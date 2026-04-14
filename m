Return-Path: <netdev+bounces-278358-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAxEJ3kF3mlRmQkAu9opvQ
	(envelope-from <netdev+bounces-278358-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:14:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0583F7B76
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79D1B3040690
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895B53BB9F6;
	Tue, 14 Apr 2026 09:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlVNWBxL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5D93B38A7
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 09:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776157981; cv=none; b=gVD06YAnBCVYaOgCw9aZ1OKUdLr5I4kaIxgwQczj57w35yiqo+zeu5TtR3xoJ/8wJhcKzAyM3XnB5RBDuM0y8xy7CIbEeqhFLjQ37fh6OceOl8BStmULsb8Yam3AMgd9jDDH7qutOy98ZHyGR26prxll0JpAbG3iI46oIbtcoNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776157981; c=relaxed/simple;
	bh=b2vABH9CUTGVy1b/2pVmKvFnsTTGQEzVcL53yfqfBH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g6dgFwoO6IZCgcm69NCvcgNMrGHMK9yQTpik+r87yrFN8h0oD6p4C0/nztIQu9bqrHKd4mH+huMOCjkVmIQwHzv0QzEU9n7d8bH/FLuMtbZPqxu+mTab+BMC5e//dwP7ZxZgA9vW62yRI8qAjTS8XVV0NwN9178vngihxXlFclU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlVNWBxL; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488ba840146so51816795e9.1
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 02:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776157978; x=1776762778; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EDSOwTMIxUubFUHj5t2nw1K3vQ5AcGm2RW0GMElvL0c=;
        b=DlVNWBxLilFDc1CxFhvDlUr5Aub04sDCdyUqsAxifkTNh3/oa3JXjdGE4SNbkebluH
         nPYOrl1qTaVEouYqwuoPn/vMQnud+FT6c9ocG+r4y00WZ3n6mftqxy/Olr9f25YJ2S0r
         Ewh3JW+1m9D/HrBvxB3N1qXOHgDetNEOJlJOBjBX2RrsQNiVMmkXwzMf47TB+MD9/Jyf
         1LRzthhq5LpEW/SUhoEqTl9yGJoVu9G2FaxE/kP0PEOTa+gq+ypxaM9BGJkq0mRV11Kr
         A3h/EBpSn3nfWnOiukvc2xsco7gsyaMnUgTV0+h91VJChFYp3WWG+2M3THfls0MvH4D0
         fNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776157978; x=1776762778;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EDSOwTMIxUubFUHj5t2nw1K3vQ5AcGm2RW0GMElvL0c=;
        b=s2p4Eg7THCwzH+pKL0f9BE+RyrovQ9lTgu2qrApysUgR3YIx2Uyd7ZkssIhyuo51Sq
         3MK2W0KDDQvS0qWOiFV02YERxhj4NzV74rYNZvZCmrrGNSbOutg8egwGC7d4ML6mPGBG
         fjoX2+rQcVI9nz1S02xNqXALmbX8AgbGWezbushgYpTYT9kFFh/ZDnjUcyuf5BffHKpE
         DPnUKp/R7IdQrHPUFajFAfGf6jbjE4nXtYOGlAMEUn/YCbV17FXPjWZkJMMD2xu54q6C
         7HTg005ZWRI5MX5ZVxe79KWHC3DxSwtCmChqLUxcfOTV7ZYOOyIbT/F8GZgayZJsuoWb
         FkUQ==
X-Forwarded-Encrypted: i=1; AFNElJ9CIyAzNWjCd/yo18B+/yFMN1Q3HiYdd/C4V+4niR6RYfmvaA5QZtC0LE76lL59GYtrf3isZYg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6J57kbT6ba1hlaLkaRJiVUOFibfQs3/WTTM09TXNHVsIMlM8/
	6V4gLOH7cvxjc0LMoDtDUGSnQMlbSDBzP13fMLV+tGRYVStDpk//wWes
X-Gm-Gg: AeBDiesAqQ6KZ2dHI1FaIFN4ReP/qA3CHAqRcVWJZVkuzS7mzW0AwTT6R4bw6+tt8YF
	YF7PlF3D/sgd/m95rVtoEdGUfVS6zKHHkhEW+FburFmXbl00OTKYuqgDdyxPMgiscU80uRWgGcN
	a9xwvpjSliW0HyxD/9+sMPhBpWcIeSsSWFwdpomzzuXX6t1QRt3uE7/RVWD+g80mLP0XLW4sZOO
	Q390RwELgB5cFexTSP/n1VMSTx8TD1p/tSg2+ClgwIwDUeGpAYmtjoHCo6QFwuWozYgGzB1qpiu
	40VIhdjimrVb8hhoCGRLYaZhH6OMPya3b8jg48Xz2jNRWEGWUFtf8iElg1Ss8HMQaJOBUT5Y48Q
	I0Up6xIzThxFBqrnw8aP9ZhSECuQcU81aFhW3MzcVGJoAqBFU21xDxuYCTK1pBqFiIMVDdXyIgN
	0mAgvnG4bFIZop57hpqe4H9NDEmrwiuUD+sqO5uhT7pNX7dKQBi4jsZOZU35c22cDRPyb5keHW3
	ZKh6mBFRw==
X-Received: by 2002:a05:600c:4fcb:b0:488:c120:480a with SMTP id 5b1f17b1804b1-488d6891181mr241537365e9.31.1776157978248;
        Tue, 14 Apr 2026 02:12:58 -0700 (PDT)
Received: from [127.0.1.1] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488eddba112sm37720175e9.0.2026.04.14.02.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 02:12:58 -0700 (PDT)
From: Fidelio Lawson <lawson.fidelio@gmail.com>
X-Google-Original-From: Fidelio Lawson <fidelio.lawson@exotec.com>
Date: Tue, 14 Apr 2026 11:12:34 +0200
Subject: [PATCH v3 1/3] net: dsa: microchip: implement KSZ87xx Module 3
 low-loss cable errata
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260414-ksz87xx_errata_low_loss_connections-v3-1-0e3838ca98c9@exotec.com>
References: <20260414-ksz87xx_errata_low_loss_connections-v3-0-0e3838ca98c9@exotec.com>
In-Reply-To: <20260414-ksz87xx_errata_low_loss_connections-v3-0-0e3838ca98c9@exotec.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Marek Vasut <marex@denx.de>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Woojung Huh <Woojung.Huh@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Fidelio Lawson <fidelio.lawson@exotec.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776157976; l=7009;
 i=fidelio.lawson@exotec.com; s=20260326; h=from:subject:message-id;
 bh=b2vABH9CUTGVy1b/2pVmKvFnsTTGQEzVcL53yfqfBH8=;
 b=1EdUKsDD5kIx0r/m1y1jf+NIHZjI939g6JX7+0sZbH92Eh6h8RlGaG7dStAAsPGCeMkgh6zEQ
 oN9nBsoHh7kA3fzag/cdtOHqo5tLS2bECSYcgE6p6ivvs4BHPXSJYm/
X-Developer-Key: i=fidelio.lawson@exotec.com; a=ed25519;
 pk=866eH9Bmmpjc+ctgkr5T1uXxBefZzob3tEEuiVWZ6BI=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-278358-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[exotec.com:email,exotec.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E0583F7B76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement the "Module 3: Equalizer fix for short cables" erratum from
Microchip document DS80000687C for KSZ87xx switches.

The issue affects short or low-loss cable links (e.g. CAT5e/CAT6),
where the PHY receiver equalizer may amplify high-amplitude signals
excessively, resulting in internal distortion and link establishment
failures.

KSZ87xx devices require a workaround for the Module 3 low-loss cable
condition, controlled through the switch TABLE_LINK_MD_V indirect
registers.

The affected registers are part of the switch address space and are not
directly accessible from the PHY driver. To keep the PHY-facing API
clean and avoid leaking switch-specific details, model this errata
control as vendor-specific Clause 22 PHY registers.

A vendor-specific Clause 22 PHY register is introduced as a mode
selector in PHY_REG_LOW_LOSS_CTRL, and ksz8_r_phy() / ksz8_w_phy()
translate accesses to these bits into the appropriate indirect
TABLE_LINK_MD_V accesses.

The control register defines the following modes:
0: disabled (default behavior)
1: EQ training workaround
2: LPF 90 MHz
3: LPF 62 MHz
4: LPF 55 MHz
5: LPF 44 MHz

Workaround 1: Adjusts the DSP EQ training behavior via LinkMD register
0x3C. Widens and optimizes the DSP EQ compensation range,
and is expected to solve most short/low-loss cable issues.

Workaround 2: for the cases where Workaround 1 is not sufficient.
This one adjusts the receiver low-pass filter bandwidth, effectively
reducing the high-frequency component of the received signal

The register is accessible through standard PHY read/write operations
(e.g. phytool), without requiring any switch-specific userspace
interface. This allows robust link establishment on short or
low-loss cabling without requiring DTS properties and without
constraining hardware design choices.

The erratum affects the shared PHY analog front-end and therefore
applies globally to the switch.

Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
---
 drivers/net/dsa/microchip/ksz8.c       | 45 ++++++++++++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz8_reg.h   | 36 ++++++++++++++++++++++++++-
 drivers/net/dsa/microchip/ksz_common.h |  3 +++
 3 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index c354abdafc1b..596c85654f24 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -1058,6 +1058,11 @@ int ksz8_r_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 *val)
 		if (ret)
 			return ret;
 
+		break;
+	case PHY_REG_KSZ87XX_LOW_LOSS:
+		if (!ksz_is_ksz87xx(dev))
+			return -EOPNOTSUPP;
+		data = dev->low_loss_wa_mode;
 		break;
 	default:
 		processed = false;
@@ -1271,6 +1276,46 @@ int ksz8_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val)
 		if (ret)
 			return ret;
 		break;
+	case PHY_REG_KSZ87XX_LOW_LOSS:
+		if (!ksz_is_ksz87xx(dev))
+			return -EOPNOTSUPP;
+
+		switch (val & PHY_KSZ87XX_LOW_LOSS_MASK) {
+		case PHY_LOW_LOSS_ERRATA_DISABLED:
+			ret = ksz8_ind_write8(dev, TABLE_LINK_MD, KSZ87XX_REG_EQ_TRAIN,
+					      KSZ87XX_EQ_TRAIN_DEFAULT);
+			if (!ret)
+				ret = ksz8_ind_write8(dev, TABLE_LINK_MD,
+						      KSZ87XX_REG_PHY_LPF,
+						      KSZ87XX_LOW_LOSS_LPF_90MHZ);
+			break;
+		case KSZ87XX_LOW_LOSS_EQ_TRAIN:
+			ret = ksz8_ind_write8(dev, TABLE_LINK_MD, KSZ87XX_REG_EQ_TRAIN,
+					      KSZ87XX_EQ_TRAIN_LOW_LOSS);
+			break;
+		case KSZ87XX_LOW_LOSS_LPF_90MHZ:
+			ret = ksz8_ind_write8(dev, TABLE_LINK_MD, KSZ87XX_REG_PHY_LPF,
+					      KSZ87XX_PHY_LPF_90MHZ);
+			break;
+		case KSZ87XX_LOW_LOSS_LPF_62MHZ:
+			ret = ksz8_ind_write8(dev, TABLE_LINK_MD, KSZ87XX_REG_PHY_LPF,
+					      KSZ87XX_PHY_LPF_62MHZ);
+			break;
+		case KSZ87XX_LOW_LOSS_LPF_55MHZ:
+			ret = ksz8_ind_write8(dev, TABLE_LINK_MD, KSZ87XX_REG_PHY_LPF,
+					      KSZ87XX_PHY_LPF_55MHZ);
+			break;
+		case KSZ87XX_LOW_LOSS_LPF_44MHZ:
+			ret = ksz8_ind_write8(dev, TABLE_LINK_MD, KSZ87XX_REG_PHY_LPF,
+					      KSZ87XX_PHY_LPF_44MHZ);
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		if (!ret)
+			dev->low_loss_wa_mode = val & PHY_KSZ87XX_LOW_LOSS_MASK;
+		return ret;
 	default:
 		break;
 	}
diff --git a/drivers/net/dsa/microchip/ksz8_reg.h b/drivers/net/dsa/microchip/ksz8_reg.h
index 332408567b47..4e02e044339c 100644
--- a/drivers/net/dsa/microchip/ksz8_reg.h
+++ b/drivers/net/dsa/microchip/ksz8_reg.h
@@ -202,6 +202,10 @@
 #define REG_PORT_3_STATUS_0		0x38
 #define REG_PORT_4_STATUS_0		0x48
 
+/* KSZ87xx LinkMD registers (TABLE_LINK_MD_V) */
+#define KSZ87XX_REG_EQ_TRAIN		0x3C
+#define KSZ87XX_REG_PHY_LPF			0x4C
+
 /* For KSZ8765. */
 #define PORT_REMOTE_ASYM_PAUSE		BIT(5)
 #define PORT_REMOTE_SYM_PAUSE		BIT(4)
@@ -342,7 +346,7 @@
 #define TABLE_EEE			(TABLE_EEE_V << TABLE_EXT_SELECT_S)
 #define TABLE_ACL			(TABLE_ACL_V << TABLE_EXT_SELECT_S)
 #define TABLE_PME			(TABLE_PME_V << TABLE_EXT_SELECT_S)
-#define TABLE_LINK_MD			(TABLE_LINK_MD << TABLE_EXT_SELECT_S)
+#define TABLE_LINK_MD			(TABLE_LINK_MD_V << TABLE_EXT_SELECT_S)
 #define TABLE_READ			BIT(4)
 #define TABLE_SELECT_S			2
 #define TABLE_STATIC_MAC_V		0
@@ -729,6 +733,36 @@
 #define PHY_POWER_SAVING_ENABLE		BIT(2)
 #define PHY_REMOTE_LOOPBACK		BIT(1)
 
+/* Equalizer low-loss workaround */
+#define PHY_REG_KSZ87XX_LOW_LOSS       0x1C
+#define PHY_KSZ87XX_LOW_LOSS_MASK      GENMASK(2, 0)
+
+/* KSZ87xx low-loss EQ mode selector (vendor-specific PHY reg 0x1c)
+ *
+ * Values:
+ *  0: disabled (default behavior)
+ *  1: EQ training workaround
+ *  2: LPF 90 MHz
+ *  3: LPF 62 MHz
+ *  4: LPF 55 MHz
+ *  5: LPF 44 MHz
+ */
+#define PHY_LOW_LOSS_ERRATA_DISABLED		0
+#define KSZ87XX_LOW_LOSS_EQ_TRAIN			1
+#define KSZ87XX_LOW_LOSS_LPF_90MHZ			2
+#define KSZ87XX_LOW_LOSS_LPF_62MHZ			3
+#define KSZ87XX_LOW_LOSS_LPF_55MHZ			4
+#define KSZ87XX_LOW_LOSS_LPF_44MHZ			5
+
+#define KSZ87XX_EQ_TRAIN_DEFAULT       0x0A
+#define KSZ87XX_EQ_TRAIN_LOW_LOSS      0x15
+
+/* LPF bandwidth bits [7:6]: 00 = 90MHz, 01 = 62MHz, 10 = 55MHz, 11 = 44MHz  */
+#define KSZ87XX_PHY_LPF_90MHZ          0x00
+#define KSZ87XX_PHY_LPF_62MHZ          0x40
+#define KSZ87XX_PHY_LPF_55MHZ          0x80
+#define KSZ87XX_PHY_LPF_44MHZ          0xC0
+
 /* KSZ8463 specific registers. */
 #define P1MBCR				0x4C
 #define P1MBSR				0x4E
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 929aff4c55de..16a6074ea4b4 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -219,6 +219,9 @@ struct ksz_device {
 	 * the switch’s internal PHYs, bypassing the main SPI interface.
 	 */
 	struct mii_bus *parent_mdio_bus;
+
+	/* Equalizer low-loss workaround tunable */
+	u8 low_loss_wa_mode; /* KSZ87xx low-loss EQ/LPF mode selector (0-5) */
 };
 
 /* List of supported models */

-- 
2.53.0


