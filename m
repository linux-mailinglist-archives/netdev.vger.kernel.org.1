Return-Path: <netdev+bounces-159532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE07A15B45
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 04:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AF1E162F86
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 03:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101902E64A;
	Sat, 18 Jan 2025 03:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAEzCrYG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA0F282FA
	for <netdev@vger.kernel.org>; Sat, 18 Jan 2025 03:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737172210; cv=none; b=QwF32DfupeGkWhkD8sW+i3TzDukB3PXyIWPFcCCHKvahZ7PwL3N+Bn6zAz89Q0+wu2dXIYE6IHjoRQpoXNE4MgYKdHmDYOsJdfNGPrxVU40/A1kq52i5NX1iuRyO7xxtsEMpE8f7qWHEvtuKfIL3zwIOYplkLAo4zhs+75WtMdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737172210; c=relaxed/simple;
	bh=b+jALF99tuoZN8Um+mbDDgRFK5xqv9O4ky+gMnRmC1o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sxSaGfhwGs30l9duNwRAleuVi1azi4u13577dthkYxMhlLMW7HUqugoD9RCIg0l/QGKAcQt85Xi3yNLnWcu0uppIps5Ne4kDO7CO3zu2SJzsaSnBOHuA2Of+ZESdq66cMw4jMmBZU3zUXAiGZQYhvk2+MPqvjjNqY/B9JP5+Juo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAEzCrYG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1A3C4CED1;
	Sat, 18 Jan 2025 03:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737172209;
	bh=b+jALF99tuoZN8Um+mbDDgRFK5xqv9O4ky+gMnRmC1o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bAEzCrYG6zrEEI0rfePOiD8XBWo8Cd4CMDgdHBeRyaIsMjxetux8KC2HH1cZCgtdw
	 +7HQ/sdl6YaJSc5+Zdlx9v4gos27NB1a5ifkBfXa8DKlPj//zYiFU8//FUd2uafsmy
	 /hDAn72cXH+7TqdmNZavNe6n+qKXyqHSWIcpKsPxWFGtd2nZkfkGv1qT0aJCvLQueh
	 5mEynMEzCkTSTTpXl3KJXOv3yBtfeXH4OMRFj+HnPWaU+V8daon4RXWozzqjia9ieL
	 0JWaM1eW/eTeCNGaQDG1HTOTjF9vjrxD15zZYBVh00XEbGzNlSjXwbCYnPMp4DmcWR
	 2NjCiTekpu1gg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC07D380AA62;
	Sat, 18 Jan 2025 03:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: let net.core.dev_weight always be non-zero
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173717223278.2330660.1589857788075296019.git-patchwork-notify@kernel.org>
Date: Sat, 18 Jan 2025 03:50:32 +0000
References: <20250116143053.4146855-1-liujian56@huawei.com>
In-Reply-To: <20250116143053.4146855-1-liujian56@huawei.com>
To: Liu Jian <liujian56@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, stephen@networkplumber.org,
 matthias.tafelmeier@gmx.net, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Jan 2025 22:30:53 +0800 you wrote:
> The following problem was encountered during stability test:
> 
> (NULL net_device): NAPI poll function process_backlog+0x0/0x530 \
> 	returned 1, exceeding its budget of 0.
> ------------[ cut here ]------------
> list_add double add: new=ffff88905f746f48, prev=ffff88905f746f48, \
> 	next=ffff88905f746e40.
> WARNING: CPU: 18 PID: 5462 at lib/list_debug.c:35 \
> 	__list_add_valid_or_report+0xf3/0x130
> CPU: 18 UID: 0 PID: 5462 Comm: ping Kdump: loaded Not tainted 6.13.0-rc7+
> RIP: 0010:__list_add_valid_or_report+0xf3/0x130
> Call Trace:
> ? __warn+0xcd/0x250
> ? __list_add_valid_or_report+0xf3/0x130
> enqueue_to_backlog+0x923/0x1070
> netif_rx_internal+0x92/0x2b0
> __netif_rx+0x15/0x170
> loopback_xmit+0x2ef/0x450
> dev_hard_start_xmit+0x103/0x490
> __dev_queue_xmit+0xeac/0x1950
> ip_finish_output2+0x6cc/0x1620
> ip_output+0x161/0x270
> ip_push_pending_frames+0x155/0x1a0
> raw_sendmsg+0xe13/0x1550
> __sys_sendto+0x3bf/0x4e0
> __x64_sys_sendto+0xdc/0x1b0
> do_syscall_64+0x5b/0x170
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> [...]

Here is the summary with links:
  - [net] net: let net.core.dev_weight always be non-zero
    https://git.kernel.org/netdev/net/c/d1f9f79fa2af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



