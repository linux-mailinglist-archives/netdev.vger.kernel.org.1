Return-Path: <netdev+bounces-196405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B65AD480B
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 03:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0442E3A9720
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 01:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B59128819;
	Wed, 11 Jun 2025 01:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myqnKGag"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E791012A177
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 01:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749605999; cv=none; b=KT+xotZNZnDLlItzb4+EnY6ZRNLVu/RicBeYimU6E0FdQK/Esex+WqWozVqcVlDw4ZMlqToBICoEIszyYmDeWQ9emaz/h9v8RpSJdBQXiZMBu4ClqRMDSB5ElbgvSFBMorNElMjgxDZTwUZYDMVpkGv1yulGV8ayWNAsNIuGjeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749605999; c=relaxed/simple;
	bh=Bz/sRXFpQ7lHFcfA2/bnaSMfCYG5l2KB657imddWrI4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=izPywbBuMZy9/y7ptgZyq3bOUhMBMUnjbSapSh0xz+M7Xv/04mzUWhkXvRRNOpvomvRntK3xw7phLX4XyU6plaSRMAmTy3nxF2e7w0OgU5DEQKjVqyxNaINfzrlF/ngrJk9jMqI5HGCTA/3k49IBMRRlO1cZJf/dLLDyy1RbKUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myqnKGag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D63C4CEED;
	Wed, 11 Jun 2025 01:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749605998;
	bh=Bz/sRXFpQ7lHFcfA2/bnaSMfCYG5l2KB657imddWrI4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=myqnKGag/LJhx2LvkFJDig+Cf+l5GwrhxfKe0nV5YzDPDazlGq0xQH6pCfy/t5y3o
	 aT2fWpLH7ea2EQQNONG1CMpgr9u/fYoa2liCVT1LcAHHNHb0TQgE5oVHW09edg/JVP
	 jRzKoO3CpLrCBbYWkI3pwDkHufByhZgiYrHN4G8paA7BFpBEc/6xB8s/aUbhL6ldxD
	 WsrUvVqdcOyR3VmjRrQLD9LsbcmpMsIn7O40ZxqzYPWLSZrFbvh5srQLNoeaWRj5b3
	 Zxvc/xXUWp9CM6AARACIYe8NuZ4VE2K0kFKpPBKOTsAuj98anpOBGiBtmmteR7155p
	 sp96SBwi1yO6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE1E39D6540;
	Wed, 11 Jun 2025 01:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: airoha: Enable RX queues 16-31
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174960602875.2765583.13701311047518290024.git-patchwork-notify@kernel.org>
Date: Wed, 11 Jun 2025 01:40:28 +0000
References: <20250609-aioha-fix-rx-queue-mask-v1-1-f33706a06fa2@kernel.org>
In-Reply-To: <20250609-aioha-fix-rx-queue-mask-v1-1-f33706a06fa2@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 09 Jun 2025 22:40:35 +0200 you wrote:
> Fix RX_DONE_INT_MASK definition in order to enable RX queues 16-31.
> 
> Fixes: f252493e18353 ("net: airoha: Enable multiple IRQ lines support in airoha_eth driver.")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_regs.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> [...]

Here is the summary with links:
  - [net] net: airoha: Enable RX queues 16-31
    https://git.kernel.org/netdev/net/c/f478d68b6533

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



