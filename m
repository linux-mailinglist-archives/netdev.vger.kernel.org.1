Return-Path: <netdev+bounces-16210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2D874BD04
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 11:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7877E2818E2
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 09:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8AB538D;
	Sat,  8 Jul 2023 09:13:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3BD46A5
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 09:13:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA3D1C433CB;
	Sat,  8 Jul 2023 09:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688807594;
	bh=0kGNTdI51iU5Y7scFFen0kYtVbEftrTmchOHCoAUPi8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hxCLOxkLErAjOYb+XnDsOvhr5vXIwBgqkUzyH6YvOMKr0iHg49NciAgxXPEX32AaJ
	 eq4vjVnvg1YU7n2ESMNjp1KxZ1NCxEYb/iFbW9lLYFaEEyqdkXTeXOuNeFl9MLki9F
	 /n3cTqTETQV4uLVsrBT9kaMfeZeBuej/Nn3ATbc9VHkp1QefPq1LU8WLHvcbCdjYh7
	 9gfYxBntYD8HSgGyQrbUdyU/WD96OBCmrnLtui6+4PsWMyq5vjkDpZOr3LY9OEBpXN
	 gzE3IIfIBS0YQdK9qkIGxrdu37duHDkwVn/9v9gj8ps8fa4DMTyn2milRrZZNBe+nj
	 pCF7F9vaEVCcQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CE0BBC73FE1;
	Sat,  8 Jul 2023 09:13:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net.git] net: bgmac: postpone turning IRQs off to avoid SoC
 hangs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168880759383.30427.14656209656761686946.git-patchwork-notify@kernel.org>
Date: Sat, 08 Jul 2023 09:13:13 +0000
References: <20230707065325.11765-1-zajec5@gmail.com>
In-Reply-To: <20230707065325.11765-1-zajec5@gmail.com>
To: =?utf-8?b?UmFmYcWCIE1pxYJlY2tpIDx6YWplYzVAZ21haWwuY29tPg==?=@codeaurora.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, f.fainelli@gmail.com, netdev@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, rafal@milecki.pl

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  7 Jul 2023 08:53:25 +0200 you wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Turning IRQs off is done by accessing Ethernet controller registers.
> That can't be done until device's clock is enabled. It results in a SoC
> hang otherwise.
> 
> This bug remained unnoticed for years as most bootloaders keep all
> Ethernet interfaces turned on. It seems to only affect a niche SoC
> family BCM47189. It has two Ethernet controllers but CFE bootloader uses
> only the first one.
> 
> [...]

Here is the summary with links:
  - [net.git] net: bgmac: postpone turning IRQs off to avoid SoC hangs
    https://git.kernel.org/netdev/net/c/e7731194fdf0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



