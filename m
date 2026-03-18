Return-Path: <netdev+bounces-268916-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOG/JZFjummoVwIAu9opvQ
	(envelope-from <netdev+bounces-268916-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 09:34:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 914732B81A0
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 09:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D396300AD4E
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 08:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D55A246BC6;
	Wed, 18 Mar 2026 08:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="baO9XAXy"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67C3285C80
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 08:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773822477; cv=none; b=a48ilAtUoqOGzFYEt7FZRmtJjhMahaZ8fdwqcykDF/BjLQdr7qrN+3NPBENvHnra9Vwwo2TCHwGtkXCfoESPLdSSmvAh84N8yaDF6DtNPv/DysBA581aHXwHp9/qMJb4gRoROUCp8S92PYBwiJS0w65gjUOK0OL691mimrTqX+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773822477; c=relaxed/simple;
	bh=ofWzG+TZmi3oV5yOiNZfwlTkhM9hrajx92UsNLLUKBI=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=V5njocJrGqZjtucqjdbfH6ZtrZJzoMHKwyrpN+S6ZcyFprpPrKzwpuUY5nNy3kOzsc4sLtG2a9ZWav3Yb0+7qxM8v9YLjXFJd61IJuNueXarRQY5F6WNWyy2Yqj1LeTo4haDGvZUl5PQfatD/IIWahL0N4NnjKZlGlU3GsEXs90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=baO9XAXy; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TxdMl9bR+bGsBgQD99s++n6aKWHLjlhy5SMeZDTuxBg=; b=baO9XAXy07ulc8rM74Wn8vNuDy
	gqZpWClpCFH+QL8jC6UszAqJ2j1lUk3HFBHThHIoacHHsx7iWsybhJ/e7dqx5hmk34bC7dE4Vy/IY
	Ia+27ayP9Mj/vYsmYVirBB+w1zBtQW03EZY62KXHOtBEB4dxK+Ar8OXhWVzattj1JHg3Ed+yE2FVV
	85VkZusbi23FKpDFqjf5lvKWpLUsvYFyWOvUCZg6fvK/1VfegZDtCuGFhi9EqHF/vPmZG+roXkK6h
	EX3C+iilwTKOCNlo2XIW3khbnlHjSVUoG3/m3uw5AGl3qwJ6F5FADFU0ayrxP/tBLCqd5uCvMFXmt
	H/gKmU2g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:58734 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w2mFl-0000000033f-1c4h;
	Wed, 18 Mar 2026 08:27:45 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w2mFk-0000000DXW2-2PR9;
	Wed, 18 Mar 2026 08:27:44 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] net: phylink: add debug for phy_config_inband()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w2mFk-0000000DXW2-2PR9@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 18 Mar 2026 08:27:44 +0000
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268916-lists,netdev=lfdr.de,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.959];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 914732B81A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add debug for the phy_config_inband() call so we can see which inband
modes are being configured at the PHY.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 59bcc69b6c39..1c178038e6f1 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1341,6 +1341,13 @@ static void phylink_major_config(struct phylink *pl, bool restart,
 	}
 
 	if (pl->phydev && pl->phy_ib_mode) {
+		phylink_dbg(pl, "configuring PHY for inband%s%s%s\n",
+			    pl->phy_ib_mode & LINK_INBAND_DISABLE ?
+				" disable" : "",
+			    pl->phy_ib_mode & LINK_INBAND_ENABLE ?
+				" enable" : "",
+			    pl->phy_ib_mode & LINK_INBAND_BYPASS ?
+				" bypass" : "");
 		err = phy_config_inband(pl->phydev, pl->phy_ib_mode);
 		if (err < 0) {
 			phylink_err(pl, "phy_config_inband: %pe\n",
-- 
2.47.3


