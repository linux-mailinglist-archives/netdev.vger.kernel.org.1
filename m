Return-Path: <netdev+bounces-48960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A615A7F031E
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 23:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20E40B20981
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 22:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A5B1EA87;
	Sat, 18 Nov 2023 22:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHl2wmcR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648F21A728
	for <netdev@vger.kernel.org>; Sat, 18 Nov 2023 22:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1656C433C9;
	Sat, 18 Nov 2023 22:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700346624;
	bh=mUlMRW77ZXIdBcfFeMEn8+fctNwnLb1qntiNTsDj8dQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tHl2wmcRCNSEhAWAlaUCcppoOYELloRI84e2glOzb6jgx4BEpPwfb3Vgj+UXs2FFv
	 nQF9C4rhtuQR32dIyMeWnVCFqfBPWBF/z1Jpejy3TUnp28inVVjMBU3B2O22K7+5LF
	 8UQVCHtpiH8JRplgp9ITnY4k7dvzi0Z18HdUc3S/abrWG6jNFrDr+tcRmCWIrx5iFl
	 YBhPC0Om3iE1e6tbQNUqKuUTXQ9LMGmMXCPVkgnu4uUuSL7v04AZaTcTtij+SUJ07J
	 CF7VrlVInwuXu25o3fNAwKQP6oEGIrRNGwYewlda/YDAWyyQfl82axGddKTL5cUy3W
	 n5sT/UgEfb4xg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 92DF7EA6300;
	Sat, 18 Nov 2023 22:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: improve RTL8411b phy-down fixup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170034662459.26475.9538826781180678414.git-patchwork-notify@kernel.org>
Date: Sat, 18 Nov 2023 22:30:24 +0000
References: <f1a5f918-e9fd-48e6-8956-2c79648e563e@gmail.com>
In-Reply-To: <f1a5f918-e9fd-48e6-8956-2c79648e563e@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, pabeni@redhat.com, edumazet@google.com,
 kuba@kernel.org, davem@davemloft.net, mirsad.todorovac@alu.unizg.hr,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 13 Nov 2023 20:13:26 +0100 you wrote:
> Mirsad proposed a patch to reduce the number of spinlock lock/unlock
> operations and the function code size. This can be further improved
> because the function sets a consecutive register block.
> 
> Suggested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] r8169: improve RTL8411b phy-down fixup
    https://git.kernel.org/netdev/net-next/c/055dd7511f67

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



