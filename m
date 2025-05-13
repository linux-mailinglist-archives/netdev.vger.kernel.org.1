Return-Path: <netdev+bounces-189940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB05CAB48C5
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 03:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B3788C4251
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 01:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E2319DF66;
	Tue, 13 May 2025 01:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/1H3WOK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA38119D093;
	Tue, 13 May 2025 01:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747099208; cv=none; b=OPsxcB9scG3/aeBHVjzaX20oezDnJKPyi45z7rIZGdZvIjISLidZLF8WxKtUH8J6Fhhl6/R47bNADLqXdQ9coalGk0k5upxo4HNR8gi3sa6rw1Ge/5f4h5ePJ2moia1bAlKCSMxN10C+vR1t+IhFT9g7pSSROtuZ0MdrscYX7nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747099208; c=relaxed/simple;
	bh=Gwv8IJluwhkLe7Hm576RB+85+3tduL9ekdWBKgtmVAc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n3qwF3/q9zBgAOzYqZ5YlbTgL0KnNQAHlL6g1JR3dMpDd0VAUPcIOzEZRyh6CbZxjICsWXJYw41WceUwrzashaZs9sQRcM5VaESa3ulyKIpHqPs/b1GCV78EMSLmd880SKDAvMfUVYcBEgCjiTuL2HsyxcvCShbJQx4f/kt6L0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/1H3WOK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8649EC4CEE7;
	Tue, 13 May 2025 01:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747099208;
	bh=Gwv8IJluwhkLe7Hm576RB+85+3tduL9ekdWBKgtmVAc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K/1H3WOKXSUhEkXbxo80jO37hrPgDOaduOvljmHihT5WjyX5ImsBaU36+416bm4Eo
	 CslRg2DZydXaMu+Rx11C79w+t7w7T5lyLLgOyvDdaq7pIG7gf5fvlSegC3SJWFHp70
	 B1iw4R6w8zd/ZMvZOb56/W5bam0N26wD0fR4ZK5mA3ZQcbdcmEE2khXeGRdff8TwCm
	 w1FnHebLA7rJ7nx0Jdla2hRp1MGfJmhSbQgnKIvG8FzhhvHbLxdV4/koHGYybc+gSj
	 4o4buXd5ggzLGovqChc6k2oCoI/3PmMG9nQVB4xZKNmE6wuegyJOeZjgA51xQ7oykE
	 V7CbEvmxblH2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D6D39D60BA;
	Tue, 13 May 2025 01:20:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ixp4xx_eth: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174709924600.1134434.410408698956541065.git-patchwork-notify@kernel.org>
Date: Tue, 13 May 2025 01:20:46 +0000
References: <20250508211043.3388702-1-vladimir.oltean@nxp.com>
In-Reply-To: <20250508211043.3388702-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, kory.maincent@bootlin.com, linusw@kernel.org,
 kaloz@openwrt.org, linux-arm-kernel@lists.infradead.org, andrew@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, richardcochran@gmail.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  9 May 2025 00:10:42 +0300 you wrote:
> New timestamping API was introduced in commit 66f7223039c0 ("net: add
> NDOs for configuring hardware timestamping") from kernel v6.6. It is
> time to convert the intel ixp4xx ethernet driver to the new API, so that
> the ndo_eth_ioctl() path can be removed completely.
> 
> hwtstamp_get() and hwtstamp_set() are only called if netif_running()
> when the code path is engaged through the legacy ioctl. As I don't
> want to make an unnecessary functional change which I can't test,
> preserve that restriction when going through the new operations.
> 
> [...]

Here is the summary with links:
  - [net-next] net: ixp4xx_eth: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
    https://git.kernel.org/netdev/net-next/c/c14e1ecefd9e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



