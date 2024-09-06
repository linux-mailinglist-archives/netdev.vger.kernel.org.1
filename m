Return-Path: <netdev+bounces-125789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC58996E970
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 07:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37F92B222C1
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 05:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD34E86250;
	Fri,  6 Sep 2024 05:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQnhd1mO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C9717BBE;
	Fri,  6 Sep 2024 05:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725601571; cv=none; b=aWMo/9rLopt0LZ2h92OWoq2E37uxtZOES1tTD9qvW+1RRW34wAFWzzhvbuI6JkfTGb0reCZI9fLEv+ZxLX0nQuRFNgu0Sm7UuEYbwdS263wkepPddHgDV54jCu1So7Kp62y3zaNoptXWLxRxBHjQ8nw5dELtWNuVkKgvcoHe49Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725601571; c=relaxed/simple;
	bh=Kxgv3UuGhwPS+NatP6LemxhH72yqs1T4CFoWXsBxsig=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ne1/w9ZTGwsG6WELlnDM3jYCdUKbFgaL+HAPV5Zd9df7GBoN30atw+XPojqHItEhWx7bG7y84xeChHu1AgZB+kENOtWfdVMxppJzp8tQdbGj3S9Uex9cFDWJzlUGz76WjdpocQ5nFo+0/wngCGfgm0vIYmzBEWfAk4IAKjvjTSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQnhd1mO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8B8C4CEC4;
	Fri,  6 Sep 2024 05:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725601571;
	bh=Kxgv3UuGhwPS+NatP6LemxhH72yqs1T4CFoWXsBxsig=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MQnhd1mOVurFbxhV4XM9ihuJ/AFwtauEgDfKITNu5Z8nxGoK6O+qDRkhN1Kkg2Lpr
	 74erken7zre4z8ccJUR9laSWuIKN+Z8WqRKw6Ew7DjVUKNjmjaZDrcYxSjvvokdskX
	 CI50HdFsQEN7BpYsr2HuTsC1ROCva0LUw33h5LPD3yEvCvWVCxUL7AFfJHzGRImU/c
	 e5DIV3Gu9fSlxJJzs5wPA4AIpTv6BaqddhRrsV7oIZQaLEW0387bMNcDMBnNZFXkzs
	 EVWjPtUTVWWN9wePneXu9urbcjuHdWA63e+SkJXxJTiy8i+MejNemzc+GFaBGo9KdZ
	 23gWmrot4UALQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713883806654;
	Fri,  6 Sep 2024 05:46:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v30 00/13] Add Realtek automotive PCIe driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172560157225.1943577.9568991767721746511.git-patchwork-notify@kernel.org>
Date: Fri, 06 Sep 2024 05:46:12 +0000
References: <20240904032114.247117-1-justinlai0215@realtek.com>
In-Reply-To: <20240904032114.247117-1-justinlai0215@realtek.com>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew@lunn.ch, jiri@resnulli.us, horms@kernel.org, rkannoth@marvell.com,
 jdamato@fastly.com, pkshih@realtek.com, larry.chiu@realtek.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 4 Sep 2024 11:21:01 +0800 you wrote:
> This series includes adding realtek automotive ethernet driver
> and adding rtase ethernet driver entry in MAINTAINERS file.
> 
> This ethernet device driver for the PCIe interface of
> Realtek Automotive Ethernet Switch,applicable to
> RTL9054, RTL9068, RTL9072, RTL9075, RTL9068, RTL9071.
> 
> [...]

Here is the summary with links:
  - [net-next,v30,01/13] rtase: Add support for a pci table in this module
    https://git.kernel.org/netdev/net-next/c/a36e9f5cfe9e
  - [net-next,v30,02/13] rtase: Implement the .ndo_open function
    https://git.kernel.org/netdev/net-next/c/ea244d7d8dce
  - [net-next,v30,03/13] rtase: Implement the rtase_down function
    https://git.kernel.org/netdev/net-next/c/5a2a2f15244c
  - [net-next,v30,04/13] rtase: Implement the interrupt routine and rtase_poll
    https://git.kernel.org/netdev/net-next/c/2bbba79e348d
  - [net-next,v30,05/13] rtase: Implement hardware configuration function
    https://git.kernel.org/netdev/net-next/c/85dd839ad1e5
  - [net-next,v30,06/13] rtase: Implement .ndo_start_xmit function
    https://git.kernel.org/netdev/net-next/c/d6e882b89fdf
  - [net-next,v30,07/13] rtase: Implement a function to receive packets
    https://git.kernel.org/netdev/net-next/c/cf7226c80845
  - [net-next,v30,08/13] rtase: Implement net_device_ops
    https://git.kernel.org/netdev/net-next/c/079600489960
  - [net-next,v30,09/13] rtase: Implement pci_driver suspend and resume function
    https://git.kernel.org/netdev/net-next/c/a25a0b070c51
  - [net-next,v30,10/13] rtase: Implement ethtool function
    https://git.kernel.org/netdev/net-next/c/dd7f17c40fd1
  - [net-next,v30,11/13] rtase: Add a Makefile in the rtase folder
    https://git.kernel.org/netdev/net-next/c/14cb81d1359e
  - [net-next,v30,12/13] realtek: Update the Makefile and Kconfig in the realtek folder
    https://git.kernel.org/netdev/net-next/c/ad61903add56
  - [net-next,v30,13/13] MAINTAINERS: Add the rtase ethernet driver entry
    https://git.kernel.org/netdev/net-next/c/b0613ba1cd93

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



