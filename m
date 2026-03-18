Return-Path: <netdev+bounces-269149-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEcnCFPuuml0dAIAu9opvQ
	(envelope-from <netdev+bounces-269149-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 19:26:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC032C138D
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 19:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E9E13010484
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 18:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9C03BFE33;
	Wed, 18 Mar 2026 18:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MGDf90YM"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A8E3CD8C8
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 18:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773858384; cv=none; b=gdHf74/DDXXnJ2SL9eP4KWG7tI3GG4YxgeTZaQrzyjE32i1dmkA0BMLjwwm+60qER56QQGheDG/iv9aQxRg80HNCodUutw2JbpyIwg7k2a/y6dR3ht1HTZr1fbhM2oYppWALL1Hi5QFN3L6R4kYK9P6SQWGMubYZgPTosrsWvdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773858384; c=relaxed/simple;
	bh=jVseAMGDZnEnDSsab2/hfTJam7jaDka2m+kybhypjys=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DecUANqQVKuyrBKpw+Ma7xej8K65oP7oTOZJD+k2avnCzzpSHgwFWleB5OEqIJ7B0shgfFznoWJFbuaNFZ06PruDLpHaZe3Yrfwir5NM6gmk8K9JegjXkltqpPyNWwrnY/0dDpNgZl9ux81weap3oG6Qr1j2EG9eI8CC6oUTz8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=MGDf90YM; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IgmHv1W2xff5lyiQbHV+n4Yse37UxYTbZx0k4RwQlNE=; b=MGDf90YMO1+FhI2NwjaX+6K3ZR
	dkMnyqDAtrgXGwTUPHlT//njb7PtlDfEYStx9317lfMMNTVZuKZpX1sGGHZLGkgTobqaHkb9fPN1o
	qWzohUrv4aQ90HKcRIEf+bslEXfB0ideBcEjHCtJP3ck3ltgc37JMmUPnyXGTxZ/oLaVCnHk8/cqD
	jX90SF5hlXu16fywJhkzJ33QDmr5OVLEfePHcowM5iLI+B40UeHyfPwP1K1riKdrwLDzsrLJnx5Ja
	dbDiMptugqEQ5Ht8E9uzu8NlVqDHuO809nuYbYEDNfCnQFQlJDHJ6Axupw8QqKid67dXF/6bXCJ/5
	9qiZeMiw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44118)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w2vax-000000003ok-2skG;
	Wed, 18 Mar 2026 18:26:15 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w2vav-000000007IU-1OAe;
	Wed, 18 Mar 2026 18:26:13 +0000
Date: Wed, 18 Mar 2026 18:26:13 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/5] net: stmmac: descriptor cleanups part 2
Message-ID: <abruRQpjLyMkoUEP@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269149-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.703];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8DC032C138D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Part 2 of the stmmac descriptor cleanups.

- rename "priv->mode" to be more descriptive, and do the same in
  function arguments.
- simplify descriptor allocation/initialisation/freeing
- use more descriptive local variable names in stmmac_xmit()
- STMMAC_GET_ENTRY() doesn't get an entry, it moves to the next one.
  Describe this in the macro name.

 drivers/net/ethernet/stmicro/stmmac/chain_mode.c   |   2 +-
 drivers/net/ethernet/stmicro/stmmac/common.h       |   2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c |  12 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_descs.c   |  12 +-
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c     |  20 +--
 drivers/net/ethernet/stmicro/stmmac/hwif.c         |   4 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |  12 +-
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c    |  21 +--
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c    |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   5 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 152 ++++++++++-----------
 11 files changed, 127 insertions(+), 117 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

