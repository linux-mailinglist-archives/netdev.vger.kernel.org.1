Return-Path: <netdev+bounces-250423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F7FD2B07F
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 04:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77C1630141EA
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 03:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA38233B95D;
	Fri, 16 Jan 2026 03:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYkc96YG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67A130FF27
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 03:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768535630; cv=none; b=vA06JqIcNf+D22/bvp495C1IEk0MgBRHZ9aIVb4WCfTy9yNDRt1y1589q1/j90OLeAzRa6XS++3RYE2RtMoxg2d5NdkpLw4u2ej1en2y/wnG8egzsruPzGaFMtnI8VrGIe8dKg9V+DelPxOi3oLo/VOlzSnNuM7tRoXhvzEY5Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768535630; c=relaxed/simple;
	bh=9eVK5dg2IWoABOjkXyZMFHd1plBwcqSl53p5rx3/ft8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dvdFYKCP3Mmp4FmQANN6zVQnVL8Dnu7EO2XD2pYWOvZkONo4IvI3DduJNlIgz8QnquI714CKvjDsMSnA2ojfZvDSVnIKeNBSJH6102DEKf1iuzsZhHE9bYHfY5qNRJsgfS+i/59evJCaYoFnEyjOejODlp/31xiNPwL1ZB00Uh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYkc96YG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD04C116C6;
	Fri, 16 Jan 2026 03:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768535624;
	bh=9eVK5dg2IWoABOjkXyZMFHd1plBwcqSl53p5rx3/ft8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RYkc96YG8/PqjNi35rstsG/0ka3TRID/aAwCbQldbmpEOhsdRUU/P4Qy81Hn3kmN2
	 8aSuX/dLrRXR6jb9pJFguQPZYDILrgf2H/uMjt59XGaxXOoUWHODTWAaTOH7pRJIm4
	 +Q1Qm82zrRQ9aH5AOSfZ3Fb+GPXWzc3tG7BnnHXe4drvaEeKyYBk6PysaLdpDuVqXi
	 ZqFfmxm3+eFTNM7CgZMzzf5GfDtbUVw/0YNN3mHpvCgm3Mck2LnrjZonh+UGpee/4L
	 e8MamT5v5cPL+bpSdzecvMw3n21UFziSgFeG20dO2xUcfYqGN/ON2Hy/KxvaQO4Gou
	 QRCLMF6ffo2gg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2774380AA4C;
	Fri, 16 Jan 2026 03:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: add skb->data_len and (skb>end - skb->tail) to
 skb_dump()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176853541652.73880.3836381203116384890.git-patchwork-notify@kernel.org>
Date: Fri, 16 Jan 2026 03:50:16 +0000
References: <20260112172621.4188700-1-edumazet@google.com>
In-Reply-To: <20260112172621.4188700-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Jan 2026 17:26:21 +0000 you wrote:
> While working on a syzbot report, I found that skb_dump()
> is lacking two important parts :
> 
> - skb->data_len.
> 
> - (skb>end - skb->tail) tailroom is zero if skb is not linear.
> 
> [...]

Here is the summary with links:
  - [net] net: add skb->data_len and (skb>end - skb->tail) to skb_dump()
    https://git.kernel.org/netdev/net/c/220d89df1da6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



