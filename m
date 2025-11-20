Return-Path: <netdev+bounces-240287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D8CC72213
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 05:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6C3003518F7
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 04:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D78226541;
	Thu, 20 Nov 2025 04:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3lxHcSL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCA619D071
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 04:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763611387; cv=none; b=LHj8uDrU365Zkkz+6ABqTXt6bPJVf/DDSHHR3kvAlPxNgrhSfxqnXPjMsliWzyJp2yYeYYV2y4/K/R0uhvPIHQVhWS54xGLSYVOXcv3RxF0g1v+nm8NOPlnLV99MQOMCKG3j8Gq7ibiFU6Be0f9jWHljXzBmN0dETeSt6nnzUIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763611387; c=relaxed/simple;
	bh=OBn51iG5c42DqEv43G7gT9DDS0iRcln91HT4C0dz+E0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F+OD/voBUI/beAYarIhp6sZ1MIx/6+HIyiohsv2A/btoVwfYxw7UVVFLRbEAZQzf9ZP3poh/NKUviQeRR0y2jlSn+JwG13TE37DJWXA+YydDI+kRMB4wzSGtOmZrg74qOK61KA8IggzxNKMZ1HB7jbj09xvwI3adn4sd5ceU9N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3lxHcSL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC247C4CEF1;
	Thu, 20 Nov 2025 04:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763611385;
	bh=OBn51iG5c42DqEv43G7gT9DDS0iRcln91HT4C0dz+E0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h3lxHcSLs4O90GTlIWxLxhZ6eCm0FGgT3h/KXG00dVZYb2+vIcbNYdIpViGjumrjT
	 kuJftdXKF+ZqXxnO63FpZjnW1ru8BczUk8mbDIa0r5TG4lUWmUzq9Ca5Rm6H42QkWu
	 +TyGZS5pAhcIwwrvHRQ50XO++h77XE3ay0NF30eZ0mCekvqIo8lk7jSablLLEb1sPz
	 /V/X/9+hNWEzQf0kI5TgbUx5ErfNaARKAbkiF3LFhMQJdQNUdmhU39paSymWfdGxgw
	 4gWnFxTt7fQJRAIT38SGVgKXxlCSuXw8QDydsIydekiUDs5AkobqvH7NtTxoBoTHfh
	 tuC+GvMYwpDug==
Date: Wed, 19 Nov 2025 20:03:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v4 2/2] doc/netlink: Expand nftables specification
Message-ID: <20251119200304.7a0a7905@kernel.org>
In-Reply-To: <2a8b6847cbb9c4c09a2ddd6663294b8238b044ad.1763574466.git.one-d-wide@protonmail.com>
References: <2a8b6847cbb9c4c09a2ddd6663294b8238b044ad.1763574466.git.one-d-wide@protonmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Nov 2025 18:16:00 +0000 Remy D. Farley wrote:
> Getting out some changes I've accumulated while making nftables work
> with Rust netlink-bindings. Hopefully, this will be useful upstream.

In the future it's better to keep things in smaller patches.
Easier to review.

The docs have to be in ReST-compatible format I see:

Documentation/netlink/specs/nftables.yaml:66: WARNING: Field list ends without a blank line; unexpected unindent.
Documentation/netlink/specs/nftables.yaml:261: WARNING: Bullet list ends without a blank line; unexpected unindent.
Documentation/netlink/specs/nftables.yaml:261: WARNING: Field list ends without a blank line; unexpected unindent.

`make htmldocs` to repro

> +    # Defined in include/linux/netfilter/nf_tables.h

Isn't this the main header for nf_tables?
If yes then no need to comment, should be the obvious place.
If no - can we use 
	
	header: linux/netfilter/nf_tables.h

?

Last but not least when you post v2 please CC folks from netfilter:

NETFILTER
M:	Pablo Neira Ayuso <pablo@netfilter.org>
M:	Jozsef Kadlecsik <kadlec@netfilter.org>
M:	Florian Westphal <fw@strlen.de>
R:	Phil Sutter <phil@nwl.cc>
L:	netfilter-devel@vger.kernel.org
L:	coreteam@netfilter.org
S:	Maintained

