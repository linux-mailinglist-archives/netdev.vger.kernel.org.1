Return-Path: <netdev+bounces-230623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4748BEC063
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 01:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78E7A1AA251F
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 23:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECA229D265;
	Fri, 17 Oct 2025 23:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxpNC/6P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0FB128816
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 23:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760744429; cv=none; b=Us2bRMIYHys+IL0njD5wh8FN+Tt1kD1xEpvqvfbwRu9hBf1T13geueyTvXf4YhdOAangwl6r+0siK8/cSBrAvK8+HEwKjQxPnq5kxiS6q+Kh82UXFuW2qFyf4MHBOf/MsoC8YUxHECR+DvmljJZD+3j8m/AMs/r6Rqgj86D9XWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760744429; c=relaxed/simple;
	bh=swdhqAgepIIjpt0A+p6qiHR4Vw/D+usZs/hS1EVw4Cw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZEr4QvjfLEygoFuUMcw7JcsxJTYk+5f7hbUCl/hGOx72W25XAxFwiPXM4bDci+kXAeuuia3nhHT3IZJJDDzUNS3Z2cC3imnJ3EFOWzIlVgbg9QXzEkpfW2bDkBPVhvvwPrcHeuMAEkjMLd1FbTGnBHgAuH5pzSrq6zHgfGFZzvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxpNC/6P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3D5C4CEE7;
	Fri, 17 Oct 2025 23:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760744428;
	bh=swdhqAgepIIjpt0A+p6qiHR4Vw/D+usZs/hS1EVw4Cw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AxpNC/6PboRZuRa96MkWou0/CFaCpX6np+Z14G333EYZDn13PiLklnQ6XoN8EO7XF
	 r1jPquM3uns/amwCvsdTGpyML0RbPdvFEI7bOVxiskEIgQ3PQGjp6xapXArGQnhtyv
	 bGrCheqD1Ioig+QDTxzgkDvXlUSpk5app+mM4faWv/1naPx1coK26JdBjhL1gTULeg
	 78EGBVdlTQvx+/+6gUOQB4xqtR47rein4WETSSJlq2Db48eHqLknL0i8SzAw05mNmX
	 UviUOpjZk8cPrICd/9JTSCbQdfHybD/or4cdK/Th5kgHLKFWAy+YAR7tqsiyA/Qx6k
	 10dbZI2W6HYbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DF239EFA5E;
	Fri, 17 Oct 2025 23:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: Kconfig: discourage drop_monitor enablement
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176074441201.2826097.18118475897010397412.git-patchwork-notify@kernel.org>
Date: Fri, 17 Oct 2025 23:40:12 +0000
References: <20251016115147.18503-1-fw@strlen.de>
In-Reply-To: <20251016115147.18503-1-fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Oct 2025 13:51:47 +0200 you wrote:
> Quoting Eric Dumazet:
> "I do not understand the fascination with net/core/drop_monitor.c [..]
> misses all the features, flexibility, scalability  that 'perf',
> eBPF tracing, bpftrace, .... have today."
> 
> Reword DROP_MONITOR kconfig help text to clearly state that its not
> related to perf-based drop monitoring and that its safe to disable
> this unless support for the older netlink-based tools is needed.
> 
> [...]

Here is the summary with links:
  - [net-next] net: Kconfig: discourage drop_monitor enablement
    https://git.kernel.org/netdev/net-next/c/2af8ff1e472e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



