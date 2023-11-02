Return-Path: <netdev+bounces-45653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B09E07DEC7C
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 06:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DCF52819AE
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 05:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C49846BF;
	Thu,  2 Nov 2023 05:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzskejKg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0FE1FDC;
	Thu,  2 Nov 2023 05:51:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D71FC433CB;
	Thu,  2 Nov 2023 05:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698904287;
	bh=6PFxVLswfSZ3JhClx8F3JtGpyqukEQDnjfW7XXnWEPY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hzskejKg1jljo9XwFvbq+PBwrT/4RscMFdc4IM6fRSKNvIaH1yU5tqN3cyyGz5U23
	 EF5eZH0wOU+fcZFVuwQVFrzAC+k7pD20iNjx74ZZcP9BPD4aPKxe82/wbpmJVkusR3
	 3XAD3MaIhxY4WA16Dplb1wQzkeQ2Re36mLz8hWpwXwr40/2E/URqiYzIJXSy2bBaEv
	 frISc2olZfGfjy/bwZph7J8n4PAuWs2ZHxn6YHOR8QUTJ+/hr2YXZG6BlAXmcgq/2F
	 tUrWYdn41he199cIc3erv3jTUHjiX4wZWWOa4exfMqdkNjvkOAWkwV0iZ28EpkzMV5
	 +rps/QBmG85kQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7EDF4E00093;
	Thu,  2 Nov 2023 05:51:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/tcp_sigpool: Fix some off by one bugs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169890428751.30377.4643015567499339552.git-patchwork-notify@kernel.org>
Date: Thu, 02 Nov 2023 05:51:27 +0000
References: <ce915d61-04bc-44fb-b450-35fcc9fc8831@moroto.mountain>
In-Reply-To: <ce915d61-04bc-44fb-b450-35fcc9fc8831@moroto.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: 0x7f454c46@gmail.com, edumazet@google.com, davem@davemloft.net,
 dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 Steen.Hegelund@microchip.com, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 31 Oct 2023 12:51:09 +0300 you wrote:
> The "cpool_populated" variable is the number of elements in the cpool[]
> array that have been populated.  It is incremented in
> tcp_sigpool_alloc_ahash() every time we populate a new element.
> Unpopulated elements are NULL but if we have populated every element then
> this code will read one element beyond the end of the array.
> 
> Fixes: 8c73b26315aa ("net/tcp: Prepare tcp_md5sig_pool for TCP-AO")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net] net/tcp_sigpool: Fix some off by one bugs
    https://git.kernel.org/netdev/net/c/74da77921333

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



