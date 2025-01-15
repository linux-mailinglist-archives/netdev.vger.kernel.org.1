Return-Path: <netdev+bounces-158672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1015A12EE0
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 00:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1290B1885880
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 23:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1302E1DC759;
	Wed, 15 Jan 2025 23:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJrHh9aN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4141DBB38;
	Wed, 15 Jan 2025 23:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736982023; cv=none; b=eiX9avJa+hckHmnYiqSjzjUHQ8qDLOXUoHlMsEHiaalFpmzG7JZs2OLVxkvyd/gInftdS0cG0Br+smb40QcnvLflLqubsJOSZKqtyUpcsBCDNJYvV/iHnD/nUP8LvUAItFmuDSqyU0RmoOmvT8EBHpUUG7MarpGk8rznmkARBZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736982023; c=relaxed/simple;
	bh=dzGttXRShtFeLCkDEvIvU+FymBDdUo8JqfLrGqZ5Hdw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Nahx+s2Mq8WeiDrP121e8oE//iItAgtAFRB/vjtHQsRrcTlGwpbRtkh+DTiOJz/u+2nWdhm8X7UPCunlSIp2TN85EwVbS4XcwFV2vDtAM03MIOIz4jBf3iETT2fP1n1JZypmI2rdOTsVxO7nmbd8jF1xGJArQtLCQ4UkNFSG7EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJrHh9aN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47265C4CED1;
	Wed, 15 Jan 2025 23:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736982022;
	bh=dzGttXRShtFeLCkDEvIvU+FymBDdUo8JqfLrGqZ5Hdw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HJrHh9aNnKqLUIQiPHDaABmLdi4ChCGVlQYKQuFofe3YzSWHsxPy2ISs/VAcZ3uEx
	 UPWFYQl9crjJcTZfLE6FBvPbU+8sQ9yvPaqA3CxNPaS9TllTmSLoRs/Fr66ce3b+1X
	 Ow9g0fxH5h0a2xYOLe/P0W8HOKoKsOQ22pSYSkn5dO5zntfbjOaSlKxiTKrBXr2olt
	 3bR0L/vteFAs1sz+DSUcfl5XkE+dOa3M5FoHJA3w7O6u/HkGRpKqIShuHoPw4aluM0
	 fbcVFMT9rIaLXqgbhwXdiLiJebwEHPbzOFKrgQurnG1Oo0h5PgmeMPCM9FYw4q3Duo
	 SoXxyCmq2SX4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D89380AA5F;
	Wed, 15 Jan 2025 23:00:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v9 0/10] bnxt_en: implement tcp-data-split and thresh
 option
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173698204525.906262.1655130633262596374.git-patchwork-notify@kernel.org>
Date: Wed, 15 Jan 2025 23:00:45 +0000
References: <20250114142852.3364986-1-ap420073@gmail.com>
In-Reply-To: <20250114142852.3364986-1-ap420073@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, almasrymina@google.com,
 donald.hunter@gmail.com, corbet@lwn.net, michael.chan@broadcom.com,
 andrew+netdev@lunn.ch, hawk@kernel.org, ilias.apalodimas@linaro.org,
 ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 dw@davidwei.uk, sdf@fomichev.me, asml.silence@gmail.com,
 brett.creeley@amd.com, linux-doc@vger.kernel.org, kory.maincent@bootlin.com,
 maxime.chevallier@bootlin.com, danieller@nvidia.com,
 hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com,
 rrameshbabu@nvidia.com, idosch@nvidia.com, jiri@resnulli.us,
 bigeasy@linutronix.de, lorenzo@kernel.org, jdamato@fastly.com,
 aleksander.lobakin@intel.com, kaiyuanz@google.com, willemb@google.com,
 daniel.zahka@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Jan 2025 14:28:42 +0000 you wrote:
> This series implements hds-thresh ethtool command.
> This series also implements backend of tcp-data-split and
> hds-thresh ethtool command for bnxt_en driver.
> These ethtool commands are mandatory options for device memory TCP.
> 
> NICs that use the bnxt_en driver support tcp-data-split feature named
> HDS(header-data-split).
> But there is no implementation for the HDS to enable by ethtool.
> Only getting the current HDS status is implemented and the HDS is just
> automatically enabled only when either LRO, HW-GRO, or JUMBO is enabled.
> The hds_threshold follows the rx-copybreak value but it wasn't
> changeable.
> 
> [...]

Here is the summary with links:
  - [net-next,v9,01/10] net: ethtool: add hds_config member in ethtool_netdev_state
    https://git.kernel.org/netdev/net-next/c/197258f0ef68
  - [net-next,v9,02/10] net: ethtool: add support for configuring hds-thresh
    https://git.kernel.org/netdev/net-next/c/eec8359f0797
  - [net-next,v9,03/10] net: devmem: add ring parameter filtering
    https://git.kernel.org/netdev/net-next/c/a08a5c948401
  - [net-next,v9,04/10] net: ethtool: add ring parameter filtering
    https://git.kernel.org/netdev/net-next/c/e61779015c4a
  - [net-next,v9,05/10] net: disallow setup single buffer XDP when tcp-data-split is enabled.
    https://git.kernel.org/netdev/net-next/c/2d46e481a9af
  - [net-next,v9,06/10] bnxt_en: add support for rx-copybreak ethtool command
    https://git.kernel.org/netdev/net-next/c/152f4da05aee
  - [net-next,v9,07/10] bnxt_en: add support for tcp-data-split ethtool command
    https://git.kernel.org/netdev/net-next/c/87c8f8496a05
  - [net-next,v9,08/10] bnxt_en: add support for hds-thresh ethtool command
    https://git.kernel.org/netdev/net-next/c/6b43673a25c3
  - [net-next,v9,09/10] netdevsim: add HDS feature
    https://git.kernel.org/netdev/net-next/c/f394d07b192b
  - [net-next,v9,10/10] selftest: net-drv: hds: add test for HDS feature
    https://git.kernel.org/netdev/net-next/c/cfd70e3eba2b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



