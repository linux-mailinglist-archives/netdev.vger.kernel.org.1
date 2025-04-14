Return-Path: <netdev+bounces-182517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37028A88FD6
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 00:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AAA617C58D
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 22:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99961F873A;
	Mon, 14 Apr 2025 22:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXYE3CMp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BD61F867F;
	Mon, 14 Apr 2025 22:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744671417; cv=none; b=to6s3U3PfiSGVGSCtJCuxohL5LWYllix46TRM09yXKg2ZmTZ6FFT++fklW5pcKXMyQntb5Itmq/96yOuJpuUiUsFtOctt9HLSxa1kOWawM0AjPXM5CSlcNooltCkRxWEgTHAilHrYvqhr2aaUn2Q1Uz29ZdQh/Vg4+P5xbYT9D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744671417; c=relaxed/simple;
	bh=6XCxiEE0f6aFdryeR9gXZd01V4lTfiAVuXBv0meC0mw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iUvtApftTUiAA7BXP6G7+H+W03ADagoquIetIDAlYFUEFaW35p3euTq7BY8wUI2WhPznmBGZWwBiyc/PGcyKYV1AtQRWgY3TIoF74h7bhWWPisxdGy5ZaHGXPpLdlO91jdoi5o2z5IfRFlKbqjZasoMidJfuRsYAlsMNvXKe9HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXYE3CMp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11AAAC4CEE9;
	Mon, 14 Apr 2025 22:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744671417;
	bh=6XCxiEE0f6aFdryeR9gXZd01V4lTfiAVuXBv0meC0mw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VXYE3CMp5xOdYHJMHh4v4qIkuEa4vvgbo69iOkRmmodzNdLg5BVA4Y4zQeOTJNeDC
	 tCh+UcmXsZQPcWIk1fPctNVA3xESUfwQyR6DC4QJIjdrAl+0vMIlNHX3ysPmdB4Big
	 FyDChJYLa8EMsJvpZOaClxm7wulRNHnrxPSAo7u9LtcVn8BjLTdsGn4rhiB41MeqNZ
	 BWfPtGqNAfBb1JglnP16CDwgWSe1boO1NLUAMIFlDOt7HsJsUpgE5gW9+wrdYMl231
	 yr8cHSGxmTUEbG3PmxVJfY4GFZ7Ri5lEEjB/6d0jFXPNU9l6zCi9BpWrmzYaEWfqu6
	 2hbFWkHjXh6bg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B563822D1A;
	Mon, 14 Apr 2025 22:57:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/5] bna: bnad_dim_timeout: Rename del_timer_sync in
 comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174467145500.2060374.2711094592170219314.git-patchwork-notify@kernel.org>
Date: Mon, 14 Apr 2025 22:57:35 +0000
References: <66962B9D4666B555+20250414042629.63019-1-wangyuli@uniontech.com>
In-Reply-To: <66962B9D4666B555+20250414042629.63019-1-wangyuli@uniontech.com>
To: WangYuli <wangyuli@uniontech.com>
Cc: akpm@linux-foundation.org, guanwentao@uniontech.com,
 linux-kernel@vger.kernel.org, mingo@kernel.org, niecheng1@uniontech.com,
 tglx@linutronix.de, zhanjun@uniontech.com, rmody@marvell.com,
 skalluru@marvell.com, GR-Linux-NIC-Dev@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Apr 2025 12:26:25 +0800 you wrote:
> Commit 8fa7292fee5c ("treewide: Switch/rename to timer_delete[_sync]()")
> switched del_timer_sync to timer_delete_sync, but did not modify the
> comment for bnad_dim_timeout(). Now fix it.
> 
> Cc: Rasesh Mody <rmody@marvell.com>
> Cc: Sudarsana Kalluru <skalluru@marvell.com>
> Cc: GR-Linux-NIC-Dev@marvell.com
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> 
> [...]

Here is the summary with links:
  - [v2,1/5] bna: bnad_dim_timeout: Rename del_timer_sync in comment
    https://git.kernel.org/netdev/net-next/c/1450e4525f9a
  - [v2,4/5] ipvs: ip_vs_conn_expire_now: Rename del_timer in comment
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



