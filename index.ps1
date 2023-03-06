Write-Output '/***************************************************************************************/'
Write-Output ‘/* 指定されたディレクトリ内にあるテキストファイルの文字コードを `utf-8` に変換します。 */’
Write-Output '/***************************************************************************************/'
Write-Output ''

$target_dir = Read-Host '文字コードを変換したいファイルのあるディレクトリをDropしてください'

# Dropした場合にシングルコーテーションが付与されてしまうため削除する
$target_dir = $target_dir -replace "'",""

Get-ChildItem $target_dir -recurse |
  ForEach-Object {
    # 取得したオブジェクトがファイルの場合のみ処理
    if ($_.GetType().Name -eq "FileInfo") {
      $file = [System.IO.File]::ReadAllText($_.FullName,[Text.Encoding]::GetEncoding(932))

      [System.IO.File]::WriteAllText($_.FullName, $file)
    }
  }
