Return-Path: <netdev+bounces-34344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0B57A35AE
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 15:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBDB41C2090E
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 13:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D884A23;
	Sun, 17 Sep 2023 13:30:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD4B3C35
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 13:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 715C0C433C7;
	Sun, 17 Sep 2023 13:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694957427;
	bh=pF02AHZ82eZiKHq52bV+zJKRphKfFVcJLjrf21UaCeo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BrmbLoepHO6JfjEOo1mQBGS3OEmH66r61AI6ma0yZtnmN5jSd77WaVn9heLe4WDoI
	 Kd0JWFgN4PTgmBLHIFJatONcH7rBr1tC5m6oEeOCOy3tVJdyTzCwEVeiqKxoeSyQt9
	 ae+5zKwHlkK5uGGGFIxuaTrfA94J8WPl66RneqaxluEtxnfwfz2cVp3djE4zZjBB26
	 INYdR3iS2jGDSjbYL6zZ2egWultRf+npJL01vPnNUDZNSo0J6QeSMg/KMinQamGAQM
	 Q5RBlmvASG1KkRzo88WeJoiIIGdhunGIwd6pRVmu+PzxlJAWRB0WFKm+UX0a2eY/R6
	 7ywwaqI5rVOwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54E92E26880;
	Sun, 17 Sep 2023 13:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] net: dsa: microchip: Move *_port_setup code to
 dsa_switch_ops::port_setup()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169495742734.23476.17293099132297430994.git-patchwork-notify@kernel.org>
Date: Sun, 17 Sep 2023 13:30:27 +0000
References: <20230914131145.23336-1-o.rempel@pengutronix.de>
In-Reply-To: <20230914131145.23336-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, andrew@lunn.ch, edumazet@google.com,
 f.fainelli@gmail.com, kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com,
 woojung.huh@microchip.com, arun.ramadoss@microchip.com,
 linux@armlinux.org.uk, kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com, petrm@nvidia.com,
 lukma@denx.de

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 14 Sep 2023 15:11:44 +0200 you wrote:
> Right now, the *_port_setup code is in dsa_switch_ops::port_enable(),
> which is not the best place for it. This patch moves it to a more
> suitable place, dsa_switch_ops::port_setup(), to match the function's
> purpose and name.
> 
> This patch is a preparation for coming ACL support patch.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: dsa: microchip: Move *_port_setup code to dsa_switch_ops::port_setup()
    https://git.kernel.org/netdev/net-next/c/152992279e41
  - [net-next,2/2] net: dsa: microchip: Add partial ACL support for ksz9477 switches
    https://git.kernel.org/netdev/net-next/c/002841be134e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



