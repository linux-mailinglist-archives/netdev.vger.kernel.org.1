Return-Path: <netdev+bounces-63257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1059F82BFB0
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 13:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B46D92852B0
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 12:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AC96A323;
	Fri, 12 Jan 2024 12:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tduj5pl7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9FF6A038
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 12:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55A06C433F1;
	Fri, 12 Jan 2024 12:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705062026;
	bh=mjelHy6a6ncuG+KTycAHuM/EUt149WUDlqfoaB9rOLw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Tduj5pl75Q7PgcnhSGLIAZmifHcojMuvLpMbXMD4E3RlSi0OPdA9Tw8D8HbYNxSry
	 yQ3VvQBmk/87B0Ir+zTtKWW7s4ADz1p9LHpfnWDPgqwIzRgThJE5K136rB4ImGCtgI
	 B5jzB1MO9xNUVn3poLmIwPV3altqKp2/4V7lKiehqgWoQGaotKX4TFXt1EXot4E72O
	 I50kbLYiwIX9wlbLWSoKHn8sHYNVHmqWhq0dpZjueP78kN6dw14llhZuqX4lsK84ge
	 cUpcJ/5lh2KSQSPLkRCRvKZNhCjZ1Orx3WqzFtqA7K2kkhIqB9d8BavLeg1RrWAtDP
	 DHH2Q4cP3P8LQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3B3C7DFC697;
	Fri, 12 Jan 2024 12:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: fill in MODULE_DESCRIPTION()s for wx_lib
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170506202623.29207.13864695075459061469.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jan 2024 12:20:26 +0000
References: <20240111193311.4152859-1-kuba@kernel.org>
In-Reply-To: <20240111193311.4152859-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jiawenwu@trustnetic.com, mengyuanlou@net-swift.com,
 duanqiangwen@net-swift.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 11 Jan 2024 11:33:11 -0800 you wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add a description to Wangxun's common code lib.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: jiawenwu@trustnetic.com
> CC: mengyuanlou@net-swift.com
> CC: duanqiangwen@net-swift.com
> 
> [...]

Here is the summary with links:
  - [net] net: fill in MODULE_DESCRIPTION()s for wx_lib
    https://git.kernel.org/netdev/net/c/907ee6681788

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



