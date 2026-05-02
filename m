Return-Path: <netdev+bounces-283390-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEKjI/LD9WnqOgIAu9opvQ
	(envelope-from <netdev+bounces-283390-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 11:29:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E69BC4B185B
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 11:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 010E43018769
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 09:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A10D30EF90;
	Sat,  2 May 2026 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="AgKeYueN"
X-Original-To: netdev@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B22F2FDC20
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777714153; cv=none; b=QOuY6KOzKHwRPjnuubSJea+iynO0Qc6wfgUuf3m46MOMvaegsm9Pn4ZPPZ6l/IPe69jjQUIbZMp5YFfghSnaPTLDislaJC37hhI8N/FTYqYQbC/amrGa3iBATgrgJ+cyKS0IGI+Ma6hrWRZXDbjtepjSQBvE/QRVgO4OtqSYcHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777714153; c=relaxed/simple;
	bh=JP1gUyFDekV1UyjLr+SAe+PehfO7figE2sb7aL4ff8A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=fxHa6pJjVsAeTXfCU1UYMxYGbXGwznJZ0OCqyrT8qo2yvC+JH/UPmJsUAyw0L/AXqjP7uyj4v75Opg+o/qVVka2rue8UIWl20iBT1vUExza+QPzPHyTlrGumwpR4PREi/n+dCaU3JrECzPlrs4CPVo3N32wFTEDN7Wuof5Nx3NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=AgKeYueN; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 2638 invoked from network); 2 May 2026 11:29:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1777714140; bh=PUcYAMODLw18bjTr+Xo/NHy0u5FhjCUxRTIwqjLUArg=;
          h=From:To:Subject;
          b=AgKeYueNTTB2aKgeR85MCjFtcNNBYfR7EXK4qVkM0v8ZpZnIeNyxm7why0dvAO2PK
           7UuJTljStFGxnVbcU02KP90hKiP9XL6n/2RL4EQtItBAmyzeNyBSOnXY23Lfjj/Dfv
           0eS5Y0hODEHAY0FzdGvIOnJ2LHoTSQ6+swQ2y1CqF5/n07ooZSlbWxHL1S+XQ2kA7N
           muMtc0XBpB0y1UXXL0DuCxZSB2u3EDWYjXCFPXIaZZ9UeExCTPcGDNc21fy8fcjB/S
           URI5/YLpkLMYchjGwqE28Y689c2n68YPcVagtbo+/zO5oqGXd8xb6gRH3fr5f2KFNC
           e65wsVTpxy7Wg==
Received: from 83.5.11.80.ipv4.supernova.orange.pl (HELO abajkowski.home) (olek2@wp.pl@[83.5.11.80])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <andrew@lunn.ch>; 2 May 2026 11:28:59 +0200
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
Date: Sat,  2 May 2026 11:28:47 +0200
Message-ID: <20260502092857.156831-1-olek2@wp.pl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: 602144fcf0b30c932f654a01782f0688
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [0WMc]                               
X-Rspamd-Queue-Id: E69BC4B185B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,makrotopia.org,nxp.com,fossekall.de,wp.pl,simonwunderlich.de,mailbox.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283390-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Replace magic number with register bit macros. The description of the
RTL8211B interrupt register is obtained from publicly available
datasheet[1].

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


