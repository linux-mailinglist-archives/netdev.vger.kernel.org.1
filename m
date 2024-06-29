Return-Path: <netdev+bounces-107870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C137C91CA83
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 04:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27BC92842B7
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 02:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A916AAD;
	Sat, 29 Jun 2024 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m63CdAjT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E77370
	for <netdev@vger.kernel.org>; Sat, 29 Jun 2024 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719627632; cv=none; b=qPyk9jhgBXUccZNEK7ylakg5d3OVTQgk/JRt1zoYoWHADajTnzeIFyFA3dcI54mf4ZOx7TTXN6NroAAKXDbZ7n+iH1P+cD1fGeSeKWykYfjCpS0e3hGHwdzHRRg1mOsjnbLiPgCuku+lF14UyUBFSglplBIwZS4vDSrFlM2B008=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719627632; c=relaxed/simple;
	bh=lepPfqX7JNOwH0nwhdLhzIQp2WFVg0uSbljOavoXkC0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j5VqY3jICbeqeSkbFJtAJioIM3zjU+9fS4wwPgydqrjqMCbDRL15IYCA6Ibk/Nu7UomN9V453f6dWFIiGdXnAqHXb4XE1F/LCIto1f4nGRZqextm1SC4Xbos7uk80iDda6iMAREaLK149r+0LcRRx/oFhZ3V9McbADoXjSVjpwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m63CdAjT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8A0DC32786;
	Sat, 29 Jun 2024 02:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719627632;
	bh=lepPfqX7JNOwH0nwhdLhzIQp2WFVg0uSbljOavoXkC0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m63CdAjTUoUoLajdJXrLMNHyGp1WvADtX5dKxGo6WqQTB8zVh2HBSAPA3mGZ3Drhe
	 0VT7nq/XmLs8jyHlXoia4lALJufKBXSb4XlVrNzV1KNiKDI9B/ztlZYpEiiHw1ev6j
	 CZ3AP1CqsRuYCSCWRfis2a03HQGAoef0N8IfGF0tQ9sA0K3s0KUlVXzG5zk4OeB/Ag
	 R5aniTT7w0WSHH0YTkkTUUYAWo4MYEyCyx5WelJMns9Zk1hLMnbT3GBakZEuG4v7cs
	 MHoM4h2BALhDU+dZO/IxM4TYJxeGg3E5GsMsq8pVza1fqowI9fowfLExKFaUjFbAnN
	 41OEYgnXANDQg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D4504C43443;
	Sat, 29 Jun 2024 02:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 net-next 0/9] ethtool: track custom RSS contexts in the
 core
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171962763186.30239.4881356378367477530.git-patchwork-notify@kernel.org>
Date: Sat, 29 Jun 2024 02:20:31 +0000
References: <cover.1719502239.git.ecree.xilinx@gmail.com>
In-Reply-To: <cover.1719502239.git.ecree.xilinx@gmail.com>
To:  <edward.cree@amd.com>
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, ecree.xilinx@gmail.com,
 netdev@vger.kernel.org, habetsm.xilinx@gmail.com,
 sudheer.mogilappagari@intel.com, jdamato@fastly.com, mw@semihalf.com,
 linux@armlinux.org.uk, sgoutham@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, hkelam@marvell.com, saeedm@nvidia.com, leon@kernel.org,
 jacob.e.keller@intel.com, andrew@lunn.ch, ahmed.zaki@intel.com,
 horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Jun 2024 16:33:45 +0100 you wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Make the core responsible for tracking the set of custom RSS contexts,
>  their IDs, indirection tables, hash keys, and hash functions; this
>  lets us get rid of duplicative code in drivers, and will allow us to
>  support netlink dumps later.
> 
> [...]

Here is the summary with links:
  - [v8,net-next,1/9] net: move ethtool-related netdev state into its own struct
    (no matching commit)
  - [v8,net-next,2/9] net: ethtool: attach an XArray of custom RSS contexts to a netdevice
    https://git.kernel.org/netdev/net-next/c/6ad2962f8adf
  - [v8,net-next,3/9] net: ethtool: record custom RSS contexts in the XArray
    https://git.kernel.org/netdev/net-next/c/eac9122f0c41
  - [v8,net-next,4/9] net: ethtool: let the core choose RSS context IDs
    https://git.kernel.org/netdev/net-next/c/847a8ab18676
  - [v8,net-next,5/9] net: ethtool: add an extack parameter to new rxfh_context APIs
    https://git.kernel.org/netdev/net-next/c/30a32cdf6b13
  - [v8,net-next,6/9] net: ethtool: add a mutex protecting RSS contexts
    https://git.kernel.org/netdev/net-next/c/87925151191b
  - [v8,net-next,7/9] sfc: use new rxfh_context API
    https://git.kernel.org/netdev/net-next/c/a9ee8d4a97d8
  - [v8,net-next,8/9] net: ethtool: use the tracking array for get_rxfh on custom RSS contexts
    https://git.kernel.org/netdev/net-next/c/7964e7884643
  - [v8,net-next,9/9] sfc: remove get_rxfh_context dead code
    https://git.kernel.org/netdev/net-next/c/b859316e8218

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



