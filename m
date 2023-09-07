Return-Path: <netdev+bounces-32362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AA2796F74
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 06:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F4632814F8
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 04:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E37EC6;
	Thu,  7 Sep 2023 04:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0E3EA9
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 04:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E174C433C9;
	Thu,  7 Sep 2023 04:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694059222;
	bh=NADXZdSMWL5mBGyP7H8DbhP5et9pbjydx3mogHSjfZI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ixWBjpyOyL/fidDlAQKwflDQv21LcuaSMop0UKFV52oSpjYN8zS5AhfFyJmjmwzxQ
	 Yq+tmDRnRKZGNaGju/3wKfMzM8oIxAuJzLAF0rGadBbsDQHdpW7nv8nnSDgZSY4BG/
	 O5RIAC0a5JgbwNzt70mwHm1z/OaYQqCFhS0Leyo0mTKh36iYYEn4sFCIvbfYEsNzCd
	 8fXFIy7rXmOEyJ3uBlg0IhN8sWroq0qqoUAK6fZNKKoCe2Xkjfw4a+T5mILF1oifq1
	 ZvPQFAcDh3wgO29lA4W1wL/7tuy4vAlC/22wv9rdAxikik04jVTE8PsJGL6gc72O69
	 jGAhQHfQI/bsA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 70768E22AFC;
	Thu,  7 Sep 2023 04:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net v4] net: phy: Provide Module 4 KSZ9477 errata (DS80000754C)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169405922245.5293.2774617542441865085.git-patchwork-notify@kernel.org>
Date: Thu, 07 Sep 2023 04:00:22 +0000
References: <20230905093315.784052-1-lukma@denx.de>
In-Reply-To: <20230905093315.784052-1-lukma@denx.de>
To: Lukasz Majewski <lukma@denx.de>
Cc: Tristram.Ha@microchip.com, edumazet@google.com, andrew@lunn.ch,
 davem@davemloft.net, woojung.huh@microchip.com, olteanv@gmail.com,
 o.rempel@pengutronix.de, f.fainelli@gmail.com, kuba@kernel.org,
 pabeni@redhat.com, UNGLinuxDriver@microchip.com, linux@armlinux.org.uk,
 hkallweit1@gmail.com, michael@walle.cc, horatiu.vultur@microchip.com,
 arun.ramadoss@microchip.com, linux@rempel-privat.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  5 Sep 2023 11:33:15 +0200 you wrote:
> The KSZ9477 errata points out (in 'Module 4') the link up/down problems
> when EEE (Energy Efficient Ethernet) is enabled in the device to which
> the KSZ9477 tries to auto negotiate.
> 
> The suggested workaround is to clear advertisement of EEE for PHYs in
> this chip driver.
> 
> [...]

Here is the summary with links:
  - [net,v4] net: phy: Provide Module 4 KSZ9477 errata (DS80000754C)
    https://git.kernel.org/netdev/net/c/08c6d8bae48c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



