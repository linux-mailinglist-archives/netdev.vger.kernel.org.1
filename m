Return-Path: <netdev+bounces-94772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 443298C09A7
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 04:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F033E281BFB
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 02:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D8C13C3D0;
	Thu,  9 May 2024 02:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2CVm1rj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901F010A11
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 02:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715220632; cv=none; b=Q0gKUmK7wD7bfFX6guGwX2GAInAkpigsR8734nJ9hOWcsNqC74g88yizTLN5mxrbjVFKTSMAAAKNTWOnMRrDL7mLUGwmiibmtPtiqvKSWhNBFvuAY6K/T8LFxGUcuIJ2hawGKvYjOAN4MZA//+YfxWDJt8RJg/+XrhLXe4cKcq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715220632; c=relaxed/simple;
	bh=fNtUqcJP82OOE7VD5T5qwuOnhtDXECX86CG4wPkmeeE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pBC4U88FAcHzrPIZGZTQNF0rxU4w3EUMG66LgpFwqtEX6aGvDhMdOiThpTF8eB809voKKcqPYRSB2R3zfL16FK9kXGer/zPrO9p+2A0kpU+yPNOVgsGAsNVTuxbEm//xq8+ew/lucAv6tscKC60gG9DDHvntYw3ZvDDvUpbR1kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2CVm1rj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01812C2BD11;
	Thu,  9 May 2024 02:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715220631;
	bh=fNtUqcJP82OOE7VD5T5qwuOnhtDXECX86CG4wPkmeeE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E2CVm1rjKqAYJVIvyZXiFFTbq8yFVWYkgfdDFnry9FtgW+E01kuoABN9T48zLs7n1
	 c0rR1N426ZSADR6ykF1XZmCajoDEexPWUjEOwWYNBIYS0uFl2cyX6m7sm6D63i+Fdx
	 h+0sQoSZ/Z+Lf91Fd+RV7qg7J7OV4krYpzMt4jKXJDB0OXl6K/xNtj3iRLVYQs7NyA
	 V2MpEVdptOtgffZ4ua53muyB4O+o5Xa1tsxVBhgVCKtGwa0vKN6qVrsTFe55VQAsSp
	 uhoaserNusKiHHjxAJ9RG+QnB/uz41xTfZeyJiT80EnuYy9jJ9JF5ZbZpvyUgu27/6
	 rKx4Cq8ukbJwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E1190C43331;
	Thu,  9 May 2024 02:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/2] netdevsim: add NAPI support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171522063091.5483.14420344395151664962.git-patchwork-notify@kernel.org>
Date: Thu, 09 May 2024 02:10:30 +0000
References: <20240507163228.2066817-1-dw@davidwei.uk>
In-Reply-To: <20240507163228.2066817-1-dw@davidwei.uk>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  7 May 2024 09:32:26 -0700 you wrote:
> Add NAPI support to netdevsim and register its Rx queues with NAPI
> instances. Then add a selftest using the new netdev Python selftest
> infra to exercise the existing Netdev Netlink API, specifically the
> queue-get API.
> 
> This expands test coverage and further fleshes out netdevsim as a test
> device. It's still my goal to make it useful for testing things like
> flow steering and ZC Rx.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/2] netdevsim: add NAPI support
    https://git.kernel.org/netdev/net-next/c/3762ec05a9fb
  - [net-next,v5,2/2] net: selftest: add test for netdev netlink queue-get API
    https://git.kernel.org/netdev/net-next/c/1cf270424218

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



