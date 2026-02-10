Return-Path: <netdev+bounces-258137-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBVrBfVqi2lKUQAAu9opvQ
	(envelope-from <netdev+bounces-258137-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 18:29:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8301C11DEFF
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 18:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8489D300A7CC
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 17:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7C92F5461;
	Tue, 10 Feb 2026 17:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lS8ZExtN"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59172B67E;
	Tue, 10 Feb 2026 17:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770744560; cv=none; b=L4RbVF+9+fI7esSCK+oM42BeDXjcxarqEI5X4lsFBxQhac48Cm2T2eGxJGCTU+tNqcKh12bWc3ua8dDC2o50OeQEQlKBG2sgrdNmMboqJdQyqFOeuwoi+v+OeQskFBrHxT4N9qSQuG2is4JnpI9uJ9yjZq7d+6sHVKQ0wGglUok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770744560; c=relaxed/simple;
	bh=9OT2lx2uxNzCCUK+DG+5c5gmSk9vM31VHB1FAyFfS5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQiuMMA8HU1aJY0qi24/8epk5b6HGBvkqBDwCAu+R4WbbQXp7olmb8zQiRqub6ezZUTlSS7nZn3BEMKJxdn0Xhwqhy9IVWu6VbWmrJWGZJOdcwJ7Y9Z9cDDdscaGUWyj/vNP8/aSZEGl3he2pd0Dg9x7vZmhNhEgnLkGqC9Bfkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=lS8ZExtN; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DAcKfWlVvFpjnpX3kQn9TetvuG3kY2q/0ckoODgRSz8=; b=lS8ZExtN/PJ9GM/RXNnUoJG8xu
	6BflzLkWMBbQhdzgpK+AV0vqxRBebBiUyfiu1SKrZKq0gxMvq/yfGWHJ58V4fIHc8e/uD0A/7Jq5f
	4lfO1aLUAJMDynrbTDZX7UShpk1ocV/xlbxN5Ncp4XBC8Ixw04ZXkOj7HJEVUbR80+dOjZne1sTKJ
	pDbP72WGuFcqTmncwm9RI8+6OtP9ZKl85doJvfuVOi+Jwqs/F1BskWyp0AGt5dVBnfDAK+NvN5MBC
	/SDZwjKf53yuDARAK6J/+9RKq2q3auogNniNAidjRbxw1a+ACOIscIzERYhkwtxE+t6NkAZLV4CaC
	8zegnKLg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49462)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vprXy-000000002oy-37Of;
	Tue, 10 Feb 2026 17:29:10 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vprXv-000000002xA-2Lqw;
	Tue, 10 Feb 2026 17:29:07 +0000
Date: Tue, 10 Feb 2026 17:29:07 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Ong Boon Leong <boon.leong.ong@intel.com>,
	Voon Weifeng <weifeng.voon@intel.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: stmmac: Use cpumask_local_spread() for
 IRQ spreading
Message-ID: <aYtq4ypxXTvn_Is6@shell.armlinux.org.uk>
References: <20260210-flo-net-stmmac-default-affinity-core-v1-0-4e76612444e1@siemens.com>
 <20260210-flo-net-stmmac-default-affinity-core-v1-2-4e76612444e1@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210-flo-net-stmmac-default-affinity-core-v1-2-4e76612444e1@siemens.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258137-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,intel.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8301C11DEFF
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 05:28:15PM +0100, Florian Bezdeka wrote:
> The stmmac driver was previously implementing a self-made IRQ
> spreading mechanism based on num_online_cpus(). By migrating to
> cpumask_local_spread() the spreading gets NUMA aware.
> 
> In addition, most drivers seem to use cpumask_local_spread(),
> aligning / harmonizing a bit more.

Oh great... sizeof(struct stmmac_priv) is already large at 880 bytes,
and adding 16 pointers or CPU mask arrays for PCI MSI adds another
128 bytes on top, whether _this_ stmmac device is PCI or not.

A better solution needs to be found. Please consider what can be done
to make MSI (a) generic to stmmac so it can live in stmmac_libpci.c,
and (b) avoid adding overhead to platforms that don't use MSI.

As an example of an improvement, the int_name_*[] strings are only
used for MSI interrupts, and each one uses over 16 bytes. I calculate
the entire usage to be 665 bytes just for these strings which are
only ever used for MSI.

With the addition of the cpumasks, we're looking at getting on for
800 bytes of this structure which are only used for MSI.

We can surely do better than this.


So, how about moving the int_name_* to its own separate struct::

struct stmmac_msi {
	/*irq_name */
	char int_name_mac[IFNAMSIZ + 9];
	... other int_name_* ...
	cpumask_var_t rx_affinity[MTL_MAX_RX_QUEUES];
	cpumask_var_t tx_affinity[MTL_MAX_TX_QUEUES];
};

and replace the existing with int_name* with a simple:

	struct stmmac_msi *msi;

This struct would only be allocated when we need it for
stmmac_request_irq_multi_msi(), and can be requested using devm in
stmmac_dvr_probe() only when required.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

