Return-Path: <netdev+bounces-210311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 365F4B12BE4
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 20:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1455917949F
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 18:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1617628934B;
	Sat, 26 Jul 2025 18:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVGxIMCT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6391289E0B
	for <netdev@vger.kernel.org>; Sat, 26 Jul 2025 18:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753555210; cv=none; b=VLAHo57xpyPF5ClTD0HitfM+srX/XvxbzxeW8/WhyB04P0bbefBC0IGKiNfwvdH71M9pNIM+oluLMFa2R1YHgzxVJsxSbeX5A4pX9yg/y1da5GyfhXVpEcNs2IH+/O7SncWRQE0NjTW/L8Lc14JIX5EcMtLeL2FwoefTGeF6utE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753555210; c=relaxed/simple;
	bh=HSeLxBCkZ/VAh0XF6l03cyOsVjw4dShYB6D1J+SxyzE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OzYSFp4R7CHVWjignkCELxpkBe/eNBOW+3BEp0h84nF/+5x5jTq86aW8UMFxSWz/05WdG4VO0D6tsYwGF699rSo8f+lWZxhTPzucScynj2Z2xUCQ5w5QCZKv2xUcu/wp1VAmkSnFYbe4Iur4cRQj/KfO8WcGgtgkYdr2hVTslr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVGxIMCT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3DBC4CEED;
	Sat, 26 Jul 2025 18:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753555209;
	bh=HSeLxBCkZ/VAh0XF6l03cyOsVjw4dShYB6D1J+SxyzE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YVGxIMCTlNBOAUUC54uaRwogSGGwwP35jRPMe+VCN0iT7D6SLkx8olsjaCTQDkqHp
	 CMgYxCkmvpW87gVC3B45DLXVYpXyjsyIRgoBx9KcKIRWKfXnm8wVxEeOHiZQQlBzb6
	 nbwlhkI1PcU92ZMYO2/EIaCKj96ED15s3y9De4qnQd3mSr8nI58Cm4ErC+2GVedZxr
	 GOByJ2IR/qC3mrHMZOxjON7qikk8unw5rys0j1+Gw8ZphFSCLh+RXTLUkAHxZutW6s
	 PMPiWg8zx7WnD+1/6/LwMB4tzCskh29Q+WxhbkuNiF/3fPR4uKNnlOKoxe3l6/cMQ+
	 QP06rthduMlkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF63383BF4E;
	Sat, 26 Jul 2025 18:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/sched: taprio: align entry index attr
 validation with mqprio
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175355522675.3664802.377944969252146800.git-patchwork-notify@kernel.org>
Date: Sat, 26 Jul 2025 18:40:26 +0000
References: <20250725-taprio-idx-parse-v1-1-b582fffcde37@kernel.org>
In-Reply-To: <20250725-taprio-idx-parse-v1-1-b582fffcde37@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: vinicius.gomes@intel.com, xiyou.wangcong@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 maherazz04@gmail.com, pabeni@redhat.com, vladimir.oltean@nxp.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Jul 2025 10:56:47 +0100 you wrote:
> Both taprio and mqprio have code to validate respective entry index
> attributes. The validation is indented to ensure that the attribute is
> present, and that it's value is in range, and that each value is only
> used once.
> 
> The purpose of this patch is to align the implementation of taprio with
> that of mqprio as there seems to be no good reason for them to differ.
> For one thing, this way, bugs will be present in both or neither.
> 
> [...]

Here is the summary with links:
  - [net-next] net/sched: taprio: align entry index attr validation with mqprio
    https://git.kernel.org/netdev/net-next/c/c471b90bb332

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



