Return-Path: <netdev+bounces-143966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AFE9C4E0E
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 06:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8539CB2098F
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 05:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113C7208208;
	Tue, 12 Nov 2024 05:09:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from r9133.ps.combzmail.jp (r9133.ps.combzmail.jp [49.212.13.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE1A1527A7
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 05:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.13.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731388155; cv=none; b=D0O6nXf4VCRldomYb+bMtr1JoaK2Fbzx4BdjbCXdcJq8i3NlQvN88tyWOGXAW+i8t41vEqnd4VAypQUoFIebTi0DK5MBxuqnFivcWW6e2ksTyAHBhwzK/nbdvqAV4pZ1VUs2FJcHnlD7P35bNeKqmuMPuQA63HxO+OvmhKKqA9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731388155; c=relaxed/simple;
	bh=St2rsNMTPgPgXM49JdqQRd8RX07V3iM4dbIFYfIxdcc=;
	h=To:From:Subject:Mime-Version:Content-Type:Message-Id:Date; b=amNxl6sX5zZ9BSvT+HZo1DYuut+CtPVHFmaic0p8mp2qTwrafDbU1pF7FStnPYmMRjlWsPqvWoTH1QfZccCiEqJPI0CFvIkklyw9fgwdCw1UiHEyIbCUEFs2hq6IlRG69N2ZI0TuHtFB93Xp8ObqJJMCIXFHpoJhmB0oPXbqV1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kb-company.site; spf=pass smtp.mailfrom=magerr.combzmail.jp; arc=none smtp.client-ip=49.212.13.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kb-company.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=magerr.combzmail.jp
Received: by r9133.ps.combzmail.jp (Postfix, from userid 99)
	id CA5D285932; Tue, 12 Nov 2024 14:08:51 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 r9133.ps.combzmail.jp CA5D285932
To: netdev@vger.kernel.org
From: info@kb-company.site<info@kb-company.site>
X-Ip: 5901201256590593
X-Ip-source: k85gj7ow48dnsahwu0p6gd
Precedence: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Subject: =?ISO-2022-JP?B?GyRCSyxGfDMwOXE/TSRyN2NBfSQ1JDskaxsoQg==?=
 =?ISO-2022-JP?B?U05TGyRCQG9OLBsoQg==?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
X-MagazineId: owhw
X-uId: 6762325043485867654165751015
X-Sender: CombzMailSender
X-Url: http://www.combzmail.jp/
Message-Id: <20241112050904.CA5D285932@r9133.ps.combzmail.jp>
Date: Tue, 12 Nov 2024 14:08:51 +0900 (JST)

$B$$$D$b$*@$OC$K$J$j$^$9!#(B


$BCf9q$N(BSNS$B!V%l%C%I%V%C%/!W$r3hMQ$7$?(B
$BE9J^=85R$KLrN)$D%;%_%J!<$r$40FFb?=$7>e$2$^$9!#(B



$B!!!!!!(B11$B7n(B14$BF|!JLZ!K!?(B20$BF|!J?e!K(B14:00$B!A(B15:00
$B!!!!!!%*%s%i%$%s%;%_%J!<(B

$B!!!!!!"!!!%F!<%^!!"!(B
$B!!!!!!Cf9q?M5R$r7cA}$5$;$k(BSNS$B@oN,(B
$B!!!!!!!V%l%C%I%V%C%/!WBP:v(B
$B!!!!!!!=!=!=!=!=!=!=!=!=!=!=!=!=!=(B
$B!!!!!!(BGoogle$B%S%8%M%9%W%m%U%#!<%k$@$1$G$OIT==J,!)(B
$B!!!!!!(BWEB$B$+$i$N=85R$rA}$d$9(B
$B!!!!!!!H(BGoogle$B%S%8%M%9%W%m%U%#!<%k!\&A!I(B


$B!!!!!!"'!!>\:Y!&$*?=9~$_!!"'(B
$B!!!!!!(Bhttps://kb-company.biz/red-book/



$BCf9q$NJ}$,0lHVMxMQ$7$F$$$k(BSNS

$B!V%l%C%I%V%C%/!J>.9H=q!K!W(B

$B$r$4B8CN$G$7$g$&$+!#(B


$B%l%C%I%V%C%/$H$O0l8@$G8@$($P!"Cf9q8lHG$N%$%s%9%?%0%i%`$G$9!#(B


$B>&IJ$N9XF~;~$d!"0{?)E9!"%[%F%k!"H~MF!&7r9/;\@_$J$I$rC5$9:]$K(B
$B;29M$K$7$?$j!";HMQBN83$r%7%'%"$9$k>l$H$7$F;H$o$l$^$9!#(B


$B$3$N$h$&$J!V<+A3$J8}%3%_!W$N=89gBN$rMxMQ$7$F!"F|K\$N;v6H<T$G$b(B
$B%l%C%I%V%C%/$K$h$k8}%3%_@oN,$G=85R$rA}$d$9$3$H$,$G$-$^$9!#(B


$B<B:]$K%l%C%I%V%C%/$NBP:v$r$7$?$*E9$O!"(B

$B!!"~Bg:e:f;T$N%j%5%$%/%k%7%g%C%W!JLH@GGd>e6b3[!K(B
$B!!!!BP:vA0!'(B30$BK|(B/$B7n!!"*!!BP:v8e!'(B170$BK|(B/$B7n(B

$B!!"~Bg:e;TFb$N$&$J$.E9!J%$%s%P%&%s%IMh5R?t!K(B
$B!!!!BP:vA0!'(B0$B?M(B/$B7n!!"*!!BP:v8e!'(B50$B?M(B/$B7n(B

$B$H!"82Cx$K8z2L$,=P$F$$$^$9!#(B


$B$^$?!"%l%C%I%V%C%/$O4Q8w$GF|K\$KEO9R$9$kCf9q?M$@$1$G$J$/(B
$BF|K\:_=;$NCf9q?M$K$b8z2L$,$"$k$N$G!"%$%s%P%&%s%I$K4X78$N$J$$(B
$B;v6H<T$G$b=85R$rA}$d$9$3$H$,$G$-$^$9!#(B


$BCf9q?M8\5R$r7cA}$5$;$k$?$a$K!"$I$s$J%l%C%I%V%C%/BP:v$r$9$Y$-$+!)(B
$B%*%s%i%$%s%;%_%J!<$K$F$*EA$($7$^$9$N$G@'Hs$4;kD0$/$@$5$$!#(B



$B!!!!!!"'!!>\:Y!&$*?=9~$_!!"'(B
$B!!!!!!(Bhttps://kb-company.biz/red-book/



$B"""#"""#"""#"""#"""#"""#"""#"""#"""#"""#"""#"""#"""#"""#(B

$B!!(B $BE9J^(BWEB$B=85R%;%_%J!<;vL36I(B
$B!!(B $BBg:e;TCf1{6hK\D.(B2$BCzL\(B3-9-5$B3,(B
 $B!!(BTEL$B!!(B 06-6484-5302

$B"""#"""#"""#"""#"""#"""#"""#"""#"""#"""#"""#"""#"""#"""#(B
$B!!K\%a!<%k$N$4ITMW$JJ}$K$OBgJQ$4LBOG$r$*$+$1$$$?$7$^$7$?!#(B
$B!!G[?.Dd;_$44uK>$NJ}$O!"2<5-$N%U%)!<%`$K$F>5$C$F$*$j$^$9!#(B
$B!!(B https://kb-company.biz/mail/
$B!!%Z!<%8$,I=<($5$l$J$$>l9g$O!"$3$N%a!<%k$N7oL>$r!VG[?.Dd;_!W$H(B
$B!!JQ$($F$=$N$^$^$4JV?.$/$@$5$$$^$;!#(B

