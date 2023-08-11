Return-Path: <netdev+bounces-26740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4521F778BDC
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 12:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 521F91C20B79
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 10:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CCC6FCD;
	Fri, 11 Aug 2023 10:20:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A9E6D22
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 10:20:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2849EC433C9;
	Fri, 11 Aug 2023 10:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691749230;
	bh=yf9lvJCGhMyN1vb9RpHsMCGkt8wZyIcVDcG9PIwdvrI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fSLCcAptSNq0dT5W5MeAUFV8JlILaq1bq6rS1yju2dbUue9hRnBkLZPyQoiHW2Y4K
	 jgBePaWNOkU0d21cH/XFCxCAVZMQS5qlGCcYp+/aBsz7H6wC6sRnHq4lBeywB0Ru8z
	 wDOv9u2I7Zbwoi69ScOi6TTgk4g1+RJY0H4RWXO+OtgiwqyS6NRfe3ZL4x0bHC0dW9
	 UOAyPJl6snbevn/rMe+b2sU9oMSYKloxEaloC4lvFv+n6J0QvnggtUGnF8/Nd2AFPj
	 rhwgIwNffjn9p4ibAQj1oJ6UhTlfakqdwxwquMMN76BejWoxzxH4hCsuHFvOkX99Ol
	 H/tKI4LjjcU6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 037DDC3274B;
	Fri, 11 Aug 2023 10:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next,v2 0/5] bonding: do some cleanups in bond driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169174922998.9362.12886233325863357951.git-patchwork-notify@kernel.org>
Date: Fri, 11 Aug 2023 10:20:29 +0000
References: <20230810135007.3834770-1-shaozhengchao@huawei.com>
In-Reply-To: <20230810135007.3834770-1-shaozhengchao@huawei.com>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, j.vosburgh@gmail.com, andy@greyhouse.net,
 weiyongjun1@huawei.com, yuehaibing@huawei.com, liuhangbin@gmail.com,
 vadim.fedorenko@linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 10 Aug 2023 21:50:02 +0800 you wrote:
> Do some cleanups in bond driver.
> 
> ---
> v2: use IS_ERR instead of NULL check in patch 2/5, update commit
>     information in patch 3/5, remove inline modifier in patch 4/5
> ---
> Zhengchao Shao (5):
>   bonding: add modifier to initialization function and exit function
>   bonding: use IS_ERR instead of NULL check in bond_create_debugfs
>   bonding: remove redundant NULL check in debugfs function
>   bonding: use bond_set_slave_arr to simplify code
>   bonding: remove unnecessary NULL check in bond_destructor
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/5] bonding: add modifier to initialization function and exit function
    https://git.kernel.org/netdev/net-next/c/e08190ef514f
  - [net-next,v2,2/5] bonding: use IS_ERR instead of NULL check in bond_create_debugfs
    https://git.kernel.org/netdev/net-next/c/57647e6fdf17
  - [net-next,v2,3/5] bonding: remove redundant NULL check in debugfs function
    https://git.kernel.org/netdev/net-next/c/cc317ea3d927
  - [net-next,v2,4/5] bonding: use bond_set_slave_arr to simplify code
    https://git.kernel.org/netdev/net-next/c/a8f3f4b44845
  - [net-next,v2,5/5] bonding: remove unnecessary NULL check in bond_destructor
    https://git.kernel.org/netdev/net-next/c/f5370ba3590d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



