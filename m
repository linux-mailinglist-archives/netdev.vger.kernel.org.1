Return-Path: <netdev+bounces-123965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B72967054
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 10:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 989EF1F22B75
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 08:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C77916EBED;
	Sat, 31 Aug 2024 08:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PThRW3+n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB99922095;
	Sat, 31 Aug 2024 08:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725092657; cv=none; b=mF06gqTODT9//NEewMbqC90pD5LgOq0ukNwR4Ntp9n98AO0YdSHekU3T9OP3UJkfdA0cee2CFOmJXa81FptK6D3CB7yGH/a4oCJC6+Bkp/+1zEWvLBi/2ueOjMX/EdDdBut8dELNmUep20w/ZPmWLwYYYBd/QF9YxxhM9RPalBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725092657; c=relaxed/simple;
	bh=8Q0rv1U+EQwWMFT1qBVs5i+5vSbooP+Bl5Hfnffjh4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tb8yeQVbtO3EDNbooQAJVyqLv3M5geqxm94LzY5Kt/XeDsbzWxdd9kQhfs7q0GfjhqKytkaNjG7CxxkY/KBXpN4Knjkl6BB25emaEUhauiB8hR77f7bOduM8OkzK4sv5Bii7ITPNydfnPHaca1eIuuG/EICUWGn97cIf6ZfP/ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PThRW3+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD1CC4CEC0;
	Sat, 31 Aug 2024 08:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725092656;
	bh=8Q0rv1U+EQwWMFT1qBVs5i+5vSbooP+Bl5Hfnffjh4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PThRW3+nZ4aRFDDLhuSiH5RqKJ6xblGOcBjhmOsCOIxA7+eOKv5dTW70+S1e7yNxP
	 PuH1KcpVat0BQ6ivesg5oPzqIPnJMlHj/JF5wMZeak1Ue/peGfq/yFFGvNNJpRJ2X8
	 Uh+arijRJZWunOUvbQoXai0j5/7LT/5tk3mSYrPFppqGFwnTuC3+wpCy4b3Ai4uOxv
	 9iDxt9jn66PXSPX8ABpnzGZugz+g2/VwrEEok6U1mgp8u5vH7pH3GdEU6PdxHa4pk1
	 mwWzJlWPbeYcaQ2tSdDCD+hIZlP7VJrUtl7/qPuWrDY0NmZVFFQEs3eED2wcAbHCoh
	 7hUv8gH2gOkvg==
Date: Sat, 31 Aug 2024 09:24:11 +0100
From: Simon Horman <horms@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	clang-built-linux <llvm@lists.linux.dev>,
	Netdev <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Anders Roxell <anders.roxell@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Florian Westphal <fw@strlen.de>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: net/xfrm/xfrm_policy.c:1286:8: error: variable 'dir' is
 uninitialized when used here [-Werror,-Wuninitialized]
Message-ID: <20240831082411.GC4063074@kernel.org>
References: <CA+G9fYtemFfuhc7=eNyP3TezM9Euc8sFtHe4GDR4Z9XdHzXSJA@mail.gmail.com>
 <20240830164706.GW1368797@kernel.org>
 <20240830170449.GX1368797@kernel.org>
 <20240830214757.GA3819549@thelio-3990X>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830214757.GA3819549@thelio-3990X>

On Fri, Aug 30, 2024 at 02:47:57PM -0700, Nathan Chancellor wrote:
> Hi Simon (and Naresh),
> 
> On Fri, Aug 30, 2024 at 06:04:49PM +0100, Simon Horman wrote:
> > On Fri, Aug 30, 2024 at 05:47:06PM +0100, Simon Horman wrote:
> > > + Florian, Steffen
> > > 
> > > On Fri, Aug 30, 2024 at 12:15:10PM +0530, Naresh Kamboju wrote:
> > > > The x86_64 defconfig builds failed on today's Linux next-20240829
> > > > due to following build warnings / errors.
> > > > 
> > > > Regressions:
> > > > * i386, build
> > > >   - clang-18-defconfig
> > > >   - clang-nightly-defconfig
> > > > 
> > > > * x86_64, build
> > > >   - clang-18-lkftconfig
> > > >   - clang-18-lkftconfig-compat
> > > >   - clang-18-lkftconfig-kcsan
> > > >   - clang-18-lkftconfig-no-kselftest-frag
> > > >   - clang-18-x86_64_defconfig
> > > >   - clang-nightly-lkftconfig
> > > >   - clang-nightly-lkftconfig-kselftest
> > > >   - clang-nightly-x86_64_defconfig
> > > >   - rustclang-nightly-lkftconfig-kselftest
> > > > 
> > > > first seen on next-20240829.
> > > >   Good: next-20240828
> > > >   BAD:  next-20240829
> > > > 
> > > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > > 
> > > > build log:
> > > > --------
> > > > net/xfrm/xfrm_policy.c:1286:8: error: variable 'dir' is uninitialized
> > > > when used here [-Werror,-Wuninitialized]
> > > >  1286 |                 if ((dir & XFRM_POLICY_MASK) == XFRM_POLICY_OUT) {
> > > >       |                      ^~~
> > > > net/xfrm/xfrm_policy.c:1257:9: note: initialize the variable 'dir' to
> > > > silence this warning
> > > >  1257 |         int dir;
> > > >       |                ^
> > > >       |                 = 0
> > > > 1 error generated.
> 
> Thanks for the report.
> 
> > > I believe that is due to
> > > commit 08c2182cf0b4 ("xfrm: policy: use recently added helper in more places")
> > > 
> > > I will work on a fix to initialise dir in the loop where it is used.
> > 
> > Patch is here:
> > - [PATCH ipsec-next] xfrm: Initialise dir in xfrm_hash_rebuild()
> >   https://lore.kernel.org/netdev/20240830-xfrm_hash_rebuild-dir-v1-1-f75092d07e1b@kernel.org/T/#u
> 
> I sent the same patch as a v1 but Florian pointed out that dir needs to
> be initialized in the other loop too. I sent my v2 for it yesterday, it
> just needs to be merged.
> 
> https://lore.kernel.org/all/20240829-xfrm-restore-dir-assign-xfrm_hash_rebuild-v2-1-1cf8958f6e8e@kernel.org/

Thanks, and sorry for the noise.

