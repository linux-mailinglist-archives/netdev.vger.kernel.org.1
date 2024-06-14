Return-Path: <netdev+bounces-103431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE691908021
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 02:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FD5AB22407
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 00:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B500E81F;
	Fri, 14 Jun 2024 00:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGrfEOIF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DADB8479;
	Fri, 14 Jun 2024 00:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718324436; cv=none; b=YylYyFaOENm9TVsG+B5F1UhPi7uL92ydMEfCnwTp5pdADUj5nnBGbrf4uVs1W+NKGxFXNOvNwjjIC4gI/8Rvl2agbCip9wrCZ8uCMtW/xWDHoYuOoJrkBmCrlYRTsgx1tuI3tSDDqgm/A1/dc8EdKfiSm3QSwkwbFqaK5VwCpIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718324436; c=relaxed/simple;
	bh=DqPxIOYBLCXCh+MITcW8dIkxk9tEr18P4RVDpR6tuJI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UzjviIKAVuh9NEwAcGxC39JKBZXTgwU0po+riUQMBmTvnfpqav8kQq/rlwY7Nb6nDPbFxQik0Sq5Pjs2jqwApWnWhbt6nUhv3O9CqtzQzTeE1tvJsg0BAcx1Jw3Tj+fFEtU6BGeA26HseJ8fa5BpXFNRITRGLnOyORBbz1zPqFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGrfEOIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D333C4AF1C;
	Fri, 14 Jun 2024 00:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718324436;
	bh=DqPxIOYBLCXCh+MITcW8dIkxk9tEr18P4RVDpR6tuJI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XGrfEOIF5UGIZDkbkWRI8FYsQ9I6EGyP11ydZQ+lIE1D45VF9FgdSbS8DBPgosK6G
	 zXPSK+p/HD/xEik6DxnzQ27HY7Hsdqi9zj5pEfh2YZcplQ2MPaZ446BNpJlOlCDFS0
	 tWxsNn99BwrvS6+eBT4U6mVUEWABjiIUWnevKAmapeLgpHQwgpnOcQfEWrgFBj2B5X
	 HzySnSqg3NxjEorGjcleQw0l9wT3wLi69QIlv64cUbLzsOKH42981xe/6ZwSIjBRT+
	 TbNQEeM//GocoJYpdvGCJNm2XdjCwpQSYj84Ha1XR1/ae1Zwc253sIAmXRuhXQPFvi
	 atFXObxpuoJfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 14702C43612;
	Fri, 14 Jun 2024 00:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] net: mvpp2: use slab_build_skb for oversized frames
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171832443607.14234.16067460622916355437.git-patchwork-notify@kernel.org>
Date: Fri, 14 Jun 2024 00:20:36 +0000
References: <20240613024900.3842238-1-aryan.srivastava@alliedtelesis.co.nz>
In-Reply-To: <20240613024900.3842238-1-aryan.srivastava@alliedtelesis.co.nz>
To: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 linux-kernel@vger.kernel.org, linux@armlinux.org.uk, mw@semihalf.com,
 netdev@vger.kernel.org, pabeni@redhat.com, keescook@chromium.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Jun 2024 14:49:00 +1200 you wrote:
> Setting frag_size to 0 to indicate kmalloc has been deprecated,
> use slab_build_skb directly.
> 
> Fixes: ce098da1497c ("skbuff: Introduce slab_build_skb()")
> Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
> ---
> Changes in v1:
> - Added Fixes tag
> 
> [...]

Here is the summary with links:
  - [v1] net: mvpp2: use slab_build_skb for oversized frames
    https://git.kernel.org/netdev/net/c/4467c09bc7a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



