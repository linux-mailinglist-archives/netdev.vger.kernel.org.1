Return-Path: <netdev+bounces-91765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E728B3CA0
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 18:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55CF61F23A6A
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 16:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD2F14EC5C;
	Fri, 26 Apr 2024 16:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IIa8YYrj"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6C6152511
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 16:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714148291; cv=none; b=Pb0ppBooGsLcNQw7tm1KUomUmHv4VLrPHAWxn3zeZQIRT2XRDIQwEeNclnOEmK5JiqcW3EV8gBr+/FwPeyleWyuc5ayv2D7/8qgyJm4lJr5aRTvH9tVlOqo5+s5o3gHfseH7wQQd3p2y0DlbRARtn/OqpLBC4UvEHf8ze+/dlOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714148291; c=relaxed/simple;
	bh=R4ys6c4dIp07oirNc2lWk3GwGQXTXhedFoYOeX3NcCE=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=e12O6vy+FHAQ0JlE8KetxtLchqjVRb4G2eMe6AHkY+jDMuMjZAdy3lNf8nF14b4IpIbZWoMSYYM7AfymAlPYpVCOtgPuZEI5Wb+JQQ8hMFOWTPnmHWlvp6VmwkrA9wnVTnURssMBBg1hVCKUH9zWwPw+V5nC7Tdzq/nCa1IjMuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=IIa8YYrj; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kPbXPhbSAci25KHhf3LrA7D43cnLOKy4dzaaLXUYURc=; b=IIa8YYrjqaQ4aSzifTE6Yd6B1+
	XblhsMTzEVvIOw1YRVFNrJaImBvlcoOjecIK6U7jAr4CcRtxLvGkWx0UqMzT5Uod/s1R54NEDHadR
	awjwVpYUNHLH0lCW151e3UptFwYurfFOIi0veIO5sUeODJ6HrnHsc953zS28uy224VwXRgrH0MHJa
	PpfJMriJdD4/2oZS410KL75xIBnIPnWI6x3nDpvlrgxv6ZMp5WJXPom3O4MS5huVV6QGeObOdzV0U
	KkjPbdjT0wh1wyZEHqCpUO9vA69KWs9eSJeyIF8DaplOIJRlhsJr+FKnS/EQPdp/fLsAnSOl8Fxv1
	J/I5UdNQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38508 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1s0OGw-0000Vv-13;
	Fri, 26 Apr 2024 17:18:02 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1s0OGx-009hgr-NP; Fri, 26 Apr 2024 17:18:03 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Taras Chornyi <taras.chornyi@plvision.eu>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: prestera: use phylink_pcs_change() to report
 PCS link change events
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1s0OGx-009hgr-NP@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 26 Apr 2024 17:18:03 +0100

Use phylink_pcs_change() when reporting changes in PCS link state to
phylink as the interrupts are informing us about changes to the PCS
state.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/marvell/prestera/prestera_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_main.c b/drivers/net/ethernet/marvell/prestera/prestera_main.c
index 4fb886c57cd7..ba6d53ac7f55 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_main.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_main.c
@@ -821,7 +821,7 @@ static void prestera_port_handle_event(struct prestera_switch *sw,
 
 		if (port->state_mac.oper) {
 			if (port->phy_link)
-				phylink_mac_change(port->phy_link, true);
+				phylink_pcs_change(&port->phylink_pcs, true);
 			else
 				netif_carrier_on(port->dev);
 
@@ -829,7 +829,7 @@ static void prestera_port_handle_event(struct prestera_switch *sw,
 				queue_delayed_work(prestera_wq, caching_dw, 0);
 		} else {
 			if (port->phy_link)
-				phylink_mac_change(port->phy_link, false);
+				phylink_pcs_change(&port->phylink_pcs, false);
 			else if (netif_running(port->dev) && netif_carrier_ok(port->dev))
 				netif_carrier_off(port->dev);
 
-- 
2.30.2


