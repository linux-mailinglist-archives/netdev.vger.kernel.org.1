Return-Path: <netdev+bounces-93154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 199418BA4F4
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 03:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6ADA2847FD
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 01:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860FDF4E2;
	Fri,  3 May 2024 01:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AunAIK2Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620E6CA7D
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 01:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714700429; cv=none; b=b64QJJIeq3T7+pdFALaekcJ6LkweNWTLCTt2EOMElzuc2AemUMo2SoI0s0xnpfs/v9k6aXDLRWWDn+m66ont4iWlbMjDEDMqm9jVXl6hHwp9fXfLduWE17aMJ4sEAyfa00FtJt+zBYldzbPe9IqbyqBorJKYjPt5hzYfpYT1SJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714700429; c=relaxed/simple;
	bh=qi82nY3X6Z2B6UAdNKNr8Yenqw6ox/QtLkt4GnbAgkY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G0pZYVzZ1OoIFSvgpTwp3yI23k2ow1TWtu8xzSjZ76HYE0lum4EaYywXg20GZ9IMSpC5x7vhklQaLxyYJ3rEPQOE/CcLAGsOW4KgvvfVkFdIkSI6DLkXq8AJLf/ClSS1MQNCwGlRH7AY3QTzahvvEENlK2IFIKeOCXRhA4cfwsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AunAIK2Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E36EBC32789;
	Fri,  3 May 2024 01:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714700428;
	bh=qi82nY3X6Z2B6UAdNKNr8Yenqw6ox/QtLkt4GnbAgkY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AunAIK2YrIdooT7gl4uHciRDbiZgYvTdOC7HN1P84PKZmfullrSeooz312njqon+/
	 TYghJULY/LvofFERQbM7Dw05MRlur3kILPMpEEHnXi5lTFcd969W7J4bMuAy7FYJ+n
	 Z6or/OvTxBH7pGLGT4LSwdP7dKhvEzfoPAUgBMGEYLvljJzuMxWzU1lDuwQpn114/z
	 azFeJSv3kcSNtajmwsbhMPilQ1gPEUxd8F0Qwxcs9OBzclh+zJWfhffIqg4nT9v/kv
	 E4edfsydOspH7hTpf1e7dJQkXNd5+brMn1RdJmaq9b08gJWtYqESzFc6BeiI8aPM1Z
	 PegpebRjnyUoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D281FC43335;
	Fri,  3 May 2024 01:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: net: py: check process exit code in bkg()
 and background cmd()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171470042885.13840.9993944325508444516.git-patchwork-notify@kernel.org>
Date: Fri, 03 May 2024 01:40:28 +0000
References: <20240502025325.1924923-1-kuba@kernel.org>
In-Reply-To: <20240502025325.1924923-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  1 May 2024 19:53:25 -0700 you wrote:
> We're a bit too loose with error checking for background
> processes. cmd() completely ignores the fail argument
> passed to the constructor if background is True.
> Default to checking for errors if process is not terminated
> explicitly. Caller can override with True / False.
> 
> For bkg() the processing step is called magically by __exit__
> so record the value passed in the constructor.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: net: py: check process exit code in bkg() and background cmd()
    https://git.kernel.org/netdev/net-next/c/e1bb5e65de83

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



