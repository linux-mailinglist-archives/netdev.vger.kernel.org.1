Return-Path: <netdev+bounces-190588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 265BFAB7B84
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 04:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F0218C1377
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 02:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5181EA7C2;
	Thu, 15 May 2025 02:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uze1RoCC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F514C6E
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 02:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747275593; cv=none; b=LsC1/KL3IguV3au0vB5+1+rRZFmKZOWiXkg8yAvpcyJymW6wMB1e7SurWyGmknpDSSl4dvuCDqQZmwOBKZq2cjCR0YUvft4l9S7LuTSULBeP8sqH2euSvP+aVMaIMQMBZg08ihChnqPermGEd8MCLywAK+wQFuoB6VvmCqR/Efg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747275593; c=relaxed/simple;
	bh=/5ChEbwddK7BVTK3jh/la8U9H1syIfuXm9VW+NcHlpQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TS0QjDFmKZKwjqoPeDL1sblEIs4k3HdFPqn8JNYHDjiwusNWerGQCyx2chZe8MtH/B4AHXW0fY6EtwB3UaRZVWrtbL51tZAIm7VXpX7bi68XaDLjLAYwduq+MR0VX0meZ6MQC6abyDkF82EV3u1Hjn1WW+UfdmslwrZne7g71kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uze1RoCC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42E9C4CEE3;
	Thu, 15 May 2025 02:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747275592;
	bh=/5ChEbwddK7BVTK3jh/la8U9H1syIfuXm9VW+NcHlpQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Uze1RoCCCBTghkEzcUSoHCFv4xgGSaVT/quLvNYuBFKdWbPaw98CekeluHF8SmTWu
	 /mwuynDzZYbTDOZV/V19GwsU4HlVX2ny0xxkuGfnNa3E5XkIV4kJU8+kc/G7M1Jx6m
	 zOuEf039m4DbLvC2JURySGiwDO/1ddVkvH4jKtY2ViLWe67Q1+wamLqfwfnZADBn8Q
	 bCfVaYE4pqQ/QaEKQlC7G9OD9WGKmmeJeEy9tiTrYIlvsKfI2necWgrTCbYvE4jP8B
	 MJCQHSj4nMKqut9hBtQ5P/MRLrUcwjEzmYcY/QSWEGa6V+4roXkgPCmgz7BNtuRR6E
	 hz8KlY5HJo0Yw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B98380AA66;
	Thu, 15 May 2025 02:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netlink: specs: tc: all actions are indexed arrays
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174727563000.2582097.7715898434192695192.git-patchwork-notify@kernel.org>
Date: Thu, 15 May 2025 02:20:30 +0000
References: <20250513221638.842532-1-kuba@kernel.org>
In-Reply-To: <20250513221638.842532-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, ast@fiberby.net, jiri@resnulli.us

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 May 2025 15:16:38 -0700 you wrote:
> Some TC filters have actions listed as indexed arrays of nests
> and some as just nests. They are all indexed arrays, the handling
> is common across filters.
> 
> Fixes: 2267672a6190 ("doc/netlink/specs: Update the tc spec")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] netlink: specs: tc: all actions are indexed arrays
    https://git.kernel.org/netdev/net/c/f3dd5fb2fa49

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



