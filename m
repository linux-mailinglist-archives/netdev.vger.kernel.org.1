Return-Path: <netdev+bounces-186814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D509AA1A8F
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 20:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83EF39C3671
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 18:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24FE254861;
	Tue, 29 Apr 2025 18:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAmsNx82"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CE524E4BF;
	Tue, 29 Apr 2025 18:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745950796; cv=none; b=Az/3rtKdCClFygiYVNmzZVmK1P/ISrk8vGCLNH+AfvcoSJOhFPV4fRL/CdR5D71Qh0/oipe3Lu3rJjMDXi611eLdQSInBLvLPOUx3D3St0LEpacu1up+mnRR79tjLv+VSzTo9gt5oTOOZCIp3k5TdJCLmsXrP3OMV3Va8qSIM8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745950796; c=relaxed/simple;
	bh=3a6w/lSHks9lO8ZwVHvxh7X9aJKafUhqyBOW7U3BCFs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eXkIttJbZLwOSYc9NOBWLFK2WRWRhumCToIkdP4LKH7oZddlm51NU7VBOP9M/yBsfSihvtOvDvTqRG3E0E7+Gk4XbHJvkq9xQ5AwHGd+tmm7Dp9uT4h+Pg6ujffTAXKfNNm8NuxfMT7WQz4rwgOmmXnemNzfFYkfQaF3rbXEPPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAmsNx82; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B64C4CEE3;
	Tue, 29 Apr 2025 18:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745950796;
	bh=3a6w/lSHks9lO8ZwVHvxh7X9aJKafUhqyBOW7U3BCFs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VAmsNx82FDfKH1VBhRLzHH8303uuCC8Oh/6zIwGQPTkEoa7Rnw0miJFoWJLXEJbDq
	 8+qV4or5U/0orZ7L1kUeDpzuH+YZ758lJqi0JYMIvEVrte92cbtpYFy2SsxPWu5Gl0
	 zR3YVeoOKHTcG0WO9AknBl5s1dRII54+N+HpEx/b4nQIRMwsnAnFTfxjpve9aMPjjl
	 UIUmupmmSKmvLiTFYpkXNT8s31SO+IDxreJ52FIe1NApqKtR23BT9Mq6MktiIkqY9D
	 LP5Ihn9oDCAZOC6GsqI98DW6Rq2kc6RjDrkpS+/GjadiFC37PVrH+YM8Ssbqmpf3Ai
	 wYeYyJeSJMDEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD703822D4C;
	Tue, 29 Apr 2025 18:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] pds_core: Allocate pdsc_viftype_defaults copy with
 ARRAY_SIZE()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174595083551.1759531.11864469944201656091.git-patchwork-notify@kernel.org>
Date: Tue, 29 Apr 2025 18:20:35 +0000
References: <20250426060712.work.575-kees@kernel.org>
In-Reply-To: <20250426060712.work.575-kees@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Apr 2025 23:07:13 -0700 you wrote:
> In preparation for making the kmalloc family of allocators type aware,
> we need to make sure that the returned type from the allocation matches
> the type of the variable being assigned. (Before, the allocator would
> always return "void *", which can be implicitly cast to any pointer type.)
> 
> This is allocating a copy of pdsc_viftype_defaults, which is an array of
> struct pdsc_viftype. To correctly return "struct pdsc_viftype *" in the
> future, adjust the allocation to allocating ARRAY_SIZE-many entries. The
> resulting allocation size is the same.
> 
> [...]

Here is the summary with links:
  - pds_core: Allocate pdsc_viftype_defaults copy with ARRAY_SIZE()
    https://git.kernel.org/netdev/net-next/c/2eea791a7554

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



