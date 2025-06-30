Return-Path: <netdev+bounces-202536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 476A7AEE2CF
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 17:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63CFF3BA597
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 15:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F4028FA9E;
	Mon, 30 Jun 2025 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmKMNjZS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E79328FA85
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 15:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751297982; cv=none; b=rEepiIMCD4i31fts1Tj13bX6a+9FFe2sl8AsicSrPNVZUf7WLmV+MTLekWMC5B6DiGzVgHx9YQHj94wsLqGu3pLnrCniDLYwgHOa09lD0hJ0R4i349VoER9i4OWWRqu0hnaRL2MUoJ4vOIgTF7JLtEF+AupgnTaEXY9ogXQqdU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751297982; c=relaxed/simple;
	bh=mt6iKyNy2SgOPfZV9hnPbIl/LQwJ6ZQIG9sEZOWdQhQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fa+4f23QbUMMDeWrWbKU90HG3ygGnUWMzm22/xmq3JzfS1IDRfwNj+1KiS8GUaGjfBVhMfXwHWvi2w42yVJGGQYJ55lxlMwKUwZRYFMj0Di5KRgC6Ucz9cYnkurp1JMvdDJtxu2+JkA0zzEXleEMTrPDY5XO6gN7wQY8ySEGsIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmKMNjZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91B7C4CEF3;
	Mon, 30 Jun 2025 15:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751297981;
	bh=mt6iKyNy2SgOPfZV9hnPbIl/LQwJ6ZQIG9sEZOWdQhQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pmKMNjZSVqEURWihleW1G6Wn9OUExYe1p07l1Ez1WbaBE4Du0NtiQ6ClEulyawpLS
	 wXDjAUt8JlILLwY4yg9INdwM4yx2KB+QTLp1xlGTxnapUdrsrM8wOg2tzisdm52V/A
	 faXZRQWAzgZoAw9NTg7u3y8AUYyPlW40ws3EHgMHhDYKK4pz+kJiNqwRlMjseNq+/w
	 c4yzuO06FlMJRrhv9Ae9et6QGgEahmRVi/WZkiHyzgq6wSavrUdBYcDCd1z7Bu7Ok0
	 1Rx+N/kuCyI9TN7oMzIx46+U+EyNWaMZb/elZBF1mWP4qs9dqrGMkaKLBNEmyNdISN
	 VgSdXjy1vMTjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B1B383BA00;
	Mon, 30 Jun 2025 15:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethtool: avoid OOB accesses in PAUSE_SET
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175129800702.3427864.3419337801355734142.git-patchwork-notify@kernel.org>
Date: Mon, 30 Jun 2025 15:40:07 +0000
References: <20250626233926.199801-1-kuba@kernel.org>
In-Reply-To: <20250626233926.199801-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 syzbot+430f9f76633641a62217@syzkaller.appspotmail.com, andrew@lunn.ch,
 maxime.chevallier@bootlin.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Jun 2025 16:39:26 -0700 you wrote:
> We now reuse .parse_request() from GET on SET, so we need to make sure
> that the policies for both cover the attributes used for .parse_request().
> genetlink will only allocate space in info->attrs for ARRAY_SIZE(policy).
> 
> Reported-by: syzbot+430f9f76633641a62217@syzkaller.appspotmail.com
> Fixes: 963781bdfe20 ("net: ethtool: call .parse_request for SET handlers")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: ethtool: avoid OOB accesses in PAUSE_SET
    https://git.kernel.org/netdev/net-next/c/99e3eb454cc4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



