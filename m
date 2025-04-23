Return-Path: <netdev+bounces-184962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B20D6A97D03
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 04:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B289E189C375
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 02:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446654A06;
	Wed, 23 Apr 2025 02:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/3kORgQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201181F16B
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 02:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745376594; cv=none; b=CNktxcXcam1ZoMn9C+tJXHbJZQ1Bs6YRfkJ28OZHVOt4h4PytVCiXP8ctdWB7qwugfiqRNpNE+4+MYEO+Zj6rMjNFCJleFY5saX/gKUAKQYYohYeiYd89sNb6TiIZW3H9Z5VFV/4mqru9MDwd08+sBsO3sMbhqB3TRgAVg9rXhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745376594; c=relaxed/simple;
	bh=Zzuf6Qv9UrdLAPSN5s+0h2XjnoinRONFzdGlTOHfysM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FCXhf7jd25B4FX3ztfTuoMV9bj4LWofypHhtP91hDpcgc/TxkYBdCE5PIa/1ousEMvWr+UeqY58J5P5Nj03dr79X6n5f9K/NZYWbZFUqOF/+Mf2IN+a3gWJBJQUpkQB6QR3wkixdi8x+9H8j/FQY2jtKBcoc8Ag+WgG8iD508eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/3kORgQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817C5C4CEE9;
	Wed, 23 Apr 2025 02:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745376593;
	bh=Zzuf6Qv9UrdLAPSN5s+0h2XjnoinRONFzdGlTOHfysM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T/3kORgQrXt+YcWQcB6WAouhSveE2rQg6gdo4PooDrnHA9NYyILvQZUVdoyDVqxwz
	 F4ThjuhJpJWAJuXK2RltUEYbRflAFTcpadGgxS4qIPR27R/Df6UDvML6l8ldPJnL5e
	 LhDrSdBsg0aHGXqnc9e+IgCuAt6JrXqhDemEWK9WR9T5ef2qUvaKk0Rvz5rt/YZDL8
	 PoTVyneL48c3jCu36fPLSdtP1ig/usS83RkFaAjoJ3rHamWcLXeHhbQcP5QcTZZ0Xh
	 VtAPHpW3RJvdyqEmNgGXXwNWKGJ1k7AyuF+SZwXgkARTD/hWdi4k2ZG8zn0u2dxT0v
	 q88w3lBoh/fTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DBD380CEF4;
	Wed, 23 Apr 2025 02:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/3] net: Followup series for ->exit_rtnl().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174537663200.2123394.7109777592977291749.git-patchwork-notify@kernel.org>
Date: Wed, 23 Apr 2025 02:50:32 +0000
References: <20250418003259.48017-1-kuniyu@amazon.com>
In-Reply-To: <20250418003259.48017-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Apr 2025 17:32:31 -0700 you wrote:
> Patch 1 drops the hold_rtnl arg in ops_undo_list() as suggested by Jakub.
> Patch 2 & 3 apply ->exit_rtnl() to pfcp and ppp.
> 
> 
> Changes:
>   v2:
>     * Patch 3
>       * Fix build failure by forward declaration
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/3] net: Drop hold_rtnl arg from ops_undo_list().
    https://git.kernel.org/netdev/net-next/c/434efd3d0cdd
  - [v2,net-next,2/3] pfcp: Convert pfcp_net_exit() to ->exit_rtnl().
    https://git.kernel.org/netdev/net-next/c/81eccc131bc1
  - [v2,net-next,3/3] ppp: Split ppp_exit_net() to ->exit_rtnl().
    https://git.kernel.org/netdev/net-next/c/7ee32072c732

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



