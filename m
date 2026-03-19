Return-Path: <netdev+bounces-269720-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEXKDnKLvGlv0QIAu9opvQ
	(envelope-from <netdev+bounces-269720-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 00:49:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADA42D444A
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 00:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6305330F70BA
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 23:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7A73CB2D8;
	Thu, 19 Mar 2026 23:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="E3cMexUP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041933AF64A
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 23:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773964105; cv=none; b=CyJRCmO7/bscsSXjKbiJZ0EfbHZmoQuaA2Nd2JpIoZp8jXOg46zo/p4W1/AqK42WgZ3R3W6EPTJ3kVdfPBQBx4rVEoPOgJX5YCZ9UAIed5GnIKGYenkLtp8gwUeKbsqHCEsF+blwdM+Kox4Ixm1obVcOrMSeRw5Gw0ZikTv4Ano=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773964105; c=relaxed/simple;
	bh=/NL/n9sv+VtCk5FddD7S2TYyrYuDLTDUdWiAMV0DGbg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W+jHOv/y8rHGYRtceKWQRP4GgziUAVWdhIZVhwH3J7FtCElHXkvYRIh/cfMNA+Lw84cOSXpFM+YDUpjHbWKHGt5xwIQk7UYecCtyFmgPbMrHWWtLP53b9IPPqPo7Pj3vZ1O+yg9PIfClUff9h9+ubkaG8BS3/4bQv2fS+wiqsiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=E3cMexUP; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2b04e6a989eso9850625ad.3
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 16:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773964103; x=1774568903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kRS/3sR6+9YCg84GC5MlgUh6Yk4EGVS0LYmYLlEg2qI=;
        b=Zhk/8ReYg37JKPV5sGsCfhBE9gLgsDf0ce9cX79KqouW+J25rKTtOAFXr8ewI4IKnX
         3z0I1f5aBn74fVUprqT3aanFpCGfpAn+lY2OYz1M7rmQ4G6nM+rByQRbwQeg6UjarwQs
         z6YTZNPVJylXswTD1V4orFSkgYmhwouQYLkeRXmmHGNFBAuvN07WdukPMDyWRcaX0rK9
         Hx71CkFId1tfViT0QRVa721TrX5iHQ1Fmn+BAUGwX5br+BOin7bZ68uOVCB6mUNLO9zI
         sCEfgK2T/iXNVRsBNAkBZhAwsIwdmFf91dT2M811yYei6hwL6FmoyPY7SoKEd1fmQuhM
         wFLw==
X-Gm-Message-State: AOJu0YxpkG9bCTo1pDoaW+dHD/dQjuRvsVam8lb44c79SagfMvkf/pD2
	Joa5AdfH10yYyRA4F40UiZ1gxaapQvHLxh7by51K4t2xM50sBoiZYKd7uf3XGAJSg1qLS7KiEAx
	VYf8Al6wdM6x5BBhBYZ4aYl4zycDxr4UwCl318kaVMp1F0NI2VEyXisA6XGgu4DR1beTqKCjA+l
	6hgHFn2MEbkMt6WW/hX9h/LS2nZe03cc7+WVWTduH709eEEl/CDSdzQLJJFNOEUSJQyrYwUW8nN
	fKfF3HokA==
X-Gm-Gg: ATEYQzz+sgjVJTck7jSW4E+WStwaP03902+0xebn35WoWyh8gbwvYPU3hF0UpqSkAsv
	GU2SSaXEysj4TQHYrUbGK+rszEt8Sq+NzfTILeXmvlx9ho9ZglKf5bDE7i6DEBGZq36/TmxN6r6
	yLCKDmTXkpEnjfjAl8MS5KGenaRucj2rHL1+7hcvAzXUn2lwvb1h8de/C55cuG93c4pWeFy7BeB
	ZzLr4Fl+Ua04/1BjE+T8vBb1rUy+WGohnoPb0ZEjsnuIY3p5uOczcLFU9vp2ufBijV3T0CXPU6o
	d/ZI1zjH4iQvQyQKVMU7MtBSetNvBecBoTH960DGV6wVdgWK2XcX+1XlNtnJXsx+bkZdu4Po2xG
	sh5vww2j1pC2TjEw73wCDy2io7wPVmVG8MxCMAU5eb2N1UjCsAGxRenysSG1APa2UzIRvGl5Vy1
	YCWBqTvkVP6RSupaYo2VpnwxkwnaHQ7+c+DXiSe5G0AZ89WdijbQ4tGB0xXg==
X-Received: by 2002:a17:903:1904:b0:2ae:b991:a46f with SMTP id d9443c01a7336-2b0827c0a43mr8041035ad.42.1773964103292;
        Thu, 19 Mar 2026 16:48:23 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b0835d8edesm654995ad.32.2026.03.19.16.48.22
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2026 16:48:23 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2bdf6fe90a9so1650191eec.1
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 16:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773964101; x=1774568901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kRS/3sR6+9YCg84GC5MlgUh6Yk4EGVS0LYmYLlEg2qI=;
        b=E3cMexUPJEvlz9nV+eyRirIkcaYliGXqrW7eWXiMvoZiqK37ojWfYULjZQByjfCO8D
         6iDBaPkVmfNtlJc36TaKPGV/mDmcBBWoHeRWM+xl1wPUF0J57zLU3rDozivOWyREi28N
         h7KF7MC5Rtvz488KdylxS7IPtKsvK6ZtbnRT4=
X-Received: by 2002:a05:7300:4342:b0:2ae:5e93:b69 with SMTP id 5a478bee46e88-2c1097a59f3mr695862eec.29.1773964101361;
        Thu, 19 Mar 2026 16:48:21 -0700 (PDT)
X-Received: by 2002:a05:7300:4342:b0:2ae:5e93:b69 with SMTP id 5a478bee46e88-2c1097a59f3mr695843eec.29.1773964100622;
        Thu, 19 Mar 2026 16:48:20 -0700 (PDT)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2d673asm1141697eec.24.2026.03.19.16.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 16:48:20 -0700 (PDT)
From: justin.chen@broadcom.com
To: netdev@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	florian.fainelli@broadcom.com,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net v3 2/2] net: bcmasp: fix double disable of clk
Date: Thu, 19 Mar 2026 16:48:13 -0700
Message-Id: <20260319234813.1937315-3-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319234813.1937315-1-justin.chen@broadcom.com>
References: <20260319234813.1937315-1-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-269720-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.976];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9ADA42D444A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Justin Chen <justin.chen@broadcom.com>

Switch to devm_clk_get_optional() so we can manage the clock ourselves.
We dynamically control the clocks depending on the state of the interface
for power savings. The default state is clock disabled, so unbinding the
driver causes a double disable.

Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
Signed-off-by: Justin Chen <justin.chen@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
v3
- Do not disable clock until probe is entirely done to avoid
  double disable on error path.

v2
- Split into two patches.
- Add error path to disable clock if we fail during probe.

 drivers/net/ethernet/broadcom/asp2/bcmasp.c | 33 ++++++++++++++-------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index 2034a1593db7..972474893a6b 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -1249,7 +1249,7 @@ static int bcmasp_probe(struct platform_device *pdev)
 	if (priv->irq <= 0)
 		return -EINVAL;
 
-	priv->clk = devm_clk_get_optional_enabled(dev, "sw_asp");
+	priv->clk = devm_clk_get_optional(dev, "sw_asp");
 	if (IS_ERR(priv->clk))
 		return dev_err_probe(dev, PTR_ERR(priv->clk),
 				     "failed to request clock\n");
@@ -1277,6 +1277,10 @@ static int bcmasp_probe(struct platform_device *pdev)
 
 	bcmasp_set_pdata(priv, pdata);
 
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to start clock\n");
+
 	/* Enable all clocks to ensure successful probing */
 	bcmasp_core_clock_set(priv, ASP_CTRL_CLOCK_CTRL_ASP_ALL_DISABLE, 0);
 
@@ -1288,8 +1292,10 @@ static int bcmasp_probe(struct platform_device *pdev)
 
 	ret = devm_request_irq(&pdev->dev, priv->irq, bcmasp_isr, 0,
 			       pdev->name, priv);
-	if (ret)
-		return dev_err_probe(dev, ret, "failed to request ASP interrupt: %d", ret);
+	if (ret) {
+		dev_err(dev, "Failed to request ASP interrupt: %d", ret);
+		goto err_clock_disable;
+	}
 
 	/* Register mdio child nodes */
 	of_platform_populate(dev->of_node, bcmasp_mdio_of_match, NULL, dev);
@@ -1301,13 +1307,17 @@ static int bcmasp_probe(struct platform_device *pdev)
 
 	priv->mda_filters = devm_kcalloc(dev, priv->num_mda_filters,
 					 sizeof(*priv->mda_filters), GFP_KERNEL);
-	if (!priv->mda_filters)
-		return -ENOMEM;
+	if (!priv->mda_filters) {
+		ret = -ENOMEM;
+		goto err_clock_disable;
+	}
 
 	priv->net_filters = devm_kcalloc(dev, priv->num_net_filters,
 					 sizeof(*priv->net_filters), GFP_KERNEL);
-	if (!priv->net_filters)
-		return -ENOMEM;
+	if (!priv->net_filters) {
+		ret = -ENOMEM;
+		goto err_clock_disable;
+	}
 
 	bcmasp_core_init_filters(priv);
 
@@ -1316,7 +1326,8 @@ static int bcmasp_probe(struct platform_device *pdev)
 	ports_node = of_find_node_by_name(dev->of_node, "ethernet-ports");
 	if (!ports_node) {
 		dev_warn(dev, "No ports found\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_clock_disable;
 	}
 
 	i = 0;
@@ -1338,8 +1349,6 @@ static int bcmasp_probe(struct platform_device *pdev)
 	 */
 	bcmasp_core_clock_set(priv, 0, ASP_CTRL_CLOCK_CTRL_ASP_ALL_DISABLE);
 
-	clk_disable_unprepare(priv->clk);
-
 	/* Now do the registration of the network ports which will take care
 	 * of managing the clock properly.
 	 */
@@ -1352,12 +1361,16 @@ static int bcmasp_probe(struct platform_device *pdev)
 		count++;
 	}
 
+	clk_disable_unprepare(priv->clk);
+
 	dev_info(dev, "Initialized %d port(s)\n", count);
 
 	return ret;
 
 err_cleanup:
 	bcmasp_remove_intfs(priv);
+err_clock_disable:
+	clk_disable_unprepare(priv->clk);
 
 	return ret;
 }
-- 
2.34.1


