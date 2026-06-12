Return-Path: <netdev+bounces-298773-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pIjODKZTLGrDPQQAu9opvQ
	(envelope-from <netdev+bounces-298773-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 20:44:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7468367BD47
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 20:44:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fcbgSV7E;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298773-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298773-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 555A13061E97
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A915039A808;
	Fri, 12 Jun 2026 18:44:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A625F369D43;
	Fri, 12 Jun 2026 18:44:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781289882; cv=none; b=APi7dNdIfDSsJsy0eadLSc3lNuDlvwCG6F4l+wmH+6EAc2dCfDyV7+dDO3ddkMn8PluM92cvwhZ7c91xfhh5x65FqLIOvHWGr/iTA4uVJpD7ZeOoD9gDaugBaHYZsBPH0bSUcwkAEJuyfSAWSsFz/qE3jDnc54h40xSt00FWqbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781289882; c=relaxed/simple;
	bh=gbcrxcebQuYwGn5El2CK8rlhQCkHOYreWg3As3qRs8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQVaOfJpGYFY5oKiD3Ow/2kLy93OWqHDHOyhTFI2YiOf4fUUzxIonDLmD7DU13mXfl8aOU/RxnPmZve3Qhlq+yHP/TeQTydTg19CqdZS7imOe0oE2hUb4jkIjUuzQ2iY9J3OXq0yh+GDoCRP5iZ1YGO3pyZ1ElTmzbfCA6buBm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcbgSV7E; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1222E1F000E9;
	Fri, 12 Jun 2026 18:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781289881;
	bh=nPFDKBATesBs+aAe1hCTyHFXJpR0NIK6lduJaHerGB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fcbgSV7EAAHLUbDg+UUx6sQcUB1v7xY8l8Ldy42koUhpXiKhPM+op20IEeka6q7Ll
	 3GX+MWKjanadYrH9kfhEwjXh6yTh9nUThymWDpU32HyZqg5zsrg7wIzRcueaGhQ09D
	 8J+b1qKWjdFzIdqMJusWleXWZ9jjfwG/KXWHQoKt13DVIap73LNEdQeIOeZjik189V
	 WtZS2+KBj/D9mE0ulxPTIG28yWpm4NWwOPnMdxdBlCpFZc5QWlijKYt1m0rxOalq8h
	 191KEj+6IZdjt0XdRPqbOl9RgQbJwLdkbrlr8pwS8Iu5U9eTl9m6O+76EdPQ4KTbvS
	 Zi35d1NLcjOLA==
Date: Fri, 12 Jun 2026 19:44:36 +0100
From: Simon Horman <horms@kernel.org>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, danishanwar@ti.com,
	vadim.fedorenko@linux.dev, u.kleine-koenig@baylibre.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	yaojun@mucse.com
Subject: Re: [PATCH net-next v7 0/4] net: rnpgbe: Add TX/RX and link status
 support
Message-ID: <20260612184436.GL671640@horms.kernel.org>
References: <20260611100036.36370-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611100036.36370-1-dong100@mucse.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298773-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:dong100@mucse.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:danishanwar@ti.com,m:vadim.fedorenko@linux.dev,m:u.kleine-koenig@baylibre.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:yaojun@mucse.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,linux.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7468367BD47

On Thu, Jun 11, 2026 at 06:00:32PM +0800, Dong Yibo wrote:
> Hi maintainers,
> 
> This patch series adds the packet transmission, reception, and link status
> management features to the RNPGBE driver, building upon the previously
> introduced mailbox communication and basic driver infrastructure.
> 
> The series introduces:
> - Msix/msi interrupt handling with NAPI support
> - TX path with scatter-gather DMA and completion handling
> - RX path with page pool buffer management
> - Link status monitoring and carrier management
> 
> These changes enable the RNPGBE driver to support basic tx/rx
> network operations.
> 
> Changelog:
> v6 -> v7:
> [patch 2/4]:
> 1. Fix 'frag_idx' error in rnpgbe_tx_map. (Sashiko-gemini)
> [patch 3/4]:
> 1. Fix skb leak in invalid size path in rnpgbe_clean_rx_irq.
>    (Sashiko-gemini)
> 2. Fix invalid size range check for rxdesc. (Sashiko-gemini)
> [patch 4/4]:
> 1. Fix 'data race on the reply payload'. (Sashiko-gemini)
> 2. Fix 'asymmetric behaviour' when report up/down. (andrew)
> 
> links:
> ---
> v1: https://lore.kernel.org/netdev/20260325091204.94015-1-dong100@mucse.com/
> v2: https://lore.kernel.org/netdev/20260403025713.527841-1-dong100@mucse.com/
> v3: https://lore.kernel.org/netdev/20260507081539.171844-1-dong100@mucse.com/
> v4: https://lore.kernel.org/netdev/20260526033539.164061-1-dong100@mucse.com/
> v5: https://lore.kernel.org/netdev/20260528023150.239532-1-dong100@mucse.com/
> v6: https://lore.kernel.org/netdev/20260604112750.769215-1-dong100@mucse.com/
> 
> Additional Notes:

Thanks for the update and the notes.

There is another round of AI-generated review of this patch-set available
on both https://sashiko.dev and https://netdev-ai.bots.linux.dev/sashiko/

I would appreciate it if you could look over that too. With a view to
addressing any issues that directly affect this patch.

...

