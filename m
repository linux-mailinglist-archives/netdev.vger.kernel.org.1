Return-Path: <netdev+bounces-128297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9871978D67
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 06:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 088821C22933
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 04:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B11C5464E;
	Sat, 14 Sep 2024 04:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeZTjmM0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753D036126;
	Sat, 14 Sep 2024 04:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726289448; cv=none; b=NkhwHFC9xtnUJ/aeUSyTHB1OGbErh87T4XOxlcKqiTOEB4e/xGYatzIVThS5nlJ8ab9d/0ym+YK1eQsXg2i7KZLYXxnaVC9lNhAf04kp4sbgj+2f3vbs3HADJF8a5vVkqO2Cmp+u4iMMaGEBJikGZihvpY7tRw/X1GuDSuWoSls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726289448; c=relaxed/simple;
	bh=4g2Ub7xX6zwQqZApvM1OzhrXjzorZQEQHbyO5oAiJww=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dbDry4P43tqV8E4+WXZuioevNxAeYSq96yHR+bKaJG8WnmZIEVeH6FZVXU7H7WlxzWp+0cnT5iEkUto4VNMNusU4JKUnccbMpan4IwVA+iixWNL5Xj72qIs4hI0xB0K3SokE+9uy5ZKJGSsZN6poXC3huKq1Y2aA+c21ZafGTn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HeZTjmM0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4AD7C4CEC0;
	Sat, 14 Sep 2024 04:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726289448;
	bh=4g2Ub7xX6zwQqZApvM1OzhrXjzorZQEQHbyO5oAiJww=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HeZTjmM0BkQkVDK4beNIltF3zNoxtP/k874sUCMofKvMo0/TE3n9hG8TEWm1qn5nW
	 Ex6bagp441WNatAvLEHFR9QwhQwuI4DBdr/e0OjYLeuTZdV8xxpu9O0FJ4Cne4maVo
	 MmtT7u/3ZVm6JNWeWDcYQ6SVapS+uHY0fJTHxKfgaV9DNzcFDSJKRDWQGKnXiUWMOR
	 Mxgci9n1g71bUnNj3vSr/pw/sQ1kG65wrcAD9Dhm3qugbjoTg6Oo/agBU3DIb6SqKD
	 OZJsPVHOJKJYEBNjRrUvLrc9lnnxMQzS7DLNjMHDEUEPxX97fgZBFKUNFGhu55jPOv
	 C10flC4qCc/Nw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 715833806655;
	Sat, 14 Sep 2024 04:50:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethtool: phy: Don't set the context dev pointer
 for unfiltered DUMP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172628944900.2462238.3253064292823332158.git-patchwork-notify@kernel.org>
Date: Sat, 14 Sep 2024 04:50:49 +0000
References: <20240913100515.167341-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20240913100515.167341-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, andrew@lunn.ch, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk,
 linux-arm-kernel@lists.infradead.org, christophe.leroy@csgroup.eu,
 herve.codina@bootlin.com, f.fainelli@gmail.com, hkallweit1@gmail.com,
 vladimir.oltean@nxp.com, kory.maincent@bootlin.com, kabel@kernel.org,
 piergiorgio.beruto@gmail.com, o.rempel@pengutronix.de, nicveronese@gmail.com,
 horms@kernel.org, mwojtas@chromium.org, nathan@kernel.org,
 atenart@kernel.org, mkl@pengutronix.de, dan.carpenter@linaro.org,
 romain.gantois@bootlin.com,
 syzbot+e9ed4e4368d450c8f9db@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Sep 2024 12:05:14 +0200 you wrote:
> The context info allows continuing DUMP requests, shall they fill the
> netlink buffer.
> 
> In the case of filtered DUMP requests, a reference on the netdev is
> grabbed in the .start() callback and release in .done().
> 
> Unfiltered DUMP request don't need the dev pointer to be set in the context
> info, doing so will trigger an unwanted netdev_put() in .done().
> 
> [...]

Here is the summary with links:
  - [net-next] net: ethtool: phy: Don't set the context dev pointer for unfiltered DUMP
    https://git.kernel.org/netdev/net-next/c/1ad84a151af7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



