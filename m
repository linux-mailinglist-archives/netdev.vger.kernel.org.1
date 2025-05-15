Return-Path: <netdev+bounces-190866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D721AB9260
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 00:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ECE1503CD3
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 22:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0A128A1CD;
	Thu, 15 May 2025 22:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQjxksXK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8492D274668
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 22:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747349392; cv=none; b=J/M5NWaANTA1uCXsug0T4oDHq65eLIpvYR+e53C9Wt7oxw3d+F+Rr+yVqTyyvFyNWNHbVL0BdwP0m9+FqD9q25cmFXUOickzAZ+qS4bmbVG4RNKF0OXWLNg/S9+8k1DKZrCPki9bFPPfBgvJ4quaMVWXMvFh3teBUxugzjwolBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747349392; c=relaxed/simple;
	bh=UhPF+X0PVndTlPsWdxJTHGvO1BKahjJ8QBG+GAGduco=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pf8lQCIGRwb8xAxG6AhtCliGWRe5ioXrmcknThFPK2x2276n8cBgb4PVnJrGbDPKywH/8nKNQKhpyJR/Xq0xpVK2Q9mAoGdkejI1VhWSEwtHZqe1Oii/efBElZ4scNL2aX7v6SMh+Q5gHBixW8VvOTVg0QlJWUinPjwvX1a9mUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQjxksXK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F4FC4CEE7;
	Thu, 15 May 2025 22:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747349392;
	bh=UhPF+X0PVndTlPsWdxJTHGvO1BKahjJ8QBG+GAGduco=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gQjxksXK/fRs+IZWO3O4pidIVy2GhIZVdd60CmgvSrz95OmqcLvdNL1t0U/waNsvS
	 Qy0HY7gdO11ENAGObv8PwGvNxG0AXwjJFVGcbsa8pkMMrJlDnQBGE0SugC1RxnCX0y
	 GFbRHHlxwEpBhz/KQkfEEVJtifDYwvh7pDx5EXQ8G4uohO0DJnO0xGx54MEnB9YUuT
	 rrMV4qXauOExZntFxZopuCb8OEpa0HKR89ZmRyWIhs/oUq0npb9oAlrMDnPQKWJ56y
	 d2xhTcq3WHI53+aM9a/7AGsclI3/wfaZFeBTbfNaki71Y0v5c3ESpny+wIX/XIyDeZ
	 2swRt/HNMgfjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BCE3806659;
	Thu, 15 May 2025 22:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl-gen: array-nest: support arrays of nests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174734942900.3270983.15016085890494710655.git-patchwork-notify@kernel.org>
Date: Thu, 15 May 2025 22:50:29 +0000
References: <20250513222011.844106-1-kuba@kernel.org>
In-Reply-To: <20250513222011.844106-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, jacob.e.keller@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 May 2025 15:20:11 -0700 you wrote:
> TC needs arrays of nests, but just a put for now.
> Fairly straightforward addition.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Sorry for trickling out random changes, I need
> 396786af1cea ("tools: ynl-gen: Allow multi-attr without nested-attributes again")
> to reach net-next before I post submsg support. Otherwise there
> will be a conflict.
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynl-gen: array-nest: support arrays of nests
    https://git.kernel.org/netdev/net-next/c/87948df5af4b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



