Return-Path: <netdev+bounces-137404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E639A605A
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 11:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17750B215BC
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 09:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B411E32A4;
	Mon, 21 Oct 2024 09:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S41S/vky"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB518198837;
	Mon, 21 Oct 2024 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503682; cv=none; b=jVbyxAP7BakwiHli+XVW9xiMXOo4qFA9Q8ZwkWlGSRqAtqajDOYCp9dR2zUZsZqwxVf1r0O6JqiSYidaehhuR+Tkn/6HSB0pmUqjzfA8INGBxHxOQ01/MjN/UjGsdVItGjRgIAA8troc1V+aW5fmfU3DBG+8mtIzjaY75LrCBYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503682; c=relaxed/simple;
	bh=6rptqk1yjX88puhYrwkZuZq14mYGXe2ZwC+jebh3JSY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CCHzHfnGrZI4nLe3MeVx39e/d61pwV0qnKSdKQQ741jjC3Tm0y7mNr0fb6Gg0vVSbH5ZXlzlPwHWcFdq6b3IgF22sXfBjrhGDrUCYk65BNTbuqTPUWMMLadpHy0AJO9PgDSYW0q2m/YqQ2m3HBClCEtlchWZ2qE0OCDwiZGWiBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S41S/vky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575AAC4CEC7;
	Mon, 21 Oct 2024 09:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729503682;
	bh=6rptqk1yjX88puhYrwkZuZq14mYGXe2ZwC+jebh3JSY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S41S/vkyRGKEeA2C28ygl8O6TszptYIZciX2hVi0K6ajaT1IUs8nB3sssIhzZ3iro
	 5MgcWeFSicjmCjP2JHwfuTKfaT8K94xIY5xyrx6cVkBijHnEH94Bgywcvo1tlAIo8C
	 tYbTfIoC16G59ZkYXOTJ3WWaiT6kyiwmlRU9GozUx1ode9Km/A5eR5/ogC8TvLzTRv
	 //boFiV114+ULueUV+g7fYKYnYJC/ntsQbIyQ9fo3HLo4SxHw8282MDQIugyY5zeg0
	 IqwpMyqcWCJMQJemvOEK377iHALkawjauBChannsK/rQnwcdOzuPCRrMwm29hrnU/9
	 z3VQc3xBKI59g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DC93809A8A;
	Mon, 21 Oct 2024 09:41:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V12 RESEND net-next 00/10] Add support of HIBMCGE Ethernet
 Driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172950368799.187649.5504292717467642283.git-patchwork-notify@kernel.org>
Date: Mon, 21 Oct 2024 09:41:27 +0000
References: <20241015123516.4035035-1-shaojijie@huawei.com>
In-Reply-To: <20241015123516.4035035-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shenjian15@huawei.com, wangpeiyang1@huawei.com,
 liuyonglong@huawei.com, chenhao418@huawei.com, sudongming1@huawei.com,
 xujunsheng@huawei.com, shiyongbang@huawei.com, libaihan@huawei.com,
 andrew@lunn.ch, jdamato@fastly.com, horms@kernel.org,
 kalesh-anakkur.purayil@broadcom.com, christophe.jaillet@wanadoo.fr,
 jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
 salil.mehta@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 15 Oct 2024 20:35:06 +0800 you wrote:
> This patch set adds the support of Hisilicon BMC Gigabit Ethernet Driver.
> 
> This patch set includes basic Rx/Tx functionality. It also includes
> the registration and interrupt codes.
> 
> This work provides the initial support to the HIBMCGE and
> would incrementally add features or enhancements.
> 
> [...]

Here is the summary with links:
  - [V12,RESEND,net-next,01/10] net: hibmcge: Add pci table supported in this module
    https://git.kernel.org/netdev/net-next/c/a95ac4f92aa6
  - [V12,RESEND,net-next,02/10] net: hibmcge: Add read/write registers supported through the bar space
    https://git.kernel.org/netdev/net-next/c/fc1992bad7da
  - [V12,RESEND,net-next,03/10] net: hibmcge: Add mdio and hardware configuration supported in this module
    https://git.kernel.org/netdev/net-next/c/a239b2b1dee2
  - [V12,RESEND,net-next,04/10] net: hibmcge: Add interrupt supported in this module
    https://git.kernel.org/netdev/net-next/c/4d089035fa19
  - [V12,RESEND,net-next,05/10] net: hibmcge: Implement some .ndo functions
    https://git.kernel.org/netdev/net-next/c/ff4edac6e9bd
  - [V12,RESEND,net-next,06/10] net: hibmcge: Implement .ndo_start_xmit function
    https://git.kernel.org/netdev/net-next/c/40735e7543f9
  - [V12,RESEND,net-next,07/10] net: hibmcge: Implement rx_poll function to receive packets
    https://git.kernel.org/netdev/net-next/c/f72e25594061
  - [V12,RESEND,net-next,08/10] net: hibmcge: Implement some ethtool_ops functions
    https://git.kernel.org/netdev/net-next/c/e8d13548bd08
  - [V12,RESEND,net-next,09/10] net: hibmcge: Add a Makefile and update Kconfig for hibmcge
    https://git.kernel.org/netdev/net-next/c/81e176de6ad4
  - [V12,RESEND,net-next,10/10] net: hibmcge: Add maintainer for hibmcge
    https://git.kernel.org/netdev/net-next/c/f9a002a13054

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



