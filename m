Return-Path: <netdev+bounces-270953-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8F7EKOhZwmnQbwQAu9opvQ
	(envelope-from <netdev+bounces-270953-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:31:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E863059E1
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 054433011078
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 09:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF9D3DEFE6;
	Tue, 24 Mar 2026 09:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VYEdNHVv"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766D53DD521;
	Tue, 24 Mar 2026 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774344109; cv=none; b=PHamASw+vDOIy1zFEqBZKC/n/uspIXQoZM+B3BjKp0AD+Zt9g42ZHoVbRBaqG3Lb4ssPXAY1hTdEwtPJF0DUe5a6Ao1FCeNn9RUeEtN/xB4+R5ii+/m0eI4QOsaggdQRxHtluOHwRRgUvgSJxejOfKqOYXYbgH9g1hyLaD2adR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774344109; c=relaxed/simple;
	bh=mng/OGMm2oi7vuZLgmgl6YVSPPsyhWXT10AzJCrskxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okeqflKDEm8LJGIMMjdZExDEJfgOvyhSDN0KhnDp9rM8SwRxsGD+vYshN6js0TzpGdHgHPdWc83hCBhdDEgtO90sTMhxfff98PnL7n28zmg5mFqejrUhRifPwNLevlqbrqPQ7NcMCUxLteOn8AqYNBtHMlnTj+j1JUCz83jXxq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VYEdNHVv; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 53C6CC5809B;
	Tue, 24 Mar 2026 09:22:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 217826011D;
	Tue, 24 Mar 2026 09:21:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 572B9104511A8;
	Tue, 24 Mar 2026 10:21:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774344093; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=E0H4SZ3DlYEVqlzu6JJsZInSW5jEBx0hElRQGDXixpQ=;
	b=VYEdNHVvZITYjJxp+4w6ZHknWDgFyGHrKUuXfDFyQ/1eR/CXJ2M4JdSFABSwxtSEeDjrVH
	mIsjeTUysEzm19uEMT6hr69dbUrpmVQ6oRtJ4CO9ZNOB0R4c95R9tDbRx6H9tN0ZSCPcOP
	/FJExyqWh+lqxlw6RRjFeVaOcvsQzXMxrG9Jb6NeD+g0TH/eOVSPWU3mTobdX4J+gQuEgT
	6i4y85EFRH4wkXZVGQDeWDRu/RreMOVxlFvm5lpViKtR7ziRVfUoM/9zDq0X2sR4Xtwqj1
	1sjlfyKgE7TRWz3CPcOD6X6zLPotfFPmtVX/kAWkAjzc7jBJ+u+M+XP67BYAuQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Rohan G Thomas <rohan.g.thomas@altera.com>,
	Mun Yew Tham <mun.yew.tham@altera.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH net-next 5/5] net: stmmac: dwmac-sofcpga: Drop the struct device reference
Date: Tue, 24 Mar 2026 10:21:00 +0100
Message-ID: <20260324092102.687082-6-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260324092102.687082-1-maxime.chevallier@bootlin.com>
References: <20260324092102.687082-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_TO(0.00)[lunn.ch,kernel.org,davemloft.net,google.com,redhat.com,gmail.com,foss.st.com,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-270953-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 65E863059E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We keep a reference to our the struct device in the socfpga_dwmac priv
structure, but now it's only ever used to produce logs in the
.set_phy_mode() ops, that are specific to this driver.

When we call that ops, we always have a ref to the struct device around,
so let's pass it to .set_phy_mode(). We can now discard that reference
from struct socfpga_dwmac.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c   | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index ae40de2ed8eb..1d7f0a57d288 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -53,14 +53,14 @@
 
 struct socfpga_dwmac;
 struct socfpga_dwmac_ops {
-	int (*set_phy_mode)(struct socfpga_dwmac *dwmac_priv);
+	int (*set_phy_mode)(struct socfpga_dwmac *dwmac_priv,
+			    struct device *dev);
 	void (*setup_plat_dat)(struct socfpga_dwmac *dwmac_priv);
 };
 
 struct socfpga_dwmac {
 	u32	reg_offset;
 	u32	reg_shift;
-	struct	device *dev;
 	struct plat_stmmacenet_data *plat_dat;
 	struct regmap *sys_mgr_base_addr;
 	struct reset_control *stmmac_rst;
@@ -243,7 +243,6 @@ static int socfpga_dwmac_parse_data(struct socfpga_dwmac *dwmac, struct device *
 	dwmac->reg_offset = reg_offset;
 	dwmac->reg_shift = reg_shift;
 	dwmac->sys_mgr_base_addr = sys_mgr_base_addr;
-	dwmac->dev = dev;
 	of_node_put(np_sgmii_adapter);
 
 	return 0;
@@ -382,7 +381,8 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 	return 0;
 }
 
-static int socfpga_gen5_set_phy_mode(struct socfpga_dwmac *dwmac)
+static int socfpga_gen5_set_phy_mode(struct socfpga_dwmac *dwmac,
+				     struct device *dev)
 {
 	struct regmap *sys_mgr_base_addr = dwmac->sys_mgr_base_addr;
 	phy_interface_t phymode = socfpga_get_plat_phymode(dwmac);
@@ -391,7 +391,7 @@ static int socfpga_gen5_set_phy_mode(struct socfpga_dwmac *dwmac)
 	u32 ctrl, val, module;
 
 	if (socfpga_set_phy_mode_common(phymode, &val)) {
-		dev_err(dwmac->dev, "bad phy mode %d\n", phymode);
+		dev_err(dev, "bad phy mode %d\n", phymode);
 		return -EINVAL;
 	}
 
@@ -440,7 +440,8 @@ static int socfpga_gen5_set_phy_mode(struct socfpga_dwmac *dwmac)
 	return 0;
 }
 
-static int socfpga_gen10_set_phy_mode(struct socfpga_dwmac *dwmac)
+static int socfpga_gen10_set_phy_mode(struct socfpga_dwmac *dwmac,
+				      struct device *dev)
 {
 	struct regmap *sys_mgr_base_addr = dwmac->sys_mgr_base_addr;
 	phy_interface_t phymode = socfpga_get_plat_phymode(dwmac);
@@ -552,7 +553,7 @@ static int socfpga_dwmac_init(struct device *dev, void *bsp_priv)
 {
 	struct socfpga_dwmac *dwmac = bsp_priv;
 
-	return dwmac->ops->set_phy_mode(dwmac);
+	return dwmac->ops->set_phy_mode(dwmac, dev);
 }
 
 static void socfpga_gen5_setup_plat_dat(struct socfpga_dwmac *dwmac)
-- 
2.49.0


