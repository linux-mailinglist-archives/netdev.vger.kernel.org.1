Return-Path: <netdev+bounces-29746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A077848EB
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 20:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787E61C20BB4
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 18:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17BE2B577;
	Tue, 22 Aug 2023 18:00:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D9A14A96
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 18:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72EABC433C7;
	Tue, 22 Aug 2023 18:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692727224;
	bh=VKQu8MHGP7kztFcEb1Co5gp/Wx66+SU5ocn14K/8za4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W42MMPX3TkZa6ws1Brlzj6zZkvs/tuveUKnKpdDr2Z5GoF/xk+EJNYf0DdKtW/9nD
	 MUk2d8TdnkHBdgNumkPbeBhsvh9bQVwkFVV1qYI0izxhO8FoD6ggJp28BH5mhjyE25
	 03W2ni79Pguu470U2daLQ0f2RrLdUV5BHLVRce3jD3IBkPIAgqbFQ7tfcY/ERI4SmN
	 f6vL57KIENYDu/xM+wQdGAbrhZX3xu8BE4De1ZZm/YFEZHa8+pKWTbnNXvEKQeK/sJ
	 YJsqIjQawb/3LLxeUW6dUo/9BtE/GHax8qksl+kG+cUipmGzhpVrKJsbye/v6uTlSs
	 bkPfFAU2EJaIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 570DFE4EAF6;
	Tue, 22 Aug 2023 18:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ionic: Remove unused declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169272722435.9690.9807057336534881696.git-patchwork-notify@kernel.org>
Date: Tue, 22 Aug 2023 18:00:24 +0000
References: <20230821134717.51936-1-yuehaibing@huawei.com>
In-Reply-To: <20230821134717.51936-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, drivers@pensando.io,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Aug 2023 21:47:17 +0800 you wrote:
> Commit fbfb8031533c ("ionic: Add hardware init and device commands")
> declared but never implemented ionic_q_rewind()/ionic_set_dma_mask().
> Commit 969f84394604 ("ionic: sync the filters in the work task")
> declared but never implemented ionic_rx_filters_need_sync().
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net-next] ionic: Remove unused declarations
    https://git.kernel.org/netdev/net-next/c/efa47e80c2bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



