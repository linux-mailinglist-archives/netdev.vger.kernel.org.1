Return-Path: <netdev+bounces-288334-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KR6C3I0B2qQswIAu9opvQ
	(envelope-from <netdev+bounces-288334-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 16:57:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B174C551C32
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 16:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0283E304C073
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 14:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C7F3BB668;
	Fri, 15 May 2026 14:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="UKKih3mK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-65.smtpout.orange.fr [80.12.242.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDABF3BFAE1
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 14:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778856723; cv=none; b=k6SQBJ4MLQ+/MeexWa7nE1Pbnysa4IIzKAPDYHBc7AZpgHDJsfH4c9Dy3TbHRHPUuDYDubQcJcsKSFkLe0W0E3Dw1KiclCuxJaH1KY0ye5mn/3BnRGKwW8DJ34rKX5RVS3B2+y+Dvwf01i8cU5CHHVMGWWBq57Wt9fufjxUzPfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778856723; c=relaxed/simple;
	bh=g3ptDJxJxQCUv+cK1mS6Te2bzjyh2+ToCFQDd0hFbUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPY9Pkr1MC3iYCRa3KYh9Urqg4OvIa5lIw/SEiyhPdB2BpzHgD9VljA1NKoik33MDv25RI2lA6w9m7Mf+ijjGNOCsnJLu0nUfikUxCr3td7dnL8Cw9iom1aFAfjpQVSAhzePrTKvt0HDiIhLkTUlpghkTQsM6a3OoYvvvIiKThU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=UKKih3mK; arc=none smtp.client-ip=80.12.242.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([10.65.86.62])
	by smtp.orange.fr with ESMTP
	id NtsFwUeFnNMP0NtsFwHqbC; Fri, 15 May 2026 16:50:47 +0200
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPSA
	id Nts1wguySDTmsNtsFwk2Cc; Fri, 15 May 2026 16:50:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1778856647;
	bh=FmW+Of738giidRlcAYcxTdkOQ9EHS9blbA9sumeTjtk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=UKKih3mKCkNqBb0MLmPJQYd9i9Zgyk34y2Do4mHTZQCKpf/nIK56C9leZtAXc9QJi
	 NIX1azAmDH/8W0zds0ujNnjWD67D1EY46ofCnl4JEITVtAfdcZpBSu18u6qLtvi6Vl
	 3VsC3L7+OwxrdMRJFibiM34CJP7IomoQz+Uw1sapUb7T8cpVufESXB6BElC8z4Kcne
	 ejKpesqBFenpdvx+PeOoCZPOtn5dyw/Cu8kkYyOEqR6Ty7XJHTXE2agDi41sscobxF
	 +KVH310Wg5PW473ZgecCxR920OM0g/tYSq1ydDNOnexjQdI38rzysBOujJtulk83l7
	 pDVFNU6SEzl3A==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 15 May 2026 16:50:47 +0200
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
Subject: [PATCH 3/3 net-next] net: mdio: mscc-miim: Use devm_of_mdiobus_register()
Date: Fri, 15 May 2026 16:50:26 +0200
Message-ID: <139ebd0e3698de5e785bb0c70a4d4da43925a7ae.1778856199.git.christophe.jaillet@wanadoo.fr>
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
X-Rspamd-Queue-Id: B174C551C32
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[wanadoo.fr,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[wanadoo.fr:s=t20230301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,wanadoo.fr];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288334-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	DKIM_TRACE(0.00)[wanadoo.fr:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Use devm_of_mdiobus_register() instead of hand writing it.
This saves some lines of code.

The remove function can be removed completely and the
platform_set_drvdata() call at the end of the probe is now also useless and
can be removed as-well.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 drivers/net/mdio/mdio-mscc-miim.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/net/mdio/mdio-mscc-miim.c b/drivers/net/mdio/mdio-mscc-miim.c
index 4d8f60d458b8..7bdcf3e9baa0 100644
--- a/drivers/net/mdio/mdio-mscc-miim.c
+++ b/drivers/net/mdio/mdio-mscc-miim.c
@@ -322,22 +322,13 @@ static int mscc_miim_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = of_mdiobus_register(bus, np);
+	ret = devm_of_mdiobus_register(dev, bus, np);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Cannot register MDIO bus\n");
 
-	platform_set_drvdata(pdev, bus);
-
 	return 0;
 }
 
-static void mscc_miim_remove(struct platform_device *pdev)
-{
-	struct mii_bus *bus = platform_get_drvdata(pdev);
-
-	mdiobus_unregister(bus);
-}
-
 static const struct mscc_miim_info mscc_ocelot_miim_info = {
 	.phy_reset_offset = MSCC_PHY_REG_PHY_CFG,
 	.phy_reset_bits = PHY_CFG_PHY_ENA | PHY_CFG_PHY_COMMON_RESET |
@@ -363,7 +354,6 @@ MODULE_DEVICE_TABLE(of, mscc_miim_match);
 
 static struct platform_driver mscc_miim_driver = {
 	.probe = mscc_miim_probe,
-	.remove = mscc_miim_remove,
 	.driver = {
 		.name = "mscc-miim",
 		.of_match_table = mscc_miim_match,
-- 
2.54.0


