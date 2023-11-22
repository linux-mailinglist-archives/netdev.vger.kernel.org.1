Return-Path: <netdev+bounces-50023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 850537F4482
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 12:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3C5BB21039
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 11:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D719E2E62F;
	Wed, 22 Nov 2023 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgJpHh0B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC472231B
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 11:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54F11C433CD;
	Wed, 22 Nov 2023 11:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700650824;
	bh=6rDBMi5vgLk/ikFlm2Flmd2RJXRdkqlpNTaFELNVkxA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lgJpHh0BBZoQxh5EBJJitx62aSBpmxszlWFaNBqG7sPgKJTuHZxRZXwSnmgXM7wwz
	 GrxBiJBRM3ynio2/WZ2hebqMPbBlgLedkmOLPHOdKnVS0lXBTh5SA7/HBK2PCcd/2O
	 7N4nc4sYo119ckB1y/i58vJU0FMBgM9AaADWKjpxLH6jteiV12u5zfn34slxz8V4G2
	 d8p1hu7L2S9KkpWqBf2Gp4V1+mpj65JQMV7gx/qR44rBt5a/r6xuKLp/YbZW6wW+wD
	 stQo6bH8mMg0sME1TJW10vw6fLtfigpxDmWENwhOviB5vEy5V+aa2OI/vygphV12Ze
	 4T/3dUzPUns9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 38CC5EAA958;
	Wed, 22 Nov 2023 11:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/1] net: stmmac: Add support for HW-accelerated
 VLAN stripping
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170065082422.4259.15356814369119039927.git-patchwork-notify@kernel.org>
Date: Wed, 22 Nov 2023 11:00:24 +0000
References: <20231121053842.719531-1-yi.fang.gan@intel.com>
In-Reply-To: <20231121053842.719531-1-yi.fang.gan@intel.com>
To: Gan Yi Fang <yi.fang.gan@intel.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 hong.aun.looi@intel.com, weifeng.voon@intel.com, yoong.siang.song@intel.com,
 jun.ann.lai@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 21 Nov 2023 13:38:42 +0800 you wrote:
> From: "Gan, Yi Fang" <yi.fang.gan@intel.com>
> 
> Current implementation supports driver level VLAN tag stripping only.
> The features is always on if CONFIG_VLAN_8021Q is enabled in kernel
> config and is not user configurable.
> 
> This patch add support to MAC level VLAN tag stripping and can be
> configured through ethtool. If the rx-vlan-offload is off, the VLAN tag
> will be stripped by driver. If the rx-vlan-offload is on, the VLAN tag
> will be stripped by MAC.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/1] net: stmmac: Add support for HW-accelerated VLAN stripping
    https://git.kernel.org/netdev/net-next/c/750011e239a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



