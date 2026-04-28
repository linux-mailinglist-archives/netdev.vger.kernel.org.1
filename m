Return-Path: <netdev+bounces-282085-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHuvKJUl8Wn4dwEAu9opvQ
	(envelope-from <netdev+bounces-282085-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 23:24:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDCF48C49F
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 23:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 94970300531D
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 21:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A84337B00C;
	Tue, 28 Apr 2026 21:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="M3/cPfNF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3F831E823
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 21:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777411472; cv=none; b=kcds9JcFUeMaUCYMmmVZakwhr7uOBPxYV+Qgw5Lo9+6Z1YqKZgeoVD5ZtWQMZJbW4Ohk1mLtEnYALz4bkVCKbQle1G+xzjdmfdWVKH5Nm3a6dPpTNbiCWLUYUzwpCueGzBGyq3mHEx7nD35Uk5cIeWjatls049Wf5MJ3QtfSg5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777411472; c=relaxed/simple;
	bh=9UtQJV/EaPNCkW27ERqANqV/XXm7voiuKSqVPBwhE38=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=azTaQc26F0kU7BQoJYq3ucm1azE7tgPNSD0MDfD2igdLWxnLYlMZ5klJEQ144Jlw76p6VTxKWxhCROQxEE4AED7pru6tnVmcvKyogQjEeTJcQ5Fc0EUH4+uPsDYvQa9j20HTJogfgmENsxgTeXDxCPiLdC31DBI6W/z9KXgY5EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=M3/cPfNF; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-35da1af3e10so11029442a91.3
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 14:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777411470; x=1778016270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vLLG/iOyKBL5v4qoBeyIwKuIHOm9UBqU8GzKiHlJvF8=;
        b=Z+aOHHzHYolPNII6TSD4FaLPnnhxstnTfgjZUN208nV8pbtgD63wVYovNA2i2uLUOR
         gv2aunEEaIOi9G6HZomBbalBMTc7T8mJFQ/cQh06PYJJDYsTmZmPxUYt1CW9c0XRCLG0
         /nlF/XVkOjRbbeZ4AtYq1+T0KKe0Pp0Hpx4jpOpz/DSG6HhBPXBNh5bdhYXgLk6I8jTB
         pe6Gi0C0TI22qP05cy/HWxIaGuKmcO8rPhkU3Ngsl4hRGd0lQTrN8Am60cShcUvTFuwj
         hwdU8MijYmQMsuZlzc/D6lsVy2DRnGy89cq/aSYCCrBoeBVGKp4CcP5xcjywTZBCZ7U6
         3s9w==
X-Gm-Message-State: AOJu0YxCP2gpHT4JumblWwbcAfyw7K9WBQrix79o2Tsj1WLDh0kkF8gl
	XbcKbPvRSTlK0EKLBU5r/R16q6qPG6NB+ghmJ75MA3joM6qB8ozazkU8PXyXiPf+RoEmZ2+1Bzk
	kKqiawa8BtN1kUo0cWN+wu5Dm0/YQRn9AE1M2FUhY0FnlRw8cUHNcPOD4hyR75F8+woq5nD1y6b
	twKOnmnilMX62AnHdJmbRLfHfsLn9Hhm/pYeCmoPLS+Su544Fy+PCJ++NZkU+SDpzNUxmPpSKQ/
	G4nnHi24A==
X-Gm-Gg: AeBDiesr+eb2tx4vEXnGsAhTE0P5aIKWPyDnUxLwgtE0F6wsmYu5EWZW1tfhK3pWlX0
	M76bEAmKvYs1ynBpYJi2xEpVWmUYCGpD7ksQ1N/kvXdsx0rGRdJ4mAQDwWpticCC6K1pl7Pzpxl
	YXr3dAk/uNXlQnuzuw4MYwj5TXpS83Px7KBQ5N9xU55ukX9C6oGShKA0YPp7tCnvBXVu8jnAQvW
	NOOaLXMjns5qNySaXWhGt4JnY59OB9EJ9TpNq3oO0Qoyu3sp3SIRq+aLSVgvx6DyD8rC4P34jZd
	RnOLx6hjZK+oggeUsPt6Nlv7uIcI1Jq8XPD+2j0CNCXEQW02O8ro2KWJcY3sbgJj0ZON8ud65Mt
	/QQ/6Ws/x8LJZB8ghiB8QjyNOGu6BCT0OjjBAFWkb0duH6hhQCe+wwbAnaSFo1dC9Rs5LjElrpX
	6jlIaOHoJhoOFHeA==
X-Received: by 2002:a17:90b:3d11:b0:362:ef2e:5ff6 with SMTP id 98e67ed59e1d1-3649207ac4dmr4844682a91.27.1777411470396;
        Tue, 28 Apr 2026 14:24:30 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-364a02e54cfsm87984a91.7.2026.04.28.14.24.30
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2026 14:24:30 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-12c66fdd4aeso17917607c88.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 14:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777411468; x=1778016268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vLLG/iOyKBL5v4qoBeyIwKuIHOm9UBqU8GzKiHlJvF8=;
        b=M3/cPfNFo/+5lcFepQhnbHVpAkkYEaZQ7QHJsaL2dp2c8pnHpbdatfDsO9NrescTh2
         ua0DeXLJKM7my2+yq3+MQpN2Kr8agoi1+Z+oWMFc7396beoJAYm70acBfs0frnE7brT7
         kh5v6exEHwP2PiMRoqkItAhMo80YeUEX98ZCM=
X-Received: by 2002:a05:7022:ec18:b0:12a:713b:8953 with SMTP id a92af1059eb24-12ddd99afaamr1828157c88.12.1777411468129;
        Tue, 28 Apr 2026 14:24:28 -0700 (PDT)
X-Received: by 2002:a05:7022:ec18:b0:12a:713b:8953 with SMTP id a92af1059eb24-12ddd99afaamr1828133c88.12.1777411467433;
        Tue, 28 Apr 2026 14:24:27 -0700 (PDT)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12de3216e81sm159506c88.4.2026.04.28.14.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 14:24:26 -0700 (PDT)
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
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net-next] net: phy: broadcom: Save PHY counters during suspend
Date: Tue, 28 Apr 2026 14:24:24 -0700
Message-Id: <20260428212424.1828999-1-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 9CDCF48C49F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,google.com,davemloft.net,armlinux.org.uk,gmail.com,lunn.ch,broadcom.com];
	TAGGED_FROM(0.00)[bounces-282085-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

The PHY counters can be lost if the PHY is reset during suspend. We
need to save the values into the shadow counters or the accounting
will be incorrect over multiple suspend and resume cycles.

Signed-off-by: Justin Chen <justin.chen@broadcom.com>
---
 drivers/net/phy/bcm-phy-lib.c |  9 +++++++++
 drivers/net/phy/bcm-phy-lib.h |  1 +
 drivers/net/phy/bcm7xxx.c     | 19 +++++++++++++++++++
 drivers/net/phy/broadcom.c    |  5 +++++
 4 files changed, 34 insertions(+)

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
index 00e8fa14aa77..6cfcf039494e 100644
--- a/drivers/net/phy/bcm7xxx.c
+++ b/drivers/net/phy/bcm7xxx.c
@@ -733,6 +733,7 @@ static int bcm7xxx_config_init(struct phy_device *phydev)
  */
 static int bcm7xxx_suspend(struct phy_device *phydev)
 {
+	struct bcm7xxx_phy_priv *priv = phydev->priv;
 	int ret;
 	static const struct bcm7xxx_regs {
 		int reg;
@@ -747,6 +748,10 @@ static int bcm7xxx_suspend(struct phy_device *phydev)
 	};
 	unsigned int i;
 
+	mutex_lock(&phydev->lock);
+	bcm_phy_update_stats_shadow(phydev, priv->stats);
+	mutex_unlock(&phydev->lock);
+
 	for (i = 0; i < ARRAY_SIZE(bcm7xxx_suspend_cfg); i++) {
 		ret = phy_write(phydev,
 				bcm7xxx_suspend_cfg[i].reg,
@@ -807,6 +812,17 @@ static void bcm7xxx_28nm_get_phy_stats(struct phy_device *phydev,
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
@@ -849,6 +865,7 @@ static int bcm7xxx_28nm_probe(struct phy_device *phydev)
 	.flags		= PHY_IS_INTERNAL,				\
 	.config_init	= bcm7xxx_28nm_config_init,			\
 	.resume		= bcm7xxx_28nm_resume,				\
+	.suspend	= bcm7xxx_28nm_suspend,				\
 	.get_tunable	= bcm7xxx_28nm_get_tunable,			\
 	.set_tunable	= bcm7xxx_28nm_set_tunable,			\
 	.get_sset_count	= bcm_phy_get_sset_count,			\
@@ -866,6 +883,7 @@ static int bcm7xxx_28nm_probe(struct phy_device *phydev)
 	.flags		= PHY_IS_INTERNAL,				\
 	.config_init	= bcm7xxx_28nm_ephy_config_init,		\
 	.resume		= bcm7xxx_28nm_ephy_resume,			\
+	.suspend	= bcm7xxx_28nm_suspend,				\
 	.get_sset_count	= bcm_phy_get_sset_count,			\
 	.get_strings	= bcm_phy_get_strings,				\
 	.get_stats	= bcm7xxx_28nm_get_phy_stats,			\
@@ -902,6 +920,7 @@ static int bcm7xxx_28nm_probe(struct phy_device *phydev)
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


