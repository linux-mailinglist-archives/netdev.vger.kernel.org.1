Return-Path: <netdev+bounces-292271-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOr9BlLjFmpIvAcAu9opvQ
	(envelope-from <netdev+bounces-292271-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 14:28:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E345E42B3
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 14:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E4E4304D45B
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629763D4128;
	Wed, 27 May 2026 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2B16mUKX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3CF3D16E2;
	Wed, 27 May 2026 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779884446; cv=none; b=f9RucAC0ah1kEORjirgxlpo309z4j9bVtAqHZP9/+tFAWu4v+o3Ps/SCmXWYZ0SI3Vsm+/7RQ/GH5IErp3YkBGNkRuU4hghw6S+qCzdpMWjRZM2ONp8pEXmqku01IWGgPbPyWKaAiWAgkAx+jGmKhv5iLtjR9Q6a0Z7Dab3zET0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779884446; c=relaxed/simple;
	bh=KEMf/skJbgjZSAPYlFo//0HTlRxvafypzAX5PwhHbYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3AdfnCPGVZgnISb1BqJY/k6V0ZNSycdcp6nQ3F6HFWu7v38ihxzZ/+ynCjpN09uO1aAjLRKUs+A6kzVOocwwc5B0eUw3V2hk2y+Zhb37do8pHH48mTvnHEPzcCra9BA/aIk+4w73voqhhrMpLhWGhkXOT9w9UvLGgB0ycum30k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2B16mUKX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5GlZSD1cForPgSCYWtl2Hw9qmlkpQrrPlhaZ5lanNWg=; b=2B16mUKX5PGCE4inRuFl//crpZ
	1r6oyME6aJ2Emp0xuks5+HZWlHu2tOMz4q7fYZnOt5VOdrAMIDbrAB5jY7KniL1VpDXXAp4oYbbPE
	FMkccRu+mPrZ0iLRb3zKqpBkA7FEXUrN+Lv+AMDLT40M0k+r9xlbh9+XltKt2l4bMnvI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSDFU-004kCH-1g; Wed, 27 May 2026 14:20:36 +0200
Date: Wed, 27 May 2026 14:20:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Thangaraj Samynathan <thangaraj.s@microchip.com>,
	netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: lan743x: add support for RMII
 interface
Message-ID: <e66d0929-6fa1-415c-80fe-d2635bf74e19@lunn.ch>
References: <20260526154054.19829-1-thangaraj.s@microchip.com>
 <20260526154054.19829-3-thangaraj.s@microchip.com>
 <48510d22-bc14-427a-b12e-17655ca95ad5@lunn.ch>
 <b24c34f91726681ef5797af10b3d1e9a@tipi-net.de>
 <10b311c5feef2ab18f1e94a6c935a79b@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10b311c5feef2ab18f1e94a6c935a79b@tipi-net.de>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292271-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 83E345E42B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> I looked into this some more and I don't think it belongs in phylink
> after all.
> 
> The "no TX_ER, no in-band LPI" bit is generic and holds for any
> MAC-driven EEE over RMII (IEEE 802.3 22.2.2 / Table 22-1: LPI is
> asserted via TX_ER, which RMII doesn't have). But EEE still works over
> RMII when the PHY or switch does LPI autonomously (PHY-managed EEE...
> yikes), since that needs no in-band signaling.

But that is a different thing. The API here is the MAC enumerating to
phylink what it is capable of. We don't have PHY-managed EEE yet in
phylink, but the basic idea would be the PHY would also enumerate its
capabilities, and then phylink would pick which to us.

> ksz_common is exactly that: it puts RMII in lpi_interfaces on purpose
> and uses a dummy mac_enable_tx_lpi() (the comment there explains the HW
> handles LPI itself once EEE is negotiated):
> 
> 	 /* ksz_phylink_mac_enable_tx_lpi() - Callback to signal LPI support
> (Dummy)
> 	 * [...]
> 	 * the actual EEE / Low Power Idle (LPI) state transitions are managed
> 	 * autonomously by the hardware based on the auto-negotiation results.
> 	 * [...]
> 	 * Therefore, this callback performs no action and serves primarily to
> 	 * inform phylink of LPI awareness [...]
> 	 */
> 	int ksz_phylink_mac_enable_tx_lpi(struct phylink_config *config,
> 					  u32 timer, bool tx_clock_stop)
> 	{
> 		return 0;
> 	}

and this is a 3rd variant, were you have an MAC/PHY pair which is
tightly integrated. I doubt that RMII is actually being used, and the
phy_interface_t should actually by "internal".

> So clearing RMII in phylink would break EEE there.

Agreed. So maybe it is too late to do this in the core, at least not
without having to change some drivers.

	Andrew

