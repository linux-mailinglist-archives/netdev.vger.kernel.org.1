Return-Path: <netdev+bounces-152456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAC39F4038
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 02:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9FF2188C061
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 01:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9B31384BF;
	Tue, 17 Dec 2024 01:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDxbawpX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1905D6EB7C
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 01:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734400213; cv=none; b=brS63gmWsrcah2Gc6Vt/+rf70lOqmIBv3GV2ZNDlX3tRGqUMgjpFfPlw9bzTgYE/6WJWSpVUb6XWwWVScxaRfIKOINYV9i5F6x8R7HTk2j7uWzP0HHUf/kJhRNe0z16CFZVPOzPiPRM5oozjYcuLxZ3togLoUeCc6aLqdJ2fNe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734400213; c=relaxed/simple;
	bh=zArOzd2eKley3lhKeWHPq2U+SEWEeiZEFmaNtT/Yb/8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=drMRf/pNDYvLIZNvo9RZupv17PIdwcmoi4cLimJ93qJqPISf/piUuMKTpM7M9nqoykOIeAH1GjACbbNGq0CWbjrXMatuVfEqNnSE8eKav04YmpBO4BD6rTTRz1FOd1Nql2M5E3FoLUIHvXCEtaFazaguQuWYtmgvg+1ZO89H60w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDxbawpX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9638FC4CED0;
	Tue, 17 Dec 2024 01:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734400212;
	bh=zArOzd2eKley3lhKeWHPq2U+SEWEeiZEFmaNtT/Yb/8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hDxbawpXVj1EK9L9NwzAOQrAd+zajf67E6p2peHObe5XBGtClFBhlSiOOuXOS8Qvn
	 hy/FzCYmcKs+DTytG9N3mgzpwvygedNgYg10qcOscPAU7j1tIZyxun/1W9ORwdZ4QV
	 4xo5sdSukyBa6K3gh552DTKOk9HsgjxcVuCSfHiCCddYM65ulE57u9qnWQh/8ovexh
	 wd280ZNJVHpLxgFt6DX0xMRqGZ4DQ3/zvTE1lbC422hhjVlOefF1ZRx2V28jxQnCTP
	 I4J8GTLJE9p9hHce/H8rMbY+trYqWGm7XbAt0ZFhzz8sKRxLlt8fpd8bXy16EhL+9B
	 vucuqKKuDdA0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD553806656;
	Tue, 17 Dec 2024 01:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] netdev: fix repeated netlink messages in queue dumps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173440022976.411680.17253151717836014949.git-patchwork-notify@kernel.org>
Date: Tue, 17 Dec 2024 01:50:29 +0000
References: <20241213152244.3080955-1-kuba@kernel.org>
In-Reply-To: <20241213152244.3080955-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Dec 2024 07:22:39 -0800 you wrote:
> Fix dump continuation for queues and queue stats in the netdev family.
> Because we used post-increment when saving id of dumped queue next
> skb would re-dump the already dumped queue.
> 
> Jakub Kicinski (5):
>   netdev: fix repeated netlink messages in queue dump
>   netdev: fix repeated netlink messages in queue stats
>   selftests: net: support setting recv_size in YNL
>   selftests: net-drv: queues: sanity check netlink dumps
>   selftests: net-drv: stats: sanity check netlink dumps
> 
> [...]

Here is the summary with links:
  - [net,1/5] netdev: fix repeated netlink messages in queue dump
    https://git.kernel.org/netdev/net/c/b1f3a2f5a742
  - [net,2/5] netdev: fix repeated netlink messages in queue stats
    https://git.kernel.org/netdev/net/c/ecc391a54157
  - [net,3/5] selftests: net: support setting recv_size in YNL
    https://git.kernel.org/netdev/net/c/0518863407b8
  - [net,4/5] selftests: net-drv: queues: sanity check netlink dumps
    https://git.kernel.org/netdev/net/c/1234810b1649
  - [net,5/5] selftests: net-drv: stats: sanity check netlink dumps
    https://git.kernel.org/netdev/net/c/5712e323d4c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



