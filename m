Return-Path: <netdev+bounces-79295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5347878A63
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 23:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 828651F21FDE
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 22:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B59557300;
	Mon, 11 Mar 2024 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTbWthIB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF2256B99
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 22:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710194435; cv=none; b=b1D/zFUrAM7kXH0sdJ77PsWNQrJi7xLs7zkOiOtyBMPZ9Bydw1Jk90o0v2O9axhaQgbNqH4NArL3NN3VZqqTtNwrx04RI7wd0hJXo6kZOGAFoHoaGNhY4x5jR8EvUFosVIBu57US5zWcv0mAz2r6h4CMDJ051pYXMGYvfmCP1HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710194435; c=relaxed/simple;
	bh=XCP5e9KCwSpsI2xoCIrXF2AG8/vGJ7eHFDQAvCXWFi4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MfVPCVVaTsn+c9WrU5EDinS2UDyn+IGYNwxdiAlhdRW+dzKkd68VkZktLnKZMTvsmDi22JtrLMx8bfPm41lPPfiWOVyua3pdvur7/iN5YBthw8c2RRtx4DtqzH8hLsVERPSmlqm8HUsypu3xy2KiEUGK2K8pUhvw0bMuwPrdqHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTbWthIB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90334C43399;
	Mon, 11 Mar 2024 22:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710194434;
	bh=XCP5e9KCwSpsI2xoCIrXF2AG8/vGJ7eHFDQAvCXWFi4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eTbWthIBOaND/7PfbHXEoP9U0vIyFqXQE+90v9kdBSWaElp8Yjf5hQxgS3v0gwWvN
	 A6bb46Pr2SXNunJgQYt1Zs5NKvbHq7ecF1ozcrD07fViFxWkxi+QPGNDccH8jlnIJW
	 7yCwKEx3BWfsqYV3kicQ1Xkn1YV0T4UgvIqctdbzrFbxmquw49QcSjUDW7pBNNXwyr
	 x286l45MVNU2GTM6BXorTQQf8p6O7Z2dW+6dDNYbmGgSQ6n55p/ntlpRpAqrlLm7Sv
	 3BPc0oFwOi7jcHy4YzVUiJvmCFr7yH1bTwnGsYu3dDbMVjJutjvuz8bEINkk9K40Pf
	 aez6Hv5oj2fKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 773D9D95057;
	Mon, 11 Mar 2024 22:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: gro: move two declarations to include/net/gro.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171019443448.9697.16788661291494587779.git-patchwork-notify@kernel.org>
Date: Mon, 11 Mar 2024 22:00:34 +0000
References: <20240308102230.296224-1-edumazet@google.com>
In-Reply-To: <20240308102230.296224-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  8 Mar 2024 10:22:30 +0000 you wrote:
> Move gro_find_receive_by_type() and gro_find_complete_by_type()
> to include/net/gro.h where they belong.
> 
> Also use _NET_GRO_H instead of _NET_IPV6_GRO_H to protect
> include/net/gro.h from multiple inclusions.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: gro: move two declarations to include/net/gro.h
    https://git.kernel.org/netdev/net-next/c/e5b7aefe38f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



