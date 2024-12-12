Return-Path: <netdev+bounces-151281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A149EDE11
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 05:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25296282C11
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 04:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74DD154430;
	Thu, 12 Dec 2024 04:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gl3MRJqd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D58257D
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 04:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733976014; cv=none; b=nOjOK/8E6Hw6SBegnHOOWd8ZRdtdMMRanKPjJApqZnMxbHS//q3A9Oclzb6fb9vxkEzlqVeLFXuZ29uG2BFoc8eG1M7YQA7E0yas1tnadZoKzIUlbeMj/4rqHNLl5h6Faz7EGgZXo6nobRP7aiqmzWQXo4HDsO3k7jWwwYpaG44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733976014; c=relaxed/simple;
	bh=TM4ibCY2adGQFahwt8dPfjotAAX5kBV83l3yzH5CMLk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O4GskvvBmKfA5FOEIf3D6+f6Z9PfXqomHn2ZwmwqCPlWug6VNkMoICHVtlzx++gSW3syAGiXq9nAlmnKj/HhxtGyUEf7Czj3LsAg6Z4i0Zo1bk9JC2K0LKbFTSP1x46tfjvu+X+0/5pBgSDNW0aySXIVT/faMD6P3fFz2Yla3rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gl3MRJqd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23278C4CED1;
	Thu, 12 Dec 2024 04:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733976014;
	bh=TM4ibCY2adGQFahwt8dPfjotAAX5kBV83l3yzH5CMLk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Gl3MRJqdk8AhJJi4m1qjvFOld8f0iWErZ73OfYQNHn1dEgFeFPgfMKy0zBB9APG/6
	 PvDUM6BXmWb4ZhVBb3WxCIOw5G0hHR4DLuyL0ethXxuv8nQoGSPJ3AOyAyKxq7YtA7
	 VY4yGciQAhVmhiIvCpYcI5xrlpHPeULS5NHD4QIrwRpVInwWfxGPmyntXpPKu750us
	 dLDsO3RCNYSp2FBUZhxs76H7cGLGAc/cE8Qbn7q8GrzVgYfi9oH/XeC3+2FZYv+yO9
	 h/COSMHkzfcs/tk0F4iZIhEVVp1npvrp4P+TtR01hzl0n0wdC8CRqYh9FRTSRhcCnF
	 bLUi/V1hTszvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 72145380A959;
	Thu, 12 Dec 2024 04:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: Add ethtool.h to NETWORKING [GENERAL]
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173397603031.1841810.15014108849651285799.git-patchwork-notify@kernel.org>
Date: Thu, 12 Dec 2024 04:00:30 +0000
References: <20241210-mnt-ethtool-h-v1-1-2a40b567939d@kernel.org>
In-Reply-To: <20241210-mnt-ethtool-h-v1-1-2a40b567939d@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mkubecek@suse.cz, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Dec 2024 13:47:44 +0000 you wrote:
> This is part of an effort to assign a section in MAINTAINERS to header
> files related to Networking. In this case the files named ethool.h.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [net] MAINTAINERS: Add ethtool.h to NETWORKING [GENERAL]
    https://git.kernel.org/netdev/net/c/15bfb14727bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



