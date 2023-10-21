Return-Path: <netdev+bounces-43166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9F17D1A08
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 02:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B976B2141D
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 00:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3CD383;
	Sat, 21 Oct 2023 00:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWa3eUDc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68792379
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 00:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6B39C433CA;
	Sat, 21 Oct 2023 00:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697849424;
	bh=8gnAknkgkLoJajNKWKRnbeDWep9Lsq0uITQv/RcgQWo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QWa3eUDc/7pXrYlN17bbSWZbLgUex1FawdSHUvF7xPij3qZwYV0shHCQBTzyBB/2z
	 l475l834WH5OogtVTXCBqVrTaD38ro9micc73JOywk4bHv4x1Hh4v5qogxaeUEvAZ2
	 BJBvgvWJZxSUF11Ade3ZS0xf+eMke+HtLy0akxYpEYY3R7Db8SWaSHO48dK2PO76Nr
	 fGhCOpwqhnvKVy9FpXXRMCntCW0oqQO2eOGPk8VOOb2quUckUXI07VB79SkqR1bH1T
	 abh9Ak8YjG/tn9NlbXtuESwo89xVN/6KP4NL1fLA9wEFWSdjLTFrE67vgqDnP3w25x
	 52m29k3VPVPLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8335C595CE;
	Sat, 21 Oct 2023 00:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] neighbour: fix various data-races
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169784942474.14403.10768131681019087380.git-patchwork-notify@kernel.org>
Date: Sat, 21 Oct 2023 00:50:24 +0000
References: <20231019122104.1448310-1-edumazet@google.com>
In-Reply-To: <20231019122104.1448310-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Oct 2023 12:21:04 +0000 you wrote:
> 1) tbl->gc_thresh1, tbl->gc_thresh2, tbl->gc_thresh3 and tbl->gc_interval
>    can be written from sysfs.
> 
> 2) tbl->last_flush is read locklessly from neigh_alloc()
> 
> 3) tbl->proxy_queue.qlen is read locklessly from neightbl_fill_info()
> 
> [...]

Here is the summary with links:
  - [net] neighbour: fix various data-races
    https://git.kernel.org/netdev/net/c/a9beb7e81bcb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



