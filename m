Return-Path: <netdev+bounces-282992-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +u3INYHF82ni6wEAu9opvQ
	(envelope-from <netdev+bounces-282992-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 23:11:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 279474A8053
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 23:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3ECD2300DE29
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 21:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562403B0ADF;
	Thu, 30 Apr 2026 21:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UtR4CiY/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com [209.85.160.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE50C3AE6F4
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 21:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777583486; cv=none; b=HOO4ZaACw9PhAv/scPUBwjekc4FYRXhjuzG+PS1N3fmK6PhGnOIiDA6h8U34F5EQF34kf/R0PfP/4SDXsO6dZSEILjWZSadsHAKOXpDPCXLrTF4HWH26G31ZG6btcmkSFyAFg+J+49PYb7NRHdjaEihJUODsw/FHXiNcLQ+kPW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777583486; c=relaxed/simple;
	bh=Tvs2Y6dEfG7JIoa6I/MdzMhiXBMCXIecvVgvnHMGwec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qO/23c2U5wK2qF58ENDU+2NmfUJwzrKbmjViMBZzeaX4a0FFAI2D6bweyweC5zJwtFup9qVTf9X5EYG3b3P4/Ckc8NmkfTKZYu0rACJfnjK5JyYMvn4Au8xFcceTPwt7x1wrHf6vCyZDA04RmV66h5A/GpPtR07pWxMf2+OA35Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UtR4CiY/; arc=none smtp.client-ip=209.85.160.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f97.google.com with SMTP id 586e51a60fabf-40efc77933fso891611fac.3
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 14:11:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777583484; x=1778188284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGuDNrM9cC9CuvljB5nsRFoixf3FmlIx1za+l5upQs4=;
        b=kwpo4QYOr/FgQfL+ldepZBMbUJdLH8qnfFmX3B1QxWpJ5FkDqykjvkLGmcm2WDBQ/d
         QJgqrcDMAVIHvadl4FPedj9eKrp9p4AVN8MZKbUDh9P/XU2Cqm2DI8djazIVB098NYzC
         zTITSVjdfwEq3INzfAc1o9FiV8+mv+vKWRX7gTJVcU6F83K9AAXkefdjM7rPyigWJi9B
         bivBOxJaujtNVc+XMoKKLhTBF25AQ/MjUI73Nv/0TS0TyKvkKFFRmzceMYKpiLy6zJds
         28yQRgmHX8fFVdTRMDJROoVHAoxmhG8c6Neo5TDMUSjP18bt6+T/dcjOvFmsLOngXehB
         gl8Q==
X-Gm-Message-State: AOJu0Yz2Jb1NRsUfNyUND/5huHuZpf4LZ4922glw97BADQsesunXLWMF
	U3mTpmVMaHu/Zm6AwGVeukzJxav6IEXelOguowJByAf01GSD80TR8UBd8cJ3Auy+G9zroq787Nq
	ChUmlbrdJfpVIAk+GxfD7M5xw2V5zPZrwXCirCOPZeIsEBQquoF1Al6zFwxaL9MWIq21slw1Uky
	5jaRsXoZ7z1WIjlo4xbz9j3fpiLwzRC7G11beFJA9fCDAjXbkWNzLscCsJFWEJ+JZFdOeB7AHUn
	vb06hcu1w==
X-Gm-Gg: AeBDietYYVE5Rh9UvOs80ugUBMLg7QhRZE8mgstDsLs0wUn28mGhL9UJXfyXotkV3g1
	sdArOeLOhwUEXZ+sBFfGI3vPKNtlsSWBy5pzy2L+QIbkiNu9GRpoeQPKxuKYbtEqu9403WN7rXG
	yi8MuhYcuO5RA42EmczPYzIge0+JMjGHXEG+dcRcRTG86Yjgogme/+6+6oSTPY0Aq5U5TOqJiqE
	dJPTaxnEHTms1pW0ot1qYS4FJTiIBlfM3c+VJ0MUbxRCeAhrthKT++f5t8nw75KLsB4Q6vk1LBF
	oXqednr8076ZQQ2shTsag7/e+TroerRTdP0DcQsP4S002wNTxbjpL/84nE3DPfSP3tBV6QDwm6H
	UqLJ4MZbeh1wV2WR0nB6slaAFHdnN+0YDGLIfknCoOutouCVWszKDBTRqkvZJ6LayZRZJLF94OI
	Ck2G3xryBsbk5qNw==
X-Received: by 2002:a05:6870:b295:b0:417:3421:13ff with SMTP id 586e51a60fabf-43434040a4bmr2757347fac.29.1777583483706;
        Thu, 30 Apr 2026 14:11:23 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-43454d7ea1bsm72005fac.13.2026.04.30.14.11.23
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2026 14:11:23 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50fb6d713ddso24255791cf.1
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 14:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777583482; x=1778188282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vGuDNrM9cC9CuvljB5nsRFoixf3FmlIx1za+l5upQs4=;
        b=UtR4CiY/seFIeHslXXQ5ptBf6w15vsv+j1ZLqCBGA9qJ/7dgKpPTI4KTUOsb7EsEcS
         Gzfntm4XMSEyE0oWsb/en/uHwERv89/2impVsSpLuOIAw93MhZcUdq4t26cZxR0lLKJi
         afQ9NNxZQ7xDfcLLpVck6hU8pPyMNTipkViBA=
X-Received: by 2002:a05:622a:242:b0:50d:7d8a:5d45 with SMTP id d75a77b69052e-5102ae08973mr66384921cf.36.1777583482284;
        Thu, 30 Apr 2026 14:11:22 -0700 (PDT)
X-Received: by 2002:a05:622a:242:b0:50d:7d8a:5d45 with SMTP id d75a77b69052e-5102ae08973mr66384111cf.36.1777583481527;
        Thu, 30 Apr 2026 14:11:21 -0700 (PDT)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5103e595bd4sm1707441cf.24.2026.04.30.14.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 14:11:21 -0700 (PDT)
From: Justin Chen <justin.chen@broadcom.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	linux@armlinux.org.uk,
	hkallweit1@gmail.com,
	andrew@lunn.ch,
	bcm-kernel-feedback-list@broadcom.com,
	florian.fainelli@broadcom.com,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net-next v2] net: phy: broadcom: Save PHY counters during suspend
Date: Thu, 30 Apr 2026 14:11:17 -0700
Message-Id: <20260430211117.2348478-1-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 279474A8053
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282992-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,google.com,davemloft.net,armlinux.org.uk,gmail.com,lunn.ch,broadcom.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

The PHY counters can be lost if the PHY is reset during suspend. We
need to save the values into the shadow counters or the accounting
will be incorrect over multiple suspend and resume cycles.

Signed-off-by: Justin Chen <justin.chen@broadcom.com>
---
v2
- Removed hook into bcm7xxx_suspend(). We dont have phy stats for 40NM phys
  nor shadow stats.

 drivers/net/phy/bcm-phy-lib.c |  9 +++++++++
 drivers/net/phy/bcm-phy-lib.h |  1 +
 drivers/net/phy/bcm7xxx.c     | 14 ++++++++++++++
 drivers/net/phy/broadcom.c    |  5 +++++
 4 files changed, 29 insertions(+)

diff --git a/drivers/net/phy/bcm-phy-lib.c b/drivers/net/phy/bcm-phy-lib.c
index 5198d66dbbc0..b64beade8dd9 100644
--- a/drivers/net/phy/bcm-phy-lib.c
+++ b/drivers/net/phy/bcm-phy-lib.c
@@ -563,6 +563,15 @@ void bcm_phy_get_stats(struct phy_device *phydev, u64 *shadow,
 }
 EXPORT_SYMBOL_GPL(bcm_phy_get_stats);
 
+void bcm_phy_update_stats_shadow(struct phy_device *phydev, u64 *shadow)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(bcm_phy_hw_stats); i++)
+		bcm_phy_get_stat(phydev, shadow, i);
+}
+EXPORT_SYMBOL_GPL(bcm_phy_update_stats_shadow);
+
 void bcm_phy_r_rc_cal_reset(struct phy_device *phydev)
 {
 	/* Reset R_CAL/RC_CAL Engine */
diff --git a/drivers/net/phy/bcm-phy-lib.h b/drivers/net/phy/bcm-phy-lib.h
index bceddbc860eb..bba94ce96195 100644
--- a/drivers/net/phy/bcm-phy-lib.h
+++ b/drivers/net/phy/bcm-phy-lib.h
@@ -85,6 +85,7 @@ int bcm_phy_get_sset_count(struct phy_device *phydev);
 void bcm_phy_get_strings(struct phy_device *phydev, u8 *data);
 void bcm_phy_get_stats(struct phy_device *phydev, u64 *shadow,
 		       struct ethtool_stats *stats, u64 *data);
+void bcm_phy_update_stats_shadow(struct phy_device *phydev, u64 *shadow);
 void bcm_phy_r_rc_cal_reset(struct phy_device *phydev);
 int bcm_phy_28nm_a0b0_afe_config_init(struct phy_device *phydev);
 int bcm_phy_enable_jumbo(struct phy_device *phydev);
diff --git a/drivers/net/phy/bcm7xxx.c b/drivers/net/phy/bcm7xxx.c
index 00e8fa14aa77..71a163f62c0e 100644
--- a/drivers/net/phy/bcm7xxx.c
+++ b/drivers/net/phy/bcm7xxx.c
@@ -807,6 +807,17 @@ static void bcm7xxx_28nm_get_phy_stats(struct phy_device *phydev,
 	bcm_phy_get_stats(phydev, priv->stats, stats, data);
 }
 
+static int bcm7xxx_28nm_suspend(struct phy_device *phydev)
+{
+	struct bcm7xxx_phy_priv *priv = phydev->priv;
+
+	mutex_lock(&phydev->lock);
+	bcm_phy_update_stats_shadow(phydev, priv->stats);
+	mutex_unlock(&phydev->lock);
+
+	return genphy_suspend(phydev);
+}
+
 static int bcm7xxx_28nm_probe(struct phy_device *phydev)
 {
 	struct bcm7xxx_phy_priv *priv;
@@ -849,6 +860,7 @@ static int bcm7xxx_28nm_probe(struct phy_device *phydev)
 	.flags		= PHY_IS_INTERNAL,				\
 	.config_init	= bcm7xxx_28nm_config_init,			\
 	.resume		= bcm7xxx_28nm_resume,				\
+	.suspend	= bcm7xxx_28nm_suspend,				\
 	.get_tunable	= bcm7xxx_28nm_get_tunable,			\
 	.set_tunable	= bcm7xxx_28nm_set_tunable,			\
 	.get_sset_count	= bcm_phy_get_sset_count,			\
@@ -866,6 +878,7 @@ static int bcm7xxx_28nm_probe(struct phy_device *phydev)
 	.flags		= PHY_IS_INTERNAL,				\
 	.config_init	= bcm7xxx_28nm_ephy_config_init,		\
 	.resume		= bcm7xxx_28nm_ephy_resume,			\
+	.suspend	= bcm7xxx_28nm_suspend,				\
 	.get_sset_count	= bcm_phy_get_sset_count,			\
 	.get_strings	= bcm_phy_get_strings,				\
 	.get_stats	= bcm7xxx_28nm_get_phy_stats,			\
@@ -902,6 +915,7 @@ static int bcm7xxx_28nm_probe(struct phy_device *phydev)
 	.config_aneg	= genphy_config_aneg,				\
 	.read_status	= genphy_read_status,				\
 	.resume		= bcm7xxx_16nm_ephy_resume,			\
+	.suspend	= bcm7xxx_28nm_suspend,				\
 }
 
 static struct phy_driver bcm7xxx_driver[] = {
diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index bf0c6a04481e..d1a4edb34ad2 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -592,8 +592,13 @@ static int bcm54xx_set_wakeup_irq(struct phy_device *phydev, bool state)
 
 static int bcm54xx_suspend(struct phy_device *phydev)
 {
+	struct bcm54xx_phy_priv *priv = phydev->priv;
 	int ret = 0;
 
+	mutex_lock(&phydev->lock);
+	bcm_phy_update_stats_shadow(phydev, priv->stats);
+	mutex_unlock(&phydev->lock);
+
 	bcm54xx_ptp_stop(phydev);
 
 	/* Acknowledge any Wake-on-LAN interrupt prior to suspend */
-- 
2.34.1


