Sub stocks()

'Loop through worksheets
For Each ws In Worksheets

Dim LastRow As Double
Dim LastCol As Integer

LastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row
LastCol = ws.Cells(1, Columns.Count).End(xlToLeft).Column
    
'Create headers
ws.Cells(1, LastCol + 2).Value = "Ticker"
ws.Cells(1, LastCol + 3).Value = "Yearly Change"
ws.Cells(1, LastCol + 4).Value = "Percent Change"
ws.Cells(1, LastCol + 5).Value = "Total Stock Volume"

    
    'Declare variables
    Dim TickerTotalValue As Double
    Dim NextTickerValue As Double
    Dim TickerName As String
    Dim NextTickerName As String
    Dim PeviousTickerName As String
    Dim EndYearOpen As Double
    Dim StartYearOpen As Double
    Dim YearlyChange As Double
    
    'Loop through rows to print summary values
    For i = 2 To LastRow
    
        'Set each variable
        TickerName = ws.Cells(i, 1)
        NextTickerName = ws.Cells(i + 1, 1)
        PreviousTickerName = ws.Cells(i - 1, 1)
        NextTickerValue = ws.Cells(i, 7)
        
        'Calculate rolling ticker value
        TickerTotalValue = TickerTotalValue + NextTickerValue
        
        If TickerName <> NextTickerName Then
            
            'Display Ticker's total value in appropriate column
            Dim TickerCount As Integer
            
            TickerCount = TickerCount + 1
            ws.Cells(TickerCount + 1, LastCol + 2).Value = TickerName
            ws.Cells(TickerCount + 1, LastCol + 5).Value = TickerTotalValue
            
            'Calculate and display yearly change
            EndYearOpen = ws.Cells(i, 6).Value
            
            YearlyChange = EndYearOpen - StartYearOpen
            ws.Cells(TickerCount + 1, LastCol + 3).Value = YearlyChange
            
            'Conditional formatting
            If YearlyChange > 0 Then
                
                ws.Cells(TickerCount + 1, LastCol + 3).Interior.ColorIndex = 4
                
            Else
            
                ws.Cells(TickerCount + 1, LastCol + 3).Interior.ColorIndex = 3
            
            End If
            
            'Calculate and display percent change
            Dim PercentChange As Double
            
            PercentChange = (YearlyChange / StartYearOpen) * 100
            ws.Cells(TickerCount + 1, LastCol + 4).Value = PercentChange
            
            
        ElseIf TickerName <> PreviousTickerName Or i = 2 Then
            
            'Set start year open (for yearly change calculation)
            StartYearOpen = ws.Cells(i, 3).Value
        
        End If
        
    Next i
    
    
    TickerCount = 0
    
    'Print column/row headers
    ws.Cells(1, LastCol + 9).Value = "Ticker"
    ws.Cells(1, LastCol + 10).Value = "Value"
    ws.Cells(2, LastCol + 8).Value = "Greatest % Increase"
    ws.Cells(3, LastCol + 8).Value = "Greatest % Decrease"
    ws.Cells(4, LastCol + 8).Value = "Greatest Total Volume"
        
    'Loop through summary columns to find greatest values
    For j = 2 To LastRow
    
        Dim Change As Double
        Dim HighestChange As Double
        Dim HighestTicker As String
        Dim LowestChange As Double
        Dim LowestTicker As String
        Dim HighestVolume As Double
        Dim HighestVolumeTicker As String
        Dim TickerVolume As Double
        
        TickerVolume = ws.Cells(j, LastCol + 5).Value
        Change = ws.Cells(j, LastCol + 3).Value
        
        'Determine highest volume
        If TickerVolume > HighestVolume Then
            HighestVolume = TickerVolume
            HighestVolumeTicker = ws.Cells(j, LastCol + 2).Value
        End If
        
        'Determine highest and lowest change
        If Change > HighestChange Then
            HighestChange = Change
            HighestTicker = ws.Cells(j, LastCol + 2).Value
        ElseIf Change < LowestChange Then
            LowestChange = Change
            LowestTicker = ws.Cells(j, LastCol + 2).Value
        End If
    
    Next j
    
    'Print greatest values
    ws.Cells(2, LastCol + 10).Value = HighestChange
    ws.Cells(3, LastCol + 10).Value = LowestChange
    ws.Cells(2, LastCol + 9).Value = HighestTicker
    ws.Cells(3, LastCol + 9).Value = LowestTicker
    ws.Cells(4, LastCol + 10).Value = HighestVolume
    ws.Cells(4, LastCol + 9).Value = HighestVolumeTicker
    
    HighestChange = 0
    LowestChange = 0

Next ws

End Sub


