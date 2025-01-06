Return-Path: <netdev+bounces-155422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B3CA024A7
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 12:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 175F21885E50
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 11:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E181DD87D;
	Mon,  6 Jan 2025 11:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Q76wFISM"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0634C1DC9B8
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 11:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736164761; cv=none; b=YaivGZHXVQ7E2plFKTCsLV/iwh1VKlelWMyWR9PWPFEdbMHOE/gq2a5Sg4eQWM69QcfjcPqyMxffM1RFRDLADBj/OKsXXJavjKwRx/oUOVqMNKdE8bz3jhj4PhC15mgpzhVGDlxBJXgsn4pAmM/wuCn0F5EjKuMIbuzl+RPPoiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736164761; c=relaxed/simple;
	bh=CNo3ZiXPz7XvtImfh59fBL+xZYmJfld4YssuE8Q+Usk=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=S9X+6DQWjOXERywCAFu7HuJZWbViZvgLsKFAtie8ZI4GplJSvU/Utt6sujSaYYzbgHu19Ens+qEDTLBVjYvxeCjk1YXW+K8jZBQzxo+7KKMUDjSjP0+CWO/hY3mZm9L7VlV6lzlVTYRCQX2wSvuipc+qrnApUYfmI4k7Kphxjjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Q76wFISM; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7lzBF/ZfPmOGT3qEEXdOPpNB7JC83GfpLdkUGGHF2us=; b=Q76wFISMmElzVYjnPgxScXr2JI
	lH44fEbSFJdd6DQjtxq85z4XN3HKQKwc3nKVDxpn9fUUnkBTVPGM8vU6ZgSmglbnekhbq0K3R/8Qz
	h02WZobkklr6rhOWFheKLTS2LtEcBgFDS+Hdnb1D6bQPVR5fXDMlchDQsj/5gLSmYb2d/9Vx66PIi
	Kuy/cVaziM+yxtykBo6oiTmkk/XR0Otr71N9ny13dARnyBh67CSSn9k5mV6wXkxqBXvAF9p+e42BP
	j4xuVLRbikxSs/h3qvqi4jqrdYobwPKiCBwZYj4Y9s1/ZKb1UGrxuhmE/HhVoj6+elVLev0qsw7vt
	GVJSkBsA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:53186 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tUllD-0005l6-2Y;
	Mon, 06 Jan 2025 11:59:07 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tUllA-007Uyx-4o; Mon, 06 Jan 2025 11:59:04 +0000
In-Reply-To: <Z3vDwwsHSxH5D6Pm@shell.armlinux.org.uk>
References: <Z3vDwwsHSxH5D6Pm@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Ar__n__ __NAL" <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Simon Horman <horms@kernel.org>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>
Subject: [PATCH net-next 5/9] net: dsa: ksz: remove ksz_get_mac_eee()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tUllA-007Uyx-4o@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 06 Jan 2025 11:59:04 +0000

ksz_get_mac_eee() is no longer called by the core DSA code. Remove it.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/microchip/ksz_common.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 60a4630dd7ba..89f0796894af 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3489,12 +3489,6 @@ static bool ksz_support_eee(struct dsa_switch *ds, int port)
 	return false;
 }
 
-static int ksz_get_mac_eee(struct dsa_switch *ds, int port,
-			   struct ethtool_keee *e)
-{
-	return 0;
-}
-
 static int ksz_set_mac_eee(struct dsa_switch *ds, int port,
 			   struct ethtool_keee *e)
 {
@@ -4664,7 +4658,6 @@ static const struct dsa_switch_ops ksz_switch_ops = {
 	.cls_flower_del		= ksz_cls_flower_del,
 	.port_setup_tc		= ksz_setup_tc,
 	.support_eee		= ksz_support_eee,
-	.get_mac_eee		= ksz_get_mac_eee,
 	.set_mac_eee		= ksz_set_mac_eee,
 	.port_get_default_prio	= ksz_port_get_default_prio,
 	.port_set_default_prio	= ksz_port_set_default_prio,
-- 
2.30.2


