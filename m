Return-Path: <netdev+bounces-193835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEDBAC5F9B
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 04:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D11E31BC56B5
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 02:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FDC1E8337;
	Wed, 28 May 2025 02:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzjmqezS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BBC1E8326
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 02:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748399419; cv=none; b=fS4ezJgDBI1OyLsVgyNTAhdpEoZwd/RoMPV+ku59wtyBHaW/QG27OXV7jsxBJB9EmCHbpXqL6ZOng0yBnfJ+DiCML6zCbyPZmsoW5ZYAcVXowei4c+Tb8LmMWOA8NlP0UNSYOCrS0jpbfzxXhulmwE21XGmqy5agXNKvQkpqZNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748399419; c=relaxed/simple;
	bh=O8HN9nO2jfwiqu7gBQqP9xTYKsa18Ye/ezfqOBxDZiw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nPOsEd6fsNkdxrQAK0Ynz9r1m2jqh9/RvsSgUyFXm4q14viJHZDU6ULBOxQMYFVl6jy5s6BiHsy9xUbAwmAC0KCIBThjFHRjFo5A5YS/hwlmxphse0OxEHRCkeQzz+ai2ArDdK54Tr/IKJ9IIeRnYOPR0pKTkI9F/XUEonDV9d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzjmqezS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2FE1C4CEE9;
	Wed, 28 May 2025 02:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748399418;
	bh=O8HN9nO2jfwiqu7gBQqP9xTYKsa18Ye/ezfqOBxDZiw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EzjmqezSUJtL2oYp5S3+eq7rcyvLIMnLI1huZOsEUC+IF5vDJUU1YCyMuD45zC8aX
	 Yvg/F6Xcms/j/mgZHseit3TdKakEylwcAtCjFIqBmHwQ8V6/UErFyrYScxvNOYYd9S
	 Mg6Dd+1jyyrDUgB3yvr1uM23Jf5+hXo8ZZyHPKp+k6RgmWW6jNnju/2vGsnhVjF2M+
	 2X/EWI9ODIsfjQPpZJXm2087gz5YyqYE41K+DuAYMoFzoZgVLiHC1mDzZ5OP0MVo5e
	 nOuhj5QVO03W6KFngdpmhrgW1tJzYCwN2qmrQ9XmYTQjjkRc5M8j7EwIRDGzA5LbTr
	 7ZZHY3wNr+2ag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DD73822D1A;
	Wed, 28 May 2025 02:30:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] selftests: netfilter: nft_queue.sh: include file
 transfer duration in log message
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174839945274.1866481.12543091323838837455.git-patchwork-notify@kernel.org>
Date: Wed, 28 May 2025 02:30:52 +0000
References: <20250523121700.20011-1-fw@strlen.de>
In-Reply-To: <20250523121700.20011-1-fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 May 2025 14:16:57 +0200 you wrote:
> Paolo Abeni says:
>  Recently the nipa CI infra went through some tuning, and the mentioned
>  self-test now often fails.
> 
> The failing test is the sctp+nfqueue one, where the file transfer takes
> too long and hits the timeout (1 minute).
> 
> [...]

Here is the summary with links:
  - [net-next,v2] selftests: netfilter: nft_queue.sh: include file transfer duration in log message
    https://git.kernel.org/netdev/net-next/c/429d410bf9ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



