Return-Path: <netdev+bounces-41611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE477CB717
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 01:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B8581C209AE
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 23:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D91F38FB9;
	Mon, 16 Oct 2023 23:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGg0wTDy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D50630D1A
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 23:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1B33C433C9;
	Mon, 16 Oct 2023 23:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697499624;
	bh=yAE3WCFOI0yZilWtjGaUmPJMyDPKdTzBz1qnAUBk1sw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OGg0wTDygQcdc2yqeKGX9YoFB9/l2bejjMKfPwnv/NSkWkrdZbHYTAN2xw9EgPlXL
	 zSAJDBcjidkyxLMkAtycSL4afWm6NBHYtZPVhoFPolrCRqa5otceqSqhOuuYAN76MO
	 r6qgGbBOFzK191o0RX7GZW9Lly8SOCRkQ3q7JwQngOiKgKbYz2+rMZ/7Big9E1uJjD
	 GBeilFKSjjTKqMCR03AjBXm3p3b0RtfGLm+da2M4CroOX+hVrRhXyItzckmMoZ15hA
	 gdbqH9NEWofCKx3+uwBmz21hZnE0EwaoHydXp5vZsGtcHtE5fC8BDg12NCYReh2K4t
	 1xZfJtTxhJNRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 96638E4E9B6;
	Mon, 16 Oct 2023 23:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/smc: return the right falback reason when prefix
 checks fail
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169749962461.28594.523885663724959725.git-patchwork-notify@kernel.org>
Date: Mon, 16 Oct 2023 23:40:24 +0000
References: <20231012123729.29307-1-dust.li@linux.alibaba.com>
In-Reply-To: <20231012123729.29307-1-dust.li@linux.alibaba.com>
To: Dust Li <dust.li@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Oct 2023 20:37:29 +0800 you wrote:
> In the smc_listen_work(), if smc_listen_prfx_check() failed,
> the real reason: SMC_CLC_DECL_DIFFPREFIX was dropped, and
> SMC_CLC_DECL_NOSMCDEV was returned.
> 
> Althrough this is also kind of SMC_CLC_DECL_NOSMCDEV, but return
> the real reason is much friendly for debugging.
> 
> [...]

Here is the summary with links:
  - [net] net/smc: return the right falback reason when prefix checks fail
    https://git.kernel.org/netdev/net/c/4abbd2e3c1db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



