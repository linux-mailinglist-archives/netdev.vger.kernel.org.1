Return-Path: <netdev+bounces-47604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F367EA9E5
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 06:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2AA11C20A1B
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 05:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4CABE67;
	Tue, 14 Nov 2023 05:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncMjpajz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD499BE5E
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 05:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A69DC433C9;
	Tue, 14 Nov 2023 05:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699938025;
	bh=yuFeCeHVw6TpC80nEGFdJTJ8o8aam2W26ocxYsqGH0o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ncMjpajzpdn+HZq3xFefDkO+DUdrfbKP2bNmzIJumTjeDFw+cyoKuU4ac5C5Qdvm6
	 AT3j7ktbOGP92MFR3J4xg9/649n6PvnG77V+LneCgv1KFoQOkHwpA+dOw7sQD6GlFY
	 v5Z5fMi2URS/17DOqHGXPJ9LnUGQNwLYkX+15xNJbnyHyAQi2yNkrLPGifC89GKM+d
	 PJ7iY6y+mEVWO8B6+sLdhzs1vstOOXRcjQuVGq1xk1ha/45HGjFTh6ftKhjXZ5BcZ3
	 xN7jJmQuGOtOUqP9pyy6vDynoGgBgQUltNzaSlDsJm/hMXyrUZthvvf7OMTWgxt2UP
	 lbiBpoORYbjuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D0D2E1F676;
	Tue, 14 Nov 2023 05:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ptp: annotate data-race around q->head and q->tail
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169993802524.31854.10280109954889583893.git-patchwork-notify@kernel.org>
Date: Tue, 14 Nov 2023 05:00:25 +0000
References: <20231109174859.3995880-1-edumazet@google.com>
In-Reply-To: <20231109174859.3995880-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, richardcochran@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 Nov 2023 17:48:59 +0000 you wrote:
> As I was working on a syzbot report, I found that KCSAN would
> probably complain that reading q->head or q->tail without
> barriers could lead to invalid results.
> 
> Add corresponding READ_ONCE() and WRITE_ONCE() to avoid
> load-store tearing.
> 
> [...]

Here is the summary with links:
  - [net] ptp: annotate data-race around q->head and q->tail
    https://git.kernel.org/netdev/net/c/73bde5a32948

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



