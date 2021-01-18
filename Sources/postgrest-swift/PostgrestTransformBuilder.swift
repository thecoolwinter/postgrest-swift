import Foundation

public class PostgrestTransformBuilder<T>: PostgrestBuilder<T> {
	public func select(columns: String = "*") -> PostgrestTransformBuilder<T> {
		/// Remove whitespaces except when quoted
		var quoted = false

		let cleanedColumns = Array(columns)
			.map { (c) -> Character in
				if !quoted && c.isWhitespace {
					return Character("")
				}
				if c == "\"" {
					quoted = !quoted
				}
				return c
			}
		var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
		urlComponents?.queryItems?.append(URLQueryItem(name: "select",
													   value: String(cleanedColumns)))

		url = urlComponents?.url ?? url

		return self
	}
}