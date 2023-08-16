Return-Path: <netdev+bounces-27881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A8C77D826
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 04:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F351028166E
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 02:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEF23D6A;
	Wed, 16 Aug 2023 02:10:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B6A17E8
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 02:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9282FC43395;
	Wed, 16 Aug 2023 02:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692151822;
	bh=i9UBZP77nwo11kSF5avIYkwJ7Z2dtioOGIPL87SSzqA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Cmg8QVwcPk+CBuZJGBBMMafsnqdXcRcjZjBxzzTS03qwoEEivWLU4eQqDTZ9I+Lds
	 ULeyXtbsle44xpETSX39BW/4Fbvyc1kECFCX7x43ckMQk2SAYJkm8BoWMCjJKhFMGi
	 mwMRP9zqHSwtBy2Vdk/nPLEO/x0FHU58EMRVG7X22H/o2cos2fiF0h9GmBlB72HcVJ
	 VnM1+04SceLfmrQwF+Qxgzqqq76B43f3cj4ZZUhmymVnmfeaLOFLybJ7mc3zkYRYME
	 3+JL19o390qACnqZoznZ99luqkXVidmFzFTDp5fnuEsdf1v5PsSMwFmjmqxgUEnz7c
	 6XUUAC5VhmqZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7DB5FC39562;
	Wed, 16 Aug 2023 02:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] eth: r8152: try to use a normal budget
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169215182251.21752.7218487312283712460.git-patchwork-notify@kernel.org>
Date: Wed, 16 Aug 2023 02:10:22 +0000
References: <20230814153521.2697982-1-kuba@kernel.org>
In-Reply-To: <20230814153521.2697982-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, mario.limonciello@amd.com, hayeswang@realtek.com,
 bjorn@mork.no, linux-usb@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Aug 2023 08:35:21 -0700 you wrote:
> Mario reports that loading r8152 on his system leads to a:
> 
>   netif_napi_add_weight() called with weight 256
> 
> warning getting printed. We don't have any solid data
> on why such high budget was chosen, and it may cause
> stalls in processing other softirqs and rt threads.
> So try to switch back to the default (64) weight.
> 
> [...]

Here is the summary with links:
  - [net-next] eth: r8152: try to use a normal budget
    https://git.kernel.org/netdev/net-next/c/cf74eb5a5bc8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



