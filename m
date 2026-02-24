Return-Path: <netdev+bounces-260444-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qM59OId7nWmAQAQAu9opvQ
	(envelope-from <netdev+bounces-260444-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:20:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3B81853F0
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65066300C938
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3F737755D;
	Tue, 24 Feb 2026 10:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="b48dGVhM"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D72D37757D
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 10:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771928243; cv=none; b=NHajrpbmGC+7Wb2Qon5tA+ijMIYSx8Ud1V4VSOmiq9EAR44OEnVVPVrVOMN6V9UP5TJ3j9ztI3s2GUn84nODN1LzQafA3XXfIboh6Lnvcx+c8OC5Jnx8DR4P1MLY5tIhiBraAcD+xbeTOg1DRStulX2+cDPpeXh9A5ueDsXPwdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771928243; c=relaxed/simple;
	bh=rFF4K8Zgf1BYVWvYDIyd09wkETxX/B9s2eyJGQxFkWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6BhcBtzGK5DnMG+4QT2d3CcdrmsfODyMsTjwKuqyo37bd9U0rWHy6XlI5tJ3/9S6iuyxRSWh/bZps/WMT/1RISC6BE8FdgQEPyRBBPfhpS3XH7pR4TmcIM8T3GyogZy+ANXyYed5g5bkMEWyhuQ1LSR+UMY2SRsI/r+arJ5+v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=b48dGVhM; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4YULu+uW6OF//44jjpCFpruF8dDEiT3NVbgUKXDQoeo=; b=b48dGVhMPjMoM08ZEEUU/QM7fE
	C8DARAtpoZNoXE/PzyN0mcJUmKJipxT2Gmo6ObVnTUmby8DwSObRPAZVcFN4w/9bAWjKeTmnwA5st
	AUc7/QUNaf9FUtVYlvkcSr5mJbtR6pLRRZ2UadZWkn+qhy7ymyEaZzMHK+KDqBHdRiC97YAn5KcWW
	YOdQ5IU13i85wdF07/d6skemAdQbJwzJuqoyEB8lmqKq8ZJx9NZAO2snSHrh3dDA3xmZt2+QUio0N
	4dedSkl20KMRCguCC287I2r21si+Z3sppmdq4vvUHTFtXc0Bmtczn5o8BEuGOYMynEm12xW5I81mm
	qd+GeF9Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55642)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vupTh-0000000055S-0ACt;
	Tue, 24 Feb 2026 10:17:17 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vupTe-000000008I5-3sCB;
	Tue, 24 Feb 2026 10:17:14 +0000
Date: Tue, 24 Feb 2026 10:17:14 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, claudiu.beznea@tuxon.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	nicolas.ferre@microchip.com, pabeni@redhat.com,
	phil@raspberrypi.com
Subject: Re: [PATCH net-next v2 3/5] net: cadence: macb: implement EEE TX LPI
 support
Message-ID: <aZ16qgIsRxkUuoW1@shell.armlinux.org.uk>
References: <20260224091821.47671-1-nb@tipi-net.de>
 <20260224091821.47671-4-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224091821.47671-4-nb@tipi-net.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-260444-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.932];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,shell.armlinux.org.uk:mid,armlinux.org.uk:url]
X-Rspamd-Queue-Id: 3B3B81853F0
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 10:18:19AM +0100, Nicolai Buchwitz wrote:
> Implement Energy Efficient Ethernet TX Low Power Idle using phylink's
> managed EEE framework. The Cadence GEM MAC has no built-in idle timer
> - TXLPIEN (NCR bit 19) immediately blocks all TX when set and the MAC
> does NOT auto-wake - so the driver uses a software delayed_work timer
> for idle detection.
> 
> The TX LPI lifecycle:
>   - phylink calls mac_enable_tx_lpi() after link-up with the negotiated
>     timer value. The driver defers the first LPI entry by 1 second per
>     IEEE 802.3az section 22.7a.
>   - macb_tx_complete() reschedules the idle timer after each TX drain.
>   - macb_start_xmit() wakes from LPI by clearing TXLPIEN, cancelling
>     the pending work, and waiting 50us (conservative Tw_sys) before
>     initiating the transmit.
>   - phylink calls mac_disable_tx_lpi() before link-down, which cancels
>     the work and clears TXLPIEN.
> 
> The phylink_config is populated with LPI capabilities (MII, GMII, RGMII
> modes; 100FD and 1000FD speeds) and a 250ms default idle timer, gated
> on MACB_CAPS_EEE.

Much better, thanks. One suggestion:

> +static void macb_tx_lpi_set(struct macb *bp, bool enable)

bool return type.

> +{
> +	unsigned long flags;
> +	u32 ncr;

	u32 old, ncr;

> +
> +	spin_lock_irqsave(&bp->lock, flags);
> +	ncr = macb_readl(bp, NCR);

	old = ncr;

> +	if (enable)
> +		ncr |= GEM_BIT(TXLPIEN);
> +	else
> +		ncr &= ~GEM_BIT(TXLPIEN);

	if (old != ncr)
> +	macb_writel(bp, NCR, ncr);
> +	bp->tx_lpi_enabled = enable;

No need for tx_lpi_enabled

> +	spin_unlock_irqrestore(&bp->lock, flags);

	return old != ncr;

> +}

...

> +/* Wake from LPI before transmitting. The MAC must deassert TXLPIEN
> + * and wait for the PHY to exit LPI before any frame can be sent.
> + * IEEE 802.3az Tw_sys is ~17us for 1000BASE-T, ~30us for 100BASE-TX;
> + * we use a conservative 50us.
> + */
> +static void macb_tx_lpi_wake(struct macb *bp)
> +{
> +	if (!bp->tx_lpi_enabled)
> +		return;

No need for this if().

> +
> +	macb_tx_lpi_set(bp, false);

instead:
	if (!macb_tx_lpi_set(bp, false))
		return;

The presence of the spinlock in macb_tx_lpi_set() suggests that there
could be races, so keeping the state completely inside the spinlock
region would be sensible.

> +	cancel_delayed_work(&bp->tx_lpi_work);

I wonder whether this is reliable on its own. cancel_delayed_work()
documentation says:

 * Note:
 * The work callback function may still be running on return, unless
 * it returns %true and the work doesn't re-arm itself.  Explicitly flush or
 * use cancel_delayed_work_sync() to wait on it.

That means macb_tx_lpi_work_fn() could have just been entered at the
point that cancel_delayed_work() has been called. Would that cause a
problem, e.g. setting LPI mode again, or would we be guaranteed that
macb_tx_all_queues_idle() returns false preventing LPI mode being set
again?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

