Return-Path: <netdev+bounces-177327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D648DA6F45F
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 12:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D96D7A4EE9
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 11:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E582561A4;
	Tue, 25 Mar 2025 11:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/QNNy1k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC6633EC
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 11:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902799; cv=none; b=RHBYKH/ZqYj2HJJ8Zm5PTOslEtCwKUI2U/j7gY9CRzr4qt4daZAMC0tLkBsC3Tub+QGdkD2vqkcbbiJPzxvrP/7meQAf1P/tkn2TeN7NROE98/xIJUPfW6Z13VDgnMxtHzH1gWfmjyodqDZnMZjpU/ep0S4PZid9UOSBoFy8jvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902799; c=relaxed/simple;
	bh=POYgjuKGHdxMUiqp3b1H6SycehuDAeBWgceEeJP3iPE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T99oAgfgIaTAz1+utzotroG2fUTvzdqMknGG0UmFmP1cfhje5IeoC80UD4W3+d8ank9CKtgSNKS/6RTkGG9v4ute5DrpfjjccTgzkDg6WVawx6bzHZ1y/sOS8EMEuRb8C5dmjC0yRbxTLVIActfcf2ZGEggXDS7rtUsoa3ev1Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/QNNy1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FB0C4CEE4;
	Tue, 25 Mar 2025 11:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742902798;
	bh=POYgjuKGHdxMUiqp3b1H6SycehuDAeBWgceEeJP3iPE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I/QNNy1k2E4fH+7tbpK38JBNuSIt4LaI63dRuDPJUU9TfLn73fDDFFfmAg6Xwczey
	 ysTK40h/pHsPTus6pmFZ6aF054AT81mAXD60OSW3FWBIzQBPa0FJCRx0qUmN3qOvJP
	 McVBRzufbj/qZMQk+Os3yuqj52ibr86B0Dd091Gw6Zql63HMwRob03cuvTp88j7MV5
	 HqWaVB0U7l83LL8F0O3ppoLyftV4Nwiis1pLHZ1Ku5sDoourLYCIvP3yR7mmapbjN3
	 0WkT3gDkoW08zqKni+kEAXHIT5XN7zHaHCSBsM/1DhG7Md34Xn3hxT88W973P+9zE3
	 8cN6vGz6PZyyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBA0C380CFE7;
	Tue, 25 Mar 2025 11:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next 0/4] af_unix: Clean up headers.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174290283479.528269.15364241713586638876.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 11:40:34 +0000
References: <20250318034934.86708-1-kuniyu@amazon.com>
In-Reply-To: <20250318034934.86708-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Mar 2025 20:48:47 -0700 you wrote:
> AF_UNIX files include many unnecessary headers (netdevice.h and
> rtnetlink.h, etc), and this series cleans them up.
> 
> Note that there are still some headers included indirectly and
> modifying them triggers rebuild, which seems mostly inevitable. [0]
> 
>   $ python3 include_graph.py net/unix/garbage.c linux/rtnetlink.h linux/netdevice.h
>   ...
>   include/net/af_unix.h
>   | include/linux/net.h
>   | | include/linux/once.h
>   | | include/linux/sockptr.h
>   | | include/uapi/linux/net.h
>   | include/net/sock.h
>   | | include/linux/netdevice.h   <---
>   ...
>   | | include/net/dst.h
>   | | | include/linux/rtnetlink.h <---
> 
> [...]

Here is the summary with links:
  - [v1,net-next,1/4] af_unix: Sort headers.
    https://git.kernel.org/netdev/net-next/c/f9af583a2c76
  - [v1,net-next,2/4] af_unix: Move internal definitions to net/unix/.
    https://git.kernel.org/netdev/net-next/c/84960bf24031
  - [v1,net-next,3/4] af_unix: Explicitly include headers for non-pointer struct fields.
    https://git.kernel.org/netdev/net-next/c/3056172a261c
  - [v1,net-next,4/4] af_unix: Clean up #include under net/unix/.
    https://git.kernel.org/netdev/net-next/c/0083e3e37e07

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



