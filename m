Return-Path: <netdev+bounces-131425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1334998E7D4
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 02:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B485B232B3
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 00:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A74C17BA0;
	Thu,  3 Oct 2024 00:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtrIpsGb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265151401C
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 00:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727916035; cv=none; b=H5iHmxzzu6YHvmr4S28h4kQwF0TOaEUY5iOTWmOSffP72fl2/3xcc43pMKWXlDYNtfxz80fDpyJDlO7Xsf8dl3jl8q14p2XTHJULkbK6WHRqMJ5oQbqyT1HdERwK6U8ehIvYCl5irU9OZodK+ppxMQYIMeDOpIwNUQ0/0UTHVOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727916035; c=relaxed/simple;
	bh=n7u4LoqXC+SEnDH/x71rcz21K9LDE4bjc55iyyBfXBU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RpfE2fB/qEHtG4sKWsrMbbhYHJ6tfoOydmM5M89bmzr+KXk+7/2lShT6SXtAHAdJO3mPXm/E8Ro13I17cNmNwhqjd7NN9A0OixflDqlPF/tqdc+4BP6wz8I3eTKNejOyOXUqPUW8J1bpfkYmbnk96sG478RNiGjNk0H9TgBCwbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtrIpsGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB99C4CEC5;
	Thu,  3 Oct 2024 00:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727916035;
	bh=n7u4LoqXC+SEnDH/x71rcz21K9LDE4bjc55iyyBfXBU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WtrIpsGb6N27JL0IYNiAYlbyIAuwVNR+RlxznmlgzdcBWUddqyWQsJyumAnEQNDHj
	 a2nFYsoXhxqT6qzAkEdgupDWuwu7wZy2kAMJH1CfQdZXbg6dRAab0LTnACEXD1aRDL
	 pfJpCSZKpgNUzJM2IN+/i74ZISH6Bf8IxvRwzu1MFt9KH9/4ErBxkxyxMjNvmh4BHD
	 i5g0mrOjLjp8KvAvdfzNl52tzjrWGHJXLEpvc/PwmPoN6qdr4/MwVRJ39O9TBISpnq
	 HscQGt3sMZ2vZ1Ibtv8BLqVLybgOrVFMLLrYSu6LDpiYYpbfTg10B5186f0Ml6eMRO
	 WOxEwqCOsNzLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71026380DBD1;
	Thu,  3 Oct 2024 00:40:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: phy: realtek: Check the index value in
 led_hw_control_get
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172791603800.1387504.12753001342982018608.git-patchwork-notify@kernel.org>
Date: Thu, 03 Oct 2024 00:40:38 +0000
References: <20240927114610.1278935-1-hui.wang@canonical.com>
In-Reply-To: <20240927114610.1278935-1-hui.wang@canonical.com>
To: Hui Wang <hui.wang@canonical.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 marex@denx.de, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Sep 2024 19:46:10 +0800 you wrote:
> Just like rtl8211f_led_hw_is_supported() and
> rtl8211f_led_hw_control_set(), the rtl8211f_led_hw_control_get() also
> needs to check the index value, otherwise the caller is likely to get
> an incorrect rules.
> 
> Fixes: 17784801d888 ("net: phy: realtek: Add support for PHY LEDs on RTL8211F")
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> 
> [...]

Here is the summary with links:
  - net: phy: realtek: Check the index value in led_hw_control_get
    https://git.kernel.org/netdev/net/c/c283782fc5d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



