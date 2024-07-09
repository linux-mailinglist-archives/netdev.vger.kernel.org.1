Return-Path: <netdev+bounces-110406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF6292C334
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 20:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2D991F2403C
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 18:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9CF17B020;
	Tue,  9 Jul 2024 18:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iW7vRwEN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE71312D766
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 18:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720549256; cv=none; b=TThRxQD36BBKgmeBH38sC7NA2yz2lTH739hgpeWmretk1PWqzyxFw/Q0qJzu9pdRLgfp7dIyQyeSuJj7wk+nUSg4tbdhh+wHJngICH3mluW3Ldm9DOdxaO3/oOvA9N0R0U7Jghpkd5yXRKEzeU7EnS87KFYlc3/bUhp40qpui3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720549256; c=relaxed/simple;
	bh=DFPufGtnVhGvJBQB+VrpcLpVZAzdy7Gmaa1v+8/adNs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=unCBbPnQo9Pw2BjUq9zJzKrJRPRcTsaHuSeiDjMbGT30qulCh9SSXFNaBlJDxGY7RCQKdJ1FK42WntpVgmlXTyqrBgNkg1Tq6rZr3cjmC9IFWck69r1UWxr4J9oKLA/LRV10856JILH9VCXFGBv71C61EOFnF4LQzqkgSgv8Yhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iW7vRwEN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B356C32786;
	Tue,  9 Jul 2024 18:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720549255;
	bh=DFPufGtnVhGvJBQB+VrpcLpVZAzdy7Gmaa1v+8/adNs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iW7vRwENFSm7i6GtW+TS1Ae9z8aw2YhMWhzU4azXPNUG42rstJyUZ++7wvt39P1Uz
	 nEt1mxsxgD4TliOiN/rF0HRnfJV1Nw3uWG3CL9317iQxzyv4kVKFjyJelsnX/4rcxH
	 2BiCP84+0R5Buf7X1qYkxlmgmY2oAWXud6u+e5phPd4FSKXPDghXdVtPE9jOs+U8ui
	 j8QZfUIa0BIpikIP+kRLoB+M+QmZPN5tMoMadh3QWdQycUzI8FLFwAwqE3K4/mdnMt
	 k4k5kLMaogYZsN1bagx82bPnylUEPDURc4C4r5ihYW81v8s+mh1hUBAavJDB8ZNl8k
	 kUHb8Zi/A42Hg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5979EC4332C;
	Tue,  9 Jul 2024 18:20:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: forwarding: Make vxlan-bridge-1d pass on
 debug kernels
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172054925536.11456.10099668582730182659.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jul 2024 18:20:55 +0000
References: <20240707095458.2870260-1-idosch@nvidia.com>
In-Reply-To: <20240707095458.2870260-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, petrm@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 7 Jul 2024 12:54:58 +0300 you wrote:
> The ageing time used by the test is too short for debug kernels and
> results in entries being aged out prematurely [1].
> 
> Fix by increasing the ageing time.
> 
> The same change was done for the VLAN-aware version of the test in
> commit dfbab74044be ("selftests: forwarding: Make vxlan-bridge-1q pass
> on debug kernels").
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: forwarding: Make vxlan-bridge-1d pass on debug kernels
    https://git.kernel.org/netdev/net-next/c/3699e57aae88

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



