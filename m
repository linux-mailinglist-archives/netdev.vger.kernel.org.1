Return-Path: <netdev+bounces-128980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B1E97CB35
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 16:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 475F11F22BC6
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 14:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4B41A01B4;
	Thu, 19 Sep 2024 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5BD6+zJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A8E1A01A9;
	Thu, 19 Sep 2024 14:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726757774; cv=none; b=BwQN50afh41eeGzBJR2sE0Tne+eNKu2UYJIPHr4XND16wZX41ZRzGCH97rj1VD+tNQqOgeeNA/8Jv7uj0Nb1PR4zKH4gjsVROfSekvNBjhWIYQBULJOCdk5S47xEQlZYKPVlEQTRsy9M3lLk8iXQSJnDzl6ykjLWlTPD+UnF0cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726757774; c=relaxed/simple;
	bh=QtIZeX0lLZcer6NTnJA8KxK4g0xGghJRzcuUPpkb0bA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWYDksEG93mcaFAKFKYuhWrB/3n5PPLfU2ZOWor8PAJj8I1GKYx0jvVdmKDjy7gIgSoYSL1vCQ0TV2XeUfu2+hCSBTNS63YkIBwkD3fZft6hrQPQ0gcYLjUUKF8mWwf8//DgMxVgwtjNxic6J5UZzyupslA8SItWpx2HxfMSABY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5BD6+zJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4FBC4CEC6;
	Thu, 19 Sep 2024 14:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726757773;
	bh=QtIZeX0lLZcer6NTnJA8KxK4g0xGghJRzcuUPpkb0bA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E5BD6+zJkxJRQkR4uhMeXTb5xDFvbc49U+UBAnb/rpWkm7Ps7hzIWTDItvKk68Ok4
	 z/3gu9GSAb4OpVvncmFYcUDrrPBaMKOxGWFJZfSH/Izu0obJ9fp/4Apak7wky5a7Jw
	 kkYs8OCz9Xlc76fmK0cd4Trm6XjxGtcJmqvC4cjbhpUZxmpZChtIXy0ICRfu2rf163
	 U68HEgkGUuMCzlFSOKoQMHRU2L8181tlrYzEP84ZGLe8wCGw/u2of92IFdoc7xVUnw
	 hZ8Zs+f8qbBEo53PlJfgBCt5JdfR3mjNK3a7xPqcUHxFteRHfcM1rmfoz1X9PICxxV
	 b6yuOkWfYFT2A==
Date: Thu, 19 Sep 2024 15:56:09 +0100
From: Simon Horman <horms@kernel.org>
To: Moon Yeounsu <yyyynoom@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: add inline annotation to fix the build warning
Message-ID: <20240919145609.GF1571683@kernel.org>
References: <20240919142149.282175-1-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919142149.282175-1-yyyynoom@gmail.com>

On Thu, Sep 19, 2024 at 11:21:49PM +0900, Moon Yeounsu wrote:
> This patch fixes two sparse warnings (`make C=1`):
> net/ipv6/icmp.c:103:20: warning: context imbalance in 'icmpv6_xmit_lock' - wrong count at exit
> net/ipv6/icmp.c:119:13: warning: context imbalance in 'icmpv6_xmit_unlock' - unexpected unlock
> 
> Since `icmp6_xmit_lock()` and `icmp6_xmit_unlock()` are designed as they
> are named, entering/returning the function without lock/unlock doesn't
> matter.
> 
> Signed-off-by: Moon Yeounsu <yyyynoom@gmail.com>

Hi Moon,

Without this patch applied I see the warnings cited above.

However, with this patch applied, I see the following.
So I think this needs more work.

net/ipv6/icmp.c: note: in included file (through include/linux/sched.h, include/linux/percpu.h, arch/x86/include/asm/msr.h, arch/x86/include/asm/tsc.h, arch/x86/include/asm/timex.h, include/linux/timex.h, ...):
./include/linux/spinlock.h:361:16: warning: context imbalance in 'icmpv6_xmit_lock' - different lock contexts for basic block
net/ipv6/icmp.c: note: in included file (through include/linux/spinlock.h, include/linux/sched.h, include/linux/percpu.h, arch/x86/include/asm/msr.h, arch/x86/include/asm/tsc.h, arch/x86/include/asm/timex.h, ...):
./include/linux/bottom_half.h:33:30: warning: context imbalance in 'icmp6_send' - different lock contexts for basic block
./include/linux/bottom_half.h:33:30: warning: context imbalance in 'icmpv6_echo_reply' - different lock contexts for basic block

Also, It is my feeling that addressing warnings of this nature
is not a fix for net, but rather but rather an enhancement for net-next.

net-next is currently closed for the v6.12 merge windows, so non-RFC,
patches should not be posted for net-next until it re-opens once v6.12-rc1
has been released, most likely during the week of 30th September.

-- 
pw-bot: changes-requested

