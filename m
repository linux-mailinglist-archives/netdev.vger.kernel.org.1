Return-Path: <netdev+bounces-132200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4480C990F98
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F171EB30BDC
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 19:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68E91B4F34;
	Fri,  4 Oct 2024 18:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqHqaNcI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B5A1B4F39
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 18:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728067829; cv=none; b=Bx6M0ylHeanshr6EOvydK2AKlvN0bHA9/XOgB8YNtKE2FuRpo1u4tlCudtiJZwfYbxtuik4w8H6Na8bpRDrzwwRkzj9Lf6pnXmSu1DzyH5CZT9wU6Br0ePPfI1KELYQIcgIO+RLA4d3NKkXGV6QNOBH7/mi/wRNdGXl0ymvfBaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728067829; c=relaxed/simple;
	bh=CdOK7sOFcbmsj4RzPLtzaOkwxekgzEb+16cLHurEIxI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Wy8Zb3Vl2GZJHzXXMUef1EyoR1jciNnvwFh5L1NADyncA2/NnxRNkLg+cjXzrnILSUY/cmy5YX/tiNc2Mr4Af2wKVIbqLL7mH26e4o8uQVwsagkiVR/TaNamPubF74GEBjViL5wd6wWXTeYQfOb4fB1UOc0YzYXK/1URkSSLxGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqHqaNcI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA50C4CEC6;
	Fri,  4 Oct 2024 18:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728067829;
	bh=CdOK7sOFcbmsj4RzPLtzaOkwxekgzEb+16cLHurEIxI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FqHqaNcIzyJObTuqx3ivm72dmIZSqADJi3vwpWw+QlINZrBatJ9YGmtfJozODkxs+
	 CFS4yBRGluXiMh3/fa3O+eW4JCl04laSzT4eZMLmV0Q6C+Kkbh1OQjQh/ZT5Q/SThj
	 7UZKArhUE1FTs3c664YW2Ds7bdvn9q/pRT3enVsv/D4BqVqUqnfmtFROWENKwp2gCd
	 heKy92NH+OqbH7qASOqTbIdH9vnugV8NeLxBhNXrK4JFlvQjoK31+bSJjh9hMw7+Nm
	 d5Lg3dE6oTLL9Fpp6twW/PwO9nzYtsDeYeiOdfKJFLpdPkQK+BTUrEEi/YBkDznsfJ
	 M7dPQlB1T/+nQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB58339F76FF;
	Fri,  4 Oct 2024 18:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V2 0/6] net/mlx5: hw counters refactor
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172806783278.2702115.5875013842003790101.git-patchwork-notify@kernel.org>
Date: Fri, 04 Oct 2024 18:50:32 +0000
References: <20241001103709.58127-1-tariqt@nvidia.com>
In-Reply-To: <20241001103709.58127-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, saeedm@nvidia.com,
 gal@nvidia.com, leonro@nvidia.com, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 1 Oct 2024 13:37:03 +0300 you wrote:
> This is a patchset re-post, see:
> https://lore.kernel.org/netdev/20240815054656.2210494-7-tariqt@nvidia.com/T/
> 
> In this patchset, Cosmin refactors hw counters and solves perf scaling
> issue.
> 
> Series generated against:
> commit c824deb1a897 ("cxgb4: clip_tbl: Fix spelling mistake "wont" -> "won't"")
> 
> [...]

Here is the summary with links:
  - [net-next,V2,1/6] net/mlx5: hw counters: Make fc_stats & fc_pool private
    https://git.kernel.org/netdev/net-next/c/5acd957a986c
  - [net-next,V2,2/6] net/mlx5: hw counters: Use kvmalloc for bulk query buffer
    https://git.kernel.org/netdev/net-next/c/10cd92df833c
  - [net-next,V2,3/6] net/mlx5: hw counters: Replace IDR+lists with xarray
    https://git.kernel.org/netdev/net-next/c/918af0219a4d
  - [net-next,V2,4/6] net/mlx5: hw counters: Drop unneeded cacheline alignment
    https://git.kernel.org/netdev/net-next/c/d95f77f1196a
  - [net-next,V2,5/6] net/mlx5: hw counters: Don't maintain a counter count
    https://git.kernel.org/netdev/net-next/c/4a67ebf85f38
  - [net-next,V2,6/6] net/mlx5: hw counters: Remove mlx5_fc_create_ex
    https://git.kernel.org/netdev/net-next/c/d1c9cffe4b01

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



