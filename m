Return-Path: <netdev+bounces-293329-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePdTCoDBGmp88AgAu9opvQ
	(envelope-from <netdev+bounces-293329-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 12:52:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F4160C41D
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 12:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3376F3038BA6
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 10:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B92339D6FF;
	Sat, 30 May 2026 10:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfGmW+ER"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E910A369D68
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 10:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780138309; cv=none; b=Ab0XtZ9Xw63LAJv8YSMQ2U0lUqZuWgF0wONJ70/4auPteHsxO/U3BTro5b277uRPaJ13cJpI3uSM5AEeV9G6ZvnqOlhK7d1h3EvDz0SFXdJ3R6OUL1YnuqB8KhGFeh6pBqwawH+sMlYvMn/Ic+vM2hbuoXzw8JEmKg1Sj3pICQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780138309; c=relaxed/simple;
	bh=6vvUpEnA3zuZyhkh5L9tx3acH0/PiR28xnODKHfdVgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qFzBFVK+CW3JfN2xWZkbC0gy5md2ZuTrxKbuhJZiVbskE4l572pyBZNYpOLI1HMDdagpRkRlhtD4b03SSi16YHkp1Oktb/hrdoIz3P8aosd8xPuzHBI5wd+p3P7S0920gASkMy6DD6NqoQh32tSiFXLvRCequpTVme7L2RZIBLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfGmW+ER; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7dc93d02916so26691387b3.3
        for <netdev@vger.kernel.org>; Sat, 30 May 2026 03:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780138307; x=1780743107; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rgdsNgCTJpv8k0KRcqQg2bYC+LqfZpfIBBy5KwRLQzE=;
        b=jfGmW+ERr6BR2uGUuVE6s6hRuFawgTxJTz2JNCUYbANT0BEb8U/lug5X09oH1UicLc
         9FpsM76sCWHj5TKCHEWNMXCLFe+my6Z/beRdj0q9/JZ+l27imcUZvJr5Q/YWEIWGL/Jr
         9ODzAyC4hD5LfqIAlCL8fMJcIIk2vaTfMZxrBsEyvMQO41UQEcLcQZscWHNIDn2+BvYw
         rLLZGrHcJOi9gyT45NSZNhtnLCTvKxyJ4T4P6UPdoK1JP6By1ydTgZVpyWU0VA6PmJJN
         FSoldSjJTVq9rQTOQaf+eM1LnfwFR2lgmyDN/tdS57KAOYoI0BR1JRlA2/ZfF27fG2B6
         wFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780138307; x=1780743107;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rgdsNgCTJpv8k0KRcqQg2bYC+LqfZpfIBBy5KwRLQzE=;
        b=Lg61s2FtD/GxxAbKkBUJQnhvx0QIrT11P2TvTCa8QgTY4WBmg9JgZuT0uI1mb3ISwH
         BnbSOIqRTs2NPtcvGTGcRzdpEUW7AGoPHL/jSAe4EmZVGMnM6SwSJSOqZTUSKlEVTZtM
         5T2ICspg2jn9FdIBKSA27e0tQKoU7MiVNmM5xeMPryrjR21a+f/m6MbF/2FB8xb6dXh/
         CGjPS640LU+ppwFFUJ9FJDe7wXORjNjx9Sq3BvTGT7IrUVLnILusp3luJ0o5GMIj3rZ2
         RPPTpxrHPm8/K7EqNwj+/W9TIG8UB4auiBeM8zpioz4ZOPIHZJYwkuofxPQ4njNSRjkb
         NsTw==
X-Gm-Message-State: AOJu0YxHrZebzoX0rwKcgyGiCpSOiAq9SQI4IyElH95frfyUiRn+73zO
	Z4RGvPOf/68kPF2T6W4DYmn1cmmxlpJYhFSk617O9sS6mF/h9djDiztu
X-Gm-Gg: Acq92OEf1SedJKsPpC81CsLsDuN5ozXgmBKrcCjvBByNXw+AgmKnpvh38IXMAhoqr/E
	s86svW6COPdF31bCJM0mKwOhHXkQ/UFuhNr5AYVwjRT2iXkJeu36w3MyAwkqm9+LM5z3gE5WLF/
	7h+2Iw9+TQjjmvLponIsRYk1vBq5YZvB2bvLPG8uYEhFd+ysarQLVOxrFi6Y5hzXeHfxvCFJjXz
	aZDfuKCvPERsdo2IReJHE6R01DlrNvjGLoP8SbVciMMtQM7YmF6RSQqVp1reSL9s/0Y0GXQ8jbc
	jws91xPmjSzH5ETQr3GDDUyk6cPnAUyHmwX5B811Z3EhUT7WW7hBElHgUMEKq3UIK9PRsS/k9vN
	ZSFMSFpWoGJWGFG5WDLtyqff7iHx5vGwanVMWpssMlBcezmVUPbah6ekJChhIHVfS2jwkeLpVUT
	CNpztLOZ8mGsgtbZB1AKy8NIUvbxmO+g1hgeR0itFFzy0winugak0oEmj+4F/G
X-Received: by 2002:a05:690c:22c6:b0:7dd:6034:b46a with SMTP id 00721157ae682-7e058d33444mr30895387b3.4.1780138306975;
        Sat, 30 May 2026 03:51:46 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7e176d6ff86sm5579357b3.16.2026.05.30.03.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 03:51:45 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 30 May 2026 07:51:06 -0300
Subject: [net-next PATCH v10 1/9] net: dsa: realtek: rtl8365mb: use ERR_PTR
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-realtek_forward-v10-1-d14b51e6a69d@gmail.com>
References: <20260530-realtek_forward-v10-0-d14b51e6a69d@gmail.com>
In-Reply-To: <20260530-realtek_forward-v10-0-d14b51e6a69d@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293329-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E8F4160C41D
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


