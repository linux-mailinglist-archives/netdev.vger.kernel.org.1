Return-Path: <netdev+bounces-238814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E209BC5FDC0
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 03:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3F7C535E8DA
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 02:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B682200113;
	Sat, 15 Nov 2025 02:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4qRwzVP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773DE1E5B64
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 02:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763172153; cv=none; b=ippcGsfrvyy+ikoEo4cbrZqmxIyRhJRjNLPOhS7KZJZgvJy93tn4WTq5KTuObH43/R8tG12BjSA+5ueLohFdTEF3UFodZ0ftzr6+64lElE4UN1p0iYbxi8xr+yiHz+XENO6szh8O5j2qmPQ7ZcNvYvW41j/X0quJquTXsjPzMDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763172153; c=relaxed/simple;
	bh=r1Y70oQkTCN8cDnZO+BT4wVD8fJOPgIQRFadr3fUvfY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NIobrgFWoF3bIismN5KSIZY47XyclNEWB5imrgyUfesby29V98LM2LUSf9PKjchVLS066RT+zgHCutAVshLPaY/XdNxB41Wyg+1GBsRj3w4HT6vM5Eyms1hdtY1IZ5nMa3OC3ySDI+SidZMwi+I4nHU1GbH6c91nwVfGgcB5QPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4qRwzVP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16381C4CEFB;
	Sat, 15 Nov 2025 02:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763172153;
	bh=r1Y70oQkTCN8cDnZO+BT4wVD8fJOPgIQRFadr3fUvfY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L4qRwzVPn7EGseyxx4loDfRa8iqce63DdA82VjzEAGrx2oCIGKGhcDlnrgtq5P5a1
	 ZXVBSUOzxfcfMY51e4q1y5r3twTs485vaczAXXYxyb4VWXf1aO0/Xp8/+QeqKutOCt
	 HXQ83fwHN1fHbW8ZCXM2Qpk1l/fdWZhtVdq3a+XFtl/TghTA2uW0XE0a7575s4WcP5
	 c5c/T42BUCGdnerJRkl9JT+ULd/XU/42fjDKygyCWHnLGOoT5r06MDiRwQjHLnW2TS
	 hCiN8cOv9yaKCVF7y731W2f0nj2S2V8jwpdZwWXovJ+W78xDawgFOXvIHPwUZWfru2
	 jR5lmhcSxpMSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDBC3A78A62;
	Sat, 15 Nov 2025 02:02:02 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] ipv6: clean up routes when manually removing
 address with a lifetime
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176317212124.1905277.14964839649058048268.git-patchwork-notify@kernel.org>
Date: Sat, 15 Nov 2025 02:02:01 +0000
References: <20251113031700.3736285-1-kuba@kernel.org>
In-Reply-To: <20251113031700.3736285-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 idosch@nvidia.com, dsahern@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Nov 2025 19:17:00 -0800 you wrote:
> When an IPv6 address with a finite lifetime (configured with valid_lft
> and preferred_lft) is manually deleted, the kernel does not clean up the
> associated prefix route. This results in orphaned routes (marked "proto
> kernel") remaining in the routing table even after their corresponding
> address has been deleted.
> 
> This is particularly problematic on networks using combination of SLAAC
> and bridges.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] ipv6: clean up routes when manually removing address with a lifetime
    https://git.kernel.org/netdev/net-next/c/c7dc5b522882

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



