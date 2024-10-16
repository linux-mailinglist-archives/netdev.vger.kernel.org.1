Return-Path: <netdev+bounces-136121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CB59A0643
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 11:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F711F25D39
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 09:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDCE206061;
	Wed, 16 Oct 2024 09:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HLvg+nX1"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1AA199944
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 09:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729072710; cv=none; b=StJy1TDehCaGiRd4jeIUDylXMTTgRMZXDR2E+ONinHo0fPXoPhZE3IKQZ01I502Id1nJbHcLTXD+/ohfsnzX89B3yRc/2zwjaeISTG6AGZ/zrDUuJf+oVZgIGt3XJ8hHu+bIaRJYPmGjJSSqhuZXAQyWonWZAW71cQS/RPH2sgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729072710; c=relaxed/simple;
	bh=DmLPmLRaziza5ewwjphLPzMhIQDGOKj2U5ryKGjIm7A=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=pJJakPPuALd8lNvXxnKN8oJBy4tbGDrkw0klN2MdxU3i+89RkA4J4FMTZ6oeJQF2CSbGv+iQ4BQo80cxmMLUMSmW7QPz4dWrGLrFghsXVWKD7BhmkWUONrs2ULr2TSwXsfgY4cQXOpN4rZMS90j1W2UF961DdRpFMkC/uAN/lBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HLvg+nX1; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qlsgT3uh8K9k1PV5YZmeebJi1rGILfxVcCKMi1nm2lU=; b=HLvg+nX1PeN8GpgroUhDTStDQW
	lmEDhmzSmv/ce+y6XzuKB72w/EIPUKPPK0GKbKlTqwTHlwMDF+e85Nnj4wfu571P4YgvS4qz0afOO
	E660b5QZcygedHQ/Kf18sdk3AZ9SH10zlPoiXd3flgjC8sX7iAzExYdFSdRMTPLJVHFa1Ti3xCxRb
	yvXrs5VTpYCpT6BTMT2GYEu5qAtjIJw34/0xkeEji5tjHEOBpig78eOTayxJU1oJmfmD+vHoTdyk3
	owR2Cx/AFqdjZEFkd2KeO8bbAo3EsOL4CjqQKDWfri0yNY2UMvQkJ5puAfB6lM4ft0YctRAYVZA5L
	B+2wpIig==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:46252 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1t10nQ-0004rT-1S;
	Wed, 16 Oct 2024 10:58:24 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1t10nQ-000AWQ-Db; Wed, 16 Oct 2024 10:58:24 +0100
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
Subject: [PATCH net-next v2 1/5] net: dsa: remove
 dsa_port_phylink_mac_select_pcs()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1t10nQ-000AWQ-Db@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 16 Oct 2024 10:58:24 +0100

There is no longer any reason to implement the mac_select_pcs()
callback in DSA. Returning ERR_PTR(-EOPNOTSUPP) is functionally
equivalent to not providing the function.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 net/dsa/port.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/net/dsa/port.c b/net/dsa/port.c
index f1e96706a701..ee0aaec4c8e0 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -1575,13 +1575,6 @@ void dsa_port_set_tag_protocol(struct dsa_port *cpu_dp,
 	cpu_dp->tag_ops = tag_ops;
 }
 
-static struct phylink_pcs *
-dsa_port_phylink_mac_select_pcs(struct phylink_config *config,
-				phy_interface_t interface)
-{
-	return ERR_PTR(-EOPNOTSUPP);
-}
-
 static void dsa_port_phylink_mac_config(struct phylink_config *config,
 					unsigned int mode,
 					const struct phylink_link_state *state)
@@ -1604,7 +1597,6 @@ static void dsa_port_phylink_mac_link_up(struct phylink_config *config,
 }
 
 static const struct phylink_mac_ops dsa_port_phylink_mac_ops = {
-	.mac_select_pcs = dsa_port_phylink_mac_select_pcs,
 	.mac_config = dsa_port_phylink_mac_config,
 	.mac_link_down = dsa_port_phylink_mac_link_down,
 	.mac_link_up = dsa_port_phylink_mac_link_up,
-- 
2.30.2


