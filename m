Return-Path: <netdev+bounces-305752-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rBB0EbklTmpuEAIAu9opvQ
	(envelope-from <netdev+bounces-305752-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 12:26:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B47D724491
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 12:26:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="hy/EWPQW";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305752-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305752-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0DC773020B7C
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 10:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522193FBEC2;
	Wed,  8 Jul 2026 10:24:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371EE3EA95A
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 10:23:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783506242; cv=none; b=Oe+DjE8V/M1IiYCGDY2L27DE7kWaKDo+VDgHNSG6J3zrfvGrbPGi4mCQqTZekeDzoLH8dPv9BsQZBhiHz4y+vfy4ZINIuC1ffbKFpCFCSvWdfIgDM+KYK8mOSR6bA8caaHk8lCVNz38fCM21L4cyK+NI54CUa8e3hAfM/43bwf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783506242; c=relaxed/simple;
	bh=15E+48iYPy7Fw+D1PSiZ/ShqOWbSu0/GPoKTFYVxnwY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M3Q+TCc1r4kM03yDBzdb7Run/MbVQh+owpZefP0hPMs8i3Yd8HqTJdGsJUZy9NP9E/VLLeTBeLAic9TXYpivhOAZUSotWV68dlADf0MvzaHgDSarx3XfBRNuSOkS7DDQRjmgx5nLzT0fI4c9PqG9ctsPcqkpwN1fvQ0F12YVKo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hy/EWPQW; arc=none smtp.client-ip=209.85.221.43
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4720d22c94aso476039f8f.1
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 03:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783506236; x=1784111036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ER7MUt+NKPquufARTcXhEHjCrBjJvnX8oO9uSMDLvh0=;
        b=hy/EWPQWJRj7nhlqbh7TDu7NdhjPNtIVe4OcekPK8sztcH+DIeSCBIXsc8mSLoIXhF
         9hTGOc/9X2TEixvK8LkS+fCoQ/Giy0gWil9NReAyQeQtRSdYQnLA0qIPjIR2K7btCut8
         D+QnGxoZuboY96u85sqlQt5rHH6FjycZd4/Iqchbal2KlWPz5FKbAOiCg5IF2fqwx43F
         t6115y7dio0/g/MNwAqkHAfTHe5LFeae5w/lj3KJyg6SXTvtNON5hoMHOuXQPO6nAMM4
         SrDO8zUFc4kvJWQTY14cA8Mg9H5AqsQjzL6B8fuLVZR3FdT7Z8bIQjLqCzkpN7WTNWkk
         6C1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783506236; x=1784111036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ER7MUt+NKPquufARTcXhEHjCrBjJvnX8oO9uSMDLvh0=;
        b=P1BcJObUQBM8nj0HqdKPplS1mGrACUOqt8P5zYStH0mzoaB7E2xw5DA7aV9dAy8jK2
         PR5/7933UGOcSoa2D0K7bN9zY3/bUIWaag3Px+xsg3mG4K8NCgLNiUH0FE9XtkAfGG3k
         JZ1fYRYb6dBo1yknb6j3FpPbcY1daeFNzIhkGS0AbzY3/ZK2kI8aiFctqv/ckXo+0lzs
         xRO6/8nqQceo4+9u/zrZXWOwdwgsZOqMBEBHxz/iKolK/PkqZkCuRQbByNq6A2sVeCNa
         xIQmSKanaAbtD9uNPc+E23EUCVScfctER4CpJF54vY15xI1rOusOBJUgIviJEBR2kRbR
         XSHA==
X-Forwarded-Encrypted: i=1; AHgh+RoAcwccZsnlVMAiTD5OuLAU94yGcIxwjTFudIol95GsCwNp0CY5vlHznk3POYP91LNYCgsXcN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGWX0al1puGInU8iHJ3yYb5cG3veKGx9Dsr4e+IkDetf++W/oU
	w4XymDbD2ngY6HiQLNhyzx9cm8PaP9j0c4i3IXb/2fzFjPKj57ecNj3O
X-Gm-Gg: AfdE7ckgWUMiNWA3gmFoQQ4QsfWpNQ9rYUBOBXdVcHlb/82Ojf1y6b8hh/P3YFTHWVQ
	gK6oocpHMHP8hJQ/HYFn5yoY5LR/4Xfp7k3GEHWuUiHsOBZ7DmcxinWiVlCgDASlhqmMTudlPI0
	7fL27Ef7TZ5LfHu4KQ0ZQGP8UHoPQ/Q64EhPuyA+32dmnbWYwxSE1WTsJHugDQhKilK0glttNCz
	hMGf09UN2LaOhHd6+rmtbfK5W2On5dTksK34BPSpOkDlpuj/zY1Yuus30SvQq17Cw1f7MdocpyO
	dtfyo3UgP0YUOj765+MB+NyiiVfpIw8Ear1EYhWQFqssnM5qboviiAq9CHjROdQ3MIAZORgFQ+W
	+zm0QX1rhBZPBQSVSj3n44VO71tuvbfezAQweMvDXw0aIaBfZ79sQ4VOzoba5HOGTl9Vh9GQ2TT
	z1BKrr65UyCYWl+VZJYPyB9o2RIlZ6VOp5CC81S4noN8clfvaF3ViqcvlDhaAbxQcLyJHYovH+a
	wuaeVh4goZMSdlAHkE=
X-Received: by 2002:a5d:5d07:0:b0:473:f4c3:4d51 with SMTP id ffacd0b85a97d-47df079abe1mr1739457f8f.43.1783506236114;
        Wed, 08 Jul 2026 03:23:56 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-95-248-227-210.retail.telecomitalia.it. [95.248.227.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47aa0f2186bsm40660248f8f.36.2026.07.08.03.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 03:23:55 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next 4/5] net: phy: mediatek: add calibration logic for AN7581
Date: Wed,  8 Jul 2026 12:23:30 +0200
Message-ID: <20260708102341.53919-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708102341.53919-1-ansuelsmth@gmail.com>
References: <20260708102341.53919-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305752-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ansuelsmth@gmail.com,m:daniel@makrotopia.org,m:dqfext@gmail.com,m:SkyLake.Huang@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,makrotopia.org,mediatek.com,collabora.com,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B47D724491

Airoha AN7581 require dedicated calibration and specific tuneup to make
the Ethernet port work on specific HW PCB layout.

The calibration process is similar to Mediatek PHY but Airoha PHY use
Software calibration process instead of making use of EFUSE.

It does also require some complex table for TX Amp compensation and
multiple register settings for EEE and 10/100M to correctly work.
Also the PHY apply a different TX Amp compensation table based on the
SoC PDIDR version. Such version info is stored in the SCU SoC registers.

Add module version as suggested by Airoha to identify the calibration logic
with a specific version.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/mediatek/airoha-ge-soc.c | 1489 ++++++++++++++++++++++
 drivers/net/phy/mediatek/mtk-ge-soc.h    |   13 +
 2 files changed, 1502 insertions(+)

diff --git a/drivers/net/phy/mediatek/airoha-ge-soc.c b/drivers/net/phy/mediatek/airoha-ge-soc.c
index 429594f27792..bc487b093cfa 100644
--- a/drivers/net/phy/mediatek/airoha-ge-soc.c
+++ b/drivers/net/phy/mediatek/airoha-ge-soc.c
@@ -1,16 +1,1493 @@
 // SPDX-License-Identifier: GPL-2.0+
+#include <linux/bitfield.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/phy.h>
 
+#include "../phylib.h"
 #include "mtk.h"
 #include "mtk-ge-soc.h"
 
+#define AIROHA_DEFAULT_PORT0_ADDR		0x9
 #define AIROHA_PHY_MAX_LEDS			2
 
+enum airoha_mdi_resister_type {
+	MDI_0R,
+	MDI_5R,
+
+	MDI_TYPE_MAX,
+};
+
+enum airoha_transformer_type {
+	TXMR,
+	DISCRETE,
+
+	TRANSFORMER_TYPE_MAX,
+};
+
+enum airoha_calib_const_type {
+	TX_AMP_TEST_A,
+	TX_AMP_TEST_B,
+	TX_AMP_TEST_C,
+	TX_AMP_TEST_D,
+	TX_AMP_1G_A,
+	TX_AMP_1G_B,
+	TX_AMP_1G_C,
+	TX_AMP_1G_D,
+	TX_AMP_100M_A,
+	TX_AMP_100M_B,
+	TX_AMP_10M_A,
+	TX_AMP_10M_B,
+	R50_A,
+	R50_B,
+	R50_C,
+	R50_D,
+
+	CALIB_CONST_TYPE_MAX,
+};
+
+struct airoha_socphy_shared {
+	struct phy_device *phydev_p0;
+	enum airoha_transformer_type transformer_type[4];
+	enum airoha_mdi_resister_type mdi_resister_type;
+	bool rext_sw_calib_done;
+	int (*tx_amp_compensation_tbl)[TRANSFORMER_TYPE_MAX][MDI_TYPE_MAX][CALIB_CONST_TYPE_MAX][4];
+	u8 *r50_cal_tbl;
+};
+
+/*
+ * 2 chip revision
+ * TXMR or discrete
+ * 2 MDI type
+ * TX AMP test/TX AMP 1G/TX AMP 100M/TX AMP 10M/R50
+ * 4 PHY
+ */
+static int an7581_tx_amp_compensation_tbl[2][TRANSFORMER_TYPE_MAX][MDI_TYPE_MAX][CALIB_CONST_TYPE_MAX][4] = {
+	{ /* IC version 1 */
+		[TXMR] = {
+			{ },
+			{
+				[TX_AMP_TEST_A] = { -12, -11, -9, -6 },
+				[TX_AMP_TEST_B] = { -9, -13, -9, -5 },
+				[TX_AMP_TEST_C] = { -5, -4, -3, 1 },
+				[TX_AMP_TEST_D] = { -9, -8, -7, -5 },
+				[TX_AMP_1G_A] = { -12, -11, -9, -6 },
+				[TX_AMP_1G_B] = { -9, -13, -9, -5 },
+				[TX_AMP_1G_C] = { -5, -4, -3, 1 },
+				[TX_AMP_1G_D] = { -9, -8, -7, -5 },
+				[TX_AMP_100M_A] = { -2, -2, 0, 2 },
+				[TX_AMP_100M_B] = { -2, -2, 1, 1 },
+				[TX_AMP_10M_A] = { 0, 0, 0, 0 },
+				[TX_AMP_10M_B] = { 0, 0, 0, 0 },
+				[R50_A] = { 15, 15, 15, 15 },
+				[R50_B] = { 15, 15, 18, 15 },
+				[R50_C] = { -8, -8, -8, -8 },
+				[R50_D] = { -8, -8, -8, -8 },
+			},
+		},
+		[DISCRETE] = {
+			{ },
+			{
+				[TX_AMP_TEST_A] = { -9, -7, -7, -5 },
+				[TX_AMP_TEST_B] = { -9, -9, -7, -4 },
+				[TX_AMP_TEST_C] = { -9, -7, -9, -6 },
+				[TX_AMP_TEST_D] = { -11, -9, -10, -8 },
+				[TX_AMP_1G_A] = { -9, -7, -7, -5 },
+				[TX_AMP_1G_B] = { -9, -8, -7, -4 },
+				[TX_AMP_1G_C] = { -9, -7, -9, -6 },
+				[TX_AMP_1G_D] = { -11, -8, -10, -8 },
+				[TX_AMP_100M_A] = { 4, 3, 4, 4 },
+				[TX_AMP_100M_B] = { 4, 4, 5, 4 },
+				[TX_AMP_10M_A] = { 0, 0, 0, 0 },
+				[TX_AMP_10M_B] = { 0, 0, 0, 0 },
+				[R50_A] = { 0, 0, 0, 0 },
+				[R50_B] = { 0, 0, 0, 0 },
+				[R50_C] = { 0, 0, 0, 0 },
+				[R50_D] = { 0, 0, 0, 0 },
+			},
+		},
+	},
+	{ /* IC version 2 */
+		[TXMR] = {
+			{ },
+			{
+				[TX_AMP_TEST_A] = { -10, -12, -12, -11 },
+				[TX_AMP_TEST_B] = { -10, -11, -11, -10 },
+				[TX_AMP_TEST_C] = { -5, -7, -9, -3 },
+				[TX_AMP_TEST_D] = { -8, -10, -7, -8 },
+				[TX_AMP_1G_A] = { -12, -6, -6, 4 },
+				[TX_AMP_1G_B] = { -10, -5, -5, 1 },
+				[TX_AMP_1G_C] = { -5, -3, -4, 11 },
+				[TX_AMP_1G_D] = { -8, -3, -3, 4 },
+				[TX_AMP_100M_A] = { 2, 1, 0, 3 },
+				[TX_AMP_100M_B] = { 0, 0, 0, 3 },
+				[TX_AMP_10M_A] = { 0, 0, 0, 0 },
+				[TX_AMP_10M_B] = { 0, 0, 0, 0 },
+				[R50_A] = { 15, 15, 15, 15 },
+				[R50_B] = { 15, 15, 18, 15 },
+				[R50_C] = { 4, 4, 4, 4 },
+				[R50_D] = { 4, 4, 4, 4 },
+			},
+		},
+		[DISCRETE] = {
+			{ },
+			{
+				[TX_AMP_TEST_A] = { -11, 11, -12, -7 },
+				[TX_AMP_TEST_B] = { -9, -10, -9, -8 },
+				[TX_AMP_TEST_C] = { -6, -3, -7, -4 },
+				[TX_AMP_TEST_D] = { -7, -8, -10, -7 },
+				[TX_AMP_1G_A] = { -11, -11, -12, -7 },
+				[TX_AMP_1G_B] = { -9, -10, -9, -8 },
+				[TX_AMP_1G_C] = { -6, -3, -7, -4 },
+				[TX_AMP_1G_D] = { -7, -8, -10, -7 },
+				[TX_AMP_100M_A] = { 2, 2, 1, 2 },
+				[TX_AMP_100M_B] = { 3, 3, 3, 3 },
+				[TX_AMP_10M_A] = { 0, 0, 0, 0 },
+				[TX_AMP_10M_B] = { 0, 0, 0, 0 },
+				[R50_A] = { 12, 12, 12, 12 },
+				[R50_B] = { 7, 7, 7, 7 },
+				[R50_C] = { 2, 2, 0, 0 },
+				[R50_D] = { 0, 0, 2, 2 },
+			},
+		},
+	},
+};
+
+static u8 an7581_zcal_to_r45ohm[64] = {
+	127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127,
+	127, 127, 127, 127, 127, 127, 127, 127, 123, 119, 115, 112, 108, 104, 100,  96,
+	 94,  92,  88,  85,  82,  80,  76,  74,  72,  68,  66,  64,  62,  60,  56,  55,
+	 52,  50,  48,  46,  44,  42,  40,  39,  36,  35,  32,  32,  30,  28,  27,  25
+};
+
+static int airoha_cal_cycle(struct phy_device *phydev, int devad,
+			    u32 regnum, u16 mask, u16 cal_val)
+{
+	struct airoha_socphy_shared *shared = phy_package_get_priv(phydev);
+	struct phy_device *phydev_p0;
+	int ret;
+
+	phydev_p0 = shared->phydev_p0;
+
+	phy_modify_mmd(phydev, devad, regnum, mask, cal_val);
+
+	ret = mtk_cal_cycle_wait(phydev_p0);
+	phydev_dbg(phydev, "cal_val: 0x%x, ret: %d\n", cal_val, ret);
+
+	return ret;
+}
+
+static int airoha_rext_cal_sw(struct phy_device *phydev)
+{
+	int calibration_polarity;
+	u8 zcal_ctrl = 32;
+	int first_calib;
+	int ret;
+
+	/* BG voltage output */
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x100, 0xc000);
+	/* tst_mode2 */
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0xff, 0x2);
+
+	phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2, 0xff,
+			   GENMASK(15, 4) | GENMASK(1, 0));
+
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_ANA_CAL_RG0,
+		      MTK_PHY_RG_CAL_CKINV | MTK_PHY_RG_ANA_CALEN |
+		      MTK_PHY_RG_REXT_CALEN);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_ANA_CAL_RG1, 0);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_ANA_CAL_RG6, 0);
+
+	phydev_dbg(phydev, "Start REXT SW cal.\n");
+	first_calib = airoha_cal_cycle(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_ANA_CAL_RG5,
+				       MTK_PHY_RG_REXT_ZCAL_CTRL_MASK, zcal_ctrl);
+
+	if (first_calib < 0) {
+		phydev_err(phydev, "REXT SW calibration failed.\n");
+		return -EINVAL;
+	}
+
+	/* If REXT calibration failed:
+	 * - increase dB until calibration succeed.
+	 * If REXT calibration succeeded:
+	 * - decrease dB until calibration fail to fine tune it.
+	 */
+	if (first_calib == 1)
+		calibration_polarity = -1;
+	else
+		calibration_polarity = 1;
+
+	while (zcal_ctrl > 0 &&
+	       zcal_ctrl < FIELD_MAX(MTK_PHY_RG_REXT_ZCAL_CTRL_MASK)) {
+		zcal_ctrl += calibration_polarity;
+
+		ret = airoha_cal_cycle(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_ANA_CAL_RG5,
+				       MTK_PHY_RG_REXT_ZCAL_CTRL_MASK, zcal_ctrl);
+		/* Exit if we either failed or succeeded compared to the
+		 * first calibration result. (aka we finished fine tuning or
+		 * we succeeded with calibration)
+		 */
+		if (ret != first_calib)
+			break;
+	}
+
+	if (ret < 0) {
+		phydev_err(phydev, "REXT SW calibration failed.\n");
+		return -EINVAL;
+	}
+
+	if (zcal_ctrl == 0 ||
+	    zcal_ctrl == FIELD_MAX(MTK_PHY_RG_REXT_ZCAL_CTRL_MASK)) {
+		zcal_ctrl = 32;
+		phydev_err(phydev, "REXT SW calibration saturation. Defaulting to %x.\n",
+			   zcal_ctrl);
+	}
+
+	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_ANA_CAL_RG5,
+		       MTK_PHY_RG_REXT_TRIM_MASK,
+		       FIELD_PREP(MTK_PHY_RG_REXT_TRIM_MASK, zcal_ctrl));
+	phy_modify_mmd(phydev, MDIO_MMD_VEND2, MTK_PHY_RG_BG_RASEL,
+		       MTK_PHY_RG_BG_RASEL_MASK,
+		       FIELD_PREP(MTK_PHY_RG_BG_RASEL_MASK, zcal_ctrl >> 3));
+
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_ANA_CAL_RG0, 0);
+
+	return 0;
+}
+
+static int airoha_tx_offset_cal_sw(struct phy_device *phydev, u8 txg_calen_x)
+{
+	struct airoha_socphy_shared *shared = phy_package_get_priv(phydev);
+	struct phy_device *phydev_p0;
+	u16 dev1e_145_tmp, bmcr_tmp;
+	int calibration_polarity;
+	u16 reg_dac1, reg_dac2;
+	int zcal_ctrl = 0;
+	int first_calib;
+	u16 reg, mask;
+	int ret;
+
+	phydev_p0 = shared->phydev_p0;
+
+	/* BG voltage output */
+	phy_write_mmd(phydev_p0, MDIO_MMD_VEND2, 0x100, 0xc000);
+
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_ANA_CAL_RG0,
+		      MTK_PHY_RG_ANA_CALEN);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_ANA_CAL_RG1,
+		      MTK_PHY_RG_TXVOS_CALEN);
+	phy_write_mmd(phydev_p0, MDIO_MMD_VEND1, MTK_PHY_RG_ANA_CAL_RG0,
+		      MTK_PHY_RG_ANA_CALEN);
+	phy_write_mmd(phydev_p0, MDIO_MMD_VEND1, MTK_PHY_RG_ANA_CAL_RG1,
+		      MTK_PHY_RG_TXVOS_CALEN);
+
+	/* Force 1G full duplex for calibration */
+	bmcr_tmp = phy_read(phydev, MII_BMCR);
+	phy_write(phydev, MII_BMCR, BMCR_FULLDPLX | BMCR_SPEED1000);
+
+	/* Force MDI */
+	dev1e_145_tmp = phy_read_mmd(phydev, MDIO_MMD_VEND1, 0x0145);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x0145, 0x1010);
+
+	/* 1e_96[15]:bypass_tx_offset_cal, Hw bypass, Fw cal */
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x96,
+		      0x8000);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x3e,
+		      0xf808);
+
+	switch (txg_calen_x) {
+	case PAIR_A:
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0xdd, BIT(12));
+		reg_dac1 = MTK_PHY_RG_DASN_DAC_IN0_A;
+		reg_dac2 = MTK_PHY_RG_DASN_DAC_IN1_A;
+		reg = MTK_PHY_RG_CR_TX_AMP_OFFSET_A_B;
+		mask = MTK_PHY_CR_TX_AMP_OFFSET_A_MASK;
+		break;
+	case PAIR_B:
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0xdd, BIT(8));
+		reg_dac1 = MTK_PHY_RG_DASN_DAC_IN0_B;
+		reg_dac2 = MTK_PHY_RG_DASN_DAC_IN1_B;
+		reg = MTK_PHY_RG_CR_TX_AMP_OFFSET_A_B;
+		mask = MTK_PHY_CR_TX_AMP_OFFSET_B_MASK;
+		break;
+	case PAIR_C:
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0xdd, BIT(4));
+		reg_dac1 = MTK_PHY_RG_DASN_DAC_IN0_C;
+		reg_dac2 = MTK_PHY_RG_DASN_DAC_IN1_C;
+		reg = MTK_PHY_RG_CR_TX_AMP_OFFSET_C_D;
+		mask = MTK_PHY_CR_TX_AMP_OFFSET_C_MASK;
+		break;
+	case PAIR_D:
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0xdd, BIT(0));
+		reg_dac1 = MTK_PHY_RG_DASN_DAC_IN0_D;
+		reg_dac2 = MTK_PHY_RG_DASN_DAC_IN1_D;
+		reg = MTK_PHY_RG_CR_TX_AMP_OFFSET_C_D;
+		mask = MTK_PHY_CR_TX_AMP_OFFSET_D_MASK;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, reg_dac1,
+		      0x8000);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, reg_dac2,
+		      0x8000);
+
+	phydev_dbg(phydev, "Start TX Offset SW cal.\n");
+
+	first_calib = airoha_cal_cycle(phydev, MDIO_MMD_VEND1, reg, mask,
+				       zcal_ctrl << __ffs(mask));
+
+	/* If TX Offset calibration failed:
+	 * - increase dB until calibration succeed.
+	 * If TX Offset calibration succeeded:
+	 * - decrease dB until calibration fail to fine tune it.
+	 */
+	if (first_calib == 1)
+		calibration_polarity = -1;
+	else
+		calibration_polarity = 1;
+
+	while (zcal_ctrl > -32 && zcal_ctrl < 32) {
+		u32 val;
+
+		zcal_ctrl += calibration_polarity;
+		if (zcal_ctrl >= 0)
+			val = zcal_ctrl;
+		else
+			/* BIT(5) signal negative number for TX Offset */
+			val = BIT(5) | abs(zcal_ctrl);
+
+		ret = airoha_cal_cycle(phydev, MDIO_MMD_VEND1, reg, mask,
+				       val << __ffs(mask));
+		/* Exit if we either failed or succeeded compared to the
+		 * first calibration result. (aka we finished fine tuning or
+		 * we succeeded with calibration)
+		 */
+		if (ret != first_calib)
+			break;
+	}
+
+	if (ret < 0) {
+		phydev_err(phydev, "TX Offset calibration failed.\n");
+		return -EINVAL;
+	}
+
+	if (zcal_ctrl == -32 ||
+	    zcal_ctrl == 32) {
+		zcal_ctrl = 0;
+		phydev_err(phydev, "TX Offset SW calibration saturation. Defaulting to %x.\n",
+			   zcal_ctrl);
+
+		phy_modify_mmd(phydev, MDIO_MMD_VEND1, reg, mask,
+			       zcal_ctrl << __ffs(mask));
+	}
+
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x100, 0x0);
+
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DASN_DAC_IN0_A, 0);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DASN_DAC_IN0_B, 0);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DASN_DAC_IN0_C, 0);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DASN_DAC_IN0_D, 0);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DASN_DAC_IN1_A, 0);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DASN_DAC_IN1_B, 0);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DASN_DAC_IN1_C, 0);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DASN_DAC_IN1_D, 0);
+
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_ANA_CAL_RG0, 0);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_ANA_CAL_RG1, 0);
+	phy_write_mmd(phydev_p0, MDIO_MMD_VEND1, MTK_PHY_RG_ANA_CAL_RG0, 0);
+	phy_write_mmd(phydev_p0, MDIO_MMD_VEND1, MTK_PHY_RG_ANA_CAL_RG1, 0);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x96, 0x0);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x3e, 0xc000);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0xdd, 0);
+
+	/* Restore BMCR */
+	phy_write(phydev, MII_BMCR, bmcr_tmp);
+
+	/* Restore MDI */
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x0145, dev1e_145_tmp);
+
+	return 0;
+}
+
+static int airoha_tx_amp_cal_sw(struct phy_device *phydev, u8 txg_calen_x)
+{
+	struct airoha_socphy_shared *shared = phy_package_get_priv(phydev);
+	u16 mask_gbe, mask_tbt, mask_tst, mask_hbt;
+	u16 reg, reg_100, reg_dac1, reg_dac2;
+	struct phy_device *phydev_p0;
+	int calibration_polarity;
+	u8 zcal_ctrl = 32;
+	int first_calib;
+	int ret;
+
+	phydev_p0 = shared->phydev_p0;
+
+	/* BG voltage output */
+	phy_write_mmd(phydev_p0, MDIO_MMD_VEND2, 0x100, 0xc000);
+
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x145, 0x1010);
+
+	phy_write_mmd(phydev_p0, MDIO_MMD_VEND1, MTK_PHY_RG_ANA_CAL_RG0,
+		      MTK_PHY_RG_CAL_CKINV | MTK_PHY_RG_ANA_CALEN);
+	phy_write_mmd(phydev_p0, MDIO_MMD_VEND1, MTK_PHY_RG_ANA_CAL_RG1,
+		      MTK_PHY_RG_TXVOS_CALEN);
+
+	/* select 1V */
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_ANA_CAL_RG6, 0x10);
+
+	/* enable Tx VLD*/
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x3e, 0xf808);
+
+	/* Force 1G full duplex for calibration */
+	phy_write(phydev, MII_BMCR, BMCR_FULLDPLX | BMCR_SPEED1000);
+
+	switch (txg_calen_x) {
+	case PAIR_A:
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0xdd, BIT(12));
+		reg_dac1 = MTK_PHY_RG_DASN_DAC_IN0_A;
+		reg_dac2 = MTK_PHY_RG_DASN_DAC_IN1_A;
+		reg = MTK_PHY_TXVLD_DA_RG;
+		mask_gbe = MTK_PHY_DA_TX_I2MPB_A_GBE_MASK;
+		mask_tbt = MTK_PHY_DA_TX_I2MPB_A_TBT_MASK;
+		reg_100 = MTK_PHY_TX_I2MPB_TEST_MODE_A2;
+		mask_hbt = MTK_PHY_DA_TX_I2MPB_A_HBT_MASK;
+		mask_tst = MTK_PHY_DA_TX_I2MPB_A_TST_MASK;
+		break;
+	case PAIR_B:
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0xdd, BIT(8));
+		reg_dac1 = MTK_PHY_RG_DASN_DAC_IN0_B;
+		reg_dac2 = MTK_PHY_RG_DASN_DAC_IN1_B;
+		reg = MTK_PHY_TX_I2MPB_TEST_MODE_B1;
+		mask_gbe = MTK_PHY_DA_TX_I2MPB_B_GBE_MASK;
+		mask_tbt = MTK_PHY_DA_TX_I2MPB_B_TBT_MASK;
+		reg_100 = MTK_PHY_TX_I2MPB_TEST_MODE_B2;
+		mask_hbt = MTK_PHY_DA_TX_I2MPB_B_HBT_MASK;
+		mask_tst = MTK_PHY_DA_TX_I2MPB_B_TST_MASK;
+		break;
+	case PAIR_C:
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0xdd, BIT(4));
+		reg_dac1 = MTK_PHY_RG_DASN_DAC_IN0_C;
+		reg_dac2 = MTK_PHY_RG_DASN_DAC_IN1_C;
+		reg = MTK_PHY_TX_I2MPB_TEST_MODE_C1;
+		mask_gbe = MTK_PHY_DA_TX_I2MPB_C_GBE_MASK;
+		mask_tbt = MTK_PHY_DA_TX_I2MPB_C_TBT_MASK;
+		reg_100 = MTK_PHY_TX_I2MPB_TEST_MODE_C2;
+		mask_hbt = MTK_PHY_DA_TX_I2MPB_C_HBT_MASK;
+		mask_tst = MTK_PHY_DA_TX_I2MPB_C_TST_MASK;
+		break;
+	case PAIR_D:
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0xdd, BIT(0));
+		reg_dac1 = MTK_PHY_RG_DASN_DAC_IN0_D;
+		reg_dac2 = MTK_PHY_RG_DASN_DAC_IN1_D;
+		reg = MTK_PHY_TX_I2MPB_TEST_MODE_D1;
+		mask_gbe = MTK_PHY_DA_TX_I2MPB_D_GBE_MASK;
+		mask_tbt = MTK_PHY_DA_TX_I2MPB_D_TBT_MASK;
+		reg_100 = MTK_PHY_TX_I2MPB_TEST_MODE_D2;
+		mask_hbt = MTK_PHY_DA_TX_I2MPB_D_HBT_MASK;
+		mask_tst = MTK_PHY_DA_TX_I2MPB_D_TST_MASK;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, reg_dac1,
+		      0x8000 | 0xf0);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, reg_dac2,
+		      0x8000 | 0xf0);
+
+	phydev_dbg(phydev, "Start TX Amp SW cal.\n");
+	first_calib = airoha_cal_cycle(phydev, MDIO_MMD_VEND1, reg,
+				       mask_gbe, zcal_ctrl << __ffs(mask_gbe));
+
+	/* If TX Amp calibration failed:
+	 * - increase dB until calibration succeed.
+	 * If TX Amp calibration succeeded:
+	 * - decrease dB until calibration fail to fine tune it.
+	 */
+	if (first_calib == 1)
+		calibration_polarity = -1;
+	else
+		calibration_polarity = 1;
+
+	while (zcal_ctrl > 0 &&
+	       zcal_ctrl < FIELD_MAX(MTK_PHY_RG_REXT_ZCAL_CTRL_MASK)) {
+		zcal_ctrl += calibration_polarity;
+
+		ret = airoha_cal_cycle(phydev, MDIO_MMD_VEND1, reg,
+				       mask_gbe, zcal_ctrl << __ffs(mask_gbe));
+		/* Exit if we either failed or succeeded compared to the
+		 * first calibration result. (aka we finished fine tuning or
+		 * we succeeded with calibration)
+		 */
+		if (ret != first_calib)
+			break;
+	}
+
+	if (ret < 0) {
+		phydev_err(phydev, "TX AMP calibration failed.\n");
+		phy_modify_mmd(phydev, MDIO_MMD_VEND1, reg,
+			       mask_gbe | mask_tbt,
+			       (zcal_ctrl << __ffs(mask_gbe)) |
+			       (zcal_ctrl << __ffs(mask_tbt)));
+
+		return -EINVAL;
+	}
+
+	if (zcal_ctrl == 0 ||
+	    zcal_ctrl == FIELD_MAX(MTK_PHY_RG_REXT_ZCAL_CTRL_MASK))
+		phydev_warn(phydev, "TX AMP SW calibration saturation.\n");
+
+	phy_modify_mmd(phydev, MDIO_MMD_VEND1, reg,
+		       mask_gbe | mask_tbt,
+		       (zcal_ctrl << __ffs(mask_gbe)) |
+		       (zcal_ctrl << __ffs(mask_tbt)));
+
+	phy_modify_mmd(phydev, MDIO_MMD_VEND1, reg_100,
+		       mask_hbt | mask_tst,
+		       (zcal_ctrl << __ffs(mask_hbt)) |
+		       (zcal_ctrl << __ffs(mask_tst)));
+
+	phy_write_mmd(phydev_p0, MDIO_MMD_VEND2, 0x100, 0x0);
+
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DASN_DAC_IN0_A, 0);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DASN_DAC_IN0_B, 0);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DASN_DAC_IN0_C, 0);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DASN_DAC_IN0_D, 0);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DASN_DAC_IN1_A, 0);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DASN_DAC_IN1_B, 0);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DASN_DAC_IN1_C, 0);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DASN_DAC_IN1_D, 0);
+	phy_write_mmd(phydev_p0, MDIO_MMD_VEND1, 0x145, 0x1000);
+
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_ANA_CAL_RG0, 0);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_ANA_CAL_RG1, 0);
+	phy_write_mmd(phydev_p0, MDIO_MMD_VEND1, MTK_PHY_RG_ANA_CAL_RG0, 0);
+	phy_write_mmd(phydev_p0, MDIO_MMD_VEND1, MTK_PHY_RG_ANA_CAL_RG1, 0);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x3e, 0xc000);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0xdd, 0);
+
+	/* Restore AN enable */
+	phy_write(phydev, MII_BMCR, BMCR_ANENABLE);
+
+	return 0;
+}
+
+static int airoha_tx_r50_cal_sw(struct phy_device *phydev, u8 txg_calen_x)
+{
+	struct airoha_socphy_shared *shared = phy_package_get_priv(phydev);
+	struct phy_device *phydev_p0;
+	u16 dev1e_145_tmp, bmcr_tmp;
+	int calibration_polarity;
+	u8 zcal_ctrl = 32;
+	int first_calib;
+	u16 reg;
+	int ret;
+
+	phydev_p0 = shared->phydev_p0;
+
+	/* BG voltage output */
+	phy_write_mmd(phydev_p0, MDIO_MMD_VEND2, 0x100, 0xc000);
+
+	phy_write_mmd(phydev_p0, MDIO_MMD_VEND1, MTK_PHY_RG_ANA_CAL_RG0,
+		      MTK_PHY_RG_CAL_CKINV | MTK_PHY_RG_ANA_CALEN);
+	phy_write_mmd(phydev_p0, MDIO_MMD_VEND1, MTK_PHY_RG_ANA_CAL_RG1, 0);
+	/* select 1V */
+	phy_write_mmd(phydev_p0, MDIO_MMD_VEND1, MTK_PHY_RG_ANA_CAL_RG6, 0x10);
+
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_ANA_CAL_RG0,
+		      MTK_PHY_RG_CAL_CKINV | MTK_PHY_RG_ANA_CALEN);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_ANA_CAL_RG1, 0);
+	/* select 1V */
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_ANA_CAL_RG6, 0x10);
+
+	/* Force 1G full duplex for calibration */
+	bmcr_tmp = phy_read(phydev, MII_BMCR);
+	phy_write(phydev, MII_BMCR, BMCR_FULLDPLX | BMCR_SPEED1000);
+
+	/* Force MDI */
+	dev1e_145_tmp = phy_read_mmd(phydev, MDIO_MMD_VEND1, 0x0145);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x0145, 0x1010);
+
+	/* disable tx slew control */
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x0185, 0x0000);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x00fb, 0x0100);
+
+	switch (txg_calen_x) {
+	case PAIR_A:
+		phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+				 MTK_PHY_RG_ANA_CAL_RG0,
+				 MTK_PHY_RG_ZCALEN_A);
+		break;
+	case PAIR_B:
+		phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+				 MTK_PHY_RG_ANA_CAL_RG1,
+				 MTK_PHY_RG_ZCALEN_B);
+		break;
+	case PAIR_C:
+		phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+				 MTK_PHY_RG_ANA_CAL_RG1,
+				 MTK_PHY_RG_ZCALEN_C);
+		break;
+	case PAIR_D:
+		phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+				 MTK_PHY_RG_ANA_CAL_RG1,
+				 MTK_PHY_RG_ZCALEN_D);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	phydev_dbg(phydev, "Start TX r50 SW cal.\n");
+	first_calib = airoha_cal_cycle(phydev_p0, MDIO_MMD_VEND1, MTK_PHY_RG_ANA_CAL_RG5,
+				       MTK_PHY_RG_REXT_ZCAL_CTRL_MASK, zcal_ctrl);
+
+	if (first_calib < 0) {
+		phydev_err(phydev, "TX r50 SW calibration failed.\n");
+		return -EINVAL;
+	}
+
+	/* If TX r50 calibration failed:
+	 * - increase dB until calibration succeed.
+	 * If TX r50 calibration succeeded:
+	 * - decrease dB until calibration fail to fine tune it.
+	 */
+	if (first_calib == 1)
+		calibration_polarity = -1;
+	else
+		calibration_polarity = 1;
+
+	while (zcal_ctrl > 0 &&
+	       zcal_ctrl < FIELD_MAX(MTK_PHY_RG_REXT_ZCAL_CTRL_MASK)) {
+		zcal_ctrl += calibration_polarity;
+
+		ret = airoha_cal_cycle(phydev_p0, MDIO_MMD_VEND1, MTK_PHY_RG_ANA_CAL_RG5,
+				       MTK_PHY_RG_REXT_ZCAL_CTRL_MASK, zcal_ctrl);
+		/* Exit if we either failed or succeeded compared to the
+		 * first calibration result. (aka we finished fine tuning or
+		 * we succeeded with calibration)
+		 */
+		if (ret != first_calib)
+			break;
+	}
+
+	if (ret < 0) {
+		phydev_err(phydev, "TX r50 SW calibration failed.\n");
+		return -EINVAL;
+	}
+
+	if (zcal_ctrl == 0 ||
+	    zcal_ctrl == FIELD_MAX(MTK_PHY_RG_REXT_ZCAL_CTRL_MASK))
+		phydev_warn(phydev, "TX r50 SW calibration saturation.\n");
+
+	zcal_ctrl = shared->r50_cal_tbl[zcal_ctrl];
+
+	switch (txg_calen_x) {
+	case PAIR_A:
+		reg = BIT(7) | FIELD_PREP(MTK_PHY_CR_TX_R50_OFFSET_A_MASK, zcal_ctrl);
+		phy_modify_mmd(phydev, MDIO_MMD_VEND1,
+			       MTK_PHY_RG_CR_TX_R50_OFFSET_A_B,
+			       BIT(7) | MTK_PHY_CR_TX_R50_OFFSET_A_MASK, reg);
+		break;
+	case PAIR_B:
+		reg = BIT(7) | FIELD_PREP(MTK_PHY_CR_TX_R50_OFFSET_B_MASK, zcal_ctrl);
+		phy_modify_mmd(phydev, MDIO_MMD_VEND1,
+			       MTK_PHY_RG_CR_TX_R50_OFFSET_A_B,
+			       BIT(7) | MTK_PHY_CR_TX_R50_OFFSET_B_MASK, reg);
+		break;
+	case PAIR_C:
+		reg = BIT(7) | FIELD_PREP(MTK_PHY_CR_TX_R50_OFFSET_C_MASK, zcal_ctrl);
+		phy_modify_mmd(phydev, MDIO_MMD_VEND1,
+			       MTK_PHY_RG_CR_TX_R50_OFFSET_C_D,
+			       BIT(7) | MTK_PHY_CR_TX_R50_OFFSET_C_MASK, reg);
+		break;
+	case PAIR_D:
+		reg = BIT(7) | FIELD_PREP(MTK_PHY_CR_TX_R50_OFFSET_D_MASK, zcal_ctrl);
+		phy_modify_mmd(phydev, MDIO_MMD_VEND1,
+			       MTK_PHY_RG_CR_TX_R50_OFFSET_C_D,
+			       BIT(7) | MTK_PHY_CR_TX_R50_OFFSET_D_MASK, reg);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_ANA_CAL_RG0, 0);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_ANA_CAL_RG1, 0);
+	phy_write_mmd(phydev_p0, MDIO_MMD_VEND1, MTK_PHY_RG_ANA_CAL_RG0, 0);
+	phy_write_mmd(phydev_p0, MDIO_MMD_VEND1, MTK_PHY_RG_ANA_CAL_RG1, 0);
+
+	/* Enable tx slew control */
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x0185, 0x0001);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x00fb, 0x0000);
+
+	phy_write_mmd(phydev_p0, MDIO_MMD_VEND2, 0x100, 0x0);
+
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_ANA_CAL_RG6, 0x0);
+	phy_write_mmd(phydev_p0, MDIO_MMD_VEND1, MTK_PHY_RG_ANA_CAL_RG6, 0x0);
+
+	/* Restore BMCR */
+	phy_write(phydev, MII_BMCR, bmcr_tmp);
+
+	/* Restore MDI */
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x0145, dev1e_145_tmp);
+
+	return 0;
+}
+
+static int airoha_rx_offset_cal_sw(struct phy_device *phydev)
+{
+	/* Hw bypass, Fw cal */
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x96, 0x8000);
+	/* tx/rx_cal_criteria_value */
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x37, 0x0033);
+
+	/* rx offset cal by Hw setup */
+	phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1, 0x39,
+			   BIT(14) | BIT(11));
+
+	/* disable rtune calibration */
+	phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2, 0x107,
+			   BIT(12));
+
+	/* bypass tx/rx dc offset cancellation process */
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, 0x171,
+			 BIT(8) | BIT(7));
+
+	/* rx offset calibration start */
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, 0x39,
+			 BIT(13));
+
+	/* rx offset calibration stop */
+	phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1, 0x39,
+			   BIT(13));
+
+	mdelay(10);
+
+	phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1, 0x171,
+			   BIT(8) | BIT(7));
+
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_ANA_CAL_RG6,
+		      0x1);
+
+	return 0;
+}
+
+static int airoha_cal_sw(struct phy_device *phydev, enum CAL_ITEM cal_item,
+			 u8 start_pair, u8 end_pair)
+{
+	u8 pair_n;
+	int ret;
+
+	for (pair_n = start_pair; pair_n <= end_pair; pair_n++) {
+		switch (cal_item) {
+		case REXT:
+			ret = airoha_rext_cal_sw(phydev);
+			break;
+		case TX_OFFSET:
+			ret = airoha_tx_offset_cal_sw(phydev, pair_n);
+			break;
+		case TX_AMP:
+			ret = airoha_tx_amp_cal_sw(phydev, pair_n);
+			break;
+		case TX_R50:
+			ret = airoha_tx_r50_cal_sw(phydev, pair_n);
+			break;
+		case RX_OFFSET:
+			ret = airoha_rx_offset_cal_sw(phydev);
+			break;
+		default:
+			return -EINVAL;
+		}
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static int airoha_start_cal(struct phy_device *phydev, enum CAL_ITEM cal_item,
+			    enum CAL_MODE cal_mode, u8 start_pair,
+			    u8 end_pair, u32 *buf)
+{
+	int ret;
+
+	switch (cal_mode) {
+	case SW_M:
+		ret = airoha_cal_sw(phydev, cal_item, start_pair, end_pair);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (ret) {
+		phydev_err(phydev, "cal %d failed\n", cal_item);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int airoha_phy_calib(struct phy_device *phydev)
+{
+	struct airoha_socphy_shared *shared = phy_package_get_priv(phydev);
+	struct phy_device *phydev_p0;
+	int ret;
+
+	phydev_p0 = shared->phydev_p0;
+
+	/* PreCalibrate Set */
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x5c, 0x6666);
+
+	if (!shared->rext_sw_calib_done) {
+		ret = airoha_start_cal(phydev, REXT, SW_M, NO_PAIR, NO_PAIR, NULL);
+		if (ret)
+			return ret;
+
+		shared->rext_sw_calib_done = true;
+	}
+
+	ret = airoha_start_cal(phydev, TX_R50, SW_M, PAIR_A, PAIR_D, NULL);
+	if (ret)
+		return ret;
+
+	ret = airoha_start_cal(phydev, TX_OFFSET, SW_M, PAIR_A, PAIR_D, NULL);
+	if (ret)
+		return ret;
+
+	ret = airoha_start_cal(phydev, TX_AMP, SW_M, PAIR_A, PAIR_D, NULL);
+	if (ret)
+		return ret;
+
+	ret = airoha_start_cal(phydev, RX_OFFSET, SW_M, NO_PAIR, NO_PAIR, NULL);
+	if (ret)
+		return ret;
+
+	/* Gating, short with other pair */
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x15, 0x0);
+
+	phy_write_mmd(phydev_p0, MDIO_MMD_VEND2, 0x100, 0x0);
+
+	return 0;
+}
+
+static int airoha_phy_auto_select_transformer(struct phy_device *phydev)
+{
+	struct airoha_socphy_shared *shared = phy_package_get_priv(phydev);
+	struct phy_device *phydev_p0;
+	u8 phy_offset;
+	u16 bmcr_tmp;
+	u16 val;
+	int i;
+
+	phydev_p0 = shared->phydev_p0;
+	phy_offset = phydev->mdio.addr - phydev_p0->mdio.addr;
+
+	/* Force 1G full duplex for calibration */
+	bmcr_tmp = phy_read(phydev, MII_BMCR);
+	phy_write(phydev, MII_BMCR, BMCR_FULLDPLX | BMCR_SPEED1000);
+
+	phy_modify_mmd(phydev, MDIO_MMD_VEND2, 0x271, GENMASK(4, 0),
+		       FIELD_PREP(GENMASK(4, 0), 0x3));
+
+	phy_modify_mmd(phydev, MDIO_MMD_VEND2, 0x269, GENMASK(15, 12),
+		       FIELD_PREP(GENMASK(15, 12), 0x2));
+
+	phy_modify_mmd(phydev, MDIO_MMD_VEND2, 0x26f, GENMASK(14, 12),
+		       FIELD_PREP(GENMASK(14, 12), 0x0));
+
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0xdd, BIT(12));
+
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DASN_DAC_IN0_A,
+		      0x8000 | 0xf0);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DASN_DAC_IN1_A,
+		      0x8000 | 0xf0);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DASN_DAC_IN0_B,
+		      0x8000 | 0xf0);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DASN_DAC_IN1_B,
+		      0x8000 | 0xf0);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DASN_DAC_IN0_C,
+		      0x8000 | 0xf0);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DASN_DAC_IN1_C,
+		      0x8000 | 0xf0);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DASN_DAC_IN0_D,
+		      0x8000 | 0xf0);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DASN_DAC_IN1_D,
+		      0x8000 | 0xf0);
+
+	/* Force pGA gain */
+	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_52B5);
+	__mtk_tr_modify(phydev, 0x1, 0xf, 0x10,
+			GENMASK(20, 15),
+			FIELD_PREP(GENMASK(20, 15), 0x1f));
+
+	__mtk_tr_modify(phydev, 0x1, 0xf, 0x11,
+			GENMASK(23, 18) | GENMASK(15, 10) | GENMASK(7, 2),
+			FIELD_PREP(GENMASK(23, 18), 0x1f) |
+			FIELD_PREP(GENMASK(15, 10), 0x1f) |
+			FIELD_PREP(GENMASK(7, 2), 0x1f));
+	phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);
+
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0xc9, 0xffff);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x151, 0x12);
+
+	switch (phy_offset) {
+	case 0:
+		val = 0x1;
+		break;
+	case 1:
+		val = 0x3;
+		break;
+	case 2:
+		val = 0x5;
+		break;
+	case 3:
+		val = 0x7;
+		break;
+	default:
+		return -EINVAL;
+	}
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x15,
+		      FIELD_PREP(GENMASK(14, 12), val) | 0x161);
+	mdelay(500);
+
+	for (i = 0; i < 3; i++)
+		val = phy_read_mmd(phydev, MDIO_MMD_VEND2, 0x1a);
+
+	/* Check the value and report transformer type for later */
+	shared->transformer_type[phy_offset] = val < 0xe0;
+
+	/* Switch to Default */
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x15, 0x1000);
+
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0xdd, 0x0);
+
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DASN_DAC_IN0_A,
+		      0x0);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DASN_DAC_IN1_A,
+		      0x0);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DASN_DAC_IN0_B,
+		      0x0);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DASN_DAC_IN1_B,
+		      0x0);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DASN_DAC_IN0_C,
+		      0x0);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DASN_DAC_IN1_C,
+		      0x0);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DASN_DAC_IN0_D,
+		      0x0);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DASN_DAC_IN1_D,
+		      0x0);
+
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0xc9, 0xfff);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x151, 0x0);
+
+	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_52B5);
+	__mtk_tr_modify(phydev, 0x1, 0xf, 0x10,
+			GENMASK(20, 15),
+			FIELD_PREP(GENMASK(20, 15), 0x4));
+
+	__mtk_tr_modify(phydev, 0x1, 0xf, 0x11,
+			GENMASK(23, 18) | GENMASK(15, 10) | GENMASK(7, 2),
+			FIELD_PREP(GENMASK(23, 18), 0x0) |
+			FIELD_PREP(GENMASK(15, 10), 0x0) |
+			FIELD_PREP(GENMASK(7, 2), 0x0));
+	phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);
+
+	/* Restore BMCR */
+	phy_write(phydev, MII_BMCR, bmcr_tmp);
+
+	return 0;
+}
+
+static int airoha_phy_tx_amp_compensation(struct phy_device *phydev)
+{
+	struct airoha_socphy_shared *shared = phy_package_get_priv(phydev);
+
+	u16 reg_1e_12_read;
+	u16 reg_1e_16_read;
+	u16 reg_1e_17_read;
+	u16 reg_1e_18_read;
+	u16 reg_1e_19_read;
+	u16 reg_1e_20_read;
+	u16 reg_1e_21_read;
+	u16 reg_1e_22_read;
+	u16 reg_1e_174_read;
+	u16 reg_1e_175_read;
+
+	int reg_1e_12_header;
+	int reg_1e_16_header;
+	int reg_1e_17_header;
+	int reg_1e_18_header;
+	int reg_1e_19_header;
+	int reg_1e_21_header;
+	int reg_1e_174_header;
+	int reg_1e_175_header;
+
+	int reg_1e_12_end;
+	int reg_1e_16_end;
+	int reg_1e_17_end;
+	int reg_1e_18_end;
+	int reg_1e_20_end;
+	int reg_1e_22_end;
+	int reg_1e_174_end;
+	int reg_1e_175_end;
+
+	struct phy_device *phydev_p0;
+	u8 phy_offset;
+
+	int txamp_low_limit = -3;
+	int txamp_high_limit = 0x42;
+
+	int r50_low_limit = -8;
+	int r50_high_limit = 0x88;
+
+	bool overflow;
+	int (*tx_amp_table)[CALIB_CONST_TYPE_MAX][4];
+	int transformer_type, mdi_resister_type;
+
+	phydev_p0 = shared->phydev_p0;
+	phy_offset = phydev->mdio.addr - phydev_p0->mdio.addr;
+
+	transformer_type = shared->transformer_type[phy_offset];
+	mdi_resister_type = shared->mdi_resister_type;
+	tx_amp_table = shared->tx_amp_compensation_tbl[transformer_type][mdi_resister_type];
+
+	reg_1e_12_read = phy_read_mmd(phydev, MDIO_MMD_VEND1, 0x12);
+	reg_1e_16_read = phy_read_mmd(phydev, MDIO_MMD_VEND1, 0x16);
+	reg_1e_17_read = phy_read_mmd(phydev, MDIO_MMD_VEND1, 0x17);
+	reg_1e_18_read = phy_read_mmd(phydev, MDIO_MMD_VEND1, 0x18);
+	reg_1e_19_read = phy_read_mmd(phydev, MDIO_MMD_VEND1, 0x19);
+	reg_1e_20_read = phy_read_mmd(phydev, MDIO_MMD_VEND1, 0x20);
+	reg_1e_21_read = phy_read_mmd(phydev, MDIO_MMD_VEND1, 0x21);
+	reg_1e_22_read = phy_read_mmd(phydev, MDIO_MMD_VEND1, 0x22);
+	reg_1e_174_read = phy_read_mmd(phydev, MDIO_MMD_VEND1, 0x174);
+	reg_1e_175_read = phy_read_mmd(phydev, MDIO_MMD_VEND1, 0x175);
+
+	reg_1e_12_header = ((reg_1e_12_read & 0xfc00) / 1024) + *tx_amp_table[TX_AMP_1G_A][phy_offset];
+	reg_1e_17_header = ((reg_1e_17_read & 0x3f00) / 256) + *tx_amp_table[TX_AMP_1G_B][phy_offset];
+	reg_1e_19_header = ((reg_1e_19_read & 0x3f00) / 256) + *tx_amp_table[TX_AMP_1G_C][phy_offset];
+	reg_1e_21_header = ((reg_1e_21_read & 0x3f00) / 256) + *tx_amp_table[TX_AMP_1G_D][phy_offset];
+
+	overflow = false;
+	if (reg_1e_12_header < txamp_low_limit ||
+	    reg_1e_12_header > txamp_high_limit)
+		overflow = true;
+	if (reg_1e_17_header < txamp_low_limit ||
+	    reg_1e_17_header > txamp_high_limit)
+		overflow = true;
+	if (reg_1e_19_header < txamp_low_limit ||
+	    reg_1e_19_header > txamp_high_limit)
+		overflow = true;
+	if (reg_1e_21_header < txamp_low_limit ||
+	    reg_1e_21_header > txamp_high_limit)
+		overflow = true;
+
+	if (overflow) {
+		reg_1e_12_header = 0x20;
+		reg_1e_17_header = 0x20;
+		reg_1e_19_header = 0x20;
+		reg_1e_21_header = 0x20;
+	} else {
+		if (reg_1e_12_header < 0)
+			reg_1e_12_header = 0;
+		else if (reg_1e_12_header > 0x3f)
+			reg_1e_12_header = 0x3f;
+		if (reg_1e_17_header < 0)
+			reg_1e_17_header = 0;
+		else if (reg_1e_17_header > 0x3f)
+			reg_1e_17_header = 0x3f;
+		if (reg_1e_19_header < 0)
+			reg_1e_19_header = 0;
+		else if (reg_1e_19_header > 0x3f)
+			reg_1e_19_header = 0x3f;
+		if (reg_1e_21_header < 0)
+			reg_1e_21_header = 0;
+		else if (reg_1e_21_header > 0x3f)
+			reg_1e_21_header = 0x3f;
+	}
+
+	reg_1e_16_end = (reg_1e_16_read & 0x003f) + *tx_amp_table[TX_AMP_TEST_A][phy_offset];
+	reg_1e_18_end = (reg_1e_18_read & 0x003f) + *tx_amp_table[TX_AMP_TEST_B][phy_offset];
+	reg_1e_20_end = (reg_1e_20_read & 0x003f) + *tx_amp_table[TX_AMP_TEST_C][phy_offset];
+	reg_1e_22_end = (reg_1e_22_read & 0x003f) + *tx_amp_table[TX_AMP_TEST_D][phy_offset];
+
+	overflow = false;
+	if (reg_1e_16_end < txamp_low_limit ||
+	    reg_1e_16_end > txamp_high_limit)
+		overflow = true;
+	if (reg_1e_18_end < txamp_low_limit ||
+	    reg_1e_18_end > txamp_high_limit)
+		overflow = true;
+	if (reg_1e_20_end < txamp_low_limit ||
+	    reg_1e_20_end > txamp_high_limit)
+		overflow = true;
+	if (reg_1e_22_end < txamp_low_limit ||
+	    reg_1e_22_end > txamp_high_limit)
+		overflow = true;
+
+	if (overflow) {
+		reg_1e_16_end = 0x20;
+		reg_1e_18_end = 0x20;
+		reg_1e_20_end = 0x20;
+		reg_1e_22_end = 0x20;
+	} else {
+		if (reg_1e_16_end < 0)
+			reg_1e_16_end = 0;
+		else if (reg_1e_16_end > 0x3f)
+			reg_1e_16_end = 0x3f;
+		if (reg_1e_18_end < 0)
+			reg_1e_18_end = 0;
+		else if (reg_1e_18_end > 0x3f)
+			reg_1e_18_end = 0x3f;
+		if (reg_1e_20_end < 0)
+			reg_1e_20_end = 0;
+		else if (reg_1e_20_end > 0x3f)
+			reg_1e_20_end = 0x3f;
+		if (reg_1e_22_end < 0)
+			reg_1e_22_end = 0;
+		else if (reg_1e_22_end > 0x3f)
+			reg_1e_22_end = 0x3f;
+	}
+
+	reg_1e_16_header = ((reg_1e_16_read & 0xfc00) / 1024) + *tx_amp_table[TX_AMP_100M_A][phy_offset];
+	reg_1e_18_header = ((reg_1e_18_read & 0x3f00) / 256) + *tx_amp_table[TX_AMP_100M_B][phy_offset];
+
+	overflow = false;
+	if (reg_1e_16_header < txamp_low_limit ||
+	    reg_1e_16_header > txamp_high_limit)
+		overflow = true;
+	if (reg_1e_18_header < txamp_low_limit ||
+	    reg_1e_18_header > txamp_high_limit)
+		overflow = true;
+
+	if (overflow) {
+		reg_1e_16_header = 0x20;
+		reg_1e_18_header = 0x20;
+	} else {
+		if (reg_1e_16_header < 0)
+			reg_1e_16_header = 0;
+		else if (reg_1e_16_header > 0x3f)
+			reg_1e_16_header = 0x3f;
+		if (reg_1e_18_header < 0)
+			reg_1e_18_header = 0;
+		else if (reg_1e_18_header > 0x3f)
+			reg_1e_18_header = 0x3f;
+	}
+
+	reg_1e_12_end = (reg_1e_12_read & 0x003f) + *tx_amp_table[TX_AMP_10M_A][phy_offset];
+	reg_1e_17_end = (reg_1e_17_read & 0x003f) + *tx_amp_table[TX_AMP_10M_B][phy_offset];
+
+	overflow = false;
+	if (reg_1e_12_end < txamp_low_limit ||
+	    reg_1e_12_end > txamp_high_limit)
+		overflow = true;
+	if (reg_1e_17_end < txamp_low_limit ||
+	    reg_1e_17_end > txamp_high_limit)
+		overflow = true;
+
+	if (overflow) {
+		reg_1e_12_end = 0x20;
+		reg_1e_17_end = 0x20;
+	} else {
+		if (reg_1e_12_end < 0)
+			reg_1e_12_end = 0;
+		else if (reg_1e_12_end > 0x3f)
+			reg_1e_12_end = 0x3f;
+		if (reg_1e_17_end < 0)
+			reg_1e_17_end = 0;
+		else if (reg_1e_17_end > 0x3f)
+			reg_1e_17_end = 0x3f;
+	}
+
+	reg_1e_174_header = ((reg_1e_174_read & 0x7f00) / 256) + *tx_amp_table[R50_A][phy_offset];
+	reg_1e_174_end = (reg_1e_174_read & 0x007f) + *tx_amp_table[R50_B][phy_offset];
+	reg_1e_175_header = ((reg_1e_175_read & 0x7f00) / 256) + *tx_amp_table[R50_C][phy_offset];
+	reg_1e_175_end = (reg_1e_175_read & 0x007f) + *tx_amp_table[R50_D][phy_offset];
+
+	overflow = false;
+	if (reg_1e_174_header < r50_low_limit ||
+	    reg_1e_174_header > r50_high_limit)
+		overflow = true;
+	if (reg_1e_174_end < r50_low_limit ||
+	    reg_1e_174_end > r50_high_limit)
+		overflow = true;
+	if (reg_1e_175_header < r50_low_limit ||
+	    reg_1e_175_header > r50_high_limit)
+		overflow = true;
+	if (reg_1e_175_end < r50_low_limit ||
+	    reg_1e_175_end > r50_high_limit)
+		overflow = true;
+
+	if (overflow) {
+		reg_1e_174_header = 0x34;
+		reg_1e_174_end = 0x34;
+		reg_1e_175_header = 0x34;
+		reg_1e_175_end = 0x34;
+	} else {
+		if (reg_1e_174_header < 0)
+			reg_1e_174_header = 0;
+		else if (reg_1e_174_header > 0x7f)
+			reg_1e_174_header = 0x7f;
+		if (reg_1e_174_end < 0)
+			reg_1e_174_end = 0;
+		else if (reg_1e_174_end > 0x7f)
+			reg_1e_174_end = 0x7f;
+		if (reg_1e_175_header < 0)
+			reg_1e_175_header = 0;
+		else if (reg_1e_175_header > 0x7f)
+			reg_1e_175_header = 0x7f;
+		if (reg_1e_175_end < 0)
+			reg_1e_175_end = 0;
+		else if (reg_1e_175_end > 0x7f)
+			reg_1e_175_end = 0x7f;
+	}
+
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x12,
+		      (reg_1e_12_header * 1024) + reg_1e_12_end);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x16,
+		      (reg_1e_16_header * 1024) + reg_1e_16_end);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x17,
+		      (reg_1e_17_header * 256) + reg_1e_17_end);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x18,
+		      (reg_1e_18_header * 256) + reg_1e_18_end);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x19,
+		      (reg_1e_19_read & 0x00ff) + (reg_1e_19_header * 256));
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x20,
+		      (reg_1e_20_read & 0xff00) + reg_1e_20_end);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x21,
+		      (reg_1e_21_read & 0x00ff) + (reg_1e_21_header * 256));
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x22,
+		      (reg_1e_22_read & 0xff00) + reg_1e_22_end);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x174,
+		      0x8080 + (reg_1e_174_header * 256) + reg_1e_174_end);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x175,
+		      0x8080 + (reg_1e_175_header * 256) + reg_1e_175_end);
+
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x176, 0x4400);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x177, 0x0044);
+
+	return 0;
+}
+
+static int an7581_phy_config_init(struct phy_device *phydev)
+{
+	struct airoha_socphy_shared *shared = phy_package_get_priv(phydev);
+	struct phy_device *phydev_p0;
+	u32 soc_pdidr;
+	u8 phy_offset;
+	int ret;
+
+	phydev_p0 = shared->phydev_p0;
+	phy_offset = phydev->mdio.addr - phydev_p0->mdio.addr;
+
+	/* FIXME: Read SoC PDIDR if available or default to 1 */
+	soc_pdidr = 1;
+
+	shared->mdi_resister_type = MDI_5R;
+	if (soc_pdidr == 1)
+		shared->tx_amp_compensation_tbl = &an7581_tx_amp_compensation_tbl[0];
+	else
+		shared->tx_amp_compensation_tbl = &an7581_tx_amp_compensation_tbl[1];
+	shared->r50_cal_tbl = an7581_zcal_to_r45ohm;
+
+	ret = airoha_phy_calib(phydev);
+	if (ret)
+		return ret;
+
+	ret = airoha_phy_auto_select_transformer(phydev);
+	if (ret)
+		return ret;
+
+	ret = airoha_phy_tx_amp_compensation(phydev);
+	if (ret)
+		return ret;
+
+	/* RX setting for 5R_TXMR before AN setting */
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0xe6, 0x1111);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0xe7, 0x5555);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0xe9, 0x0001);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0xfe, 0x0000);
+
+	/* Long Loop Reach setting */
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x11, 0xff00);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x202, 0x2310);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x203, 0x0025);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x204, 0x2310);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x205, 0x0025);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x206, 0x2310);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x207, 0x0025);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x208, 0x2310);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x209, 0x0025);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x20a, 0x2310);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x20b, 0x0025);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x20e, 0x2310);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x20f, 0x0025);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x210, 0x2310);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x211, 0x0025);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x212, 0x2310);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x213, 0x0025);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x214, 0x2310);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x215, 0x0025);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x216, 0x2310);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x217, 0x0025);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x21a, 0x2310);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x21b, 0x0025);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x21c, 0x2310);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x21d, 0x0025);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x21e, 0x2310);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x21f, 0x0025);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x220, 0x2310);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x221, 0x0025);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x222, 0x2310);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x223, 0x0025);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x226, 0x2310);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x227, 0x0025);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x228, 0x2310);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x229, 0x0025);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x22a, 0x2310);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x22b, 0x0025);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x22c, 0x2310);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x22d, 0x0025);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x22e, 0x2310);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x22f, 0x0025);
+
+	/* RX Setting */
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x3c, 0xc000);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x3d, 0x0000);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x3e, 0xc000);
+
+	/* EEE setting */
+	phy_write_mmd(phydev, MDIO_MMD_AN, 0x3c, 0x0000);
+
+	/* RX */
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x41, 0x3333);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x44, 0x00c0);
+
+	/* 10M settings */
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x1a3, 0x00d2);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x1a4, 0x010e);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x27b, 0x1177);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x27c, 0x0808);
+
+	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_1);
+	__phy_write(phydev, 0x14, 0x3a18);
+	phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);
+
+	phy_write(phydev, 0x9, 0x1e00);
+
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x269, 0x2114);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x26a, 0x1113);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x26f, 0x0000);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x271, 0x2c63);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x272, 0x0c2b);
+
+	/* EEE set because power down can't set tokenring */
+	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_52B5);
+	__mtk_tr_write(phydev, 0x0, 0x7, 0x15, 0x0055a0);
+	__mtk_tr_write(phydev, 0x0, 0x7, 0x17, 0x07ff3f);
+	__mtk_tr_write(phydev, 0x1, 0xf, 0x0, 0x00001e);
+	__mtk_tr_write(phydev, 0x1, 0xf, 0x1, 0x6fb90a);
+	__mtk_tr_write(phydev, 0x1, 0xf, 0x18, 0x0e2f00);
+	__mtk_tr_write(phydev, 0x1, 0xd, 0x26, 0x444444);
+	__mtk_tr_write(phydev, 0x2, 0xd, 0x3, 0x000004);
+	__mtk_tr_write(phydev, 0x2, 0xd, 0x6, 0x2ebaef);
+	__mtk_tr_write(phydev, 0x2, 0xd, 0x8, 0x00000b);
+	__mtk_tr_write(phydev, 0x2, 0xd, 0xc, 0x00504d);
+	__mtk_tr_write(phydev, 0x2, 0xd, 0xd, 0x02314f);
+	__mtk_tr_write(phydev, 0x2, 0xd, 0xf, 0x003028);
+	__mtk_tr_write(phydev, 0x2, 0xd, 0x10, 0x00000a);
+	__mtk_tr_write(phydev, 0x2, 0xd, 0x11, 0x040001);
+	__mtk_tr_write(phydev, 0x2, 0xd, 0x14, 0x00024a);
+	__mtk_tr_write(phydev, 0x2, 0xd, 0x1c, 0x003210);
+	phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);
+
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x120, 0x8014);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x122, 0xffff);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x144, 0x0200);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x14a, 0xee20);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x19b, 0x0111);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x234, 0x1181);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x238, 0x0120);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x239, 0x0117);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x2d1, 0x0733);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x323, 0x0011);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x324, 0x013f);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x326, 0x0037);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x268, 0x07f4);
+
+	if (shared->transformer_type[phy_offset] == TXMR) {
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x00, 0x0187);
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01, 0x01cc);
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x02, 0x01c2);
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x03, 0x0109);
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x04, 0x020b);
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x05, 0x0202);
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x06, 0x0387);
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x07, 0x03c5);
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x08, 0x03c2);
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x09, 0x0309);
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x0a, 0x000e);
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x0b, 0x0002);
+
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x23, 0x0880);
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x24, 0x0880);
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x25, 0x0880);
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x26, 0x0880);
+	} else {
+		if (soc_pdidr == 2) {
+			phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x269, 0x1114);
+			phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x26a, 0x1113);
+			phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x26f, 0x2000);
+			phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x271, 0x4c88);
+			phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x272, 0x0c2b);
+
+			/* 100M sharp */
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x00, 0x0190);
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01, 0x01c8);
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x02, 0x01c0);
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x03, 0x0030);
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x04, 0x0208);
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x05, 0x0000);
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x06, 0x0318);
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x07, 0x03c8);
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x08, 0x03c0);
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x09, 0x0230);
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x0a, 0x0008);
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x0b, 0x0200);
+
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x23, 0x0885);
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x24, 0x0885);
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x25, 0x0885);
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x26, 0x0885);
+		} else {
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x00, 0x0190);
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01, 0x01cf);
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x02, 0x01c0);
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x03, 0x0030);
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x04, 0x020f);
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x05, 0x0000);
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x06, 0x0318);
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x07, 0x03cf);
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x08, 0x03c0);
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x09, 0x0230);
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x0a, 0x000f);
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x0b, 0x0200);
+
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x23, 0x0003);
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x24, 0x0003);
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x25, 0x0003);
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x26, 0x0003);
+		}
+	}
+
+	return 0;
+}
+
 static int an7581_phy_probe(struct phy_device *phydev)
 {
+	struct airoha_socphy_shared *shared;
 	struct mtk_socphy_priv *priv;
 	struct pinctrl *pinctrl;
+	int ret;
 
 	/* Toggle pinctrl to enable PHY LED */
 	pinctrl = devm_pinctrl_get_select(&phydev->mdio.dev, "gbe-led");
@@ -18,10 +1495,18 @@ static int an7581_phy_probe(struct phy_device *phydev)
 		dev_err(&phydev->mdio.bus->dev,
 			"Failed to setup PHY LED pinctrl\n");
 
+	ret = devm_phy_package_join(&phydev->mdio.dev, phydev, 0,
+				    sizeof(struct airoha_socphy_shared));
+	if (ret)
+		return ret;
+
 	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
+	if (phydev->mdio.addr == AIROHA_DEFAULT_PORT0_ADDR)
+		shared->phydev_p0 = phydev;
+
 	phydev->priv = priv;
 
 	return 0;
@@ -63,6 +1548,7 @@ static struct phy_driver mtk_socphy_driver[] = {
 	{
 		PHY_ID_MATCH_EXACT(AIROHA_GPHY_ID_AN7581),
 		.name		= "Airoha AN7581 PHY",
+		.config_init	= an7581_phy_config_init,
 		.config_intr	= genphy_no_config_intr,
 		.handle_interrupt = genphy_handle_interrupt_no_ack,
 		.probe		= an7581_phy_probe,
@@ -72,6 +1558,8 @@ static struct phy_driver mtk_socphy_driver[] = {
 		.led_hw_control_set = mt798x_phy_led_hw_control_set,
 		.led_hw_control_get = mt798x_phy_led_hw_control_get,
 		.led_polarity_set = an7581_phy_led_polarity_set,
+		.read_page	= mtk_phy_read_page,
+		.write_page	= mtk_phy_write_page,
 	},
 	{
 		PHY_ID_MATCH_EXACT(AIROHA_GPHY_ID_AN7583),
@@ -98,5 +1586,6 @@ static const struct mdio_device_id __maybe_unused airoha_socphy_tbl[] = {
 MODULE_DESCRIPTION("Airoha SoC Gigabit Ethernet PHY driver");
 MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
 MODULE_LICENSE("GPL");
+MODULE_VERSION("01.01.20260306");
 
 MODULE_DEVICE_TABLE(mdio, airoha_socphy_tbl);
diff --git a/drivers/net/phy/mediatek/mtk-ge-soc.h b/drivers/net/phy/mediatek/mtk-ge-soc.h
index 507e68343576..5e9d24a9833c 100644
--- a/drivers/net/phy/mediatek/mtk-ge-soc.h
+++ b/drivers/net/phy/mediatek/mtk-ge-soc.h
@@ -12,6 +12,7 @@
 
 #define MTK_EXT_PAGE_ACCESS			0x1f
 #define MTK_PHY_PAGE_STANDARD			0x0000
+#define MTK_PHY_PAGE_EXTENDED_1			0x0001
 #define MTK_PHY_PAGE_EXTENDED_3			0x0003
 
 #define MTK_PHY_LPI_REG_14			0x14
@@ -177,6 +178,7 @@
 #define MTK_PHY_RG_ANA_CAL_RG0			0xdb
 #define   MTK_PHY_RG_CAL_CKINV			BIT(12)
 #define   MTK_PHY_RG_ANA_CALEN			BIT(8)
+#define   MTK_PHY_RG_REXT_CALEN			BIT(4)
 #define   MTK_PHY_RG_ZCALEN_A			BIT(0)
 
 #define MTK_PHY_RG_ANA_CAL_RG1			0xdc
@@ -187,6 +189,9 @@
 
 #define MTK_PHY_RG_ANA_CAL_RG5			0xe0
 #define   MTK_PHY_RG_REXT_TRIM_MASK		GENMASK(13, 8)
+#define   MTK_PHY_RG_REXT_ZCAL_CTRL_MASK	GENMASK(5, 0)
+
+#define MTK_PHY_RG_ANA_CAL_RG6			0xe1
 
 #define MTK_PHY_RG_TX_FILTER			0xfe
 
@@ -208,6 +213,14 @@
 #define   MTK_PHY_CR_TX_AMP_OFFSET_C_MASK	GENMASK(13, 8)
 #define   MTK_PHY_CR_TX_AMP_OFFSET_D_MASK	GENMASK(6, 0)
 
+#define MTK_PHY_RG_CR_TX_R50_OFFSET_A_B		0x174
+#define   MTK_PHY_CR_TX_R50_OFFSET_A_MASK	GENMASK(13, 8)
+#define   MTK_PHY_CR_TX_R50_OFFSET_B_MASK	GENMASK(6, 0)
+
+#define MTK_PHY_RG_CR_TX_R50_OFFSET_C_D		0x175
+#define   MTK_PHY_CR_TX_R50_OFFSET_C_MASK	GENMASK(13, 8)
+#define   MTK_PHY_CR_TX_R50_OFFSET_D_MASK	GENMASK(6, 0)
+
 #define MTK_PHY_RG_AD_CAL_COMP			0x17a
 #define   MTK_PHY_AD_CAL_COMP_OUT_MASK		GENMASK(8, 8)
 
-- 
2.53.0


