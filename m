Return-Path: <netdev+bounces-19338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E3B75A50D
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 06:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497AC1C21285
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 04:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D502102;
	Thu, 20 Jul 2023 04:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE7D20FE;
	Thu, 20 Jul 2023 04:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79489C433C8;
	Thu, 20 Jul 2023 04:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689826821;
	bh=klxwWjqJHJeqwFDN62FMv3knTJ+VzqfyWcqEIxnjsEw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NK5/gdWiDX3oolaWinZ31qWcpN+N6G9afdEoeTRA+g2HuYqohRdJX9nDXkWcrRFkc
	 FUnlkSSlGCY+lolAmZZTqViDD5L3r0BIl7SKXoDWfh35Wz48aisRy0DADVS+6wsVGi
	 2tI1yze9bY5sZqUGhRTR2vQXQ5Fec8IkhduiLJcy+ytAmGTgFHDSuG2SUpofDyr3sk
	 FCgsWyHOO2AIndlUrZapI3vEaGp9M0bqhRpMFLv1NiY9DMaxvHr72RVgzKgXEfElTz
	 O18fxJpGutC9KUVXJPAwMTTm/xE8ax1smDB5Ix1DhGSNUuq2Sdag+rhZGP1JEeLRAG
	 dUBnmk+MpYVDg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5AC17E21EFE;
	Thu, 20 Jul 2023 04:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] r8169: revert two changes that caused regressions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168982682136.14645.17168208094713450395.git-patchwork-notify@kernel.org>
Date: Thu, 20 Jul 2023 04:20:21 +0000
References: <ddadceae-19c9-81b8-47b5-a4ff85e2563a@gmail.com>
In-Reply-To: <ddadceae-19c9-81b8-47b5-a4ff85e2563a@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: kuba@kernel.org, davem@davemloft.net, nic_swsd@realtek.com,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 regressions@lists.linux.dev

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Jul 2023 13:07:53 +0200 you wrote:
> This reverts two changes that caused regressions.
> 
> Heiner Kallweit (2):
>   r8169: revert 2ab19de62d67 ("r8169: remove ASPM restrictions now that
>     ASPM is disabled during NAPI poll")
>   Revert "r8169: disable ASPM during NAPI poll"
> 
> [...]

Here is the summary with links:
  - [net,1/2] r8169: revert 2ab19de62d67 ("r8169: remove ASPM restrictions now that ASPM is disabled during NAPI poll")
    https://git.kernel.org/netdev/net/c/cf2ffdea0839
  - [net,2/2] Revert "r8169: disable ASPM during NAPI poll"
    https://git.kernel.org/netdev/net/c/e31a9fedc7d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



