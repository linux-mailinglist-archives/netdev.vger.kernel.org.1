Return-Path: <netdev+bounces-203070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6171DAF0755
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 02:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F7AA1C0464C
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 00:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B0F20311;
	Wed,  2 Jul 2025 00:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqxxekNo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A581A26B;
	Wed,  2 Jul 2025 00:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751416784; cv=none; b=hyLC6cl0Juouj9yw5lYesf2EgeJCYtJyZTqIlAFKaN4pL1Vql65qJXYXglxt8+CCQdCsBHirkUnM0SH9x+N+ipdud9dO04/RocCAXe4UbzLjr+EExPY7KMIi+yAo1g8dqY6kd3TvnfQFoV2yrhdAsmeokRLLBeBUMfLfnEUqQ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751416784; c=relaxed/simple;
	bh=o/xGom8IA8NsknYb8sIUXQnBpEJ2ngGA2mmaOOLrhoU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o5ot8RzhQK8YxU+WNIyH9bw+D8TBrpRVIFoh2ugcYzi8dsi75HOrnUcLwFJv2pBKEhUnVA5VsUe4BTaqcJB+RnqvW4Z6wANgv+Ce9EKN3F5moXAMDrnzs0eip1SFcaxhmOoW/NjMgjTV5KPFdpj98QRaqXG/YR8ImOabiiUyk80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqxxekNo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA08CC4CEEB;
	Wed,  2 Jul 2025 00:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751416783;
	bh=o/xGom8IA8NsknYb8sIUXQnBpEJ2ngGA2mmaOOLrhoU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tqxxekNoRAV+Q1oe2ceSBD6gcIcr4TO/Q/aluYhP6nfJW4a7WT8k2vnk2rfBSPC70
	 lanPYE3yiU0FkGqFXJi40Ax/CVUWa1THkMysI7Wyu91slGP5WfwHxz/Xl/wPrKHkKR
	 IPDtUruqQpCatnGd2uAxDEC+D9XIq0cAjKfwFCdGR9WgYINqxjPooO0rHiJGDMsdsk
	 d3+yZRRCguIinGB7GUI5EbYQNzUx2TcAVLO8AsVNrkq1FxfR/a6MPNd27npNJ/SxId
	 53Z1hz8WXAzOtPzckGDDzLaVLlXzBf2oUYm+t9spa0kP+TWTq7BHvBcVu3J4wP2uVv
	 YaGu/YDlrJwTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE14383BA06;
	Wed,  2 Jul 2025 00:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] lib: test_objagg: Set error message in
 check_expect_hints_stats()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175141680850.158782.14637527276749679466.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 00:40:08 +0000
References: <8548f423-2e3b-4bb7-b816-5041de2762aa@sabinyo.mountain>
In-Reply-To: <8548f423-2e3b-4bb7-b816-5041de2762aa@sabinyo.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: jiri@resnulli.us, arnd@arndb.de, akpm@linux-foundation.org,
 idosch@mellanox.com, davem@davemloft.net, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Jun 2025 14:36:40 -0500 you wrote:
> Smatch complains that the error message isn't set in the caller:
> 
>     lib/test_objagg.c:923 test_hints_case2()
>     error: uninitialized symbol 'errmsg'.
> 
> This static checker warning only showed up after a recent refactoring
> but the bug dates back to when the code was originally added.  This
> likely doesn't affect anything in real life.
> 
> [...]

Here is the summary with links:
  - [net] lib: test_objagg: Set error message in check_expect_hints_stats()
    https://git.kernel.org/netdev/net/c/e6ed134a4ef5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



