Return-Path: <netdev+bounces-48533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C16247EEB37
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 03:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB9D281138
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 02:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A55469E;
	Fri, 17 Nov 2023 02:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ay0jfgFb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2279C441F
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 02:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94A58C433D9;
	Fri, 17 Nov 2023 02:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700189423;
	bh=XkytwE5OeOaF3AHN/WW2vcDjb88B6z5uDTCuZBrPtdE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ay0jfgFbO1/r/ctHswf54erTI/d/qKftw8Jcf25hrPT38L8NU6EcbSevRFP4D6iRy
	 KcHnJJ85G2vbkrw7CFU9sbRMXlOjR4CXaRnNeoeVARFbEIR3ii+ULkW0XfwH2zNLVp
	 fPOI/D2jhu2EhX/aB7HTK6JN4n1rNBRjxEJCAoFlpdyaRfdTxsiuUohB4ZV1iprYXa
	 0y7b2bOvsXaGBLQEWw9mAs6hH0/DZ5MxCWVKP+9REzdTLsjMKBjuvgRiWLUrruezJh
	 AqnUE8qeIOX+uZBa9mOTl58jQ3GW8V1fDN8a00HYQenKwOmzkGsDlLQXi+Q09n4QZw
	 5umLgDuRivgKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C87BE1F662;
	Fri, 17 Nov 2023 02:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: phy: broadcom: Wire suspend/resume for
 BCM54612E
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170018942350.29552.13239182407636546748.git-patchwork-notify@kernel.org>
Date: Fri, 17 Nov 2023 02:50:23 +0000
References: <20231116193231.7513-1-marcovr@selfnet.de>
In-Reply-To: <20231116193231.7513-1-marcovr@selfnet.de>
To: Marco von Rosenberg <marcovr@selfnet.de>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 16 Nov 2023 20:32:31 +0100 you wrote:
> The BCM54612E ethernet PHY supports IDDQ-SR.
> Therefore wire-up the suspend and resume callbacks
> to point to bcm54xx_suspend() and bcm54xx_resume().
> 
> Signed-off-by: Marco von Rosenberg <marcovr@selfnet.de>
> ---
> Changes in v2:
> - Changed commit message
> - Rebased on commit 3753c18ad5cf
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: phy: broadcom: Wire suspend/resume for BCM54612E
    https://git.kernel.org/netdev/net-next/c/380b50ae3a04

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



