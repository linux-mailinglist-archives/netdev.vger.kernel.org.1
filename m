Return-Path: <netdev+bounces-131959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB7E9900BD
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 12:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EEA81C232CD
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 10:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A081494CF;
	Fri,  4 Oct 2024 10:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IHsg0vzE"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5E7137903
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 10:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728037228; cv=none; b=rsfnXSjpzXmq0wey2lJbDOYsn5TUlYKxBXHx48e3Qf4MA6+HKAb9f8vz3jJ2zF2FnHBx2pE161fyx+S764ME0gnplXnapQG54KBJTP88Aog466E4CedaYDK1F2y0Ue1UU+LCbYiv9ZJqPEzQfXBNt7OI+yoNsj+PYVBaJSt9X5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728037228; c=relaxed/simple;
	bh=ofjQSUc0h77WX1o2ephmMiUGWI4mR07fot68T4gefkI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kpiWYoX7MJCzDyPlKG0pjtnGo60I3RKSa5pR9X9LgduxJbLQVi0EAdSuvPqB/8k6SuARScKXQZ+tvBz4w0H6ekuuls10Xdda1WB92kzqzTePNG6BT4Scyj13yryywnPxQK4EyBHfnFw4bhVAxR8KqEeLlXrmqr6YQfJFdQ8+oUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=IHsg0vzE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=g5gMsMlOt6+uUT+iqof24T3eZesuF6qztprcqRPdYLE=; b=IHsg0vzEv5qz9GOw5lXDVzbEzv
	ZnTWNB3bY4TryT+DXC5e6vRKWDBrs9idERQ/4nTStu3sOOLkCdzzZUMAqWuiGTzge5JMxqAvizPOl
	8OPG9J4g6iC4ZRPghgepHAl4nD76uJnBfHJvmVxVDLFNciVljJ6aiFO9wJQgXg3p44BojTTrrg/Of
	lI4SlghrghkX/tIv23vfVkpVppmhUiwmjQmt+XhJjmqRkuZdsPKucrA7ILwtOaov1QvVRDcwk30yc
	U71meNoT0bamu6Qu8BfYPLZobG+xqUq6yyBxUDj53qQllXNUZSriY6hXYYXoaWCbypI/R6GPrsauw
	pvZuJ5Mg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43032)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1swfPp-0001fb-3D;
	Fri, 04 Oct 2024 11:20:05 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1swfPi-00016R-0C;
	Fri, 04 Oct 2024 11:19:58 +0100
Date: Fri, 4 Oct 2024 11:19:57 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 00/13] net: pcs: xpcs: cleanups batch 2
Message-ID: <Zv_BTd8UF7XbJF_e@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

This is the second cleanup series for XPCS.

Patch 1 removes the enum indexing the dw_xpcs_compat array. The index is
never used except to place entries in the array and to size the array.

Patch 2 removes the interface arrays - each of which only contain one
interface.

Patch 3 makes xpcs_find_compat() take the xpcs structure rather than the
ID - the previous series removed the reason for xpcs_find_compat needing
to take the ID.

Patch 4 provides a helper to convert xpcs structure to a regular
phylink_pcs structure, which leads to patch 5.

Patch 5 moves the definition of struct dw_xpcs to the private xpcs
header - with patch 4 in place, nothing outside of the xpcs driver
accesses the contents of the dw_xpcs structure.

Patch 6 renames xpcs_get_id() to xpcs_read_id() since it's reading the
ID, rather than doing anything further with it. (Prior versions of this
series renamed it to xpcs_read_phys_id() since that more accurately
described that it was reading the physical ID registers.)

Patch 7 moves the searching of the ID list out of line as this is a
separate functional block.

Patch 8 converts xpcs to use the bitmap macros, which eliminates the
need for _SHIFT definitions.

Patch 9 adds and uses _modify() accessors as there are a large amount
of read-modify-write operations in this driver. This conversion found
a bug in xpcs-wx code that has been reported and already fixed.

Patch 10 converts xpcs to use read_poll_timeout() rather than open
coding that.

Patch 11 converts all printed messages to use the dev_*() functions so
the driver and devie name are always printed.

Patch 12 moves DW_VR_MII_DIG_CTRL1_2G5_EN to the correct place in the
header file, rather than amongst another register's definitions.

Patch 13 moves the Wangxun workaround to a common location rather than
duplicating it in two places. We also reformat this to fit within
80 columns.

 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c |   2 +-
 drivers/net/pcs/pcs-xpcs-nxp.c                    |  24 +-
 drivers/net/pcs/pcs-xpcs-wx.c                     |  56 ++-
 drivers/net/pcs/pcs-xpcs.c                        | 445 +++++++++-------------
 drivers/net/pcs/pcs-xpcs.h                        |  26 +-
 include/linux/pcs/pcs-xpcs.h                      |  19 +-
 6 files changed, 237 insertions(+), 335 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

