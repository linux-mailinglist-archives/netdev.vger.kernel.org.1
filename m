Return-Path: <netdev+bounces-217531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D677B38FC5
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 02:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D727E1B28919
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 00:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E8F194A60;
	Thu, 28 Aug 2025 00:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAlCzOx3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E597E19047A
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 00:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756341003; cv=none; b=tb/KGSmTDlNyFlisQ/PfVqAS0eIg2zJaFIl0iJNsmzUeh/6iUwSB5zZHZbwYKYkOS1DTi1v+z/UuYmQkym/ExKh5sGtGKcWNnea0p44qJMPeb3UtXvJYlSePgu0iQz5YvTTjIwXu8p5+B4Ccxfhsr72vdBkPYdVhNea9NL1zT6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756341003; c=relaxed/simple;
	bh=MlVem33JQzR6++6XNPLPrDnGlWTeMVWy9ennVveYWeE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lbiTwxdvhiwJ6n4U5CWoRlkUfKpcyngmdRnq2USHXUujbF5GTb2621RubkGtsDeLv3L0TOk/K11QH8L5PaaYAdvNAeCD5ozj7GZF0XgWBPJCO8lF4Y9q11VGVZk3yc26C8H5vjWeNicImrZufFLVims5TYreo+D8Bv9VhyKhXHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAlCzOx3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B66C4CEEB;
	Thu, 28 Aug 2025 00:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756341002;
	bh=MlVem33JQzR6++6XNPLPrDnGlWTeMVWy9ennVveYWeE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CAlCzOx3FYGYERTt9AIXu1Kd6mPhEU7MKE3xhIuoa3erQYTuMc/1wXFsDybu+FhxP
	 7KCeT9Ju0/1DHTrcIePmZwH2weLwbWF2zjLaeo2t5M1UAxH3g650sLdppL+WWgqUsA
	 +/k9AAyHS6A6bWJVvQNtdWTpe8omV2IVOqd6QKnRiZIu1vhbxrIRrHIKyz1RbRVwvR
	 IcNlvEy8ExdeClmO+NzPKEIq6TNJCKs0dMjPzJeKF2ABOuFsylg9Y9ceVYHzagZyGV
	 2iYYlQBsoSKHhdpPdYJqlVsUIlauJiS6FzeYJtxvMyssFsKzjadKeDfZ6Ieaqj4OiC
	 Zz29CitfNAxVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFDC383BF76;
	Thu, 28 Aug 2025 00:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sctp: initialize more fields in sctp_v6_from_sk()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175634100974.886655.11990946128940456601.git-patchwork-notify@kernel.org>
Date: Thu, 28 Aug 2025 00:30:09 +0000
References: <20250826141314.1802610-1-edumazet@google.com>
In-Reply-To: <20250826141314.1802610-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+e69f06a0f30116c68056@syzkaller.appspotmail.com,
 marcelo.leitner@gmail.com, lucien.xin@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 Aug 2025 14:13:14 +0000 you wrote:
> syzbot found that sin6_scope_id was not properly initialized,
> leading to undefined behavior.
> 
> Clear sin6_scope_id and sin6_flowinfo.
> 
> BUG: KMSAN: uninit-value in __sctp_v6_cmp_addr+0x887/0x8c0 net/sctp/ipv6.c:649
>   __sctp_v6_cmp_addr+0x887/0x8c0 net/sctp/ipv6.c:649
>   sctp_inet6_cmp_addr+0x4f2/0x510 net/sctp/ipv6.c:983
>   sctp_bind_addr_conflict+0x22a/0x3b0 net/sctp/bind_addr.c:390
>   sctp_get_port_local+0x21eb/0x2440 net/sctp/socket.c:8452
>   sctp_get_port net/sctp/socket.c:8523 [inline]
>   sctp_listen_start net/sctp/socket.c:8567 [inline]
>   sctp_inet_listen+0x710/0xfd0 net/sctp/socket.c:8636
>   __sys_listen_socket net/socket.c:1912 [inline]
>   __sys_listen net/socket.c:1927 [inline]
>   __do_sys_listen net/socket.c:1932 [inline]
>   __se_sys_listen net/socket.c:1930 [inline]
>   __x64_sys_listen+0x343/0x4c0 net/socket.c:1930
>   x64_sys_call+0x271d/0x3e20 arch/x86/include/generated/asm/syscalls_64.h:51
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Here is the summary with links:
  - [net] sctp: initialize more fields in sctp_v6_from_sk()
    https://git.kernel.org/netdev/net/c/2e8750469242

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



