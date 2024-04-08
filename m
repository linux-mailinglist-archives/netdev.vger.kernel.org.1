Return-Path: <netdev+bounces-85765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B723A89C0CE
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 15:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4EB5B26F80
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 13:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E751671B20;
	Mon,  8 Apr 2024 13:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XW2GYNLA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49077173E
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 13:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581829; cv=none; b=itGMP06YJ3w1TREXrCyJ9QCjtTVHjAge2fMxr8ptV+NwtvBbj6pVWFVmhHxXnZKQWqnQsH+3YBTSK/C5UKD7KBcJszl3z0XnsGzmPAumvZ7sw57l6PVLuSPxlg/AJiI/Lq7ZHWY8D7Rg4fA7YqnjTRSdvJDOOn3up4qxu+avIsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581829; c=relaxed/simple;
	bh=94C6+G1zDPMgZaYNLGAZ2TB6IIE8Qvg489s3XjxyGkk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VZY3POF2i8hJBGNVH+FRU8l0cupsK9HeyshY0lrWbFTr4u4UxZ+mNzYHu/7C15hLa04sjRYoRdvL31+OiDoW27HAX1w+GHFWuG4AJLGdPpeX5W98bSXxs8iXx7afCoMwfdirs6K7QrUn0qR4t531Pu3VhiZVCTSOz1EdXx9KZbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XW2GYNLA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A334DC433A6;
	Mon,  8 Apr 2024 13:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712581829;
	bh=94C6+G1zDPMgZaYNLGAZ2TB6IIE8Qvg489s3XjxyGkk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XW2GYNLAzDuUJXDf5WDxxlmdOqmkVDOoX2zQ5dLbX58i420uyC2dVu+uAs/ElASfN
	 uMlrVLzGizGX+FXkV7SDMftVdctKZn+oZYJStJqYVG3USeSCdgAGKPOcHaAEaRX2Ny
	 04ZsY3/cr0IyvGcXQ5HRkVB92rRBR1nogdMTgTRQevGt9PetqPof33LNwISMcZIWCJ
	 duGsMuQo5K3SlQ6Y2FCndR87qNMg9yp+dJvav0JERoJ21foaH0L9vkFEE5DkopMKxC
	 o2Xgw6RwHVwT/58iLrULq9b6811yL4TYsljT9gYT1NBnVYOUfzM4Ho8Qh993z4oJGR
	 CI3RGnv83YjjQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 92BA4D72A03;
	Mon,  8 Apr 2024 13:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: display more skb fields in skb_dump()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171258182959.9669.7116178764304358673.git-patchwork-notify@kernel.org>
Date: Mon, 08 Apr 2024 13:10:29 +0000
References: <20240407080606.3153359-1-edumazet@google.com>
In-Reply-To: <20240407080606.3153359-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun,  7 Apr 2024 08:06:06 +0000 you wrote:
> Print these additional fields in skb_dump() to ease debugging.
> 
> - mac_len
> - csum_start (in v2, at Willem suggestion)
> - csum_offset (in v2, at Willem suggestion)
> - priority
> - mark
> - alloc_cpu
> - vlan_all
> - encapsulation
> - inner_protocol
> - inner_mac_header
> - inner_network_header
> - inner_transport_header
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: display more skb fields in skb_dump()
    https://git.kernel.org/netdev/net-next/c/4308811ba901

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



