Return-Path: <netdev+bounces-29758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BE7784957
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 20:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A433F2811A5
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 18:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4A41DDE1;
	Tue, 22 Aug 2023 18:20:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A1C1D2F9
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 18:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B66FC433C9;
	Tue, 22 Aug 2023 18:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692728423;
	bh=C1pqjOji5dbhWyQPts8YZ0FiD5Zi7ocA9kgmdx+ppTg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qE+VPYL3eXVMo5EOBF1p7ZIGCLXJTVLhHSuGL0SFx08VFqpyJ69TeGKs2AffePVEk
	 Hmua0l2T+CipGrRCWpYc+1RRW+YYIFekLHx1d4/QD6YlX2Pf5wZUjgrCULUTe9iLlS
	 /ctQwDJyPyu/EM+OhZKn0FNgHyER60Jdd21ECU7ESonjMQg4EXcJ9ILGjmWF3D8hAr
	 CtVYJzppa7501XrBRYfz0dUUc60S8kHoM9eWBZ5lhwTCredjxjN0um5Qe+xTuyalTG
	 bCnzf+CaMjTkL+l2wEAzQ/YoUK0r7/WjLzhVcKWsr5PrdLX7tbc/ooPR/XVyM9XWqY
	 sulBfC4TeQerQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5BB61C595CE;
	Tue, 22 Aug 2023 18:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sfc: allocate a big enough SKB for loopback selftest
 packet
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169272842337.23867.1886199095677767522.git-patchwork-notify@kernel.org>
Date: Tue, 22 Aug 2023 18:20:23 +0000
References: <20230821180153.18652-1-edward.cree@amd.com>
In-Reply-To: <20230821180153.18652-1-edward.cree@amd.com>
To:  <edward.cree@amd.com>
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, ecree.xilinx@gmail.com,
 netdev@vger.kernel.org, habetsm.xilinx@gmail.com, andy.moreton@amd.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Aug 2023 19:01:53 +0100 you wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Cited commits passed a size to alloc_skb that was only big enough for
>  the actual packet contents, but the following skb_put + memcpy writes
>  the whole struct efx_loopback_payload including leading and trailing
>  padding bytes (which are then stripped off with skb_pull/skb_trim).
> This could cause an skb_over_panic, although in practice we get saved
>  by kmalloc_size_roundup.
> Pass the entire size we use, instead of the size of the final packet.
> 
> [...]

Here is the summary with links:
  - [net] sfc: allocate a big enough SKB for loopback selftest packet
    https://git.kernel.org/netdev/net/c/6dc5774deefe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



