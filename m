Return-Path: <netdev+bounces-177328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3D9A6F461
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 12:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C05DB7A5276
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 11:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7577A2561C8;
	Tue, 25 Mar 2025 11:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyFp6Cvv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6852561BF;
	Tue, 25 Mar 2025 11:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902800; cv=none; b=NbRrUlbcpXK/T55MwK0J9Li/V5EjHpcjYxoppiRQzxJGq6yWemtSL8LMbvT6vEWq1io5tba0wbZyYGzWVt6QtIIHm0rQI92iWrwICJPP33PwAYKbOSHkF8q687cJ7ZHJYFDmoYwHvyZa9ovATk+PSTVcrS67ukFFfZzgRcRaSe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902800; c=relaxed/simple;
	bh=UJ3PR/aOzNTP/9EyaL5yfKfrM5PQAQcxIZh6cRaHv5o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MJ4lbz5uTzcbwXu2NDbhl284xMPMY/ZAb5taMBCQ2PqCi4t+F5PG0kUF7gScqvYslX+lhw8SzUrXo1sr3EbMYbk+TfYGPes1eqU42nuo2XaB3GkzVX4BmFLfi8KY3ofgKEQj626lz33zCcitVoyiJmd/tmNhoe1z3JhGx2CBP8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyFp6Cvv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2574C4CEE4;
	Tue, 25 Mar 2025 11:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742902799;
	bh=UJ3PR/aOzNTP/9EyaL5yfKfrM5PQAQcxIZh6cRaHv5o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GyFp6Cvvjiym38w/QOV2Q0F/Sd+TBFaHp5/hKLPOJPCGMV/izvygpSFlGA2dN2hB7
	 rcQYhV1odBT2dTnW8FiDlUeoy9oFtEzD5TCIsKceMvJk3r6bnpE+Z9/KM0bi8Q1Sae
	 rHXs9BLj5JLCUNChKPTSKOncVqX2hKq4GrmU9LHvdhzdBBeELz/DAIcg8q2GRlNZsy
	 ZDfETDb3EQYEKp7YjfVBST1qAYK8CNyQqMO3Ub4vjDKV874i9FhBgoOX/LhuEM8mxh
	 H5+erFp40Y56HGHYZqwU6JKgwQtnWL2beGXzcxHp1wz6ZErLNALNlcrytTm9x7B1+J
	 HS4HFm4sJsrnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B96380CFE7;
	Tue, 25 Mar 2025 11:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: tulip: avoid unused variable warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174290283600.528269.2264732089213374671.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 11:40:36 +0000
References: <20250318-tulip-w1-v3-1-a813fadd164d@kernel.org>
In-Reply-To: <20250318-tulip-w1-v3-1-a813fadd164d@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, deller@gmx.de, netdev@vger.kernel.org,
 linux-parisc@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Mar 2025 13:53:34 +0000 you wrote:
> There is an effort to achieve W=1 kernel builds without warnings.
> As part of that effort Helge Deller highlighted the following warnings
> in the tulip driver when compiling with W=1 and CONFIG_TULIP_MWI=n:
> 
>   .../tulip_core.c: In function ‘tulip_init_one’:
>   .../tulip_core.c:1309:22: warning: variable ‘force_csr0’ set but not used
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: tulip: avoid unused variable warning
    https://git.kernel.org/netdev/net-next/c/6165feda3d8c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



