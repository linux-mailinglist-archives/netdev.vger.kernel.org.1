Return-Path: <netdev+bounces-136122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 088D79A0644
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 11:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 158DD1C22D5B
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 09:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BC6199944;
	Wed, 16 Oct 2024 09:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="SDC5156x"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B8420604C
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 09:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729072716; cv=none; b=vGbB41F5KLjZmO3RiSK54CiYJ5APQ3Ktmg0t5Cvp30iP3rIdFWC1PYGI7pmZtYau65K+Uwr1Y0PhRP4wHWPqDNNLypSmIEyVt5eGb3G2IcM6dfThJGNvrOjNFVE3P02lY83p++5csVIYT6Xfxsprw6aKjHZ4/8Vr5NDu/30dR6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729072716; c=relaxed/simple;
	bh=sVSFCnQxQPuJp45EmURMFRulEMP8X4iGMkd9iB/nFDE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=qlexHQ+qYdYBiTRjMAM+jfmtiCDMNatTr66RS98lXqCwTEQwC4oc4veUVSJTIKpr2RTAbwzC+pMMatxIWhJHrdmFd6ZgvSrxbx446NAYILUIN+XkzyoFD1JJzSNI5URIvmm7JgTYZbAwz4qWTdV9QrFG//rqXCN0ZzgmDnstJYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=SDC5156x; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LXa+zpsJI+d2DCmUR+6YHhK6bMBBML5RTKHyzEmK5XQ=; b=SDC5156xE2YbwSmb8HsaGHyV1/
	cQzR6SbUAzQcV9MC7YM/Vt5QAH1RJravxGVIUfqs/A0fm8Mov7Rhys9MoQfhHtmBAvYOgOMw2gqFu
	0MAnml/aIys6MXp4ykziUvWZZM+TsNegYfcgPjaxMNqkzoXNkiCCGeAHWDybTK1UZbjfw5boi8OxN
	DA8UwuwYmOyWMlppkeZ9vwOZvNG7fDv4MeRyzsR1OvaSYMXSC6IEQsGZ+aMbGXITrnTw5ZeDO35qJ
	ZMl3ylashwvG3j4Sx2g4b0ZxGmJhcS+xyNBoF3iNC/Mthy4wAhd+egDgAI9rZ4V2nDRz5yGcOAUDy
	n7jhBxsg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:48574 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1t10nV-0004ri-1m;
	Wed, 16 Oct 2024 10:58:30 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1t10nV-000AWW-IJ; Wed, 16 Oct 2024 10:58:29 +0100
In-Reply-To: <Zw-OCSv7SldjB7iU@shell.armlinux.org.uk>
References: <Zw-OCSv7SldjB7iU@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next v2 2/5] net: dsa: mv88e6xxx: return NULL when no PCS
 is present
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1t10nV-000AWW-IJ@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 16 Oct 2024 10:58:29 +0100

Rather than returning an EOPNOTSUPP error pointer when the switch
has no support for PCS, return NULL to indicate that no PCS is
required.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index f68233d24f32..da19a3b05549 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -868,7 +868,7 @@ mv88e6xxx_mac_select_pcs(struct phylink_config *config,
 {
 	struct dsa_port *dp = dsa_phylink_to_port(config);
 	struct mv88e6xxx_chip *chip = dp->ds->priv;
-	struct phylink_pcs *pcs = ERR_PTR(-EOPNOTSUPP);
+	struct phylink_pcs *pcs = NULL;
 
 	if (chip->info->ops->pcs_ops)
 		pcs = chip->info->ops->pcs_ops->pcs_select(chip, dp->index,
-- 
2.30.2


