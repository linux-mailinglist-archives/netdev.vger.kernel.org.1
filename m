Return-Path: <netdev+bounces-272843-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCblMP9tyGnolwUAu9opvQ
	(envelope-from <netdev+bounces-272843-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 01:10:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5F035043A
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 01:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1F203013D69
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 00:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08B340DFD4;
	Sun, 29 Mar 2026 00:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ahnmyFwF"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DCD40DFC6
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 00:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774743035; cv=none; b=UJfRTVm2iybzw5YZpEF+Pz09gF92sSjQovXJPtBY8ErpfnZNgaYBHyJeYIkZG5H0U+0MS7z7rvToN/Vp3wz7JFc4zAH7/uWR1WrDIXkvYQx+9Kzx2FYzfSv8DZV4FkWDMUvOSAuLIyU7wV86p34KEnumrkwZBQL1mNwNH3Vx7+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774743035; c=relaxed/simple;
	bh=wmH7k+fcbsyyzwUcG4zRrT+TOlWh2rlVpVe1Ypy3x3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZbsyb+GZbwCdhKLzlnYUAenmjGjOMFsri5hsStCFfGrBJQxWO7b0bHCaa72xD/l4UeyrmIEqzN7KGkG2Q/CP+oKFXUklb/xMk+w1Wvg5jzLvtpXgCIWn6b52kA1OjsZbTY8esn/R2hPgAyii6d1/MjklXQqvMzmY+K650h6iuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ahnmyFwF; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=k1x7gH1eTuySIxAjJtVXx70vFzTUtBL9VqU5Cc+Qdgk=; b=ahnmyFwF1QL366ZcprC61eQJyg
	G1UgkJQqLB7dkm9aPLyzxuqR9EPgWfgvH95nfE3+iMnt1YVqf0TIsY403UOvbjXc8HXrks13us6C5
	33TPAzBn/lOaJHYJuJD/yoXvUqJwxBZueDLEtcBzoRQTX9MR735dIXF69OPIZoSRFtkn/fL27AY/s
	AuWMr2rwju1O08KKs6jK6f6FzM16Frky+JLims+uknyez9OB5gJzSuQIFScm3kxptfzHrHoGbo/C6
	2TSAIJaxVrKD6C5iqFk5YutkWnhEAjopQggF0El4ogOkcAmMW6nj/VqVcFjEaeXvzW8f9FbKoCgAM
	WFtdTKqQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53134)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w6djU-000000007Yi-3RjU;
	Sun, 29 Mar 2026 00:10:24 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w6djR-0000000018F-0z79;
	Sun, 29 Mar 2026 00:10:21 +0000
Date: Sun, 29 Mar 2026 00:10:21 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Ong Boon Leong <boon.leong.ong@intel.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 00/10] net: stmmac: TSO fixes/cleanups
Message-ID: <acht7WzzX2BlITQy@shell.armlinux.org.uk>
References: <achJ1dfeT6Q8rBuX@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <achJ1dfeT6Q8rBuX@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272843-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.708];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E5F035043A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 28, 2026 at 09:36:21PM +0000, Russell King (Oracle) wrote:
> Hot off the press from reading various sources of dwmac information,
> this series attempts to fix the buggy hacks that were previously
> merged, and clean up the code handling this.
> 
> I'm not sure whether "TSO" or "GSO" should be used to describe this
> feature - although it primarily handles TCP, dwmac4 appears to also
> be able to handle UDP.
> 
> In essence, this series adds a .ndo_features_check() method to handle
> whether TSO/GSO can be used for a particular skbuff - checking which
> queue the skbuff is destined for and whether that has TBS available
> which precludes TSO being enabled on that channel.
> 
> I'm also adding a check that the header is smaller than 1024 bytes,
> as documented in those sources which have TSO support - this is due
> to the hardware buffering the header in "TSO memory" which I guess
> is limited to 1KiB. I expect this test never to trigger, but if
> the headers ever exceed that size, the hardware will likely fail.
> 
> I'm also moving the VLAN insertion for TSO packets into core code -
> with the addition of .do_Features_check(), this can be done and
> unnecessary code removed from the stmmac driver.
> 
> I've changed the hardware initialisation to always enable TSO support
> on the channels even if the user requests TSO/GSO to be disabled -
> this fixes another issue as pointed out by Jakub in a previous review
> of the two patches (now patches 5 and 6.)
> 
> I'm moving the setup of the GSO features, cleaning those up, and
> adding a warning if platform glue requests this to be enabled but the
> hardware has no support. Hopefully this will never trigger if everyone
> got the STMMAC_FLAG_TSO_EN flag correct.
> 
> Also move the "TSO supported" message to the new
> stmmac_set_gso_features() function so keep all this TSO stuff together.

There are a few more issues that I would like to fix in this driver
in respect of the TSO support.

STM32MP151 and STM32MP25xx both state that when the TSE bit is set
in the channel Tx control register, TxPBL must be >= 4. We don't
check that is the case. Sadly, the documentation doesn't say whether
it's the TxPBL field value or the burst limit itself (there's the PBLx8
bit which multiplies the values in the field by 8.) Given the unknowns
here, I don't have a solution for this yet.

The other restriction is that the MSS[13:0] value must be greater than
the dwmac core's configured data width in bytes, with a recommendation
that it is 64 bytes or more. MSS[13:0] comes from
skb_shinfo(skb)->gso_size. However, the header plus the MSS size must
not exceed 16383 bytes. I think this can be catered for by adding
another test in the new stmmac_features_check() function:

	if (skb_is_gso(skb)) {
		headlen = skb_headlen(skb);
		gso_size = skb_shinfo(skb)->gso_size;
...
		if (headlen > 1023 || gso_size < 64 ||
		    gso_size + headlen > 16383)
			features &= ~NETIF_F_GSO_MASK;

What I haven't worked out yet is whether any of these conditions
just "can't happen" with our networking layers - I suspect the
gso_size < 64 would be one such case.

Next, the hardware has a maximum size for segmentation, which is 256KiB.
I think that needs netif_set_tso_max_size(dev, 256KiB). We're currently
safe, because the default is 64KiB, and I'd worry about whether we'd
overflow the space in the TX descriptor ring.

If anyone has any comments on the above, that would be good. Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

