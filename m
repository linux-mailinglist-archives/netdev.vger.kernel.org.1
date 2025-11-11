Return-Path: <netdev+bounces-237403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED42AC4AD0F
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 02:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C2BF44FBDE3
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 01:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E04267B07;
	Tue, 11 Nov 2025 01:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NM204X3K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DC6158545
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 01:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762824635; cv=none; b=ir3HMFV3dazzERGdFB2GjbmnUCQ/EVlxcU8kYIQc8EXUVw5Au/p7k1lEK3R2WgXxDrAOOuHXVsTLQ2jox8QZ5Z3OeXA8MnQITJhjxp/SbnQGH+GJcdU7dV1udQXqaeSaR+DNPOWpqpwk6YGP+KDXmjdrGA6EBuQJ7TenHI17Lkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762824635; c=relaxed/simple;
	bh=HgbPRmYEmAN/5YWZQeBNKs6LmTG6q9I830tW3lmN9jg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jkyc3aKECfAy/QUnh8T6/pa1wUlO0FjJLDw7ZIvZ+X07vVTqLSOjQYZwuyT60sknlUHCR5QsA6l2/XWiKZd0+Fsuz6vieSvbN97xZi+z9WMGc1bGsBtXzc/c3mDzB+pPJmYCEDV6IY4rB5anYEC15Ke4mwLnq3a/EK1yuyi/S5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NM204X3K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A08C19421;
	Tue, 11 Nov 2025 01:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762824635;
	bh=HgbPRmYEmAN/5YWZQeBNKs6LmTG6q9I830tW3lmN9jg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NM204X3K1+70xC7wEirW6kQQsFVxTzeoPLHWeQ453kK4/pNZ0xF7Iivb+oBcTD4/U
	 +X4pAERDBjX2VJzn43qw6ALPmbeLxiKFb3zovk0W1W/5l2P9xuRPW7YYWGQ5uXzfcA
	 VY5horpdi/OF2ngg5qS4t9FV/YtL6+JiM4rsMAWZsSZz+ksO5aQw7yBT4q/Z5UKlP5
	 XyDdQhaRR+cQzIMIgeD36Z+cN6e+FOYf9sf+xxXXs2KdL5V2tIiXpAhw8vVB0JI1zg
	 kCi+0TwDatsi7jBvDfXsSa5YRdRceqiQUXScWIU8O0sV1dq6kJ8F6OzBgFIIphULNd
	 P08OYSFnBPFxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB126380CFD7;
	Tue, 11 Nov 2025 01:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/3] ynl: Fix tc filters with actions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176282460576.2841507.5529895194461903454.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 01:30:05 +0000
References: <20251106151529.453026-1-zahari.doychev@linux.com>
In-Reply-To: <20251106151529.453026-1-zahari.doychev@linux.com>
To: Zahari Doychev <zahari.doychev@linux.com>
Cc: donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 jacob.e.keller@intel.com, ast@fiberby.net, matttbe@kernel.org,
 netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, johannes@sipsolutions.net

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Nov 2025 16:15:26 +0100 you wrote:
> The first patch in this series introduces an example tool that
> creates, shows and deletes flower filter with two VLAN actions.
> The subsequent patches address various issues to ensure the tool
> operates as intended.
> 
> ---
> v2:
> - extend the sampe tool to show and delete the filter
> - drop fix for ynl_attr_put_str as already fixed by:
>   Link: https://lore.kernel.org/netdev/20251024132438.351290-1-poros@redhat.com/
> - make indexed-arrays to start from index 1.
>   Link: https://lore.kernel.org/netdev/20251022182701.250897-1-ast@fiberby.net/
> 
> [...]

Here is the summary with links:
  - [v2,1/3] ynl: samples: add tc filter example
    (no matching commit)
  - [v2,2/3] tools: ynl: call nested attribute free function for indexed arrays
    https://git.kernel.org/netdev/net/c/41d0c31be29f
  - [v2,3/3] tools: ynl: ignore index 0 for indexed-arrays
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



