Return-Path: <netdev+bounces-284531-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIAbO8Ir+mkhKgMAu9opvQ
	(envelope-from <netdev+bounces-284531-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 19:41:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE4F4D237B
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 19:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5E2043027267
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 17:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D494A33E1;
	Tue,  5 May 2026 17:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aMfKbg6T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5984A48B39C
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 17:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002777; cv=none; b=LV7Rmb6R8oy1QMkqPasZWD0fhrquEAlPfu1t0ahSgJkRpYxeFUMYTB01p+kjyeyuCmAy7BzKRxPWRmZ7ch5DWylTzzVBbZE9McPBKCW/eDsMfPhZkF1a90TFrTjdCQPxgZ/7I52JA5b1zMlIRIlNOQu9FgraIlLgtDOG7X1VZeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002777; c=relaxed/simple;
	bh=hOx8wYFu69T7UqL87tce5GNKx6tUvW3fvS1pbp/gOa4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gi5jt2YDpCqKe8MalpXPS3ItqgMX+5qnAjWwHfgOPckOsSge7L9ruhQKMfl6OOBf65P5ifVKbQPef7C3s4ZFilofRA8ygBoZIPpJfL2NnXfm1IZak4p/5J/A1GyxrP8GTCbncgVy32qH7aZ7u8omXgMGIDNA6ls/oA2GgQHY9Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aMfKbg6T; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-365425c98c6so1912470a91.0
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 10:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778002776; x=1778607576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ak8uCCdJ9WoLNd/t9XxTpdA0O+s8kR1F5gLQbZnejoU=;
        b=qTfSbkoykIPiaFLU6IFnqaPqDS+jK5ycb70jGI1Qx/OzwfXcQnngb0WdUkaV4UQLD+
         4ZxycIb4/UW9dPzT1YJbsO3rqoNh7OAeblIOxj4/udCADLqp9rYZn/YpSYImNhknWwDw
         t4zSmBn/RBL+K6FfoC6C7nYPOnkSrmMem/YQQmer0eY6CC2dGN8iemesLJGzDhTboMnk
         ntHIKg27M5co4KF56HO0O0RUXY+HeP92i8barhkc86zvM/Vu3a5cfWdLtlfWTHdhkt+U
         JdZhFDFiIuJjmYcW1XCbcOo+4rOL/2VV+lUbzvJlakIUcXIzbYsfOyrNyK8YNmmxsbIO
         2XHg==
X-Gm-Message-State: AOJu0YwUKXpPeOcJfD+ONqIdqfytOL/zgQjcj/8GvRh7JxR6kb1pPXG5
	cXbg1o1FleDYR4qzSyGn7sr6iyQyM5eCxYTDK29bfPc1Tc2CJ5sxNnEOSXvXkVyWHuiSW1dh8Zw
	LhhZMLC89InjdC4BZbFK/+xqscGWPwJSfBhnqW9QDkqV3wonnNlG4kPTnHt9VVGTGrP3W8tY/56
	lmHgnak5uaiRUKuuCm3KEWrJHFsJbpoKtzPubwZz8foJ9NfT3t/sRJAtizv4xjcEVtU46JE76NV
	F3GVYHzvQ==
X-Gm-Gg: AeBDiesCyjpcKH4SpA6XZEyJnplopCkLnaumAck6ggSjJnYW7K3WwmqUx5KvdkX4tpM
	+e5DttaQnyrVTyZ7/bPHU03WziT23uddXiWGsQasMEHEw0KB3u1EE+SwU83R03nOpqGGs+zL7nM
	KBBvoMPdlzbFaMWhNlXJwJmZ+aAis4CT/IzKS+N6YNACoNuPjVMC4sbN8qsb0IhYUIaMs/Fp2mw
	RT79WUsQ6jkCjWaEyg00ECxc3gxX0wn/wm926UmTF1kGgXuzF9hDJvym5IzrN2frmA6cUPPEgMU
	e5fm5ErpUVkJY/QrdajxWiZ+GNp6Z7EmSVTHAhisfI+yqsTSrS30Nmd6gZRjO1yhWJit3HXlLIA
	uA9f2cjRSoTv37Io+0mdNxHtPCytmu4jbMIAkRcMiUrIxr+xloR+r24vGPUiEL6ykHFAzjVAgTL
	+WeQg80Y4gN83nEy8b1BKZsVCvtz2mUTO0xCvvHteVeSEbGXajvAPfCyRRdZp8+LCBjzOUcIsLK
	bSI
X-Received: by 2002:a17:90b:3849:b0:364:87dd:b2c4 with SMTP id 98e67ed59e1d1-3650ce73938mr15471455a91.25.1778002775612;
        Tue, 05 May 2026 10:39:35 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-365a49eb5f6sm6614a91.0.2026.05.05.10.39.35
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2026 10:39:35 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-131371497a1so1136600c88.0
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 10:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778002773; x=1778607573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ak8uCCdJ9WoLNd/t9XxTpdA0O+s8kR1F5gLQbZnejoU=;
        b=aMfKbg6TbBtyjj58nRQQxjQvc/fSP5cvBqf0LR9dFBHeZ0RUDBnzTRVUbM3m7DDxFC
         GVcYXhGcB+FjV7a9FGUR4M5JkH2pTQBg722BL5vS8iSUJbB3bjHliRe4SR4z1nksP7MW
         skv7lzUJUXJiUV2KKfJbCarNe/IjvMbfVDSyQ=
X-Received: by 2002:a05:7022:689e:b0:130:a479:79a5 with SMTP id a92af1059eb24-131853ebb11mr126066c88.4.1778002773538;
        Tue, 05 May 2026 10:39:33 -0700 (PDT)
X-Received: by 2002:a05:7022:689e:b0:130:a479:79a5 with SMTP id a92af1059eb24-131853ebb11mr126029c88.4.1778002772853;
        Tue, 05 May 2026 10:39:32 -0700 (PDT)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df84252c0sm24557221c88.10.2026.05.05.10.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:39:32 -0700 (PDT)
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
Subject: [PATCH net v3] net: phy: broadcom: Save PHY counters during suspend
Date: Tue,  5 May 2026 10:39:26 -0700
Message-Id: <20260505173926.2870069-1-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 0EE4F4D237B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284531-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,google.com,davemloft.net,armlinux.org.uk,gmail.com,lunn.ch,broadcom.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

The PHY counters can be lost if the PHY is reset during suspend. We
need to save the values into the shadow counters or the accounting
will be incorrect over multiple suspend and resume cycles.

Fixes: 820ee17b8d3b ("net: phy: broadcom: Add support code for reading PHY counters")
Signed-off-by: Justin Chen <justin.chen@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
v3
- Added fixes tag and moved from net-next to net.

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


