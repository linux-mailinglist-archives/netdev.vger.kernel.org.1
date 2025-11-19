Return-Path: <netdev+bounces-239779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80862C6C589
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 03:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4F84F352097
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 02:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCAB27055D;
	Wed, 19 Nov 2025 02:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7TCOVL0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3597B2376E0
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 02:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763518261; cv=none; b=LHSbG7B8A5QkeWn8AWX9JtdZGZsnrjLSSvvr6tVd9IfFFm6ZtRpyyKr8CdQTV4V9Wk3EW15bibumIuAN4uXAPjeT9MLL2vNJpBgpTxzmDJwSlNe9VGmOYrTW64F381wZm8zenHzXuusv7bp7PnANacDYuENrw3c6ycMon6BhEhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763518261; c=relaxed/simple;
	bh=IY4pIDzwBvApBk5L+qnIM5FpGtKDNWHXMzMROPS3ZqU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CTMtOnpa1VegiHvgpFhXh6AePCODzRkAIP7+nXAQAL7xNNgdKdd4At5yupBDFjmsMQgBao7U5/Xbal807clrWwHIeT/Ew3GjOURA0uZzdhhndcVfaCvyl85Rh0/mAYqsRws/SPFItVx1hQSosPjB9eE2dwaCGZLutCRp24ZSoJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7TCOVL0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE18C4CEF5;
	Wed, 19 Nov 2025 02:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763518260;
	bh=IY4pIDzwBvApBk5L+qnIM5FpGtKDNWHXMzMROPS3ZqU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T7TCOVL0a4LVRRszB4tLj8GmdWYMVHt6INIjLIb+9oyBpO/j55y+F4lCauOG8+27X
	 Xu7Uv2sQK9bAvCS/hXe/Ay95HFw5pUPxiyKHxTepetogptnDLl5MAJzDLMyv/g/xa3
	 GzGTQesWyCAop9C59Qfief4XUONpZSPbeRqCt+UkvM+buFFuclHPioleVfvJ5GWuDQ
	 SsFJmaNIaqxDkvc0J4XvNpyd7/9cYU6UL1WVq5zS0dVq1C/rRZU14fXOGVuBsp0hsN
	 XUdxXIvHHmba6noGiZyL8l0iMDNU/b8YkFrfG8OzbP9Qr94Y+ihArK8L7y0ZB8trO3
	 FZlUuxHNEYq3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1A6380A94B;
	Wed, 19 Nov 2025 02:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] tcp: Don't reinitialise tw->tw_transparent in
 tcp_time_wait().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176351822549.182718.113533008094323243.git-patchwork-notify@kernel.org>
Date: Wed, 19 Nov 2025 02:10:25 +0000
References: <20251118000445.4091280-1-kuniyu@google.com>
In-Reply-To: <20251118000445.4091280-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ncardwell@google.com, horms@kernel.org,
 kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Nov 2025 00:04:40 +0000 you wrote:
> tw->tw_transparent is initialised twice in inet_twsk_alloc()
> and tcp_time_wait().
> 
> Let's remove the latter.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> 
> [...]

Here is the summary with links:
  - [v1,net-next] tcp: Don't reinitialise tw->tw_transparent in tcp_time_wait().
    https://git.kernel.org/netdev/net-next/c/932478bf9f6d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



