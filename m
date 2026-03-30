Return-Path: <netdev+bounces-273353-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJjUBhf9ymk2CgYAu9opvQ
	(envelope-from <netdev+bounces-273353-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:45:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7970F362149
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FA9C30C438D
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 22:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813C7391E6A;
	Mon, 30 Mar 2026 22:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCAwNi/V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50FD3EBF1C
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 22:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774910367; cv=none; b=MictS1lUgM8svsDwEOFZ7lnjLi5W8+dTn0043Ho2UfdpDPj9z/CEIWUymQT2QixhVnOdHVjlMw7Syxob2FxZunXkAATr+2NGpnS+VbbHsittOyGWjjVYvlwYAP1kMb/P6NE1rl2j1+d3Mhxtot/PkL2dbUB2s03h95qThy0q+Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774910367; c=relaxed/simple;
	bh=EeQGIlzSq9W72qEaKjyWBZjyph2cMjhBKvlKlY5FRtM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jvunIKKo3U5wpAE1ZEJaJClDxP/SrLImxw08OH5bXR8X4kuvdVxHqhYreP173BvMxR08Xu6j1b1MVgSroEs75Yx4mnAgFw+fMhkRKLTnKSmsnJIXubScXeyngmJrkFG+PEIfB3Hm3hxeMinPokzB5iMexEM5MBo9vZW1h859Gu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCAwNi/V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E3BC2BCB0;
	Mon, 30 Mar 2026 22:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774910366;
	bh=EeQGIlzSq9W72qEaKjyWBZjyph2cMjhBKvlKlY5FRtM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DCAwNi/Vs89u5yK+FApbEW700neUEeO3SKe8D9sNXQBnsXejrYwhy3ZwND3W51Dki
	 Sotbfv360ej0aANr0m4QQndjCDrVt4rONA44nbzj+AvlJexXJf9h3RWzP2PCU34cn8
	 3QpdlPYvMVPzRhxsYt0iF3v1i/PSiG3OWt7TX+ird/eivz045lPkQwV26H/o53xu1Z
	 UeimYlf9fpwXs8tf8MRl04yWkpLEcEYFiYQcWOYOMh6L+Rzi9kg+gaa+TaVffVeJov
	 K9ijDqPmYdd7QfsWr7XVfTLIS+i0kPRGSHATpQzlO+miLEovdMO0X5VdCsFZwRV52M
	 UhxieYtBviGyQ==
Date: Mon, 30 Mar 2026 15:39:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Wagner <wagner.daniel.t@gmail.com>
Cc: netdev@vger.kernel.org, Florian Fainelli
 <florian.fainelli@broadcom.com>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 bcm-kernel-feedback-list@broadcom.com, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] net: phy: bcm84881: add BCM84891/BCM84892
 support
Message-ID: <20260330153920.04e62663@kernel.org>
In-Reply-To: <CAMsLQxGcnD1Q8REcgKWJQR-cgS2Z1KaTJgs9r989p2pxz6vV4Q@mail.gmail.com>
References: <20260324152503.1522071-2-wagner.daniel.t@gmail.com>
	<20260324190601.1616343-1-wagner.daniel.t@gmail.com>
	<CAMsLQxGcnD1Q8REcgKWJQR-cgS2Z1KaTJgs9r989p2pxz6vV4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,broadcom.com,lunn.ch,gmail.com,armlinux.org.uk,google.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-273353-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7970F362149
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 29 Mar 2026 17:47:47 +0100 Daniel Wagner wrote:
> I see v2 is marked as "changes requested" on patchwork; I believe it
> addresses the original points, but happy to make further changes if I
> missed something. LEDs will follow in a separate patch.

Repost it, say in the change log that it's identical to v2.
You posted this while the discussion was still ongoing which 
is an automatic expulsion from patchwork.

