Return-Path: <netdev+bounces-72760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC73185984A
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 18:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 966F3281B64
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 17:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF07D6EB7F;
	Sun, 18 Feb 2024 17:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNH8IJ2E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9266BB58
	for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 17:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708278626; cv=none; b=IP5sd0lam/Ix1GmJTuInnsSc6V6EvhAUWLTvs8K+J0FDVqhtUZOSIO25gp/LNhf+I00lULMKJxyB9AotfVoTM/5fDNiSc7obViEAHeBhHo/g+Moajj0J6URhLa9R5JlGuNBeET8Zf1en2FqpISMam1x5ThxIV9HdqSJxM9gmOGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708278626; c=relaxed/simple;
	bh=Arg5IYgbFZxDNEXGigVOshFsxH86bJXtm8ixxUbMSvk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pDdJV9HsGvdYSVeZe+hsqseObmkYGD27cKXcAscULDMw5HWVyPp8K7M5lQQTRwpg0dlZYkxUSmfqwgdy2qpeny0VSNxgk25yCpMg1xZWlIb4+otYZUaSb5MGmQVixycLrarjHQvJhTnnIQnSNoAFhogBna2Uj289sW4UshQwPhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNH8IJ2E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40A12C43394;
	Sun, 18 Feb 2024 17:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708278626;
	bh=Arg5IYgbFZxDNEXGigVOshFsxH86bJXtm8ixxUbMSvk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pNH8IJ2ExjScZGhv1ZeG2zk/9uFCFQ0Gz16zN0Qdv6i9msQS+m1qDT4paAaXdwuU7
	 0kXE5NauXRVqfesWExRLpYubtbXpc0+BeVyonCYjK2ClcQo1Rk9j2pyGEVMEPVTdFe
	 cWxK1xgXtINsxCuHlMZOQSrqEQMhMjOd5l1h+XMgb6CkPfnauEUFNGhhUBTUIcHuzB
	 Ve7EjQ5fFjM8+0XpvzY4EF6IOUFKGYNnQPQ4f35dSRuBCZKmWdQOrV2K5qCUJDc4Pv
	 t0Bx554vYxlJhSBLj/kCp9HPOEaVUPreDrd2UpjPeFiX9v/R3m6eBVHzHQZoz8+diX
	 g6ZtIRvjl64Xw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2413FD8C968;
	Sun, 18 Feb 2024 17:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 iproute2] ifstat: convert sprintf to snprintf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170827862614.25576.18140577673825813285.git-patchwork-notify@kernel.org>
Date: Sun, 18 Feb 2024 17:50:26 +0000
References: <20240214125659.2477-1-dkirjanov@suse.de>
In-Reply-To: <20240214125659.2477-1-dkirjanov@suse.de>
To: Denis Kirjanov <kirjanov@gmail.com>
Cc: stephen@networkplumber.org, netdev@vger.kernel.org, dkirjanov@suse.de

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed, 14 Feb 2024 07:56:59 -0500 you wrote:
> Use snprintf to print only valid data
> 
> v2: adjust formatting
> v3: fix the issue with a buffer length
> 
> Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
> 
> [...]

Here is the summary with links:
  - [v3,iproute2] ifstat: convert sprintf to snprintf
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=d2f1c3c9a8a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



