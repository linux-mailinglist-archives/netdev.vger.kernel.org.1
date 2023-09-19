Return-Path: <netdev+bounces-34895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CA77A5BE4
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 10:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050442819C9
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 08:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8324B38DDB;
	Tue, 19 Sep 2023 08:04:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8346C1FA9
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 08:04:31 +0000 (UTC)
Received: from 5367726.msquaremedia.com (5367726.msquaremedia.com [162.214.205.247])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6D0102
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 01:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=msmunify.io
	; s=default; h=Message-Id:Date:Reply-To:MIME-Version:Content-Type:To:Subject:
	From:Sender:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=5ofKuMykHx2Sld4j0q9WPz7JjaaqKFeOfirEhItgvPs=; b=sqk8llRDbITZ6PzeozbwuK7bJJ
	wJPxCB2hWuR58dA6CdjvH5SJNTKaxerLAAlnCYTxjkB7/kLOxJSfVPWPp0iXOLzwuDRBIlBZIxTAl
	w4hJtlmMylynz74WT8X2khW0Sx1VKIWBDBZb83u5yoLPCmpaV8SlpDbTHn4YmIDDXEjQHJ/UvX+J3
	klvlrFwt7IDqzmsKbJGC3nN5CG2IL906R0A+83tGmXFnHF0joXw4wACK3vAjLhiCYFuh1W3z/QFJO
	JTWcv4QiNiTTnutLsjab8WdwuyoI+/LpdWbls60fpN2r/PtaIhFtOQwpbVFI78KNnnzdZsJy2kekW
	78+c2VRw==;
Received: from [78.141.198.167] (port=53311 helo=vultr-guest)
	by 5367726.msquaremedia.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <labonie.das@msmunify.io>)
	id 1qiVhe-0000UA-0S
	for netdev@vger.kernel.org;
	Tue, 19 Sep 2023 03:03:28 -0500
From: "Erica Lee" <labonie.das@msmunify.io>
Subject: Req for quote
To: <netdev@vger.kernel.org>
Content-Type: multipart/mixed; boundary="8=_2pNNwhOzyiko4iNqWnvlKYSpVvugvD9"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: "Erica Lee" <reply@jidlee.com>
Date: Tue, 19 Sep 2023 08:03:28 +0000
Message-Id: <19282023090308B8B5CF0572-93C56F6051@msmunify.io>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - 5367726.msquaremedia.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - msmunify.io
X-Get-Message-Sender-Via: 5367726.msquaremedia.com: authenticated_id: labonie.das@msmunify.io
X-Authenticated-Sender: 5367726.msquaremedia.com: labonie.das@msmunify.io
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is a multi-part message in MIME format

--8=_2pNNwhOzyiko4iNqWnvlKYSpVvugvD9
Content-Type: multipart/alternative;
	boundary="vAgodGYrisndBaQpBqBEB55=_npLbxSAFA"

--vAgodGYrisndBaQpBqBEB55=_npLbxSAFA
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi Sir,

I am glad this email finds you well.

Find attached my request, Please give me your best prices.

Send us prices ASAP, so we can proceed further

Thank you.

Best Regards,

Erica Lee (Sales & Marketing / Assistant Manager)
TAEJIN Technology Co., Ltd.(HTC KOREA)

A: 2F Samjeong Building, 553, Nonhyeon-ro, Gangnam-gu, 06126, Seoul, K=
OREA
T: +82-70-7014-9515(Direct), +82-2-553-9625/ F: +82-2-553-9645
W:=20

www.htckorea.co.kr http://www.htckorea.co.kr/

--vAgodGYrisndBaQpBqBEB55=_npLbxSAFA
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


<html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-=
8859-1">
  <META http-equiv=3D"X-UA-Compatible" content=3D"IE=3Dedge"> <META na=
me=3D"viewport" content=3D"width=3Ddevice-width, initial-scale=3D1"> <=
META name=3D"format-detection" content=3D"telephone=3Dno"> <title>Req =
for quote</title>
 </head>
 <body bgcolor=3D"#ffffff"><FONT face=3D"Arial" size=3D"3"> <P align=3D=
"left">&nbsp;&nbsp;</p><p align=3D"left">&nbsp;&nbsp;</p><p style=3D"m=
argin: 0px; text-align: left; text-transform: none; text-indent: 0px; =
font-family: Arial, Helvetica, sans-serif; font-size: small; font-styl=
e: normal; font-weight: 400; word-spacing: 0px; white-space: normal; b=
ox-sizing: border-box; orphans: 2; widows: 2; font-variant-ligatures: =
normal; font-variant-caps: normal; -webkit-text-stroke-width: 0px; tex=
t-decoration-thickness: initial; text-decoration-style: initial; text-=
decoration-color: initial;"><SPAN style=3D"font-family: 'Malgun Gothic=
'; font-size: 10pt; box-sizing: border-box; text-decoration-color: ini=
tial;">Hi Sir,</SPAN></p><p style=3D"margin: 0px; text-align: left; te=
xt-transform: none; text-indent: 0px; font-family: Arial, Helvetica, s=
ans-serif; font-size: small; font-style: normal; font-weight: 400; wor=
d-spacing: 0px; white-space: normal; box-sizing: border-box; orphans: =
2; widows: 2; font-variant-ligatures: normal; font-variant-caps: norma=
l; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial;=
 text-decoration-style: initial; text-decoration-color: initial;"><SPA=
N style=3D"font-family: 'Malgun Gothic'; font-size: 10pt; box-sizing: =
border-box; text-decoration-color: initial;">&nbsp;</SPAN></p><p style=
=3D"margin: 0px; text-align: left; text-transform: none; text-indent: =
0px; font-family: Arial, Helvetica, sans-serif; font-size: small; font=
-style: normal; font-weight: 400; word-spacing: 0px; white-space: norm=
al; box-sizing: border-box; orphans: 2; widows: 2; font-variant-ligatu=
res: normal; font-variant-caps: normal; -webkit-text-stroke-width: 0px=
; text-decoration-thickness: initial; text-decoration-style: initial; =
text-decoration-color: initial;"><SPAN style=3D"font-family: 'Malgun G=
othic'; font-size: 10pt; box-sizing: border-box; text-decoration-color=
: initial;">I am glad this email finds you well.</SPAN></p><p style=3D=
"margin: 0px; text-align: left; text-transform: none; text-indent: 0px=
; font-family: Arial, Helvetica, sans-serif; font-size: small; font-st=
yle: normal; font-weight: 400; word-spacing: 0px; white-space: normal;=
 box-sizing: border-box; orphans: 2; widows: 2; font-variant-ligatures=
: normal; font-variant-caps: normal; -webkit-text-stroke-width: 0px; t=
ext-decoration-thickness: initial; text-decoration-style: initial; tex=
t-decoration-color: initial;"><SPAN style=3D"font-family: 'Malgun Goth=
ic'; font-size: 10pt; box-sizing: border-box; text-decoration-color: i=
nitial;">Find attached&nbsp;my request, Please give me your best price=
s.</SPAN></p><p style=3D"margin: 0px; text-align: left; text-transform=
: none; text-indent: 0px; font-family: Arial, Helvetica, sans-serif; f=
ont-size: small; font-style: normal; font-weight: 400; word-spacing: 0=
px; white-space: normal; box-sizing: border-box; orphans: 2; widows: 2=
; font-variant-ligatures: normal; font-variant-caps: normal; -webkit-t=
ext-stroke-width: 0px; text-decoration-thickness: initial; text-decora=
tion-style: initial; text-decoration-color: initial;"><SPAN style=3D"f=
ont-family: 'Malgun Gothic'; font-size: 10pt; box-sizing: border-box; =
text-decoration-color: initial;">Send us prices&nbsp;ASAP, so we can p=
roceed further</SPAN></P> <DIV style=3D"text-align: left; text-transfo=
rm: none; text-indent: 0px; font-family: Arial, Helvetica, sans-serif;=
 font-size: small; font-style: normal; font-weight: 400; word-spacing:=
 0px; white-space: normal; box-sizing: border-box; orphans: 2; widows:=
 2; font-variant-ligatures: normal; font-variant-caps: normal; -webkit=
-text-stroke-width: 0px; text-decoration-thickness: initial; text-deco=
ration-style: initial; text-decoration-color: initial;"> <P style=3D"m=
argin: 0px; box-sizing: border-box; text-decoration-color: initial;"><=
SPAN style=3D"font-family: 'Malgun Gothic'; font-size: 10pt; box-sizin=
g: border-box; text-decoration-color: initial;">Thank you.</SPAN></p><=
p style=3D"margin: 0px; text-align: justify; box-sizing: border-box; t=
ext-decoration-color: initial;"><SPAN style=3D"font-family: 'Malgun Go=
thic'; font-size: 10pt; box-sizing: border-box; text-decoration-color:=
 initial;">&nbsp;</SPAN></p><p style=3D"margin: 0px; text-align: justi=
fy; box-sizing: border-box; text-decoration-color: initial;"><SPAN sty=
le=3D"font-family: 'Malgun Gothic'; font-size: 10pt; box-sizing: borde=
r-box; text-decoration-color: initial;">&nbsp;</SPAN></p><p style=3D"m=
argin: 0px; text-align: justify; box-sizing: border-box; text-decorati=
on-color: initial;"><SPAN style=3D"font-family: 'Malgun Gothic'; font-=
size: 10pt; box-sizing: border-box; text-decoration-color: initial;">B=
est Regards,</SPAN></p><p style=3D"margin: 0px; text-align: justify; b=
ox-sizing: border-box; text-decoration-color: initial;"><SPAN style=3D=
"font-family: 'Malgun Gothic'; font-size: 10pt; box-sizing: border-box=
; text-decoration-color: initial;">&nbsp;</SPAN></P> <DIV style=3D"mar=
gin: 0px; box-sizing: border-box; text-decoration-color: initial;"><SP=
AN style=3D"font-family: SimSun; font-size: 10.5pt; box-sizing: border=
-box; text-decoration-color: initial;"> <HR width=3D"210" size=3D"2" a=
lign=3D"left" style=3D"border-width: 1px 0px 0px; width: 157.5pt; over=
flow: visible; margin-top: 1rem; margin-bottom: 1rem; border-top-color=
: rgba(0, 0, 0, 0.1); border-top-style: solid; box-sizing: content-box=
; text-decoration-color: initial;"> </SPAN></DIV> <P style=3D"margin: =
0px; text-align: justify; box-sizing: border-box; text-decoration-colo=
r: initial;"><B style=3D"font-weight: bolder; box-sizing: border-box; =
text-decoration-color: initial;"><SPAN style=3D"font-family: Arial, sa=
ns-serif; box-sizing: border-box; text-decoration-color: initial;">Eri=
ca Lee&nbsp;&nbsp;</SPAN></B><SPAN style=3D"font-family: 'Malgun Gothi=
c'; font-size: 9pt; box-sizing: border-box; text-decoration-color: ini=
tial;">(Sales &amp; Marketing / Assistant Manager)</SPAN><SPAN style=3D=
"font-family: Arial, sans-serif; font-size: 10pt; box-sizing: border-b=
ox; text-decoration-color: initial;"><BR style=3D"box-sizing: border-b=
ox; text-decoration-color: initial;"><BR style=3D"box-sizing: border-b=
ox; text-decoration-color: initial;"></SPAN><B style=3D"font-weight: b=
older; box-sizing: border-box; text-decoration-color: initial;"><SPAN =
style=3D"font-family: 'Malgun Gothic'; font-size: 10pt; box-sizing: bo=
rder-box; text-decoration-color: initial;">TAEJIN Technology Co., Ltd.=
(HTC KOREA)</SPAN></B></p><p style=3D"margin: 0px; text-align: justify=
; box-sizing: border-box; text-decoration-color: initial;"><SPAN style=
=3D"font-family: HY&#44204;&#44256;&#46357;, serif; font-size: 9pt; bo=
x-sizing: border-box; text-decoration-color: initial;">A:</SPAN><SPAN =
style=3D"font-family: Arial, sans-serif; font-size: 9pt; box-sizing: b=
order-box; text-decoration-color: initial;">&nbsp;</SPAN><SPAN style=3D=
"font-family: 'Malgun Gothic'; font-size: 9pt; box-sizing: border-box;=
 text-decoration-color: initial;">2F Samjeong Building, 553, Nonhyeon-=
ro, Gangnam-gu, 06126, Seoul, KOREA</SPAN><SPAN style=3D"font-family: =
'Malgun Gothic'; font-size: 9pt; box-sizing: border-box; text-decorati=
on-color: initial;"><BR style=3D"box-sizing: border-box; text-decorati=
on-color: initial;"></SPAN><SPAN style=3D"font-family: HY&#44204;&#442=
56;&#46357;, serif; font-size: 9pt; box-sizing: border-box; text-decor=
ation-color: initial;">T:</SPAN><SPAN style=3D"font-family: Arial, san=
s-serif; font-size: 9pt; box-sizing: border-box; text-decoration-color=
: initial;">&nbsp;</SPAN><SPAN style=3D"font-family: 'Malgun Gothic'; =
font-size: 9pt; box-sizing: border-box; text-decoration-color: initial=
;">+82-70-7014-9515(Direct), +82-2-553-9625/&nbsp;</SPAN><SPAN style=3D=
"font-family: HY&#44204;&#44256;&#46357;, serif; font-size: 9pt; box-s=
izing: border-box; text-decoration-color: initial;">F:</SPAN><SPAN sty=
le=3D"font-family: 'Malgun Gothic'; font-size: 9pt; box-sizing: border=
-box; text-decoration-color: initial;">&nbsp;+82-2-553-9645</SPAN><SPA=
N style=3D"font-family: 'Malgun Gothic'; font-size: 9pt; box-sizing: b=
order-box; text-decoration-color: initial;"><BR style=3D"box-sizing: b=
order-box; text-decoration-color: initial;"></SPAN><SPAN style=3D"font=
-family: HY&#44204;&#44256;&#46357;, serif; font-size: 9pt; box-sizing=
: border-box; text-decoration-color: initial;">W:&nbsp;</SPAN><SPAN st=
yle=3D"font-family: 'Malgun Gothic'; font-size: 10pt; box-sizing: bord=
er-box; text-decoration-color: initial;"><A title=3D"blocked::http://w=
ww.htckorea.co.kr/" style=3D"box-sizing: border-box;" href=3D"http://w=
ww.htckorea.co.kr/" target=3D"_blank" rel=3D"noreferrer"><SPAN style=3D=
"font-size: 9pt; box-sizing: border-box; text-decoration-color: initia=
l;">www.htckorea.co.kr</SPAN></A></SPAN></P></DIV></FONT></body>
 </html>

--vAgodGYrisndBaQpBqBEB55=_npLbxSAFA--

--8=_2pNNwhOzyiko4iNqWnvlKYSpVvugvD9
Content-Type: application/octet-stream;
	name="Req for quote.xlsx"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="Req for quote.xlsx"

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
AAAAAA4ADgAkBAAA6R0AAAAA

--8=_2pNNwhOzyiko4iNqWnvlKYSpVvugvD9--


