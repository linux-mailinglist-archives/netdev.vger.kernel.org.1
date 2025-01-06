Return-Path: <netdev+bounces-155418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1900A024A3
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 12:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6099B188287B
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 11:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793581D9A56;
	Mon,  6 Jan 2025 11:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0CUjRiDB"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51F21D8A0D
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 11:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736164740; cv=none; b=USs/4/URiZcbaDDcCsOWOIFzaVr9Od0E6SbHXuX36KzdaNTg+uwnZzYT17giwaQv2jCa9pMFt3KkK8tC/eEfx/5WkxryRdR46SH4aI+pFA8/eUuW24gfIE0lEKQnb5vCGtnrO2lH8B2EMW+WJWjlU2p9id0m5OJ1ZkhZQkyt34s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736164740; c=relaxed/simple;
	bh=Rc8VySvUZZJExdHrprGDBiAnU5GUl8beszNYZDjrjSo=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=h1eM2Pt5+cTqo/jX007JNvPxtENXzqedBjkrmcKIXgb2AItb++0QDAROdN9IlrfJHM0AOgCKUzDR1SZfUVm1UiUATzZ1YrUHk0SxRYxAuYzTEUrCHqCum35eprwy6ZL00/2zRZ4Z3OPlJtQqgZGm2MPf98uPCii3PUHZalbqtjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0CUjRiDB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YaIwfo3a3xNY9w0lpoJEGzMt05JFAo3+kHqFGw6dWEM=; b=0CUjRiDBpeqq/aRdQ3h3jjBwGv
	JPXREV5M/ICLFd9KhbVLmn5pAp4jSjJ3V/z/0tZDrrFYtnY/NpCAj1jGhlCu9qL4V7mw911t1sVzW
	le+sTBmQde2oGEB7/ZamT03HtypDCt56x3hFkItNsE+9nr8pUtyPSnFO4iBovXXPuKHuHqRrp3bpV
	j5JalkxjZLFJEwJfPxrYkvtKvW0FusHtbtbdD5F36dw8BYacB8G6Khi7Iy8au11ByWSuDZsf1VBev
	f0hNr73BdPO1EB+3MtEBvw04WB8UHJlMYzhiPuenxUMUFixZKt5HX2+uCORaX4d4N2I/P3yiNKE2r
	Tg8NV7tw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35618 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tUlks-0005k3-2E;
	Mon, 06 Jan 2025 11:58:46 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tUlkp-007UyW-OR; Mon, 06 Jan 2025 11:58:43 +0000
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
Subject: [PATCH net-next 1/9] net: dsa: ksz: remove setting of tx_lpi
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
Message-Id: <E1tUlkp-007UyW-OR@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 06 Jan 2025 11:58:43 +0000

dsa_user_get_eee() calls the DSA switch get_mac_eee() method followed
by phylink_ethtool_get_eee(), which goes on to call
phy_ethtool_get_eee(). This overwrites all members of the passed
ethtool_keee, which means anything written by the DSA switch
get_mac_eee() method will be discarded.

Remove setting any members in ksz_get_mac_eee().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/microchip/ksz_common.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index e3512e324572..60a4630dd7ba 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3492,14 +3492,6 @@ static bool ksz_support_eee(struct dsa_switch *ds, int port)
 static int ksz_get_mac_eee(struct dsa_switch *ds, int port,
 			   struct ethtool_keee *e)
 {
-	/* There is no documented control of Tx LPI configuration. */
-	e->tx_lpi_enabled = true;
-
-	/* There is no documented control of Tx LPI timer. According to tests
-	 * Tx LPI timer seems to be set by default to minimal value.
-	 */
-	e->tx_lpi_timer = 0;
-
 	return 0;
 }
 
-- 
2.30.2


