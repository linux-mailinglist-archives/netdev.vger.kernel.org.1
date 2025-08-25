Return-Path: <netdev+bounces-216682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD5DB34F0F
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 00:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E08A47AA66A
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 22:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FD429B8D3;
	Mon, 25 Aug 2025 22:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOR3MqoS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9451A9FB8;
	Mon, 25 Aug 2025 22:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756161007; cv=none; b=RBJNXQE6GGC/6N1QsxoHBxVuS1lhE1JaRbmfixSkb6tkXQOBw4sKlj/C1wt3a21zM3/qdqpIFBo7qKwtwA8GG9Phe8zmVh6E8ZXPPqHftsfMTC1eVBV4Rk8vYoDLTtZH1oM8AUD05TdrmYsJGhM+hiRcsHFUrx6MVxd6jT6IOH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756161007; c=relaxed/simple;
	bh=yT3FFyW+GEzq3lv6YkzjAEvU9dFwM8VXl2/bqfQWakk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dXn8Ef+kOWXwlQSXIAfb6nQI6E2bZYoLWLlK7SX30lScGIi6NVpZm3OuZVeL/jWC1OK3L4dWzzvhOV6zwSMMQQpSshaetPi0W6irZbsFpRljGNKwac8XBhQgmcs8w+aW/7nKtx/5Gc3tQLnm6f4i4cWn8n3vlq4RkgTvmFwJl7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOR3MqoS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B33BC4CEED;
	Mon, 25 Aug 2025 22:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756161006;
	bh=yT3FFyW+GEzq3lv6YkzjAEvU9dFwM8VXl2/bqfQWakk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dOR3MqoSmu1qz7NtbYscpQYbp/OafCvueKTLsEhSXYE+b0t7QlRekCNb4wYaYLEXW
	 btYtX+G2CTmq/spusd/q8i8g1LKsauRqnB7ObiReIWk9PUZrAg5Ifodj63kRY/qco+
	 xt8HzijFLNpphWiPykVrTaIY+GgzPwPoq/DvFkiGkNokLUfOhbH1eYy9+r4wjUz6yh
	 5nmx+++51qvXkUMxm022a/iLwBYNNNUFPQYaEQMOgVRT9Q9QRSa382CSOf5IYOHl5K
	 V7LCmX+RErA2/SvWrXAIfVpDpp7RAp1/gsQOuvb0dG/EbvpwFLeZd2qRfpc2yenIPO
	 WxYMpIqFJDmGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E76383BF70;
	Mon, 25 Aug 2025 22:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/7] net: dsa: lantiq_gswip: prepare for
 supporting new features
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175616101425.3580155.8913076433536253697.git-patchwork-notify@kernel.org>
Date: Mon, 25 Aug 2025 22:30:14 +0000
References: <cover.1755878232.git.daniel@makrotopia.org>
In-Reply-To: <cover.1755878232.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: hauke@hauke-m.de, andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 p.zabel@pengutronix.de, linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, andreas.schirm@siemens.com,
 lukas.stockmann@siemens.com, alexander.sverdlin@siemens.com,
 peter.christen@siemens.com, ajayaraman@maxlinear.com, bxu@maxlinear.com,
 lxu@maxlinear.com, jpovazanec@maxlinear.com, fchan@maxlinear.com,
 yweng@maxlinear.com, lrosu@maxlinear.com, john@phrozen.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 22 Aug 2025 17:11:18 +0100 you wrote:
> Prepare for supporting the newer standalone MaxLinear GSW1xx switch
> family by refactoring the existing lantiq_gswip driver.
> This is the first of a total of 3 series and doesn't yet introduce
> any functional changes, but rather just makes the driver more
> flexible, so new hardware and features can be supported in future.
> 
> This series has been preceded by an RFC series which covers everything
> needed to support the MaxLinear GSW1xx family of switches. Andrew Lunn
> had suggested to start with the 8 patches now submitted as they prepare
> but don't yet introduce any functional changes.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/7] net: dsa: lantiq_gswip: deduplicate dsa_switch_ops
    https://git.kernel.org/netdev/net-next/c/fa1439a86583
  - [net-next,v4,2/7] net: dsa: lantiq_gswip: prepare for more CPU port options
    https://git.kernel.org/netdev/net-next/c/2bec1c383699
  - [net-next,v4,3/7] net: dsa: lantiq_gswip: move definitions to header
    https://git.kernel.org/netdev/net-next/c/476c001a554d
  - [net-next,v4,4/7] net: dsa: lantiq_gswip: introduce bitmap for MII ports
    https://git.kernel.org/netdev/net-next/c/dc6156976d2e
  - [net-next,v4,5/7] net: dsa: lantiq_gswip: load model-specific microcode
    https://git.kernel.org/netdev/net-next/c/2e5311d3782f
  - [net-next,v4,6/7] net: dsa: lantiq_gswip: make DSA tag protocol model-specific
    https://git.kernel.org/netdev/net-next/c/1ccc407285e2
  - [net-next,v4,7/7] net: dsa: lantiq_gswip: store switch API version in priv
    https://git.kernel.org/netdev/net-next/c/8a7576d220c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



