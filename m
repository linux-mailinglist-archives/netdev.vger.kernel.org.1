Return-Path: <netdev+bounces-88973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E598A9240
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 07:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D6C41F2189F
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 05:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27304F5EC;
	Thu, 18 Apr 2024 05:06:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from r9103.ps.combzmail.jp (r9103.ps.combzmail.jp [49.212.47.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36612375F
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 05:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.47.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713416770; cv=none; b=peyXg+CD7EbW7TmiP5rVz1NLtji4ar/IzIP3QlbL/JydRgsC3n8il783sUT2la//LioCtfgU7BAHbyLjvULyos/Zc0vjjz5x/GVdGz19PnBosADaYTW8jBobpP1XXw6PEjMyehOHTCWIvhgX0/TvtVkOgedQx/u1IXDB57+gSCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713416770; c=relaxed/simple;
	bh=5vxF6HLaB6pKdX/FPQmMfaJ9wpaq/DYP838hJzWNjVA=;
	h=To:From:Subject:Mime-Version:Content-Type:Message-Id:Date; b=qrUWHLBxIA9LOT4MhdQkeavcv7TwHd7ZcIbm5OBrQNrzwj7lS6MntQ+bQHv6Z3hKvb5mmeutCuOiIrkYh1C5LSOACCYU58X1rC2y0YjkHhjg/mHtP0FqBTOimdIzSD1wgfwyu8uLXtGp8UG3yxb70sFkocWkBl/8Vm9h9NUV0B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fc-seminar.jp; spf=pass smtp.mailfrom=magerr.combzmail.jp; arc=none smtp.client-ip=49.212.47.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fc-seminar.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=magerr.combzmail.jp
Received: by r9103.ps.combzmail.jp (Postfix, from userid 99)
	id 8BB35188BBA; Thu, 18 Apr 2024 13:54:08 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 r9103.ps.combzmail.jp 8BB35188BBA
To: netdev@vger.kernel.org
From: info@fc-seminar.jp
X-Ip: 378976358800223
X-Ip-source: k85gj7cj48dnsaziu0p6gd
Precedence: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Subject: =?ISO-2022-JP?B?GyRCR2M8aEBsTGdFORsoQiAbJEIlVSVpJXMbKEI=?=
 =?ISO-2022-JP?B?GyRCJUElYyUkJTolNyU5JUYlYEBiTEAycRsoQg==?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
X-MagazineId: cjzi
X-uId: 6762255642485860714549451036
X-Sender: CombzMailSender
X-Url: http://www.combzmail.jp/
Message-Id: <20240418045529.8BB35188BBA@r9103.ps.combzmail.jp>
Date: Thu, 18 Apr 2024 13:54:08 +0900 (JST)

$B?75,;v6H$r$*C5$7$N7P1D<TMM!&;v6H%*!<%J!<MM$X(B


$B$$$D$b$*@$OC$K$J$j$^$9!#(B


$BK!?M$N?75,;v6H$H$7$F!"%j%9%/$rM^$($F%9%?!<%H$G$-$k!"(B
$B%U%i%s%A%c%$%:;v6H$N%*%s%i%$%s@bL@2q$r$40FFb$$$?$7$^$9!#(B


$B6H3&L$7P83!?<R0w(B1$BL>$G%9%?!<%H$G$-$k$N$G(B
$B$46=L#$,$"$l$P@'Hs$*?=9~$_$/$@$5$$!#(B


$B!!!!"(!!(BZoom$B$N%&%'%S%J!<5!G=$K$h$kH/?.7A<0$N$?$a(B
$B!!!!!!!!;kD0<T$N$*4i$d$*@<$,I=$K=P$k$3$H$O$4$6$$$^$;$s!#(B


$B!!!!"#!!%;%_%J!<;kD08e$N%"%s%1!<%H$G8DJL@bL@$X(B
$B!!!!!!!!$*?=9~$_$5$l$?J}$K$O=q@R$r%W%l%<%s%H!#(B
$B!!!!!!!!!!!!!!!!!!(B $B"'!!=q@R>R2p!!"'(B
$B!!!!!!!!(Bhttps://www.amazon.co.jp/dp/4478114706
$B!!!!!!!!!=!!(B2022$BG/(B3$B7n!!%@%$%d%b%s%I<R=PHG!!!=(B
$B!!!!!!!!!!!!3t<02q<R%(%s%Q%o!<!JGc<hBg5H(B $B1?1DK\It!K(B
$B!!!!!!!!!!!!BeI=(B $BA}0f=S2p(B $BCx(B
$B!!!!!!!!!!!!!V3XNr$J$7!"?ML.$J$7$J$i!"<RD9$K$J$l(B!$B!W(B


$B!!(B4$B7n(B24$BF|!J?e!K!!%U%i%s%A%c%$%:;v6H!!%*%s%i%$%s@bL@2q(B
----------------------------------------------------------

$B!!!!!!!!!!!!!!!!!!A49q(B650$BE9J^(B
$B!!!!!!!!(B $B!!(B 10$BG/4V$NE9J^7QB3N((B97.4%
$B!!!!!!(B $B!!!!!!!!!!!!Gc<h@lLgE9(B
$B!!!!!!!!!!!!!!!!!=!!Gc<hBg5H!!!=(B

$B!!!!!!!!Gc$$<h$j!V@lLg!W$@$+$i<B8=$G$-$k(B
$B!!!!!!!!Dc%j%9%/!?9b<}1W$N%S%8%M%9%b%G%k(B


$B!!!!!!!!!!!!!!"'(B  $B>\:Y!&?=9~(B  $B"'(B
$B!!!!(Bhttps://fc-daikichi-kaitori.biz/dai3/

$B!!!!!!!!!!!!!!"!!!(B $B!!Ds6!!!!!(B $B"!(B
$B!!!!!!!!!!!!!!3t<02q<R%(%s%Q%o!<(B
$B!!!!!!!!!!!!!!!JGc<hBg5H(BFC$BK\It!K(B

$B!!!!F|Dx#1!!!'!!(B 4$B7n(B 24$BF|(B $B!J?e!K(B14:00$B!A(B14:30$B!!"((B
$B!!!!F|Dx#2!!!'!!(B 5$B7n(B 14$BF|(B $B!J2P!K(B14:00$B!A(B14:30$B!!"((B
$B!!!!BP!!>]!!!'!!?75,;v6H$r$*9M$($NK!?M(Bor$B8D?M;v6H<g(B
$B!!!!"(!!N>F|Dx$H$bFbMF$OF1$8$G$9(B

$B!!!!!!!!!!!!!!!~!!%3%s%F%s%D!!!~(B
$B!!!!!=!!Gc$$<h$C$?$"$H$NLY$1$N%+%i%/%j$O!)(B
$B!!!!!=!!%j%5%$%/%k%7%g%C%W$H$N0c$$$O!)(B
$B!!!!!=!!L$7P83$G::Dj$O$I$&$9$k$N$+!)(B
$B!!!!!=!!%a%k%+%j!"%d%U%*%/$KIi$1$F$$$k$N$G$O!)(B
$B!!!!!=!!?75,;v6H$H$7$F$N<}1W@-!&%j%9%/!&7QB3@-$O!)!!(Betc...

----------------------------------------------------------


$B$4>R2p$9$k$N$O!V!!Gc<h@lLgE9!!!W$N%U%i%s%A%c%$%:$G$9!#(B


$B0lHLE*$K%j%f!<%9;v6H$OGc$$<h$C$F$+$iHNGd$9$k$^$G:_8K$rJz$($k$?$a(B
$B!V:_8K%j%9%/!W!V2A3JJQF0%j%9%/!W!V;q6bITB-%j%9%/!W$H$$$C$?#3Bg%j%9%/$,H<$$$^$9!#(B


$B$3$&$7$?%j%9%/$r<h$j=|$/$N$,!"Gc$$<h$C$?=V4V$KMx1W$,3NDj$9$k!VGc<h@lLgE9!W$G$9!#(B


$B$3$N%S%8%M%9%b%G%k$,<u$1F~$l$i$l!"Gc<hBg5H$O6H3&(B2$B0L$N(B650$BE9J^$^$G3HBg$7$^$7$?!#(B


$B$7$+$7!"$^$@$^$@?-D9$9$k%j%f!<%9;T>l$KBP$7$FE9J^$,B-$j$F$$$J$$$?$a(B
$B0l=o$K<h$jAH$s$G$$$?$@$1$k2CLAE9$rJg=8$7$F$$$^$9!#(B


$BK\@bL@2q$K$FLY$1$N%+%i%/%j$d<}1W@-!&%j%9%/!&7QB3@-$J$I$r$*EA$($7$^$9$N$G(B
$B?75,;v6H$NN)$A>e$2$r$*9M$($NJ}$O@'Hs$H$b$4;22C$/$@$5$$!#(B


$B!!!!F|Dx#1!!!'!!(B 4$B7n(B 24$BF|(B $B!J?e!K(B14:00$B!A(B14:30$B!!"((B
$B!!!!F|Dx#2!!!'!!(B 5$B7n(B 14$BF|(B $B!J2P!K(B14:00$B!A(B14:30$B!!"((B
$B!!!!"(!!$I$A$i$NF|Dx$bFbMF$OF1$8$G$9!!"((B


$B!!!!"'!!$*?=9~$O2<5-(BURL$B$h$j$*4j$$$7$^$9!!"'(B

$B!!(B $B!!(Bhttps://fc-daikichi-kaitori.biz/dai3/


$B(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(B
$B!!%U%i%s%A%c%$%:%;%_%J!<!!1?1D;vL36I(B
$B!!EEOC!'(B0120-891-893
  $B=;=j!'El5~ETCf1{6h6d:B#7!]#1#3!]#6(B
$B!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=(B
$B!!K\%a!<%k$N$4ITMW$JJ}$K$OBgJQ$4LBOG$r$*$+$1$$$?$7$^$7$?!#(B
$B!!G[?.Dd;_$44uK>$NJ}$O!"$*<j?t$G$9$,!VG[?.ITMW!W$H$4JV?.$$$?$@$/$+!"(B
$B!!2<5-%"%I%l%9$h$j!"$*<jB3$-$r$*4j$$$$$?$7$^$9!#(B
$B!!(1!!(Bhttps://fc-daikichi-kaitori.biz/mail/
$B(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(B

