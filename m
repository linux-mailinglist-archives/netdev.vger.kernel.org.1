Return-Path: <netdev+bounces-296304-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8EsqD2+9JWq9LAIAu9opvQ
	(envelope-from <netdev+bounces-296304-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 20:50:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF36651502
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 20:50:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=0CnGAI4M;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296304-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296304-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BDC0300A744
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 18:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924032E6CC7;
	Sun,  7 Jun 2026 18:48:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B7E2BE02A
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 18:48:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780858130; cv=none; b=ZG38OvrEsb1SYqdHkk6jIEYlmQUxId9ZJdU8WG/F7jIY9CVL+5s7iakdDAw3Jj9lHUhzwVp0WJ3gfyOMJmamA9ZzgC17zwx++n20jGUJuFfw87QIC1uw4lei4LcSiTfI6yHv0EnJ8/u35exAkFdY37F/dZbzP0hitfSM3cN07kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780858130; c=relaxed/simple;
	bh=ZHzWBTgu2DQQzr0lhj7HG8pN3/vXTbAOZT5B30ftn0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxaEspGLogpZPdrG8VIQWvwlJO/CI8N6nl9d455bQR1+xAlL4eJ19NP0MMnQ8Je6FhLH4NPW5TQTpXMu6jn4qTRVe+TKmlI4jLUMioNqioiW1vx25cgc4ARDNaIBJ8nf25IjumkBPMFMXNa4BiSTyz45LY7ioYDvtZpK2FM4QGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0CnGAI4M; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EKo7HGAbgsIDL31kPHzl3tZYuwTp1av9mowY1XXGB9k=; b=0CnGAI4MBR4qwHMnl6f2tC5l0x
	hczLYBiRcqVZ82WBlypFVktHKhKO8lZAwNrnpFaAvK8zKDm3yqpBrED+lvyyFDEW3KKSsnYlY+Q06
	rjO8v+kQ4dt0RVX6jV5JlL1tvnemkQTxZTIK16BN1hhdNszNJOOd8pNDSg35p1vUTnlk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wWIY3-006UzT-3N; Sun, 07 Jun 2026 20:48:39 +0200
Date: Sun, 7 Jun 2026 20:48:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Madhur Agrawal <madhur.agrawal@airoha.com>
Subject: Re: [PATCH net-next v2] net: airoha: add ethtool priv_flags support
 for LAN/WAN and GDM2 loopback
Message-ID: <e8f3d24a-985b-4bde-9f51-2d5ae3d25b01@lunn.ch>
References: <20260607-airoha-ethtool-priv_flags-v2-1-742c7aa1e182@kernel.org>
 <33c3a87d-ad97-4f6a-8f76-ebab80c496ac@lunn.ch>
 <aiWzaV1f1Fpc2rhJ@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiWzaV1f1Fpc2rhJ@lore-desk>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296304-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:madhur.agrawal@airoha.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:from_mime,lunn.ch:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5EF36651502

On Sun, Jun 07, 2026 at 08:07:37PM +0200, Lorenzo Bianconi wrote:
> > > When a GDM3/GDM4 port is set to WAN mode, enable GDM2 loopback to
> > > support hardware QoS. Conversely, when switching back to LAN mode,
> > > disable the GDM2 loopback and restore the default forwarding
> > > configuration.
> > 
> > Why not just use the presence of an off loadable qdisc as the
> > indicator to change mode?
> 
> Hi Andrew,
> 
> Interesting, can you please provide more details about you mean?

You say you need it to be in loopback mode in order to support
hardware QoS. You configure QoS by using a qdisc, and something like
mqprio, tcf etc. So when the user configures QoS, you can see if the
hardware supports the request QoS. If so, swap to loopback mode and
offload the QoS function to the hardware. If the hardware does not
support the requested QoS, leave it in software and keep with LAN
mode.

	Andrew

