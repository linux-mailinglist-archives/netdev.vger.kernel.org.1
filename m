Return-Path: <netdev+bounces-137408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 016FE9A60A1
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 11:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A36481F2251C
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 09:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C061E3DE5;
	Mon, 21 Oct 2024 09:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qb57PkJ3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A9F1E32AC;
	Mon, 21 Oct 2024 09:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504223; cv=none; b=D3gBzYnzRL8Ps5CC3kzeYxb9keus08biZUXTRts8XqKm1I3i42n/pQnVhW+PkeRZdmUgjeBg9f/+OVwrgN4OVWWhgmq9TJVVdJOX+2N9fi22Xtmc0YpQPPOtwPSjFBvJzimrUV0d+DK5DW281e5Oq9qqprb33y0NMAVh3RAHdr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504223; c=relaxed/simple;
	bh=EINqetAsJIKGinGmMOLN93gzlHvmLn/CfhjxCi/PMAI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uBWIvWZFVw7UknlHEsznDx5/TFV9QoRhLCOofn2L8JG4I42VQ6IUSjYD3mECbxYaeMfK6GCkt1Lcu6fyurvZXbGVsMrLsqKwTEEh7FdOBm7XPCg920th/Gea0x3FSWeNMLVb3UBbQoDIa+d04Vt7z4v03vEDo2V6/E3puJ76V9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qb57PkJ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46496C4CEC3;
	Mon, 21 Oct 2024 09:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729504223;
	bh=EINqetAsJIKGinGmMOLN93gzlHvmLn/CfhjxCi/PMAI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qb57PkJ3oAu1jPezwGNmdx8iAUb/e4kzDPSkZy9xZbhn9g2OsimK27K33bUcEXvfX
	 p2fzO3JlMBGA6lPV7hjPuwMn1OGOow2Yis+hxsSbniZ9fflpKplahq6iAsn+vEo0qQ
	 2DF0lRHPZrokkAbYzwLnazD2ZsaQhqyy3PaCun9PH3sKiy9+aTt7AMZy3nxbmiWzS7
	 mla3baFHGr1R5xGFM31dCqB2hNrvhXfL8ddKXLIIzTHn43UbuzRJkxiuaaUwK19N4x
	 dH3myWYf1sF4L6gwTzIQYaRBa1yjfBf/0mUBCGf/opbbnfLA8vGN1iMQ1NVM8DemmT
	 e2H0clFWsxwKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DEA3809A8A;
	Mon, 21 Oct 2024 09:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] net: wwan: fix global oob in wwan_rtnl_policy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172950422926.192458.11194707436275183429.git-patchwork-notify@kernel.org>
Date: Mon, 21 Oct 2024 09:50:29 +0000
References: <20241015131621.47503-1-linma@zju.edu.cn>
In-Reply-To: <20241015131621.47503-1-linma@zju.edu.cn>
To: Lin Ma <linma@zju.edu.cn>
Cc: loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 15 Oct 2024 21:16:21 +0800 you wrote:
> The variable wwan_rtnl_link_ops assign a *bigger* maxtype which leads to
> a global out-of-bounds read when parsing the netlink attributes. Exactly
> same bug cause as the oob fixed in commit b33fb5b801c6 ("net: qualcomm:
> rmnet: fix global oob in rmnet_policy").
> 
> ==================================================================
> BUG: KASAN: global-out-of-bounds in validate_nla lib/nlattr.c:388 [inline]
> BUG: KASAN: global-out-of-bounds in __nla_validate_parse+0x19d7/0x29a0 lib/nlattr.c:603
> Read of size 1 at addr ffffffff8b09cb60 by task syz.1.66276/323862
> 
> [...]

Here is the summary with links:
  - [net,v1] net: wwan: fix global oob in wwan_rtnl_policy
    https://git.kernel.org/netdev/net/c/47dd5447cab8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



