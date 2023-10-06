Return-Path: <netdev+bounces-38457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B61297BB014
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 03:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 468D1282038
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 01:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4981139B;
	Fri,  6 Oct 2023 01:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JT8K7Mgw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63F515B4
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 01:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29191C433CB;
	Fri,  6 Oct 2023 01:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696556426;
	bh=TUFpNkWhorEQXj2yaH9Ncv2Sl60tKWZxHmlW4LCTB7U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JT8K7MgwcZMCWFgW8+2z8pL0Frn5lKBmZqmaAorGCy8wFwrMqbVdRPYQmRUjbB/b1
	 vAi9cL7pqzeBRBHOOI2KTkIWFmUN7YG16ATmzzsY+akxJNgE9QruV7nrTUsTp7qSCE
	 BP8pCh//K+fG/ImWgDon7x8n3CkF+T0VIs7ngivEtjQPO6GiuiXPjUXYh/EyxyW/4x
	 q/Q0CUw9vzt1+1N3g7FXCV5xFrUPFF3tSC8bAG+MxXBgvNB9JqIGwgzek7B84nAM88
	 HGaXSeNwljIccxksdvYwwzNu/odXjJh+BGl3wkDh9Ql4M5yStWoF3OOEfhghE6gl28
	 6IF2fKhfiZvaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0FCC4E632D1;
	Fri,  6 Oct 2023 01:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] Rework tx fault fixups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169655642605.20160.5177963742723021002.git-patchwork-notify@kernel.org>
Date: Fri, 06 Oct 2023 01:40:26 +0000
References: <ZRwYJXRizvkhm83M@shell.armlinux.org.uk>
In-Reply-To: <ZRwYJXRizvkhm83M@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 3 Oct 2023 14:33:25 +0100 you wrote:
> Hi,
> 
> This series reworks the tx-fault fixup and then improves the Nokia GPON
> workaround to also ignore the RX LOS signal as well. We do this by
> introducing a mask of hardware pin states that should be ignored,
> converting the tx-fault fixup to use that, and then augmenting it for
> RX LOS.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: sfp: re-implement ignoring the hardware TX_FAULT signal
    https://git.kernel.org/netdev/net-next/c/e184e8609f8c
  - [net-next,2/2] net: sfp: improve Nokia GPON sfp fixup
    https://git.kernel.org/netdev/net-next/c/5ffe330e40bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



