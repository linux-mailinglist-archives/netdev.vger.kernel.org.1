Return-Path: <netdev+bounces-294021-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFgeIilqHmqGjAkAu9opvQ
	(envelope-from <netdev+bounces-294021-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 07:29:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 045556288CD
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 07:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE6DC307E92E
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 05:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD5D3016E3;
	Tue,  2 Jun 2026 05:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="TeoJRmQ6"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7AD3090C1
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 05:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780378018; cv=none; b=PfJB+LVkP/wL8vB+rVyeiQfkwZKuTOR98nJEU17txmZWMfi6I0uGKbx2ANtv9kgVc96WQdv1cv8BMaADNyqyghXTTw3ysEk5jgsxteihoi48j2mybdSAhoaKa/OKFCphAgnrh763NJVcKs4IMXAWZHp5SO7PjUTwE+ZgJaSb5Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780378018; c=relaxed/simple;
	bh=kSWUU44FfZTN9vbCegeN14XRV/XoR63O/ImgDAhptUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UtADnIgA6wcxx3enJY2zrATrUrG5PLPrRMiFBz+AkMMWeDtzdvr/drGMv8riQ97uzjDpvDCk3T1w7qWvsNfl5Kz9iU+o1G8Hm4sxyvAGCtPlbpFAqyyAhnjNWV/5nQuzdLhhLB5BNZaVh4AJKmoOqYr+8VT4aXUH4dtppd+w+SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=TeoJRmQ6; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780378013; x=1780982813;
	i=markus.stockhausen@gmx.de;
	bh=QY3j2Yw5N5rEWm8pGmgPffZ5040SQDLTypXD6BJ7Cq4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TeoJRmQ6/x7KYxy1KYm1D+ajOxBysLEiIXLXxTCAMpp2y06Xw1w3kPoyVrxcPPvJ
	 3d54YGHNFsDpSptKbmmjAm128w2DRGiVcEA532TbNiTATA2LVxUmRns+iKg7qv77k
	 r3mHoZ0pdgWjN59vHodFe23b/Wwav/Q0vFnvL327xrfl0twV93/QsnzccyzXCqBX7
	 2QGlA+MkUms3JYwlaNGlOBv8zbTz5RqSM4QlQoYxpjLD+/JlRJWHQmA7UNm0TUvBZ
	 q+Qq83Uir+iNKyxqnFVmfPEENPt/FH2Rzmwwprh3tHPIG6+/kFadS20lXHAoibJGI
	 5+7pCMVU7iUwYH8sQA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrhUK-1x6uC12jP2-00laGT; Tue, 02
 Jun 2026 07:26:53 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org,
	mensi@mensi.ch
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next 5/8] net: mdio: realtek-rtl9300: adapt spaces for defines
Date: Tue,  2 Jun 2026 07:26:37 +0200
Message-ID: <20260602052640.93083-6-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602052640.93083-1-markus.stockhausen@gmx.de>
References: <20260602052640.93083-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rvwGaiK4bgzkj41wYMO+7bvQgtwjrqigdoHfwUpBYEAtzrq3+gu
 S5T/P2HyKrv+MUaCkBUQYHYhNx+XLsb181mEQNWXGK/e1g8hUwMOP38xLjtAmTMDqRTSkJX
 S+omREQO50s9LYCXXXMYwZjLchxe+hoVxcOiBwmSxw9v4nVoH9qqyO4UOv5y+IwHJpFNG4M
 GKl50PTNMd5JtCvetkosQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ks5gyhyzRug=;2fo0gVl459+68L1wXvZ+D5tICRM
 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
 S4s7nUpes3I+9gvOVetjJisIR83WPE6ylyIKSdK
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294021-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org,mensi.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmx.de];
	DKIM_TRACE(0.00)[gmx.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Queue-Id: 045556288CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Register and fields will get longer prefixes in the future.
Keep define blocks clean and readable and add another tab.
Additionally clean up some multi-space separators with tabs.

Just cosmetics, no functional change.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 56 ++++++++++++-------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index cec2afed5b6f..74ea2550e652 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -51,34 +51,34 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
=20
-#define RTL9300_NUM_BUSES		4
-#define RTL9300_NUM_PAGES		4096
-#define RTL9300_NUM_PORTS		28
-#define SMI_GLB_CTRL			0xca00
-#define   GLB_CTRL_INTF_SEL(intf)	BIT(16 + (intf))
-#define SMI_PORT0_15_POLLING_SEL	0xca08
-#define RTL9300_SMI_ACCESS_PHY_CTRL_0	0xcb70
-#define RTL9300_SMI_ACCESS_PHY_CTRL_1	0xcb74
-#define   PHY_CTRL_REG_ADDR		GENMASK(24, 20)
-#define   PHY_CTRL_PARK_PAGE		GENMASK(19, 15)
-#define   PHY_CTRL_MAIN_PAGE		GENMASK(14, 3)
-#define   PHY_CTRL_WRITE		BIT(2)
-#define   PHY_CTRL_READ			0
-#define   PHY_CTRL_TYPE_C45		BIT(1)
-#define   PHY_CTRL_TYPE_C22		0
-#define   PHY_CTRL_CMD			BIT(0)
-#define   PHY_CTRL_FAIL			BIT(25)
-#define RTL9300_SMI_ACCESS_PHY_CTRL_2	0xcb78
-#define   PHY_CTRL_INDATA		GENMASK(31, 16)
-#define   PHY_CTRL_DATA			GENMASK(15, 0)
-#define RTL9300_SMI_ACCESS_PHY_CTRL_3	0xcb7c
-#define   PHY_CTRL_MMD_DEVAD		GENMASK(20, 16)
-#define   PHY_CTRL_MMD_REG		GENMASK(15, 0)
-#define SMI_PORT0_5_ADDR_CTRL		0xcb80
-
-#define MAX_PORTS       28
-#define MAX_SMI_BUSSES  4
-#define RAW_PAGE(priv)	((priv)->info->num_pages - 1)
+#define RTL9300_NUM_BUSES			4
+#define RTL9300_NUM_PAGES			4096
+#define RTL9300_NUM_PORTS			28
+#define SMI_GLB_CTRL				0xca00
+#define   GLB_CTRL_INTF_SEL(intf)		BIT(16 + (intf))
+#define SMI_PORT0_15_POLLING_SEL		0xca08
+#define RTL9300_SMI_ACCESS_PHY_CTRL_0		0xcb70
+#define RTL9300_SMI_ACCESS_PHY_CTRL_1		0xcb74
+#define   PHY_CTRL_REG_ADDR			GENMASK(24, 20)
+#define   PHY_CTRL_PARK_PAGE			GENMASK(19, 15)
+#define   PHY_CTRL_MAIN_PAGE			GENMASK(14, 3)
+#define   PHY_CTRL_WRITE			BIT(2)
+#define   PHY_CTRL_READ				0
+#define   PHY_CTRL_TYPE_C45			BIT(1)
+#define   PHY_CTRL_TYPE_C22			0
+#define   PHY_CTRL_CMD				BIT(0)
+#define   PHY_CTRL_FAIL				BIT(25)
+#define RTL9300_SMI_ACCESS_PHY_CTRL_2		0xcb78
+#define   PHY_CTRL_INDATA			GENMASK(31, 16)
+#define   PHY_CTRL_DATA				GENMASK(15, 0)
+#define RTL9300_SMI_ACCESS_PHY_CTRL_3		0xcb7c
+#define   PHY_CTRL_MMD_DEVAD			GENMASK(20, 16)
+#define   PHY_CTRL_MMD_REG			GENMASK(15, 0)
+#define SMI_PORT0_5_ADDR_CTRL			0xcb80
+
+#define MAX_PORTS				28
+#define MAX_SMI_BUSSES				4
+#define RAW_PAGE(priv)				((priv)->info->num_pages - 1)
=20
=20
 struct otto_emdio_cmd_regs {
=2D-=20
2.54.0


