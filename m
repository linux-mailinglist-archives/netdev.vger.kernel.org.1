Return-Path: <netdev+bounces-84368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5587E896BC1
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 12:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87C7E1C2107F
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 10:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA86F136E22;
	Wed,  3 Apr 2024 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjrkoHwQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C322E13AA5D;
	Wed,  3 Apr 2024 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712139028; cv=none; b=Ci4WX0Y0uXh3o856gGquKwo3MG6Kdu4yJxhaXNoB90VBCtTyK0Z7bT+23JjgUOLYGMquTgCd8S8PZS5pjgcnrApLAKMlfcDxep/cQz3coCheZ6wx33dYeXaBoIA4Kyz6WJ0LMe63XDDyujg3VubCZYJ5YXfWGRZG4hTTVdUrM9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712139028; c=relaxed/simple;
	bh=9k/ctL/2N8p+CDWoWSVLNO3MphELQWzxRzzNCTnWqQ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BEtEX+aekIFSrQ1RLVQvVZHezSKM1Ln8VL/3/AaYZkMu7o60A21PCOG4ssEmBiKTNa7pxT0X9jl1XX254fUXpCZODksd6RAcjlzmi60aYIMmp/utrY9FnWyfk86++Wkv2RqRfFjbfj6QlHPAqRn5HWv5FJIf4v//t0aWWhGXp48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjrkoHwQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E75BC433C7;
	Wed,  3 Apr 2024 10:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712139028;
	bh=9k/ctL/2N8p+CDWoWSVLNO3MphELQWzxRzzNCTnWqQ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rjrkoHwQ6uFRKZk53Mb/tHvAZK70UANlEH+CMb9Lf8gq37WVhQdBkSvfHWcKQxKC4
	 BfOs/7GFiqkJBuBwwxzWb7dR90Gx1w+gr4VU2/dvcrpvsTggDLbLGztFc7BDCkrDqv
	 6sspkQWv5vNTnER/JwQLqcCcjORbUc2+cLzqVe8WwDgTkG1p8GhjMt0+asFbzAK4W1
	 8Uqz3PrE9Y6dQMfw9KGCZaoL+zxvzjv5iifID39Dgdu+CVjpnd2UXyGJ+8Lzsf6dbF
	 Gshzj3QKIMLisA4I0AwC1R9u7dmCX82VLNGEql9rntHzpuY/n1mnALTxgPG1eFVsO3
	 7Ox0jUOxneAPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3206ED84BB4;
	Wed,  3 Apr 2024 10:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] octeontx2-af: Add array index check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171213902820.4996.18356221177275595089.git-patchwork-notify@kernel.org>
Date: Wed, 03 Apr 2024 10:10:28 +0000
References: <20240328165505.19106-1-amishin@t-argos.ru>
In-Reply-To: <20240328165505.19106-1-amishin@t-argos.ru>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 28 Mar 2024 19:55:05 +0300 you wrote:
> In rvu_map_cgx_lmac_pf() the 'iter', which is used as an array index, can reach
> value (up to 14) that exceed the size (MAX_LMAC_COUNT = 8) of the array.
> Fix this bug by adding 'iter' value check.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 91c6945ea1f9 ("octeontx2-af: cn10k: Add RPM MAC support")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> 
> [...]

Here is the summary with links:
  - [net,v2] octeontx2-af: Add array index check
    https://git.kernel.org/netdev/net/c/ef15ddeeb6be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



