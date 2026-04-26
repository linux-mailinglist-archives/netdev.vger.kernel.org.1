Return-Path: <netdev+bounces-281197-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id q8YaM4mQ7mkDvgAAu9opvQ
	(envelope-from <netdev+bounces-281197-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 00:24:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E62746B5E9
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 00:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E9833009CEC
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 22:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5743330C62E;
	Sun, 26 Apr 2026 22:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="X69MiKwp"
X-Original-To: netdev@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800E330BBB9
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 22:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777242246; cv=none; b=tbes9B11gxVHgT30hVlXP8uJkmR2pBbo/gDj8p0YEUgU04duvb8UHpFfI5jGAu1u8p8FbTRDqDJlqVGxvnOQMfgzxiuqjLuXUmrxJ6Uh11E1BFN02X2eUPFxTrUNIkJwBZij9iDbmHrHsSkkb1CtevrKIWDxd7kW6OT3CL+adCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777242246; c=relaxed/simple;
	bh=duvRwRyeAinnB/xvun0uxF9j9V4bN/P78/1rb+3Veq0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Td7C/Os5RPZ5H7Zumb5kzgbbVxIOBeBAXLnoxUaskIlizHHo0ObjsGTPT2vqU5mpDQ7X3TgSpSboni4E+AYJXltwILji4WokqiWlFTGqdwQjnhzKfuzkbV/2Pn2pbSHMnk/v6OMgxAIgsUIXeJaRRRg0W4gS2zgp8PX6Mf5DAJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=X69MiKwp; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 7590 invoked from network); 27 Apr 2026 00:24:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1777242242; bh=yi7xlcKtlsDvAwwYvHTnNAfEA4EJ74uDBLc0UVQJAkI=;
          h=From:To:Subject;
          b=X69MiKwpAkE0LuJEBQH+897iQGplRR5b6BupD08zXikYew9hBR17kKujN/uF0i8wZ
           PnCK4aZcLuTruHyqHGQ4DG1kEIylKJ/tqVEXLX6RHNzPMA84VzYyU1bUZ8mcb+51I9
           oRptr1YgoKoAxY9OUmGU6B9loRzrt8EtsPOa6IdkqGgKxtuspmXpFEZi4CECrnhYSY
           fItOSrluUvmgC82trUy0aPCIclgfY+I1CD9+o+FFgPu9d0CjllOF9WEWOBSxxw4SeB
           aCpUkZ9AOC/CQJJRc9QVzezR3AnGLhiDGjGrtWLp4qzFItjlm+wlUQnXE9MycE955A
           g6XjoKBZsYB+A==
Received: from 83.24.138.167.ipv4.supernova.orange.pl (HELO abajkowski.lan) (olek2@wp.pl@[83.24.138.167])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <andrew@lunn.ch>; 27 Apr 2026 00:24:02 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	daniel@makrotopia.org,
	vladimir.oltean@nxp.com,
	michael@fossekall.de,
	olek2@wp.pl,
	ih@simonwunderlich.de,
	rmk+kernel@armlinux.org.uk,
	marek.vasut@mailbox.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: phy: realtek: replace magic number with register bit macros
Date: Mon, 27 Apr 2026 00:23:44 +0200
Message-ID: <20260426222359.3443278-1-olek2@wp.pl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: 37bdd7c5aaae4d1e559689eec61f739b
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000003 [AcCc]                               
X-Rspamd-Queue-Id: 1E62746B5E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,makrotopia.org,nxp.com,fossekall.de,wp.pl,simonwunderlich.de,mailbox.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281197-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[wp.pl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olek2@wp.pl,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[wp.pl:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wp.pl:email,wp.pl:dkim,wp.pl:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Replace magic number with register bit macros. The description of the
RTL8211B interrupt register is obtained from the datasheet.

1. RTL8211B(L) Rev. 1.5 Datasheet
Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 drivers/net/phy/realtek/realtek_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 79c867ef64da..9f2a0bc03728 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -40,7 +40,12 @@
 						 RTL8201F_ISR_LINK)
 
 #define RTL821x_INER				0x12
-#define RTL8211B_INER_INIT			0x6400
+#define RTL8211B_INER_SPEED			BIT(14)
+#define RTL8211B_INER_DUPLEX			BIT(13)
+#define RTL8211B_INER_LINK_STATUS		BIT(10)
+#define RTL8211B_INER_INIT			(RTL8211B_INER_SPEED | \
+						 RTL8211B_INER_DUPLEX | \
+						 RTL8211B_INER_LINK_STATUS)
 #define RTL8211E_INER_LINK_STATUS		BIT(10)
 #define RTL8211F_INER_PME			BIT(7)
 #define RTL8211F_INER_LINK_STATUS		BIT(4)
-- 
2.53.0


