Return-Path: <netdev+bounces-20735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B58B760D03
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 10:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA26E281844
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 08:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22397E5;
	Tue, 25 Jul 2023 08:30:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E7E21501
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 08:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00B06C433C9;
	Tue, 25 Jul 2023 08:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690273828;
	bh=JFrJ4nSKyL1Po2pXxouc7d+HenWHpFKgiTP5aMROtZs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TGiFXIG2tRRnLiXiHCILxnYg0DGWYmQy04/lLbL3KtGUwumtau6KTm05su23LIAxm
	 hULgAiSCdFjUvSKmHvoJeh6e5FvcwSSbxvY/7Mmy4/4GBwBhnaJu18cqH1y/3Pr0Ad
	 klPnCSMhoxWZtq9SOkMCgQ2YI2E7epD/GofYjiVXg96QPbPrpgyS1GJh77mDAQFkpL
	 zpkr1SqRUDqtEa1q9ALH6uxX/G35Ub6tJlS9S4dHFHRjB2eFL30GR9wXx6jzlkFn+D
	 g9UuBvfPRa4CRMkTgY00Q1vtZULJgQiY3BAGd/MvWqVWU4QGy0Ei0QGC5C6f/DdzvV
	 NN2znfgc6iX6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D65F1C73FE2;
	Tue, 25 Jul 2023 08:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH V4] octeontx2-af: Fix hash extraction enable configuration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169027382787.932.8358430107229778836.git-patchwork-notify@kernel.org>
Date: Tue, 25 Jul 2023 08:30:27 +0000
References: <20230721061222.2632521-1-sumang@marvell.com>
In-Reply-To: <20230721061222.2632521-1-sumang@marvell.com>
To: Suman Ghosh <sumang@marvell.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lcherian@marvell.com, jerinj@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 21 Jul 2023 11:42:22 +0530 you wrote:
> As of today, hash extraction support is enabled for all the silicons.
> Because of which we are facing initialization issues when the silicon
> does not support hash extraction. During creation of the hardware
> parsing table for IPv6 address, we need to consider if hash extraction
> is enabled then extract only 32 bit, otherwise 128 bit needs to be
> extracted. This patch fixes the issue and configures the hardware parser
> based on the availability of the feature.
> 
> [...]

Here is the summary with links:
  - [net,V4] octeontx2-af: Fix hash extraction enable configuration
    https://git.kernel.org/netdev/net/c/4e62c99d71e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



