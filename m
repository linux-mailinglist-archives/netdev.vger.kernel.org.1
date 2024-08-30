Return-Path: <netdev+bounces-123765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA846966745
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 18:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659AD1F25A82
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 16:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41371B3B10;
	Fri, 30 Aug 2024 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJH3CHZ5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4A1135417;
	Fri, 30 Aug 2024 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725036431; cv=none; b=TtQJhMCXIUbAbfE45dy53vKnAC9/2N5SJ/TCchN1bNwCIu1ZPBOcfpUz2OyyP0nycV3ZmTWdUWDuAD8C096YlZIMpaQ5+amuZiT2DYqGPf5YB6ASictz7Lyxp4hLhuuZhFb7HbIIfwgn+GBAJuZd2fGsdnFmqmmLTtxsuFE8oOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725036431; c=relaxed/simple;
	bh=SQ9lisFf3o2BYvsuSUZxqA756vneQkERg1IHs9y7+2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q25TmDs9nnk3XnXOZ26BG9O40rOx/2qrB/7kMCoTTracjAMVpI51Betp4IzIfcXdzuBvPmNXNO21OMzftTd71q/ueTGn+4hARR3nMWANkqIWO9SluU42tkouIOvEuxdtniGeC5hLhrnGWTByOnfOEZtP0gocBbfySaMxpyRvbGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJH3CHZ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6259CC4CEC2;
	Fri, 30 Aug 2024 16:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725036431;
	bh=SQ9lisFf3o2BYvsuSUZxqA756vneQkERg1IHs9y7+2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tJH3CHZ5gvbxgDXWGNcfzdnvIvn8SjQVjbZCguHKlh7jlJEWllIn2YJ0z6MkikHoO
	 1LCaCYw4Us647LL95BmKualhQ9e7L7zfD1MIijQegb2T8R70/Dvz5pl5DJ6HwHivmn
	 saeq9Hsaj9k5f0cvorRJxsJRaTQXqA2ByduO/L0Kt3SS06DyOM7H5t4o7kDepaFsK0
	 fQghHCtIcO9hnUjmFZNI907G0Mk+qonm5jg7RnP9FsKFdY3gRoOeO8cTjdKih/+OHq
	 xFLbRU/9s8Arpi5e7UVLS+JKydUnvZNVp9EV50SrgT1TNJ+pbl44qiJXcjqLp1riBn
	 Z+021KZnlApcw==
Date: Fri, 30 Aug 2024 17:47:06 +0100
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
Message-ID: <20240830164706.GW1368797@kernel.org>
References: <CA+G9fYtemFfuhc7=eNyP3TezM9Euc8sFtHe4GDR4Z9XdHzXSJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtemFfuhc7=eNyP3TezM9Euc8sFtHe4GDR4Z9XdHzXSJA@mail.gmail.com>

+ Florian, Steffen

On Fri, Aug 30, 2024 at 12:15:10PM +0530, Naresh Kamboju wrote:
> The x86_64 defconfig builds failed on today's Linux next-20240829
> due to following build warnings / errors.
> 
> Regressions:
> * i386, build
>   - clang-18-defconfig
>   - clang-nightly-defconfig
> 
> * x86_64, build
>   - clang-18-lkftconfig
>   - clang-18-lkftconfig-compat
>   - clang-18-lkftconfig-kcsan
>   - clang-18-lkftconfig-no-kselftest-frag
>   - clang-18-x86_64_defconfig
>   - clang-nightly-lkftconfig
>   - clang-nightly-lkftconfig-kselftest
>   - clang-nightly-x86_64_defconfig
>   - rustclang-nightly-lkftconfig-kselftest
> 
> first seen on next-20240829.
>   Good: next-20240828
>   BAD:  next-20240829
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> build log:
> --------
> net/xfrm/xfrm_policy.c:1286:8: error: variable 'dir' is uninitialized
> when used here [-Werror,-Wuninitialized]
>  1286 |                 if ((dir & XFRM_POLICY_MASK) == XFRM_POLICY_OUT) {
>       |                      ^~~
> net/xfrm/xfrm_policy.c:1257:9: note: initialize the variable 'dir' to
> silence this warning
>  1257 |         int dir;
>       |                ^
>       |                 = 0
> 1 error generated.

I believe that is due to
commit 08c2182cf0b4 ("xfrm: policy: use recently added helper in more places")

I will work on a fix to initialise dir in the loop where it is used.

