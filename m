Return-Path: <netdev+bounces-81018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F7A88587A
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 12:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 565F21F221BA
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 11:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5322158ADD;
	Thu, 21 Mar 2024 11:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npHQV+PW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3013058ACE
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711021228; cv=none; b=h5KMaL73QRYUeSqM40rA8B7FWxKt7rloS1aziWLxbH/OxN+hdy7d64iGg0q9ynF9db2mx+j9nUnQRu6/71lPCLZXt1/MqRi+qbGXBjxTwAm+2JJ7DIqqYhvEz8OEh1jNLfd2JOMmiEtgQvkfNcnM76U4uKECWqZn+SEwUBVz1Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711021228; c=relaxed/simple;
	bh=KuHKjtLTNKWbZrynnM66MzNcYKRg5e+bFn4oGPLz4/w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ArebKELUsumAFZJmZ0eTVt3cbChJA4DhtWp2MdaNkSXKfKmv4Llb6dqjCko+hEmewrIFs53iZ0nzERDAjtC1xT6OdbXpF3IAcVRPBhSgZSRFbiEhluxZqjg+ThCSFT3uM71Ma7urONX3Jpz1wcLYeNBZfFMoXxyooNrg+AIHyd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npHQV+PW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B67D4C43394;
	Thu, 21 Mar 2024 11:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711021227;
	bh=KuHKjtLTNKWbZrynnM66MzNcYKRg5e+bFn4oGPLz4/w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=npHQV+PWwpuKhPIQcmJJTxVNP8zIKkxTc2qif5HfJMrukjybWLhNYSUfwgnzi4yNW
	 fjW6P3GEhCvxWWtpIiStfFFyYmZcK1HatAI5s7+JB83YAyPeRtCvmi10mGY6oRBNQq
	 uQahOjuIy5RBPA3dqyaOvnZvzFVPKNDPr7+gfFSNZIa+Ix5rIXjZQXKO8FJOBl80qX
	 D3LjZlbO2ka0x/9hAh3rFcbb0FbznJ1OWc3MVN4PGpXKDJGIsTck+wt8S69u+ZWi6t
	 J4Rdax2Z0j7wj2VdJZH0s22F3j1K6MM+I2qpreNqb5Tw7zio4fHSHuxof5Sm7mNwN0
	 ni9LQhObqKNtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AB5CDD982E3;
	Thu, 21 Mar 2024 11:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: forwarding: Fix ping failure due to short
 timeout
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171102122769.14460.3006004140693836919.git-patchwork-notify@kernel.org>
Date: Thu, 21 Mar 2024 11:40:27 +0000
References: <20240320065717.4145325-1-idosch@nvidia.com>
In-Reply-To: <20240320065717.4145325-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, amcohen@nvidia.com, petrm@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 20 Mar 2024 08:57:17 +0200 you wrote:
> The tests send 100 pings in 0.1 second intervals and force a timeout of
> 11 seconds, which is borderline (especially on debug kernels), resulting
> in random failures in netdev CI [1].
> 
> Fix by increasing the timeout to 20 seconds. It should not prolong the
> test unless something is wrong, in which case the test will rightfully
> fail.
> 
> [...]

Here is the summary with links:
  - [net] selftests: forwarding: Fix ping failure due to short timeout
    https://git.kernel.org/netdev/net/c/e4137851d486

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



