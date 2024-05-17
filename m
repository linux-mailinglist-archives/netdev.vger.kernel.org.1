Return-Path: <netdev+bounces-96841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD138C8007
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 04:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 943862836FC
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 02:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC37134A6;
	Fri, 17 May 2024 02:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXf7x117"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA63944E;
	Fri, 17 May 2024 02:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715913631; cv=none; b=UH2ekNgH2OdZn1VHzED834+ygbhyzZlLOr2wj/0wjeS6SYN73I5035B1TSzZxaOEeqnYf0dHM6n0sVJHARjEgiCyi8WJIFUjZNE1HcVc7ML/48DVChYuj1aPF90If2Lrcp0jJIH1cLvB537n3gpsgwMUSRbjfVLpDJswkFNULiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715913631; c=relaxed/simple;
	bh=k7znKN6JGauk6ykcKgo+Z88vg4lxjZPW3yH8AttVDrY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KWLwQLmvRTk78N95+EIdyZeO0txgRqy9jbwf8tSmOPqtpckIa4s0KsYLqsXYKrGTKodoyEwViKOX4QfML+bxWk1pd7WDwFohWhEfNUJYMDOjk1iLLIUydVJVAj1RFB77OUsCYiYz93lmSMi4KOgmDG/iRqPCedGF3LB9i+lTMr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXf7x117; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CEBD1C4AF0D;
	Fri, 17 May 2024 02:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715913630;
	bh=k7znKN6JGauk6ykcKgo+Z88vg4lxjZPW3yH8AttVDrY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nXf7x11720bnqlwQLsro1EhclG3C9wymT7ieqFcSmLQNOw1gl1Y6jCJG5hOYgkIGT
	 ahhPlxK0d5FZyyYXYbwH/R28rxJSR3WYu2ZsRr9hJqm8UAnQ0g8C8nAHzFW3Qk19Gz
	 KM5kLadWNwqVYwvHzyCuPr5KfbqttNP2MgC1G80583RTP2hVqqu/1KPXu/XWQUAvBA
	 svHtSf7zin+CrObrDweOWk+pXOYh/wJ+T1BUhxGhOKesAqIaQV5SE6RtbUuMqQ7zvW
	 27fp4ze137SxsgtEWgjQZTE4/cRwN7Mg3Pwv1hlYu6TF/1piFY9PxFWJ7+0e2XuRy0
	 6osNW+OT0wCgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1ACDC54BDC;
	Fri, 17 May 2024 02:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests/net: reduce xfrm_policy test time
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171591363078.2697.6035369319499887657.git-patchwork-notify@kernel.org>
Date: Fri, 17 May 2024 02:40:30 +0000
References: <20240514095227.2597730-1-liuhangbin@gmail.com>
In-Reply-To: <20240514095227.2597730-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 May 2024 17:52:27 +0800 you wrote:
> The check_random_order test add/get plenty of xfrm rules, which consume
> a lot time on debug kernel and always TIMEOUT. Let's reduce the test
> loop and see if it works.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  tools/testing/selftests/net/xfrm_policy.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net] selftests/net: reduce xfrm_policy test time
    https://git.kernel.org/netdev/net/c/988af276360b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



