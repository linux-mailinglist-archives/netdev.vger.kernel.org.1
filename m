Return-Path: <netdev+bounces-25625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BB5774EFF
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 01:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 217BA281995
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 23:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6761BEE4;
	Tue,  8 Aug 2023 23:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F191818035
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 23:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9059AC433CB;
	Tue,  8 Aug 2023 23:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691536220;
	bh=QymEYaE/ocr/oE+yC+MvRgPI3Ed/7/qkFjpw7D1hx6E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bjS3Ef1fMuZKqQP9PNJtZyqDe8TB363XqK5/XpIYacrZkqnyFtirQB8IRpcJn1eeH
	 1s5RhXqjg9XJQCoiiqa+iDwMUgw5LwLv0mFpoKXII35BwqWBBMSI3x9AFa/5bye0J5
	 /lOh/jU1WLY3wAoZTikp0kboTQUCrctusKgCpnl3r7VCgUJniotLqY1/63bdQS0F3p
	 xkazpSWtqq+6d6t1ftPL8xII4v/eSvFPUGUmEzq5Ak28nZv5v5QneMkvo3qstAwL3p
	 0aEgSM8jB0mNr66FD3Oiqref4CthsgGePCqfoNpQ4PPk/GVCrrLqS1vmL7s6f6iZhq
	 a8iMryXd7X28Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73875C595C2;
	Tue,  8 Aug 2023 23:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: fq: Remove unused typedef fq_flow_get_default_t
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169153622046.13310.5606957399763289440.git-patchwork-notify@kernel.org>
Date: Tue, 08 Aug 2023 23:10:20 +0000
References: <20230807142111.33524-1-yuehaibing@huawei.com>
In-Reply-To: <20230807142111.33524-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 7 Aug 2023 22:21:11 +0800 you wrote:
> Commitbf9009bf21b5 ("net/fq_impl: drop get_default_func, move default flow to fq_tin")
> remove its last user, so can remove it.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/net/fq.h | 5 -----
>  1 file changed, 5 deletions(-)

Here is the summary with links:
  - [net-next] net: fq: Remove unused typedef fq_flow_get_default_t
    https://git.kernel.org/netdev/net-next/c/209bccbac9e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



