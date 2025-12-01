Return-Path: <netdev+bounces-243078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F6DC99488
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 23:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2E7BB3460E9
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 22:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AAF23EA9D;
	Mon,  1 Dec 2025 22:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDYna9Sy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4A542AB7
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 22:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764626590; cv=none; b=kK2I3Csj3J/6uxCUJyv03NNaKQs7HuCGj06yXRzAwwyngZz90Qjp627N7fTNCJgTTuv20kvsVhNhZhVR1Nz+f32IWDwWXT0zsfocp5xZh9De3uvQcZ0qFjtsYsml+iN1aRGB+LjLBFb3RY7dh7zb6KIycHUOsjwaOc1eExEDhsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764626590; c=relaxed/simple;
	bh=r335AtzmAzLbb7RMqS7LpTqNthOpvn5q8H/gveoXp7o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sd6wzibo/E1A8cWE/gawa1E9F+eLDAJ4Zj21k63xbPSAY/2y9yPGsnKidfoJBPTUGZq5ZA+pwIWJV7lu4eTAxbMHkE0Zy10Wc4NNp6WLFbdD3R2EJzXXPIQUz2BevT/Ugj7NI4QR1zK1vwV0jtNF5vGJnWiiHoj1aQuQsZOli6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDYna9Sy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29A6C4CEF1;
	Mon,  1 Dec 2025 22:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764626588;
	bh=r335AtzmAzLbb7RMqS7LpTqNthOpvn5q8H/gveoXp7o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cDYna9SyLfhHVhVastLuQeVZTqnquakkAY88v7FQk66kb2Ae8pQeqR0EOfkZxmGFx
	 rnyL8iGImzaW+vXB8aVlFoZC5Wvkkz1mKVayzHWsAwUplslEyP0g4YIWIrJ1df0sCN
	 1fa2Ck+pQ+5XxWKpWhwxHANZDdi74HPHfpaeqiA5zcQqfw5fDEXZ/Ns1xK0qW871c0
	 LtTNyHLcWT+3vD4GhOIgswYQjQfG2mHwBrD5xKkeINC9e4bYwI7G7+CxlyRKnrl0tN
	 6MYTjtxDl37/MyP+wFd54Pwjhy3JW4w0t1oU9101MSM3vB9bmjZc4JcsV7cmffC0E9
	 zqxq+iU4YHFsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2AAC381196A;
	Mon,  1 Dec 2025 22:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: mctp: test: move TX packetqueue from dst
 to dev
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176462640879.2561615.15924092267906413026.git-patchwork-notify@kernel.org>
Date: Mon, 01 Dec 2025 22:00:08 +0000
References: 
 <20251126-dev-mctp-test-tx-queue-v2-1-4e5bbd1d6c57@codeconstruct.com.au>
In-Reply-To: 
 <20251126-dev-mctp-test-tx-queue-v2-1-4e5bbd1d6c57@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: matt@codeconstruct.com.au, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Nov 2025 16:48:54 +0800 you wrote:
> To capture TX packets during a test, we are currently intercepting the
> dst->output with an implementation that adds the transmitted packet to
> a skb queue attached to the test-specific mock dst. The netdev itself is
> not involved in the test TX path.
> 
> Instead, we can just use our test device to stash TXed packets for later
> inspection by the test. This means we can include the actual
> mctp_dst_output() implementation in the test (by setting dst.output in
> the test case), and don't need to be creating fake dst objects, or their
> corresponding skb queues.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: mctp: test: move TX packetqueue from dst to dev
    https://git.kernel.org/netdev/net-next/c/6ab578739a4c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



