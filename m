Return-Path: <netdev+bounces-43992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 167867D5C29
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 22:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B9EBB210E4
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 20:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8DC3E476;
	Tue, 24 Oct 2023 20:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUCaVRR2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04183DFE5
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 20:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92A48C433C9;
	Tue, 24 Oct 2023 20:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698178227;
	bh=myYOnY22ZvkcMKy2skYZ67MAG6kNS+2M4N313N7XwBs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EUCaVRR2OZ4Zg1z9LnSB4/IMjQu5wZq+n57VbMH7yxWQivjDcEPc+50HmraK4unF7
	 X6b27JLbNwYasv27lKwspb6qMF2xWZDaO7nasTwqxRVP4BAVDUqoVPA7dK4WUyfy/Z
	 nlNmFmov0L0ozeXwn9vafiea4CFqXrqvzDPhSVo7pGHDOtHP4P5UUuga8i6PrNwXLE
	 4erwi46P3BtqH3JYS3NlV4ZCDajCw0nTarLrLaWA9QlZjkiCllcvc4p5FrVhZ1NNpd
	 x2G6F9O8xdNULyCmA8k57jAEa40aLraNBtsjLYlBRR0SOpmsQ0iA+3pIqevEYfOqNt
	 XuE2fnKMNAKuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 74F28C595C3;
	Tue, 24 Oct 2023 20:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/6] net: deduplicate netdev name allocation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169817822747.29692.6994871674872355452.git-patchwork-notify@kernel.org>
Date: Tue, 24 Oct 2023 20:10:27 +0000
References: <20231023152346.3639749-1-kuba@kernel.org>
In-Reply-To: <20231023152346.3639749-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, johannes.berg@intel.com, mpe@ellerman.id.au, j@w1.fi,
 jiri@resnulli.us

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Oct 2023 08:23:40 -0700 you wrote:
> After recent fixes we have even more duplicated code in netdev name
> allocation helpers. There are two complications in this code.
> First, __dev_alloc_name() clobbers its output arg even if allocation
> fails, forcing callers to do extra copies. Second as our experience in
> commit 55a5ec9b7710 ("Revert "net: core: dev_get_valid_name is now the same as dev_alloc_name_ns"") and
> commit 029b6d140550 ("Revert "net: core: maybe return -EEXIST in __dev_alloc_name"")
> taught us, user space is very sensitive to the exact error codes.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/6] net: don't use input buffer of __dev_alloc_name() as a scratch space
    https://git.kernel.org/netdev/net-next/c/bd07063dd11f
  - [net-next,v2,2/6] net: make dev_alloc_name() call dev_prep_valid_name()
    https://git.kernel.org/netdev/net-next/c/556c755a4d81
  - [net-next,v2,3/6] net: reduce indentation of __dev_alloc_name()
    https://git.kernel.org/netdev/net-next/c/9a810468126c
  - [net-next,v2,4/6] net: trust the bitmap in __dev_alloc_name()
    https://git.kernel.org/netdev/net-next/c/7ad17b04dc7b
  - [net-next,v2,5/6] net: remove dev_valid_name() check from __dev_alloc_name()
    https://git.kernel.org/netdev/net-next/c/70e1b14c1bcb
  - [net-next,v2,6/6] net: remove else after return in dev_prep_valid_name()
    https://git.kernel.org/netdev/net-next/c/ce4cfa2318af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



