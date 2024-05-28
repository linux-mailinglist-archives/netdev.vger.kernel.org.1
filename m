Return-Path: <netdev+bounces-98360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB898D10DC
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 02:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBAF8B2139F
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 00:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B6C79D0;
	Tue, 28 May 2024 00:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLd/JMXp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409527E6;
	Tue, 28 May 2024 00:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716855631; cv=none; b=l7rU4iJimeJY4sz81goHsGw37Lq22LU1imrl6F4AoLz9vwYMPkKwVQr3+KhlV/VW/v1stDp/MsTIIFwORHhNKtT+HxxISQmqTOHgYTGUkLlNOxtNWoIYq10uBnJPNOQ0vtTTKD7nq3SJlaM0C2sBn3t+gOyEDxMohTmXWoa+3xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716855631; c=relaxed/simple;
	bh=KnIP48er4l1+WXnJ9sQb8xUdlECD0RlI5ZTst68GyBs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gLrklFTl49HH4KtSBxAj6jQiNcHL3HmZ1sU0cZ6z9IGl5bmw4QGSnRvzV2E9J+etdvPgmv1n7aMjGaPfZ3LKbV7eUvpn/BKh2lZSGYSZsNXPKZ4J53wOz5Gl6TH0EFxnURLQurs5mH1RjiEsDfHvsCggTdT7Jb23NmJQgVWU32c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLd/JMXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E46F5C4AF0C;
	Tue, 28 May 2024 00:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716855630;
	bh=KnIP48er4l1+WXnJ9sQb8xUdlECD0RlI5ZTst68GyBs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TLd/JMXpFnsmAbuDwjCfpNMxn1M337UGwiABoXOvVRtLo8JfIM1wpIfNwpeOMCnAE
	 B9eIw4xIyQLzbfOrjk2esJ/daq21pE2QY2v70LDi0NzOTk8l/j9g3LeJup6ypTg0li
	 7bGEz4zXrTkyyQmk3pp+MlgQlC9lEShMsm7DE56OCb/SK1WO8Bq5lLKtF7mtAYh2Xd
	 EfstbYN+sqJePh46NFLVtdLmRAlQtoWflaQM3VTfeqk0cRz4ykukQZtRwoa03JoubA
	 vVviHVY2oum4qsSWv9TxhTonEBdIcGxapCE3zQxS9ImjhX3q2B+hvOscnXre/G6Nr5
	 8Zek1wDfq+UTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0EB6D40198;
	Tue, 28 May 2024 00:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] page_pool: fix &page_pool_params kdoc issues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171685563085.6024.16419471197715039412.git-patchwork-notify@kernel.org>
Date: Tue, 28 May 2024 00:20:30 +0000
References: <20240524112859.2757403-1-aleksander.lobakin@intel.com>
In-Reply-To: <20240524112859.2757403-1-aleksander.lobakin@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 24 May 2024 13:28:59 +0200 you wrote:
> After the tagged commit, @netdev got documented twice and the kdoc
> script didn't notice that. Remove the second description added later
> and move the initial one according to the field position.
> 
> After merging commit 5f8e4007c10d ("kernel-doc: fix
> struct_group_tagged() parsing"), kdoc requires to describe struct
> groups as well. &page_pool_params has 2 struct groups which
> generated new warnings, describe them to resolve this.
> 
> [...]

Here is the summary with links:
  - [net] page_pool: fix &page_pool_params kdoc issues
    https://git.kernel.org/netdev/net/c/266aa3b4812e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



