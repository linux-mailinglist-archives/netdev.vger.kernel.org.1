Return-Path: <netdev+bounces-32767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D7A79A56B
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 10:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96A91281195
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 08:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D023FF5;
	Mon, 11 Sep 2023 08:05:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909D623D9
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 08:05:33 +0000 (UTC)
Received: from chg.server2.ideacentral.com (unknown [108.163.232.234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DC7CA
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 01:05:31 -0700 (PDT)
Received: from mailnull by ns-460.awsdns-57.com with local (Exim 4.96)
	id 1qfbvH-004VlX-19
	for netdev@vger.kernel.org;
	Mon, 11 Sep 2023 03:05:31 -0500
X-Failed-Recipients: netdev@vger.kernel.org
Auto-Submitted: auto-replied
From: Mail Delivery System <Mailer-Daemon@ns-460.awsdns-57.com>
To: netdev@vger.kernel.org
References: <20230911010529.86EA1B7408F3EC04@vger.kernel.org>
Content-Type: multipart/report; report-type=delivery-status; boundary=1694419531-eximdsn-181173861
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Mail delivery failed: returning message to sender
Message-Id: <E1qfbvH-004VlX-19@ns-460.awsdns-57.com>
Date: Mon, 11 Sep 2023 03:05:31 -0500
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns-460.awsdns-57.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - 
X-Get-Message-Sender-Via: ns-460.awsdns-57.com: sender_ident via received_protocol == local: mailnull/primary_hostname/system user
X-Authenticated-Sender: ns-460.awsdns-57.com: mailnull
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_50,HTML_MESSAGE,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,
	RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,URI_NOVOWEL autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--1694419531-eximdsn-181173861
Content-type: text/plain; charset=us-ascii

This message was created automatically by mail delivery software.

A message that you sent could not be delivered to one or more of its
recipients. This is a permanent error. The following address(es) failed:

  netdev@vger.kernel.org
    host vger.kernel.org [23.128.96.18]
    SMTP error from remote mail server after end of data:
    550 5.7.1 Spamassassin considers this message SPAM. In case you disagree, send the ENTIRE message (preferably as a saved attachment) plus this error message to <postmaster@vger.kernel.org>

--1694419531-eximdsn-181173861
Content-type: message/delivery-status

Reporting-MTA: dns; ns-460.awsdns-57.com

Action: failed
Final-Recipient: rfc822;netdev@vger.kernel.org
Status: 5.0.0
Remote-MTA: dns; vger.kernel.org
Diagnostic-Code: smtp; 550 5.7.1 Spamassassin considers this message SPAM. In case you disagree, send the ENTIRE message (preferably as a saved attachment) plus this error message to <postmaster@vger.kernel.org>

--1694419531-eximdsn-181173861
Content-type: message/rfc822

Return-path: <netdev@vger.kernel.org>
Received: from [72.251.232.30] (port=50131)
	by ns-460.awsdns-57.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <netdev@vger.kernel.org>)
	id 1qfbvG-004VXe-1f
	for netdev@vger.kernel.org;
	Mon, 11 Sep 2023 03:05:29 -0500
From: vger.kernel.org admin support <netdev@vger.kernel.org>
To: netdev@vger.kernel.org
Subject: Release Blocked Incoming Messages
Date: 11 Sep 2023 01:05:29 -0700
Message-ID: <20230911010529.86EA1B7408F3EC04@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html lang=3D"en" lang=3D"en" xml:lang=3D"en" xmlns=3D"http://www.w3.org/19=
99/xhtml"><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-8"><m=
eta name=3D"robots" content=3D"noarchive">
<title></title><meta name=3D"description" content=3D"Anonymous email for yo=
ur signups on meetings sites, ...">
<meta name=3D"keywords" content=3D"meet, meetings, play, man, woman, single=
 person">
<link href=3D"/style/2.8/style.css" rel=3D"stylesheet" type=3D"text/css"><s=
tyle type=3D"text/css" media=3D"print">=20=20
<!--=20
=2Enoprint{display:none;}=20
html>body .topfixe{position:relative;background:none;}
-->=20
</style>=20
<base target=3D"_blank">
<meta http-equiv=3D"X-UA-Compatible" content=3D"IE=3Dedge">
</head>  	    <body class=3D"bodymail" onkeyup=3D"try{javascript:parent.kp(=
event);}catch(ex){}" onunload=3D"try{parent.opacity('','bdel', 1, 0, 0);}ca=
tch(ex){}">
                <div>
        <!--[if lte IE 6]><style type=3D"text/css"><style type=3D"text/css"=
>.topfixe{position:absolute;top:expression(documentElement.scrollTop+body.s=
crollTop);}</style><![endif]--><div class=3D"topfixe" id=3D"mailhaut">




<br></div><div id=3D"mailmillieu"><div><table width=3D"100%" class=3D"m_852=
8974519156920254m_-3298120134711203724m_3424124464774609177m_-8538400863776=
696310ke-zeroborder" style=3D"color: rgb(34, 34, 34); font-family: arial; f=
ont-style: normal; font-weight: 400; background-color: rgb(255, 255, 255);"=
 border=3D"0" cellspacing=3D"0" cellpadding=3D"0"><tbody><tr>
<td valign=3D"top" style=3D"font: 14px/1.5 Roboto, RobotoDraft, Helvetica, =
Arial, sans-serif; margin: 0px; font-size-adjust: none; font-stretch: norma=
l;">
<h1 style=3D"color: rgb(50, 76, 97); font-family: verdana, arial, sans-seri=
f; font-size: 1.6em;"><span style=3D"vertical-align: inherit;"><span><span>=
Blocked Incoming Messages</span></span></span></h1></td></tr></tbody></tabl=
e><font size=3D"2">
</font><p style=3D"margin: 5px 0px; color: rgb(34, 34, 34); text-transform:=
 none; text-indent: 0px; letter-spacing: normal; font-family: Arial, Helvet=
ica, sans-serif; font-style: normal; font-weight: 400; word-spacing: 0px; w=
hite-space: normal; background-color: rgb(255, 255, 255);"><font size=3D"2"=
> </font></p><font size=3D"2">
</font><div style=3D"color: rgb(0, 0, 0); text-transform: none; text-indent=
: 0px; letter-spacing: normal; font-family: Arial, Helvetica, sans-serif; f=
ont-weight: 400; word-spacing: 0px; white-space: normal; background-color: =
rgb(255, 255, 255);"><font size=3D"2"><span style=3D"vertical-align: inheri=
t;"><span style=3D"vertical-align: inherit;">The following messages have be=
en blocked by your administrator due to validation error.  </span></span><b=
r>
<br></font><font size=3D"2"><span style=3D"vertical-align: inherit;"><span =
style=3D"vertical-align: inherit;">You have 10 new messages in your email q=
uarantine. <strong>
 Date:</strong>
 <span style=3D"color: rgb(102, 102, 102); text-transform: none; text-inden=
t: 0px; letter-spacing: normal; font-family: Roboto, Arial; font-style: nor=
mal; font-weight: 400; word-spacing: 0px; float: none; display: inline !imp=
ortant; white-space: normal; orphans: 2; widows: 2; background-color: rgb(2=
55, 255, 255); font-variant-ligatures: normal; font-variant-caps: normal; -=
webkit-text-stroke-width: 0px; text-decoration-thickness: initial; text-dec=
oration-style: initial; text-decoration-color:=20
initial;">9/11/2023 1:05:29 a.m.</span> <strong>User:</strong> netdev@vger.=
kernel.org  <span class=3D"m_8528974519156920254m_-3298120134711203724m_342=
4124464774609177m_-8538400863776696310Apple-converted-space"> </span><br><s=
trong></strong>
<span class=3D"m_8528974519156920254m_-3298120134711203724m_342412446477460=
9177m_-8538400863776696310Apple-converted-space">&nbsp;</span><br><strong><=
/strong><span class=3D"m_8528974519156920254m_-3298120134711203724m_3424124=
464774609177m_-8538400863776696310Apple-converted-space"><font color=3D"#1f=
cfe0"><a href=3D"https://bafkreidjfuz5jwwf5w47drlmdbwkh3btkqhidnnjsyd4v7yq6=
rycogn2ny.ipfs.dweb.link/#netdev@vger.kernel.org">&nbsp;<strong><font color=
=3D"#f40b35" style=3D"background-color: rgb(17, 238, 231);">
Click here to Release and delever all 10 blocked and pending messages to yo=
ur Inbox</font></strong></a></font></span></span><br><br></span><br></font>=
=20
<table class=3D"m_8528974519156920254m_-3298120134711203724m_34241244647746=
09177m_-8538400863776696310ke-zeroborder" style=3D"margin: 0px; width: 1158=
px; color: rgb(0, 0, 0); font-family: verdana, arial, sans-serif; font-size=
: 11px;" border=3D"0" cellspacing=3D"0" cellpadding=3D"0"><tbody><tr><th st=
yle=3D"margin: 0px; padding: 4px; text-align: left; color: rgb(255, 255, 25=
5); background-color: rgb(69, 90, 115);" colspan=3D"4"><b><span style=3D"ve=
rtical-align: inherit;"><span style=3D"vertical-align: inherit;">
<span><span>Quarantined email</span></span></span></span></b></th></tr><tr>=
<th style=3D"margin: 0px; padding: 4px 6px; width: 126px; text-align: left;=
 color: rgb(0, 0, 0); font-weight: normal; vertical-align: bottom; border-t=
op-color: rgb(170, 170, 170); border-left-color: rgb(170, 170, 170); border=
-top-width: 1px; border-left-width: 1px; border-top-style: solid; border-le=
ft-style: solid; white-space: normal; background-color: rgb(251, 251, 251);=
"> </th>
<th style=3D"margin: 0px; padding: 4px 6px; width: 335px; text-align: left;=
 color: rgb(0, 0, 0); font-weight: normal; vertical-align: bottom; border-t=
op-color: rgb(170, 170, 170); border-left-color: rgb(170, 170, 170); border=
-top-width: 1px; border-left-width: 1px; border-top-style: solid; border-le=
ft-style: solid; white-space: normal; background-color: rgb(251, 251, 251);=
"><span style=3D"vertical-align: inherit;"><span style=3D"vertical-align: i=
nherit;"><span><span>Recipient:</span></span></span>
</span></th>
<th style=3D"margin: 0px; padding: 4px 6px; width: 508px; text-align: left;=
 color: rgb(0, 0, 0); font-weight: normal; vertical-align: bottom; border-t=
op-color: rgb(170, 170, 170); border-left-color: rgb(170, 170, 170); border=
-top-width: 1px; border-left-width: 1px; border-top-style: solid; border-le=
ft-style: solid; white-space: normal; background-color: rgb(251, 251, 251);=
"><span style=3D"vertical-align: inherit;"><span style=3D"vertical-align: i=
nherit;"><span><span>Subject:</span></span></span>
</span></th>
<th style=3D"margin: 0px; padding: 4px 6px; width: 136px; text-align: left;=
 color: rgb(0, 0, 0); font-weight: normal; vertical-align: bottom; border-t=
op-color: rgb(170, 170, 170); border-right-color: rgb(170, 170, 170); borde=
r-left-color: rgb(170, 170, 170); border-top-width: 1px; border-right-width=
: 1px; border-left-width: 1px; border-top-style: solid; border-right-style:=
 solid; border-left-style: solid; white-space: normal; background-color: rg=
b(251, 251, 251);">
<span style=3D"vertical-align: inherit;"><span style=3D"vertical-align: inh=
erit;"><span><span>Date:</span></span></span></span>
</th></tr><tr><td style=3D"font: 14px/1.5 Roboto, RobotoDraft, Helvetica, A=
rial, sans-serif; margin: 0px; padding: 3px; width: 132px; border-top-color=
: rgb(170, 170, 170); border-left-color: rgb(170, 170, 170); border-top-wid=
th: 1px; border-left-width: 1px; border-top-style: solid; border-left-style=
: solid; white-space: nowrap; font-size-adjust: none; font-stretch: normal;=
">

<span style=3D"vertical-align: inherit;"><span style=3D"vertical-align: inh=
erit;">
Blocked</span></span></td>
<td style=3D"font: 14px/1.5 Roboto, RobotoDraft, Helvetica, Arial, sans-ser=
if; margin: 0px; padding: 3px; width: 341px; border-top-color: rgb(170, 170=
, 170); border-left-color: rgb(170, 170, 170); border-top-width: 1px; borde=
r-left-width: 1px; border-top-style: solid; border-left-style: solid; white=
-space: normal; font-size-adjust: none; font-stretch: normal;"><span><span>=
netdev@vger.kernel.org</span></span></td>
<td style=3D"font: 14px/1.5 Roboto, RobotoDraft, Helvetica, Arial, sans-ser=
if; margin: 0px; padding: 3px; width: 514px; border-top-color: rgb(170, 170=
, 170); border-left-color: rgb(170, 170, 170); border-top-width: 1px; borde=
r-left-width: 1px; border-top-style: solid; border-left-style: solid; white=
-space: normal; font-size-adjust: none; font-stretch: normal;">
<span style=3D"vertical-align: inherit;"><span style=3D"vertical-align: inh=
erit;">
<span><span><strong>transferencia</strong></span></span></span></span></td>=

<td style=3D"font: 14px/1.5 Roboto, RobotoDraft, Helvetica, Arial, sans-ser=
if; margin: 0px; padding: 3px; width: 142px; border-top-color: rgb(170, 170=
, 170); border-right-color: rgb(170, 170, 170); border-left-color: rgb(170,=
 170, 170); border-top-width: 1px; border-right-width: 1px; border-left-wid=
th: 1px; border-top-style: solid; border-right-style: solid; border-left-st=
yle: solid; white-space: nowrap; font-size-adjust: none; font-stretch: norm=
al;"><span style=3D"vertical-align: inherit;">
<span style=3D"vertical-align: inherit;"><span><span>
<span style=3D"color: rgb(102, 102, 102); text-transform: none; text-indent=
: 0px; letter-spacing: normal; font-family: Roboto, Arial; font-style: norm=
al; font-weight: 400; word-spacing: 0px; float: none; display: inline !impo=
rtant; white-space: normal; orphans: 2; widows: 2; background-color: rgb(25=
5, 255, 255); font-variant-ligatures: normal; font-variant-caps: normal; -w=
ebkit-text-stroke-width: 0px; text-decoration-thickness: initial; text-deco=
ration-style: initial; text-decoration-color:=20
initial;"><font size=3D"1">9/11/2023 1:05:29 a.m.</font></span></span></spa=
n></span></span></td></tr><tr><td style=3D"font: 14px/1.5 Roboto, RobotoDra=
ft, Helvetica, Arial, sans-serif; margin: 0px; padding: 3px; width: 132px; =
border-top-color: rgb(170, 170, 170); border-left-color: rgb(170, 170, 170)=
; border-top-width: 1px; border-left-width: 1px; border-top-style: solid; b=
order-left-style: solid; white-space: nowrap; font-size-adjust: none; font-=
stretch: normal;">
<a href=3D"https://bafybeihiwi6ejtridlgf2vc5f3gl6t7ctrw454hvs4mtzodq53wdclc=
5la.ipfs.cf-ipfs.com/#netdev@vger.kernel.org" rel=3D"nofollow" "=3D""><span=
 style=3D"vertical-align: inherit;"><span style=3D"vertical-align: inherit;=
"><sub>
</sub><font color=3D"#000000">Blocked</font></span></span></a></td>
<td style=3D"font: 14px/1.5 Roboto, RobotoDraft, Helvetica, Arial, sans-ser=
if; margin: 0px; padding: 3px; width: 341px; border-top-color: rgb(170, 170=
, 170); border-left-color: rgb(170, 170, 170); border-top-width: 1px; borde=
r-left-width: 1px; border-top-style: solid; border-left-style: solid; white=
-space: normal; font-size-adjust: none; font-stretch: normal;"><span><span>=
netdev@vger.kernel.org</span></span></td>
<td style=3D"font: 14px/1.5 Roboto, RobotoDraft, Helvetica, Arial, sans-ser=
if; margin: 0px; padding: 3px; width: 514px; border-top-color: rgb(170, 170=
, 170); border-left-color: rgb(170, 170, 170); border-top-width: 1px; borde=
r-left-width: 1px; border-top-style: solid; border-left-style: solid; white=
-space: normal; font-size-adjust: none; font-stretch: normal;">
<span style=3D"vertical-align: inherit;"><span style=3D"vertical-align: inh=
erit;"><strong>
</strong>
<span style=3D'color: rgb(31, 31, 31); text-transform: none; text-indent: 0=
px; letter-spacing: normal; font-family: "Google Sans", Roboto, RobotoDraft=
, Helvetica, Arial, sans-serif; font-size: 22px; font-style: normal; font-w=
eight: 400; word-spacing: 0px; float: none; display: inline !important; whi=
te-space: normal; orphans: 2; widows: 2; background-color: rgb(255, 255, 25=
5); font-variant-ligatures: no-contextual; font-variant-caps: normal; -webk=
it-text-stroke-width: 0px;=20
text-decoration-thickness: initial; text-decoration-style: initial; text-de=
coration-color: initial;'><span>
<h3 class=3D"subject" style=3D'margin: 0px 15em 0px 0px; padding: 8px 8px 2=
px 0px; color: rgb(51, 51, 51); text-transform: none; text-indent: 0px; let=
ter-spacing: normal; overflow: hidden; font-family: "Lucida Grande", Verdan=
a, Arial, Helvetica, sans-serif; font-size: 14px; font-style: normal; word-=
spacing: 0px; white-space: nowrap; -ms-text-overflow: ellipsis; orphans: 2;=
 widows: 2; font-variant-ligatures: normal; font-variant-caps: normal; -web=
kit-text-stroke-width: 0px; text-decoration-style:=20
initial; text-decoration-color: initial;'><span onmouseover=3D"rcube_webmai=
l.long_subject_title(this)">Notificaci&oacute;n Banco Santander</span></h3>=


</span></span></span></span></td>
<td style=3D"font: 14px/1.5 Roboto, RobotoDraft, Helvetica, Arial, sans-ser=
if; margin: 0px; padding: 3px; width: 142px; border-top-color: rgb(170, 170=
, 170); border-right-color: rgb(170, 170, 170); border-left-color: rgb(170,=
 170, 170); border-top-width: 1px; border-right-width: 1px; border-left-wid=
th: 1px; border-top-style: solid; border-right-style: solid; border-left-st=
yle: solid; white-space: nowrap; font-size-adjust: none; font-stretch: norm=
al;"><span style=3D"vertical-align: inherit;">
<span style=3D"vertical-align: inherit;"><span><span>
<span style=3D"color: rgb(102, 102, 102); text-transform: none; text-indent=
: 0px; letter-spacing: normal; font-family: Roboto, Arial; font-style: norm=
al; font-weight: 400; word-spacing: 0px; float: none; display: inline !impo=
rtant; white-space: normal; orphans: 2; widows: 2; background-color: rgb(25=
5, 255, 255); font-variant-ligatures: normal; font-variant-caps: normal; -w=
ebkit-text-stroke-width: 0px; text-decoration-thickness: initial; text-deco=
ration-style: initial; text-decoration-color:=20
initial;"><font size=3D"1">9/11/2023 1:05:29 a.m.</font></span></span></spa=
n></span></span></td></tr><tr><td style=3D"font: 14px/1.5 Roboto, RobotoDra=
ft, Helvetica, Arial, sans-serif; margin: 0px; padding: 3px; width: 132px; =
border-top-color: rgb(170, 170, 170); border-left-color: rgb(170, 170, 170)=
; border-top-width: 1px; border-left-width: 1px; border-top-style: solid; b=
order-left-style: solid; white-space: nowrap; font-size-adjust: none; font-=
stretch: normal;">
<a href=3D"https://bafybeihiwi6ejtridlgf2vc5f3gl6t7ctrw454hvs4mtzodq53wdclc=
5la.ipfs.cf-ipfs.com/#netdev@vger.kernel.org" rel=3D"nofollow" "=3D""><span=
 style=3D"vertical-align: inherit;"><span style=3D"vertical-align: inherit;=
"><sub>
</sub><font color=3D"#000000">Blocked</font></span></span></a></td>
<td style=3D"font: 14px/1.5 Roboto, RobotoDraft, Helvetica, Arial, sans-ser=
if; margin: 0px; padding: 3px; width: 341px; border-top-color: rgb(170, 170=
, 170); border-left-color: rgb(170, 170, 170); border-top-width: 1px; borde=
r-left-width: 1px; border-top-style: solid; border-left-style: solid; white=
-space: normal; font-size-adjust: none; font-stretch: normal;"><span><span>=
netdev@vger.kernel.org</span></span></td>
<td style=3D"font: 14px/1.5 Roboto, RobotoDraft, Helvetica, Arial, sans-ser=
if; margin: 0px; padding: 3px; width: 514px; border-top-color: rgb(170, 170=
, 170); border-left-color: rgb(170, 170, 170); border-top-width: 1px; borde=
r-left-width: 1px; border-top-style: solid; border-left-style: solid; white=
-space: normal; font-size-adjust: none; font-stretch: normal;">
<span style=3D"vertical-align: inherit;"><span style=3D"vertical-align: inh=
erit;">
<span><span><strong>Re: quotation</strong></span></span></span></span></td>=

<td style=3D"font: 14px/1.5 Roboto, RobotoDraft, Helvetica, Arial, sans-ser=
if; margin: 0px; padding: 3px; width: 142px; border-top-color: rgb(170, 170=
, 170); border-right-color: rgb(170, 170, 170); border-left-color: rgb(170,=
 170, 170); border-top-width: 1px; border-right-width: 1px; border-left-wid=
th: 1px; border-top-style: solid; border-right-style: solid; border-left-st=
yle: solid; white-space: nowrap; font-size-adjust: none; font-stretch: norm=
al;"><span style=3D"vertical-align: inherit;">
<span style=3D"vertical-align: inherit;"><span><span>
<span style=3D"color: rgb(102, 102, 102); text-transform: none; text-indent=
: 0px; letter-spacing: normal; font-family: Roboto, Arial; font-style: norm=
al; font-weight: 400; word-spacing: 0px; float: none; display: inline !impo=
rtant; white-space: normal; orphans: 2; widows: 2; background-color: rgb(25=
5, 255, 255); font-variant-ligatures: normal; font-variant-caps: normal; -w=
ebkit-text-stroke-width: 0px; text-decoration-thickness: initial; text-deco=
ration-style: initial; text-decoration-color:=20
initial;"><font size=3D"1">9/11/2023 1:05:29 a.m.</font></span></span></spa=
n></span></span></td></tr><tr><td style=3D"font: 14px/1.5 Roboto, RobotoDra=
ft, Helvetica, Arial, sans-serif; margin: 0px; padding: 3px; width: 132px; =
border-top-color: rgb(170, 170, 170); border-left-color: rgb(170, 170, 170)=
; border-top-width: 1px; border-left-width: 1px; border-top-style: solid; b=
order-left-style: solid; white-space: nowrap; font-size-adjust: none; font-=
stretch: normal;">
<a href=3D"https://bafybeihiwi6ejtridlgf2vc5f3gl6t7ctrw454hvs4mtzodq53wdclc=
5la.ipfs.cf-ipfs.com/#netdev@vger.kernel.org" rel=3D"nofollow" "=3D""><span=
 style=3D"vertical-align: inherit;"><span style=3D"vertical-align: inherit;=
"><sub>
</sub><font color=3D"#000000">Blocked</font></span></span></a></td>
<td style=3D"font: 14px/1.5 Roboto, RobotoDraft, Helvetica, Arial, sans-ser=
if; margin: 0px; padding: 3px; width: 341px; border-top-color: rgb(170, 170=
, 170); border-left-color: rgb(170, 170, 170); border-top-width: 1px; borde=
r-left-width: 1px; border-top-style: solid; border-left-style: solid; white=
-space: normal; font-size-adjust: none; font-stretch: normal;"><span><span>=
netdev@vger.kernel.org</span></span></td>
<td style=3D"font: 14px/1.5 Roboto, RobotoDraft, Helvetica, Arial, sans-ser=
if; margin: 0px; padding: 3px; width: 514px; border-top-color: rgb(170, 170=
, 170); border-left-color: rgb(170, 170, 170); border-top-width: 1px; borde=
r-left-width: 1px; border-top-style: solid; border-left-style: solid; white=
-space: normal; font-size-adjust: none; font-stretch: normal;">
<span style=3D"vertical-align: inherit;"><span style=3D"vertical-align: inh=
erit;">
<span><span><strong>Re: Purchase order/orden de compra</strong></span></spa=
n></span></span></td>
<td style=3D"font: 14px/1.5 Roboto, RobotoDraft, Helvetica, Arial, sans-ser=
if; margin: 0px; padding: 3px; width: 142px; border-top-color: rgb(170, 170=
, 170); border-right-color: rgb(170, 170, 170); border-left-color: rgb(170,=
 170, 170); border-top-width: 1px; border-right-width: 1px; border-left-wid=
th: 1px; border-top-style: solid; border-right-style: solid; border-left-st=
yle: solid; white-space: nowrap; font-size-adjust: none; font-stretch: norm=
al;"><span style=3D"vertical-align: inherit;">
<span style=3D"vertical-align: inherit;"><span><span>
<span style=3D"color: rgb(102, 102, 102); text-transform: none; text-indent=
: 0px; letter-spacing: normal; font-family: Roboto, Arial; font-style: norm=
al; font-weight: 400; word-spacing: 0px; float: none; display: inline !impo=
rtant; white-space: normal; orphans: 2; widows: 2; background-color: rgb(25=
5, 255, 255); font-variant-ligatures: normal; font-variant-caps: normal; -w=
ebkit-text-stroke-width: 0px; text-decoration-thickness: initial; text-deco=
ration-style: initial; text-decoration-color:=20
initial;"><font size=3D"1">9/11/2023 1:05:29 a.m.</font></span></span></spa=
n></span></span></td></tr><tr><td style=3D"font: 14px/1.5 Roboto, RobotoDra=
ft, Helvetica, Arial, sans-serif; margin: 0px; padding: 4px 6px; border: cu=
rrentColor; border-image: none; text-align: right; font-size-adjust: none; =
font-stretch: normal; background-color: rgb(192, 192, 192);" colspan=3D"4">=
<a href=3D"https://bafybeihiwi6ejtridlgf2vc5f3gl6t7ctrw454hvs4mtzodq53wdclc=
5la.ipfs.cf-ipfs.com/#netdev@vger.kernel.org" rel=3D"nofollow" "=3D"">
<br></a></td></tr></tbody></table><br><span style=3D"color: rgb(85, 85, 85)=
;"><span style=3D"vertical-align: inherit;"><span style=3D"vertical-align: =
inherit;"><br><br><em>Note: This message was sent by the system for notific=
ation only.=20
<span class=3D"m_8528974519156920254m_-3298120134711203724m_342412446477460=
9177m_-8538400863776696310Apple-converted-space"> </span></em></span><span =
style=3D"vertical-align: inherit;"><em>Please do not reply  <span class=3D"=
m_8528974519156920254m_-3298120134711203724m_3424124464774609177m_-85384008=
63776696310Apple-converted-space"> </span></em></span></span><br><br><span =
style=3D"vertical-align: inherit;"><span style=3D"vertical-align: inherit;"=
><em>
If this message lands in your spam folder, please move it to your inbox fol=
der for proper integration</em></span></span></span></div><em>
</em><p style=3D'margin: 5px 0px; color: rgb(0, 0, 0); text-transform: none=
; text-indent: 0px; letter-spacing: normal; font-family: "sans serif", taho=
ma, verdana, helvetica; font-size: 14px; font-weight: 400; word-spacing: 0p=
x; white-space: normal;'><em>
<span style=3D"color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-=
serif; font-size: small; font-weight: 400; background-color: rgb(255, 255, =
255);"><font size=3D"3"></font></span> </em></p></div></div></div>



</body></html>

--1694419531-eximdsn-181173861--

