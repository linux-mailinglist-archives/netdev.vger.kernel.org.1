Return-Path: <netdev+bounces-137305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B10589A5500
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 18:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01F81C20E46
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 16:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E69197A87;
	Sun, 20 Oct 2024 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="se5R/w7C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA25197A7C
	for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729440638; cv=none; b=op0BHQkWltLncev+iFuvfeqGHujmLijYo4NDllfHC8l81HvT+j9GlY/yMI/Cnbq378QCrOzYiczjsZdNURDcK/qaxeD86JoBAGIUT2tZxb1/ZOW9cMn8+Ox4drcqHwr34uj94tSkt1cV455ag0muAAdRn8sgSnMNOb61hu0ea+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729440638; c=relaxed/simple;
	bh=hhhWcCapoMxcedeEtz1JRQxOxofKjLTS5em6zhXCNGM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tSNWG49IsehVVUXItZtEY+2iOaUXrxVNUVJw1RDxYNomuHdKRcYXm6k87uqOYcxlsjFU3E76tN1Si+0O56f8ffLXXx7j6iJKqHW6jXQGqH3n5lalV1ZW8qWcvD2NtOQGmOeDayki1uPEpQXHAwSKywkqbvSToFEf8JENYPCGNf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=se5R/w7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDB3C4CEC7;
	Sun, 20 Oct 2024 16:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729440637;
	bh=hhhWcCapoMxcedeEtz1JRQxOxofKjLTS5em6zhXCNGM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=se5R/w7CNguNMFC71ujLM+yvw1GnX4nXQbdlTH93LavgiUGbV05rXJ++/b00XrBI1
	 9CfMJ5znmjLyChxptJK8TRvhxZf0uY2AU6Eed9KkGxDKikdSqpwcu3uf5/ANYf+zdf
	 Zqzad0MxzoXQ8fXLA1Z/zhi9s8SsvZuUukqAHwszQXcJIY3s8/4MYwQ8e4+YAVwf9y
	 6YhP19frxc5hf2Qhv0b7MJ+imueoRB1cpvb/Qxiwjqj1CxD3gfUJG5MfRPZ6pIL3l+
	 BIrOqQqrQJTzn/eVoPvYANk9ClauWRRHneWXnvUA6ce7KspSgHZVhL1EwzoXVju11W
	 kbhopd0mKuPnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD9A3805CC0;
	Sun, 20 Oct 2024 16:10:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: remove rtl_dash_loop_wait_high/low
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172944064351.3604255.9055858723876067928.git-patchwork-notify@kernel.org>
Date: Sun, 20 Oct 2024 16:10:43 +0000
References: <fb8c490c-2d92-48f5-8bbf-1fc1f2ee1649@gmail.com>
In-Reply-To: <fb8c490c-2d92-48f5-8bbf-1fc1f2ee1649@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Andrew Lunn <andrew@lunn.ch>:

On Wed, 16 Oct 2024 22:31:10 +0200 you wrote:
> Remove rtl_dash_loop_wait_high/low to simplify the code.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 35 ++++++-----------------
>  1 file changed, 8 insertions(+), 27 deletions(-)

Here is the summary with links:
  - [net-next] r8169: remove rtl_dash_loop_wait_high/low
    https://git.kernel.org/netdev/net-next/c/d64113c6bb5e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



