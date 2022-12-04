
--Yêu cầu 3--

--1. Cho danh sách (ds) nhân viên (nv) gồm họ tên, phái.
SELECT HONV + ' ' + TENNV AS N'Họ Tên'
, GT AS N'Giới Tính'
FROM NHANVIEN
GO

--2. Cho ds nhân viên thuộc đơn vị số 5.
SELECT *
FROM NHANVIEN
WHERE MADV = 5
GO

--3. Cho ds nhân viên gồm mã nv, họ tên, phái của các nv thuộc đơn vị số 5.
SELECT MANV AS N'Mã NV'
, HONV + ' ' + TENNV AS N'Họ Tên'
, GT AS N'Giới Tính'
FROM NHANVIEN 
WHERE MADV = 5
GO

--4. Ds họ tên, phái của các nv thuộc đơn vị ‘nghiên cứu’.
SELECT a.HONV + ' ' + a.TENNV AS N'Họ Tên'
, a.GT AS N'Giới Tính'
FROM NHANVIEN a
INNER JOIN DONVI b ON a.MADV = b.MADV
WHERE b.TENDV = N'nghiên cứu'
GO

--5. Cho ds các mã nhân viên có tham gia đề án số 4 hoặc 5.
SELECT MANV AS N'Mã NV'
FROM NV_DEAN
WHERE MADA = 4 OR MADA = 5
GO

--6. Cho ds các mã nhân viên vừa có tham gia đề án số 4 vừa có tham gia đề án số 5.
SELECT MANV AS N'Mã NV'
FROM NV_DEAN
WHERE MADA = 4 AND MANV in (SELECT MANV FROM NV_DEAN WHERE MADA = 5)
GO

--7. Cho ds các mã nhân viên có tham gia đề án số 4 mà không có tham gia đề án số 5.
SELECT MANV AS N'Mã NV'
FROM NV_DEAN
WHERE MADA = 4 AND MANV NOT IN (SELECT MANV FROM NV_DEAN WHERE MADA = 5)
GO

--8. Cho biết ds thể hiện mọi nhân viên đều tham gia tất cả các đề án.
DECLARE @SLDeAn INT

SELECT @SLDeAn = COUNT(*)
FROM DEAN

SELECT MANV, COUNT(MADA) AS DA
INTO #tmp
FROM NV_DEAN
GROUP BY MANV

SELECT a.*
FROM NHANVIEN a
INNER JOIN #tmp b ON a.MANV = b.MANV
WHERE b.DA = @SLDeAn

DROP TABLE #tmp	
GO

--9. Cho ds các nhân viên và thông tin đơn vị mà nhân viên đó trực thuộc (mã nv, họ tên, mã đơn vị, tên đơn vị).
SELECT a.MANV AS N'Mã NV'
, a.HONV + ' ' + a.TENNV AS N'Họ Tên'
, a.MADV AS N'Mã Đơn Vị'
, b.TENDV AS N'Tên Đơn Vị'
FROM NHANVIEN a
INNER JOIN DONVI b ON a.MADV = b.MADV
WHERE b.TENDV = N'nghiên cứu'
GO

--10. Cho ds các đơn vị và địa điểm đơn vị (mã dv, tên dv, địa điểm)
SELECT a.MADV AS N'Mã Đơn Vị'
, a.TENDV AS N'Tên Đơn Vị'
, b.DD AS N'Địa Điểm'
FROM DONVI a
INNER JOIN DONVI_DD b ON a.MADV = b.MADV
GO

--11. Cho ds các nhân viên thuộc đơn vị ‘Nghiên cứu’.
SELECT a.*
FROM NHANVIEN a
INNER JOIN DONVI b ON a.MADV = b.MADV
WHERE b.TENDV = N'Nghiên cứu'
GO

--12. Đối với từng nv, cho biết họ tên ngày sinh và tên của nv phụ trách trực tiếp nhân viên đó.
SELECT a.HONV + ' ' + a.TENNV AS N'Họ Tên'
, a.NS AS N'Ngày Sinh'
, b.HONV + ' ' + b.TENNV AS N'Người Phụ Trách'
FROM NHANVIEN a
INNER JOIN NHANVIEN b ON a.MANGS = b.MANV
GO

--13. Ds nv thuộc đơn vị 5 có tham gia đề án tên là ‘Sản phẩm X’.
SELECT a.*
FROM NHANVIEN a
INNER JOIN NV_DEAN b ON a.MANV = b.MANV
INNER JOIN DEAN c ON b.MADA = c.MADA
WHERE a.MADV = 5 AND c.TENDA = N'Sản phẩm X'
GO

--14. Tương tự 5, thuộc đơn vị ‘nghiên cứu’ có tham gia đề án tên là ‘Sản phẩm X’.
SELECT a.HONV + ' ' + a.TENNV AS N'Họ Tên'
, a.GT AS N'Giới Tính'
FROM NHANVIEN a
INNER JOIN DONVI b ON a.MADV = b.MADV
INNER JOIN NV_DEAN c ON a.MANV = c.MANV
INNER JOIN DEAN d ON c.MADA = d.MADA
WHERE b.TENDV = N'nghiên cứu' AND d.TENDA = N'Sản phẩm X'
GO

--15. GÁN: Cho biết có tất cả bao nhiêu nhân viên.
SELECT COUNT(*) AS N'Số Lượng NV'
FROM NHANVIEN
GO

--16. Cho biết mỗi đơn vị có bao nhiêu nhân viên (MADV, TENDV, SLNV).
SELECT a.MADV
, b.TENDV
, COUNT(MANV) AS N'SLNV'
FROM NHANVIEN a
INNER JOIN DONVI b ON a.MADV = b.MADV
GROUP BY a.MADV, b.TENDV
GO

--17. Cho biết tổng lương, số lượng nv, lương trung bình, lương bé nhất trong toàn công ty.
SELECT SUM(LUONG) AS N'Tổng Lương'
, COUNT(MANV) AS N'Số Lượng NV'
, AVG(LUONG) AS N'Lương Trung Bình'
, MIN(LUONG) AS N'Lương thấp Nhất'
FROM NHANVIEN 
GROUP BY MADV
GO

--18. Ds nhân viên có tham gia đề án.
SELECT DISTINCT b.*
FROM NV_DEAN a
INNER JOIN NHANVIEN b ON a.MANV = b.MANV
GO

--19. Ds nhân viên không có tham gia đề án nào.
SELECT a.*
FROM NHANVIEN a
LEFT JOIN NV_DEAN b ON a.MANV = b.MANV
WHERE ISNULL(b.MADA, 0) = 0
GO

--20. Mỗi nv tham gia bao nhiêu đề án với tổng thời gian là bao nhiêu.
SELECT MANV AS N'Mã NV'
, COUNT(MADA) AS N'Số Lượng ĐA'
, SUM(SOGIO) AS N'Tổng Số Giờ'
FROM NV_DEAN
GROUP BY MANV
GO

--21. Ds nv có tham gia đề án tên là ‘Sản phẩm X ’ hoặc ‘Sản phẩm Y’.
SELECT a.*
FROM NHANVIEN a
INNER JOIN NV_DEAN b ON a.MANV = b.MANV
INNER JOIN DEAN c ON b.MADA = c.MADA
WHERE c.TENDA = N'Sản phẩm X' OR c.TENDA = N'Sản phẩm Y'
GO

--22. Ds nv vừa có tham gia đề án tên ‘Sản phẩm X’ vừa có tham gia đề án ‘Sản phẩm Y’.
SELECT a.*
FROM NHANVIEN a
INNER JOIN NV_DEAN b ON a.MANV = b.MANV
INNER JOIN DEAN c ON b.MADA = c.MADA
WHERE c.TENDA = N'Sản phẩm X' AND a.MANV IN (SELECT a.MANV
											FROM NHANVIEN a
											INNER JOIN NV_DEAN b ON a.MANV = b.MANV
											INNER JOIN DEAN c ON b.MADA = c.MADA
											WHERE c.TENDA = N'Sản phẩm Y')
GO

--23. Ds nv có tham gia đề án tên ‘Sản phẩm X’ mà không có tham gia đề án tên là ‘Sản phẩm Y’.
SELECT a.*
FROM NHANVIEN a
INNER JOIN NV_DEAN b ON a.MANV = b.MANV
INNER JOIN DEAN c ON b.MADA = c.MADA
WHERE c.TENDA = N'Sản phẩm X' AND a.MANV NOT IN (SELECT a.MANV
											FROM NHANVIEN a
											INNER JOIN NV_DEAN b ON a.MANV = b.MANV
											INNER JOIN DEAN c ON b.MADA = c.MADA
											WHERE c.TENDA = N'Sản phẩm Y')
GO

--24. Ds nv chỉ có tham gia đề án tên ‘Sản phẩm X’.
SELECT a.*
FROM NHANVIEN a
INNER JOIN NV_DEAN b ON a.MANV = b.MANV
INNER JOIN DEAN c ON b.MADA = c.MADA
WHERE c.TENDA = N'Sản phẩm X' AND a.MANV NOT IN (SELECT a.MANV
											FROM NHANVIEN a
											INNER JOIN NV_DEAN b ON a.MANV = b.MANV
											INNER JOIN DEAN c ON b.MADA = c.MADA
											WHERE c.TENDA <> N'Sản phẩm x') 
GO

--25. Ds các đề án chỉ do các nv thuộc đơn vị “Nghiên cứu” thực hiện.
SELECT MADA, COUNT(MANV) AS SLNV
INTO #tmp_NVDA
FROM NV_DEAN
GROUP BY MADA

SELECT a.MADA, COUNT(b.MANV) AS SLNV
INTO #tmp_NVNCDA
FROM NV_DEAN a
	INNER JOIN NHANVIEN b ON a.MANV = b.MANV
	INNER JOIN DONVI c ON b.MADV = c.MADV
WHERE c.TENDV = N'Nghiên cứu'
GROUP BY a.MADA

SELECT a.*
FROM DEAN a
	INNER JOIN #tmp_NVDA b ON a.MADA = b.MADA
	INNER JOIN #tmp_NVNCDA c ON a.MADA = c.MADA
WHERE b.SLNV = c.SLNV

DROP TABLE #tmp_NVDA, #tmp_NVNCDA
GO

--26. Ds các nv có tham gia tất cả các đề án.
DECLARE @SLDeAn INT

SELECT @SLDeAn = COUNT(*)
FROM DEAN

SELECT MANV, COUNT(MADA) AS DA
INTO #tmp
FROM NV_DEAN
GROUP BY MANV

SELECT a.*
FROM NHANVIEN a
INNER JOIN #tmp b ON a.MANV = b.MANV
WHERE b.DA = @SLDeAn

DROP TABLE #tmp	
GO

--27. Ds nv thuộc đơn vị ‘Nghiên cứu’ có tham gia tất cả các đề án do đơn vị số 5 chủ trì.
DECLARE @SLDA INT

SELECT @SLDA = COUNT(*)
FROM DEAN
WHERE MA_DV = 5

SELECT a.MANV, COUNT(MADA) AS DA
INTO #tmp
FROM NHANVIEN a
INNER JOIN DONVI b ON a.MADV = b.MADV
INNER JOIN NV_DEAN c ON a.MANV = c.MANV
WHERE b.TENDV = N'Nghiên cứu'
GROUP BY a.MANV

SELECT a.*
FROM NHANVIEN a
INNER JOIN #tmp b ON a.MANV = b.MANV
WHERE b.DA = @SLDA

DROP TABLE #tmp
GO

--28. Cho biết lương trung bình của các đơn vị (mã, tên, lương TB).
SELECT a.MADV AS N'Mã DV'
, a.TENDV AS N'Tên DV'
, AVG(b.LUONG) AS N'Lương TB'
FROM DONVI a
INNER JOIN NHANVIEN b ON a.MADV = b.MADV
GROUP BY a.MADV, a.TENDV
GO

--29. Cho biết các đơn vị có lương trung bình > 2500.
SELECT a.MADV
, a.TENDV
, AVG(b.LUONG) AS LUONG
INTO #tmp
FROM DONVI a
INNER JOIN NHANVIEN b ON a.MADV = b.MADV
GROUP BY a.MADV, a.TENDV

SELECT MADV AS N'Mã DV'
, TENDV AS N'Tên DV'
, LUONG
FROM #tmp
WHERE LUONG > 2500

DROP TABLE #tmp
GO

--30. Cho biết các đơn vị có chủ trì đề án có số nhân viên > 3 và có lương trung bình lớn hơn 2500.
SELECT a.MADV
, a.TENDV
, AVG(b.LUONG) AS LUONG
, COUNT(MANV) AS MANV
INTO #tmp
FROM DONVI a
INNER JOIN NHANVIEN b ON a.MADV = b.MADV
GROUP BY a.MADV, a.TENDV

SELECT DISTINCT  MADV AS N'Mã DV'
, TENDV AS N'Tên DV'
FROM #tmp a
INNER JOIN DEAN b ON a.MADV = b.MA_DV
WHERE LUONG > 2500 AND MANV > 3

DROP TABLE #tmp
GO

--31. Cho biết nhân viên nào có lương cao nhất trong từng đơn vị ban.
SELECT a.MADV
, MAX(LUONG) AS LUONG
INTO #LUONGMAX
FROM DONVI a
LEFT JOIN NHANVIEN b ON a.MADV = b.MADV
GROUP BY a.MADV

SELECT *
FROM NHANVIEN a
INNER JOIN #LUONGMAX b ON a.MADV = b.MADV
WHERE a.LUONG = b.LUONG

DROP TABLE #LUONGMAX
GO

--32. Cho biết đơn vị nào có lương trung bình cao nhất.
DECLARE @LUONGAVG INT

SELECT a.MADV
, a.TENDV
, AVG(b.LUONG) AS LUONG
INTO #AVGMAX
FROM DONVI a
INNER JOIN NHANVIEN b ON a.MADV = b.MADV
GROUP BY a.MADV, a.TENDV

SELECT TOP 1 @LUONGAVG = LUONG
FROM #AVGMAX
ORDER BY LUONG DESC

SELECT *
FROM #AVGMAX
WHERE LUONG = @LUONGAVG

DROP TABLE #AVGMAX
GO

--33. Cho biết đơn vị nào có ít nhân viên nhất.
DECLARE @SLNV INT

SELECT a.MADV
, a.TENDV
, COUNT(MANV) AS SL
INTO #NV
FROM DONVI a
INNER JOIN NHANVIEN b ON a.MADV = b.MADV
GROUP BY a.MADV, a.TENDV

SELECT TOP 1 @SLNV = SL
FROM #NV
ORDER BY SL

SELECT *
FROM #NV
WHERE SL = @SLNV

DROP TABLE #NV
GO

--34. Cho biết đơn vị nào có đông nhân viên nữ nhất.
DECLARE @SLNV INT

SELECT a.MADV
, a.TENDV
, COUNT(MANV) AS SL
INTO #NV
FROM DONVI a
INNER JOIN NHANVIEN b ON a.MADV = b.MADV
WHERE b.GT = N'Nữ'
GROUP BY a.MADV, a.TENDV

SELECT TOP 1 @SLNV = SL
FROM #NV
ORDER BY SL DESC

SELECT *
FROM #NV
WHERE SL = @SLNV

DROP TABLE #NV
GO

--35. Ds mã, tên của các đơn vị có chủ trì đề án tên là “SPX” lẫn “SPY”.
SELECT a.MADV AS N'Mã DV'
, a.TENDV AS N'Tên DV'
FROM DONVI a
INNER JOIN DEAN b ON a.MADV = b.MA_DV
WHERE b.TENDA = N'SPX' AND a.MADV IN (SELECT a.MADV
										FROM DONVI a
										INNER JOIN DEAN b ON a.MADV = b.MA_DV
										WHERE b.TENDA = N'SPY')
GO

--36. Ds mã, tên của các đơn vị có chủ trì đề án tên là “SPX” mà không có chủ trì đề án tên là “SPY”.
SELECT a.MADV AS N'Mã DV'
, a.TENDV AS N'Tên DV'
FROM DONVI a
INNER JOIN DEAN b ON a.MADV = b.MA_DV
WHERE b.TENDA = N'SPX' AND a.MADV NOT IN (SELECT a.MADV
										FROM DONVI a
										INNER JOIN DEAN b ON a.MADV = b.MA_DV
										WHERE b.TENDA = N'SPY')
GO

--37. Phân công cho các nhân viên thuộc đơn vị số 5 tham gia đề án số 10 mỗi người tham gia 10 giờ.
UPDATE a
SET SOGIO = 10
FROM NV_DEAN a
	INNER JOIN NHANVIEN b on a.MANV = b.MANV
WHERE a.MADA = 10 AND b.MADV = 5
GO

--38. Xóa tất cả những phân công liên quan đến nhân viên mã là 10.
DELETE NV_DEAN
WHERE MANV = 10
GO

--39. Xóa tất cả những phân công liên quan đến nhân viên mã là 10 và đề án mã là 20.
DELETE NV_DEAN
WHERE MANV = 10 AND MADA = 20
GO

--40. Tăng 10% giờ tham gia đề án của nhân viên đã tham gia đề án số 10.
UPDATE NV_DEAN
SET SOGIO = SOGIO * 1.1
WHERE MADA = 10
GO

--41. Giảm 15% giờ tham gia đề án của các nhân viên thuộc đơn vị “Nghiên cứu ”đã tham gia đề án số 10.
UPDATE a
SET SOGIO = SOGIO * 0.85
FROM NV_DEAN a
	INNER JOIN NHANVIEN b ON a.MANV = b.MANV
	INNER JOIN DONVI c ON b.MADV = c.MADV
WHERE MADA = 10 AND TENDV = N'Nghiên cứu'
GO

--42. Cho biết mỗi đơn vị định vị ở bao nhiêu nơi.
SELECT a.MADV AS N'Mã DV'
		, a.TENDV AS N'Tên DV'
		, COUNT(b.DD) AS N'Tổng Nơi'
FROM DONVI a
	INNER JOIN DONVI_DD b ON a.MADV = b.MADV
GROUP BY a.MADV, a.TENDV
GO

--43. Cho biết những đơn vị định vị ở nhiều nơi.
SELECT a.MADV
		, a.TENDV
		, COUNT(b.DD) AS DD
INTO #tmp
FROM DONVI a
	INNER JOIN DONVI_DD b ON a.MADV = b.MADV
GROUP BY a.MADV, a.TENDV

SELECT MADV AS N'Mã DV'
		, TENDV AS N'Tên DV'
FROM #tmp
WHERE DD > 1

DROP TABLE #tmp
GO

--44. Ds các nhân viên đã tham gia nhiều hơn 3 đề án.
SELECT MANV, COUNT(MADA) AS DA
INTO #tmp
FROM NV_DEAN
GROUP BY MANV

SELECT a.*
FROM NHANVIEN a
	INNER JOIN #tmp b ON a.MANV = b.MANV
WHERE DA > 3

DROP TABLE #tmp
GO

--45. Cho biết các đề án có nhiều hơn 10 nhân viên tham gia.
SELECT MADA, COUNT(MANV) AS NV
INTO #tmp
FROM NV_DEAN
GROUP BY MADA

SELECT a.*
FROM DEAN a
	INNER JOIN #tmp b ON a.MADA = b.MADA
WHERE NV > 10

DROP TABLE #tmp
GO