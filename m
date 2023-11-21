Return-Path: <netdev+bounces-49584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F87E7F2914
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 10:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09696281F44
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 09:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD7138DC1;
	Tue, 21 Nov 2023 09:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KukXidsW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0021D695
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 09:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AFF62C433C7;
	Tue, 21 Nov 2023 09:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700559623;
	bh=GKaCEsuN2a26DWqLwo7f7sJIvXyNSbixPwgr7S2T4oQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KukXidsWExih6YhB33+yRukb6Bb79ecm3ZWnata59gdf+38j1It0/VBZApn/YYlii
	 jiEk7iemmTDEuWBazjo9w0QWVKqk2fitcUfdqsAncFc10VfWOzXHgUaV1C7UXsKEtt
	 c40sv8s657jktZH3GIqQRX6bezDyERC8v1xdBHewbMFSA4P9iWkmfoX3VuX3ofdzP9
	 oMFi9j+5SXpNGnhxv7b5KnOAidSZyW8CB7s88Au/NY3arVsh/MBCFkeDAE51pWkwms
	 1NL6pKqp6B/tf+wfHj+lFnyN9xDg30TvjguPxhARjP4c6+o5nSOI9uGaEmlp3YyLf/
	 5Hrqme9YexaTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 951B1EAA955;
	Tue, 21 Nov 2023 09:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] octeon_ep: support Octeon CN10K devices
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170055962360.22415.12175732590141368949.git-patchwork-notify@kernel.org>
Date: Tue, 21 Nov 2023 09:40:23 +0000
References: <20231117103817.2468176-1-srasheed@marvell.com>
In-Reply-To: <20231117103817.2468176-1-srasheed@marvell.com>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hgani@marvell.com,
 vimleshk@marvell.com, egallen@redhat.com, mschmidt@redhat.com,
 pabeni@redhat.com, horms@kernel.org, kuba@kernel.org, davem@davemloft.net,
 wizhao@redhat.com, konguyen@redhat.com, edumazet@google.com, corbet@lwn.net,
 vburru@marvell.com, sedara@marvell.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 17 Nov 2023 02:38:10 -0800 you wrote:
> Add PCI Endpoint NIC support for Octeon CN10K devices.
> CN10K devices are part of Octeon 10 family products with
> similar PCI NIC characteristics. These include:
> - CN10KA
> - CNF10KA
> - CNF10KB
> - CN10KB
> 
> [...]

Here is the summary with links:
  - [net-next,v1] octeon_ep: support Octeon CN10K devices
    https://git.kernel.org/netdev/net-next/c/0807dc76f3bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



