Return-Path: <netdev+bounces-157717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99367A0B5F3
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 12:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC33166A91
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 11:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CB01A8F98;
	Mon, 13 Jan 2025 11:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="j00IdBCf"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D611C07C1
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 11:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736768777; cv=none; b=hgkCW49ZLuVoNHja2IT3Kp6tUNjYNWm/rr8SG5oLNPbx/mu4YH7FojksQusAkDW4miXJrWXrgO5N9suPwFfhu49Y0VQcyHzgnMjfozVRyNw9uSiSwJUTxBM4gS5CrhUQhIa2kiuSpq61KK3mepiAJpYuqaeKzJBu5d03t/ijdOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736768777; c=relaxed/simple;
	bh=GCJH4Zl6I7sjiJ1mbDG5Cn6k41VwAbQYslrv7EZvCO4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ONniHeBsaoNcivMiFEd/MwfeaJUmJKHP8ES6NLj7rcRN48qARWOfG4Rapfcc35KOU2akqtvAVfpKsnDFLboJubp4zDGggoE1qHDVNGDk8EXkZSc+1FyIJ7ASJeAd8xBykugjLR1njKVunAXAk+l1ypGRvc1mH+NbiEGZlDp7ZvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=j00IdBCf; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hOdrpZAmSqRk7KcSBI8gGwUZGDxOvGDd/H3Zqd4B98k=; b=j00IdBCfKR/wGmZxAJzkeUg4bb
	CZ0lU6ZzRKt6fvWLNS+BdXQ3P9thS8ZKaGuGxqTc9G5gg0pb2o3gJ2vtGjYobsB+o2tq/RQ6offB/
	0z0XgeQwLFF9XPyPv/OblcLDH+T+ZUPC0TNLSOS6Z3NVV0yokCphg2MduP1C/6ieoWiKXrx2ORN4w
	ldD9jA+cHAY1mix6C3xOH5yUkqsTRN80a/cS9OCX/UnZT2c4WG8wD7Y91tPzH/VPhY25d/nz0g3cF
	XQjKDe/C69TChJhKZwWv1beMdzqB/sqma8cj9f1mrSoJGEbLe58E+zUQS6pWjNvF2cHEi8Y3qE0Pb
	eCGBzmgA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:48036 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tXItV-0006VQ-0K;
	Mon, 13 Jan 2025 11:46:09 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tXItC-000MB6-54; Mon, 13 Jan 2025 11:45:50 +0000
In-Reply-To: <Z4T84SbaC4D-fN5y@shell.armlinux.org.uk>
References: <Z4T84SbaC4D-fN5y@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Eric Woudstra <ericwouds@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 3/9] net: stmmac: simplify TX cleanup decision for
 ending sw LPI mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tXItC-000MB6-54@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 13 Jan 2025 11:45:50 +0000

As mentioned in "net: stmmac: correct priv->eee_sw_timer_en setting",
we can simplify some fast-path tests.

The transmit cleaning path checks whether EEE is enabled, the transmit
path is not in LPI mode, and that we're using software timed mode.
Since the above mentioned commit, checking whether EEE is enabled is
no longer necessary as priv->eee_sw_timer_en will be false when EEE is
disabled. Simplify this test.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f1e416b03349..e8667848e0ee 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2782,8 +2782,7 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue,
 			xmits = budget;
 	}
 
-	if (priv->eee_enabled && !priv->tx_path_in_lpi_mode &&
-	    priv->eee_sw_timer_en) {
+	if (priv->eee_sw_timer_en && !priv->tx_path_in_lpi_mode) {
 		if (stmmac_enable_eee_mode(priv))
 			mod_timer(&priv->eee_ctrl_timer, STMMAC_LPI_T(priv->tx_lpi_timer));
 	}
-- 
2.30.2


