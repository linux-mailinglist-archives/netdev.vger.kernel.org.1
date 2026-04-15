Return-Path: <netdev+bounces-278763-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCChFCaI32nSUgAAu9opvQ
	(envelope-from <netdev+bounces-278763-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 14:44:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB80E404611
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 14:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A7643014131
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 12:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDEE3191BA;
	Wed, 15 Apr 2026 12:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Cswnx1KX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25E4275B15
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776257055; cv=none; b=GBWB3L9RxWLLcbi/U4JKTxOXjMnH2M9UrJBSTpropBlpj+z8kgLjMyr+PCqHxj48wigWgNQZZ92utZsAW7tRqCls2fjFjbfnnglLk8F/UBiaU1CUsXx45DgdG359U86Orc4/uYkraKh9TsauOx8xcq8OqYv3GEBYELz9BJFfvvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776257055; c=relaxed/simple;
	bh=D+vBqJT638pklrZ1iWFcInZtjjm9ZwDhfHQibnTN4AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpkDep7ZH2RFBmaKhzDXTEi0hR5j4Jt4sYPCSAFiwZ5cI+3gELE4Rd/IMWuo+Tyoh/E2UfQJtA4D4ucVFIPyn4bglFqY+DgtjVNozaX1NWoTM/1nJT+qJDRXRSi/a2l+kQHMewOEt0MHaoswdlThiwUlImxNsSuWzHptI77oR9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Cswnx1KX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UyQKCDTxnGTJw71Mu2rprj6cyd6GgdGyAa8DuKAW8c4=; b=Cswnx1KXs9lvtqeyPXB2GfbbT+
	3gXcHhOdEPK2RGQNkTR97u+pDvuccO8W39CMIXcn83fgqWIwZsUcJCsev36tvt4tjFScphSivRC+n
	tigbE7SrhL54KMcqh2FLg6EFvK1oQo189TZ8zw66E3PrluqxvTdg1LEx1YIQXbwq2r/j6qw8gKdwT
	MwkfaRT3TjbM4SSls8cXz6s1GhSD3uxsCnv9v1YT0DC+fU9sYYPYAvRWHfmCKANjvdvpoyuWh9BLw
	5Zt6Pd8gpcqiQUTwdWp0vB2oxEqDEP9d2aDPH88PVMaM0PipMEspk0VWKEfeq1XW0vdkJoU05a9Pl
	Y/k36gEg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38004)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wCzb9-0000000025E-0kHQ;
	Wed, 15 Apr 2026 13:44:03 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wCzb5-000000002E2-1vhk;
	Wed, 15 Apr 2026 13:43:59 +0100
Date: Wed, 15 Apr 2026 13:43:59 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sam Edwards <cfsworks@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	linux-stm32@st-md-mailman.stormreply.com,
	Linux Network Development Mailing List <netdev@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: stmmac: enable RPS and RBU interrupts
Message-ID: <ad-ID2WaPgPJqdsa@shell.armlinux.org.uk>
References: <E1wBBaR-0000000GZHR-1dbM@rmk-PC.armlinux.org.uk>
 <20260413110222.49fc3759@kernel.org>
 <ad06yiZZbLC9k3jY@shell.armlinux.org.uk>
 <CAH5Ym4i7VV53hQGY3AjAUW3B8g_ffgmw69kPhPrk2CmcRbguuQ@mail.gmail.com>
 <ad5LlXzeQ8j14Mjg@shell.armlinux.org.uk>
 <ad7nsUQvksJF7JFK@shell.armlinux.org.uk>
 <CAH5Ym4jA8w9=UxMT4vKJpnXkuDHtkFtMcg4u2sy_0S+8wgy-9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5Ym4jA8w9=UxMT4vKJpnXkuDHtkFtMcg4u2sy_0S+8wgy-9w@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278763-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.630];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shell.armlinux.org.uk:mid,armlinux.org.uk:url,armlinux.org.uk:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB80E404611
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 07:12:34PM -0700, Sam Edwards wrote:
> On Tue, Apr 14, 2026 at 6:19 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> > Okay, just a quick note to say that nvidia's 5.10.216-tegra kernel
> > survives iperf3 -c -R to the imx6.
> 
> Hi Russell,
> 
> Aw, you beat me to it! I was about to report that 5.10.104-tegra is
> unaffected. And my iperf3 server is a multi-GbE amd64 machine.
> 
> > Dumping the registers and comparing, and then forcing the RQS and TQS
> > values to 0x23 (+1 = 36, *256 = 9216 bytes) and 0x8f (+1 = 144,
> > *256 = 36864 ytes) respectively seems to solve the problem. Under
> > net-next, these both end up being 0xff (+1 = 256, *256 = 65536 bytes.)
> > Suspiciously, 36 * 4 = 144, and I also see that this kernel programs
> > all four of the MTL receive operation mode registers, but only the
> > first MTL transmit operation mode register. However, DMA channels 1-3
> > aren't initialised.
> 
> Wow, great! I wonder if the problem is that the MTL FIFOs are smaller
> than that, so when the DMA suffers a momentary hiccup, the FIFOs are
> allowed to overflow, putting the hardware in a bad state.
> 
> Though I suspect this is only half of the problem: do you still see
> RBUs? Everything you've shared so far suggests the DMA failures are
> _not_ because the rx ring is drying up.

Yes. Note that RBUs will happen not because of DMA failures, but if
the kernel fails to keep up with the packet rate. RBU means "we read
the next descriptor, and it wasn't owned by hardware".

> > Looking back at 5.10, I don't see any code that would account for these
> > values being programmed for TQS and RQS, it looks like the calculations
> > are basically the same as we have today.
> 
> Note that Nvidia have their own "nvethernet" driver for their vendor
> kernel, which appears to pick the FIFO sizes from hardcoded tables in
> its eqos_configure_mtl_queue() [1] function.

That has:

	const nveu32_t rx_fifo_sz[2U][OSI_EQOS_MAX_NUM_QUEUES] = {
		{ FIFO_SZ(9U), FIFO_SZ(9U), FIFO_SZ(9U), FIFO_SZ(9U),
		  FIFO_SZ(1U), FIFO_SZ(1U), FIFO_SZ(1U), FIFO_SZ(1U) },
		{ FIFO_SZ(36U), FIFO_SZ(2U), FIFO_SZ(2U), FIFO_SZ(2U),
		  FIFO_SZ(2U), FIFO_SZ(2U), FIFO_SZ(2U), FIFO_SZ(16U) },
	};
	const nveu32_t tx_fifo_sz[2U][OSI_EQOS_MAX_NUM_QUEUES] = {
		{ FIFO_SZ(9U), FIFO_SZ(9U), FIFO_SZ(9U), FIFO_SZ(9U),
		  FIFO_SZ(1U), FIFO_SZ(1U), FIFO_SZ(1U), FIFO_SZ(1U) },
		{ FIFO_SZ(8U), FIFO_SZ(8U), FIFO_SZ(8U), FIFO_SZ(8U),
		  FIFO_SZ(8U), FIFO_SZ(8U), FIFO_SZ(8U), FIFO_SZ(8U) },
	};

where each of those values is the RQS/TQS value to use in KiB:

#define FIFO_SZ(x)		((((x) * 1024U) / 256U) - 1U)

This doesn't correspond with the values I'm seeing programmed into
the hardware under the 5.10.216-tegra kernel. I'm seeing TQS = 143
(36KiB), and RQS = 35 (9KiB). Yes, these values exist in the tables
above from a quick look, but they're not in the right place!

For example, tx_fifo_sz[] doesn't contain an entry for 36KiB.
rx_fifo_sz[0][0..3] looks plausible.

It's certainly not a case of misreading the register values, this is
what devmem2 said:

Value at address 0x02490d00: 0x008f000a
Value at address 0x02490d30: 0x02379eb0

where TQS is bits 24:16 of the register at offset 0xd00 - which is
0x8f, and RQS is bits 29:20 of the register at 0xd30, which is
0x23.

Now, as for FIFO sizes, if we sum up all the entries, then we
get:

SUM(rx_fifo_size[0][]) = 60KiB
SUM(rx_fifo_size[1][]) = 64KiB
SUM(tx_fifo_size[0][]) = 60KiB
SUM(tx_fifo_size[1][]) = 64KiB

From what I gather in core_local.h, l_mac_ver contains one of three
values - 0 = Legacy EQOS, 1 = Orin EQOS, 2 = Orin MGBE, and which
set of values is selected by bit 0 of that. Decoding this further,
Legacy EQOS is IP version v5.0, Orin EQOS is v5.3, and Orin MGBE
is v3.1 and v4.0.

So, I wonder whether there's something in "Legacy EQOS" that consumes
4KiB of FIFO that isn't documented in iMX8M (IP v5.1).

Is anyone aware of public SoC documentation that covers the v5.0 IP
version?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

