package io.prediction.engines.itemrank.test

import io.prediction.engines.itemrank._
import org.json4s._
import org.json4s.native.JsonMethods._
import org.scalatest._
import scala.io.Source._

abstract class UnitSpec extends WordSpec with Matchers with OptionValues with Inside with Inspectors

class TestItemRankEngine extends UnitSpec {

  "An ItemRankCleanser" should {
    val data = fromURL(getClass.getResource("/ItemRankCleanserData.json")).mkString
    val fixtures = parse(data)

    implicit lazy val formats = org.json4s.DefaultFormats

    for (fixture <- fixtures.children) {
      val name = (fixture \ "name").extract[String]
      val cleanserParams = (fixture \ "cleanserParams").extract[CleanserParams]
      val users = (fixture \ "users").extract[Map[Int, UserTD]]
      val items = (fixture \ "items").extract[Map[Int, ItemTD]]
      val u2iActions = (fixture \ "u2iActions").extract[Seq[U2IActionTD]]
      val trainingData = new TrainingData(users, items, u2iActions)

      val expect = (fixture \ "expect").extract[Seq[RatingTD]]

      name in {
        val cleanser = new ItemRankCleanser
        cleanser.init(cleanserParams)
        val cleansedData = cleanser.cleanse(trainingData)
        (cleansedData.rating zip expect).foreach {
          g => {
            assert(g._1.uindex == g._2.uindex)
            assert(g._1.iindex == g._2.iindex)
            assert(g._1.rating == g._2.rating)
            assert(g._1.t == g._2.t)
          }
        }
      }
    }
  }
}
