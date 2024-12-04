Return-Path: <netdev+bounces-148785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B98339E31DE
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 04:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20662B2A5B2
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 03:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0BA13D51E;
	Wed,  4 Dec 2024 03:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+dFUNfT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892C3136658
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 03:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733281824; cv=none; b=OIEwRhebDx8bs1QRgqJyy0HJpyv/yWLlZBUh7khdvHPe6t1jTKchjjJdnkVKXzRg7nJnfaq8vvzMirPPq+LngMPKRaKXC1Ic/HJbNaGKvNncUmTToJoDOmUTeGUJ06s32Nawz+dYqSS/m0CMDdQdIraHxzHOb3zQJZWWjj6n6BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733281824; c=relaxed/simple;
	bh=Qtn3b6VApITf0ZV8C6N8eQcjGLYL6RWTiC9FNkRQRBk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MgKSPKmv2M0PSxDh/rEzD4FvYAlAeQeE9mW+p4R5VUYzqM7eo/Sx9OKX+ne1TE36U5eALbmy+sBfUNUPDmGbENQ0XnaiwQralOMUroEF68u09PKcjnGUBn6muNFxmhwt03fm01uHqo0fMLd500GZ5DC/T4WlTdp4bpZ3mWVDBnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+dFUNfT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128FAC4CEDC;
	Wed,  4 Dec 2024 03:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733281824;
	bh=Qtn3b6VApITf0ZV8C6N8eQcjGLYL6RWTiC9FNkRQRBk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b+dFUNfTwXgngox6TkzHDoC3rbPKrpHcu1w1aS2ovdu/Ynh33ZIYOH3gBBnO4UNf4
	 /hQFpu3LMhtvryH4mIOr4XHHTtUVCC93QKMbJ4RKdhb2wObMxmaxRSBYtL5QRxLS9C
	 P2+LKKgD95YF683DfrjKPWMZ0sBCOscoiLDS0VZ+7l7LQbzrFDfKVhCkFBSXGVoko2
	 TA6eYN89/yN0UlGu7tbThqJ53vAgiaFhKnSNUKpS47HeZBXm22xL847tVMbr8KdhVf
	 r1U+ljXRJghjo/dpKdksu+w1AtQQwTBiCCTLFo35UGliWcw8b4GIBvrm3e3NDQJujB
	 O35uR6KXjP86g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2713806656;
	Wed,  4 Dec 2024 03:10:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: remove unused flag
 RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173328183824.718738.17982508719796709703.git-patchwork-notify@kernel.org>
Date: Wed, 04 Dec 2024 03:10:38 +0000
References: <d9dd214b-3027-4f60-b0e8-6f34a0c76582@gmail.com>
In-Reply-To: <d9dd214b-3027-4f60-b0e8-6f34a0c76582@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 2 Dec 2024 21:14:35 +0100 you wrote:
> After 854d71c555dfc3 ("r8169: remove original workaround for RTL8125
> broken rx issue") this flag isn't used any longer. So remove it.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 3 ---
>  1 file changed, 3 deletions(-)

Here is the summary with links:
  - [net-next] r8169: remove unused flag RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE
    https://git.kernel.org/netdev/net-next/c/2e20bf8cc057

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



