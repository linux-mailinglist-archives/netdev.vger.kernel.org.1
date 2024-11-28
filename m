Return-Path: <netdev+bounces-147775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B369DBB9D
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 18:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7851280A91
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 17:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2E51A9B4D;
	Thu, 28 Nov 2024 17:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qeGV3osD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4626977111
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 17:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732813218; cv=none; b=XhkO7dSmK7IGfhv6+p3XsXsM+55CURko1OIKVIQi0Fn5dYIujL8DHp5OpZufLubSabEDVtoPDlkbEOaSl38BDOYtKiIbNWB5sJOY/NMRVr4Uq+a9O99vOFKpDewItxst4Tbv3bvQUICmYI6oDnadKAjLG1EjzSiBhzfGXzrMG1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732813218; c=relaxed/simple;
	bh=2asuz6NoBYqxNK+D6nc7MiphD/K35xEX5AaB94XUrWA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZfMJakCGBgnyi5Z1IR3bN7uK5DXWSD9JcjXed0mI/EMmGkGfrKnv6Rr5M9Fu+U9KgEwBisVyjGpgoUvaWvGav1GK+b0xyJA5LXq76u0fSxsyy0GKALgqwEIsC3Q9Kk6LF1bIrkFdHM2C90ZDdvtX1hDW2saiI5p7NACEVgcrSx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qeGV3osD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB64AC4CECE;
	Thu, 28 Nov 2024 17:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732813216;
	bh=2asuz6NoBYqxNK+D6nc7MiphD/K35xEX5AaB94XUrWA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qeGV3osD5VXdORSzcKdx5G1MTQmYqzQtCCuCcQI/zsTBmkGClTbvOrJYdKvkbhFvA
	 0rh8AAoSElx9DR1f1en/s4zSoFvtElKWv+cf2q+1E8e4zg/c3sAAPCpc1OD4+iow/3
	 Po+wK0+w2e051P3umM7NfxY2lp4ce0ZCkFkjkNpZKY8UPH1fChv7tysNJ6tLieJvC6
	 oO+8bdramM19iYcf30jEfYO34PPqZqi4PpM4lQVOFow9tflk6GvjQrb4yIcjDUVYSV
	 rgc3Got2t3dPvp/DVhZ5nbjKPJ8RAFdPxoVajenffvTOl2ta+pNDjGPKV5K+foS+4J
	 /5x7a79edINlg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34C6A380A944;
	Thu, 28 Nov 2024 17:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipmr: fix build with clang and DEBUG_NET disabled.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173281323001.1797424.18250480682649507687.git-patchwork-notify@kernel.org>
Date: Thu, 28 Nov 2024 17:00:30 +0000
References: <ee75faa926b2446b8302ee5fc30e129d2df73b90.1732810228.git.pabeni@redhat.com>
In-Reply-To: <ee75faa926b2446b8302ee5fc30e129d2df73b90.1732810228.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org, sashal@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 28 Nov 2024 17:18:04 +0100 you wrote:
> Sasha reported a build issue in ipmr::
> 
> net/ipv4/ipmr.c:320:13: error: function 'ipmr_can_free_table' is not \
> 	needed and will not be emitted \
> 	[-Werror,-Wunneeded-internal-declaration]
>    320 | static bool ipmr_can_free_table(struct net *net)
> 
> [...]

Here is the summary with links:
  - [net] ipmr: fix build with clang and DEBUG_NET disabled.
    https://git.kernel.org/netdev/net/c/f6d7695b5ae2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



