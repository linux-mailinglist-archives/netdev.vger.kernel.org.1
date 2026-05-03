Return-Path: <netdev+bounces-283548-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HObHQPp9mnhZgIAu9opvQ
	(envelope-from <netdev+bounces-283548-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 08:19:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FB14B4955
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 08:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CBD9301ABBE
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 06:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964703A8737;
	Sun,  3 May 2026 06:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hc2abwCv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B043A7F72
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 06:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777789124; cv=none; b=kLv3tWgbwWD1ijMnvPu/rPjuCYg0GW/l5nFo/sVPbT69FqeEu3EFfRxGlyoX186e7ATFnpx5r7LWpoq3LZ1KOlxnLYc/R8vjxAEXcWizji3yQ45Hd3il1nGiwTxR8WnhCZw+GIzVALVAsuRVGFRFPOU8dOwGR2mc2Z8I0B1LcdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777789124; c=relaxed/simple;
	bh=aHdh0Hk/xa6nprg4PdMeLnNI2TZo7IQk1TicKG2qHEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mJ54+C95blg+ma/JNlsiINlaNAg2sErnf800eEJByedjIE/l5O6U19SgNHJbo/ENLNID8pxqLbk62uD+hmD27lT5ILrIirnO8nQQvkKnHOsef+e26GaRFg3/JIXAcafgMYP0RdoQhYL4UeC2gWcEdo0qVvv3vqj0z5QvbCHWxig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hc2abwCv; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2f0ad52830cso682581eec.1
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 23:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777789121; x=1778393921; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zO76ew4o6bwBsn6iDB7Aqwra9fHtMOz2VvpalpZDKhk=;
        b=Hc2abwCvR46yZDjc8Fzy6pZ2IUnT+vaMoMIEWo1wjjolAus3Oqxg4qDcLkRqtAgrwc
         PKKC1ui7kHHCEu5CXxbHSjjGyUOeunC+zH/tYAYHTwRjEzBgWOZ7XOgmYTbe8xz1sw+1
         fc9aSQQ6GWMII3/fIM3wxJWNQnYHTfyXk31s/gzGq9vG8w80SiFNzlqTYtTAZXIy+KV8
         E2CPXkPESudiizq1NJsQQheic1hwYPQojQiXBsMiLoGZGES585NVe30eXObLqM1uWjyj
         rGUxq63Oy+SBgwOKRWkWKaoG/IgljEZH9h760tUEYM0l+Tc+bLDxuvc5+TvO+j+Ec0uT
         WI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777789121; x=1778393921;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zO76ew4o6bwBsn6iDB7Aqwra9fHtMOz2VvpalpZDKhk=;
        b=nvpogcFUoGv18O6wTIB9GSYqJmZrvK3hCZrT+oaqGwDq0w6tAOMGduDHeAkdOjVcf+
         2pmQ3F+8uROIxuPjqhKtrXVsbZeKtv8KVYK0HaYF5XDO0RWGhdvJ7TDbtpCyTDG5J9Tn
         uB24YG8LpCdBWqdh9soOcowBKlh/W04ALlGXQqnJcjn0hAdlAyq76pj5iLYJSapd/V34
         Up7NQvvG6/gKDRBSIjffv0pQGpgRPceFqjz2QKZ4PzCHFXJkaMk+LMMvU1Oyb3iGEhmx
         3orSsJYzkDWbz/QqFgPp8E+0fF7AiETonA8xGeC5NuDJ3yD22wIz5CuoVL5tRKrjwsAo
         xfIA==
X-Gm-Message-State: AOJu0Yw1Qo0OMC4eiVZDbH0SdDmTOJ9ZMKhNLkr09VODOdogfpZ6bBAw
	EFf033VKi+5HwXZgTU69YeeArbS+ibVMFj9B4pFFcVwnxbZ3ujJ44el1
X-Gm-Gg: AeBDietK1Q0CmJla/Q4oWlfVReF6viN+64FdwmDvRQOjuWQwfUDWNol6NZT8681M2sO
	m3nZztSAzE6h91oiNoLrTLtM8UpbYY5bPd04/aZDr3Y89GoL9JSH5Z8EGIu27YfwZMruslnEKaw
	zcTOzYPtFKlIulDucNHgSIAg30soJibApwRgLj2SNhR8HoHW7L87+5RoIn66uM3c8x32oVPux/J
	FHdDrBLTbB3Jv8G0kNz4ELbRbKNcXMr4pwZInJgGyz2XDDM95ZhFn2y9thRYFX8Ad39F+E3dZ7e
	g3hC9yWKvNtxv6xWP7B66KyE/VpLFQvHh5gCFpLZPFUURpUsicIuUsnH8NWcZaVSWw78oG4NfNj
	XLy+RV/MeQIQfuqOksVB0IgxTcWUmemsYoXl0luvXbozXcPNaVZEynxYrvQSVqR/PEO3uqkgKW7
	DyYvezu4WX6z+PjnltpAq/xn/ZRcXDD4mzRJ5nG5mudNp2y1oK5yBbAydUXvsS
X-Received: by 2002:a05:7300:6c2b:b0:2ed:a64:a457 with SMTP id 5a478bee46e88-2efb9c85886mr2537316eec.20.1777789121490;
        Sat, 02 May 2026 23:18:41 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3bf6811fsm11100344eec.29.2026.05.02.23.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 23:18:40 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sun, 03 May 2026 03:18:21 -0300
Subject: [net-next PATCH v2 1/8] net: dsa: realtek: rtl8365mb: use ERR_PTR
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260503-realtek_forward-v2-1-d064e220b391@gmail.com>
References: <20260503-realtek_forward-v2-0-d064e220b391@gmail.com>
In-Reply-To: <20260503-realtek_forward-v2-0-d064e220b391@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.15.2
X-Rspamd-Queue-Id: C9FB14B4955
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283548-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Convert numeric error codes into human-readable strings by
using %pe together with ERR_PTR() in dev_err() messages.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/rtl8365mb.c | 40 ++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index c35cef01ec26..edbc16345d0d 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -789,8 +789,8 @@ static int rtl8365mb_phy_read(struct realtek_priv *priv, int phy, int regnum)
 	ret = rtl8365mb_phy_ocp_read(priv, phy, ocp_addr, &val);
 	if (ret) {
 		dev_err(priv->dev,
-			"failed to read PHY%d reg %02x @ %04x, ret %d\n", phy,
-			regnum, ocp_addr, ret);
+			"failed to read PHY%d reg %02x @ %04x, ret %pe\n", phy,
+			regnum, ocp_addr, ERR_PTR(ret));
 		return ret;
 	}
 
@@ -817,8 +817,8 @@ static int rtl8365mb_phy_write(struct realtek_priv *priv, int phy, int regnum,
 	ret = rtl8365mb_phy_ocp_write(priv, phy, ocp_addr, val);
 	if (ret) {
 		dev_err(priv->dev,
-			"failed to write PHY%d reg %02x @ %04x, ret %d\n", phy,
-			regnum, ocp_addr, ret);
+			"failed to write PHY%d reg %02x @ %04x, ret %pe\n", phy,
+			regnum, ocp_addr, ERR_PTR(ret));
 		return ret;
 	}
 
@@ -1068,8 +1068,8 @@ static void rtl8365mb_phylink_mac_config(struct phylink_config *config,
 		ret = rtl8365mb_ext_config_rgmii(priv, port, state->interface);
 		if (ret)
 			dev_err(priv->dev,
-				"failed to configure RGMII mode on port %d: %d\n",
-				port, ret);
+				"failed to configure RGMII mode on port %d: %pe\n",
+				port, ERR_PTR(ret));
 		return;
 	}
 
@@ -1098,8 +1098,8 @@ static void rtl8365mb_phylink_mac_link_down(struct phylink_config *config,
 						     false, false);
 		if (ret)
 			dev_err(priv->dev,
-				"failed to reset forced mode on port %d: %d\n",
-				port, ret);
+				"failed to reset forced mode on port %d: %pe\n",
+				port, ERR_PTR(ret));
 
 		return;
 	}
@@ -1129,8 +1129,8 @@ static void rtl8365mb_phylink_mac_link_up(struct phylink_config *config,
 						     rx_pause);
 		if (ret)
 			dev_err(priv->dev,
-				"failed to force mode on port %d: %d\n", port,
-				ret);
+				"failed to force mode on port %d: %pe\n", port,
+				ERR_PTR(ret));
 
 		return;
 	}
@@ -1285,8 +1285,8 @@ static void rtl8365mb_get_ethtool_stats(struct dsa_switch *ds, int port, u64 *da
 						 mib->length, &data[i]);
 		if (ret) {
 			dev_err(priv->dev,
-				"failed to read port %d counters: %d\n", port,
-				ret);
+				"failed to read port %d counters: %pe\n", port,
+				ERR_PTR(ret));
 			break;
 		}
 	}
@@ -1638,7 +1638,8 @@ static irqreturn_t rtl8365mb_irq(int irq, void *data)
 	return IRQ_HANDLED;
 
 out_error:
-	dev_err(priv->dev, "failed to read interrupt status: %d\n", ret);
+	dev_err(priv->dev, "failed to read interrupt status: %pe\n",
+		ERR_PTR(ret));
 
 out_none:
 	return IRQ_NONE;
@@ -1776,7 +1777,8 @@ static int rtl8365mb_irq_setup(struct realtek_priv *priv)
 	ret = request_threaded_irq(irq, NULL, rtl8365mb_irq, IRQF_ONESHOT,
 				   "rtl8365mb", priv);
 	if (ret) {
-		dev_err(priv->dev, "failed to request irq: %d\n", ret);
+		dev_err(priv->dev, "failed to request irq: %pe\n",
+			ERR_PTR(ret));
 		goto out_remove_irqdomain;
 	}
 
@@ -1952,14 +1954,16 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 
 	ret = rtl8365mb_reset_chip(priv);
 	if (ret) {
-		dev_err(priv->dev, "failed to reset chip: %d\n", ret);
+		dev_err(priv->dev, "failed to reset chip: %pe\n",
+			ERR_PTR(ret));
 		goto out_error;
 	}
 
 	/* Configure switch to vendor-defined initial state */
 	ret = rtl8365mb_switch_init(priv);
 	if (ret) {
-		dev_err(priv->dev, "failed to initialize switch: %d\n", ret);
+		dev_err(priv->dev, "failed to initialize switch: %pe\n",
+			ERR_PTR(ret));
 		goto out_error;
 	}
 
@@ -2077,8 +2081,8 @@ static int rtl8365mb_detect(struct realtek_priv *priv)
 
 	ret = rtl8365mb_get_chip_id_and_ver(priv->map, &chip_id, &chip_ver);
 	if (ret) {
-		dev_err(priv->dev, "failed to read chip id and version: %d\n",
-			ret);
+		dev_err(priv->dev, "failed to read chip id and version: %pe\n",
+			ERR_PTR(ret));
 		return ret;
 	}
 

-- 
2.53.0


