Return-Path: <netdev+bounces-255143-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KA8VBCWwfGmbOQIAu9opvQ
	(envelope-from <netdev+bounces-255143-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 14:20:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63714BAEDA
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 14:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B01D5303A85F
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 13:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2E029D26B;
	Fri, 30 Jan 2026 13:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YjpGsNaF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E58429BDBF
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769779188; cv=none; b=FfEtbu6TcVnhV8TbvhqpfkM6IFykT2x932eFf3WzakpB7awc+rzKvAJT2wAxlvlV8ZxyHXNed290U0v60tp4p5v3hdUGFHGNGg4+glRYQ5usuNbe9FwYJcYWLFNmdnj4imVAiNVuhzaB+8VrBkMFPNMrw/njls7cQfE3IE3u+EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769779188; c=relaxed/simple;
	bh=JIWN/nz8WfABssRSPSTUU++BJd0SMkAIZLvPDkubCn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsrWORUlvrrjghUhG7spCMaIPBZcClyykZI6G+WeiHsmcALj6XPAdqbaRplbxTn2FDWOKDav6jHqlL0OIPpCws9NmHH1FYnhOP5wy6dzb5ls8MCKnqFrilAt7xCpkxUmYs6VpfCMO8Iu9AnIwMDEQsYxMjvj9qCyFqsiYQYpSVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YjpGsNaF; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso18850755e9.1
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 05:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769779185; x=1770383985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6LftfxHAZaora2yPEdmX+khpJwn0jgto61bYSOyCgE0=;
        b=YjpGsNaF7onfNlWdQaIItSmmUUM+3B6xss/znwrsGgV+wWiIpT6zmegAej8arTMecM
         cdNBNouzSqYtc1ZsZ0PpJbvoeAg3Pe74LU0vQpju5dLC7roFDfFAdY006GKY/N4CG0U5
         awF3LIT1qiqKwdpmnqoAQ92aE6z/K5k79PPi3dXunhtchHjCM5vjg30fFUEd85fr+Ci3
         4gn7iRYqfSHuVkhsrrIxW63WH4hB3/fnr7DfqKFWBcQHw+33nUiBMMApYVplykMJswMr
         CtRgcrwxrrNJFD0GDdSh5gLA571HWrdhSmd+Ksdfrf2RUSXnVUW77yT+S2U5uHFppdTh
         H/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769779185; x=1770383985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6LftfxHAZaora2yPEdmX+khpJwn0jgto61bYSOyCgE0=;
        b=Tr6rsSvhfSXDYOCG3dsE03EJ55NARPYvYOBXuWNhlgn+iE5LjS2Zf45ikZygL4JeZl
         JFd/Q6wouzxgFxA0dFl3QJSFYmiQIQHgckBfxIF0nKXwwTDOvA3VdiJydAmxMWwGCEVt
         +mS7b8hFHPW857OPrkr1Bnckd2sbW8IBE0GywtJ7OG+wt/X8m0VrOkS+EDabmMEdPT5a
         +lZ7ykZkbWGHJNxVj0zJ/SQfRworOQ74dy+/i4detHPxSP7XDaCqq73Gl5yQ1aAAcmgE
         CC9CdP3kktakTyN0bhjKH5vP+SzvXKBJmLc0mleyebJ15UxU4+yknVOO0I7/DIu+1eK7
         i6WQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvH0BBo/PFrnua6uBZw8avnxPiQLa/ydEwvYeB50xiDGaM5YB6OUS5vTDyhS1iPj0Ae+CLnoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMj72ZStvde2bO7UaBGHY6X1492T1BAo1PK5Ussu7VDRxcDCbP
	nIL1jUy2Yn/MPGPfx9SW+rZ5RkD1/bO97WUQmA/YbSOcKJKXge4iCdXtg7jFtGiHV4c=
X-Gm-Gg: AZuq6aK4Hy2UW7xXdwjn/xs1+yUbL/LMAIbu5sgzSaGv/r8BhZVtYplHDh7sEz3Veqn
	6t9uoyPDFFfJATaMcVKyPHKEKSMJuSqt0z3TelIqeGUw7XU5BXI+R76IpGtF/TmzAsMRNHpD2sf
	R6FtKVl9tqrefHvOZUV6UNCBhxGcqyNJaWxMdHqh/XgHk/13C/RPFfd43bHBBYRlMNKehTv/tzh
	kmq8FHY3G6foaDxvKNIA1zSfTmU8wT3IhcpYEwixNUTf92cFu7ep6OymrJBqJ0LVhAMTmTMr2rs
	uhobRzqFUDTvTzln2CoTUrPPoH7fbFAdzySiBvOLnMKkkBpPk2FQyJQ7wukVBbpa0e7OhdjtMI3
	+Rvj13U/JekowlEjyaR5RyCcYSHpUvO6fr4rKXH1D1pEChePUq01CvZqEhGljIsWgZV5wT96ZoN
	ID/JK9KAUZwBZ5ftrg
X-Received: by 2002:a05:600c:680a:b0:47e:e051:79ee with SMTP id 5b1f17b1804b1-480828745d7mr89683285e9.3.1769779184609;
        Fri, 30 Jan 2026 05:19:44 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cdd77b8sm200882875e9.3.2026.01.30.05.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 05:19:44 -0800 (PST)
Date: Fri, 30 Jan 2026 16:19:41 +0300
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
Subject: [PATCH v6 1/3] net: stmmac: s32: use a syscon for
 S32_PHY_INTF_SEL_RGMII
Message-ID: <b6b60d03344d070b2b4db7f0f00527f166e594e0.1769764941.git.dan.carpenter@linaro.org>
References: <cover.1769764941.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1769764941.git.dan.carpenter@linaro.org>
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
	FREEMAIL_CC(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,linaro.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-255143-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,linaro.org:email,linaro.org:dkim,linaro.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 63714BAEDA
X-Rspamd-Action: no action

On the s32 chipsets the GMAC_0_CTRL_STS register is in GPR region.
Originally, accessing this register was done in a sort of ad-hoc way,
but we want to use the syscon interface to do it.

This is a little bit ugly because we have to maintain backwards
compatibility to the old device trees so we have to support both ways
to access this register.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
---
v6: Add Jan's R-b tag
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


