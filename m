Return-Path: <netdev+bounces-112764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B0D93B0CD
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 14:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0771C22B7B
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 12:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE1B156871;
	Wed, 24 Jul 2024 12:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEK128VU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DB179F0;
	Wed, 24 Jul 2024 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721822432; cv=none; b=gH0Cs2HpSdBZkZ0szRDJLxEd1/UzqHBLf2tVUCEXlqzxwZAKROBhbWqQfK+oXPsSo7HDRmJ76zmX/SH9Bx6nU5fUKzD4MIjZJzmgK3G9PQJc8uAJgCw9iJX0bjfR5lRFloFKJFLxSf88VDFvP8fplOm8LCEcv1Xpf/qd8wRKU0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721822432; c=relaxed/simple;
	bh=PBkYQ8eBLHEy0auwrIBbL/xSA8m++mxeWNt2CaKYkJw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pEpKH0lyEJR7iZbKknfgXI1/0TMul4qAT5W6hAew6T7DERIPPBA4OIi4sNd0TxCVOQddTNBwTEFb8YElx1N46JQOMs70NVk8Dz9nyUMpeKd+zlH/nyCU2kiefF+Nc1LaH8SiCLi6tDa/D547S63W2IIGxlwgJhlL36B+noDJrNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEK128VU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 563B4C4AF0C;
	Wed, 24 Jul 2024 12:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721822430;
	bh=PBkYQ8eBLHEy0auwrIBbL/xSA8m++mxeWNt2CaKYkJw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DEK128VUL+debVTWMHHmxyDRc1DANLR8TiMfUIUP0fTfaFwOFN0WSqnWf41V5X0Ez
	 nYMjlx1dVGMesKPX+xYHv+FUiiAa+KHTeANrZaPRDvccKze3H5A62pstrYRfCqHTzu
	 2vpN/ZHSPAQuCyucgetx20ffvMMowHvQeHa9x5nDB6FJmEycSR/QYbt9691k6PvF9f
	 3AHd9phIFnpgWpcaJOHXGGxIYtjow/v+SkDmKlljp8/GQ6qGrzBDfdt3lbJMQ7Xg9z
	 YYxVaMLvafw+TLlMUQg4iPC1YgUoKS3fsw3K7FiHRhF7M32Alyr6OPve4Q7dY/TsUm
	 zcMOGh5GhBu1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3E3D5C433E9;
	Wed, 24 Jul 2024 12:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: forwarding: skip if kernel not support setting
 bridge fdb learning limit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172182243024.24813.9530655978630105526.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jul 2024 12:00:30 +0000
References: <20240723082252.2703100-1-liuhangbin@gmail.com>
In-Reply-To: <20240723082252.2703100-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, razor@blackwall.org,
 jnixdorf-oss@avm.de, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 23 Jul 2024 16:22:52 +0800 you wrote:
> If the testing kernel doesn't support setting fdb_max_learned or show
> fdb_n_learned, just skip it. Or we will get errors like
> 
> ./bridge_fdb_learning_limit.sh: line 218: [: null: integer expression expected
> ./bridge_fdb_learning_limit.sh: line 225: [: null: integer expression expected
> 
> Fixes: 6f84090333bb ("selftests: forwarding: bridge_fdb_learning_limit: Add a new selftest")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] selftests: forwarding: skip if kernel not support setting bridge fdb learning limit
    https://git.kernel.org/netdev/net/c/863ff546fb62

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



