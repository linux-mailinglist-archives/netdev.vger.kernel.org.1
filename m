Return-Path: <netdev+bounces-203519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 996E9AF643B
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 23:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77D6D3AD012
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 21:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB562E03F5;
	Wed,  2 Jul 2025 21:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FK8md6Gd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2593923BD09
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 21:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751492389; cv=none; b=WgMAulm9tOoBon8xl1DJ0dcecX2l7GrqECrK6RJg/dGy5XRx635xe1EFVO/WBQ+n/WN4JIuvLPVvqLmg0ZEYBEhkmf+jKKjQhbvMynh5IaNd7IaWHEB8Vq1gXmclbwuuDt9+eLYdI5VNHAKa20agbGTNgYsSu/6cdEtap9B8TUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751492389; c=relaxed/simple;
	bh=yO30au54jAcJ64My/g0w4XEnbivtQXr1xR4gkoXGZbY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T3A1fVUFvr8lKIR1DSWgBgin3okiaF70QH66TGSuw8Hmq+jSdM5DbCB4h//D+Uo4VL4ozKceNlhkj+8h21gfIs8KwsKAvaQFkGXlXIuNdSR0quI15ZXGxvG9gqpz6DBVOT4jMuSG2jGE8JbWmfyI9uGd0+6RCJVQw2RoTEMkySQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FK8md6Gd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CCBC4CEE7;
	Wed,  2 Jul 2025 21:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751492388;
	bh=yO30au54jAcJ64My/g0w4XEnbivtQXr1xR4gkoXGZbY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FK8md6Gd2beJUgi2J/TOAiGasvKwKmSYq/rCXBP7ukjNvRDsrabcFE5eNqr/eiGHR
	 9E2Y7bHPMVh6VxAul/Gnrt9pyOGRRkPeEFWh523yzMG7VpJPhdZdG/wot8Fc61F14L
	 MCkXAHMUvQ078ssGyQ43MHuwkytYuMocutt3FwzHiSGtJIiY0u37UtkYOPN9iiE2+k
	 cH01HStvCitdaC5uPxeuhJycxKYvTBJ+p34TvK/U97GksyGcnwufFKbx1hId4/Y0wg
	 S8K6+IH96JOTA5oLoC8XIzjKI4GKYll2LTH55rKZRee4nTyqJyr+E5SUf3jNs6IlNj
	 wT5fmPhyVc/qQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C9C383B273;
	Wed,  2 Jul 2025 21:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/4] net: introduce net_aligned_data
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175149241313.872486.2789502153734310329.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 21:40:13 +0000
References: <20250630093540.3052835-1-edumazet@google.com>
In-Reply-To: <20250630093540.3052835-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 willemb@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Jun 2025 09:35:36 +0000 you wrote:
> ____cacheline_aligned_in_smp on small fields like
> tcp_memory_allocated and udp_memory_allocated is not good enough.
> 
> It makes sure to put these fields at the start of a cache line,
> but does not prevent the linker from using the cache line for other
> fields, with potential performance impact.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/4] net: add struct net_aligned_data
    https://git.kernel.org/netdev/net-next/c/3715b5df09b9
  - [v2,net-next,2/4] net: move net_cookie into net_aligned_data
    https://git.kernel.org/netdev/net-next/c/998642e999d2
  - [v2,net-next,3/4] tcp: move tcp_memory_allocated into net_aligned_data
    https://git.kernel.org/netdev/net-next/c/83081337419c
  - [v2,net-next,4/4] udp: move udp_memory_allocated into net_aligned_data
    https://git.kernel.org/netdev/net-next/c/e3d4825124bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



