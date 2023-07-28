Return-Path: <netdev+bounces-22208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 707C1766808
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 11:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92AFF1C21760
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 09:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDA910949;
	Fri, 28 Jul 2023 09:00:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB4A10796
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 09:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0CB00C433BB;
	Fri, 28 Jul 2023 09:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690534828;
	bh=nKcg0svSuKF9Vd07SSVz4aGc8zGscXKZz+MjBRE27hA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=apRWyV92bmUuDI3BsIiV4GYnTQ/loEpFHR6YNJ2wYty1jQOKC6QTtMQCl3y8/lZW4
	 MkG/se5iO46tq7Fvmo0Mje0tV2ycTJhQmmkIRf3Wmdw5pCG8QO5hjLuzv0icQzYU+e
	 szQUBgq+SAgrkVQ3arTXavh8XPsBNBRIKlQywFw/f88KPhzcv2O4KUaXQ6Zu06qBcp
	 oNnzi6UXoqffoAMkPHU4dvCo+mMxUeNqVoex3GTIdyug3MVdPfzx2SH0FIpP46QMYc
	 mw3/vV5vxHNvtNNwMQ6KuQS7TxpSe8D1iqwqQoqk9vCBOYOnfeSoaH+4ge2/xjmZ7U
	 xSIrlweIIXBiQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E533FE21EC9;
	Fri, 28 Jul 2023 09:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/11] sfc: Remove Siena bits from sfc.ko
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169053482793.22021.4315305142294339300.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jul 2023 09:00:27 +0000
References: <169045436482.9625.4994454326362709391.stgit@palantir17.mph.net>
In-Reply-To: <169045436482.9625.4994454326362709391.stgit@palantir17.mph.net>
To: Martin Habets <habetsm.xilinx@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, linux-net-drivers@amd.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 27 Jul 2023 11:40:37 +0100 you wrote:
> Last year we split off Siena into it's own driver under directory siena.
> This patch series removes the now unused Falcon and Siena code from sfc.ko.
> No functional changes are intended.
> 
> ---
> 
> Martin Habets (11):
>       sfc: Remove falcon references
>       sfc: Remove siena_nic_data and stats
>       sfc: Remove support for siena high priority queue
>       sfc: Remove EFX_REV_SIENA_A0
>       sfc: Remove PTP code for Siena
>       sfc: Remove some NIC type indirections that are no longer needed
>       sfc: Filter cleanups for Falcon and Siena
>       sfc: Remove struct efx_special_buffer
>       sfc: Miscellaneous comment removals
>       sfc: Cleanups in io.h
>       sfc: Remove vfdi.h
> 
> [...]

Here is the summary with links:
  - [net-next,01/11] sfc: Remove falcon references
    https://git.kernel.org/netdev/net-next/c/806521bc48aa
  - [net-next,02/11] sfc: Remove siena_nic_data and stats
    https://git.kernel.org/netdev/net-next/c/e714e5b24413
  - [net-next,03/11] sfc: Remove support for siena high priority queue
    https://git.kernel.org/netdev/net-next/c/f294c1f7bfbd
  - [net-next,04/11] sfc: Remove EFX_REV_SIENA_A0
    https://git.kernel.org/netdev/net-next/c/958d58bb9940
  - [net-next,05/11] sfc: Remove PTP code for Siena
    https://git.kernel.org/netdev/net-next/c/1c145a5dc370
  - [net-next,06/11] sfc: Remove some NIC type indirections that are no longer needed
    https://git.kernel.org/netdev/net-next/c/a623b3a58a85
  - [net-next,07/11] sfc: Filter cleanups for Falcon and Siena
    https://git.kernel.org/netdev/net-next/c/a847431c5ba5
  - [net-next,08/11] sfc: Remove struct efx_special_buffer
    https://git.kernel.org/netdev/net-next/c/d73e77153b4d
  - [net-next,09/11] sfc: Miscellaneous comment removals
    https://git.kernel.org/netdev/net-next/c/ae9d445cd41f
  - [net-next,10/11] sfc: Cleanups in io.h
    https://git.kernel.org/netdev/net-next/c/b0d1fe9bcdc6
  - [net-next,11/11] sfc: Remove vfdi.h
    https://git.kernel.org/netdev/net-next/c/3771c878b460

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



