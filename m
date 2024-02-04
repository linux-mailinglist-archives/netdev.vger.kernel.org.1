Return-Path: <netdev+bounces-68928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2750D848E23
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 14:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 948AC1F22504
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 13:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78D6224FA;
	Sun,  4 Feb 2024 13:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuPESfVi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15B9224E4
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 13:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707054026; cv=none; b=ajfSQ6gW26OmYGRoNAiBEkt4aixN6fnTS/VmWYqnCg4ZX4aaSqoC2xJvlKf77kPi9dJ55AzS5RJtBPG8mJisXG5+swk7AlslsnnHnYXIoOwz+GUXJb2wptPUgPxV299GQF4dSXCJwOTO9BE6CO5aBD2XGZJCDEOyFmVqfPjrrEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707054026; c=relaxed/simple;
	bh=MadHqkVyeM/YJgRXrnBai2otsbDMDP189B7WCqWKGhk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m4drbE/ZyuXke/ZFMyKwUQdBykNbwmNdPDF7t2XJlA4Dw4gbMsnEzGmea6CNJwo8KNfGKpGxwaq/KzkXEOtFNM+OKAcbRBQ+nEOXE8e/+TsbxycRgbskNRkZ3t7Gpw4bhNi/OYAixyvY+HgEm1POJNnLlc6n701oW20xly+SFEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuPESfVi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F12AC433B2;
	Sun,  4 Feb 2024 13:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707054026;
	bh=MadHqkVyeM/YJgRXrnBai2otsbDMDP189B7WCqWKGhk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BuPESfVigWFtoqK/jLRil3sb9MfEigMpRhz2x4vS14+K0DZXmvmxAHq723/sWz6yQ
	 PXO3Z46qBlYCacCECjfAmST/OTCQEIy9qXo4ycy/nMpvJN3g8SX6K3n1l6D2BN+2fG
	 uhl/f0HxP6zvA9Ev1+sW3hc+/flBkmNpAfhoGIiqgJupUxL8+FFhB+9BuXU3hg4s7n
	 vxghcFTb2xVWWcB6IlfQspOyv7YrxCU/du+H68DBc0F1WO0Xs3VNtR1Mq2hbjy3EvT
	 MVVQxw5MiqlPxcyqkug82OnUQgIf4EUaShkDe1ScgC4dWZNBz74UQmZNGxvzYco5zC
	 RxtxvwXgsk5gw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4264EE2F2F3;
	Sun,  4 Feb 2024 13:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: add support for RTL8126A
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170705402626.16095.1642488959165467062.git-patchwork-notify@kernel.org>
Date: Sun, 04 Feb 2024 13:40:26 +0000
References: <c2eaaf79-600a-4162-b439-8dbd7e7033fd@gmail.com>
In-Reply-To: <c2eaaf79-600a-4162-b439-8dbd7e7033fd@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, pabeni@redhat.com, edumazet@google.com,
 davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 1 Feb 2024 22:38:01 +0100 you wrote:
> This adds support for the RTL8126A found on Asus z790 Maximus Formula.
> It was successfully tested w/o the firmware at 1000Mbps. Firmware file
> has been provided by Realtek and submitted to linux-firmware.
> 2.5G and 5G modes are untested.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] r8169: add support for RTL8126A
    https://git.kernel.org/netdev/net-next/c/3907f1ffc0ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



