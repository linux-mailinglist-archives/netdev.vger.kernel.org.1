Return-Path: <netdev+bounces-38902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9C97BCF49
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 18:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9CE41C2087C
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 16:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979DE156FA;
	Sun,  8 Oct 2023 16:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsnJ7eo1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782C7C2C3
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 16:52:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D19E8C433C9;
	Sun,  8 Oct 2023 16:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696783929;
	bh=XpWAoOiXXqi8yhNSs8TLF1to5sTFQ9pjTT1uSc+d1IA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dsnJ7eo1uxCtIarB3FqPjAmcpWHf3+w8g+RJmojV/aY/O+fQiCINa0DVxW71N0Vra
	 LYl6JxHwovVfSx6WPhpciZbdjh/qZUITdUtNlcuynrZoYtxcRoUMFjczn8pJC9hbXb
	 bPQqAReXoVO8zUndOEez0OnksEC89pPgKYj/cvBYtk6Av1sbKz6MuriKqsRGQb3Jik
	 eBDv/PvS+qYvd30Q/BGfdiAAw/Xu+D0zFPHJsC7VTrZRdksCHoKZxM3sQCfhnkN5bZ
	 w3eMF0P8/EQRLYyeMV9mzXULz+bjIjYv6vps9OxcOdbuPgVdLm2hJ5f7IG9fOY8U46
	 LGTnfNRzElFFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B62E0C64459;
	Sun,  8 Oct 2023 16:52:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: bcmgenet: Remove custom ndo_poll_controller()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169678392974.1974.11968305394752351326.git-patchwork-notify@kernel.org>
Date: Sun, 08 Oct 2023 16:52:09 +0000
References: <20231005181747.3017588-1-florian.fainelli@broadcom.com>
In-Reply-To: <20231005181747.3017588-1-florian.fainelli@broadcom.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, opendmb@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  5 Oct 2023 11:17:47 -0700 you wrote:
> The driver gained a .ndo_poll_controller() at a time where the TX
> cleaning process was always done from NAPI which makes this unnecessary.
> See commit ac3d9dd034e5 ("netpoll: make ndo_poll_controller() optional")
> for more background.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: bcmgenet: Remove custom ndo_poll_controller()
    https://git.kernel.org/netdev/net-next/c/19537e125cc7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



