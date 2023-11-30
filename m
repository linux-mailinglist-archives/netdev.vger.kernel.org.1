Return-Path: <netdev+bounces-52376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5ED7FE83B
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 05:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C90BA28182E
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 04:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661F9168BD;
	Thu, 30 Nov 2023 04:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXF9NFY/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B35353B1
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 04:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11B4BC433D9;
	Thu, 30 Nov 2023 04:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701318034;
	bh=dBS5lB2qKeAdPW9CSIigrC/KUKHtXgHivBvgCPSL8YM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tXF9NFY/zFK5cBUxVMxc0w/06tjr/HEvHsEX0CL0yPtyOH7BqWZmtseXbo6Vud9om
	 S+6zy7f3p+chZS+dS9t0h38M8ILuT7cnoqybLg/kf5GpLKfwfvU+AC1WE3+60tVyHM
	 5Mmyc7Vf4MDt9EaDG3O/NskMsMkJnTZwZVWO/BBioNHth1o96XCfbiaHBpAFlpE09z
	 BiJyVFedgmpcdpt4BGLsV8yp1sWAXd9EPIqKq+QWmBIRP7CbprWpvXqhnZXaS/xfsx
	 ZrWkPm5Hbs41RhDUXYNGrN2IN4Da83BfLMcGUXsb8XY8Tkw/hhRj4jHkXLCZh/FIB5
	 u3E4hUtylwAAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E839EE000A3;
	Thu, 30 Nov 2023 04:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 0/8] tcp: Clean up and refactor
 cookie_v[46]_check().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170131803394.31156.6126240264416407387.git-patchwork-notify@kernel.org>
Date: Thu, 30 Nov 2023 04:20:33 +0000
References: <20231129022924.96156-1-kuniyu@amazon.com>
In-Reply-To: <20231129022924.96156-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Nov 2023 18:29:16 -0800 you wrote:
> This is a preparation series for upcoming arbitrary SYN Cookie
> support with BPF. [0]
> 
> There are slight differences between cookie_v[46]_check().  Such a
> discrepancy caused an issue in the past, and BPF SYN Cookie support
> will add more churn.
> 
> [...]

Here is the summary with links:
  - [v3,net-next,1/8] tcp: Clean up reverse xmas tree in cookie_v[46]_check().
    https://git.kernel.org/netdev/net-next/c/34efc9cfe7c6
  - [v3,net-next,2/8] tcp: Cache sock_net(sk) in cookie_v[46]_check().
    https://git.kernel.org/netdev/net-next/c/45c28509fee6
  - [v3,net-next,3/8] tcp: Clean up goto labels in cookie_v[46]_check().
    https://git.kernel.org/netdev/net-next/c/50468cddd6bc
  - [v3,net-next,4/8] tcp: Don't pass cookie to __cookie_v[46]_check().
    https://git.kernel.org/netdev/net-next/c/7577bc8249c3
  - [v3,net-next,5/8] tcp: Don't initialise tp->tsoffset in tcp_get_cookie_sock().
    https://git.kernel.org/netdev/net-next/c/efce3d1fdff5
  - [v3,net-next,6/8] tcp: Move TCP-AO bits from cookie_v[46]_check() to tcp_ao_syncookie().
    https://git.kernel.org/netdev/net-next/c/7b0f570f879a
  - [v3,net-next,7/8] tcp: Factorise cookie-independent fields initialisation in cookie_v[46]_check().
    https://git.kernel.org/netdev/net-next/c/de5626b95e13
  - [v3,net-next,8/8] tcp: Factorise cookie-dependent fields initialisation in cookie_v[46]_check()
    https://git.kernel.org/netdev/net-next/c/8e7bab6b9652

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



