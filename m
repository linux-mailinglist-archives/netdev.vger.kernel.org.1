Return-Path: <netdev+bounces-288333-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEG+B/w0B2rftQIAu9opvQ
	(envelope-from <netdev+bounces-288333-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 17:00:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE70551CC6
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 17:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 93CD8303D7D9
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 14:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C212F3BB131;
	Fri, 15 May 2026 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="BmodFq+n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-68.smtpout.orange.fr [80.12.242.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F1737187F
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 14:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778856721; cv=none; b=f2IxIh+aUqTlxA38tbwwBg7shuA5UdMOdqBulhMmA6diuRwCj5VUvktoIDHqxlVPLqV+DCQiPodGTXqEEnk6lw+r3XrHmXeN1JYKb63k98U5T/w4PuRrJOlwtkqew0AJWNoqCXM4Y69K4RLi25PjJ81DMzJ218B4sJRcZJB/lQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778856721; c=relaxed/simple;
	bh=dSiK2d5HHGG4axsv3+vMzoiypN5x6RYhvbf7IPwT4eI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y43k8MSIKmWtcB12xgb6/E+6haMFfdNkw9c7BSlbz2hanzKt6+nrRMdbFsedc1qK3HFUveh9RLu14kAlxf26wcBJBKN/8Sd83SDeqq0TCgqKj7CeQa355m3IrZL2OAXZZvPdip1Cbd2vDwFHF/GlS50V/kEC6Cwm1hKDurKI23M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=BmodFq+n; arc=none smtp.client-ip=80.12.242.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTP
	id NtsCwqnpEEQJUNtsDw38u9; Fri, 15 May 2026 16:50:45 +0200
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPSA
	id Nts1wguySDTmsNtsDwk26Z; Fri, 15 May 2026 16:50:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1778856645;
	bh=4OQ0NNNNJoZiPc0P+s+xkhSrdNg3Aq027Eag1qLTTHY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=BmodFq+nHLpH+b+RGwAPftM3d69ZrVc7RKX+H4ReDSnEMWkBs+APfJ9kI/c4evFpA
	 bLfRBsAms3m5LwNIkaKtL4d+GBZcx6OiPnVJ7VdorS4amFN6fV+qnFosZ1dBtT7w2a
	 YTZJoOSybkvHmX69zTzm4ow4GiGHIYwSArjogimWpfTSNaS1Arw/R6pXBw8UaLIa5W
	 T+BPnBAbNcpkagPVJfAcd9zM1vB0VumSCLHT/KN0R/CQxlJCr/9/EN4TtIw0jNlZlg
	 ppjiH7V9dCD7WOlicUtlYNdnKTGGYFQ1kWDd6TaAr4NsuRuMUthiawjlWP2aP09ydJ
	 OVnruDa/v9/8A==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 15 May 2026 16:50:45 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/3 net-next] net: mdio: mscc-miim: Use devm_clk_get_optional_enabled()
Date: Fri, 15 May 2026 16:50:25 +0200
Message-ID: <542f88aee5de2ac24fca58001eab24ac817abee9.1778856199.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1778856199.git.christophe.jaillet@wanadoo.fr>
References: <cover.1778856199.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2BE70551CC6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[wanadoo.fr,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[wanadoo.fr:s=t20230301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,wanadoo.fr];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288333-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	DKIM_TRACE(0.00)[wanadoo.fr:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[wanadoo.fr];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christophe.jaillet@wanadoo.fr,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Use devm_clk_get_optional_enabled() instead of clk_prepare_enable() and
clk_disable_unprepare().

This saves some lines of code and simplifies error handling in the probe.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

In the remove sequence, clk_disable_unprepare() and mdiobus_unregister()
are not called with the same order anymore. I don't think that it matters.
---
 drivers/net/mdio/mdio-mscc-miim.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/net/mdio/mdio-mscc-miim.c b/drivers/net/mdio/mdio-mscc-miim.c
index 03878bd9091d..4d8f60d458b8 100644
--- a/drivers/net/mdio/mdio-mscc-miim.c
+++ b/drivers/net/mdio/mdio-mscc-miim.c
@@ -307,7 +307,7 @@ static int mscc_miim_probe(struct platform_device *pdev)
 	if (!miim->info)
 		return -EINVAL;
 
-	miim->clk = devm_clk_get_optional(dev, NULL);
+	miim->clk = devm_clk_get_optional_enabled(dev, NULL);
 	if (IS_ERR(miim->clk))
 		return PTR_ERR(miim->clk);
 
@@ -318,35 +318,23 @@ static int mscc_miim_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ret = clk_prepare_enable(miim->clk);
-	if (ret)
-		return ret;
-
 	ret = mscc_miim_clk_set(bus);
 	if (ret)
-		goto out_disable_clk;
+		return ret;
 
 	ret = of_mdiobus_register(bus, np);
-	if (ret < 0) {
-		dev_err_probe(dev, ret, "Cannot register MDIO bus\n");
-		goto out_disable_clk;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Cannot register MDIO bus\n");
 
 	platform_set_drvdata(pdev, bus);
 
 	return 0;
-
-out_disable_clk:
-	clk_disable_unprepare(miim->clk);
-	return ret;
 }
 
 static void mscc_miim_remove(struct platform_device *pdev)
 {
 	struct mii_bus *bus = platform_get_drvdata(pdev);
-	struct mscc_miim_dev *miim = bus->priv;
 
-	clk_disable_unprepare(miim->clk);
 	mdiobus_unregister(bus);
 }
 
-- 
2.54.0


