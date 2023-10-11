Return-Path: <netdev+bounces-39944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 454E17C4F49
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 11:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 028E0282609
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 09:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72141D556;
	Wed, 11 Oct 2023 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukh3qSfA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AABA1D52A
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 09:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5775C433CA;
	Wed, 11 Oct 2023 09:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697017226;
	bh=WRT6G5ZYtV7v/9Z+5239GhfTbBtfI5U0mxDqQ61pQMA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ukh3qSfAYF0xgq2fBSjCuB1h+0l3TfswHpzUKwm8fiUTFqzMo8/gNMAKh+buMLHMI
	 RPiLl281OFjDZ0lk8QIiwag512xqgUD6HlGpB4iQPoBOTM95X5IK7z/wIbqDtSuI4h
	 0Bgla0gA7qw4VZ8leWrpktqLIpHOKjkC+VkD/X70YN0JLfppBaQU7y28LR1a/R7ACd
	 qP5jEflq23S0pnXx06ZuWpl5pMFVnZlcfKoFyLwngDiTrUq6WvJOwayszbU294o30s
	 EGLKwT5KBakIn6tQsuTs9j7fc7832VPAS83ULAPld4+virqnhBce2yDbWyCsR8jkos
	 4wzWuDzFsBYcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7F57C595C4;
	Wed, 11 Oct 2023 09:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] nfp: flower: avoid rmmod nfp crash issues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169701722681.1947.9222553022108785688.git-patchwork-notify@kernel.org>
Date: Wed, 11 Oct 2023 09:40:26 +0000
References: <20231009112155.13269-1-louis.peens@corigine.com>
In-Reply-To: <20231009112155.13269-1-louis.peens@corigine.com>
To: Louis Peens <louis.peens@corigine.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 yanguo.li@corigine.com, netdev@vger.kernel.org, stable@vger.kernel.org,
 oss-drivers@corigine.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  9 Oct 2023 13:21:55 +0200 you wrote:
> From: Yanguo Li <yanguo.li@corigine.com>
> 
> When there are CT table entries, and you rmmod nfp, the following
> events can happen:
> 
> task1：
>     nfp_net_pci_remove
>           ↓
>     nfp_flower_stop->(asynchronous)tcf_ct_flow_table_cleanup_work(3)
>           ↓
>     nfp_zone_table_entry_destroy(1)
> 
> [...]

Here is the summary with links:
  - [net] nfp: flower: avoid rmmod nfp crash issues
    https://git.kernel.org/netdev/net/c/14690995c141

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



