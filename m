Return-Path: <netdev+bounces-106562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78502916D48
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 17:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A998E1C20CFA
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 15:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFDC16DEB3;
	Tue, 25 Jun 2024 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hwz6AX8Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BBE157461
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 15:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719330030; cv=none; b=qX5zC6ao+Ai+LS9ygEf1rD+i/2bXjv5nCs9LuCBhuBiWXrNhsQ9vrTqywLxCv4MjKY61Q75CybK6f209Mxaf7aQr1NTvFL/hPPjIDmnLNHlUsjN36HJWxUmKl7bTK7m7m3dUknVd6+IztMXpJ9dDsNVRBIu9V54CkR+ZnkyiGJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719330030; c=relaxed/simple;
	bh=OedEXoXD+ebvygGChkel9aAWZFxR717SVtGPC7T6Z6E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QkPA5UsQGGfuN/qjDAotWbh2WAMBXWt7S6n9Nk8c6ugY53GMkUBchuuyJpdwROCEgOlpEeCAEpm2dCeWWFwZzeunqmUzu9neWYM3IS6MPLY6bC+WlXYHt0/3VJuiCMn1AFfuqPISP00k+e3Bmr9JPnwMN4JchculmqYug2SNg+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hwz6AX8Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5955C32786;
	Tue, 25 Jun 2024 15:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719330029;
	bh=OedEXoXD+ebvygGChkel9aAWZFxR717SVtGPC7T6Z6E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hwz6AX8ZxZElDxIgASZlf4NhtBYgDwqS1EaIarJbcLWmIVypwbuBFaiKFC7p+1wVC
	 8vlqZI/GLaDbRQ6imZfwNGiF1kfKXk3ngYtUmwwH6YNTUbq1SKCrMg80/XUV+KdmnK
	 oT4FzabF6E5xk3hDBI83KfGUVB9gi+tLs/cJHbsb2Ip8PhnqcnP3aoa20/GSYDtEEZ
	 f4OElchDxqMoSQcSY8PBVHzu3m4dHpUrRF4i9UoCP90RLe2jqXtk8oW4Kx+N+Uut0x
	 h2Nkjfz+a8C0bo4a0ELRZ3KgBchkLai4UnQ2D56rFoWcJhM9FcxcEGb9ifInjIYZqN
	 CSySx6ff7F0RA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AADB6C43638;
	Tue, 25 Jun 2024 15:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] l2tp: remove incorrect __rcu attribute
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171933002969.6467.170416176909145450.git-patchwork-notify@kernel.org>
Date: Tue, 25 Jun 2024 15:40:29 +0000
References: <20240624082945.1925009-1-jchapman@katalix.com>
In-Reply-To: <20240624082945.1925009-1-jchapman@katalix.com>
To: James Chapman <jchapman@katalix.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, tparkin@katalix.com,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, lkp@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Jun 2024 09:29:45 +0100 you wrote:
> This fixes a sparse warning.
> 
> Fixes: d18d3f0a24fc ("l2tp: replace hlist with simple list for per-tunnel session list")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406220754.evK8Hrjw-lkp@intel.com/
> Signed-off-by: James Chapman <jchapman@katalix.com>
> 
> [...]

Here is the summary with links:
  - [net-next] l2tp: remove incorrect __rcu attribute
    https://git.kernel.org/netdev/net-next/c/a8a8d89dbd2b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



