Return-Path: <netdev+bounces-12666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 155BD73865A
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 16:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F70D281459
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 14:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2DF18AEE;
	Wed, 21 Jun 2023 14:10:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0B6182C0
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 14:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19080C433C0;
	Wed, 21 Jun 2023 14:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687356625;
	bh=3WCUOcr5UNscK3AWTclNUDhLVN3+J9o9BqthU//QGdI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QZ2rBM+CNeEZf0Dc9hWyC53QeatBgDD6fMFLu03inGDH2VZJjaOleP21agcMwNimJ
	 NTFYFDLXCA2abpE4WVl7Xw7OY5J99+OYi6jZ6xB9ZbiZF7xT8l1efy/mtPmGhnbIJv
	 5buXcEmsY3NLZKV/hxu1XAz8nYp3KDRX/ZUBPPCK6c/vDyAbXjn5zuR7gBqlNBNjna
	 XJPjTGan3egQmS16PHsDqzTRPTcXIqZQuRLjtwPwpAzIiM/2eyRPfxHF+7a289iC3s
	 SJZZHZrVk1jr1/oSotL6dCWKg4sF3rFtPBswX6tHb6WyvVbwWz+7w5PjJFxRdGTpNl
	 P31VQ+TgZGJOw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA07BC4316B;
	Wed, 21 Jun 2023 14:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: micrel: Change to receive timestamp in the
 frame for lan8841
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168735662495.3443.6450450622724986833.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jun 2023 14:10:24 +0000
References: <20230615094740.627051-1-horatiu.vultur@microchip.com>
In-Reply-To: <20230615094740.627051-1-horatiu.vultur@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 15 Jun 2023 11:47:40 +0200 you wrote:
> Currently for each timestamp frame, the SW needs to go and read the
> received timestamp over the MDIO bus. But the HW has the capability
> to store the received nanoseconds part and the least significant two
> bits of the seconds in the reserved field of the PTP header. In this
> way we could save few MDIO transactions (actually a little more
> transactions because the access to the PTP registers are indirect)
> for each received frame.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: micrel: Change to receive timestamp in the frame for lan8841
    https://git.kernel.org/netdev/net-next/c/cc7554954848

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



