Return-Path: <netdev+bounces-199982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD637AE29BB
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 17:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C556B3BB4E3
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 15:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8870513C81B;
	Sat, 21 Jun 2025 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kgi7aG3l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AC220C010
	for <netdev@vger.kernel.org>; Sat, 21 Jun 2025 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750518591; cv=none; b=tYdfw5O8FC6gotjtZvSKDUsqQ7Rz2Y7nmqQUJBzAqovvbPSCM7U/r9h8PuSSuFzxNYzQjS8Eqq5TkMUKS+IoRom/RgAe1UCRigW/d380Oy5hkzugwhYJqTU5O2FZakYoO41cHJ2qv1wpRg5MGbusjHnbCHMfu4XcYwCTiM+Vp/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750518591; c=relaxed/simple;
	bh=Me+7RaMAmY27DzuQp5sogcyuGPRRUaGmAxFUUGRBmZw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aOu/gvcLlP1wKAhFg56P2XALXuxW5a4d95akS0o1+GQK7MrhC+FbM2G6Ysp4Tb0JQLqZ3ZOJIJSeXFLz8ecZD9ZEW7cu3LcJbeyf4pz3k2aC+63QE8X+AzcaKEcou+R3uxRma9rs8uRGC2oo77gt8EoG4LYGq9ajFmNudjPk9Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kgi7aG3l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9590C4CEEF;
	Sat, 21 Jun 2025 15:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750518590;
	bh=Me+7RaMAmY27DzuQp5sogcyuGPRRUaGmAxFUUGRBmZw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Kgi7aG3lp/T2+b3WZAU92q1xyIJo5vsOiyh11woKhBmCQMUV7jIVxRyq+KQZF1y/X
	 l8zMsaVl2jC/h9VLKnXvh5K+GR7ZvoIgzqv+R3jVVQsDYMovpKtG7n8GyLQ+gcaWTK
	 +UDPOM7RUNu2SEP4q6W42R4TvomZEadcguJEtmA6ojc/J7UXpXNOa16hhreyL3jM4y
	 A4y060QW39SSDyGAxzjVTQhMOeV47Dx6MmEv7A6DzNPBJtmP27TKjFpa6fKApSSNIl
	 zTDny70fWfUJ3MoaJIMVZbNkN5rG0ruX+JzWbcg1AlMCzNQq8HJLsczEFKpuMgBU6e
	 WviorbgNWgIkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE02338111DD;
	Sat, 21 Jun 2025 15:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/10] eth: finish migration to the new RXFH
 callbacks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175051861849.1879824.12303497854819755196.git-patchwork-notify@kernel.org>
Date: Sat, 21 Jun 2025 15:10:18 +0000
References: <20250618203823.1336156-1-kuba@kernel.org>
In-Reply-To: <20250618203823.1336156-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
 somnath.kotur@broadcom.com, shenjian15@huawei.com, salil.mehta@huawei.com,
 shaojijie@huawei.com, cai.huoqing@linux.dev, saeedm@nvidia.com,
 tariqt@nvidia.com, louis.peens@corigine.com, mbloch@nvidia.com,
 manishc@marvell.com, ecree.xilinx@gmail.com, joe@dama.to

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Jun 2025 13:38:13 -0700 you wrote:
> Finish drivers conversions to callbacks added by
> commit 9bb00786fc61 ("net: ethtool: add dedicated callbacks for
> getting and setting rxfh fields"). Remove the conditional calling
> in the core, rxnfc callbacks are no longer used for RXFH.
> 
> Jakub Kicinski (10):
>   eth: sfc: falcon: migrate to new RXFH callbacks
>   eth: sfc: siena: migrate to new RXFH callbacks
>   eth: sfc: migrate to new RXFH callbacks
>   eth: benet: migrate to new RXFH callbacks
>   eth: qede: migrate to new RXFH callbacks
>   eth: mlx5: migrate to new RXFH callbacks
>   eth: nfp: migrate to new RXFH callbacks
>   eth: hinic: migrate to new RXFH callbacks
>   eth: hns3: migrate to new RXFH callbacks
>   net: ethtool: don't mux RXFH via rxnfc callbacks
> 
> [...]

Here is the summary with links:
  - [net-next,01/10] eth: sfc: falcon: migrate to new RXFH callbacks
    https://git.kernel.org/netdev/net-next/c/80ec96cb245b
  - [net-next,02/10] eth: sfc: siena: migrate to new RXFH callbacks
    https://git.kernel.org/netdev/net-next/c/c58b9d1829d4
  - [net-next,03/10] eth: sfc: migrate to new RXFH callbacks
    https://git.kernel.org/netdev/net-next/c/861b948ac18c
  - [net-next,04/10] eth: benet: migrate to new RXFH callbacks
    https://git.kernel.org/netdev/net-next/c/92a95652650f
  - [net-next,05/10] eth: qede: migrate to new RXFH callbacks
    https://git.kernel.org/netdev/net-next/c/06bb89e00f22
  - [net-next,06/10] eth: mlx5: migrate to new RXFH callbacks
    https://git.kernel.org/netdev/net-next/c/18f4e3898ac3
  - [net-next,07/10] eth: nfp: migrate to new RXFH callbacks
    https://git.kernel.org/netdev/net-next/c/6bfd8cf33859
  - [net-next,08/10] eth: hinic: migrate to new RXFH callbacks
    https://git.kernel.org/netdev/net-next/c/943c0ce30884
  - [net-next,09/10] eth: hns3: migrate to new RXFH callbacks
    https://git.kernel.org/netdev/net-next/c/188793f082a5
  - [net-next,10/10] net: ethtool: don't mux RXFH via rxnfc callbacks
    https://git.kernel.org/netdev/net-next/c/72792461c8e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



