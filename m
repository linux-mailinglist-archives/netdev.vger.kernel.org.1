Return-Path: <netdev+bounces-94000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AF18BDDFA
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 11:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3198C1F243F7
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 09:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7652314D6F1;
	Tue,  7 May 2024 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGT+Nvke"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEB814D451;
	Tue,  7 May 2024 09:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715073629; cv=none; b=SWN0FPw30rXS9Q3EFPqWu2OwSU9Yfx4KYxZWPVw7kFQZpND4h3LDlJxbtvEWrTrApGYLFnzc6rt3ZOSlcEn2tsZzjOXVWtYNvikg6PcM2prLXD5bKoVfHgXzn59z5KmuC30H1NiiLqXDlf9ObCCsseKFUR7nrCK+NKZ6/JUkFoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715073629; c=relaxed/simple;
	bh=uOZNtUaSA1NitsAwAQwP0IwamEmkrJ7p/dRtfpW0oxU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VxU7fKrOgwcYOFKh5WjU8k7ZyDqcQTLjxV2eQVNUvCVeJb2RrDjPMlTQXEaQBc6AZrE3hJKpbt0TXe/HrVuXQgaj1eUjxNlzxWHRRHdBzetktxdmhPEnLHg56ssYK6qReOAPCXsxIDNEJVlltIV4cPTwDw9pQZ9j/lydQAEgyVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGT+Nvke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C72DFC4AF66;
	Tue,  7 May 2024 09:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715073628;
	bh=uOZNtUaSA1NitsAwAQwP0IwamEmkrJ7p/dRtfpW0oxU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bGT+NvkeqUqQom3lqasvsjqjWnqfi3h43vie3FeumHw1qxVGJbbja1ioFoeyPkt9a
	 wTBcyKP6yY/+1h5MD6EGX3EyeHrwpfYUCrpfnNyfTkZK7LDD7jK5AGtNQm1DNZfZtT
	 Tt7kyLToerrWg0x2GdQUqvV51XVvhOcokWIgQ7Oh47f1bn0zyFO1Api6DAFjue06XU
	 +h57xiIXfRvxUxa+YGMdG2mXXDnDFmmg3HdRskhypMlMFn0MjrA82G+2HTnI79jEBu
	 yQ7Xm5E5c3bVettgZjin5gN8dA7HzlJ9zA4KJ1ztBBhpbMl70XCOM17w/o9k3UV4fW
	 yPDx36kwSwwBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9E1AC43332;
	Tue,  7 May 2024 09:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: qede: don't restrict error codes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171507362875.12123.6973193327747912095.git-patchwork-notify@kernel.org>
Date: Tue, 07 May 2024 09:20:28 +0000
References: <20240503105505.839342-1-ast@fiberby.net>
In-Reply-To: <20240503105505.839342-1-ast@fiberby.net>
To: =?utf-8?b?QXNiasO4cm4gU2xvdGggVMO4bm5lc2VuIDxhc3RAZmliZXJieS5uZXQ+?=@codeaurora.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, manishc@marvell.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  3 May 2024 10:55:00 +0000 you wrote:
> This series fixes the qede driver, so that when a helper function fails,
> then the callee should return the returned error code, instead just
> assuming that the error is eg. -EINVAL.
> 
> The patches in this series, reduces the change of future bugs, so new
> error codes can be returned from the helpers, without having to update
> the call sites.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net: qede: use return from qede_parse_actions() for flow_spec
    https://git.kernel.org/netdev/net-next/c/146817ec3209
  - [net-next,2/3] net: qede: use return from qede_flow_spec_validate_unused()
    https://git.kernel.org/netdev/net-next/c/e5ed2f0349bf
  - [net-next,3/3] net: qede: use return from qede_flow_parse_ports()
    https://git.kernel.org/netdev/net-next/c/c0c66eba6322

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



