Return-Path: <netdev+bounces-147132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5186E9D79BF
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 02:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3D34B2100E
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 01:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D92A4C76;
	Mon, 25 Nov 2024 01:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H41QVVq2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4965D2F2D
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 01:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732497619; cv=none; b=ax2r6BwxEdF0WTFfLfiJsuxbkYabZBgmBnxIlEFPMzPrzMx2G0e1yuu1b2DVHVKYiolv8mEw6ZW6dsiTPO+91slq8v/c6gxHXF6blZ+0vCcLr6FhqF5FhOtYhwiigiCkXzh2YE9qnBVEp24OACgZu9P37vH0bLEiUnJXWEMw/EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732497619; c=relaxed/simple;
	bh=9AsvQxvcnkFFFQa32Y3j1grOuZYBm9NHB2d0AXzr0EM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OCfXe1wdD/sP3TaA1+4Ycrc5VY6X/mTOA2/1p6Ufw1eY0FdQ/VIGsUMxsfN5clacLqsq8s0CHEusDmlFvDaAG91+pb7KG4g7upJKoV0iuxw3Z/O/tqpESqo0uBxQb0nZgGAKPq9ZIvoUVEvHlFs/z4DP7z/CvQC+RF18dfzbF8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H41QVVq2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A0AC4CECC;
	Mon, 25 Nov 2024 01:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732497617;
	bh=9AsvQxvcnkFFFQa32Y3j1grOuZYBm9NHB2d0AXzr0EM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H41QVVq2H/HEHj+SXs0FlKiEOL1OReLVF0iW9o+H46OKroSXQuqo6g+B19PCf3g/P
	 NO7jZcnuYYR9qxr1EV3cxYzkdgJyscAoxQUO+nSWEyW1HdWpH1vEU4e6heJrB0+Cqw
	 oLmbHHcqr4U+eFvWK+BXqR2g6tG2AqD0I1+TdflJ4lBrQQJ01v2D1XOH+xAfwUQGE5
	 UzvTeM2i578BdBh9DO5ag7Sa8LYRixBHjAT7AQETsvSn9/7gN9/0Rf2ZmRGLhliKxL
	 Df2e66k2vU5jkdBDZ3gCojQT65FP0G40pWMG27JgRpcyoXYs5YwU0fnrZOLCs9tYkd
	 Qj6vEdIj31KbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71BCB3809A00;
	Mon, 25 Nov 2024 01:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/2] netlink: fix false positive warning in extack
 during dumps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173249763028.3416049.3184048718308851972.git-patchwork-notify@kernel.org>
Date: Mon, 25 Nov 2024 01:20:30 +0000
References: <20241119224432.1713040-1-kuba@kernel.org>
In-Reply-To: <20241119224432.1713040-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org,
 syzbot+d4373fa8042c06cefa84@syzkaller.appspotmail.com, dsahern@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 Nov 2024 14:44:31 -0800 you wrote:
> Commit under fixes extended extack reporting to dumps.
> It works under normal conditions, because extack errors are
> usually reported during ->start() or the first ->dump(),
> it's quite rare that the dump starts okay but fails later.
> If the dump does fail later, however, the input skb will
> already have the initiating message pulled, so checking
> if bad attr falls within skb->data will fail.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] netlink: fix false positive warning in extack during dumps
    https://git.kernel.org/netdev/net/c/3bf39fa849ab
  - [net,v2,2/2] selftests: net: test extacks in netlink dumps
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



