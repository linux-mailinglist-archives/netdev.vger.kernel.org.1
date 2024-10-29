Return-Path: <netdev+bounces-139955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9707A9B4C9B
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 15:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BBB928360D
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 14:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC493198825;
	Tue, 29 Oct 2024 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNHqCCBJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C34197A9F;
	Tue, 29 Oct 2024 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730213432; cv=none; b=BUoObr6Y6DjcGe5TblZZZN++zB2eblSA9WxZEU8KLyR5dMMgQgfqUskdOlAbIU5zf0alqVdMQx3V1Q8S6QJvev3C02vfQH5YkR1TDem8U0ojOooGqXHQ5Kv3BVbbuUjF6M9mwYn9N3n3Pt1A2dgFUeUuRxX205Ds2TcbrwZWuwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730213432; c=relaxed/simple;
	bh=nyKvWnDoZNQLtnF/BEa1scvjbFEOhteiDlpptbNb6sM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XosUORDmLes3/qaoL7fhznj3W5+WRKwg6NdC3O6JTE1zh0pe/9Wid84DK2ztc2h01gbSicDgHE04X7z5LG6gHartgO6h7Pij83/JDUyTiZ3m9/mrRGB3Ucl3clAFtcqkLxqErv70gVZx01T0IKqrDXAyr07aEM1BPZ/dnCb4klI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNHqCCBJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F63C4CEE6;
	Tue, 29 Oct 2024 14:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730213432;
	bh=nyKvWnDoZNQLtnF/BEa1scvjbFEOhteiDlpptbNb6sM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pNHqCCBJK7sbgCNiG7QKiIDyKF6CJkqP8MXVPx8qT2psByKkqd9I1PoDNhfy4WhIn
	 AzBXlrDIjbFAYiAYd6d6X/q4BlyIP5IRV8MRfds1xEgd+ULyqJqbJjnhKQdgQ6H1ie
	 m89YZwMoHFioLSAebXtkJE9tI5hZLUVir/aSMpad9sKeLdhv+WYVAg36KUXJpP9qN8
	 +xSi15Jiecuz/bVXfoitMW7YNwJNnXckr7vjPgHwLjmALiDfbGH2RhUwr813w2gIQ9
	 JhQoUrw0IlhSQDVwNtlRfMbx4Hlqvn/udHzE3evJZpDSM9CQsoj4ND1ZTGrZBTcuTE
	 Z1514BTMQ5o3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE3AC380AC08;
	Tue, 29 Oct 2024 14:50:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv8 net-next 0/5] ibm: emac: more cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173021343952.717356.3259604965087127919.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 14:50:39 +0000
References: <20241022002245.843242-1-rosenp@gmail.com>
In-Reply-To: <20241022002245.843242-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shannon.nelson@amd.com, u.kleine-koenig@baylibre.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 21 Oct 2024 17:22:40 -0700 you wrote:
> Tested on Cisco MX60W.
> 
> v2: fixed build errors. Also added extra commits to clean the driver up
> further.
> v3: Added tested message. Removed bad alloc_netdev_dummy commit.
> v4: removed modules changes from patchset. Added fix for if MAC not
> found.
> v5: added of_find_matching_node commit.
> v6: resend after net-next merge.
> v7: removed of_find_matching_node commit. Adjusted mutex_init patch.
> v8: removed patch removing custom init/exit. Needs more work.
> 
> [...]

Here is the summary with links:
  - [PATCHv8,net-next,1/5] net: ibm: emac: use netif_receive_skb_list
    https://git.kernel.org/netdev/net-next/c/0a24488d93e8
  - [PATCHv8,net-next,2/5] net: ibm: emac: use devm_platform_ioremap_resource
    https://git.kernel.org/netdev/net-next/c/c9bf90863df5
  - [PATCHv8,net-next,3/5] net: ibm: emac: use platform_get_irq
    https://git.kernel.org/netdev/net-next/c/a598f66d9169
  - [PATCHv8,net-next,4/5] net: ibm: emac: use devm for mutex_init
    https://git.kernel.org/netdev/net-next/c/af4698be49e8
  - [PATCHv8,net-next,5/5] net: ibm: emac: generate random MAC if not found
    https://git.kernel.org/netdev/net-next/c/707f1c4b6a2c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



