Return-Path: <netdev+bounces-219967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CBAB43F4D
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 16:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AA6416543D
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 14:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D88030BF63;
	Thu,  4 Sep 2025 14:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbW4CR+5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4893830C341
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 14:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996823; cv=none; b=hu6QQK7OAdn46JIVRepwDsptwcrJVPUo3qSDDKGU9nPUzepjAN248n4WeUvBls5J1lcijkMNcELSkCvOa0FI3mz4Sl2a7a+tHOY5hsIDHX6HomDjwlNkU7sDZvVNai4m4Mvhrf0aqQgZHdYL0/jB2kA4+Lmduh7LOvIMvdTgfts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996823; c=relaxed/simple;
	bh=y3SVCyu/mv9g+anql08tosYVgKm6hfS19Fay8HQ8Dfc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G3DJ3hMzEdZmFAdKQ8tMh4JNkSL8sBtQuUOysktdPGLrN5TUTgBlfNKfAi8qIlYicqChIsRJFREb/PDofRsD+SN/xw345DQqfHhMlOs6sJRgK6r6RSZHCRi/sm2+sU5v7ESdK5Pj0B6/n/Vgam2UE2cp/4Rf4ronD6KaIzpf3xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbW4CR+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23243C4CEF0;
	Thu,  4 Sep 2025 14:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756996823;
	bh=y3SVCyu/mv9g+anql08tosYVgKm6hfS19Fay8HQ8Dfc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sbW4CR+54SDH+j1Nm4Bp1ZJ4ms32kxrNJsS7REXcN8/umg3DAzynCJaXeZVfzntZo
	 QOJrB2Mhx6/NVUkBcKPc/tw+3INv20yf5aBZdQTE7bdvOeHQYswBsW1OHjh3b8T1uX
	 kvz7b6vFvx/F5QoZiNg93fo+E07pk7S6Euu3UNonhTNlkK1WlKqhUWD9WPAFE61EeS
	 wxry2gC8fkGXZje2AMssmC/MOzZXrRxQoxVr0WypYiEXU4mHVK8Caw/EhC3mAIl/aq
	 HL3iId/QpXQ1U+owaX7QVQruDqN96eUp836GS24j8Wx8seCovnli3qvdq/WBJA8LGJ
	 yKNFteu/PqKVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3407D383BF69;
	Thu,  4 Sep 2025 14:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] selftest: net: Fix weird setsockopt() in
 bind_bhash.c.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175699682799.1834386.3327422453903294226.git-patchwork-notify@kernel.org>
Date: Thu, 04 Sep 2025 14:40:27 +0000
References: <20250903222938.2601522-1-kuniyu@google.com>
In-Reply-To: <20250903222938.2601522-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, joannelkoong@gmail.com,
 kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Sep 2025 22:28:51 +0000 you wrote:
> bind_bhash.c passes (SO_REUSEADDR | SO_REUSEPORT) to setsockopt().
> 
> In the asm-generic definition, the value happens to match with the
> bare SO_REUSEPORT, (2 | 15) == 15, but not on some arch.
> 
> arch/alpha/include/uapi/asm/socket.h:18:#define SO_REUSEADDR	0x0004
> arch/alpha/include/uapi/asm/socket.h:24:#define SO_REUSEPORT	0x0200
> arch/mips/include/uapi/asm/socket.h:24:#define SO_REUSEADDR	0x0004	/* Allow reuse of local addresses.  */
> arch/mips/include/uapi/asm/socket.h:33:#define SO_REUSEPORT 0x0200	/* Allow local address and port reuse.  */
> arch/parisc/include/uapi/asm/socket.h:12:#define SO_REUSEADDR	0x0004
> arch/parisc/include/uapi/asm/socket.h:18:#define SO_REUSEPORT	0x0200
> arch/sparc/include/uapi/asm/socket.h:13:#define SO_REUSEADDR	0x0004
> arch/sparc/include/uapi/asm/socket.h:20:#define SO_REUSEPORT	0x0200
> include/uapi/asm-generic/socket.h:12:#define SO_REUSEADDR	2
> include/uapi/asm-generic/socket.h:27:#define SO_REUSEPORT	15
> 
> [...]

Here is the summary with links:
  - [v1,net] selftest: net: Fix weird setsockopt() in bind_bhash.c.
    https://git.kernel.org/netdev/net/c/fd2004d82d8d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



