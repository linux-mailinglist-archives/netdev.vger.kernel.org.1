Return-Path: <netdev+bounces-83886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 930BC894AB5
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 07:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C68D1F24694
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 05:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2FF18042;
	Tue,  2 Apr 2024 05:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVBROVw9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80DA18035
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 05:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712034029; cv=none; b=JKYjNG7dbjXqe0AmfiCvdhLug+qIQJvPVQw+Q65/5RKXk7x8tDZqExDty5Hl58HM3aqLatvDsLN3gTKrZUuy0xqbSskGlC6KIJhcgoM7xe+4YPMFL2nbL7TtssPlExxXBa1jyCC+albv3fyYUW07Bw2n2VMOLPuw0gu/BULB3wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712034029; c=relaxed/simple;
	bh=rEFW4wGi8qx/sLAewRTdZlOBk+0BUrrVQ3dTtx7hfco=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ty012UOSYyXHse0DSCjLEIGb90+3TpcMNZ1TK83FOUShfD2xw6nsKD5KjlcC7wwSvj3QhbMRHLBuWi4futqd/OBXC+l4psj+UTEyl5eL5Ked2diGCazy3L7igJ6oKeU73lWv9onZbhTIMErju7YNv27i4LNawYHFkur5O3G6aHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVBROVw9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F0FFC43394;
	Tue,  2 Apr 2024 05:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712034029;
	bh=rEFW4wGi8qx/sLAewRTdZlOBk+0BUrrVQ3dTtx7hfco=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jVBROVw9FlEagtqT0Ne6HhZsITEiX5mBAJCvV7qi+m59EYmYBzmu07VyM9Km0C2rt
	 qBYw6/BawPPG76XwEH5Xa0jepaG8TEjzZHKt0pWKid9TD/uaRKFVj2+GjEmjSm+cCq
	 ByZvNyGvPgdrrQuiaAhS2BqS/XIHbpesDsO9TF9cwIsXygyflFTRVoE5R2hOh+HuYt
	 PIiVGptQwWerSNHL9zrPkpNgh5R4v2w6CVgog/GexCXIvGI3On1gWprY71wPDGAstL
	 UHktcWtk7GrfMTl1E5MTxedzoVdb6ePO8zHxd8CKhPohhp3XQXMh/VTXbHLJCDxYyW
	 VbzKNNnK2aAQA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3E99CD9A158;
	Tue,  2 Apr 2024 05:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv6: remove RTNL protection from inet6_dump_fib()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171203402925.17077.9636282571913518612.git-patchwork-notify@kernel.org>
Date: Tue, 02 Apr 2024 05:00:29 +0000
References: <20240329183053.644630-1-edumazet@google.com>
In-Reply-To: <20240329183053.644630-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, dsahern@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 Mar 2024 18:30:53 +0000 you wrote:
> No longer hold hold RTNL while calling inet6_dump_fib().
> 
> Also change return value for a completed dump,
> so that NLMSG_DONE can be appended to current skb,
> saving one recvmsg() system call.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: David Ahern <dsahern@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] ipv6: remove RTNL protection from inet6_dump_fib()
    https://git.kernel.org/netdev/net-next/c/5fc68320c1fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



