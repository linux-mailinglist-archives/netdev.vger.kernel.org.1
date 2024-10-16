Return-Path: <netdev+bounces-135941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B037999FDA1
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 03:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56F8B1F26072
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 01:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F33D16630A;
	Wed, 16 Oct 2024 01:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1nRRPsu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC398165F17
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 01:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729040424; cv=none; b=lFTOb+RgcT3N3EBuWViGpGuSRonX9HVRhDQRENVH1XsItyOLi40T9obS6e+aTMguN6KfJWrUe3BaJel0wnPWgIHA0Qqm67SrMxW1jvtNz9RnOuXyokfzx9N36pYs2i1/1WdpvEWngcUMG7S5sob1GVMlxlC7IUcwR2KppgC6h2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729040424; c=relaxed/simple;
	bh=8078Ee6xH3nBE8h+9Q255A9s2KaF2oPXKY9xWnMfmHQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QEIfEF+euvmMUgK0wp3sW2b1n6Aw0n+Y/qjn6cf18np1IZUOHQCc7o5w1loS623yzBIPWq1fdDgFUNS/N4IaPTnkFQm3+/vVDqnN3F32CthGhXF+fZJ+PX+y5A8C/dSmn9viej6+hxB+ghK30y8LKyAJR0amT70mHvK0k5quGvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1nRRPsu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB3AC4CECD;
	Wed, 16 Oct 2024 01:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729040423;
	bh=8078Ee6xH3nBE8h+9Q255A9s2KaF2oPXKY9xWnMfmHQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S1nRRPsu0HE+AvMEFfa25M1HfO7rya5rBuNDQe19ZN32bXdnKHKEsgxd4YLMk0Tkf
	 edTQncumBG7wNaOjSvAWm9f6zBvT5Syg2E3BOCrrmDikzulQ+/SHAJcuh02JxHC1VQ
	 eO0sfqEchumIJ5EzHCCbvyXBBfEAgoYbrc7RkN35lZKBtWdYozIrWXaeAej530v1gr
	 5v6HkiT+zALxw3gie4M+aYTF+IQuSqp3Ze94h1m0f2jzNH6i8J88YAH52cVe8i8Ci3
	 1nfWvrKRyqs8wkcpY1KxBf1oWKtGOTpAd9hYdfx4W9ivaacwOiLbqPmNo1nIBXD5s4
	 wwhvJGmPYZ1oQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBB7B3809A8A;
	Wed, 16 Oct 2024 01:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] tcp/dccp: Don't use timer_pending() in
 reqsk_queue_unlink().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172904042876.1343417.3440209685224947342.git-patchwork-notify@kernel.org>
Date: Wed, 16 Oct 2024 01:00:28 +0000
References: <20241014223312.4254-1-kuniyu@amazon.com>
In-Reply-To: <20241014223312.4254-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, martin.lau@kernel.org,
 kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Oct 2024 15:33:12 -0700 you wrote:
> Martin KaFai Lau reported use-after-free [0] in reqsk_timer_handler().
> 
>   """
>   We are seeing a use-after-free from a bpf prog attached to
>   trace_tcp_retransmit_synack. The program passes the req->sk to the
>   bpf_sk_storage_get_tracing kernel helper which does check for null
>   before using it.
>   """
> 
> [...]

Here is the summary with links:
  - [v3,net] tcp/dccp: Don't use timer_pending() in reqsk_queue_unlink().
    https://git.kernel.org/netdev/net/c/e8c526f2bdf1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



