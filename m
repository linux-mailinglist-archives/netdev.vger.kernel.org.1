Return-Path: <netdev+bounces-58339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3DD815E9A
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 12:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC73B283213
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 11:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F60212B7C;
	Sun, 17 Dec 2023 11:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uL2AyEVl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B88912B74
	for <netdev@vger.kernel.org>; Sun, 17 Dec 2023 11:01:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99AECC433C9;
	Sun, 17 Dec 2023 11:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702810919;
	bh=pZbwoYu1x9dSoyYPLsCDp8KSA0hLznjGpDxCDQtbi8E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uL2AyEVl1MNXzLCwJ87m9QiOHzPGJLGk9VWmo4UH/d8hX0i/U/KLlZVF3MF8WCmvS
	 aVZ8ZnlGqDcl7a15dKnITAD9Eb9RScXxp4q+RcCT7F66UMQqL83lz1rpLW6z9qshqM
	 b9Hdqc/NtGNf1GREX1PbU4xwYPyY+iZ3dI5XHxVGmi4G7XQSPCQmPlEFbGtHT3N96A
	 TbghVU42WRV+ep88G4ZBST3lcSKZ/RfczbVsB3U6ut7nsdGvh2Ve7q7ltvTtUA4qfe
	 6QUKn/tQ03y4lJeppa7ougIfIqzTWoYWEsXT/BMeGlMfEWPweatA8YF+CnpT99kuYT
	 eqkWF/6tTpJJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75CA4C4314C;
	Sun, 17 Dec 2023 11:01:59 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v11 0/3] skbuff: Optimize SKB coalescing for page
 pool
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170281091947.1355.12420531280583558242.git-patchwork-notify@kernel.org>
Date: Sun, 17 Dec 2023 11:01:59 +0000
References: <20231215033011.12107-1-liangchen.linux@gmail.com>
In-Reply-To: <20231215033011.12107-1-liangchen.linux@gmail.com>
To: Liang Chen <liangchen.linux@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org,
 linyunsheng@huawei.com, netdev@vger.kernel.org, linux-mm@kvack.org,
 jasowang@redhat.com, almasrymina@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 15 Dec 2023 11:30:08 +0800 you wrote:
> The combination of the following condition was excluded from skb coalescing:
> 
> from->pp_recycle = 1
> from->cloned = 1
> to->pp_recycle = 1
> 
> With page pool in use, this combination can be quite common(ex.
> NetworkMananger may lead to the additional packet_type being registered,
> thus the cloning). In scenarios with a higher number of small packets, it
> can significantly affect the success rate of coalescing.
> 
> [...]

Here is the summary with links:
  - [net-next,v11,1/3] page_pool: halve BIAS_MAX for multiple user references of a fragment
    https://git.kernel.org/netdev/net-next/c/aaf153aecef1
  - [net-next,v11,2/3] skbuff: Add a function to check if a page belongs to page_pool
    https://git.kernel.org/netdev/net-next/c/8cfa2dee325f
  - [net-next,v11,3/3] skbuff: Optimization of SKB coalescing for page pool
    https://git.kernel.org/netdev/net-next/c/f7dc3248dcfb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



