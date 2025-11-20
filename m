Return-Path: <netdev+bounces-240249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E794DC71E1D
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 03:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9448D34EF50
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 02:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B18209F5A;
	Thu, 20 Nov 2025 02:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbqHCvb6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EEFD531;
	Thu, 20 Nov 2025 02:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763606678; cv=none; b=kv3GGj3ItoU/JAaHMmOx0SzA8MmrbVBRt6QenCct+kfb65VYOpKrnigPxP5IegujiHsYOoPDOO8WV7u8FbSUYJev3u4w1WNKr2WDe2HCDWVXJsuz4mWkwD+OPvxuH5z5vIiiofVgikvjWd7eaYKT2V8YjZMnE2mwy5CnPZU2oCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763606678; c=relaxed/simple;
	bh=ix0hqericVGB0EMLnx7+/jSBoCx0qtxlgsvyY0lfAwk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cixsGvnwPd+gMBWHcYHl+nngBAP/9hVlgmFlCurSOSvXPiifEwLTuu+oTGpZO4gqKYJlZDoKxpy3r3h0StLq7aYKcvBgUbYx3gwNYdmjVp+vGX2n69GQd7mQ72/fxJmKLDtlvi7mfwU8teDbg8ASSvwyy8Rk5o1RZCYipE4vics=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbqHCvb6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1C9C4CEF5;
	Thu, 20 Nov 2025 02:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763606678;
	bh=ix0hqericVGB0EMLnx7+/jSBoCx0qtxlgsvyY0lfAwk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CbqHCvb6xuIDW4adOja7BpfssfDDeF8vwdsThdcJToGr5cSGuq7srO0KQtg6Z/Cdt
	 kAVah/JwhElvIV82uO/0HXY3S2WC7NH0kqyeYX8gWpGwXbakF51wGpKng3plJVhowL
	 QzDDTm7RCWCIDINIzmJixvUPDmfNjAJIpXJIdzr58uBZn3BLYpIzNxtFjvdQwPurrz
	 32EzWzKeMw0plfZq4irDn8r1PVFjP8wit9GcdgE5YjpvLxkg/AglMhZUZzPMyO6pvi
	 7sxxGjQro0gKd/PihkHyVjzxQE6iND53KFaquRqkZb43wYSGMO3RBQxJ6Z9SfMjucP
	 Nr8YugoXPhwIg==
Date: Wed, 19 Nov 2025 18:44:36 -0800
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
Message-ID: <20251119184436.1e97aeab@kernel.org>
In-Reply-To: <aR5m174O7pklKrMR@zx2c4.com>
References: <20251105183223.89913-1-ast@fiberby.net>
	<20251105183223.89913-12-ast@fiberby.net>
	<aRyNiLGTbUfjNWCa@zx2c4.com>
	<d2e84a2b-74cd-44a1-97a6-a10ece7b4c5f@fiberby.net>
	<aRz4eVCjw_JUXki6@zx2c4.com>
	<20251118170045.0c2e24f7@kernel.org>
	<aR5m174O7pklKrMR@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Nov 2025 01:54:47 +0100 Jason A. Donenfeld wrote:
> On Tue, Nov 18, 2025 at 05:00:45PM -0800, Jakub Kicinski wrote:
> > On Tue, 18 Nov 2025 23:51:37 +0100 Jason A. Donenfeld wrote:  
> > > I mean, there is *tons* of generated code in the kernel. This is how it
> > > works. And you *want the output to change when the tool changes*. That's
> > > literally the point. It would be like if you wanted to check in all the
> > > .o files, in case the compiler started generating different output, or
> > > if you wanted the objtool output or anything else to be checked in. And
> > > sheerly from a git perspective, it seems outrageous to touch a zillion
> > > files every time the ynl code changes. Rather, the fact that it's
> > > generated on the fly ensures that the ynl generator stays correctly
> > > implemented. It's the best way to keep that code from rotting.  
> > 
> > CI checks validate that the files are up to date.
> > There has been no churn to the kernel side of the generated code.
> > Let's be practical.  
> 
> Okay, it sounds like neither of you want to do this. Darn. I really hate
> having generated artifacts laying around that can be created efficiently
> at compile time. But okay, so it goes. I guess we'll do that.
> 
> I would like to ask two things, then, which may or may not be possible:
> 
> 1) Can we put this in drivers/net/wireguard/generated/netlink.{c.h}
>    And then in the Makefile, do `wireguard-y += netlink.o generated/netlink.o`
>    on one line like that. I prefer this to keeping it in the same
>    directory with the awkward -gen suffix.

That should work, I think.

> 2) In the header of each generated file, automatically write out the
>    command that was used to generate it. Here's an example of this good
>    habit from Go: https://github.com/golang/go/blob/master/src/syscall/zsyscall_linux_amd64.go

You don't like the runes? :)

/* Do not edit directly, auto-generated from: */
/*	$YAML-path */
/* YNL-GEN [kernel|user|uapi] [source|header] */
/* YNL-ARG $extra-args */

Do you care about the exact cmdline of the python tool, or can we just
append:

/* To regenerate run: tools/net/ynl/ynl-regen.sh */

