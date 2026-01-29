Return-Path: <netdev+bounces-254654-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFEsLGYee2msBQIAu9opvQ
	(envelope-from <netdev+bounces-254654-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:46:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75133ADAF2
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E102630C887D
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 08:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E9B37E30D;
	Thu, 29 Jan 2026 08:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnV59r/5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A3537F733
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 08:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769675812; cv=none; b=Fldt0jaund6MdLQ7dMGMTxzE5Nx9uG0qAzxJNPjAKD1kxkR+gApX+iKN7VOYCislgDXjR47hMKBb8ZDJ7w4MfsjT4REY4kgf7vGX+18HPZVPGzPrxIcRvXjCILsjcrZE7a3HB4vZOgd8apSUZBejoSlEzLv1LgLXSKTRwJIOQ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769675812; c=relaxed/simple;
	bh=M/KOrSujhOHb14c/9iYAuK6EvuFfrnFrSN3nLo1iV6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oh5GetYQbPLtOye7H2eoYd3S6zr+O5//s7D6prpnVfN5sLh4kUcNf7z+r9oa909VujMzMxUedvr3XZj7vrMOyB5imaeqfg41uKecUVJiCvge865CF17yv5e7T0vnX3rRj0F/4Vm/G6ov/eLXplXSPaJew04zudBl0gGYi0z72h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnV59r/5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3AA8C4CEF7;
	Thu, 29 Jan 2026 08:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769675811;
	bh=M/KOrSujhOHb14c/9iYAuK6EvuFfrnFrSN3nLo1iV6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WnV59r/5rhPdgZ2C2HJ47vgFZ3OrxWWKQT7D24ueJWomRJo2EJwn32axFKTZew1aj
	 qsy3S+416xuCmckJklQQOT4Pj0XBN6R1qvLXmzR30nLDn7OMxkUmJ4enMBuM59UYmq
	 zkb5QZBf1D0diTg8vxgLdvGRQpHsXVDKkQ+w/PLbfQQLIkL/zrjo7U9dDi09P/Uzqz
	 sq2aXzK7KHILsTFPfY99Rc5zNsh41wTkR9F/qHZIP5gZMZYXj4DHL8xn64kLqAUJUT
	 iRevRH9yK/m8OfsmeIm8RcnR9WR3g5gqW0G3XVqaTDudIe9P3QACXuEE9Dq6NH4b7p
	 lqRwDHTaDFzeQ==
Date: Thu, 29 Jan 2026 09:36:46 +0100
From: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>, netdev@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net] net: sfp: Fix quirk for Ubiquiti U-Fiber Instant SFP
 module
Message-ID: <yybgfvhubsekdljwnukifyvesu37x7cog6mas3riy4yphm2i7s@7cegq3jyp25a>
References: <20260128175714.11411-1-kabel@kernel.org>
 <65ba2124-3940-4dd6-bbab-a31cdc67f573@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65ba2124-3940-4dd6-bbab-a31cdc67f573@bootlin.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,armlinux.org.uk,redhat.com,google.com,davemloft.net,gmail.com,lunn.ch];
	TAGGED_FROM(0.00)[bounces-254654-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kabel@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 75133ADAF2
X-Rspamd-Action: no action

So I sent v2 with change as you suggested but forgot to add your R-b tag /o\ :-D

