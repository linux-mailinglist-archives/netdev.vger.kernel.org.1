Return-Path: <netdev+bounces-195077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 929B4ACDCCE
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 13:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 712423A58E4
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 11:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D24A28ECEA;
	Wed,  4 Jun 2025 11:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="suV3Xt94"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557B828ECE5;
	Wed,  4 Jun 2025 11:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749037196; cv=none; b=I0lVLcnDLGU7y19UFyK4uJ+nV6fmsPw7Lr9YllALJwILb+wVItpa2/MP7uxVrErZxdPOMnmLr+SDELxiYWSwsHBJt8G1J8EazLNMZYC8WtE0eDLU1i77dxUkdGZRBYlTtNTM6pVHiKiHiDS9SHoKjGh2wps0lDBR7BWH57kA6w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749037196; c=relaxed/simple;
	bh=f5sb3YV8qwEzrJRbbUo0eU1F2vSViH0WxMz1v6VOMKA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RSR00xdthOItkMPuGuJusCoCeE9Erj/21qP1FsHHLbPqAYMBETECDoVoTrSVa+TVHq0182z1uDDujd98db2pAw04ClndNXBQa3+W7wMNi2Ecp/IQ+vnD9voYsDhL2jp47WQVLJUFcxYEL7od8E2U/OPoXBSDlwW+bk4pMagEttA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=suV3Xt94; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B946AC4CEE7;
	Wed,  4 Jun 2025 11:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749037195;
	bh=f5sb3YV8qwEzrJRbbUo0eU1F2vSViH0WxMz1v6VOMKA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=suV3Xt94XZ0j5pd1qxnjcqnX63gG9D709HAX+kcJPaKQ3RzfUNRbbE1jxBaq+nkCl
	 oduer5jd7f49zsB6uKoeWPBRGluK22AlgTl58dGkJAHS8vftT/GLk1mIh+nieWoLrJ
	 0y45gcpyQ6HVER32f3Hclin6B/zLcQeekptpi49+xGcOAvfbhbe0jlMqOKkodc+8fO
	 i2RtOr8XQVovYo8pG0w6A0F7MaPt3BOTS5PnJvsJ31l2SXBxax1eBijyxv8+V74Rux
	 sJn7+ouf+dGfREsZVkGmyRJmr752Fj4LswpeyiONueC7Cet2fH8VuzXk9OEVwdcBYU
	 AYGBEW0lR1fag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C8D38111E5;
	Wed,  4 Jun 2025 11:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] gve: add missing NULL check for
 gve_alloc_pending_packet() in TX DQO
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174903722800.2252645.3715137704739506343.git-patchwork-notify@kernel.org>
Date: Wed, 04 Jun 2025 11:40:28 +0000
References: <20250602103450.3472509-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250602103450.3472509-1-alok.a.tiwari@oracle.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: almasrymina@google.com, bcf@google.com, joshwash@google.com,
 willemb@google.com, pkaligineedi@google.com, pabeni@redhat.com,
 kuba@kernel.org, jeroendb@google.com, hramamurthy@google.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, darren.kenny@oracle.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  2 Jun 2025 03:34:29 -0700 you wrote:
> gve_alloc_pending_packet() can return NULL, but gve_tx_add_skb_dqo()
> did not check for this case before dereferencing the returned pointer.
> 
> Add a missing NULL check to prevent a potential NULL pointer
> dereference when allocation fails.
> 
> This improves robustness in low-memory scenarios.
> 
> [...]

Here is the summary with links:
  - [net,v2] gve: add missing NULL check for gve_alloc_pending_packet() in TX DQO
    https://git.kernel.org/netdev/net/c/12c331b29c73

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



