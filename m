Return-Path: <netdev+bounces-24246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F3976F6F8
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 03:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 491A41C21543
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 01:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DDCA4E;
	Fri,  4 Aug 2023 01:30:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82144EA8
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 01:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0A1CC433C7;
	Fri,  4 Aug 2023 01:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691112620;
	bh=xeu6u6diyKYThtdJewA0EcMoqfQS/Oz/v588unjpA4E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bLOu5NCbXOTKFVs/8lk2igTdROpJsiQD+a0B8vib/Gm2hhRMz3Oo76Z10U/XGkV1q
	 rjTL3otkLQAE6FjFmRJbeQKhGuPyoQWbS7pHFNAeBdxb35ot3Snsg9+K7YvEVmGPEI
	 rnT633N49cQo9yuHErV/JC5+p+a+NoQSaNxQUSG+2BH9SoEwQyA5LFXRkRJtM66MIi
	 YkXyi4ps5lO9RbuieeIBqTOujBVM3rT0SmvXQnBpLcReO6uuDcNxf01M2oG+YTa5/m
	 3Kp75vkxzq6L3ROjNfT24fqqZBuXJyHtNffx062QkiIbCT9GN9/InlNAgCjSIMBnSH
	 7jnqW/PqiVn7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9A0DC3274D;
	Fri,  4 Aug 2023 01:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: Space.h: Remove unused function declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169111262075.25155.13359566243110329523.git-patchwork-notify@kernel.org>
Date: Fri, 04 Aug 2023 01:30:20 +0000
References: <20230802130716.37308-1-yuehaibing@huawei.com>
In-Reply-To: <20230802130716.37308-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 2 Aug 2023 21:07:16 +0800 you wrote:
> Commit 5aa83a4c0a15 ("  [PATCH] remove two obsolete net drivers") remove fmv18x_probe().
> And commmit 01f4685797a5 ("eth: amd: remove NI6510 support (ni65)") leave ni65_probe().
> Commit a10079c66290 ("staging: remove hp100 driver") remove hp100 driver and hp100_probe()
> declaration is not used anymore.
> 
> sonic_probe() and iph5526_probe() are never implemented since the beginning of git history.
> 
> [...]

Here is the summary with links:
  - [net-next] net: Space.h: Remove unused function declarations
    https://git.kernel.org/netdev/net-next/c/992725ff32f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



