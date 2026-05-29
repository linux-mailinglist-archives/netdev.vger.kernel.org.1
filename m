Return-Path: <netdev+bounces-292961-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOsYLswWGWoMqQgAu9opvQ
	(envelope-from <netdev+bounces-292961-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 06:32:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFE15FD01F
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 06:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2A54304A6CD
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 04:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02E3370AE0;
	Fri, 29 May 2026 04:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAq+xf9J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B233367B93
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 04:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780029025; cv=none; b=MW+yOTcjgFzdFAEdYb3k+ZdeEs+NfAErP/Pj1vWrkZVWt47jUI/7C9tQKxJ8bSCfY/882Z/GQcQEr+IMeG64GAjUxb4O4hkISpmJgr2Vn00ReH+Pgr+WIhNJmJJlATAH6Jf+iu9450NYEPoeYuBBdNC4QSRWaBj2Pi6E4e6vqQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780029025; c=relaxed/simple;
	bh=6vvUpEnA3zuZyhkh5L9tx3acH0/PiR28xnODKHfdVgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SueN0YK8WgoFmh4tOkmQfEiAA/PxN53v0d/DmI6DvkRYUW+MBUWVskoh80tMzKKaiOcD5o0L2jBW0DEirvoSW0uAEuQCBrJFQd4CHDj4e9FlAkNwsSzlJH31IJPjzk95aYhcT6u0lIKfQVCgtsAL8c8OUeNK9nWCfNX5vJ/jcGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAq+xf9J; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-516d0db9372so65629601cf.2
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 21:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780029023; x=1780633823; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rgdsNgCTJpv8k0KRcqQg2bYC+LqfZpfIBBy5KwRLQzE=;
        b=TAq+xf9JiV39zwLD4ZW74QWi/QYU/b5qx+w9hdXs0pPTJukhFeAS4+JY0u+yup/f4r
         +CyJAXqQ15zS9AayuDCUHHEYwL4SH2bAfkHqpKA49uABrbJIUnoW/gaDqwa6q3JPacs9
         I5nr0DEdS3MXfESlqwqX2KMZq3dgrBmJ3WC04uPPPzTOI3ckwkGbXUxkBXfQ0YgqcaS4
         HoVRBH7P+heiq8kw8lw/x0r7128+Tkuj6xQ0fhjzkFXMcFwY0G/CbAX1FHFpZtYTpjVT
         sEjITljRaImhVvCwqbY/8S2QdU3P26CfVzpA4EKNwvdVrSJU9Ku+pH2rDhgqg5jwA3HM
         6M0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780029023; x=1780633823;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rgdsNgCTJpv8k0KRcqQg2bYC+LqfZpfIBBy5KwRLQzE=;
        b=hLwTDXRHRZFUK3VhWUxJWIIaEFfa4En02tIoilGoGuJqzZhXx6bGI/LudlljBZFsR2
         zhetBBX7ahx4t8znPYcwRkATtc+o8lBU/WKxRkuEK++3s219SLhYVcn/rL1le27qD2Mf
         ynLhnTp35Hn6fUzV/XTqy3lXJ0kgJoBa+3QTxWYVRoqVrBldD2Ln4Cx6EQ8P/jbIOif5
         qekOBXRuoPEdT6pmrKRc6jkUBtG2pEBQHsAZREqnJ5HX4ErxnTFoxOZdiYpZ7h+wL02l
         UuAH4CrzLzw5iPkcuMGuiAjw15ViW6LpBpQn4y0CfESrXtluJBLu3za5ITob3/wpt9je
         Ho/Q==
X-Gm-Message-State: AOJu0YyyIMrNXiKv80yo1Fx5HxTolDYQlm5cZWXPD57cPDiv1emRM662
	guWMB5Od6J22SXxVFa3E4BOzq6ECPEZPSXBQe9IJ8QjyFBjUStCydZZa
X-Gm-Gg: Acq92OHkAy7KnqI3cRLcIpiyuK8wth+X5O73Kl8TdSGprC2eIc4TIQ8c2P9bguPj+xt
	/d1FInpWxLlWY1aHL1CDDVYtJt4+P0OGapmOfmiBMR4zIitnGpLnLbUJMeTcm0cuB/mzDiBjOSu
	KSoD9nyr0ze2W7YfTalRM4QWTgW1qyLdK/VDp7S0QF+0FNAh9WeX49XoPAXte1OvFHN9Ky2+D8G
	jPzwQvPSqaSsYYcDbX6o+2VcH2depmz+zyBbX13Lnx/88h6oog7XJXsvIx16w8KAwRC8u5ZgDqf
	ExToX8QMuxNeMd/cYUcB9BTda4LVscDLvEtToCDdhkwUOjHu0h4KL+fQ9z80Em3Aag0r5uj3XEq
	CHVQoDrAr8ZNQ7O4InGKFL/DLqaChT7x2+wb9/rzVoHbNo/r/Foe2CnhvkETHXMoADsmjMaUCb4
	vmoRcEHe7VzASYrqcGVl/Jtr3MzTF4kjFfDhoDcdsuief0kj64sQ==
X-Received: by 2002:a05:622a:1902:b0:516:e047:2f30 with SMTP id d75a77b69052e-5172dd2511fmr18004991cf.38.1780029023077;
        Thu, 28 May 2026 21:30:23 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5172ebc7d23sm9260991cf.29.2026.05.28.21.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 21:30:22 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 29 May 2026 01:29:46 -0300
Subject: [net-next PATCH v9 1/8] net: dsa: realtek: rtl8365mb: use ERR_PTR
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-realtek_forward-v9-1-e7c61872d923@gmail.com>
References: <20260529-realtek_forward-v9-0-e7c61872d923@gmail.com>
In-Reply-To: <20260529-realtek_forward-v9-0-e7c61872d923@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mieczyslaw Nalewaj <namiltd@yahoo.com>, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292961-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,yahoo.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1DFE15FD01F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert numeric error codes into human-readable strings by using %pe
together with ERR_PTR() in dev_err() messages.  Also use dev_err_probe()
instead of checking for -EPROBE_DEFER.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/rtl8365mb.c | 51 +++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 0da048da533a..2637884fe472 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -803,8 +803,8 @@ static int rtl8365mb_phy_read(struct realtek_priv *priv, int phy, int regnum)
 	ret = rtl8365mb_phy_ocp_read(priv, phy, ocp_addr, &val);
 	if (ret) {
 		dev_err(priv->dev,
-			"failed to read PHY%d reg %02x @ %04x, ret %d\n", phy,
-			regnum, ocp_addr, ret);
+			"failed to read PHY%d reg %02x @ %04x, ret %pe\n", phy,
+			regnum, ocp_addr, ERR_PTR(ret));
 		return ret;
 	}
 
@@ -831,8 +831,8 @@ static int rtl8365mb_phy_write(struct realtek_priv *priv, int phy, int regnum,
 	ret = rtl8365mb_phy_ocp_write(priv, phy, ocp_addr, val);
 	if (ret) {
 		dev_err(priv->dev,
-			"failed to write PHY%d reg %02x @ %04x, ret %d\n", phy,
-			regnum, ocp_addr, ret);
+			"failed to write PHY%d reg %02x @ %04x, ret %pe\n", phy,
+			regnum, ocp_addr, ERR_PTR(ret));
 		return ret;
 	}
 
@@ -1082,8 +1082,8 @@ static void rtl8365mb_phylink_mac_config(struct phylink_config *config,
 		ret = rtl8365mb_ext_config_rgmii(priv, port, state->interface);
 		if (ret)
 			dev_err(priv->dev,
-				"failed to configure RGMII mode on port %d: %d\n",
-				port, ret);
+				"failed to configure RGMII mode on port %d: %pe\n",
+				port, ERR_PTR(ret));
 		return;
 	}
 
@@ -1112,8 +1112,8 @@ static void rtl8365mb_phylink_mac_link_down(struct phylink_config *config,
 						     false, false);
 		if (ret)
 			dev_err(priv->dev,
-				"failed to reset forced mode on port %d: %d\n",
-				port, ret);
+				"failed to reset forced mode on port %d: %pe\n",
+				port, ERR_PTR(ret));
 
 		return;
 	}
@@ -1143,8 +1143,8 @@ static void rtl8365mb_phylink_mac_link_up(struct phylink_config *config,
 						     rx_pause);
 		if (ret)
 			dev_err(priv->dev,
-				"failed to force mode on port %d: %d\n", port,
-				ret);
+				"failed to force mode on port %d: %pe\n", port,
+				ERR_PTR(ret));
 
 		return;
 	}
@@ -1299,8 +1299,8 @@ static void rtl8365mb_get_ethtool_stats(struct dsa_switch *ds, int port, u64 *da
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
@@ -1652,7 +1652,8 @@ static irqreturn_t rtl8365mb_irq(int irq, void *data)
 	return IRQ_HANDLED;
 
 out_error:
-	dev_err(priv->dev, "failed to read interrupt status: %d\n", ret);
+	dev_err(priv->dev, "failed to read interrupt status: %pe\n",
+		ERR_PTR(ret));
 
 out_none:
 	return IRQ_NONE;
@@ -1725,10 +1726,13 @@ static int rtl8365mb_irq_setup(struct realtek_priv *priv)
 	/* rtl8365mb IRQs cascade off this one */
 	irq = of_irq_get(intc, 0);
 	if (irq <= 0) {
-		if (irq != -EPROBE_DEFER)
-			dev_err(priv->dev, "failed to get parent irq: %d\n",
-				irq);
-		ret = irq ? irq : -EINVAL;
+		if (!irq) {
+			dev_err(priv->dev, "failed to map IRQ\n");
+			ret = -EINVAL;
+		} else {
+			ret = dev_err_probe(priv->dev, irq,
+					    "failed to get parent irq\n");
+		}
 		goto out_put_node;
 	}
 
@@ -1790,7 +1794,8 @@ static int rtl8365mb_irq_setup(struct realtek_priv *priv)
 	ret = request_threaded_irq(irq, NULL, rtl8365mb_irq, IRQF_ONESHOT,
 				   "rtl8365mb", priv);
 	if (ret) {
-		dev_err(priv->dev, "failed to request irq: %d\n", ret);
+		dev_err(priv->dev, "failed to request irq: %pe\n",
+			ERR_PTR(ret));
 		goto out_remove_irqdomain;
 	}
 
@@ -1966,14 +1971,16 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 
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
 
@@ -2091,8 +2098,8 @@ static int rtl8365mb_detect(struct realtek_priv *priv)
 
 	ret = rtl8365mb_get_chip_id_and_ver(priv->map, &chip_id, &chip_ver);
 	if (ret) {
-		dev_err(priv->dev, "failed to read chip id and version: %d\n",
-			ret);
+		dev_err(priv->dev, "failed to read chip id and version: %pe\n",
+			ERR_PTR(ret));
 		return ret;
 	}
 

-- 
2.54.0


