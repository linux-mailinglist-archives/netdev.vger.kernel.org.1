Return-Path: <netdev+bounces-262392-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PZWnCwovpGk6aAUAu9opvQ
	(envelope-from <netdev+bounces-262392-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 13:20:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 625D61CF908
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 13:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B21C300F149
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 12:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAA5175A83;
	Sun,  1 Mar 2026 12:20:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82387E54B
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 12:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772367622; cv=none; b=iJDSvBKnOXR/d5LiM1hLYJhuU/GK2/bXsG6ln/1j7/k5vq81SA2KXbRWvrJBI96lJwfZadExCa4SkRUAbcSaKzMBpVEEGC5YeY85jP/nnesFk+ex1B+fwF1H+31RsNDU0uWHkpRqi7GJ/l2R5uLNzWhaFDBeblAGOqcubtKtaIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772367622; c=relaxed/simple;
	bh=OZ3Xhz2M9cgusIxXFISulXJZ+bLz5loyYHcjKn6ujeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwrI1jsRmQEfJ4Dyh/kOYfUYIWkkkh/9bdVvE+cb9Q6BQtjyiC6vOOHi2uuxANGpV+2F38WrdnJC/B4GRFGqFlYVE+NAc8FYLQ4xYupSRBqvxOIl60PDHPASMex6UMKjJGxe2S1dtgVlr7nsRleFZXDPCnFVVPBpRqQvzHPIjmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vwfTr-000000000Rd-1C0p;
	Sun, 01 Mar 2026 12:01:03 +0000
Date: Sun, 1 Mar 2026 12:00:55 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Joris Vaisvila <joey@tinyisr.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [RFC 0/2 net-next] net: dsa: MT7628 embedded switch initial
 support
Message-ID: <aaQqdwNsuwzRb7Xu@makrotopia.org>
References: <20260228185242.800836-1-joey@tinyisr.com>
 <20260228234031.bimzpo4mmu6t5rty@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228234031.bimzpo4mmu6t5rty@skbuf>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262392-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[makrotopia.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.979];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 625D61CF908
X-Rspamd-Action: no action

On Sun, Mar 01, 2026 at 01:40:31AM +0200, Vladimir Oltean wrote:
> [...]
> I looked at arch/mips/boot/dts/ralink/mt7628a.dtsi and found nothing
> Ethernet-related. So it's a bit hard to comment from me whether this is
> an instance of mtk_eth_soc.c or something, that is being used as a DSA
> conduit. Case in which your architectural choice is fine.

Yes, the SoC Ethernet is supported by mtk_eth_soc.c, the reason why it
is still missing in mt7628a.dtsi is preceisely because there is no way to
actually use without a DSA/switch driver.

