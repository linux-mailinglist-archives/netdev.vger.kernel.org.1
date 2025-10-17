Return-Path: <netdev+bounces-230625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6093ABEC069
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 01:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E53E4ECB19
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 23:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14D830F813;
	Fri, 17 Oct 2025 23:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RL3hdKIv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3F12EB870
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 23:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760744432; cv=none; b=A3saUAw2DvAn8PZBrIKesRYnU4GQ9y6pGazJBMPq+pXyvD1XnhB5cMb4cpkfVDxer1dKGV0OOfDxl6bHxNblVzvh+kPOgDV15YM7BzqyF5ffVn9CJcpuf2n9QLyI87ZYNDb0YwyNg8nyrgD9KaWuwUoev9POuXtK95KnRzkNPJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760744432; c=relaxed/simple;
	bh=Bv3/A5qSQoRm5Pifbt7K82z1WUlcRFgSyz5F27akmbw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EUHNC2DXDRF9nKBw0QKVzmC6mlzmQN/zOhmOgy1Ww9KgDYeEx5qyxsomLEFVo1YGbJndQkox2tdPo51u1OEQg6Tsfz88em5YLAu4viV0vGoe0Suxh/kjGiI9d9X3BfdY7h/pu3Yt6/Fy/WnjfCx52NuPh+g4WasvJOGt1Eli5Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RL3hdKIv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353DBC4CEE7;
	Fri, 17 Oct 2025 23:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760744431;
	bh=Bv3/A5qSQoRm5Pifbt7K82z1WUlcRFgSyz5F27akmbw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RL3hdKIv65alaXOoaOQWGJ3xBH+DZZDTOk4+ffFmUcPxsyNbpBdyn0r7bs94EcstQ
	 Q3DoIUSo4+Xh5v3LKI84rMa0XP1malGl+mhXDL/8fgR43JCOb7C3zeYE/A89fBQrx7
	 AFJzfWK2K7lvNR2AX2YkZk5hICAFFyOR82Qz0KhzCbBP6n/B3Fs2HHQx2gdbgEML5h
	 jw+iuAcNM48sWmzcVc62f3UcjBKHGJQLyaclquGvAJ88N4cUYWoJKFNl6QoGEEJp1d
	 0rBXWO/K82TlWKemFCYaLzNtCAPzZD79wFPI7P/J1dlBQxSlFM19jJh8AYiF+hzxKE
	 aO3kYz2bsrbWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACD539EFA5E;
	Fri, 17 Oct 2025 23:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] ipv6: Move ipv6_fl_list from ipv6_pinfo to
 inet_sock.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176074441449.2826097.1824023534110386025.git-patchwork-notify@kernel.org>
Date: Fri, 17 Oct 2025 23:40:14 +0000
References: <20251014224210.2964778-1-kuniyu@google.com>
In-Reply-To: <20251014224210.2964778-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ayush.sawal@chelsio.com, ncardwell@google.com, marcelo.leitner@gmail.com,
 lucien.xin@gmail.com, kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Oct 2025 22:42:07 +0000 you wrote:
> In {tcp6,udp6,raw6}_sock, struct ipv6_pinfo is always placed at
> the beginning of a new cache line because
> 
>   1. __alignof__(struct tcp_sock) is 64 due to ____cacheline_aligned
>      of __cacheline_group_begin(tcp_sock_write_tx)
> 
>   2. __alignof__(struct udp_sock) is 64 due to ____cacheline_aligned
>      of struct numa_drop_counters
> 
> [...]

Here is the summary with links:
  - [v1,net-next] ipv6: Move ipv6_fl_list from ipv6_pinfo to inet_sock.
    https://git.kernel.org/netdev/net-next/c/1c17f4373d4d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



