Return-Path: <netdev+bounces-232542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C471AC06532
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 14:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBEAD1A67DE9
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 12:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6521E31A04F;
	Fri, 24 Oct 2025 12:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WBNDUlYV"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C021631985D
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761310186; cv=none; b=TuFCzgRZJX/In7LAcVfVyKEBZMH34UXzdXUVURw+l9h80TwEDr32h+UvtfxIhdEa+ospbvYgLMnoSdVXju6BujbMd5ZRQcUvioD6Nyh0OBTWejaIGK6/Y9PTE3mzLIZZbLIA4A6uNvh1FSI4hokVDK8QNl+GnE2zhNX+hPHFMm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761310186; c=relaxed/simple;
	bh=Jx51LrstpFgOs34KQeSLwU1kRM+ly78rYRUGfNC7dgo=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ciU0Z6Glu2H2LsKf6UEEUz/uFNvcZzS3Mek+Xgm87oSKQPlqmPeAhJkaF9B+7njNnb8B1Y6zBVn3B7HmLDPNGy/vrBX6QNrqk8tR4gTpRf5/emgT3bX3b/FspsjRiy3AyxNvRStg6KoS9pQR0GI7sK7LwEhZhiwyxatGyb0mbgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=WBNDUlYV; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=E0No7cruyWx2qZBY+buUWbnCGY9SGIALpdVgd4OG3fw=; b=WBNDUlYV2nbGyJ/1Gm+z/iHz18
	CfR93CN7zEm1ayY+9vjLpw8iF3dBVk6pjPnwEFB8VM4mAAZwhYb2DQh5fWhAgoMUJiSO7Eu9MiBt1
	083PiRKHqzZXRpU1l8dYzmhtu63kHPKIg1o9lOomestjXLUhInYmnHqg5Vcohk9dsDri1XHsFDMzx
	7veX+jrrBi4LM0i6Oux5NalwzfnFK/l9aFtDkmm9SM+NV0kZtZ+adNzGS6Dt2RrhnVzWrqwNEsWNh
	csWNTauLjriQmHyjWH5YVsWOwEe8uUpg8hj/paDCP0YpdgOW8BacTZvC5YCmhL2WtpjuSzuU219j+
	P7v3TZvQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50616 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vCHEe-000000007bX-3gQe;
	Fri, 24 Oct 2025 13:49:36 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vCHEd-0000000BPUG-3cS7;
	Fri, 24 Oct 2025 13:49:35 +0100
In-Reply-To: <aPt1l6ocBCg4YlyS@shell.armlinux.org.uk>
References: <aPt1l6ocBCg4YlyS@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH net-next v2 7/8] net: stmmac: use != rather than ^ for
 comparing dev_id
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vCHEd-0000000BPUG-3cS7@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 24 Oct 2025 13:49:35 +0100

Use the more usual not-equals rather than exclusive-or operator when
comparing the dev_id in stmmac_hwif_find().

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 6c5429f37cae..187ae582a933 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -314,7 +314,7 @@ stmmac_hwif_find(enum dwmac_core_type core_type, u8 snpsver, u8 dev_id)
 		if (snpsver < entry->min_id)
 			continue;
 		if (core_type == DWMAC_CORE_XGMAC &&
-		    (dev_id ^ entry->dev_id))
+		    dev_id != entry->dev_id)
 			continue;
 
 		return entry;
-- 
2.47.3


