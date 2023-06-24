Return-Path: <netdev+bounces-13748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A7873CD31
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 00:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D91372810F7
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 22:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACA6DDDD;
	Sat, 24 Jun 2023 22:10:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC0FEAFA
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 22:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BFA51C433C8;
	Sat, 24 Jun 2023 22:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687644626;
	bh=Af1wluoPesxzfC6tKSmwNEv1detWSwXXYbav1TrsDwA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mh/fzCZcwqpyIeqjker9f2jPAVerk0DNhYcqeTejx//Fd3adpYJZPYA3REXj4jw2Z
	 e8Chl6qu+5m9z9wym14l6m3te9WoAQkPi/8qAl8jpKO3QpBfnu229OV9rrVxxCq1TG
	 2Ns2hK/IGLSIGRigP95uS9CtJXERnm+xRIgDOMb30Alot5Xc1hYzmjdl1FFD6Kon1N
	 bflR1fXCpkHCgsGzyc/C1KHHF5mt2Q2uJHHdjoT130t2fk+zj0TZ+5t+7YWUT5hrND
	 dl8i1AAmylMO/ud2zhYABP0TKTEjU5lui0WrV/pAYHQRyrRLOFVaKYj+XQyphZXQMN
	 UIt4OA4yBg3fA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A4544C395F1;
	Sat, 24 Jun 2023 22:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: phy: broadcom: drop brcm_phy_setbits() and
 use phy_set_bits() instead
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168764462666.18414.17822935967545944021.git-patchwork-notify@kernel.org>
Date: Sat, 24 Jun 2023 22:10:26 +0000
References: <20230622184721.24368-1-giulio.benetti@benettiengineering.com>
In-Reply-To: <20230622184721.24368-1-giulio.benetti@benettiengineering.com>
To: Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc: f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 simon.horman@corigine.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Jun 2023 20:47:21 +0200 you wrote:
> Linux provides phy_set_bits() helper so let's drop brcm_phy_setbits() and
> use phy_set_bits() in its place.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> ---
> V1->V2:
> * fix code style and add branch net-next to subject as suggested by Simon
>   Horman
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: phy: broadcom: drop brcm_phy_setbits() and use phy_set_bits() instead
    https://git.kernel.org/netdev/net-next/c/28e219aea0b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



