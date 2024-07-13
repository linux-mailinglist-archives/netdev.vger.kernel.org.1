Return-Path: <netdev+bounces-111286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3459D9307B1
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 00:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E7651C2034B
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 22:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C582013DDD3;
	Sat, 13 Jul 2024 22:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8BFV8iG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01AB61FD7
	for <netdev@vger.kernel.org>; Sat, 13 Jul 2024 22:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720909831; cv=none; b=k0JYS02DeMwgpPMjoxk5mu7b8KGcNO4D3sQQUsS8lZvJZHERb5/3l9r2B8n7/hcdzEU2soQyy35jfpeBv20OexUnEmWNpG/NubrxzhmteT3U7xlrx2Ba1Z8AMTSf7MeoQ+sD2sGC2ckA12i8x4YwZ0S4wZJRl52PdiKPu7uvGG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720909831; c=relaxed/simple;
	bh=LZX/bqZVErdO+KRsqjNWnUZeXMQmvYYWGXlebmlK4Ok=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pOBwI95ecjQGZh/ixM+bHUt0Tu/WTo0DJjK85EX5woVTZ4L3FYPwC7RhVY4+bI4LHSlreuk2w/WU3o6c95hmN9CYafxmcfjCStRtqPYrXb+fsIl3J9Ma3yDzCQX5Dzy6XHI7OMXiGqQ7RYRxB5LuIMEOwS+ZWVbHJQiDUvOm8xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8BFV8iG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15265C4AF0B;
	Sat, 13 Jul 2024 22:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720909831;
	bh=LZX/bqZVErdO+KRsqjNWnUZeXMQmvYYWGXlebmlK4Ok=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C8BFV8iGTzSdJj6SVY+IIk64a2jMqHjLPDPGEp4tMmuc9Z4AyMISLrAP8TziVqF0b
	 YTbn44qrYPGWN6NPotHmH/4Ku6bu2TPjBoZ39iXu7d63WYuS5Nuke7ZdM3mGwDe3ef
	 dlFIjDVB4e6VX4Kl/FAHavRe9sgAkKCwSBjxAONoIEWvBR7s5/tehi//YA9sJrLVz1
	 /7fH3xDjuw+bQ/UrJh8grfVREvwi4SBwrlZtMIRFegx9JeAl9nzpzmzi1aPXCp+2IQ
	 GNVcL695SU5/2ojulrm8MgWxrE5VE9sexE83yq0bGBKGOjJSEtR+bChUB4fou053rD
	 WMn0yTOQ44xig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F116DC43153;
	Sat, 13 Jul 2024 22:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 0/2] tcp: Make simultaneous connect()
 RFC-compliant.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172090983097.21567.15657611491994442725.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jul 2024 22:30:30 +0000
References: <20240710171246.87533-1-kuniyu@amazon.com>
In-Reply-To: <20240710171246.87533-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Jul 2024 10:12:44 -0700 you wrote:
> Patch 1 fixes an issue that BPF TCP option parser is triggered for ACK
> instead of SYN+ACK in the case of simultaneous connect().
> 
> Patch 2 removes an wrong assumption in tcp_ao/self-connnect tests.
> 
> v3:
>   * Use (sk->sk_state == TCP_SYN_RECV && sk->sk_socket) to detect cross SYN case
> 
> [...]

Here is the summary with links:
  - [v3,net-next,1/2] tcp: Don't drop SYN+ACK for simultaneous connect().
    https://git.kernel.org/netdev/net-next/c/23e89e8ee7be
  - [v3,net-next,2/2] selftests: tcp: Remove broken SNMP assumptions for TCP AO self-connect tests.
    https://git.kernel.org/netdev/net-next/c/b3bb4d23a41b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



