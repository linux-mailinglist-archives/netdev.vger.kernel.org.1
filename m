Return-Path: <netdev+bounces-142607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D639BFC3E
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 03:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACA15B22ADD
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 02:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377571DCB2D;
	Thu,  7 Nov 2024 02:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLkZcjsc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0DF1DC745;
	Thu,  7 Nov 2024 02:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944834; cv=none; b=OBVNN49ouwpZDqvCXbtQ/TcbfukPyluZHt2qULV6/apl+YT8cYssOj+lrpoOLYrtkqwDVPwkndjvFcXLWjiMMGtL5qWzigNLCDqlj13IHlx8KnmV3B6dCHgkSZtrBvq3nPat0bDdBuHXvvBXW9R/4PZHaZhvIlgnYpL5c4qy0n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944834; c=relaxed/simple;
	bh=gIQGimrnzc1hsVHg/vIg2XahaK7b3FKSgeEB4kmB2qA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cZ3fkiAZp/y7O9UemGeYzgArR961plYiPiAMaYvh2eDI7QDyuum+3npJITzZQS7Ya/1lkhjvoe+f03rQ/8s76XKUOgJ1FhtL5+yg3EUb8Wph3KrZGE87reDhvzgm6fjqPvFct/rFEObrhsIwAspj+5ny6Z0J4Wn28X8XFFBPPi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLkZcjsc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8608C4CEC6;
	Thu,  7 Nov 2024 02:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730944833;
	bh=gIQGimrnzc1hsVHg/vIg2XahaK7b3FKSgeEB4kmB2qA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fLkZcjscx9afJrvcCV5wKVqrV/ZL4yNOU4mmMh+GjiZewRSs0/do4T2Q1XZad+CwW
	 1i8YqXvRxTIduTQ70lgpO7C13gvY20aYyxyXdW0pT7dqFMhnLcvdt955JzI18kzTXC
	 Ns9cTKSXPP/TbfZCyS9sdZU2hg6e6O7DKlAO9GktFOirW2eiOjTDFfRZ+/fQ8BfkC0
	 OMOeVfDW9m8zMp/Q7ducglyOzeZzH0x16U7D8xmVKnzxWIQ7CKFQobkJj6OuwrlpTx
	 0ZiHKWLMpVopLJyVxrdUq2JbaE4tNl5jSeI6QNo91WVUmZoFSh1lbZsXReFILqeLQ4
	 0t1lBURlbDaLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD943809A80;
	Thu,  7 Nov 2024 02:00:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 net-next] net: bnx2x: use ethtool string helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173094484249.1489169.7860391812406631787.git-patchwork-notify@kernel.org>
Date: Thu, 07 Nov 2024 02:00:42 +0000
References: <20241104202326.78418-1-rosenp@gmail.com>
In-Reply-To: <20241104202326.78418-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, skalluru@marvell.com, manishc@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  4 Nov 2024 12:23:26 -0800 you wrote:
> The latter is the preferred way to copy ethtool strings.
> 
> Avoids manually incrementing the pointer. Cleans up the code quite well.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: handle IS_VF
>  v1: split off from main broadcom patch.
>  .../ethernet/broadcom/bnx2x/bnx2x_ethtool.c   | 68 +++++++++----------
>  1 file changed, 31 insertions(+), 37 deletions(-)

Here is the summary with links:
  - [PATCHv2,net-next] net: bnx2x: use ethtool string helpers
    https://git.kernel.org/netdev/net-next/c/4069dcb7da95

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



