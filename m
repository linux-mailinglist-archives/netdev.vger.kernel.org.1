Return-Path: <netdev+bounces-69691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4DA84C2ED
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 04:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFE14B20EFA
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 03:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC24AF4E2;
	Wed,  7 Feb 2024 03:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMeeF7jx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AE4F9C3
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 03:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707275430; cv=none; b=nGxL20WqzJe7gjkZVtu8r6Cd8SEZcmcrMZMBLa7+TKeY7vaZeLSxPJy1lJy8XxmL2hnKOtqW9R07yKTqqE8bl7XwW5SqmOYk4mcgh+oknAIDzcsjEcrWVJEgnsp3P6HyL4UE3kzxYHKGOQsqKH4hl7zcT6lN823mAyKrCY/W5iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707275430; c=relaxed/simple;
	bh=HbVd9tCcwzXIV2n6NTYcYZVE8vHwIkLuVtvlgsu28F4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iU0xt/KlIxVTcin048haXI+JGpDdxKr1zWC4BEYZYg61jkhCWLuJSvAHOFKAXH3We4Hf2KoEv1h+8TnZKfnSeul4jaAdZGhG4Fc+sxpRcT1HSny5SoR1GNJ0em8qf46UvRwkaCXZ9xeXKPvJMHwbkfU4amACAQqsRVbFyZn0Vkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMeeF7jx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65D65C433C7;
	Wed,  7 Feb 2024 03:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707275430;
	bh=HbVd9tCcwzXIV2n6NTYcYZVE8vHwIkLuVtvlgsu28F4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SMeeF7jxa/YG1/MP9r/Jp4G199xrMuBkTH24gESp0bUUhcTzg0/1lCUzxXP0inGDS
	 JCYMxq5IB9dA3MXNVKBpIC3wIrkYRkahNClxCQKVxFJ9GNiH/OByfC3y3jt28XSMh+
	 ok8ilv9+WjlmMwKxOFu1QqjK3IpzqoPKHU8DB92c1kVf4UB23RBH/DL66+FAEwVmyl
	 x4yoTsG9BfmXhb2IcNYqq0RWiECZREDdtBw3euTU6Yeo/4L+tCKCJp+73GFI8yLm85
	 M5qbs+h+vhp5eNBO9ShHa//omiiKrXDhXryE1Qfz/ATv/YFgz/+nrv6uXMv/NMrTB1
	 9mp8htXEofg3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41460E2F2F9;
	Wed,  7 Feb 2024 03:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: phy: add and use helper
 phy_advertise_eee_all
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170727543025.7995.3694755537186077085.git-patchwork-notify@kernel.org>
Date: Wed, 07 Feb 2024 03:10:30 +0000
References: <0d886510-b2b7-43f2-b8a6-fb770d97266d@gmail.com>
In-Reply-To: <0d886510-b2b7-43f2-b8a6-fb770d97266d@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, linux@armlinux.org.uk, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, nic_swsd@realtek.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 3 Feb 2024 20:47:53 +0100 you wrote:
> Per default phylib preserves the EEE advertising at the time of
> phy probing. The EEE advertising can be changed from user space,
> in addition this helper allows to set the EEE advertising to all
> supported modes from drivers in kernel space.
> 
> v2:
> - extend kernel doc description of new function
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: phy: add helper phy_advertise_eee_all
    https://git.kernel.org/netdev/net-next/c/b64691274f5d
  - [net-next,v2,2/2] r8169: use new helper phy_advertise_eee_all
    https://git.kernel.org/netdev/net-next/c/7cc0187ea252

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



