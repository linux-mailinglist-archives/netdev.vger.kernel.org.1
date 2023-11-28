Return-Path: <netdev+bounces-51667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD927FB9ED
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 13:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51AC21C21357
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 12:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847FC4F8B2;
	Tue, 28 Nov 2023 12:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSOqEpRR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689F34F883
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 12:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD691C433CA;
	Tue, 28 Nov 2023 12:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701173425;
	bh=fDerBEX4zImSKW/ua5l6Viri3OLzLkv7oCfJ+wrhFT0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sSOqEpRR35V8NfbnIb5hkmDYaJtaxJhOrrdLQDUdLy2kxguOhroKGTWPm0kQrg3FS
	 To41ugBuASVaeu7jW5lHU0HOfhIX6wnHGZ62wcdd62vO/ljM9sK2f4tu4yPqKuz1RP
	 Tvpi7zVnePz9e29NqBSBPhlCYzoY8eWHsbCyXm60lHeoi14Z7k1a195uywRJn8QcdD
	 Evj+B3wQkjDlyb7KDFKEyKvtFNz1g922zsDjciQl7TTr5/OEY767246lzwnjJZ/74/
	 KxcjHGsA3MlY+TxKxT7IUNs5UjWOqEFqOcSqvHHY32Otf+5Ul91mhCF1C2JjkSfP95
	 UkbmAkbX/q93w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C67D0C39562;
	Tue, 28 Nov 2023 12:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] r8169: fix deadlock on RTL8125 in jumbo mtu mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170117342581.12571.18238973381273183418.git-patchwork-notify@kernel.org>
Date: Tue, 28 Nov 2023 12:10:25 +0000
References: <caf6a487-ef8c-4570-88f9-f47a659faf33@gmail.com>
In-Reply-To: <caf6a487-ef8c-4570-88f9-f47a659faf33@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 free122448@hotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 26 Nov 2023 19:36:46 +0100 you wrote:
> The original change results in a deadlock if jumbo mtu mode is used.
> Reason is that the phydev lock is held when rtl_reset_work() is called
> here, and rtl_jumbo_config() calls phy_start_aneg() which also tries
> to acquire the phydev lock. Fix this by calling rtl_reset_work()
> asynchronously.
> 
> Fixes: 621735f59064 ("r8169: fix rare issue with broken rx after link-down on RTL8125")
> Reported-by: Ian Chen <free122448@hotmail.com>
> Tested-by: Ian Chen <free122448@hotmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] r8169: fix deadlock on RTL8125 in jumbo mtu mode
    https://git.kernel.org/netdev/net/c/59d395ed606d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



