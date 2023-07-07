Return-Path: <netdev+bounces-15952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE96474A8E6
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 04:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7334E280DFB
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 02:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521CD3C26;
	Fri,  7 Jul 2023 02:20:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F9615B6
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 02:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9FBEAC43397;
	Fri,  7 Jul 2023 02:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688696424;
	bh=O60SrJAdQrkyNj4OQ6v4QHzWUm8hH4cwJkZj5houL8k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aR35+of/Cp9VxeTdGu+4J1VNesVcyFZ+15Wc4IxYc5OR1cLbxmNLPTrOyfegkapvc
	 TRaQ7ZQeTBcE3oxklkJcdurVLKH2OcGm5JM/+JY54pf6dxh6o6kUBe7JPj07I2DtmC
	 kJnxEOfBvjUAjGIx8ujEO1I1M9hRAM1Gr/ZXpAx1EKxnF/FkLVPoYnO4Tem6KcPkdS
	 I6WlgFKJQOaiv+EbT6vRITca6uBtXVK6hslCBudrnJgh0rNKMwKxOeTKVAdoU/K+Kc
	 QOaHWxYueq7G8Tp/eO2W9Ld86xnfPCIQdxZhUMFtqefi7CzIrBfIbb4280/ps6s77o
	 MntYz4kxXBN1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7D8DCE29F48;
	Fri,  7 Jul 2023 02:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: cls_fw: Fix improper refcount update leads to
  use-after-free
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168869642451.27656.10599486797276830961.git-patchwork-notify@kernel.org>
Date: Fri, 07 Jul 2023 02:20:24 +0000
References: <20230705161530.52003-1-ramdhan@starlabs.sg>
In-Reply-To: <20230705161530.52003-1-ramdhan@starlabs.sg>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 netdev@vger.kernel.org, ramdhan@starlabs.sg

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  5 Jul 2023 12:15:30 -0400 you wrote:
> From: M A Ramdhan <ramdhan@starlabs.sg>
> 
> In the event of a failure in tcf_change_indev(), fw_set_parms() will
> immediately return an error after incrementing or decrementing
> reference counter in tcf_bind_filter().  If attacker can control
> reference counter to zero and make reference freed, leading to
> use after free.
> 
> [...]

Here is the summary with links:
  - [net] net/sched: cls_fw: Fix improper refcount update leads to use-after-free
    https://git.kernel.org/netdev/net/c/0323bce598ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



