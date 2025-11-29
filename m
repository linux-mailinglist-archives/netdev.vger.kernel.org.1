Return-Path: <netdev+bounces-242658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4A1C93799
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 04:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 639B94E04F0
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 03:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE91819EED3;
	Sat, 29 Nov 2025 03:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKsXyq7+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986C136D517
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 03:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764388484; cv=none; b=HrgFPKiqVE10P1lPb0/ykmeKEwTNtWuT9SaWvsJvNtfcF2ETc3F9vvNG7oGxmQJHso7aYH4LufMnRtQ4AGZksvwC9/Zsy767ObwQ005cr1PBLIUXJD1BXAS8jSLSd9RUTy6tbx6u9DzjcQHU/bvc0m87N270IqbEG9Gb2Vm1wa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764388484; c=relaxed/simple;
	bh=SaS4iyqXjsoDt2t2BzT525Hi7Zg7FBV+7lSYHcqxhzg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Hziice5LhOhlE95mCPFZYyDd+xrJB91ysJyRVRX4O5PW4HGjckYto8RGA6HjTaepQa3M2uGA3FQFm6jznKQWSPZ4ilmfQpJEMFi96s9ZsmPCPeLHNNm9BKk7QPTignJUkmfmzLaOpQJmJHQFtc3qJiqsIHtX+4k8LR5RLKBd160=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKsXyq7+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F41C4CEF7;
	Sat, 29 Nov 2025 03:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764388484;
	bh=SaS4iyqXjsoDt2t2BzT525Hi7Zg7FBV+7lSYHcqxhzg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PKsXyq7++WC4UkFaK4ZxsSbAoAYDUNw2uNQmhgWBOf44vPcyGayF4e80utiRM9S0q
	 e8yi0/QuCMJRAYz1Bq+jcyfB5ButPj7q2ZN820sOpoMcFZbgQobMD875UReAiDTNII
	 7d0xEUk0uZFZkw0zfCw4zmPmS/m0VsnPp9cfIGppO6kWB9DS6mk4PWGOJBBz3kxLpb
	 9a6jJ0SZpceCA7SBoL7XZkEjEcV8GqIARkcsUSEUZnQ8JNegYAU/G3Rwrbs7Ggd1pR
	 UELc1KXm56P3ZMStNnNChsb3KMY/DfMv24KeZ/pvTaUTMqzHNKhCQ74qwcC3hAMu7I
	 ksuw7I7BcCnYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B916380692B;
	Sat, 29 Nov 2025 03:51:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: Remove KMSG_COMPONENT macro
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176438830577.886304.16799607222244419774.git-patchwork-notify@kernel.org>
Date: Sat, 29 Nov 2025 03:51:45 +0000
References: <20251126140705.1944278-1-hca@linux.ibm.com>
In-Reply-To: <20251126140705.1944278-1-hca@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, pablo@netfilter.org,
 kadlec@netfilter.org, fw@strlen.de, alibuda@linux.alibaba.com,
 dust.li@linux.alibaba.com, sidraya@linux.ibm.com, wenjia@linux.ibm.com,
 wintera@linux.ibm.com, twinkler@linux.ibm.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Nov 2025 15:07:05 +0100 you wrote:
> The KMSG_COMPONENT macro is a leftover of the s390 specific "kernel message
> catalog" from 2008 [1] which never made it upstream.
> 
> The macro was added to s390 code to allow for an out-of-tree patch which
> used this to generate unique message ids. Also this out-of-tree patch
> doesn't exist anymore.
> 
> [...]

Here is the summary with links:
  - [net-next] net: Remove KMSG_COMPONENT macro
    https://git.kernel.org/netdev/net-next/c/c940be4c7c75

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



