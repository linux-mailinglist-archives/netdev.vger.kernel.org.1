Return-Path: <netdev+bounces-275124-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPnXIC3lz2kS1gYAu9opvQ
	(envelope-from <netdev+bounces-275124-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 18:05:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF02396106
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 18:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A118D3008D0B
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 16:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A743C7DF1;
	Fri,  3 Apr 2026 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+T2BHhW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38213C3C14;
	Fri,  3 Apr 2026 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775232173; cv=none; b=Hv1ga3Zx48zDyAJF+KL62/9J1zjZpUDkN+Pq1xErRVnyg++hYirYpIHJBf/3mSQTo26KMMUkZEMlsTMMAuiqxE4hKnMaYBbGwL+tVrsdutUrL/cUatx6Jq67cCOggK81tBU6N4hYOF/wsUqPLTUINni8KYZEOkroE6ZUDXnX980=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775232173; c=relaxed/simple;
	bh=BNPbGQtpMtb7EJLXPZZidRn5FnuViXRDcfBMEOcMpoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9WL63W7x+xbJ6wQzy2KlPkwloWXpI/OVqE9D02oC3fuBB2hU/eBXPRvYyLr5h0VicKwFj4/eYsgIX7tko1KdFYB/Nqk3Mv+6c28PdWgr1w5wRh97SY0AjOU23CiD66HF7hf8VJ6Nla/1cvCcy0WGGjnpOtVELzYh1EGIHlvCRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+T2BHhW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE9AC4CEF7;
	Fri,  3 Apr 2026 16:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775232173;
	bh=BNPbGQtpMtb7EJLXPZZidRn5FnuViXRDcfBMEOcMpoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h+T2BHhW+QNMdiKBVw4bPtbVkFy0PePJKkJXdRp6yu2l4mvddNz380uIuM/oK/wDe
	 pKAKNLZ9I0IWO+BLyDnNSQAC3nJbK0SthBdWGVvhCjAu6HJkyAwvdohNPnzxCP3Xxm
	 1Ur9EEdoIWyVV6CHt2Xi4xLAfpjR/YVfgxs/CRlAVNFNAk/JTmaX5V+Ig0bQG6eumo
	 A6Y5Qwt4P8A2a4Bu+zkHEJHpNyElmTqfSPAjRRRMaX/tYEwGWIaOWvl6K+IZ5Fvt2Z
	 AwfigUc8ltso8I5SJmTVFxOtC/GZEsAmkD9iS9dhNVHeBS/L2RZlrvmnioLOvWEtdE
	 Hh0zd3XHG5bzQ==
Date: Fri, 3 Apr 2026 17:02:48 +0100
From: Simon Horman <horms@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: fec: make FIXED_PHY dependency unconditional
Message-ID: <20260403160248.GN113102@horms.kernel.org>
References: <20260402141048.2713445-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402141048.2713445-1-arnd@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,arndb.de,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-275124-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7BF02396106
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 04:10:40PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When CONFIG_FIXED_PHY is in a loadable module, the fec driver cannot be
> built-in any more:
> 
> x86_64-linux-ld: vmlinux.o: in function `fec_enet_mii_probe':
> fec_main.c:(.text+0xc4f367): undefined reference to `fixed_phy_unregister'
> x86_64-linux-ld: vmlinux.o: in function `fec_enet_close':
> fec_main.c:(.text+0xc59591): undefined reference to `fixed_phy_unregister'
> x86_64-linux-ld: vmlinux.o: in function `fec_enet_mii_probe.cold':
> 
> Select the fixed phy support on all targets to make this build
> correctly, not just on coldfire.
> 
> Notat that Essentially the stub helpers in include/linux/phy_fixed.h
> cannot be used correctly because of this build time dependency,
> and we could just remove them to hit the build failure more often
> when a driver uses them without the 'select FIXED_PHY'.
> 
> Fixes: dc86b621e1b4 ("net: fec: register a fixed phy using fixed_phy_register_100fd if needed")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I sent the same fix for B44 earlier, see commit 3f0f591b44b0 ("net: b44:
> always select CONFIG_FIXED_PHY"). I checked that there are no other
> conditional users of FIXED_PHY this time.

Reviewed-by: Simon Horman <horms@kernel.org>


