Return-Path: <netdev+bounces-133911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDE7997754
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 23:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7B691C2128D
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 21:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744E11885BF;
	Wed,  9 Oct 2024 21:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwbLokYm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7762119
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 21:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728508568; cv=none; b=NIXLEi7o1rMo5a8j1Dk/c+L6deOvEgLVBiPr5GUw0Dnh2gMYiv019Y+xgBr7FhuEIszXZbzCjeyAYuIR4gEdyFAlSEekdqCOj4Te71l+CK7IgL1eg4CSpBQNrTIKieF0+AhUy1DSQbbgJrFyDQEzpIrAqv0SJ9XP0iqfM9W/+jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728508568; c=relaxed/simple;
	bh=xIsQ1d+v7oHmtaK2VQlPK34wIEw2pJt0Hqe5ull5w5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bznVrsI1j+sKRIwZzHhNu7k604hoJRkjNGYpyG0yulPqdrrn+czwp131Vs7YdD/lcI73oWJKlL/ubij9dj8rBba2Vhkv7fDZMEylUj/qkBY0/7kjcskfMdmPo3w3LhMY2ImpgtYWcgniPC1Zmioo/aPwERo3frNIkSKXN4ei5S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwbLokYm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4F1C4CED2;
	Wed,  9 Oct 2024 21:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728508567;
	bh=xIsQ1d+v7oHmtaK2VQlPK34wIEw2pJt0Hqe5ull5w5s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CwbLokYmR8aq9eH2I82PdYsIr8VIYQcyHIsCOUo2cu/bgkg7kzvbZHPf68P/E5Tvs
	 drUHRha7cktm7mzerYupl2hKpvdNQ+FnjL9fUFqK8gCx/oDHz2tKX/6bkWAPHyI2YB
	 tY3CIS4+57+ettbHVWWsGqxWIRhPz91HY9XcOtOzCsxYinU4uXaHdas87j9TTCrJeQ
	 b4Pz/AJdnR342HPyolxCWndM2C2/mZkvOE6j702naEEqErr+CVK0hqrW6zTRgBST+O
	 MK+0sOqy5aYSyW391mK2FHIRqDoKTQmdHBzXRYRwdeTUoGUN/zdOyzPmSRYAIojJP6
	 GphVoT/alhGFg==
Message-ID: <8be5e4f4-436e-41fb-a6c1-c22e9225505a@kernel.org>
Date: Wed, 9 Oct 2024 15:16:05 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/5] net: remove RTNL from fib_seq_sum()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20241009184405.3752829-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20241009184405.3752829-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/24 12:44 PM, Eric Dumazet wrote:
> This series is inspired by a syzbot report showing
> rtnl contention and one thread blocked in:
> 
> 7 locks held by syz-executor/10835:
>   #0: ffff888033390420 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2931 [inline] 
>   #0: ffff888033390420 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x224/0xc90 fs/read_write.c:679
>   #1: ffff88806df6bc88 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x1ea/0x500 fs/kernfs/file.c:325
>   #2: ffff888026fcf3c8 (kn->active#50){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x20e/0x500 fs/kernfs/file.c:326
>   #3: ffffffff8f56f848 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: new_device_store+0x1b4/0x890 drivers/net/netdevsim/bus.c:166
>   #4: ffff88805e0140e8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline] 
>   #4: ffff88805e0140e8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x8e/0x520 drivers/base/dd.c:1005
>   #5: ffff88805c5fb250 (&devlink->lock_key#55){+.+.}-{3:3}, at: nsim_drv_probe+0xcb/0xb80 drivers/net/netdevsim/dev.c:1534
>   #6: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: fib_seq_sum+0x31/0x290 net/core/fib_notifier.c:46
> 
> This is not a bug fix, unless I am mistaken, thus targeting net-next.
> 
> 
> Eric Dumazet (5):
>   fib: rules: use READ_ONCE()/WRITE_ONCE() on ops->fib_rules_seq
>   ipv4: use READ_ONCE()/WRITE_ONCE() on net->ipv4.fib_seq
>   ipv6: use READ_ONCE()/WRITE_ONCE() on fib6_table->fib_seq
>   ipmr: use READ_ONCE() to read net->ipv[46].ipmr_seq
>   net: do not acquire rtnl in fib_seq_sum()
> 
>  include/net/fib_notifier.h |  2 +-
>  include/net/fib_rules.h    |  2 +-
>  include/net/ip6_fib.h      |  8 ++++----
>  include/net/ip_fib.h       |  4 ++--
>  include/net/netns/ipv4.h   |  2 +-
>  net/core/fib_notifier.c    |  2 --
>  net/core/fib_rules.c       | 14 ++++++++------
>  net/ipv4/fib_notifier.c    | 10 +++++-----
>  net/ipv4/fib_rules.c       |  2 +-
>  net/ipv4/ipmr.c            | 10 ++++------
>  net/ipv6/fib6_notifier.c   |  2 +-
>  net/ipv6/fib6_rules.c      |  2 +-
>  net/ipv6/ip6_fib.c         | 14 +++++++-------
>  net/ipv6/ip6mr.c           | 10 ++++------
>  14 files changed, 40 insertions(+), 44 deletions(-)
> 

For the set:
Reviewed-by: David Ahern <dsahern@kernel.org>


