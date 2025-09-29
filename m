Return-Path: <netdev+bounces-227192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79392BA9E9B
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 18:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 348743A0738
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 16:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74DD309EE8;
	Mon, 29 Sep 2025 16:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXIi7Xs6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00CA1F5847
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 16:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161616; cv=none; b=Q0Z8QV+x6x7Py9fj1KJjN1CRq9VYhYi19u3M7PVijNcdFiCuiVxUEOvKQE7uSEwUlUgOMAvfJfR/7cmCDkY6Ei21M9qsHPVAkYFVpdFJrVNYrmr/CbjQH0YPZINKGF4JCvyOty07sMydWkk3wnU4ES787Bo7kCuDmWACXiGRZEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161616; c=relaxed/simple;
	bh=gxqbybMCG27rYjbGGovKV2EtyUzLzfX8r4kGBQG0VM8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p4xN4DraAL7U60ZdCcIFlgxkYIQ8ICtN7hWuOEOuxngb3vUJADye/7ldSs9lupaRrkdQGl2RMfbKQ93ZI+dqYjhIBFdBVNOf3I6YF79HY8GHi+2FyfcRBICU7/VhZp+uv6f4nYFssj4wg4QKr90Pk3v/LP6LU+XmJHr7mTOey7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXIi7Xs6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268AEC4CEF4;
	Mon, 29 Sep 2025 16:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759161615;
	bh=gxqbybMCG27rYjbGGovKV2EtyUzLzfX8r4kGBQG0VM8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CXIi7Xs6gHCmKmN6XF9eE3OFhH/eDWUE5bHi6BJ5dCUybDyWASGN0FD09oLscQUY3
	 9O3uS1ocCfBV3caLH1mmGkTgXcSyRDv6FYTQDXosAhIM/SWmL0HjmEkS0r1M4/990P
	 jmI3nDMVxVye0cwxW44Uqpzmi9iEueS9bnj4+nVYbjwJGxTFFQbHtipN+MqTrHSZ2u
	 qG/0N1npPk1Sef6mDoPXCncpN6GuGqvMWLC29gVz1WxRb03nfbj8XuNRunLnS8pvfe
	 nIbnaXV16qgxX5Nn2tN18XvcCZ/qsTVFIQP+vCaaPzlbJDNqC1YDWWnWF0SLa/yQQz
	 lyi39m4V0X5Rw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBB8439D0C1A;
	Mon, 29 Sep 2025 16:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v3] ip: iplink_bridge: Support
 fdb_local_vlan_0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175916160876.1625635.16628239948699650647.git-patchwork-notify@kernel.org>
Date: Mon, 29 Sep 2025 16:00:08 +0000
References: 
 <d23fb4f116e5540afbd564e0e3a31d91eae42c60.1758209325.git.petrm@nvidia.com>
In-Reply-To: 
 <d23fb4f116e5540afbd564e0e3a31d91eae42c60.1758209325.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: idosch@nvidia.com, razor@blackwall.org, dsahern@kernel.org,
 netdev@vger.kernel.org, bridge@lists.linux-foundation.org

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Thu, 18 Sep 2025 17:39:26 +0200 you wrote:
> Add support for the new bridge option BR_BOOLOPT_FDB_LOCAL_VLAN_0.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
> 
> Notes:
>     v3:
>     - When printing the option, test optmask, not optval
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v3] ip: iplink_bridge: Support fdb_local_vlan_0
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=fc5f69b8f2c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



