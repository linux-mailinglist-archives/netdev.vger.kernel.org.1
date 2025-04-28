Return-Path: <netdev+bounces-186602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6714A9FDA7
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 01:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D1B1A85107
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 23:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F04120E6E4;
	Mon, 28 Apr 2025 23:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1HqL3+J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF34120B1F5
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 23:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745882394; cv=none; b=VwW42phikXD1Ip1qv0XmhwqEb7vz585uNtq5JJXMJhapjvMhqRR7bczPOMVRluvs8qtawloh6pCiT9nMXz4nSFoDLzZSsMx/lghqZZB4+c4ZWIPoSWX10aKfSxhMmOxWj1iJjAO7lwFsdSDZc4vSpdFW7zc+Ue1oh9ReqDaGrwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745882394; c=relaxed/simple;
	bh=g2qRPe928Tf8rjjmTdvzCNkwyQsW5jLn9c9jg2joRgo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PUH4JRysVljEJix/DScVSv+1aL4uQwF9DfP4OuM8LjD3/14+8z9vpfA/clIW3FSNYbAklRhImGQRjcvOTTD1dfztOUYSyBr2ZOr8bTs0w/pq0h7WqMX6FRYv6HWoQ/lgel4W72zbjygQuLvb3RYYlGMny8My8Obu3wSgYVWPVv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1HqL3+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6B9C4CEE4;
	Mon, 28 Apr 2025 23:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745882393;
	bh=g2qRPe928Tf8rjjmTdvzCNkwyQsW5jLn9c9jg2joRgo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N1HqL3+JlwbgS8Htuui5D6fSyd2OwVYFt0T+Ro6D8Sqv+OuMV1wtZ91uI6dfpfGYd
	 lIqU+ZuhwRUMRrM/A142vw2TT382A6b08lO5KS34a691qyswpyYnZfHJsvNmzlsg/H
	 jaIJFyTXOQ72pqDNHLDAxDYJBtC3bVqu3UblUaq5z6Zk9Tky+ZTbdDjuZktVqIdlMD
	 vHLdKT88ZOroZX4QRlrOSvchFMRlOz96W0lhDWSgt0LBnHmSBzuQs4S7jBl7S/37ca
	 bvLo2Cc5/GjtFPWnNTf4Q8iYjmMRvuy0Bl1FzDCaSBxRKnWfhdvf+h7AIENeCzwqh2
	 XTMEN0ZQMMT7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD693822D43;
	Mon, 28 Apr 2025 23:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/3][pull request] Intel Wired LAN Driver Updates
 2025-04-22 (ice, idpf)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174588243249.1076307.7416724904721410898.git-patchwork-notify@kernel.org>
Date: Mon, 28 Apr 2025 23:20:32 +0000
References: <20250425222636.3188441-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250425222636.3188441-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Apr 2025 15:26:30 -0700 you wrote:
> For ice:
> Paul removes setting of ICE_AQ_FLAG_RD in ice_get_set_tx_topo() on
> E830 devices.
> 
> Xuanqiang Luo adds error check for NULL VF VSI.
> 
> For idpf:
> Madhu fixes misreporting of, currently, unsupported encapsulated
> packets.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/3] ice: fix Get Tx Topology AQ command error on E830
    https://git.kernel.org/netdev/net/c/3ffcd7b657c9
  - [net,v2,2/3] ice: Check VF VSI Pointer Value in ice_vc_add_fdir_fltr()
    https://git.kernel.org/netdev/net/c/425c5f266b2e
  - [net,v2,3/3] idpf: fix offloads support for encapsulated packets
    https://git.kernel.org/netdev/net/c/713dd6c2deca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



