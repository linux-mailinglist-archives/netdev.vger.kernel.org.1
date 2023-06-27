Return-Path: <netdev+bounces-14309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC79E74016F
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 18:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42FD32810D0
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 16:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F9B13069;
	Tue, 27 Jun 2023 16:40:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F144A1373
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 16:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80DF6C433C0;
	Tue, 27 Jun 2023 16:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687884023;
	bh=w2D8t/VMojgXK2lyS/fzG64h7GtDArWYUhSoj2MxT6g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gdH4Dxn4O6Sm7VyNt7gislO5aeozvVcdKcUFy9kqRWtDSr84bcb49NnPfYPGbVeF4
	 10GdBwppLYYT6BKgn0vmgVWpAWBG+tMBJG9RPYYeY12Nm0ioOqxmGtUMaZBdrQZmfm
	 wNR+F/NMVT93eymf5zwMT5lCTlAFQY4yqynxltzMHpZcYkSzTdJC7cKPv7zxu5Mqxe
	 6dkA95gLSm/Hv/OLVK0+6mnu6w6ziDonPbgrjsZjObxXb6aHmlMcgvN2ro+/PSIZSH
	 zzG0qzRX2BMqeKaSzBiGdk3eFGD47ROTUcmWrbMS/7yFfqci1cxeB5cQxzkvXpayZQ
	 JQ+nABONfu5PQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 61DEFE53807;
	Tue, 27 Jun 2023 16:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] Revert "af_unix: Call scm_recv() only after
 scm_set_cred()."
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168788402338.21860.15081782447341175410.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jun 2023 16:40:23 +0000
References: <20230626205837.82086-1-kuniyu@amazon.com>
In-Reply-To: <20230626205837.82086-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuni1840@gmail.com, netdev@vger.kernel.org,
 konradybcio@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Jun 2023 13:58:37 -0700 you wrote:
> This reverts commit 3f5f118bb657f94641ea383c7c1b8c09a5d46ea2.
> 
> Konrad reported that desktop environment below cannot be reached after
> commit 3f5f118bb657 ("af_unix: Call scm_recv() only after scm_set_cred().")
> 
>   - postmarketOS (Alpine Linux w/ musl 1.2.4)
>   - busybox 1.36.1
>   - GNOME 44.1
>   - networkmanager 1.42.6
>   - openrc 0.47
> 
> [...]

Here is the summary with links:
  - [v1,net-next] Revert "af_unix: Call scm_recv() only after scm_set_cred()."
    https://git.kernel.org/netdev/net-next/c/9d797ee2dce1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



