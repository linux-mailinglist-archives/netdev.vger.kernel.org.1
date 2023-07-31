Return-Path: <netdev+bounces-22952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5655676A2B8
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 23:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F6231C20CD6
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 21:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8616E1E508;
	Mon, 31 Jul 2023 21:30:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDAF1DDE3
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 21:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 938CDC433C7;
	Mon, 31 Jul 2023 21:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690839022;
	bh=pQfRh1ZbEZsm3fYKoQE0zU0UksbypnaUuSQAyKqfye8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iIEPwfFNLDElfyRZotMoFkQJN6ZnIjScqDugB3a3FcrYnnHuDvPZ7rKUDq/L3ch7n
	 kzY4CwUVf4r0NmoDdAKklcQbX+SVPZXTw0thj5Xkw7wKrNzONd2VQYn6P6ms9BRIF7
	 QMQty0AcN7BfSwCBMms3CVShAXYFd3wKUWVNJZjtWS3V6T5fy/qjYFkaF6XXfthAKj
	 b1L9z0s7Nw5I/My0SaZO0jjxdoj9ChDb6IfiZPwjokfhqQjSM92/f6p6QLzWCj5aGk
	 qAMzDMXyYvVo3G99UVtE/v5DsP012IWVA5DtTa0mHQd46gqGeVw86YHyOHiMyhoB6b
	 l0ZYhcsleHPAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6F392C595C0;
	Mon, 31 Jul 2023 21:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ice: Fix RDMA VSI removal during queue rebuild
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169083902244.31832.215608833883581269.git-patchwork-notify@kernel.org>
Date: Mon, 31 Jul 2023 21:30:22 +0000
References: <20230728171243.2446101-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230728171243.2446101-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, rafalx.rogalski@intel.com,
 david.m.ertman@intel.com, shiraz.saleem@intel.com, mustafa.ismail@intel.com,
 jgg@nvidia.com, leonro@nvidia.com, linux-rdma@vger.kernel.org,
 mateusz.palczewski@intel.com, kamil.maziarz@intel.com,
 bharathi.sreenivas@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Jul 2023 10:12:43 -0700 you wrote:
> From: Rafal Rogalski <rafalx.rogalski@intel.com>
> 
> During qdisc create/delete, it is necessary to rebuild the queue
> of VSIs. An error occurred because the VSIs created by RDMA were
> still active.
> 
> Added check if RDMA is active. If yes, it disallows qdisc changes
> and writes a message in the system logs.
> 
> [...]

Here is the summary with links:
  - [net] ice: Fix RDMA VSI removal during queue rebuild
    https://git.kernel.org/netdev/net/c/4b31fd4d77ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



