Return-Path: <netdev+bounces-115505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0463946B59
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 00:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 627AF281CA3
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 22:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDE741A8E;
	Sat,  3 Aug 2024 22:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7VgXKIo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A931862C
	for <netdev@vger.kernel.org>; Sat,  3 Aug 2024 22:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722723378; cv=none; b=qiQJOa3P3Jv44iF/Vl7/p0XX73bephQAeJ7JhecuTsVwndFh+jiYutG1X4wwiddjs9sYx9ssD/8IJW8RNMCrSBfGSOo1kAEWuq/hxiozh47dOfvog901FoTUARCVgqmrJHZK8F4+AKZ+4+tbmjMqTKHSSVT474HfeClim47sHkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722723378; c=relaxed/simple;
	bh=usKt7Ul+9xkyh1RkYcGHCuDPw+ukGlbOW1aq1sjFXXg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B/A63rjZ4Lmr3NMs/6sajAGmTUfX7DyzmQHEMZfKTbv12m8+hCHy9RGUUYIh39bYTw+NF5QbsNxlSTQzD6cniffskB4qZ1L+yMpszuknYdnYj2bA62oWHya5GK4DavXVBJ36cGyipHshkmPtSYf8O0LwIhV3fQM1kw4ZPW79vu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7VgXKIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 780E8C116B1;
	Sat,  3 Aug 2024 22:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722723377;
	bh=usKt7Ul+9xkyh1RkYcGHCuDPw+ukGlbOW1aq1sjFXXg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V7VgXKIorC/BK0kZQLBHQ2FPdvhgwJXPKFhpUVWiC4Wocex3m7J9O3X5moXp1s+Ol
	 EXpBSO01rf4i5GCPR0xPADWapNxZ4jfrTGrT3ojzwpw1Um7NM0Jr2gybUFLjc6iXCK
	 a8ZgDegI8k5FvUVrzJXtqGUxwAtfnkZr4DIo4nnsMnvoiz2K/PDQeho2gMk9AJ0xVg
	 PBTU539Z1AEkDxL0S7SpIk7SjvVEAX3lh8q/JDZd0VcmyXOgFrsdybMNH7+Npl1RB/
	 GPMzw19Dt3KoTDQ+Z7RwAZEdV0/BXDSXuccO1nywq+WyKUyn/UCfuFIIzqibAbV/J1
	 BJ32AsfASGh2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6BE27C433F2;
	Sat,  3 Aug 2024 22:16:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/6] net: Random cleanup for netns initialisation.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172272337743.6154.17806420427012460609.git-patchwork-notify@kernel.org>
Date: Sat, 03 Aug 2024 22:16:17 +0000
References: <20240731200721.70601-1-kuniyu@amazon.com>
In-Reply-To: <20240731200721.70601-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 31 Jul 2024 13:07:15 -0700 you wrote:
> patch 1 & 2 suppress unwanted memory allocation for net->gen->ptr[].
> 
> patch 3 ~ 6 move part of netns initialisation to prenet_init() that
> do not require pernet_ops_rwsem.
> 
> 
> v2:
>   patch 1 : Removed Fixes: tag
>   patch 2 : Use XOR for WARN_ON()
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/6] l2tp: Don't assign net->gen->ptr[] for pppol2tp_net_ops.
    https://git.kernel.org/netdev/net-next/c/1ad001347fb1
  - [v2,net-next,2/6] net: Don't register pernet_operations if only one of id or size is specified.
    https://git.kernel.org/netdev/net-next/c/768e4bb6a75e
  - [v2,net-next,3/6] net: Initialise net->passive once in preinit_net().
    https://git.kernel.org/netdev/net-next/c/2b5afc1d5d5a
  - [v2,net-next,4/6] net: Call preinit_net() without pernet_ops_rwsem.
    https://git.kernel.org/netdev/net-next/c/930299491825
  - [v2,net-next,5/6] net: Slim down setup_net().
    https://git.kernel.org/netdev/net-next/c/05be80125944
  - [v2,net-next,6/6] net: Initialise net.core sysctl defaults in preinit_net().
    https://git.kernel.org/netdev/net-next/c/8eaf71f77c92

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



