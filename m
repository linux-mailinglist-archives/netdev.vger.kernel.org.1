Return-Path: <netdev+bounces-117887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A6D94FAE7
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 03:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 908051F21E28
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 01:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3650115A8;
	Tue, 13 Aug 2024 01:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqEdhNTQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1206D138C
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 01:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723510835; cv=none; b=TDwYJTz2/iYw1xH8reqTrGoNOfTGObv9qdUmy3qqmRC1xh4OzyYzKmDr9MD/inKqu1BkRth/2oKsAQdrBqRzN5t2EWr2m+CSy2iG75y6EZZ7B55svvdr5TSE5OXVgpTG5j8gMjBs6OwZmKLiU3sm0NYkbILYkCqTkE7YucF3Nlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723510835; c=relaxed/simple;
	bh=Nwue0W/iWy59UCjXMHvUtXSOObkFYI2ormHJmJ/55jU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e6J8XFiukNYXAK6NyINWt3hoq018xH9HGri6tdRNEJTsC4L+ZiXRhxjxYqyAqlc7c+jHp24mZEBQNfR4nJAV2NFk1dMyQbkPPVUbNXk+YTvhs1RJ8WAz6Y6P3Zv5dn+h7G09TsUo1uZ/3ITpWRkfr8vaQdHGarrv9DrXiu1bmRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqEdhNTQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC7FC4AF0D;
	Tue, 13 Aug 2024 01:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723510834;
	bh=Nwue0W/iWy59UCjXMHvUtXSOObkFYI2ormHJmJ/55jU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EqEdhNTQTZ47g7ZSLC5FmMj2c67z+p6gIT8DlxFs/hdT86PuQhlrvlgX67iQDCdYA
	 eXZcMKstkh5MZh5TkMlZME+8L6/np7YbLubOe91RiJD/R295fJ3Gk7ZSYn8IVMU7l4
	 2nrdOgeJQhVCNFlKi1uF+pzapDI7N//WmNcueO0Y2bZWfaRsuHv9TFyTgwiH9ET5j4
	 LPIucH5uPZcaPHvap83KMfQ/J83p3fLgVvPH5LdAG58+CDa2Y/iDHr+mtmqFgyGHJn
	 w86gtxGwWv4MvD40W1aFwN84tOCXofgcn+1OVkJBeXCrIin2YKExXTy51dW9fQB57X
	 XkIEFS5yAtjjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE7C382332D;
	Tue, 13 Aug 2024 01:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/6] net: nexthop: Increase weight to u16
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172351083351.1180801.8605860552440119209.git-patchwork-notify@kernel.org>
Date: Tue, 13 Aug 2024 01:00:33 +0000
References: <cover.1723036486.git.petrm@nvidia.com>
In-Reply-To: <cover.1723036486.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 dsahern@kernel.org, sharpd@nvidia.com, horms@kernel.org,
 przemyslaw.kitszel@intel.com, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 7 Aug 2024 16:13:45 +0200 you wrote:
> In CLOS networks, as link failures occur at various points in the network,
> ECMP weights of the involved nodes are adjusted to compensate. With high
> fan-out of the involved nodes, and overall high number of nodes,
> a (non-)ECMP weight ratio that we would like to configure does not fit into
> 8 bits. Instead of, say, 255:254, we might like to configure something like
> 1000:999. For these deployments, the 8-bit weight may not be enough.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/6] net: nexthop: Add flag to assert that NHGRP reserved fields are zero
    https://git.kernel.org/netdev/net-next/c/75bab45e6b2d
  - [net-next,v2,2/6] net: nexthop: Increase weight to u16
    https://git.kernel.org/netdev/net-next/c/b72a6a7ab957
  - [net-next,v2,3/6] selftests: router_mpath: Sleep after MZ
    https://git.kernel.org/netdev/net-next/c/110d3ffe9d2b
  - [net-next,v2,4/6] selftests: router_mpath_nh: Test 16-bit next hop weights
    https://git.kernel.org/netdev/net-next/c/bb89fdacf99c
  - [net-next,v2,5/6] selftests: router_mpath_nh_res: Test 16-bit next hop weights
    https://git.kernel.org/netdev/net-next/c/dce0765c1d5b
  - [net-next,v2,6/6] selftests: fib_nexthops: Test 16-bit next hop weights
    https://git.kernel.org/netdev/net-next/c/4b808f447332

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



