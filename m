Return-Path: <netdev+bounces-240258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CD2C71F90
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 04:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 971A74E4D0B
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 03:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855443081CC;
	Thu, 20 Nov 2025 03:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUxX61Qo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED9C307AEA;
	Thu, 20 Nov 2025 03:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763608800; cv=none; b=jHJeLl3+g5aLfs/n9HuFR7cFuBFtjkiQSD8lfcfPSl2T1yExggUFHP2ukH9QyJFQWkfgxcwAAyUDdsIB4+siOce2qaCl+VHF1nwX69S7847fDlDq566Vl9923DnhOi1aYcgdGFVCkLUotlS1qWtg48USjD4Vinxqie+oDXTzevg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763608800; c=relaxed/simple;
	bh=SnHtT1XSX2LRMY8qiz6OJtd2+7a2qULjOsCaX+Ox058=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PBO7tE6qaNupNr2rLGyHi63NYJT5LUDad90IJaFyQZq+08FBgL9kXKEAcDUDcjprbJ7AAkbEXkTsVh318kE8pysj4ae1bF36GjPF2DXMleTPV8gbKvaEFWI209R+DasMCP+IpiSQGQvIYyJPS+pbss58Ygat5mC5MBJThV31c6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUxX61Qo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A88C4CEF5;
	Thu, 20 Nov 2025 03:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763608799;
	bh=SnHtT1XSX2LRMY8qiz6OJtd2+7a2qULjOsCaX+Ox058=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tUxX61QoG9zh8dMM3E7bPKpkwMRYQ553n0hiVBARcxm+K/bb15eh7mT4ImDxsFd8E
	 w3uiuV+mIJrtYWZKoysb2Lk87+fUwQEtVw078iAA4zKTuzyDUlLmo/AAZFgEg7W0w2
	 1XkHKODQTMX3mQFKCwn8pn0cNIS5vNQ6kbG083Bqjrx/lqmMt3TTFF4NotVOIWJ98l
	 sY4Vnjr3Fhgv8k8p33L7WEIVG3odnVC8ZKst9qSEwPUxh9Kc7ZR99W/CaQVJLkft9U
	 1LmcVhbmbnt/GY7DG9rk4fp88fUiD8iy+MpL3V39/BRZtN8yWYFGXIGxgulhrInevT
	 MAY0Zq6+pgFhg==
Date: Wed, 19 Nov 2025 19:19:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>, Donald Hunter <donald.hunter@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jacob Keller
 <jacob.e.keller@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jordan Rife <jordan@jrife.io>
Subject: Re: [PATCH net-next v3 11/11] wireguard: netlink: generate netlink
 code
Message-ID: <20251119191958.07d9de89@kernel.org>
In-Reply-To: <CAHmME9oO0sGnHrZUeETmL+CCj1UZ+aQx_CPArXKpFuBhE9UYbw@mail.gmail.com>
References: <20251105183223.89913-1-ast@fiberby.net>
	<20251105183223.89913-12-ast@fiberby.net>
	<aRyNiLGTbUfjNWCa@zx2c4.com>
	<d2e84a2b-74cd-44a1-97a6-a10ece7b4c5f@fiberby.net>
	<aRz4eVCjw_JUXki6@zx2c4.com>
	<20251118170045.0c2e24f7@kernel.org>
	<aR5m174O7pklKrMR@zx2c4.com>
	<20251119184436.1e97aeab@kernel.org>
	<CAHmME9oO0sGnHrZUeETmL+CCj1UZ+aQx_CPArXKpFuBhE9UYbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Nov 2025 03:46:39 +0100 Jason A. Donenfeld wrote:
> > Do you care about the exact cmdline of the python tool, or can we just
> > append:
> >
> > /* To regenerate run: tools/net/ynl/ynl-regen.sh */  
> 
> The args are non-trivial, right?

They aren't all that complicated TBH, quoting slightly modified from
tools/net/ynl/ynl-regen.sh:

    $TOOL --mode $mode --$type --spec $KDIR/$yaml_spec $extra_args -o $output

The line just gets quote long for my taste with all the paths in place.

Somewhere along the line we added --cmp-out to make sure output isn't
modified on every regen attempt (for the benefit of incremental builds).

> The idea is so that these files can be regenerated in a few years
> when the ynl project has widely succeeded and we've all paged this
> out of our minds and forgotten how it all worked.

We run ./tools/net/ynl/ynl-regen.sh in our CI, checking if anything
diverged. Primarily because in early days, when codegen was modified
more often, I was worried we'll break the generation for some of the
specs.

The documentation also basically says "create the fake header where 
you want the file to be and run ./tools/net/ynl/ynl-regen.sh".

https://docs.kernel.org/userspace-api/netlink/intro-specs.html#generating-kernel-code

Admittedly most of this comes down to "what Jakub found convenient
when developing the specs" :S

