Return-Path: <netdev+bounces-272922-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mE6vBWU5yWmKwAUAu9opvQ
	(envelope-from <netdev+bounces-272922-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 16:38:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B29352739
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 16:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F0AB301ABA6
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 14:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7C5375F67;
	Sun, 29 Mar 2026 14:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ykcIg/Ni";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Oce4hFIg"
X-Original-To: netdev@vger.kernel.org
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24764175A77;
	Sun, 29 Mar 2026 14:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774794936; cv=none; b=EMe33bh36RtU+U6Y+FH/pd2GLnD5+Dy7m8gCVQSjmAgEYIUKWDWk3uooqavO3i2rMkI3Ssbtz+uCTk9Nvre7phzU21jvbfnI7Czp2Dr/OCVCPeal16RhsvmG2CgMSFb0RjTB5v8/1IqL7CQgAppVf+akTz0JFmoznYZfyi5SsP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774794936; c=relaxed/simple;
	bh=R9AYP534H4yxPtjSPAG6yLFF2Kpi6mkRfxJEuVcZ5r8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RnAzj9+O8OwpDjZI6TWubOrRvp1mfRfHqPvxc86FUT7A4ug4xylRBeM+ddvu2mrAkkmwGeHGcNngnlZDenv09IjfU6sAvY5JXV6TcAQUS933luGwhWCQJxR3aunWn+b6lpOT41SGCHMGWyo+Yjy+Elv/55MplLdJNbjDI52FAnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ykcIg/Ni; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Oce4hFIg; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4fkH3m3cwpzB02y;
	Sun, 29 Mar 2026 16:35:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1774794932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cA6uD+0oCzRov5b9jthEp24abkpw//foWgsmdeyirZw=;
	b=ykcIg/NibXxMTRWOd05/d4dur7zGN4hSvoTbtH6PotAm+m3/KuACFncVno+yYfQluLd1kR
	4PxaReYjiA2F2mj1qR/xMVBxYbj2wGK14++eTUNc4Cxm7JbL23rIWg9WxcLw9ehXrSTnQE
	Wias0D3KWPn0K0uix2j1/oQgPDRjqeEynoDMdd44Scdpc6/RRQsUpDMI7m3FrPF6c3nQux
	XyyLtwiVdtQqocA13qrN77Pg5KCNLwXZwvJClTQelKZ8K63ItWYEkuJTzM+6CrAOr9BNnl
	ALuE4yyHCv441zYCFuBbz7Zx4ssKf/9KQ2MvMMfdM2lpaPl1BemiF54SfHDMlQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=Oce4hFIg;
	spf=pass (outgoing_mbo_mout: domain of mashiro.chen@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=mashiro.chen@mailbox.org
From: Mashiro Chen <mashiro.chen@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1774794930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cA6uD+0oCzRov5b9jthEp24abkpw//foWgsmdeyirZw=;
	b=Oce4hFIgBdU6z0eMtfyKFWvCs77AWDuEi+J9Q87yNjLBrA4CzFwFEoJFfEv76sLeiBzcua
	Yyp65TxlwWOme/M0CCZT5LDtnAkkyl/AK/rXtTh45ZlM80XCDgAAKs5yvH0t4Kv0SZmiU7
	O0TPUDb2PxfdZ1e/JBwsym7Ivh4lQt8UChuSnI+Jh+EFP0ITyU02gTsLQ87Eoks/PE8xfd
	L6TCTjQKTZz4JQS0Kg6jWWAq3D0jbs3TfzMTlSwnKPVAg2ujQUhiCx6pSBZhDRj+UKhCSz
	2F2AmNgMq1LsXQ0+y1nRHSoUdoZKz1ZB8u27X0W2YtNulLSLHsAGtrsHnmuOrA==
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mashiro Chen <mashiro.chen@mailbox.org>
Subject: [PATCH 5/5] hamradio: mkiss: cleanup indentation and coding style
Date: Sun, 29 Mar 2026 22:34:08 +0800
Message-ID: <20260329143408.747197-6-mashiro.chen@mailbox.org>
In-Reply-To: <20260329143408.747197-1-mashiro.chen@mailbox.org>
References: <20260329143408.747197-1-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: r4bj1y3pjkpg8d8dmq1f1o1wsz9ofcn7
X-MBO-RS-ID: 2ca30c21dee261337ac
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272922-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mashiro.chen@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:dkim,mailbox.org:email,mailbox.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 84B29352739
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Clean up the remaining coding style issues in mkiss.c
to follow the Linux Kernel coding standards. The
primary changes include fixing indentation and
alignment issues by using tabs instead of spaces where
possible. Additionally, add missing spaces after
keywords and blank lines after variable declarations.
Block comment formatting is also adjusted to use a
separate line for the trailing delimiter.

Signed-off-by: Mashiro Chen <mashiro.chen@mailbox.org>
---
 drivers/net/hamradio/mkiss.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/net/hamradio/mkiss.c b/drivers/net/hamradio/mkiss.c
index 75b9bd2e1..8939582ac 100644
--- a/drivers/net/hamradio/mkiss.c
+++ b/drivers/net/hamradio/mkiss.c
@@ -64,7 +64,7 @@ struct mkiss {
 #define AXF_OUTWAIT	4		/* is outpacket was flag	*/
 
 	int		mode;
-        int		crcmode;	/* MW: for FlexNet, SMACK etc.  */
+	int		crcmode;	/* MW: for FlexNet, SMACK etc.  */
 	int		crcauto;	/* CRC auto mode */
 
 #define CRC_MODE_NONE		0
@@ -439,27 +439,30 @@ static void ax_encaps(struct net_device *dev, unsigned char *icp, int len)
 		/* Configuration Command (kissparms(1).
 		 * Protocol spec says: never append CRC.
 		 * This fixes a very old bug in the linux
-		 * kiss driver. -- dl9sau */
+		 * kiss driver. -- dl9sau
+		 */
 		switch (*p & 0xff) {
 		case 0x85:
 			/* command from userspace especially for us,
-			 * not for delivery to the tnc */
+			 * not for delivery to the tnc
+			 */
 			if (len > 1) {
 				int cmd = (p[1] & 0xff);
-				switch(cmd) {
+
+				switch (cmd) {
 				case 3:
-				  ax->crcmode = CRC_MODE_SMACK;
-				  break;
+					ax->crcmode = CRC_MODE_SMACK;
+					break;
 				case 2:
-				  ax->crcmode = CRC_MODE_FLEX;
-				  break;
+					ax->crcmode = CRC_MODE_FLEX;
+					break;
 				case 1:
-				  ax->crcmode = CRC_MODE_NONE;
-				  break;
+					ax->crcmode = CRC_MODE_NONE;
+					break;
 				case 0:
 				default:
-				  ax->crcmode = CRC_MODE_SMACK_TEST;
-				  cmd = 0;
+					ax->crcmode = CRC_MODE_SMACK_TEST;
+					cmd = 0;
 				}
 				ax->crcauto = (cmd ? 0 : 1);
 				netdev_info(ax->dev, "crc mode set to %d\n", cmd);
@@ -473,6 +476,7 @@ static void ax_encaps(struct net_device *dev, unsigned char *icp, int len)
 		}
 	} else {
 		unsigned short crc;
+
 		switch (ax->crcmode) {
 		case CRC_MODE_SMACK_TEST:
 			ax->crcmode  = CRC_MODE_FLEX_TEST;
@@ -812,7 +816,7 @@ static int mkiss_ioctl(struct tty_struct *tty, unsigned int cmd,
 	switch (cmd) {
 	case SIOCGIFNAME:
 		err = copy_to_user((void __user *) arg, ax->dev->name,
-		                   strlen(ax->dev->name) + 1) ? -EFAULT : 0;
+				   strlen(ax->dev->name) + 1) ? -EFAULT : 0;
 		break;
 
 	case SIOCGIFENCAP:
@@ -828,7 +832,7 @@ static int mkiss_ioctl(struct tty_struct *tty, unsigned int cmd,
 		ax->mode = tmp;
 		dev->addr_len        = AX25_ADDR_LEN;
 		dev->hard_header_len = AX25_KISS_HEADER_LEN +
-		                       AX25_MAX_HEADER_LEN + 3;
+				       AX25_MAX_HEADER_LEN + 3;
 		dev->type            = ARPHRD_AX25;
 
 		err = 0;
@@ -838,7 +842,7 @@ static int mkiss_ioctl(struct tty_struct *tty, unsigned int cmd,
 		char addr[AX25_ADDR_LEN];
 
 		if (copy_from_user(&addr,
-		                   (void __user *) arg, AX25_ADDR_LEN)) {
+				   (void __user *)arg, AX25_ADDR_LEN)) {
 			err = -EFAULT;
 			break;
 		}
-- 
2.53.0


