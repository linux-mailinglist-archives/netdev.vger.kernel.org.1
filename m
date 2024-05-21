Return-Path: <netdev+bounces-97333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DE28CADA4
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 13:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D04128312B
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 11:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BB774404;
	Tue, 21 May 2024 11:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAT5eBH0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55DE763F1
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 11:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716292228; cv=none; b=h9/c+azWSxSTQ0s/OTx0eByCSihDrs2u9m1AVeWQuYYdJFjx8r6N0PCBJvOWcG6r6nhkjGZKphTpYY2fyhe7wNmXWbIvbArzJzauaby6VRAH1cuTa3xwCGb8rPvwevMTyDPl7WmuLgZkbAK5o1ix9jvEwLJ/wBufK21EWTeGkCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716292228; c=relaxed/simple;
	bh=c3hMXERiqI4LlSBAOoZGQWiiM4vCYcA3natUvqE+E4A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ry5Y/vxvTA+BKId6tWRzIqklFuUJCnjKdREj47U/ZYneg0JywisqBtsZBKnwcoKyPC0xVdXqzRpDddzrP085Y4F5OuwBTmVdrnCHGzDDFEViwnx/enohWPcvFxlMU2iSaX8NsX04EN0oWDguOw6dlv1Qo1vT3prysOECbqynY18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAT5eBH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CF5FC32789;
	Tue, 21 May 2024 11:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716292228;
	bh=c3hMXERiqI4LlSBAOoZGQWiiM4vCYcA3natUvqE+E4A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EAT5eBH0KspsNd5lDx86oQ5jY1zACb95t+tkWdd68xrBEeyx1vwgSppJwWOBu7HXR
	 uKMYbFfv/MdEfhRwH0fCmqDTkqPmmGuar7Jr20ObPfN838jWV7E0IBEoqQUfGSDE4V
	 hNkk3YBmuParAm7zggUhinUUG75G5qs5Zp/Wg4/HsP1OqDUpRSxx+Is9sg9jrxLSrz
	 H5PBZu+HRf+CxcHGbAg0mFWnwMiRxy29SdPoehMFkL1G7NdcWSaUj0uorvGHGA7+HU
	 1Wb8ugBSrJAlwrMwymegMcCKH6oG8zxUwV563nrCmU0ifwtDKaxZKtw0tBFBUeaTU9
	 OEriSwitgUOMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6E060C54BD4;
	Tue, 21 May 2024 11:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net 0/2] af_unix: Fix GC and improve selftest
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171629222844.9323.10296602270935017581.git-patchwork-notify@kernel.org>
Date: Tue, 21 May 2024 11:50:28 +0000
References: <20240517093138.1436323-1-mhal@rbox.co>
In-Reply-To: <20240517093138.1436323-1-mhal@rbox.co>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kuniyu@amazon.com, shuah@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 17 May 2024 11:27:00 +0200 you wrote:
> Series deals with AF_UNIX garbage collector mishandling some in-flight
> graph cycles. Embryos carrying OOB packets with SCM_RIGHTS cause issues.
> 
> Patch 1/2 fixes the memory leak.
> Patch 2/2 tweaks the selftest for a better OOB coverage.
> 
> v3:
>   - Patch 1/2: correct the commit message (Kuniyuki)
> 
> [...]

Here is the summary with links:
  - [v3,net,1/2] af_unix: Fix garbage collection of embryos carrying OOB with SCM_RIGHTS
    https://git.kernel.org/netdev/net/c/041933a1ec7b
  - [v3,net,2/2] selftest: af_unix: Make SCM_RIGHTS into OOB data.
    https://git.kernel.org/netdev/net/c/e060e433e512

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



