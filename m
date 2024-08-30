Return-Path: <netdev+bounces-123774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6164F966792
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 19:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E095286611
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 17:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BC91B5EA9;
	Fri, 30 Aug 2024 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFGiZtTV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4A416C68F;
	Fri, 30 Aug 2024 17:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725037494; cv=none; b=tmqnW+qdbN5K2MI7HOdlVzKjUUEbYG7D9C83QlACnro+UXIqm8h7UiOXHSgfCURTk/i63t4KMzHU3ZEk9wJpKRJYUnuv1Rj7iqG5gEXKwuTm11N1Tq0z7ss1Oz6KVlDHzBRIooptMmVsK3wZb4BreE5O4qPTRtC4swFwn/gNzqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725037494; c=relaxed/simple;
	bh=xIXAMIe5hLeQUFpwywsJ8g5KP7dZuff50VDK4ECjhaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYeVPVPOlqPQWLI5e7uFX5svpltQE3/y5fZoSYbV1H6pJGq5nj/jr8q+kVyehvtVOa8L0SxARDWqO6yZDTjTYDoZA6+fWME/tOoD0jhIkIS5TD+MLsxoYbcHf5caTP6wy7n7gkJkxaLdZ8ufYPm7vC4kZFEy10HjSkl3bjBpAtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFGiZtTV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E95C4CEC2;
	Fri, 30 Aug 2024 17:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725037493;
	bh=xIXAMIe5hLeQUFpwywsJ8g5KP7dZuff50VDK4ECjhaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nFGiZtTVGSMcAvzTDKKMPKU9t254eb1MRqstsx3+2wi7SnROqSDh21xZ9yJMc+sme
	 g0yvyDsJeCojACLE1s9CQXEPLA7hgyBJn1ZAkHeMUhHREV/QzOD4Dr9CxoRWLyjRIB
	 Oop5Z8PNSHkHP6P/Xzs6eWiCQpG+xQkMxywEPVt80Lup3BdgkKC1XiVPMGIogi6/1E
	 CQGvNOxr1OYofJdERSgID4GHEsMtkSvBlXfuj6788/Qw2eab6sil6o9Rh4GrkA9x6d
	 n9asGsqSMCPmeqwy1GAgZ+ZSIqPiQ0S8hix+olAAS9AwbGCl29Gbq3urMDZ74j0m4C
	 47WrsXy/moEwg==
Date: Fri, 30 Aug 2024 18:04:49 +0100
From: Simon Horman <horms@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: clang-built-linux <llvm@lists.linux.dev>,
	Netdev <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Anders Roxell <anders.roxell@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Florian Westphal <fw@strlen.de>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: net/xfrm/xfrm_policy.c:1286:8: error: variable 'dir' is
 uninitialized when used here [-Werror,-Wuninitialized]
Message-ID: <20240830170449.GX1368797@kernel.org>
References: <CA+G9fYtemFfuhc7=eNyP3TezM9Euc8sFtHe4GDR4Z9XdHzXSJA@mail.gmail.com>
 <20240830164706.GW1368797@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830164706.GW1368797@kernel.org>

On Fri, Aug 30, 2024 at 05:47:06PM +0100, Simon Horman wrote:
> + Florian, Steffen
> 
> On Fri, Aug 30, 2024 at 12:15:10PM +0530, Naresh Kamboju wrote:
> > The x86_64 defconfig builds failed on today's Linux next-20240829
> > due to following build warnings / errors.
> > 
> > Regressions:
> > * i386, build
> >   - clang-18-defconfig
> >   - clang-nightly-defconfig
> > 
> > * x86_64, build
> >   - clang-18-lkftconfig
> >   - clang-18-lkftconfig-compat
> >   - clang-18-lkftconfig-kcsan
> >   - clang-18-lkftconfig-no-kselftest-frag
> >   - clang-18-x86_64_defconfig
> >   - clang-nightly-lkftconfig
> >   - clang-nightly-lkftconfig-kselftest
> >   - clang-nightly-x86_64_defconfig
> >   - rustclang-nightly-lkftconfig-kselftest
> > 
> > first seen on next-20240829.
> >   Good: next-20240828
> >   BAD:  next-20240829
> > 
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > 
> > build log:
> > --------
> > net/xfrm/xfrm_policy.c:1286:8: error: variable 'dir' is uninitialized
> > when used here [-Werror,-Wuninitialized]
> >  1286 |                 if ((dir & XFRM_POLICY_MASK) == XFRM_POLICY_OUT) {
> >       |                      ^~~
> > net/xfrm/xfrm_policy.c:1257:9: note: initialize the variable 'dir' to
> > silence this warning
> >  1257 |         int dir;
> >       |                ^
> >       |                 = 0
> > 1 error generated.
> 
> I believe that is due to
> commit 08c2182cf0b4 ("xfrm: policy: use recently added helper in more places")
> 
> I will work on a fix to initialise dir in the loop where it is used.

Patch is here:
- [PATCH ipsec-next] xfrm: Initialise dir in xfrm_hash_rebuild()
  https://lore.kernel.org/netdev/20240830-xfrm_hash_rebuild-dir-v1-1-f75092d07e1b@kernel.org/T/#u

