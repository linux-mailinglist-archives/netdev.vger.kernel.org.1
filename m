Return-Path: <netdev+bounces-219909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07924B43AB3
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 13:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7005D189D30A
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 11:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DE42EA15D;
	Thu,  4 Sep 2025 11:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkZZ2Nsi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34744F5E0
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 11:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756986612; cv=none; b=NVF183NFKWv4V/LJWSlORgzZTVWxxnQEgx1Ut7ul8Dz6s6EmOVddyXx/XvnSOpPYRorNUyNkdtDvlEM297OnE3WiKshrUnqNL/68VuI25wWC3vUgBftiDQjdRDLsVu+LBDNmf+wwmMZIzFSyrtEACkpISJloCBEhFQr3CIrIlq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756986612; c=relaxed/simple;
	bh=oB424v13SjlKFC9k+sA/L18wdJfkDeo4tcCgVhlN7JY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X+8ydZXNqqa7PmFbBYDYc4Jn1XkflP9eGOaV5+hzUcwrwm6o+79JMmE9xn3lbo32S3V17CozOrp3wVdqSWO9IBIeZksdClbjVfOrwbPspyztWvg4ompc27hLlIgY1yWJU4NXaWKUAeVRaGbFKUyOvaI/WpqGzIYZ40JvytUC8BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkZZ2Nsi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58937C4CEF0;
	Thu,  4 Sep 2025 11:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756986612;
	bh=oB424v13SjlKFC9k+sA/L18wdJfkDeo4tcCgVhlN7JY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MkZZ2Nsi7Tf0JqXXh1dm6RnSefprLj4H1nZGV3JXT8bUqylxlzJrFFCXLxqmsDSDG
	 V70xsdZ0kKB9KWVBOjljfaHGvsI7rXr4xnF8/2tUoVuyRcQxbW0ag6MpO3lHI6Zo+9
	 gf2ZeoLGtwkG4X8rv6pUo7Xo9+d0F3T3akNPt7hBz+y5JYdxKfOuqD0OYN3MCYjL5Q
	 9R+ijNIoW5t7mtJ+4Ho44PBvwb95IU5zK2J4kcry9DDlPo9X9ATQDK+vsonq5g001B
	 UtsAOHxx73BUwySClBPhAAmW9RQcdLc4C4u4sHIz//DvQ/x4AgJPzKsG1SeAuGFjES
	 ax9hlFMZMqRMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C55383BF69;
	Thu,  4 Sep 2025 11:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 00/14] eth: fbnic: support queue API and
 zero-copy
 Rx
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175698661727.1779540.2588956434517263416.git-patchwork-notify@kernel.org>
Date: Thu, 04 Sep 2025 11:50:17 +0000
References: <20250901211214.1027927-1-kuba@kernel.org>
In-Reply-To: <20250901211214.1027927-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 almasrymina@google.com, tariqt@nvidia.com, dtatulea@nvidia.com,
 hawk@kernel.org, ilias.apalodimas@linaro.org, alexanderduyck@fb.com,
 sdf@fomichev.me

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  1 Sep 2025 14:12:00 -0700 you wrote:
> Add support for queue API to fbnic, enable zero-copy Rx.
> 
> Patch 10 is likely of most interest as it adds a new core helper
> (and touches mlx5). The rest of the patches are fbnic-specific
> (and relatively boring).
> 
> Patches 1-3 reshuffle the Rx init/allocation path to better
> align structures and functions which operate on them. Notably
> patch 1 moves the page pool pointer to the queue struct (from NAPI).
> 
> [...]

Here is the summary with links:
  - [net-next,v3,01/14] eth: fbnic: move page pool pointer from NAPI to the ring struct
    https://git.kernel.org/netdev/net-next/c/33478dca2b23
  - [net-next,v3,02/14] eth: fbnic: move xdp_rxq_info_reg() to resource alloc
    https://git.kernel.org/netdev/net-next/c/894d4a4ea6cb
  - [net-next,v3,03/14] eth: fbnic: move page pool alloc to fbnic_alloc_rx_qt_resources()
    https://git.kernel.org/netdev/net-next/c/b6396b71d196
  - [net-next,v3,04/14] eth: fbnic: use netmem_ref where applicable
    https://git.kernel.org/netdev/net-next/c/426e13db369c
  - [net-next,v3,05/14] eth: fbnic: request ops lock
    https://git.kernel.org/netdev/net-next/c/4ddb17c1a2c2
  - [net-next,v3,06/14] eth: fbnic: split fbnic_disable()
    https://git.kernel.org/netdev/net-next/c/cbfc047429ee
  - [net-next,v3,07/14] eth: fbnic: split fbnic_flush()
    https://git.kernel.org/netdev/net-next/c/be2be74af889
  - [net-next,v3,08/14] eth: fbnic: split fbnic_enable()
    https://git.kernel.org/netdev/net-next/c/8a47d940cf81
  - [net-next,v3,09/14] eth: fbnic: split fbnic_fill()
    https://git.kernel.org/netdev/net-next/c/709da681f4de
  - [net-next,v3,10/14] net: add helper to pre-check if PP for an Rx queue will be unreadable
    https://git.kernel.org/netdev/net-next/c/3ceb08838b57
  - [net-next,v3,11/14] eth: fbnic: allocate unreadable page pool for the payloads
    https://git.kernel.org/netdev/net-next/c/8a11010fdd96
  - [net-next,v3,12/14] eth: fbnic: defer page pool recycling activation to queue start
    https://git.kernel.org/netdev/net-next/c/49c429ec6b62
  - [net-next,v3,13/14] eth: fbnic: don't pass NAPI into pp alloc
    https://git.kernel.org/netdev/net-next/c/3812339b6cc9
  - [net-next,v3,14/14] eth: fbnic: support queue ops / zero-copy Rx
    https://git.kernel.org/netdev/net-next/c/da43127a8edc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



