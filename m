Return-Path: <netdev+bounces-196392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 453C8AD4706
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 01:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70F3D3A863F
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 23:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B4628D85F;
	Tue, 10 Jun 2025 23:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HinrPqMQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F374028CF77
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 23:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749599427; cv=none; b=GZcZW7riIG0Qd5fvF9eg0Dl3nxaJw6cbwwkOlbzmkLaJydoTHgtJVe+0XASWJA51nf2CU0+OgYsVS1XjK4OGBI63SBq2Wc1FTrX8o6zqLrbrV4FYuoVVFl/++TJbUHm/rRtNULW7IREvVR7ToUvQuDLKFFaRQBl2J5wkjP6XPP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749599427; c=relaxed/simple;
	bh=6YKgl1/FIodNh8f8Cp2Mqb8qAlDyi/CAgU9x+eLuGiw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R1yyxtp4dyGnQw/m7+AZ7vWBOc3doOnKKZdlI+dSNt3HxPOR7/GBzIkeqzu9Cq0kGAIWGqEJyU8WP1Eo0K7ajyK/xhqeHhThrSsP3yNHIHu2Fvu/gL60R0mbfXKaSW8RHxB3r/Uk/r7SSLVIbv94pPiKVCRE0pMh8qmDwingeVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HinrPqMQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36BAC4CEED;
	Tue, 10 Jun 2025 23:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749599426;
	bh=6YKgl1/FIodNh8f8Cp2Mqb8qAlDyi/CAgU9x+eLuGiw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HinrPqMQPvJ9iBIn8O8ezaSZKwSUxjcFjsz6TxcM1tNOSYZKJrxoh7/5Rc5wlWLKC
	 I1njoii2hkpAWxuO6HwG8yUB/0Scx1GhF3LuhoRXmjQNkjnyF2L5jO4ev9sq9E2qxM
	 toM0iehQ8jlrPAlzG0OmfoPPcNs4HdKRCth3mfwc7Odzxit3LE/W71+BMMyjhrUN1D
	 xO2w48ArtMmWnDQ94K8T5qjbv892zuANa6qDFkbM9/jhobEg8tOwNOMAnaktsv8GwH
	 Y8lwgPP5rMxgO40HsiOoJ10iG78VO7cvnBkHXNya5BKIlRZHOD3VbM4v1m6ExjNO0Y
	 wJAebOmwjCtNA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70A7238111E3;
	Tue, 10 Jun 2025 23:50:58 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH ethtool V2] json_print: add NULL check before
 jsonw_string_field() in print_string()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174959945698.2737769.12311191847890318758.git-patchwork-notify@kernel.org>
Date: Tue, 10 Jun 2025 23:50:56 +0000
References: <20250518130110.965797-1-ant.v.moryakov@gmail.com>
In-Reply-To: <20250518130110.965797-1-ant.v.moryakov@gmail.com>
To: Anton Moryakov <ant.v.moryakov@gmail.com>
Cc: mkubecek@suse.cz, netdev@vger.kernel.org

Hello:

This patch was applied to ethtool/ethtool.git (master)
by Michal Kubecek <mkubecek@suse.cz>:

On Sun, 18 May 2025 16:01:11 +0300 you wrote:
> From: AntonMoryakov <ant.v.moryakov@gmail.com>
> 
> Static analyzer (Svace) reported a potential null pointer dereference
> in print_string(). Specifically, when both 'key' and 'value' are NULL,
> the function falls through to jsonw_string_field(_jw, key, value),
> which dereferences both pointers.
> 
> [...]

Here is the summary with links:
  - [ethtool,V2] json_print: add NULL check before jsonw_string_field() in print_string()
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=fd328ccb3cc0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



