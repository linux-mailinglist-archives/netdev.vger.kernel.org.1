Return-Path: <netdev+bounces-122363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E5A960D53
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 16:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2AB628585A
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6E91C463F;
	Tue, 27 Aug 2024 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5U8Ac7n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C001C3F2A;
	Tue, 27 Aug 2024 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724768087; cv=none; b=oise7PE9US0rkuEy7dy8T7yFc50BUu4rYE/CfPNmkMKmrKL/P12aDUWaXOBM2lmmDn9WLwogMjllFDm32jn3FriO+JvHd6FezFCIlEd+567pcQ2gSKYtKjqntKTWixLRMRwK2svdv718MkOtCqzrAehJsczWD8mWidN4WtQlr14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724768087; c=relaxed/simple;
	bh=a/qNXotiee3mkDBZtw/MwodPcn0+Q7aIdor21E4Jwx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SoCumYt26yYd49qtozPBEPgZOnw+wOCn0TrKLlInF42+Reh05XoFkzP1f3jDOrpjlhxgnBGlbPyaqsNq4ZrP4KiYRGpCb1eANniVEMHYX4zDnzkIkVBWL3lX/B3C08H3QMGJNvREOjNcFzU52s15D0tRbNf56v3zc9PZb+DfQZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5U8Ac7n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84C4C581AA;
	Tue, 27 Aug 2024 14:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724768085;
	bh=a/qNXotiee3mkDBZtw/MwodPcn0+Q7aIdor21E4Jwx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n5U8Ac7nJsSEAL/6CjdNIlaFXssAx54V5VxtygP7756BZV/TOl4j+46zr7y5WbX7I
	 A/440w6Jxobevbl63n9NL6cu2UIejOB/gBmN/7PZJMPmPpLgfFBHkKFXPnRlI7oTB3
	 ez2rHZ0V7mt1vEf+0wK2pMgTWe0buH8YDBeSPSul3+F8/KFWTvdbkBOOKkKgCMcUmO
	 jvXQCuOiqftj+ouhkTTy9g+tx20NxtxGj81SJJIw0M9pe3SWgT784z8VBlVIoYuzfB
	 w2sY/ZU7YYBPC6tDnbSfPKYLE8EWivvzlwikrO/CbJG9iHB8709U3YOmVcn9uQDnsZ
	 +0AV272x6BBBg==
Date: Tue, 27 Aug 2024 15:14:40 +0100
From: Simon Horman <horms@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: kernel test robot <lkp@intel.com>, netdev@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org
Subject: Re: [PATCH v4 net-next 09/12] testing: net-drv: add basic shaper test
Message-ID: <20240827141440.GC1368797@kernel.org>
References: <4cf74f285fa5f07be546cb83ef96775f86aa0dbf.1724165948.git.pabeni@redhat.com>
 <202408220027.kA3pRF6J-lkp@intel.com>
 <3b1ca110-d1e7-47c5-af31-360a233cb4aa@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b1ca110-d1e7-47c5-af31-360a233cb4aa@redhat.com>

Cc: Brian Cain, linux-hexagon

On Thu, Aug 22, 2024 at 09:53:22AM +0200, Paolo Abeni wrote:
> 
> 
> On 8/21/24 18:52, kernel test robot wrote:
> > Hi Paolo,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on net-next/main]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Paolo-Abeni/tools-ynl-lift-an-assumption-about-spec-file-name/20240820-231626
> > base:   net-next/main
> > patch link:    https://lore.kernel.org/r/4cf74f285fa5f07be546cb83ef96775f86aa0dbf.1724165948.git.pabeni%40redhat.com
> > patch subject: [PATCH v4 net-next 09/12] testing: net-drv: add basic shaper test
> > config: hexagon-randconfig-r112-20240821 (https://download.01.org/0day-ci/archive/20240822/202408220027.kA3pRF6J-lkp@intel.com/config)
> > compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
> > reproduce: (https://download.01.org/0day-ci/archive/20240822/202408220027.kA3pRF6J-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202408220027.kA3pRF6J-lkp@intel.com/
> > 
> > sparse warnings: (new ones prefixed by >>)
> > > > net/shaper/shaper.c:227:24: sparse: sparse: Using plain integer as NULL pointer
> 
> AFAICS this warning comes directly from/is due to the hexgon cmpxchg
> implementation:
> 
> #define arch_cmpxchg(ptr, old, new)                             \
> ({                                                              \
>         __typeof__(ptr) __ptr = (ptr);                          \
>         __typeof__(*(ptr)) __old = (old);                       \
>         __typeof__(*(ptr)) __new = (new);                       \
>         __typeof__(*(ptr)) __oldval = 0;                        \
> 				^^^^^^^ here.

FWIIW, I agree.

It seems that arch_cmpxchg, as implemented above, expects ptr to
be an integer. And indeed it is used in that way from
include/linux/atomic/atomic-arch-fallback.h:raw_atomic_cmpxchg_acquire().

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/include/linux/atomic/atomic-arch-fallback.h?id=f8fdda9e4f988c210b1e4519a28ddbf7d29b0038#n2055

As a hack, I allowed the function to handle either int or any type of
pointer. With this in place Sparse no longer flags the problem described
above in shaper.c.

Perhaps someone has a suggestion of how to fix this properly.

diff --git a/arch/hexagon/include/asm/cmpxchg.h b/arch/hexagon/include/asm/cmpxchg.h
index bf6cf5579cf4..d8decb8fb456 100644
--- a/arch/hexagon/include/asm/cmpxchg.h
+++ b/arch/hexagon/include/asm/cmpxchg.h
@@ -51,12 +51,18 @@ __arch_xchg(unsigned long x, volatile void *ptr, int size)
  *  variable casting.
  */
 
+#define arch_cmpxchg_zero(ptr)					\
+	(__typeof__(*(ptr)))					\
+		_Generic(*(ptr),				\
+			 int:		0,			\
+			 default:	NULL)
+
 #define arch_cmpxchg(ptr, old, new)				\
 ({								\
 	__typeof__(ptr) __ptr = (ptr);				\
 	__typeof__(*(ptr)) __old = (old);			\
 	__typeof__(*(ptr)) __new = (new);			\
-	__typeof__(*(ptr)) __oldval = 0;			\
+	__typeof__(*(ptr)) __oldval = arch_cmpxchg_zero(ptr);	\
 								\
 	asm volatile(						\
 		"1:	%0 = memw_locked(%1);\n"		\

