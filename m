Return-Path: <netdev+bounces-117220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0167994D255
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 16:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A914B1F22FD6
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 14:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DCC194C6F;
	Fri,  9 Aug 2024 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dw+pDGui"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D611156676
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723214432; cv=none; b=R7qRTVjGrrnJ4qgXDb/oF3eg1rKLryzehXaYbfDb9Rq8X1Y+AD77Ceb01kwj9myU3Xa/nzVO0jj/q2FvpjnqjqtxaDgnTWeI7Qd+ztmLcPO+ahcIjqCkvEkELoO9bk0cUoy+/DunI92gXs5IOXZXnt/WrO4KH74fELGmukXsruw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723214432; c=relaxed/simple;
	bh=HLo0ejaYhNNyf2R2rE9udsFI/sfTp+3aJY856SA2+no=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a1IdFvAJrJhuKkgXLth/3ScRE9S7fUVxr0s0M0D94pXiGdszmA4i1RqB4nkpbTJmXsfxHvnk2evZKYBn0sNjn4EITPsrbkV5RFpvgilkBB6aqacOXHr7Ole+icUaHiPqHj3i3jO02iIjs78RNw22mKumscucYmE+/20cF8M3PnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dw+pDGui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3952C32782;
	Fri,  9 Aug 2024 14:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723214431;
	bh=HLo0ejaYhNNyf2R2rE9udsFI/sfTp+3aJY856SA2+no=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dw+pDGuixodUkW/wn29ZhbwKWqKy+km6Tz+XAN5NBF0hJzzJr/xFczWUSNe/l+oZo
	 rH+nnfzN3Cby5aQ30inFmPOic0t31hqSAe/aMNZGq22bX007MTkZRou7/SZdz0BXCh
	 MxI3mIwgxpjhKDh81Q6+WLx09z2YCqRPmQzMg+XOCYsQDElko2L6J/nsjeyHe+YbXJ
	 /kDHUNXiHWqir1X72O7v4Bqr79bqF60YJiGWzojSC6Vg9uA/jXuk76ejOAIPhNZkhn
	 iehQasAkEN0uQrLxPp3MzhlBmR80cmBzJcfO3fR7iW4mykPFX/lOqVb2tBSJbx5epm
	 Z9hv5FMfvVdPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD97382333D;
	Fri,  9 Aug 2024 14:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] ip/netkit: print peer policy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172321442979.3807691.11397075349377998172.git-patchwork-notify@kernel.org>
Date: Fri, 09 Aug 2024 14:40:29 +0000
References: <20240806105548.3297249-1-razor@blackwall.org>
In-Reply-To: <20240806105548.3297249-1-razor@blackwall.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, daniel@iogearbox.net,
 dsahern@kernel.org

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Tue,  6 Aug 2024 13:55:48 +0300 you wrote:
> Print also the peer policy, example:
> $ ip -d l sh dev netkit0
> ...
>  netkit mode l2 type primary policy blackhole peer policy forward
> ...
> 
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> 
> [...]

Here is the summary with links:
  - [iproute2-next] ip/netkit: print peer policy
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=354d8a368851

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



