Return-Path: <netdev+bounces-72312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D93A857807
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 09:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1146A1F21EF3
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 08:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DB01BC39;
	Fri, 16 Feb 2024 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiyQX/m+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4021BF26
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708073429; cv=none; b=FauK/FRZC04KXWnZmhu/nHC7jXu71i54OdAr5Lmv/FGsO0cJleUzwTx0kRwro9bJQa/B6A8KpKXWMfm49D+oh1GUaIzIzD98ZnLHqC/xox3RLj9v+phRqUrhfyiP4e/shQji+CaLDM9FBNcIgjznEgSeqvdxQb7wO0P3cBaovHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708073429; c=relaxed/simple;
	bh=dRsGt3xUDhHOXtUxRc6dJryWhnxQReVb2knOMG9g6/U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qE8jt09x6gIAKWYWFXRYIsBH+3jYD0nJ9fQgazym4Aeb4OSEnuHZJuG+mSnsbTHCR393Ext4faFSwFVPPoKpRxkUT9uAYL/wDSNDxe9WMji6I41SgxegmCievu3SEQQGYqioFQDpmgH75qQ4A2yK2i/lDfc18BlN+ABHu4vpy98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiyQX/m+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8340C43390;
	Fri, 16 Feb 2024 08:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708073429;
	bh=dRsGt3xUDhHOXtUxRc6dJryWhnxQReVb2knOMG9g6/U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QiyQX/m+Jvi76lvVCNRTtBdSBwg+1ZTr+bhHBMtL2lwlqmNbKGg2KDafz3MLoo04y
	 entVqqV1ePqvZKTDV5gc+OhWB7mSzpUGOK/SXzyduM9w2oWNQUFah1y3FZ9Y2qVdg6
	 Vgj8fCfL9jaeocdln50Ystd+z4CzvwHa4Hlfz3RZslpyYlIHA1Zo1y0lom2oeKzbh6
	 lcvhC31FGuYbfDT/RBSvMwj+ZZErbz4wb8c+BFMYeuUc7lVPVnqLIXy51/88pZbb8a
	 2bnFAISVcSnOQzW9E5C5ol9PqogpkwNLeK9ZMIx/edHw78d9aDjyUgHg0MJl3nuoYY
	 wu0g6nQQreXRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CB42ED8C97D;
	Fri, 16 Feb 2024 08:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net-next 0/9] ionic: add XDP support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170807342882.14240.8262323137715362250.git-patchwork-notify@kernel.org>
Date: Fri, 16 Feb 2024 08:50:28 +0000
References: <20240214175909.68802-1-shannon.nelson@amd.com>
In-Reply-To: <20240214175909.68802-1-shannon.nelson@amd.com>
To: Nelson@codeaurora.org, Shannon <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, brett.creeley@amd.com,
 drivers@pensando.io

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 14 Feb 2024 09:59:00 -0800 you wrote:
> This patchset is new support in ionic for XDP processing,
> including basic XDP on Rx packets, TX and REDIRECT, and frags
> for jumbo frames.
> 
> Since ionic has not yet been converted to use the page_pool APIs,
> this uses the simple MEM_TYPE_PAGE_ORDER0 buffering.  There are plans
> to convert the driver in the near future.
> 
> [...]

Here is the summary with links:
  - [v4,net-next,1/9] ionic: set adminq irq affinity
    https://git.kernel.org/netdev/net-next/c/c699f35d658f
  - [v4,net-next,2/9] ionic: add helpers for accessing buffer info
    https://git.kernel.org/netdev/net-next/c/97538c146cca
  - [v4,net-next,3/9] ionic: use dma range APIs
    https://git.kernel.org/netdev/net-next/c/d67ee210dafd
  - [v4,net-next,4/9] ionic: add initial framework for XDP support
    https://git.kernel.org/netdev/net-next/c/180e35cdf035
  - [v4,net-next,5/9] ionic: Add XDP packet headroom
    https://git.kernel.org/netdev/net-next/c/f81da39bf4c0
  - [v4,net-next,6/9] ionic: Add XDP_TX support
    https://git.kernel.org/netdev/net-next/c/8eeed8373e1c
  - [v4,net-next,7/9] ionic: Add XDP_REDIRECT support
    https://git.kernel.org/netdev/net-next/c/587fc3f0dceb
  - [v4,net-next,8/9] ionic: add ndo_xdp_xmit
    https://git.kernel.org/netdev/net-next/c/26f5726a7857
  - [v4,net-next,9/9] ionic: implement xdp frags support
    https://git.kernel.org/netdev/net-next/c/5377805dc1c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



