Return-Path: <netdev+bounces-20616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D049A7603DC
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 02:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 179051C20CCC
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 00:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8522A15CE;
	Tue, 25 Jul 2023 00:20:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B757E5;
	Tue, 25 Jul 2023 00:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C0B6C433AB;
	Tue, 25 Jul 2023 00:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690244421;
	bh=/CYJf6waf/5H+qoHbl8j40uIaY97gRV1gVYHmtkTc60=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DY9qFiBJU1eT6ASnLKNZ7Y0v2xiqyg9ocqEnuDYE5rqHY8HBjpwZ0okTPw0rjRQQi
	 v8Fhs7FU0DeYVqUc0LB6r1LP0gHyHpdFe9+XFpg84eEuohx5Hko9mR5j8NJPesF6xe
	 d6zCbPZoBdkwMWaB1tSVKEWrgPnZTcl4eyXrKHtXnab2PGkJWQCuHsv75ocqUXKdx7
	 9bKtKgQVFdV9AbOnZuxHiHmTGQ4CcYU7bmdIAPQr+9CvH0jZ3lVA58tqmh2i91oWVm
	 rrf0cjOtufB2JXe76WMJa8D6z04boxYmw9LKsnxNROOLrgfpGebqZZLgGmLkBjol11
	 1H7/lcDTIvVXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 46D96E21EDD;
	Tue, 25 Jul 2023 00:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mptcp: fix rcv buffer auto-tuning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169024442128.15014.7119910740780685151.git-patchwork-notify@kernel.org>
Date: Tue, 25 Jul 2023 00:20:21 +0000
References: <20230720-upstream-net-next-20230720-mptcp-fix-rcv-buffer-auto-tuning-v1-1-175ef12b8380@tessares.net>
In-Reply-To: <20230720-upstream-net-next-20230720-mptcp-fix-rcv-buffer-auto-tuning-v1-1-175ef12b8380@tessares.net>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev, edumazet@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, martineau@kernel.org, soheil@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Jul 2023 20:47:50 +0200 you wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> 
> The MPTCP code uses the assumption that the tcp_win_from_space() helper
> does not use any TCP-specific field, and thus works correctly operating
> on an MPTCP socket.
> 
> The commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
> broke such assumption, and as a consequence most MPTCP connections stall
> on zero-window event due to auto-tuning changing the rcv buffer size
> quite randomly.
> 
> [...]

Here is the summary with links:
  - [net-next] mptcp: fix rcv buffer auto-tuning
    https://git.kernel.org/netdev/net-next/c/b8dc6d6ce931

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



