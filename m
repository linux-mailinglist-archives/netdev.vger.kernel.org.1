Return-Path: <netdev+bounces-40927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BFF7C91E5
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 02:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 857801F20F43
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 00:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A545B627;
	Sat, 14 Oct 2023 00:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Svd7mnjp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879EE7E
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 00:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1DC75C433C7;
	Sat, 14 Oct 2023 00:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697244624;
	bh=m3c/MJzzDmjpubIiS2M2FAnFZh5fhMVsI9m3MaOxG/U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Svd7mnjpFg/J0RXC6Om6y66VE+NreFdDcK/g5lz/rVCHC1woyffxlBoH9GZcgXHfY
	 btUaCp1qY9R9O0AIC5Kuay5viYxOhFL3uzkfxSlThn+6joNbCyYQ+fiBDDiqhHw9Kz
	 uIxq6Y0v24g2USM0FE7y8jD6N1FNsAu9GbY2rPYZ3CGkUbBHz73zHvBVcLMBuKG7E4
	 O6oNF9L3EEcUR82SCwdVrSC4+TnIdqVl1PfsgijYBBDF9Pu/7JdPKwS1gYnW391f0/
	 5U9HTEL+k/Q76c0SkIV31+ETtItaMRyfcboFIDCuGxJWJOHpZ/Nbi9vEhAYru8BWw8
	 dE2+JKmTeo3pQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 04639E1F66B;
	Sat, 14 Oct 2023 00:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: fix rare issue with broken rx after link-down
 on RTL8125
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169724462401.2191.2301272788594728307.git-patchwork-notify@kernel.org>
Date: Sat, 14 Oct 2023 00:50:24 +0000
References: <9edde757-9c3b-4730-be3b-0ef3a374ff71@gmail.com>
In-Reply-To: <9edde757-9c3b-4730-be3b-0ef3a374ff71@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, nic_swsd@realtek.com, netdev@vger.kernel.org,
 me@lagy.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Oct 2023 08:51:13 +0200 you wrote:
> In very rare cases (I've seen two reports so far about different
> RTL8125 chip versions) it seems the MAC locks up when link goes down
> and requires a software reset to get revived.
> Realtek doesn't publish hw errata information, therefore the root cause
> is unknown. Realtek vendor drivers do a full hw re-initialization on
> each link-up event, the slimmed-down variant here was reported to fix
> the issue for the reporting user.
> It's not fully clear which parts of the NIC are reset as part of the
> software reset, therefore I can't rule out side effects.
> Therefore apply the fix to net-next only. If no side effects are
> reported, it can be submitted for stable later.
> 
> [...]

Here is the summary with links:
  - [net-next] r8169: fix rare issue with broken rx after link-down on RTL8125
    https://git.kernel.org/netdev/net-next/c/621735f59064

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



