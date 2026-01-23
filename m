Return-Path: <netdev+bounces-252956-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAllLFrRc2kCywAAu9opvQ
	(envelope-from <netdev+bounces-252956-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:51:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F3B7A53F
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A88213008A58
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 19:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A89E2C11C9;
	Fri, 23 Jan 2026 19:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bnvrNziP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B8028853A
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 19:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769197877; cv=none; b=IsopxUCASkc2PwDShg1PmVc2TSVfeyN7yW2M1C3fWwWYaohY4PKZrZfbClB1nmTn3HzcNyjRNXTM75ohq/BWF49FGczBMyTixsybmxnkOWPCVUegw03u88TQyBoorlxdLN8W/VX0BieNFg46p1WZr86ywYlbj6KrD2qn5YGCYIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769197877; c=relaxed/simple;
	bh=4cqSz3lY0LahuG/j0CMYaZzp90KYqJNiS3dbc0Xv/6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Acny3rirpdL2mVUIz9cqAAu/rV+Sk4UzLe3sBAdWWQpIx7tPV99BhIbF6hLRIMAzS4X17qyUnlx74Z/L5e6PY5P6NazhGkBZxQg1V6XVfdNRrk7hhYOklgAU1C20tuJlEqsa0aJxWhAI4L9riSvDKA0mNi/LUqajVlN+3A5g6H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bnvrNziP; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4359019da8cso2446376f8f.1
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769197874; x=1769802674; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UmphJA0oiA6TDyGHVSdklpPRPAEFYSyTBQggvAD3gKE=;
        b=bnvrNziP2vYaDnr5/xqykTR6VN32yzrpUFoomi6R1q4j033AkSw2Y+3fIQWTe/fc1D
         CVjkofe0Hjb0ZRj+hIJYZwAStb+99eUynQoynrjuif6Z+AmORtFTurLPIEK5OAEzOmVz
         oPhTeOFaElh2ZmVKuFj4kzQOFcSuEJlArKlJxL1woKQ2M3rlu4hP+yZFXhsp1CMYAM4W
         dvqTgPdGM1d95kq/3VzdN6OkkSp7Mdrsw8aQywf68tC05A3PONWbvSMMK5djnyH2HQM2
         huNHtRSX25ol7GynbEfnQUgK2euKFmFUQnm100ogZ9Cr7/N5vctKyVai/aquSAphUBpV
         KPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769197874; x=1769802674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmphJA0oiA6TDyGHVSdklpPRPAEFYSyTBQggvAD3gKE=;
        b=v85NFI14u/qzqg87R2U/2qp/I73cLS//ZXEReFTfJlgugERR9jM1e2hnVlMH2n2iSw
         Rde7oNOCXZ+HsqBDoUKvgw3oDHU0ruoBJKb3ZGZ/hmopYHyd/4BsGEPfsZ8BI/rywg8q
         Jyr48RdvzlrhB9akVoaDARQDvq/FJik2RBISx0Vr62M9P9VeK58Fqjao+k7zdivMu1QT
         2aV1AC2/jY0UOKEZYBmc32/OncSaQpsRMGsJqw/PDsB4HxBXAlwnO1k00q3E/CbikNt3
         ka5UlxbifZ3lgASi8JLTHTlBP2L1MOc0BPRhVLd2XFgGf5qRUVVVyBvbeUWr2MwfPrAG
         L/dA==
X-Forwarded-Encrypted: i=1; AJvYcCVH7DgGQwVGgePzceW9yntrW6h/5QlsblVMS3JrZiaDdUpGY2yCbCnQxYt6hbZRaU5HjlQP+E0=@vger.kernel.org
X-Gm-Message-State: AOJu0YySv+4DC82432WepCJHL8thGJMrQVN/degvRgIBCAE6Sj27+IS4
	0DEbcUiE9X5/7ZRawDsOrFfNnadYOf3FlFoTQEP+LFi03i0gRia8Uny+vk0zi7XhMzI=
X-Gm-Gg: AZuq6aJYxTg8ZXuVlTMIpq2b1D8a+x3pQzKIoPRhfv39wDgmoBt8J0rDkKP6OrGSMch
	WjmEPpbhucVKICysvutEE240W9W9NFuGs3HF+JKhHcXt1f+jsoVo1lx+phJOOcqbcSI0D6EHaPz
	efnVhU8KeoEPQsBAd5p2mvxD1VaMUWvaVrsadjn3aFXGT/orobp2b75jD4uIDo++bCU3R980/SU
	Supifjd9+EFkKLcYs9e2odVsTOXDPS8SzPC+JVsZTwIyY+5DvgSR0Z75qTpERg03aXh3bqLlT31
	U55y+c9Mnplw7ekrl1wusUOI0g0hF5JKnuzV6TRFI0Lf4fGeNVJtAH0BBGiQPGnZrnCt/gyJbWJ
	cICkIlOlTzfAIWihNp/qdLxdHSMALMq/mLzF5/91TgwN1cn0nQA6qlR29bWFlEvK6mgrWSm8YLT
	R7x3MyFdizvxnZ7D/U
X-Received: by 2002:a05:6000:22c1:b0:42f:b707:56f0 with SMTP id ffacd0b85a97d-435b1605719mr7557722f8f.37.1769197874256;
        Fri, 23 Jan 2026 11:51:14 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f742d6sm8529079f8f.30.2026.01.23.11.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 11:51:13 -0800 (PST)
Date: Fri, 23 Jan 2026 22:51:10 +0300
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
	Frank Li <Frank.li@nxp.com>, linaro-s32@linaro.org,
	imx@lists.linux.dev
Subject: [PATCH v4 1/3] net: stmmac: s32: use a syscon for
 S32_PHY_INTF_SEL_RGMII
Message-ID: <8f2139e8adf02b485a4c84d558fc23f78cf04add.1769195864.git.dan.carpenter@linaro.org>
References: <cover.1769195864.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1769195864.git.dan.carpenter@linaro.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,linaro.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252956-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[16];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 12F3B7A53F
X-Rspamd-Action: no action

On the s32 chipsets the GMAC_0_CTRL_STS register is in GPR region.
Originally, accessing this register was done in a sort of ad-hoc way,
but we want to use the syscon interface to do it.

This is a little bit ugly because we have to maintain backwards
compatibility to the old device trees so we have to support both ways
to access this register.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v3: no change
v2: no change
v1: Fix forward porting bug.  s/PHY_INTF_SEL_RGMII/S32_PHY_INTF_SEL_RGMII/

 .../net/ethernet/stmicro/stmmac/dwmac-s32.c   | 23 +++++++++++++++----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
index 5a485ee98fa7..2e6bb41f49e1 100644
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
@@ -40,7 +44,10 @@ struct s32_priv_data {
 
 static int s32_gmac_write_phy_intf_select(struct s32_priv_data *gmac)
 {
-	writel(S32_PHY_INTF_SEL_RGMII, gmac->ctrl_sts);
+	if (gmac->ctrl_sts)
+		writel(S32_PHY_INTF_SEL_RGMII, gmac->ctrl_sts);
+	else
+		regmap_write(gmac->sts_regmap, gmac->sts_offset, S32_PHY_INTF_SEL_RGMII);
 
 	dev_dbg(gmac->dev, "PHY mode set to %s\n", phy_modes(*gmac->intf_mode));
 
@@ -125,10 +132,16 @@ static int s32_dwmac_probe(struct platform_device *pdev)
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


