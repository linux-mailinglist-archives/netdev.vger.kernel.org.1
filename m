Return-Path: <netdev+bounces-193797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DC5AC5EBD
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 03:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B26D1BA69A0
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 01:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F111EA7C4;
	Wed, 28 May 2025 01:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q49m/1j2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3421E9B35
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 01:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748395218; cv=none; b=Chojlgz/PGyL5uwKfNis3CYsQ/HLB2djLqLODuNBKyoHIq3H6p7ZMevminxaDBmGFxCi4qYwUO4ratEKz5nB0vdq3CGR8N08Jwdv+xZA0H3hX/pc+vnq5owpZ1IKBRjeUnNjYzi4gfiamj61/q9tMGAmwg2cLw8ybFaJngCnb1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748395218; c=relaxed/simple;
	bh=lUI5kno9Izyk6PXqmeTE3Y/5fa2mvdBKgiqN8c47G78=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O3UTFShoS3kWZnzm1nt3nWuy/2VzgaPhePVOoZ/DIg5LvxL87Feho/O3r+6qPIWmm9N+uIpYNkTR2HyQwB/qfunxCZPP5xi5NSjf1E4oGH4AL5nLZ3D9JhXAIjSzvDS7mzBt3H6eufb8FDPoEGXOmgXq1qjWQfz8gOyruQBqwp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q49m/1j2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB14C4CEE9;
	Wed, 28 May 2025 01:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748395218;
	bh=lUI5kno9Izyk6PXqmeTE3Y/5fa2mvdBKgiqN8c47G78=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q49m/1j2GYUaGo9spD2/PugF2lVjnmYH2PjVe4DYV5kwHCpQlzqbo606RKrOzHlGx
	 QZWQJWg+2Ox9SolSkVyZVVxbw7MUKLX+aoiebuhxIkMsbQNHh8xWu4w8NIgN8KJzGk
	 LBZG460kcSzxlfBIAeinIU/nWlEDsNB5Ydw3nURw2nmcBPU5y5fTlmrpVHZr4zadDz
	 Hc68WIUVDqYYk9HPn5ZRzNSlPf5VA7/s4Hhc9TI5X9XjpIQ9nvZL/b6v1+8V/Xup1T
	 TysyFtqGOvyxYTVSyKVTHHXO/cNMWjQrAoE6E3azDSKHzNkpw+gylrcFI30FNxGoRL
	 /IObInc0FOF1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E8B380AAE2;
	Wed, 28 May 2025 01:20:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] tools: ynl: parse extack for sub-messages
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174839525200.1849945.12711546934451965416.git-patchwork-notify@kernel.org>
Date: Wed, 28 May 2025 01:20:52 +0000
References: <20250523103031.80236-1-donald.hunter@gmail.com>
In-Reply-To: <20250523103031.80236-1-donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 jstancek@redhat.com, arkadiusz.kubalewski@intel.com, sdf@fomichev.me,
 donald.hunter@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 May 2025 11:30:31 +0100 you wrote:
> Extend the Python YNL extack decoding to handle sub-messages in the same
> way that YNL C does. This involves retaining the input values so that
> they are available during extack decoding.
> 
> ./tools/net/ynl/pyynl/cli.py --family rt-link --do newlink --create \
>     --json '{
>         "linkinfo": {"kind": "netkit", "data": {"policy": 10} }
>     }'
> Netlink error: Invalid argument
> nl_len = 92 (76) nl_flags = 0x300 nl_type = 2
> 	error: -22
> 	extack: {'msg': 'Provided default xmit policy not supported', 'bad-attr': '.linkinfo.data(netkit).policy'}
> 
> [...]

Here is the summary with links:
  - [net-next,v1] tools: ynl: parse extack for sub-messages
    https://git.kernel.org/netdev/net-next/c/09d7ff0694ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



