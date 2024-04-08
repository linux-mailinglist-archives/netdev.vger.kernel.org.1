Return-Path: <netdev+bounces-85708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F70389BDFF
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 13:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ACF4281718
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 11:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99888651B4;
	Mon,  8 Apr 2024 11:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KTzs1ozl"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F331651B2
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 11:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712575161; cv=none; b=rZ8bGodEhd9wZzRe2t0qWMNJChcSL2MgvWkyP5lFBPMYM2ipebmDLIylCUx4zc+QK9DhG6ztx2wj16bpU5JYKmA9K1I6+T+jKvVWEJqiF4ot59D+Sc6kMNYHfPR/0dnUU8FLkz4JM+9znHQaIFvmcFwy/IUuvQwsm4aorNWooYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712575161; c=relaxed/simple;
	bh=vVP7G3uCwIFDBf1rGo7RdBTbWGiNF5aFzIpP1ZnvCWo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QjCiUzvSN68+6y6cqhm0w4ZGc4Atku362ak5uspC1VzEQYpiNdJNOitOz6KpoW6v9evPNFQqr5/WZ83I49AZbhWI82MMb+70Lb8mtBp0vBLX3DnUh1D3WbDKOaicX0J5aNuCvtjzAXnA34ZCrc+uQDhCwrHCdPhebSVwGxPwT9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=KTzs1ozl; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FaG1unAHeq7TwLEGPaOh/z6wgVU4RBxFPXp+k2dhLD4=; b=KTzs1ozl4CW7RLZUeBDj25zEHk
	+XujJqzjfPRytDQ0cZZUEaFQ/EUk9eWHANmtpsIciiFXN6mz/71Pm/QyDaE38Z90hq4KGx1MGcFb3
	DUaT0PWgZlx1g8Nv78KVK95XnywBoxrLTXJt/ViRD0MJFoWXNsEIgkUvHm7wKWlYFOsh1ZzOSTPGG
	rvuJeksDDsNErrtggD9lolKG8ABv6tKcViUTbsPDAirNCsaqax++ErMqxJBCajDHcdneIPqbL13f+
	FLwoD1tRelvDJAksxhniDkcbBiybmv2AF8j83TWnxg58nC6HRsJbKj4JUIqqtNBljSiugYpskeEl4
	gQYOrItg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50832)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rtn1k-00056V-1i;
	Mon, 08 Apr 2024 12:19:04 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rtn1i-00046w-Tt; Mon, 08 Apr 2024 12:19:02 +0100
Date: Mon, 8 Apr 2024 12:19:02 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/3] net: dsa: allow phylink_mac_ops in DSA drivers
Message-ID: <ZhPSpvJfvLqWi0Hu@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

This series showcases my idea of moving the phylink_mac_ops into DSA
drivers, using mv88e6xxx as an example. Since I'm only changing one
driver, providing the mac_ops has to be optional and the existing shims
need to be kept for unconverted drivers.

The first patch introduces a new helper that converts from the
phylink_config structure that phylink uses to communicate with MAC
drivers to the dsa_port structure. From this, DSA drivers can get
the dsa_switch structure and thus their implementation specific
data structure, and they can also retrieve the port index.

The second patch adds the support to the core DSA layer to allow
DSA drivers to provide phylink_mac_ops.

The third patch converts mv88e6xxx to use this.

I initially made this change after adding yet more phylink to DSA
driver shims for my work with phylink-based EEE support, and decided
that it was getting silly to keep implementing more and more shims.
There are cases where shims don't work well - we had already tripped
over a case a few years ago when the phylink mac_select_pcs operation
was introduced. Phylink tested for the presence of this in the ops
structure, but with DSA shims, this doesn't necessarily mean that
the sub-driver supports this method. The only way to find that out
is to call the method with dummy values and check the return code.

The same thing was partly true when adding EEE support, and I ended
up with this in phylink to determine whether the MAC supported EEE:

+static bool phylink_mac_supports_eee(struct phylink *pl)
+{
+       return pl->mac_ops->mac_disable_tx_lpi &&
+              pl->mac_ops->mac_enable_tx_lpi &&
+              pl->config->lpi_capabilities;
+}

because merely testing for the presence of the operations is
insufficient when shims are involved - and it wasn't possible to call
these functions in the way that mac_select_pcs could be called.

So, I think it's time to get away from this shimming model and instead
have drivers directly interface to the various subsystems.

This converts mv88e6xxx. I have similar patches for other DSA drivers
that will be sent once this has been reviewed.

v2: fix up patch 2 to call the mac_link_down() method as pointed out
by Vladimir

 drivers/net/dsa/mv88e6xxx/chip.c | 63 +++++++++++++++++++++++++---------------
 include/net/dsa.h                | 11 +++++++
 net/dsa/port.c                   | 41 +++++++++++++++++++-------
 3 files changed, 80 insertions(+), 35 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

