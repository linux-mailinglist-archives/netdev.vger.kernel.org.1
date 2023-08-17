Return-Path: <netdev+bounces-28579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EADDF77FE43
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 21:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F8E728217B
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 19:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E03168D6;
	Thu, 17 Aug 2023 19:00:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E294D18023
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 19:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DF5CC433C8;
	Thu, 17 Aug 2023 19:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692298825;
	bh=xXkZA/Pua8C1TX3iJ8DyLZtgH5tkMqTPyZaEElD1qx0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KgGFQJk1NI2lZM+SqH3L0shbE/2nZ3rKkKKvBeN70ues2FoLcUFFEGXMH5k8vkr9l
	 RcwzH7UIsiZfkruSEGZ8HYQoNnq9alh4nACJzYbhyP4Jy+bdpVTgD14D8rjVK1boWM
	 +nTX6eQEaYOO85SlDc15Ag7J5ERzOgkFxABBguom7y31PMrD7KX6L5xZ436QVlJAMm
	 6fUFVgZ1F5RH7NE292umYlWZZi3Jmz5XvmFDAmVGgA2AYKgDRgXYsIhgSGtSuBKZiO
	 WJrAt62oBihvFnop3+aGypVxqqEmMdyakR5Ek50ikCR++7THR5/M0FSv1Lzk00mYRN
	 gCxC5djnShYbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 20164C395C5;
	Thu, 17 Aug 2023 19:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] qede: fix firmware halt over suspend and resume
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169229882512.13479.11029444161932633540.git-patchwork-notify@kernel.org>
Date: Thu, 17 Aug 2023 19:00:25 +0000
References: <20230816150711.59035-1-manishc@marvell.com>
In-Reply-To: <20230816150711.59035-1-manishc@marvell.com>
To: Manish Chopra <manishc@marvell.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, aelior@marvell.com,
 palok@marvell.com, njavali@marvell.com, skashyap@marvell.com,
 jmeneghi@redhat.com, yuval.mintz@qlogic.com, skalluru@marvell.com,
 pabeni@redhat.com, edumazet@google.com, horms@kernel.org, davem@davemloft.net

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Aug 2023 20:37:11 +0530 you wrote:
> While performing certain power-off sequences, PCI drivers are
> called to suspend and resume their underlying devices through
> PCI PM (power management) interface. However this NIC hardware
> does not support PCI PM suspend/resume operations so system wide
> suspend/resume leads to bad MFW (management firmware) state which
> causes various follow-up errors in driver when communicating with
> the device/firmware afterwards.
> 
> [...]

Here is the summary with links:
  - [v3,net] qede: fix firmware halt over suspend and resume
    https://git.kernel.org/netdev/net/c/2eb9625a3a32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



