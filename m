Return-Path: <netdev+bounces-61473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C88823F71
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 11:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 841CBB21600
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 10:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2767320DD8;
	Thu,  4 Jan 2024 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1fihzQ2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069E920DD5
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 10:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77472C433C9;
	Thu,  4 Jan 2024 10:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704364226;
	bh=Ubrxvdscr6NSU+tZOzdhbGK2e99/tQqxaGKzSUHKQK0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g1fihzQ2s1eIX0BUyoWJiHpTiVEhYuIQ6/qg+8/AJkctbKoQSo+wGLWi/JUqiB5UI
	 blswNVYy/KpPn6k1s1X+wKSBvjUUhc2PWDMvdjsISJHVk4fAGu1GqPLElfmO3A4Uql
	 44Ct+1NWj0BNH3bK8Fw4VHcGyO2qmBKSG0q0kAHgCEA2FCQYdGlKC/Hd70QVIZRoYh
	 F7grzRxuf/l3llNEeqeftCUOBVgI0DPrUjsrGL1SMcdqVVOG+KRuh2VArvXUobYiDv
	 lSlkjMDVQCJX255whSC/ohTmWiH75/nmmUJxt/vr9z8o3TNZhtOy/ZUAyf/3qHwymz
	 U6tgjiA6FD8uQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5AC4CC3959F;
	Thu,  4 Jan 2024 10:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] sctp: fix busy polling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170436422536.28338.15558044259425144269.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jan 2024 10:30:25 +0000
References: <20231219170017.73902-1-edumazet@google.com>
In-Reply-To: <20231219170017.73902-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, jmoroni@google.com,
 marcelo.leitner@gmail.com, lucien.xin@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 19 Dec 2023 17:00:17 +0000 you wrote:
> Busy polling while holding the socket lock makes litle sense,
> because incoming packets wont reach our receive queue.
> 
> Fixes: 8465a5fcd1ce ("sctp: add support for busy polling to sctp protocol")
> Reported-by: Jacob Moroni <jmoroni@google.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> Cc: Xin Long <lucien.xin@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] sctp: fix busy polling
    https://git.kernel.org/netdev/net-next/c/a562c0a2d651

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



