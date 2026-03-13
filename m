Return-Path: <netdev+bounces-267570-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIq/Bo9ptGnxnQAAu9opvQ
	(envelope-from <netdev+bounces-267570-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 20:46:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F26628966C
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 20:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9510031E0FC4
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 19:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DCC363C64;
	Fri, 13 Mar 2026 19:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zoom.us header.i=@zoom.us header.b="nFYlhhR0"
X-Original-To: netdev@vger.kernel.org
Received: from o5.sg.zoom.us (o5.sg.zoom.us [149.72.199.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8258236165B
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 19:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.72.199.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773431163; cv=none; b=aQEGWTMcXNLSu0OGZbDGUW6h++e3ATFinfGvbNWZUkFX5jhH5/Ze5ORRbqLiFF4fHAhtd66n+LkvgDBYe9/1V8SFLd8xW3T/dcWd2mJseh3/PXcBveSG/s434y70bLjpN+0lsRBbuze7DIIk28Ir7URUxXYU96SNSIjl6IkZXk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773431163; c=relaxed/simple;
	bh=zGMxbq1FlPyiIc3cZDU1xJv1m2fDpm8RndChwggTTaU=;
	h=Content-Type:Date:From:Mime-Version:Message-ID:Subject:To; b=l1g2e9nNfPRF91BTQUms78y+fqKnDcCMoIwfytDMJPnsXDDxvNFXWPMWXhR1SfFZS99wR2FfgtZtJIvriJwfuDrkn0QAt7+op+D16wQyl0fw/FGFx0t3GH+o9ZS5Kj+WRDMDM6nUkn+8EwUI72v7/XRAOeEFtuX86ciqTpWVdgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zoom.us; spf=pass smtp.mailfrom=bounce-sg.zoom.us; dkim=pass (2048-bit key) header.d=zoom.us header.i=@zoom.us header.b=nFYlhhR0; arc=none smtp.client-ip=149.72.199.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zoom.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce-sg.zoom.us
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zoom.us;
	h=content-type:date:from:mime-version:subject:reply-to:to:cc:
	content-type:date:from:subject:to;
	s=sg; t=1773431160; bh=69N719GTkR39WuFClAVRZFNfdk7Xz/EazXve0Yz5VuI=;
	b=nFYlhhR0NY55QkHHtXz5EfJ4rf2+/NYrYA4vS0TYiBkfH6WZR/cETS7TfP13phYaBJD9
	6kWJtVNWqjHa6cBk/SbW2/nmZDrLA4xgxNHyT235HNpkm2EzGYRchd1wS3xxd7BUmHGh85
	h2LA6aFR8cYnMfgzZVMIoqKKBOqtf/tCAhMUkgFFVY4CI7ogfJWRDpkUefGTYOlmFVcT54
	b4316zXuWkiKvE9dj+yrtqdAt/TXg+RbqO0tvQ3fgYUphQFj4Wjv3WCf+YwPRGTvCRRUrX
	gEHXXk/alEuhM4FXP6hipSW6F696RTaZT5A9xbGspBRTzoHUMWNqvHKR7jyawb5Q==
Received: by recvd-656d48875c-9h9ql with SMTP id recvd-656d48875c-9h9ql-1-69B46978-3C
	2026-03-13 19:46:00.247391953 +0000 UTC m=+347424.320711381
Received: from MjEwNzk4ODQ (unknown)
	by geopod-ismtpd-36 (SG) with HTTP
	id TZvQUbLbRNCkvX1fUfwEyQ
	Fri, 13 Mar 2026 19:46:00.234 +0000 (UTC)
Content-Type: multipart/mixed; boundary=c55842b844d2dc3795931c859326e06d331fd0f64d9331a2a56fdbf2c73e
Date: Fri, 13 Mar 2026 19:46:00 +0000 (UTC)
From: Zoom Webinar <no-reply@zoom.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <TZvQUbLbRNCkvX1fUfwEyQ@geopod-ismtpd-36>
Subject: [TODAY @ 3 PM]: How AI =?UTF-8?B?4oCcVmlyYWwgQ2hhcmFjdGVyc+KAnQ==?=
 Are Pulling Millions of Views & Turning Short Videos Into Daily Sales
 Confirmation
Reply-To: Zoom Webinar <lanrejames@novalab.in>
Feedback-ID: j8lyLvjATyKTA8EMIQdvzA:::zoom.us
X-SG-EID: 
 =?us-ascii?Q?u001=2ERgZnWCz8IFHH0kIZpn+qAiw7pwkTVFI=2FJtjtfe++gnUbGuPWuWXXvMnuq?=
 =?us-ascii?Q?lWvvHeZe7tGaFmya1Lib5mab1OpHy63PHZSA4Ml?=
 =?us-ascii?Q?QaZx+UVdiNAAusRj4a7wfXfY0uw2XMfbDbC7udr?=
 =?us-ascii?Q?bg3D=2F8cJIQY5V7++Y+ql7VLW3E3M8A4i21jbTMZ?=
 =?us-ascii?Q?bCqiJRu+XnGxDPJGdUp7ZMXhKRYne2eZS0VAr4t?=
 =?us-ascii?Q?GkdH4Z=2FJmjA4RXlko5N3Fbos4xlSJTDkVknwAp+?= =?us-ascii?Q?JCMm?=
X-SG-ID: 
 =?us-ascii?Q?u001=2ESdBcvi+Evd=2FbQef8eZF3Bq+efGylwbz3q5X9xSK9XHyEixZMkOa8ilCgx?=
 =?us-ascii?Q?YOwpsXED6=2FoRQgRpyNwhJCp+NbSG4xP8sPpKkrO?=
 =?us-ascii?Q?K4yJNq1xr8196a7nn7YrEzKTMCJt7Z4IA8onDck?=
 =?us-ascii?Q?E9lNoaeGkNxcsxRHKYtBvs3Tg9+HdgpnzZKBUKM?=
 =?us-ascii?Q?tvQfKPwzhAaiExj3NE1IYdqnA+Hpsb6x9dxS94q?=
 =?us-ascii?Q?ZkThl64gv2=2FMwDzlsXZ8ol9suGMB20W6N4GzKM2?=
 =?us-ascii?Q?vdpWizA=2FHBTr7HZXbQIkBUzYohER8BU3XX6GfBo?=
 =?us-ascii?Q?L6RRXdJLh=2F3Gx02tyuYCUof3GidOAlsc7NdlRA8?=
 =?us-ascii?Q?9H82Dauz1wqsbzgTAgHXkCDsxfYjep9JKuFqXwz?=
 =?us-ascii?Q?3TTkVYoaDgFK6WI92=2Fq3QMCgiGhqRP0NCBZHESN?=
 =?us-ascii?Q?G=2FimnpF5A+gIZ5Cd2TnRGfEj0Yf+f6ipFVityGY?=
 =?us-ascii?Q?5hg9hMrUVaGfrpLYpAyZZPirhWP3Z1VGN+2Ob6o?=
 =?us-ascii?Q?cTKPMeww115m2bCJl6SXhvNIPu1NnPqKPAmtUDb?=
 =?us-ascii?Q?zOzMnvy2JSbSlXeOyIW94719JbvzvMONLpQuqqs?=
 =?us-ascii?Q?89yjsWuE3wFieEFtVVDeLZS6JNGvToVn9fKv0b0?=
 =?us-ascii?Q?2Pp+Rq=2FHKyiGnCf1=2FkZt=2FDMg6y7lxOMgU1nC+kC?=
 =?us-ascii?Q?zbsuKzOW3xN3Bj9sF=2FtkNwqkDUk0UVc5grilTI3?=
 =?us-ascii?Q?p8TQGJfy3ZcoGHz1h45rejJ6Id+nEx0HG1Zky6O?=
 =?us-ascii?Q?TsdvNftZu8OXJsBxiA64zQPl3=2F+BMvMg24VfMau?=
 =?us-ascii?Q?HdRBUUTpN+YK3zHEKdoP9Iyb2PYkSRhNJ0eXfYU?=
 =?us-ascii?Q?zxtMVHXBirlFIHnZUNZSVIUmWqV3noeRJTXAE=2Fv?=
 =?us-ascii?Q?tYd9x=2F89tfRCncTrVpw=2F0VBoXRx=2FVLGGxM6OFuf?=
 =?us-ascii?Q?ZZUHVUBgFZMmiYWuHw3=2FhbLefv5yppej1eekOY4?=
 =?us-ascii?Q?8kUj1jCDW7rDHZqk+XcQuPPqVtwN6we4tjRZgAh?=
 =?us-ascii?Q?mA2emjoeqWGuFGo1igtHg2Bfw5S+XAuBXcODJ99?=
 =?us-ascii?Q?XX6R1VgORRiWUxC39YTeWt0IEeNojI5F=2FKE2Gf8?=
 =?us-ascii?Q?vlniN=2FQt1j2EELFO9yJ1IfaTw3KeKMiHo6fbX7E?=
 =?us-ascii?Q?3bQ2vO16t7B3CLXcs?=
To: netdev@vger.kernel.org
X-Entity-ID: u001.D04ToUD6XUHaWjLaA2+xDg==
X-Spamd-Result: default: False [1.14 / 15.00];
	MIME_MA_MISSING_TEXT(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zoom.us,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[zoom.us:s=sg];
	MIME_HTML_ONLY(0.20)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,multipart/alternative];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267570-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	HAS_ATTACHMENT(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~,3:~,4:~];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REDIRECTOR_URL(0.00)[twitter.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[no-reply@zoom.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[zoom.us:+];
	NEURAL_HAM(-0.00)[-0.950];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	HAS_REPLYTO(0.00)[lanrejames@novalab.in];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zoom.us:dkim,zoom.us:email,zoom.us:url,linkedin.com:url,novalab.in:email,novalab.in:replyto,instagram.com:url]
X-Rspamd-Queue-Id: 6F26628966C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--c55842b844d2dc3795931c859326e06d331fd0f64d9331a2a56fdbf2c73e
Content-Type: multipart/alternative; boundary=85fddd802d38c7ddee2a37489b5c535de4fc52a89dd212d1110af16b5e6d

--85fddd802d38c7ddee2a37489b5c535de4fc52a89dd212d1110af16b5e6d
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=utf-8
Mime-Version: 1.0

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.=
w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns=3D"http://www.w3.org/1999/xhtml">
<head>
    <meta content=3D"text/html; charset=3Dutf-8" http-equiv=3D"Content-Type=
"/>
</head>
<body style=3D"height: 100% !important;width: 100% !important;margin: 0;pad=
ding: 0;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" align=3D"center" bg=
color=3D"#f1f1f4" width=3D"100%" style=3D"font-size: 13px;font-family: Aria=
l;height:100%;">
    <tr>
        <td>
            <table id=3D"table-new-invitation" border=3D"0" cellpadding=3D"=
0" cellspacing=3D"0" align=3D"center" style=3D"padding: 40px 0;max-width: 9=
60px;min-width: 600px;width: 60%;">
                    <tr><td style=3D"height: 8px;"></td> </tr>
                <tr>
                    <td valign=3D"top" bgcolor=3D"#ffffff">
                        <table border=3D"0" cellpadding=3D"0" cellspacing=
=3D"0" align=3D"center" width=3D"100%" style=3D"margin-left: 0;margin-right=
: 0;">
                            <tr>
                                <td style=3D"padding-left: 32px;padding-rig=
ht: 32px;">
                                    <table border=3D"0" cellpadding=3D"0" c=
ellspacing=3D"0" align=3D"center" width=3D"100%" style=3D"font-size: 13px;c=
olor: #39394d;font-family: Arial;">
                                        <tr> <td colspan=3D"2" valign=3D"to=
p" style=3D"padding-top:32px;font-size: 14px;font-weight: 400;color: #13161=
9;font-family: Arial;line-height: 24px;">Hi  Friend,</td> </tr>
                                        <tr> <td colspan=3D"2" valign=3D"to=
p" style=3D"padding-top:32px;font-size: 14px;font-weight: 400;color: #13161=
9;font-family: Arial;line-height: 24px;">Thank you for registering for [TOD=
AY @ 3 PM]<span>:</span> How AI =E2=80=9CViral Characters=E2=80=9D Are Pull=
ing Millions of Views &amp; Turning Short Videos Into Daily Sales. You can =
find information about this webinar below.</td> </tr>
                                        <tr><td style=3D"height: 32px"></td=
></tr>
                                        <tr><td style=3D"height: 32px"></td=
></tr>
                                            <tr> <td colspan=3D"2" valign=
=3D"top" style=3D"font-size: 14px;font-weight: 400;color: #131619;font-fami=
ly: Arial;line-height: 24px;"> Please submit any questions to: <a target=3D=
"_blank" style=3D"color: #000000;text-decoration:none;"> lanrejames@novalab=
.in</a> </td> </tr>
                                        <tr><td style=3D"height: 32px"></td=
></tr>
                                            <tr> <td colspan=3D"2" style=3D=
"font-size: 14px;font-weight: 400;color: #000;font-family: Arial;line-heigh=
t: 24px;" valign=3D"top"> You can <a href=3D"https://zoom.us/webinar/regist=
er/WN_7OWkX7BxTwuKEaEuvulYxA?tk=3Dne0YQcPmi-uwaFLv4evBfTr4ZgnhsqCQx4lcvf8ly=
F8.DQkAAAAVfMDRTRZHY2dJbS1rbFFDLWZlQ1otaHdWWDFRAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAA#detail" target=3D"_blank">cancel</a> your registration at a=
ny time. </td> </tr>
                                        <tr><td style=3D"height: 32px"></td=
></tr>
                                        <tr> <td colspan=3D"2" style=3D"fon=
t-size: 14px;font-weight: 400;color: #000;font-family: Arial;line-height: 2=
4px;" valign=3D"top"> Thank you! </td> </tr>
                                        <tr>
                                            <td width=3D"100%">
                                                <table style=3D"width:100%;=
border-radius: 8px;background-color: #F7F7FC;">
                                                        <tr> <td colspan=3D=
"3" style=3D"padding: 12px 16px 8px 16px;font-size: 14px;font-weight: 700;l=
ine-height: 24px;" valign=3D"top">  <strong>[TODAY @ 3 PM]<span>:</span> Ho=
w AI =E2=80=9CViral Characters=E2=80=9D Are Pulling Millions of Views &amp;=
 Turning Short Videos Into Daily Sales</strong> </td> </tr>
                                                            <tr>
                                                                <td valign=
=3D"top" style=3D"padding: 4px 16px 8px 16px;width: 112px;font-size: 13px;f=
ont-weight: 400;line-height: 16px;color: rgba(4, 4, 19, 0.56);">Date & Time=
</td>
                                                                <td valign=
=3D"top" style=3D"font-weight: 400;font-size: 13px;line-height: 16px;color:=
 #233333;padding: 4px 16px 8px 0;">Mar 13, 2026 03:00 PM Eastern Time (US a=
nd Canada)</td>
                                                            </tr>
                                                        <tr>
                                                            <td valign=3D"t=
op" style=3D"padding: 4px 16px 8px 16px;width: 112px;font-size: 13px;font-w=
eight: 400;line-height: 16px;color: rgba(4, 4, 19, 0.56);">Webinar ID</td>
                                                            <td valign=3D"t=
op" style=3D"font-weight: 400;font-size: 13px;line-height: 16px;color: #233=
333;padding: 4px 16px 8px 0;">922 8732 4493</td>
                                                        </tr>
                                                        <tr>
                                                            <td valign=3D"t=
op" style=3D"padding: 4px 16px 8px 16px;width: 112px;font-size: 13px;font-w=
eight: 400;line-height: 16px;color: rgba(4, 4, 19, 0.56);">Description</td>
                                                            <td valign=3D"t=
op" style=3D"font-weight: 400;font-size: 13px;line-height: 16px;color: #233=
333;padding: 4px 16px 8px 0;">Something BIG is about to hit the AI content =
creation space=E2=80=A6<br/>
<br/>
For the first time ever, you=E2=80=99re about to discover a powerful system=
 that lets anyone create viral AI character videos in minutes without compl=
icated editing, animation skills, or expensive software.<br/>
<br/>
Inside this live training, you=E2=80=99ll see how simple ideas, scripts, or=
 images can instantly be transformed into fully animated character videos w=
ith voiceovers, expressions, and storytelling built in automatically.<br/>
<br/>
These character-driven videos are dominating social platforms because audie=
nces connect with characters far more than ordinary content, which is why c=
reators are generating massive engagement using this format.<br/>
<br/>
During this LIVE session, you=E2=80=99ll discover:<br/>
<br/>
=E2=80=A2 How AI characters can instantly generate engaging videos for TikT=
ok, Instagram Reels, and YouTube Shorts<br/>
=E2=80=A2 The simple workflow that transforms ideas, images, or scripts int=
o animated viral videos<br/>
=E2=80=A2 How character-based content grabs attention and keeps viewers wat=
ching longer<br/>
=E2=80=A2 The strategy behind viral character storytelling that drives shar=
es and engagement<br/>
=E2=80=A2 How beginners are using AI characters to create entertaining, hig=
hly shareable videos at scale<br/>
<br/>
You=E2=80=99ll also see a live demo showing exactly how these AI characters=
 can speak, react, and tell stories while automatically syncing voice, expr=
essions, and scenes.<br/>
<br/>
If you want to learn how the new wave of AI-powered viral character videos =
are being created=E2=80=A6<br/>
<br/>
you won=E2=80=99t want to miss this training.<br/>
<br/>
=E2=9A=A0=EF=B8=8F IMPORTANT =E2=80=94 Secure Your Reminder Now!<br/>
<br/>
This is a live training and space is limited.<br/>
<br/>
To make sure you don=E2=80=99t miss it:<br/>
<br/>
=E2=9C=85 Click =E2=80=9CAdd to Calendar=E2=80=9D below to save the event t=
o your Google / Outlook calendar.<br/>
<br/>
Your device will automatically remind you before we go live.<br/>
<br/>
Most people miss live trainings simply because they forget.<br/>
<br/>
Don=E2=80=99t be that person.</td>
                                                        </tr>
                                                    <tr>
                                                        <td style=3D"paddin=
g: 8px 16px 0;width: 112px;"></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr><td style=3D"height: 8px;"></td=
> </tr>
                                            <tr> <td colspan=3D"2" style=3D=
"line-height: 32px;padding-top: 16px;padding-bottom: 30px;"> <span style=3D=
"font-size: 14px;font-weight: bold;line-height: 20px;color: #222230;vertica=
l-align: middle;">Add to:</span>  <a href=3D"https://zoom.us/webinar/tJYvf-=
6rrD8uE9cVJcfwBOyFHAZcfcmFSa8i/calendar/google/add?user_id=3DLnKURcHP6xkoHA=
CztbQQblg7dXY0TZCjtHmevfkWBNfRd3jLMVc.Yztoi8BnQGUPoAjW&type=3Dgoogle" style=
=3D"letter-spacing: 0;border: 1px solid #3171BB;color: #3171BB;border-radiu=
s: 8px;padding: 3px 5px;text-decoration: none;font-weight: 400;font-size: 1=
4px;line-height: 30px;height: 24px;display:inline-flex;vertical-align:middl=
e;"> <i class=3D"glyphicon" style=3D"width: 20px;display:inline-block;"> <i=
mg src=3D"https://st3.zoom.us/static/6.3.53910/image/new/google.png" /> </i=
><span style=3D"display:inline-flex;line-height:24px;">&nbsp;Google Calenda=
r</span> </a>&nbsp;  <a href=3D"https://zoom.us/webinar/tJYvf-6rrD8uE9cVJcf=
wBOyFHAZcfcmFSa8i/ics?user_id=3DIW8T9xhTf8RliLrMg8zSznus8l_ruKxwzoWW2puQU0f=
_LX9J02k.7wkk0r329SJTzTd0&type=3Dicalendar" style=3D"border: 1px solid #0E7=
2ED;color: #0E72ED;border-radius: 8px;padding:3px 5px;text-decoration: none=
;font-weight: 400;font-size: 14px;line-height: 30px;vertical-align:middle;h=
eight: 24px;display:inline-flex;letter-spacing: 0;"> <i class=3D"glyphicon"=
 style=3D"width: 20px;display:inline-block;"> <img src=3D"https://st3.zoom.=
us/static/6.3.53910/image/new/outlook.png" /> </i><span style=3D"display:in=
line-flex;line-height:24px;">&nbsp;Outlook Calendar(.ICS)</span> </a>&nbsp;=
 <a href=3D"https://zoom.us/webinar/tJYvf-6rrD8uE9cVJcfwBOyFHAZcfcmFSa8i/ic=
s?user_id=3DebviIyEyrzDLwnYinZETZj1JEt58cyyLMdlIFOEVz_mu4PjRtsM.p4Cn1RXPHwL=
Pb8F8&type=3Dyahoo" style=3D"border: 1px solid #952BCE;color: #952BCE;borde=
r-radius: 8px;padding: 3px 5px;text-decoration: none;font-weight: 400;font-=
size: 14px;line-height: 30px;vertical-align:middle;height: 24px;display:inl=
ine-flex;letter-spacing: 0;"> <i class=3D"glyphicon" style=3D"width: 20px;d=
isplay:inline-block;"> <img src=3D"https://st3.zoom.us/static/6.3.53910/ima=
ge/new/yahoo.png" /> </i><span style=3D"display:inline-flex;line-height:24p=
x;">&nbsp;Yahoo Calendar</span> </a> </td> </tr>
                                        <tr></tr>
                                        <tr> <td> <table align=3D"left" cel=
lpadding=3D"0" cellspacing=3D"0" style=3D"width:100%;"> <tr> <td bgcolor=3D=
"#ffffff" style=3D"padding: 32px 0 0 0;padding-top: 30px !important;width: =
182px;font-size: 12px;line-height: 18px;color: rgba(4, 4, 19, 0.56);font-we=
ight: 700;" valign=3D"top"> WAYS TO JOIN THIS WEBINAR </td> <td bgcolor=3D"=
#ffffff" style=3D"padding: 32px 0 0 8px;padding-top: 38px !important;" vali=
gn=3D"top"> <div style=3D"height: 1px;border-top: 1px dashed rgba(82, 82, 1=
28, 0.18);"></div> </td> </tr> </table> </td> </tr>
                                        <tr> <td colspan=3D"2" style=3D"pad=
ding-left:12px;padding-top: 28px !important;padding-bottom: 12px !important=
;font-family: Arial;font-size: 16px;font-weight: 700;line-height: 24px;colo=
r: #233333;" valign=3D"top"> <ul style=3D"padding:0;margin:0;"><li class=3D=
"join1" style=3D"margin-left:0;list-style-type: disc;">Join from PC, Mac, i=
Pad, or Android</li></ul> </td> </tr>
                                            <tr> <td bgcolor=3D"#ffffff" wi=
dth=3D"122" height=3D"30" style=3D"padding-bottom: 16px;" valign=3D"middle"=
> <div style=3D"height: 24px;border-radius: 8px;line-height: 30px;mso-line-=
height-rule: exactly;"> <a type=3D"button" href=3D"https://zoom.us/w/922873=
24493?tk=3Dne0YQcPmi-uwaFLv4evBfTr4ZgnhsqCQx4lcvf8lyF8.DQkAAAAVfMDRTRZHY2dJ=
bS1rbFFDLWZlQ1otaHdWWDFRAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA&uuid=3D=
WN_7OWkX7BxTwuKEaEuvulYxA" target=3D"_blank" style=3D"height:24px;text-deco=
ration:none;font-size: 14px;font-weight: 500;color: #fff;background: #0E72E=
D;border-radius: 8px;line-height: 30px;vertical-align:middle;padding: 7px 2=
0px;mso-line-height-rule:exactly;">&nbsp;&nbsp;&nbsp;&nbsp;<span style=3D"l=
ine-height:30px;mso-line-height-rule:exactly;">Join Webinar</span>&nbsp;&nb=
sp;&nbsp;&nbsp;</a> </div> </td> </tr>
                                            <tr> <td colspan=3D"2" valign=
=3D"top" style=3D"font-size: 14px;font-weight: 400;color: #000000;font-fami=
ly: Arial;line-height: 24px;"> If the button above does not work, paste thi=
s into your browser:=E2=80=A8<br/> </td> </tr>
                                            <tr> <td colspan=3D"2" valign=
=3D"top" width=3D"536" style=3D"word-break: break-all;font-size: 14px;font-=
weight: 400;color: #000000;font-family: Arial;line-height: 24px;"> <a href=
=3D"https://zoom.us/w/92287324493?tk=3Dne0YQcPmi-uwaFLv4evBfTr4ZgnhsqCQx4lc=
vf8lyF8.DQkAAAAVfMDRTRZHY2dJbS1rbFFDLWZlQ1otaHdWWDFRAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAA&uuid=3DWN_7OWkX7BxTwuKEaEuvulYxA" style=3D"width: 536p=
x;text-decoration:underline;color: #000000;word-wrap:break-word;">https://z=
oom.us/w/92287324493?tk=3Dne0YQcPmi-uwaFLv4evBfTr4ZgnhsqCQx4lcvf8lyF8.DQkAA=
AAVfMDRTRZHY2dJbS1rbFFDLWZlQ1otaHdWWDFRAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAA&uuid=3DWN_7OWkX7BxTwuKEaEuvulYxA</a> </td> </tr>
                                        <tr> <td colspan=3D"2" style=3D"fon=
t-family: Arial;font-size: 14px;font-weight: 700;line-height: 17px;color: #=
222230;padding-top: 12px;" valign=3D"top"> To keep this webinar secure, do =
not share this link publicly. </td> </tr>
                                                <tr>
                                                    <td width=3D"100%">
                                                        <table align=3D"lef=
t" border=3D"0" cellpadding=3D"0" cellspacing=3D"0" style=3D"width:auto;pad=
ding:0;margin:0;">
                                                            <tr> <td colspa=
n=3D"2" valign=3D"top" style=3D"padding:32px 0 8px 12px;font-family: Arial;=
font-size: 16px;font-weight: 700;line-height: 24px;color: #233333;"> <ul st=
yle=3D"padding:0;margin:0;"><li style=3D"margin-left:0;list-style-type: dis=
c;">Join via audio</li></ul> </td> </tr>
                                                            <tr> <td width=
=3D"600" colspan=3D"2" valign=3D"top" style=3D"word-break: break-word;paddi=
ng-bottom: 4px;font-size: 14px;font-weight: 400;color: #233333;font-family:=
 Arial;line-height: 24px;"> <span style=3D"color: #000000;word-wrap: break-=
word;"> US: <a style=3D"color: #233333;text-decoration: underline;" href=3D=
"tel:+13462487799,,92287324493#">+13462487799,,92287324493#</a>   or <a sty=
le=3D"color: #233333;text-decoration: underline;" href=3D"tel:+13602095623,=
,92287324493#">+13602095623,,92287324493#</a>  </span> </td> </tr>
                                                            <tr> <td style=
=3D"width: 100px;padding-left: 0;padding-right: 6px;font-weight: 600;font-s=
ize: 14px;color: #233333;font-family: Arial;line-height: 24px;" valign=3D"t=
op"> Or, dial: </td> <td width=3D"836" style=3D"word-break: break-word;padd=
ing-left: 0;padding-bottom: 4px;font-size: 14px;font-weight: 400;color: #23=
3333;font-family: Arial;line-height: 24px;" valign=3D"top"> <span style=3D"=
color: #000000;word-wrap: break-word;">    US:  +1 346 248 7799      or +1 =
360 209 5623      or +1 386 347 5053      or +1 507 473 4847      or +1 564=
 217 2000      or +1 646 931 3860      or +1 669 444 9171      or +1 669 90=
0 6833      or +1 689 278 1000      or +1 719 359 4580      or +1 929 205 6=
099      or +1 253 205 0468      or +1 253 215 8782      or +1 301 715 8592=
      or +1 305 224 1968      or +1 309 205 3325      or +1 312 626 6799   =
  <br><a href=3D"https://zoom.us/u/ac9hEmcTMT" target=3D"_blank" style=3D"f=
ont-size: 14px;font-weight: 400;color: #233333;font-family: Arial;line-heig=
ht: 24px;vertical-align: top;">More International numbers</a>  </span> </td=
> </tr>
                                                                <tr> <td va=
lign=3D"top" style=3D"width: auto;padding-left: 0;padding-right: 6px;font-s=
ize: 14px;font-weight: 400;color: #233333;font-family: Arial;line-height: 2=
4px;">Webinar ID:</td> <td style=3D"padding-left:0;padding-bottom: 4px;font=
-size: 14px;font-weight: 400;color: #233333;font-family: Arial;line-height:=
 24px;" valign=3D"top">922 8732 4493</td> </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                       =20
                                       =20
                                       =20
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td height=3D"32"></td>
                            </tr>
                            <tr><td style=3D"padding-top: 32px;padding-left=
: 32px;padding-right: 32px;"><div style=3D"height: 1px; border-top-width: 1=
px; border-top-style: inset; border-top-color: #DFE3E8;"></div></td></tr>
                            <tr>
                                <td style=3D"padding-top: 24px;padding-bott=
om: 24px;">
                                    <table align=3D"center" border=3D"0" ce=
llpadding=3D"0" cellspacing=3D"0" style=3D"width:auto;">
                                        <tbody>
                                        <tr>
                                            <td style=3D"padding:0;"> <a hr=
ef=3D"https://linkedin.com/company/zoom/" class=3D"no-decortaion" style=3D"=
margin-right: 16px;"> <img alt=3D"" border=3D"0" width=3D"32" height=3D"32"=
 src=3D"https://file-paa.zoom.us/kNH2urxhRLqXnWNb_EN1lQ/MS4yLoS79VBM36fz9x0=
Qu-Vm3_05uKEgidDZkSkBh6nf5jHh/Linkedin.png" style=3D"border-width: 0px;bord=
er-style: solid;width: 32px;height: 32px;" /> </a> </td>
                                            <td style=3D"padding:0;"> <a hr=
ef=3D"https://twitter.com/zoom" class=3D"no-decortaion" style=3D"margin-rig=
ht: 16px;"> <img alt=3D"" border=3D"0" width=3D"32" height=3D"32" src=3D"ht=
tps://file-paa.zoom.us/A9z6enYnRciVty2WD69K5Q/MS4yLlA3EEXVxtd5BnQvHzaVmWfiw=
_MyODrLSm1FTgct1k_x/X.png" style=3D"border-width: 0px;border-style: solid;w=
idth: 32px;height: 32px;" /> </a> </td>
                                            <td style=3D"padding:0;"> <a hr=
ef=3D"https://instagram.com/zoom" class=3D"no-decortaion" style=3D"margin-r=
ight: 16px;"> <img alt=3D"" border=3D"0" width=3D"32" height=3D"32" src=3D"=
https://file-paa.zoom.us/6OcdBBJUSUO39GlRevwBpw/MS4yLhjC22e6R_ad3qd4NWLCKth=
WlIu8Y716iX4jSiBD42Rx/Instagram.png" style=3D"border-width: 0px;border-styl=
e: solid;width: 32px;height: 32px;" /> </a> </td>
                                            <td style=3D"padding:0;"> <a hr=
ef=3D"https://www.facebook.com/zoom" style=3D"text-decoration: none;margin-=
right: 16px;"> <img alt=3D"" border=3D"0" width=3D"32" height=3D"32" src=3D=
"https://file-paa.zoom.us/XiUNdDxVRN227pWtZejqng/MS4yLjBX8SUlVoub9cJv-VllS5=
alt7U-cZRNnpyJTwbWNBPX/Facebook.png" style=3D"border-width: 0px;border-styl=
e: solid;width: 32px;height: 32px;" /> </a> </td>
                                            <td style=3D"padding:0;"> <a hr=
ef=3D"https://www.youtube.com/@Zoom" style=3D"text-decoration: none;margin-=
right: 16px;"> <img alt=3D"" border=3D"0" width=3D"32" height=3D"32" src=3D=
"https://file-paa.zoom.us/AQII00caTNmcRtOxZA9CHw/MS4yLluoNlumbwBzheCXQU4wTL=
FvBAvxtt0j2Se_SPtGrimT/YouTube.png" style=3D"border-width: 0px;border-style=
: solid;width: 32px;height: 32px;" /> </a> </td>
                                            <td style=3D"padding:0;"> <a hr=
ef=3D"https://blog.zoom.us/" style=3D"text-decoration: none;"> <img alt=3D"=
" border=3D"0" width=3D"32" height=3D"32" src=3D"https://file-paa.zoom.us/y=
3B837SCRhewJhRfIQAbNQ/MS4yLjSNE-R1r6XOy5Splz-i8Kl5uvaFt1JIWRutwY3W9uAP/Blog=
.png" style=3D"border-width: 0px;border-style: solid;width: 32px;height: 32=
px;" /> </a> </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                    <table align=3D"center" border=3D"0" ce=
llpadding=3D"0" cellspacing=3D"0" width=3D"100%" style=3D"margin-top: 16px;=
color:#6E7680;font-size: 12px;line-height: 16px;font-weight: 400;">
                                        <tbody>
                                        <tr> <td align=3D"center" style=3D"=
font-size:12px;font-weight: 400;line-height:16px;color:#747487;" valign=3D"=
top"> <a style=3D"color: #0D6BDE; font-size: 14px;font-style: normal;font-w=
eight: 590;line-height: 18px;text-decoration:none; letter-spacing: -0.15px;=
">Zoom.com</a> <br> <a style=3D"color: #2A2B2D; font-size: 10px; font-style=
: normal;font-weight: 400;line-height: 16px;text-decoration:none; letter-sp=
acing: 0.12px;" target=3D"_blank"> 55 Almaden Blvd<br> San Jose, CA 95113</=
a> </td> </tr>
                                        <tr> <td align=3D"center"style=3D"p=
adding: 16px 0 0;font-size:12px;font-weight: 400;line-height:16px;color:#74=
7487;" valign=3D"top"> <a href=3D"tel:1-888-799-9666" style=3D"color: #0D6B=
DE; text-decoration: none; font-size: 14px; font-style: normal;font-weight:=
 590;line-height: 18px; letter-spacing: -0.15px;">+1.888.799.9666</a> <br> =
</td> </tr>
                                        <tr> <td align=3D"center"style=3D"f=
ont-size:12px;font-weight: 400;line-height:16px;color:#747487;" valign=3D"t=
op"> <a style=3D"color:#686F79;margin:0;font-size:10px; font-weight: 400;li=
ne-height: 16px;text-decoration: none; letter-spacing: 0.12px;" target=3D"_=
blank">&copy;2026 Zoom Communications, Inc.</a> <br> </td> </tr>
                                        </tbody>
                                    </table>

                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</body>
</html>

<html xmlns=3D"http://www.w3.org/1999/xhtml">
<head>
    <meta content=3D"text/html; charset=3Dutf-8" http-equiv=3D"Content-Type=
"/>
</head>
<body style=3D"height: 100% !important;width: 100% !important;margin: 0;pad=
ding: 0;">
            <table align=3D"center" border=3D"0" cellpadding=3D"0" cellspac=
ing=3D"0" width=3D"100%" style=3D"padding-top: 16px;">
            <tbody>
                <tr>
                    <td align=3D"center" style=3D"padding-top:16px;padding-=
left: 32px;padding-right: 32px;color:#6e7680;font-size:18px;line-height:22p=
x;font-weight:400" valign=3D"top">
                        <a style=3D"color:#6E7680;text-decoration: none;" t=
arget=3D"_blank">
                            To unsubscribe, [<a href=3D'https://zoom.us/web=
inar/email/3184ad23-db8d-471d-93c5-d6839dac2f92/unsubscribe?email=3DDKTyOUj=
AnjPyaQvNqAAAFgAAAFwNi_KTZ0qdllc5uElvkS_7k_MQlZkKlXo6VE8KUcAmLAd0THpKMDAwMD=
Ax&amp;host=3DDElmGrXFugXvGsDxvAAAFQAAABR5OW4aLX8HKagEK4PzMGJJ6NyJ5r3GVl5mI=
GzsLKbjGcbKLtYwMDAwMDE&amp;language=3Den-US&amp;view=3Dfalse'>Click here</a=
>]
                        </a>
                    </td>
                </tr>
            </tbody>
        </table>
</body>
</html>
--85fddd802d38c7ddee2a37489b5c535de4fc52a89dd212d1110af16b5e6d
Content-Transfer-Encoding: quoted-printable
Content-Type: text/calendar; method=REQUEST;; charset=UTF-8
Mime-Version: 1.0

BEGIN:VCALENDAR
PRODID:-//zoom.us//iCalendar Event//EN
VERSION:2.0
CALSCALE:GREGORIAN
METHOD:REQUEST
BEGIN:VTIMEZONE
TZID:America/New_York
LAST-MODIFIED:20260306T231828Z
TZURL:https://www.tzurl.org/zoneinfo-outlook/America/New_York
X-LIC-LOCATION:America/New_York
BEGIN:DAYLIGHT
TZNAME:EDT
TZOFFSETFROM:-0500
TZOFFSETTO:-0400
DTSTART:19700308T020000
RRULE:FREQ=3DYEARLY;BYMONTH=3D3;BYDAY=3D2SU
END:DAYLIGHT
BEGIN:STANDARD
TZNAME:EST
TZOFFSETFROM:-0400
TZOFFSETTO:-0500
DTSTART:19701101T020000
RRULE:FREQ=3DYEARLY;BYMONTH=3D11;BYDAY=3D1SU
END:STANDARD
END:VTIMEZONE
BEGIN:VEVENT
DTSTAMP:20260313T192227Z
DTSTART;TZID=3DAmerica/New_York:20260313T150000
DTEND;TZID=3DAmerica/New_York:20260313T160000
SUMMARY:[TODAY @ 3 PM]: How AI =E2=80=9CViral Characters=E2=80=9D Are Pullin=
g Millions of Views & Turning Short Videos Into Daily Sales
UID:b97kuj9p68p3gdpj68q38e9jdpin8p35ep07cpr5e8n6mpbidpimobjfe9jg
TZID:America/New_York
DESCRIPTION:Topic: [TODAY @ 3 PM]: How AI =E2=80=9CViral Characters=E2=80=9D=
 Are Pulling Millions of Views & Turning Short Videos Into Daily Sales\nDesc=
ription: Something BIG is about to hit the AI content creation space=E2=80=
=A6\n\nFor the first time ever\, you=E2=80=99re about to discover a powerful=
 system that lets anyone create viral AI character videos in minutes without=
 complicated editing\, animation skills\, or expensive software.\n\nInside t=
his live training\, you=E2=80=99ll see how simple ideas\, scripts\, or image=
s can instantly be transformed into fully animated character videos with voi=
ceovers\, expressions\, and storytelling built in automatically.\n\nThese ch=
aracter-driven videos are dominating social platforms because audiences conn=
ect with characters far more than ordinary content\, which is why creators a=
re generating massive engagement using this format.\n\nDuring this LIVE sess=
ion\, you=E2=80=99ll discover:\n\n=E2=80=A2 How AI characters can instantly =
generate engaging videos for TikTok\, Instagram Reels\, and YouTube Shorts\n=
=E2=80=A2 The simple workflow that transforms ideas\, images\, or scripts in=
to animated viral videos\n=E2=80=A2 How character-based content grabs attent=
ion and keeps viewers watching longer\n=E2=80=A2 The strategy behind viral c=
haracter storytelling that drives shares and engagement\n=E2=80=A2 How begin=
ners are using AI characters to create entertaining\, highly shareable video=
s at scale\n\nYou=E2=80=99ll also see a live demo showing exactly how these =
AI characters can speak\, react\, and tell stories while automatically synci=
ng voice\, expressions\, and scenes.\n\nIf you want to learn how the new wav=
e of AI-powered viral character videos are being created=E2=80=A6\n\nyou won=
=E2=80=99t want to miss this training.\n\n=E2=9A=A0=EF=B8=8F IMPORTANT =E2=
=80=94 Secure Your Reminder Now!\n\nThis is a live training and space is lim=
ited.\n\nTo make sure you don=E2=80=99t miss it:\n\n=E2=9C=85 Click =E2=80=
=9CAdd to Calendar=E2=80=9D below to save the event to your Google / Outlook=
 calendar.\n\nYour device will automatically remind you before we go live.\n=
\nMost people miss live trainings simply because they forget.\n\nDon=E2=80=
=99t be that person.\n\nJoin from PC\, Mac\, iPad\, or Android:\nhttps://zoo=
m.us/w/92287324493?tk=3Dne0YQcPmi-uwaFLv4evBfTr4ZgnhsqCQx4lcvf8lyF8.DQkAAAAV=
fMDRTRZHY2dJbS1rbFFDLWZlQ1otaHdWWDFRAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAA&uuid=3DWN_7OWkX7BxTwuKEaEuvulYxA\n\nPhone one-tap:\n+13462487799\,\,9228=
7324493# US (Houston)\n+13602095623\,\,92287324493# US\n\nJoin via audio:\n+=
1 346 248 7799 US (Houston)\n+1 360 209 5623 US\n+1 386 347 5053 US\n+1 507 =
473 4847 US\n+1 564 217 2000 US\n+1 646 931 3860 US\n+1 669 444 9171 US\n+1 =
669 900 6833 US (San Jose)\n+1 689 278 1000 US\n+1 719 359 4580 US\n+1 929 2=
05 6099 US (New York)\n+1 253 205 0468 US\n+1 253 215 8782 US (Tacoma)\n+1 3=
01 715 8592 US (Washington DC)\n+1 305 224 1968 US\n+1 309 205 3325 US\n+1 3=
12 626 6799 US (Chicago)\nWebinar ID: 922 8732 4493\nInternational numbers a=
vailable: https://zoom.us/u/ac9hEmcTMT\n\n\n
LOCATION:https://zoom.us/w/92287324493?tk=3Dne0YQcPmi-uwaFLv4evBfTr4ZgnhsqCQ=
x4lcvf8lyF8.DQkAAAAVfMDRTRZHY2dJbS1rbFFDLWZlQ1otaHdWWDFRAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAA&uuid=3DWN_7OWkX7BxTwuKEaEuvulYxA
SEQUENCE:1773423967
ORGANIZER;ROLE=3DREQ-PARTICIPANT;CN=3DZoom Webinar:no-reply@zoom.us
ATTENDEE;ROLE=3DREQ-PARTICIPANT;CN=3DFriend:mailto:netdev@vger.kernel.org
BEGIN:VALARM
TRIGGER:-PT10M
ACTION:DISPLAY
DESCRIPTION:Reminder
END:VALARM
END:VEVENT
END:VCALENDAR

--85fddd802d38c7ddee2a37489b5c535de4fc52a89dd212d1110af16b5e6d--

--c55842b844d2dc3795931c859326e06d331fd0f64d9331a2a56fdbf2c73e
Content-Disposition: attachment; filename="invite.ics"
Content-Transfer-Encoding: base64
Content-Type: text/calendar; name="invite.ics"

QkVHSU46VkNBTEVOREFSDQpQUk9ESUQ6LS8vem9vbS51cy8vaUNhbGVuZGFyIEV2ZW50Ly9FTg0K
VkVSU0lPTjoyLjANCkNBTFNDQUxFOkdSRUdPUklBTg0KTUVUSE9EOlJFUVVFU1QNCkJFR0lOOlZU
SU1FWk9ORQ0KVFpJRDpBbWVyaWNhL05ld19Zb3JrDQpMQVNULU1PRElGSUVEOjIwMjYwMzA2VDIz
MTgyOFoNClRaVVJMOmh0dHBzOi8vd3d3LnR6dXJsLm9yZy96b25laW5mby1vdXRsb29rL0FtZXJp
Y2EvTmV3X1lvcmsNClgtTElDLUxPQ0FUSU9OOkFtZXJpY2EvTmV3X1lvcmsNCkJFR0lOOkRBWUxJ
R0hUDQpUWk5BTUU6RURUDQpUWk9GRlNFVEZST006LTA1MDANClRaT0ZGU0VUVE86LTA0MDANCkRU
U1RBUlQ6MTk3MDAzMDhUMDIwMDAwDQpSUlVMRTpGUkVRPVlFQVJMWTtCWU1PTlRIPTM7QllEQVk9
MlNVDQpFTkQ6REFZTElHSFQNCkJFR0lOOlNUQU5EQVJEDQpUWk5BTUU6RVNUDQpUWk9GRlNFVEZS
T006LTA0MDANClRaT0ZGU0VUVE86LTA1MDANCkRUU1RBUlQ6MTk3MDExMDFUMDIwMDAwDQpSUlVM
RTpGUkVRPVlFQVJMWTtCWU1PTlRIPTExO0JZREFZPTFTVQ0KRU5EOlNUQU5EQVJEDQpFTkQ6VlRJ
TUVaT05FDQpCRUdJTjpWRVZFTlQNCkRUU1RBTVA6MjAyNjAzMTNUMTkyMjI3Wg0KRFRTVEFSVDtU
WklEPUFtZXJpY2EvTmV3X1lvcms6MjAyNjAzMTNUMTUwMDAwDQpEVEVORDtUWklEPUFtZXJpY2Ev
TmV3X1lvcms6MjAyNjAzMTNUMTYwMDAwDQpTVU1NQVJZOltUT0RBWSBAIDMgUE1dOiBIb3cgQUkg
4oCcVmlyYWwgQ2hhcmFjdGVyc+KAnSBBcmUgUHVsbGluZyBNaWxsaW9ucyBvZiBWaWV3cyAmIFR1
cm5pbmcgU2hvcnQgVmlkZW9zIEludG8gRGFpbHkgU2FsZXMNClVJRDpiOTdrdWo5cDY4cDNnZHBq
NjhxMzhlOWpkcGluOHAzNWVwMDdjcHI1ZThuNm1wYmlkcGltb2JqZmU5amcNClRaSUQ6QW1lcmlj
YS9OZXdfWW9yaw0KREVTQ1JJUFRJT046VG9waWM6IFtUT0RBWSBAIDMgUE1dOiBIb3cgQUkg4oCc
VmlyYWwgQ2hhcmFjdGVyc+KAnSBBcmUgUHVsbGluZyBNaWxsaW9ucyBvZiBWaWV3cyAmIFR1cm5p
bmcgU2hvcnQgVmlkZW9zIEludG8gRGFpbHkgU2FsZXNcbkRlc2NyaXB0aW9uOiBTb21ldGhpbmcg
QklHIGlzIGFib3V0IHRvIGhpdCB0aGUgQUkgY29udGVudCBjcmVhdGlvbiBzcGFjZeKAplxuXG5G
b3IgdGhlIGZpcnN0IHRpbWUgZXZlclwsIHlvdeKAmXJlIGFib3V0IHRvIGRpc2NvdmVyIGEgcG93
ZXJmdWwgc3lzdGVtIHRoYXQgbGV0cyBhbnlvbmUgY3JlYXRlIHZpcmFsIEFJIGNoYXJhY3RlciB2
aWRlb3MgaW4gbWludXRlcyB3aXRob3V0IGNvbXBsaWNhdGVkIGVkaXRpbmdcLCBhbmltYXRpb24g
c2tpbGxzXCwgb3IgZXhwZW5zaXZlIHNvZnR3YXJlLlxuXG5JbnNpZGUgdGhpcyBsaXZlIHRyYWlu
aW5nXCwgeW914oCZbGwgc2VlIGhvdyBzaW1wbGUgaWRlYXNcLCBzY3JpcHRzXCwgb3IgaW1hZ2Vz
IGNhbiBpbnN0YW50bHkgYmUgdHJhbnNmb3JtZWQgaW50byBmdWxseSBhbmltYXRlZCBjaGFyYWN0
ZXIgdmlkZW9zIHdpdGggdm9pY2VvdmVyc1wsIGV4cHJlc3Npb25zXCwgYW5kIHN0b3J5dGVsbGlu
ZyBidWlsdCBpbiBhdXRvbWF0aWNhbGx5LlxuXG5UaGVzZSBjaGFyYWN0ZXItZHJpdmVuIHZpZGVv
cyBhcmUgZG9taW5hdGluZyBzb2NpYWwgcGxhdGZvcm1zIGJlY2F1c2UgYXVkaWVuY2VzIGNvbm5l
Y3Qgd2l0aCBjaGFyYWN0ZXJzIGZhciBtb3JlIHRoYW4gb3JkaW5hcnkgY29udGVudFwsIHdoaWNo
IGlzIHdoeSBjcmVhdG9ycyBhcmUgZ2VuZXJhdGluZyBtYXNzaXZlIGVuZ2FnZW1lbnQgdXNpbmcg
dGhpcyBmb3JtYXQuXG5cbkR1cmluZyB0aGlzIExJVkUgc2Vzc2lvblwsIHlvdeKAmWxsIGRpc2Nv
dmVyOlxuXG7igKIgSG93IEFJIGNoYXJhY3RlcnMgY2FuIGluc3RhbnRseSBnZW5lcmF0ZSBlbmdh
Z2luZyB2aWRlb3MgZm9yIFRpa1Rva1wsIEluc3RhZ3JhbSBSZWVsc1wsIGFuZCBZb3VUdWJlIFNo
b3J0c1xu4oCiIFRoZSBzaW1wbGUgd29ya2Zsb3cgdGhhdCB0cmFuc2Zvcm1zIGlkZWFzXCwgaW1h
Z2VzXCwgb3Igc2NyaXB0cyBpbnRvIGFuaW1hdGVkIHZpcmFsIHZpZGVvc1xu4oCiIEhvdyBjaGFy
YWN0ZXItYmFzZWQgY29udGVudCBncmFicyBhdHRlbnRpb24gYW5kIGtlZXBzIHZpZXdlcnMgd2F0
Y2hpbmcgbG9uZ2VyXG7igKIgVGhlIHN0cmF0ZWd5IGJlaGluZCB2aXJhbCBjaGFyYWN0ZXIgc3Rv
cnl0ZWxsaW5nIHRoYXQgZHJpdmVzIHNoYXJlcyBhbmQgZW5nYWdlbWVudFxu4oCiIEhvdyBiZWdp
bm5lcnMgYXJlIHVzaW5nIEFJIGNoYXJhY3RlcnMgdG8gY3JlYXRlIGVudGVydGFpbmluZ1wsIGhp
Z2hseSBzaGFyZWFibGUgdmlkZW9zIGF0IHNjYWxlXG5cbllvdeKAmWxsIGFsc28gc2VlIGEgbGl2
ZSBkZW1vIHNob3dpbmcgZXhhY3RseSBob3cgdGhlc2UgQUkgY2hhcmFjdGVycyBjYW4gc3BlYWtc
LCByZWFjdFwsIGFuZCB0ZWxsIHN0b3JpZXMgd2hpbGUgYXV0b21hdGljYWxseSBzeW5jaW5nIHZv
aWNlXCwgZXhwcmVzc2lvbnNcLCBhbmQgc2NlbmVzLlxuXG5JZiB5b3Ugd2FudCB0byBsZWFybiBo
b3cgdGhlIG5ldyB3YXZlIG9mIEFJLXBvd2VyZWQgdmlyYWwgY2hhcmFjdGVyIHZpZGVvcyBhcmUg
YmVpbmcgY3JlYXRlZOKAplxuXG55b3Ugd29u4oCZdCB3YW50IHRvIG1pc3MgdGhpcyB0cmFpbmlu
Zy5cblxu4pqg77iPIElNUE9SVEFOVCDigJQgU2VjdXJlIFlvdXIgUmVtaW5kZXIgTm93IVxuXG5U
aGlzIGlzIGEgbGl2ZSB0cmFpbmluZyBhbmQgc3BhY2UgaXMgbGltaXRlZC5cblxuVG8gbWFrZSBz
dXJlIHlvdSBkb27igJl0IG1pc3MgaXQ6XG5cbuKchSBDbGljayDigJxBZGQgdG8gQ2FsZW5kYXLi
gJ0gYmVsb3cgdG8gc2F2ZSB0aGUgZXZlbnQgdG8geW91ciBHb29nbGUgLyBPdXRsb29rIGNhbGVu
ZGFyLlxuXG5Zb3VyIGRldmljZSB3aWxsIGF1dG9tYXRpY2FsbHkgcmVtaW5kIHlvdSBiZWZvcmUg
d2UgZ28gbGl2ZS5cblxuTW9zdCBwZW9wbGUgbWlzcyBsaXZlIHRyYWluaW5ncyBzaW1wbHkgYmVj
YXVzZSB0aGV5IGZvcmdldC5cblxuRG9u4oCZdCBiZSB0aGF0IHBlcnNvbi5cblxuSm9pbiBmcm9t
IFBDXCwgTWFjXCwgaVBhZFwsIG9yIEFuZHJvaWQ6XG5odHRwczovL3pvb20udXMvdy85MjI4NzMy
NDQ5Mz90az1uZTBZUWNQbWktdXdhRkx2NGV2QmZUcjRaZ25oc3FDUXg0bGN2ZjhseUY4LkRRa0FB
QUFWZk1EUlRSWkhZMmRKYlMxcmJGRkRMV1psUTFvdGFIZFdXREZSQUFBQUFBQUFBQUFBQUFBQUFB
QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQSZ1dWlkPVdOXzdPV2tYN0J4VHd1S0VhRXV2dWxZeEFc
blxuUGhvbmUgb25lLXRhcDpcbisxMzQ2MjQ4Nzc5OVwsXCw5MjI4NzMyNDQ5MyMgVVMgKEhvdXN0
b24pXG4rMTM2MDIwOTU2MjNcLFwsOTIyODczMjQ0OTMjIFVTXG5cbkpvaW4gdmlhIGF1ZGlvOlxu
KzEgMzQ2IDI0OCA3Nzk5IFVTIChIb3VzdG9uKVxuKzEgMzYwIDIwOSA1NjIzIFVTXG4rMSAzODYg
MzQ3IDUwNTMgVVNcbisxIDUwNyA0NzMgNDg0NyBVU1xuKzEgNTY0IDIxNyAyMDAwIFVTXG4rMSA2
NDYgOTMxIDM4NjAgVVNcbisxIDY2OSA0NDQgOTE3MSBVU1xuKzEgNjY5IDkwMCA2ODMzIFVTIChT
YW4gSm9zZSlcbisxIDY4OSAyNzggMTAwMCBVU1xuKzEgNzE5IDM1OSA0NTgwIFVTXG4rMSA5Mjkg
MjA1IDYwOTkgVVMgKE5ldyBZb3JrKVxuKzEgMjUzIDIwNSAwNDY4IFVTXG4rMSAyNTMgMjE1IDg3
ODIgVVMgKFRhY29tYSlcbisxIDMwMSA3MTUgODU5MiBVUyAoV2FzaGluZ3RvbiBEQylcbisxIDMw
NSAyMjQgMTk2OCBVU1xuKzEgMzA5IDIwNSAzMzI1IFVTXG4rMSAzMTIgNjI2IDY3OTkgVVMgKENo
aWNhZ28pXG5XZWJpbmFyIElEOiA5MjIgODczMiA0NDkzXG5JbnRlcm5hdGlvbmFsIG51bWJlcnMg
YXZhaWxhYmxlOiBodHRwczovL3pvb20udXMvdS9hYzloRW1jVE1UXG5cblxuDQpMT0NBVElPTjpo
dHRwczovL3pvb20udXMvdy85MjI4NzMyNDQ5Mz90az1uZTBZUWNQbWktdXdhRkx2NGV2QmZUcjRa
Z25oc3FDUXg0bGN2ZjhseUY4LkRRa0FBQUFWZk1EUlRSWkhZMmRKYlMxcmJGRkRMV1psUTFvdGFI
ZFdXREZSQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQSZ1dWlkPVdO
XzdPV2tYN0J4VHd1S0VhRXV2dWxZeEENClNFUVVFTkNFOjE3NzM0MjM5NjcNCk9SR0FOSVpFUjtS
T0xFPVJFUS1QQVJUSUNJUEFOVDtDTj1ab29tIFdlYmluYXI6bm8tcmVwbHlAem9vbS51cw0KQVRU
RU5ERUU7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7Q049RnJpZW5kOm1haWx0bzpuZXRkZXZAdmdlci5r
ZXJuZWwub3JnDQpCRUdJTjpWQUxBUk0NClRSSUdHRVI6LVBUMTBNDQpBQ1RJT046RElTUExBWQ0K
REVTQ1JJUFRJT046UmVtaW5kZXINCkVORDpWQUxBUk0NCkVORDpWRVZFTlQNCkVORDpWQ0FMRU5E
QVINCg==
--c55842b844d2dc3795931c859326e06d331fd0f64d9331a2a56fdbf2c73e--

