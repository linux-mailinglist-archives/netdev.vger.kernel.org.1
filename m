Return-Path: <netdev+bounces-224456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D45ACB85423
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 16:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E0403AF67A
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 14:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF41306B34;
	Thu, 18 Sep 2025 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XI3MPnrv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA7B30103C;
	Thu, 18 Sep 2025 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758205818; cv=none; b=By9r5gqNQNYo32haniDV12zLfYKwxndqfRrbwBFrq8Zk0fiFH/kq+drjHA8AhHHx84BdhiyY756KgDWeOBqee9CeZ1UHLcpn1LBwjxymDy70/vo2Ojmvu7wmH2cqBv62d1DkvjKneFK+2ofCwZNU4AsxdCw5v20Ght1KKco1KPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758205818; c=relaxed/simple;
	bh=ckFgxz34aBgFRsnyA+st0b8BuvozjIy3Ct1WtrnIsOE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GHdJ8XmtDwvlTlC+BXm1KAJjVIxVzZiKfPfm/F7tDeIsViFQ3Sgw7FXHnwI7bzLHgmUpeYtPxiCj0LoOoo7oRu036o/Y+0JY/V3/SRb08pqENVtkidrnFHHYBK6UcXxDAD7WdA1KJp0B/+D9WOQm+jlx56OzCXWeuNthl2haso0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XI3MPnrv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0915C4CEE7;
	Thu, 18 Sep 2025 14:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758205817;
	bh=ckFgxz34aBgFRsnyA+st0b8BuvozjIy3Ct1WtrnIsOE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XI3MPnrvwSOvjIORhNl0CrAwO3wTZ3miA447J2yxQPdma/lFpfx2SCQjQ1VY0BYn1
	 z01FtNeOvBc+eGe3RGIwLsSquD7mMqNNf/s9CWIvWUTpc2dEG5wU2+ttjv3tpkzt9+
	 QjfLUM+HgP7SrVThQYaCAT1kBE0p6xW56GhPMZdWpE2WDNvJfX/XIIKhlLAegwDOe4
	 sAwTfseoZ7vPYd9lHI/XzJ8L78zqZXJB0YdmXNZCUA96YzquaK6qBN0z5vtCageKxu
	 1437vU8uRuSiuSkmb9w2YKdDi8G+4ejKzw9hcpvFNj7gqhkhk3t6SHaNuzMgzRuXXE
	 tqG0vmOmBPd6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D7239D0C28;
	Thu, 18 Sep 2025 14:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/8] net: ethtool: add dedicated GRXRINGS
 driver callbacks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175820581800.2438890.5576765054312020810.git-patchwork-notify@kernel.org>
Date: Thu, 18 Sep 2025 14:30:18 +0000
References: <20250917-gxrings-v4-0-dae520e2e1cb@debian.org>
In-Reply-To: <20250917-gxrings-v4-0-dae520e2e1cb@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, kuba@kernel.org, horms@kernel.org, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, leiyang@redhat.com, kernel-team@meta.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Sep 2025 02:58:07 -0700 you wrote:
> This patchset introduces a new dedicated ethtool_ops callback,
> .get_rx_ring_count, which enables drivers to provide the number of RX
> rings directly, improving efficiency and clarity in RX ring queries and
> RSS configuration.
> 
> Number of drivers implements .get_rxnfc callback just to report the ring
> count, so, having a proper callback makes sense and simplify .get_rxnfc
> (in some cases remove it completely).
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/8] net: ethtool: pass the num of RX rings directly to ethtool_copy_validate_indir
    https://git.kernel.org/netdev/net-next/c/3efaede2e13b
  - [net-next,v4,2/8] net: ethtool: add support for ETHTOOL_GRXRINGS ioctl
    https://git.kernel.org/netdev/net-next/c/06fad5a4aeb2
  - [net-next,v4,3/8] net: ethtool: remove the duplicated handling from ethtool_get_rxrings
    https://git.kernel.org/netdev/net-next/c/87c76c2db002
  - [net-next,v4,4/8] net: ethtool: add get_rx_ring_count callback to optimize RX ring queries
    https://git.kernel.org/netdev/net-next/c/84eaf4359c36
  - [net-next,v4,5/8] net: ethtool: update set_rxfh to use ethtool_get_rx_ring_count helper
    https://git.kernel.org/netdev/net-next/c/d5544688d421
  - [net-next,v4,6/8] net: ethtool: update set_rxfh_indir to use ethtool_get_rx_ring_count helper
    https://git.kernel.org/netdev/net-next/c/dce08107f1f3
  - [net-next,v4,7/8] net: ethtool: use the new helper in rss_set_prep_indir()
    https://git.kernel.org/netdev/net-next/c/8b7c4b612dec
  - [net-next,v4,8/8] net: virtio_net: add get_rxrings ethtool callback for RX ring queries
    https://git.kernel.org/netdev/net-next/c/483446690a62

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



