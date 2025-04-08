Return-Path: <netdev+bounces-180160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7B0A7FC6B
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 12:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 999717AACA8
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 10:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1B7267B7D;
	Tue,  8 Apr 2025 10:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wk9VhJuE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BC4267B02;
	Tue,  8 Apr 2025 10:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744108796; cv=none; b=mIm6x2HnUSS/l+END3HBXobOxFCoIxqUPM7sgTPPMDMVgWTJ+oxpStzUWp7q0oWgryc2w3Ziq+S65EQ7M3H5QO1bQPCZwechMlaOf94UH8ATdiz7sjsJDg2/LaJQ3B18DaY2k5wpoSJ2VUSREBgn87N816ZZVgqoGkAA4y3qr5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744108796; c=relaxed/simple;
	bh=plkz3MQ7BX+/KhcbHoMa+ajqqg0T2So5u3ho8UX1XWY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=elsSz/p9OvitzGjzVkJOzi8cSRIhrOGv1AWHTxWMUiFumHgrap/z51cvaZtpYMTSj7pgO+3I7p7008WNHo7JvnD3eIUtNfkpr+rt7wAj09LoEPt63nrC1uI701jxddQLb7SC9/cA9GHKuqXSefXrY1B3LDAZg6Zl57odzhrjzk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wk9VhJuE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5EFC4CEEB;
	Tue,  8 Apr 2025 10:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744108795;
	bh=plkz3MQ7BX+/KhcbHoMa+ajqqg0T2So5u3ho8UX1XWY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Wk9VhJuEOIUVgOXTynT2cMDOvQOoJKCe6+LqoryH/MkIdqpkB1+ltLjusrLhjaK8+
	 8cpM9hBLMWP4VFkHNtvgzYNxT/k8cJKPMl001qqLVSnU/0GA+0Lh3NcfXOqeH299Q4
	 vCzT/thPjIOHOoKy1tYBWy9OpCY9n82to4PK17MxRWaxARR4wzTm62E49LdbRIrie9
	 sx8fF3vcqNcU32Otq3UJrNrllNRvRWPZ6iw7MazhFZjmrlR4kFralkPASBnN+v3hJg
	 5sY87IoGWAVM5OF2JQEPRLx/rW4ybABjsWTIZLhN8dMt1zbgjqFPMz1ieqzAovATkK
	 p3IWs9FfNjpIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713AD38111D4;
	Tue,  8 Apr 2025 10:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH] octeontx2-pf: qos: fix VF root node parent queue index
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174410883327.1866615.2642781055524417737.git-patchwork-notify@kernel.org>
Date: Tue, 08 Apr 2025 10:40:33 +0000
References: <20250407070341.2765426-1-hkelam@marvell.com>
In-Reply-To: <20250407070341.2765426-1-hkelam@marvell.com>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 bbhushan2@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, naveenm@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 7 Apr 2025 12:33:41 +0530 you wrote:
> The current code configures the Physical Function (PF) root node at TL1
> and the Virtual Function (VF) root node at TL2.
> 
> This ensure at any given point of time PF traffic gets more priority.
> 
>                     PF root node
>                       TL1
>                      /  \
>                     TL2  TL2 VF root node
>                     /     \
>                    TL3    TL3
>                    /       \
>                   TL4      TL4
>                   /         \
>                  SMQ        SMQ
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-pf: qos: fix VF root node parent queue index
    https://git.kernel.org/netdev/net/c/b7db94734e78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



