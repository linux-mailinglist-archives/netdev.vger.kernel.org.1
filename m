Return-Path: <netdev+bounces-292239-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGTQMkLFFmrOqgcAu9opvQ
	(envelope-from <netdev+bounces-292239-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:19:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F97E5E2868
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 145B831B5E07
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1883D301D;
	Wed, 27 May 2026 10:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="lekIn0Yl"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B2F3F0774;
	Wed, 27 May 2026 10:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779876712; cv=none; b=JPa2Ut4x+mUuQW3DDvCBUqNxkRtTtkczRGRP3JTmxIriswYqHTACH2AgHPp/g2eqfu3ftXwhqJKt5F3Gk10Dm19gQHUFM0rEJ+pClKjb2k+l0Z5hsfOm9Z5uEssoeqn8zeBrL9LSCu+HQVzWBnMf9x5h6Po8o91VN8OZEjpT84s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779876712; c=relaxed/simple;
	bh=5YW3mHidosqgLXLhug9PVGW8oxDHErnlce3UJUh8WGI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=q6WNWqcEepqC7dgR1n6DV8Fs919bKrAvVjdhxmDQcaE18BLxkI84tFIivviaXdxyLQ6SNtVd0LogZ79xNVq96NQgua9nTb+M0mLenchfj+Y0/3rj8x4bO2M4e4OyfuNplcxuvEUkqd3bKsLiiZ3Fdxk7ORSD5XtqguhX/snfSUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=lekIn0Yl; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 239ECA4B83;
	Wed, 27 May 2026 12:11:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1779876700; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Mr7FHSDOpOGYNjR+cO/Osg7hZAXJhvQ0HNcqTxYsjmk=;
	b=lekIn0YlJINjuRSmdX/BgXoFYblubBp0ckHuerBabiPpXgaGER06+aR56UJw+CeSnvcJqR
	mvUy5mZdEnNZ2hGsZqMGEIND+/iFWNzWum7TUy4N0Jvo9rJpIPbnDC0VDY9YXjbDduhfcd
	5k3i9LtXjaPwpECsfGM2nsu+xd49o1wvJPuizZRWP49WCVBkjnuv49MGlmrEkKVW16zWRb
	K9eWHByXz4gUgkmk60JLyVQGGk7YT/Mc6QbofkFctDRbnLDnj5rDsvXEPFed3P5at3IvXK
	IrIku+2AHMOEL9AdUbxzKRzU5gwVnuvAkfRO0TH4deyhzlNI5NG4h611QL0Ikg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 27 May 2026 12:11:36 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Thangaraj Samynathan <thangaraj.s@microchip.com>,
 netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: lan743x: add support for RMII
 interface
In-Reply-To: <b24c34f91726681ef5797af10b3d1e9a@tipi-net.de>
References: <20260526154054.19829-1-thangaraj.s@microchip.com>
 <20260526154054.19829-3-thangaraj.s@microchip.com>
 <48510d22-bc14-427a-b12e-17655ca95ad5@lunn.ch>
 <b24c34f91726681ef5797af10b3d1e9a@tipi-net.de>
Message-ID: <10b311c5feef2ab18f1e94a6c935a79b@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292239-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5F97E5E2868
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Andrew

On 26.5.2026 21:59, Nicolai Buchwitz wrote:
> [...]
>> 
>> Humm, is this an 802.3 limitation, or a limitation of this hardware?
> 
> I do not think this is specific to the lan743x. Linux drives EEE from
> the MAC side, so mac_enable_tx_lpi() has to signal "assert LPI" to the
> PHY across the xMII. On MII and GMII the MAC signals LPI using TX_ER,
> and AFAICT RMII has a reduced pin set with no TX_ER, so the MAC has no
> standard way to request LPI over RMII. So IMHO EEE does not really
> apply to RMII in general, not only on this controller. Please correct
> me if I am missing something here.

> [...]

>> If this is 802.3, then this should be in phylink, not drivers.
> 
> Since this seems generic, I agree it belongs in phylink rather than
> each driver. I can send a patch excluding RMII (and probably REVRMII)
> from EEE centrally, so drivers do not need to special-case it.

I looked into this some more and I don't think it belongs in phylink
after all.

The "no TX_ER, no in-band LPI" bit is generic and holds for any
MAC-driven EEE over RMII (IEEE 802.3 22.2.2 / Table 22-1: LPI is
asserted via TX_ER, which RMII doesn't have). But EEE still works over
RMII when the PHY or switch does LPI autonomously (PHY-managed EEE...
yikes), since that needs no in-band signaling.

ksz_common is exactly that: it puts RMII in lpi_interfaces on purpose
and uses a dummy mac_enable_tx_lpi() (the comment there explains the HW
handles LPI itself once EEE is negotiated):

	 /* ksz_phylink_mac_enable_tx_lpi() - Callback to signal LPI support 
(Dummy)
	 * [...]
	 * the actual EEE / Low Power Idle (LPI) state transitions are managed
	 * autonomously by the hardware based on the auto-negotiation results.
	 * [...]
	 * Therefore, this callback performs no action and serves primarily to
	 * inform phylink of LPI awareness [...]
	 */
	int ksz_phylink_mac_enable_tx_lpi(struct phylink_config *config,
					  u32 timer, bool tx_clock_stop)
	{
		return 0;
	}

So clearing RMII in phylink would break EEE there.

lpi_interfaces is opt-in already, RMII is only affected when a driver
memcpy()s supported_interfaces into it. So it seems that this is really
per-driver, and keeping the exclusion in lan743x looks right to me.
Unless we want to continue handling EEE differently depending on if MAC
or PHY-managed EEE ...

> [...]

Nicolai

