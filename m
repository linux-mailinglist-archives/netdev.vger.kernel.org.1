Return-Path: <netdev+bounces-254178-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBI0GcjceWnI0QEAu9opvQ
	(envelope-from <netdev+bounces-254178-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 10:54:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B44E49F094
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 10:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B624A3010BAE
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 09:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E639B34D391;
	Wed, 28 Jan 2026 09:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SyWryHYQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377B234AB05
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 09:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594048; cv=none; b=en3ZBizi5rZpcjfEYknUM/QCm4cCacdDdlQluQE1Fy6LfygiidSVPfaC86La/thXjKpOdhyIhyexvjf3uxUcyRFyhW05skqgItshzuQ4cVtkC3hwEemuNtYGOvxNElOvb8qYvvLgBiJUN6qnZsclHicuWNa2x4joOOMFjUeipEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594048; c=relaxed/simple;
	bh=iUYNzaQn+dgqqmhuq2Vji7cyU4pKHLtBGG8gHzmw9NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/Tp0ZVw8Ut41PhP+zMKbYr9y8rTBbQkj8ych4iMg5Bs6m3x902Bml4qpZiZrGXnunOxWiVtzsAac+9tKeyJCuRgn7CtiYSDcbz/BhL0FXx89FloJ0kod6O89wrp+n1Sq5Qz3iBKf3Ov4bnzMTyw6ZJM4vsOo40872dK+2miIio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SyWryHYQ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4806f9e61f9so2027185e9.1
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 01:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769594045; x=1770198845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/27C/CNBZB5U2mainQlNU7Fdsq/MruiST5P1Ff/65Ew=;
        b=SyWryHYQuKNBzalXBLMos7RsCjeBesQqIc4mQFkD50uKKKN49ufwSG5eYB/tDNkDCY
         VDtERV/SdQtK0/OpSFiTMZnqAgSfYynu9Pzjy+vKN426Rf9+Ls0oZcaROKdutaMy69qU
         lhQk+u6u1qCtCrnoccEa/1nONZxoVlVNTvJ2XuGS9bbKA1gRbeSuVx3hvSqC4w8SGfJw
         nWI6waavJza0Pzo5dHS7q9oidWjcZU7wPJHNusLQbtkZJBMPNNpstRGICwaBrYcO4TP6
         wOkXgi6oP0Pp8pvV4OvEPo3Sl3tCvrVAGLSM8EfgAlz75FHfGlNrvDtJaZCJk4qp8aUX
         5tMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769594045; x=1770198845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/27C/CNBZB5U2mainQlNU7Fdsq/MruiST5P1Ff/65Ew=;
        b=OCHIBMtVYQ1C9Jdxlx2zWgU1a2nCUlXYZMRtIdZDY2e0pP+Tnk+zafgrQQYsDUWAnL
         /l6u484wxSbAfAfYXjbZ5rC/EM65KIds2SZbjV+aiXPskdGWRlhbOm+gzJ+XvR6NNKd9
         3pDm6k/k3gzKd+LwM3CTtLRF+AH/WRk+J0HHPvZlABWu33X8O9Wyg9pFKPsWcutn4JL7
         k0NO/+7chqH8sFWJs1dHt3ZVvcNmO2yUk3l+5BaItcP7j1sZczrCyIk0rdK8vp5dmeUX
         C8S4NUBE2u17FvD+X3GFgumUzVPtFwiFdMFg22fr3dtS2gcMFrYFnWMRPOZIVDYta+rc
         Y79A==
X-Forwarded-Encrypted: i=1; AJvYcCV93hNxrhxwhof2P4AdlBTBW2IncEKWpZil5VU8QkOSznWeQ8g450/rLyAYCh1VUfBBjeA4yJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHBYeKTp2pSFuPz4pBhM4aXQIl9yTGMyGeCCJcfKwthqN5PGRP
	1kKqAUwlpEBxHaMphN0Ylf4FOHI4woSazHl1Fgp1KET3J3TaTpMC2i88smwOPDHgLrs=
X-Gm-Gg: AZuq6aIROASeKDmoF7auKmMzG31CNd1hiUaHZbPmLzAQ3dgKJMsMNIE9Xu9yPNqd4xt
	wnEfpPbbxmAk5NpmWN/Jfbbid2/yD6B0wojy+/vm2sOVrGKalG2yLxK1udMoTySopb+/HLWm3OK
	wW6JgS566NQ6igt2dXmjqlldWBgeYkLu6zPw5DmwEWWXvIDDmLPoB2R5dHPYUB15UOMhzbTF16G
	rOmGmygRfhbhpijgs6q+2FtI99+7HMGd7W9eTkQ7IEDsNUn7oo2ACFHx1SALeH2Hem56WMwrBbF
	4cjEONC85OQwYZPG28iQwRjCdU9XTiizKPxe1RFHCiUYeAWRp9EE4PqRRowGorRSV7f3Vu8SiPY
	mQrXVSzua169rtChSFq7cMzN2PA2DQv1WamjF098Q1c8Hjluvx4IeEp1YpMn4Qv+EM8rYyHBZ+V
	v/G1Ge5UbpHtD3q4l8
X-Received: by 2002:a05:600c:458a:b0:47b:e2a9:2bd7 with SMTP id 5b1f17b1804b1-48069c6970fmr53235125e9.19.1769594045452;
        Wed, 28 Jan 2026 01:54:05 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806ce4c3d1sm51986545e9.9.2026.01.28.01.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 01:54:05 -0800 (PST)
Date: Wed, 28 Jan 2026 12:54:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jan Petrous <jan.petrous@oss.nxp.com>
Cc: s32@nxp.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linaro-s32@linaro.org, imx@lists.linux.dev
Subject: [PATCH v5 1/3] net: stmmac: s32: use a syscon for
 S32_PHY_INTF_SEL_RGMII
Message-ID: <b38f1c628cdac8e87271e5fa4e2b71110c15b42c.1769592679.git.dan.carpenter@linaro.org>
References: <cover.1769592679.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1769592679.git.dan.carpenter@linaro.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,linaro.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-254178-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:email,linaro.org:dkim,linaro.org:mid]
X-Rspamd-Queue-Id: B44E49F094
X-Rspamd-Action: no action

On the s32 chipsets the GMAC_0_CTRL_STS register is in GPR region.
Originally, accessing this register was done in a sort of ad-hoc way,
but we want to use the syscon interface to do it.

This is a little bit ugly because we have to maintain backwards
compatibility to the old device trees so we have to support both ways
to access this register.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v5: Return an error if regmap_write() fails
v4: no change
v3: no change
v2: Fix forward porting bug.  s/PHY_INTF_SEL_RGMII/S32_PHY_INTF_SEL_RGMII/

 .../net/ethernet/stmicro/stmmac/dwmac-s32.c   | 28 +++++++++++++++----
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
index 5a485ee98fa7..af594a096676 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
@@ -11,12 +11,14 @@
 #include <linux/device.h>
 #include <linux/ethtool.h>
 #include <linux/io.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of_mdio.h>
 #include <linux/of_address.h>
 #include <linux/phy.h>
 #include <linux/phylink.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/stmmac.h>
 
 #include "stmmac_platform.h"
@@ -32,6 +34,8 @@
 struct s32_priv_data {
 	void __iomem *ioaddr;
 	void __iomem *ctrl_sts;
+	struct regmap *sts_regmap;
+	unsigned int sts_offset;
 	struct device *dev;
 	phy_interface_t *intf_mode;
 	struct clk *tx_clk;
@@ -40,11 +44,17 @@ struct s32_priv_data {
 
 static int s32_gmac_write_phy_intf_select(struct s32_priv_data *gmac)
 {
-	writel(S32_PHY_INTF_SEL_RGMII, gmac->ctrl_sts);
+	int ret = 0;
+
+	if (gmac->ctrl_sts)
+		writel(S32_PHY_INTF_SEL_RGMII, gmac->ctrl_sts);
+	else
+		ret = regmap_write(gmac->sts_regmap, gmac->sts_offset,
+				   S32_PHY_INTF_SEL_RGMII);
 
 	dev_dbg(gmac->dev, "PHY mode set to %s\n", phy_modes(*gmac->intf_mode));
 
-	return 0;
+	return ret;
 }
 
 static int s32_gmac_init(struct device *dev, void *priv)
@@ -125,10 +135,16 @@ static int s32_dwmac_probe(struct platform_device *pdev)
 				     "dt configuration failed\n");
 
 	/* PHY interface mode control reg */
-	gmac->ctrl_sts = devm_platform_get_and_ioremap_resource(pdev, 1, NULL);
-	if (IS_ERR(gmac->ctrl_sts))
-		return dev_err_probe(dev, PTR_ERR(gmac->ctrl_sts),
-				     "S32CC config region is missing\n");
+	gmac->sts_regmap = syscon_regmap_lookup_by_phandle_args(dev->of_node,
+					"nxp,phy-sel", 1, &gmac->sts_offset);
+	if (gmac->sts_regmap == ERR_PTR(-EPROBE_DEFER))
+		return PTR_ERR(gmac->sts_regmap);
+	if (IS_ERR(gmac->sts_regmap)) {
+		gmac->ctrl_sts = devm_platform_get_and_ioremap_resource(pdev, 1, NULL);
+		if (IS_ERR(gmac->ctrl_sts))
+			return dev_err_probe(dev, PTR_ERR(gmac->ctrl_sts),
+					     "S32CC config region is missing\n");
+	}
 
 	/* tx clock */
 	gmac->tx_clk = devm_clk_get(&pdev->dev, "tx");
-- 
2.51.0


