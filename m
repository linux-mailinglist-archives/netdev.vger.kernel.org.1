Return-Path: <netdev+bounces-155419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B39A024A4
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 12:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F0D61885D2C
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 11:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5201DD874;
	Mon,  6 Jan 2025 11:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="kim957CC"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B40A1DC05F
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 11:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736164742; cv=none; b=IVBTpsXlL9aTlDLv/dMXJ0MPTHa1d5vniHKoSnewt44I0c0CMLbWJAhkdYEGXHLsFhwykkMVrSOabismnSlNJVJFL/n48acmmDlHT3TcpIoMs4ggkwdw2fgEBVYsxcK9mWzrt9bwHjFNZVou+2Wcy+t0HykDDLmyMqSkW1ehmmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736164742; c=relaxed/simple;
	bh=pCtyD2WRVF6fGGaWtI/hAUYUTpIxwfCoxyO+8fAeEh0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=dUxTemtTCtey4KJW93DVuqd95xhE/x4qM7ZN8nIOf/NnYGP6keB9tLTmiUQCgXb1CqExIGmZDNIKWg5Mf8Os6qZq7IArbMP/c+Osl/iM8+6OxPPG/l49rGjY8YjLMBJKtch3EvFmlVIwpXmpyTCGK039xUQ6RO+GPCk8Wu5yJ3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=kim957CC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Tpla/p5jBbXU8PHtAJsqJXMShZ+2IQdFhklawDkmOxI=; b=kim957CCwJw2F0uyW8on/x6ptj
	CdMTQGZpQXlS9VWnCYJBE011UoxOC6m07+lSBaeF6L5uwIt+DhvqgNuwhtl70BVvt45+7iQFxYcxh
	6ngHHDU+nzgUqkKvfk5uys7pmF9zHOfOgU57V29i82m0tXnaGXzRH+q2OHmN9rZziHaUfKh+W7ejn
	HHdnPpJad9vwjhhWjmK0JN+MRLzHRn7uyG1vbw0v/AHVOa0XZN+fPx5yrlvbpTvWYvpmSo6HGPW17
	RzEP2zohaZHNyVu5xpp/HCQCWIs/3Qt1E5ejCU7kRuHsDz84TbgKxdpHYVWxO+yV42CNS6Kfz0eqk
	YusGlGqg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:52330 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tUlkx-0005kC-2p;
	Mon, 06 Jan 2025 11:58:51 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tUlku-007Uyc-RP; Mon, 06 Jan 2025 11:58:48 +0000
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
Subject: [PATCH net-next 2/9] net: dsa: mt753x: remove setting of tx_lpi
 parameters
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tUlku-007Uyc-RP@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 06 Jan 2025 11:58:48 +0000

dsa_user_get_eee() calls the DSA switch get_mac_eee() method followed
by phylink_ethtool_get_eee(), which goes on to call
phy_ethtool_get_eee(). This overwrites all members of the passed
ethtool_keee, which means anything written by the DSA switch
get_mac_eee() method will be discarded.

Remove setting any members in mt753x_get_mac_eee().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mt7530.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 9605febd3573..4c78d049b9f4 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -3088,12 +3088,6 @@ mt753x_setup(struct dsa_switch *ds)
 static int mt753x_get_mac_eee(struct dsa_switch *ds, int port,
 			      struct ethtool_keee *e)
 {
-	struct mt7530_priv *priv = ds->priv;
-	u32 eeecr = mt7530_read(priv, MT753X_PMEEECR_P(port));
-
-	e->tx_lpi_enabled = !(eeecr & LPI_MODE_EN);
-	e->tx_lpi_timer = LPI_THRESH_GET(eeecr);
-
 	return 0;
 }
 
-- 
2.30.2


