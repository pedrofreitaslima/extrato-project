import org.json4s._
import org.json4s.jackson.JsonMethods._

// Assuming you have your Avro data in a string format with snake_case keys
def convertSnakeToCamel(snakeCaseJson: String): String = {
  // Parse the JSON string to AST
  val jsonAST = parse(snakeCaseJson)

  // Convert to camelCase
  val camelCaseAST = jsonAST.camelizeKeys

  // Convert back to string
  compact(render(camelCaseAST))
}
