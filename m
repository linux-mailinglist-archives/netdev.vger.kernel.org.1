Return-Path: <netdev+bounces-38073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C52387B8E08
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 22:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 30FEE281843
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 20:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694DD224FD;
	Wed,  4 Oct 2023 20:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMGKvZpa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EAC22EE9
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 20:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBFB1C433CA;
	Wed,  4 Oct 2023 20:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696451426;
	bh=oh6xitWr++z2BIqUUKyYoq+1pyDthWDaQ3PK0sgNako=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oMGKvZpaBvxQD5YCtn1K/jw3uH/X/6jhyla+2+lhS/thzFy1z3Vi8G/IULw6tvG2t
	 hUEntopqfUzCM3+aPTCZAwiTzrQA7iM8LMHghGXBtdTaKsDXq0YPOKXZegP23kquuO
	 wr2sQvl8dwgBPO6cmvLLBhd5PquqD81YH95HPOOy14dDELpzZGiNo3PDvTLcj55SGr
	 YHN0hoH14q8XYeC8/0GjrCGdIkk/n30j99naw/itrcWe+6il3pXuW1m33F8wCDUDYV
	 38SRCwhm70/AKDGxZIXfau/9EqfKgai87WJ/ybXTO/swyYAMu781SZbh20h6LAKk7m
	 nviI9wY12MDYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F697E632D6;
	Wed,  4 Oct 2023 20:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tipc: fix a potential deadlock on &tx->lock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169645142664.7929.9991674504549336321.git-patchwork-notify@kernel.org>
Date: Wed, 04 Oct 2023 20:30:26 +0000
References: <20230927181414.59928-1-dg573847474@gmail.com>
In-Reply-To: <20230927181414.59928-1-dg573847474@gmail.com>
To: Chengfeng Ye <dg573847474@gmail.com>
Cc: jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 Sep 2023 18:14:14 +0000 you wrote:
> It seems that tipc_crypto_key_revoke() could be be invoked by
> wokequeue tipc_crypto_work_rx() under process context and
> timer/rx callback under softirq context, thus the lock acquisition
> on &tx->lock seems better use spin_lock_bh() to prevent possible
> deadlock.
> 
> This flaw was found by an experimental static analysis tool I am
> developing for irq-related deadlock.
> 
> [...]

Here is the summary with links:
  - tipc: fix a potential deadlock on &tx->lock
    https://git.kernel.org/netdev/net/c/08e50cf07184

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



