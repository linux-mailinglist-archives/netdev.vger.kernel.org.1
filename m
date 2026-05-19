Return-Path: <netdev+bounces-289271-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJrkJvftC2pQRQUAu9opvQ
	(envelope-from <netdev+bounces-289271-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 06:58:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8CA5774D2
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 06:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B635C30245BD
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 04:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5406F309DDF;
	Tue, 19 May 2026 04:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/cV0Gny"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2F0307AF0
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 04:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779166702; cv=none; b=DDmssIkshiyuU58iCypYSla0wOf0sfzvV9rI5dKLeW1yKxsMxbUSLxyU/atkJGM0gmRbiGq2cKLfZPBNR8RRWlwPBbMHBdb1JoHPtCJuDZ+YVu/k+kbCGob7dQVNbS7fXoaqCS2T3IYUWsLyaBP4oV3PaakcIb0FJpylkZxjiYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779166702; c=relaxed/simple;
	bh=p1MUqpJcNOpNKgaKAgd10fMptk1LZjJ/uZuFUtetG5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sZbYraBdwG7+MIBJ73ZGZfS9m9GodDgbg5tLESgL/N0sSQ3kqw4uBQkEiPraRzYQcAhboKvuWndkWVR74U1eJ6kJlagaIm9Gp8LB1Gljn4MiXy1rHLoV/4tPNVtSrCcir1CPjHQOUVXGgaxGZQnnm4FhnLnkckr/lyhikeWIPSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/cV0Gny; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-911488599e3so376337385a.3
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 21:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779166700; x=1779771500; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VwVVUMzUc60XALDu2g8/TiSpQu8lRILNNJR3OBveODg=;
        b=C/cV0GnyYOyaIFR9QsJoRLcqYUojm7IHjJzyIh6kvEziYkd1g1aqUqDeEGdbNZCQB5
         KKVHsJeLoTKt4L4FLReswP9mm5fDowMQjHSfI0TUWibqlwIyIvNskdGkvWr+z7myb4Nq
         Y0ntfl/q4uN0kdPYohHUYW1IXvMqaLCq0dW7IoxcMyBfrLzaLFnWz77AV8LV6DpQ9Xon
         DcKe3LWxxSL5LgppYoM+jePfP/8F3vmbN/x3H/HL2tvc4WnX+Hu2ioh6HPa8dgdz7V5h
         2QiLMEigru299F2oMJ9L1FUe+jbAanhOXIBsGJQFixZob1JyzI8dha3tWul0BvPVMcjD
         C7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779166700; x=1779771500;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VwVVUMzUc60XALDu2g8/TiSpQu8lRILNNJR3OBveODg=;
        b=FAgYWb6c6duAtLZ+SwbwdYowvb745lqsfrYFs149Oz6Db9Ab+xDDhdc4RmvAr9EsW+
         MmLj6vVQtFcZsNz2p2sXuAsyp8KzYfv1ULUTFk08nJG/y4qwWm2QAYG8eJvhmk01xy4M
         h3OlCbLkpq4bjMI1jah9O1lZUASQy4SBD/wY7JGeQD9+olLPjQae7C1K4zvUTx41FrRT
         cTK6imuggm75eoAk92JGeP0t+mWQ+IytGbHgpWyuDtk1oiwYIAqZgpSFwCIBLZdmVaWp
         cjNdzB0rs4MZFRp09KSFgxk5r9b3qF6L2lwbSjFL4z/yYeKb+ntA7QRqcoU4Gz2taW9k
         QPjg==
X-Gm-Message-State: AOJu0Yw7BBE/yPX+LgQPgJauEPJOdymMC5GXgB5xUwcMNtAtwm+QVrWI
	vG2ammWkBrY1EKKrNLnfVYR4dLU1II+edppNIrXswzV1AvNBwuCZAulJ
X-Gm-Gg: Acq92OGGCE1DxydevCKELiUHu8oWlA7bq+GUdQKAmSkM7u/5pectnkhZDuRK4kYNuaB
	EPVk6KQxaNqWJtkGZM5x5K192O5PMMFsD395EvDZroqCAvK038alBJLRGOqwGyqC51VBURrRstM
	cM8VovTS1n65XF3GEj+60e8gtPXiBOS9Drp9NkDVyiMrshkR+wC8qDqvFylFftue+YQeebnQnWN
	E9jlyD/CSd/vuqDtDVK45NqCf3Wi5Tpjgimord12v0Ek7VvHr+9jpD6H/v8Uz3ZDir7DeIaOZk9
	vy3qHWJQgBpumqsQD5ozX9V0OQ2U3iILcPiNfT/D+UndqsdPQHu6E4U78io3pGC3yHmoikREQY5
	VNBMwMSZZCH/EVAqrUcAkKGbQ6aGKGM04gmygZplgHwxoWBnEb2hjpO1CvewCNHcwwXmq0QaT5w
	ilqxE9ss0S44C5I/123iDOBkJ/u2wnkLAfWETucqje8f0tizrH+A==
X-Received: by 2002:a05:620a:1a1a:b0:912:c611:80ff with SMTP id af79cd13be357-912c611880cmr2076373385a.52.1779166699556;
        Mon, 18 May 2026 21:58:19 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9114edfd3ebsm1588593185a.23.2026.05.18.21.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 21:58:18 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 19 May 2026 01:57:56 -0300
Subject: [net-next PATCH v5 1/8] net: dsa: realtek: rtl8365mb: use ERR_PTR
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-realtek_forward-v5-1-cb9f702c1782@gmail.com>
References: <20260519-realtek_forward-v5-0-cb9f702c1782@gmail.com>
In-Reply-To: <20260519-realtek_forward-v5-0-cb9f702c1782@gmail.com>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289271-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3E8CA5774D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert numeric error codes into human-readable strings by
using %pe together with ERR_PTR() in dev_err() messages.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/rtl8365mb.c | 51 +++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 0da048da533a..c04786be3f79 100644
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
+			dev_err(priv->dev, "failed map IRQ\n");
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


