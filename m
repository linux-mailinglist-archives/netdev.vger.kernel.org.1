Return-Path: <netdev+bounces-155825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6206A03F1E
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 13:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 516A67A1DBA
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 12:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567601EF0B9;
	Tue,  7 Jan 2025 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8tEyHr0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4461EF0B1
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 12:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736253013; cv=none; b=C+63ynWf9ccY9OeDjPN8AHGUQeoPIxhFvVbdtv+eXW7kRlJruYnAjsjLLwMTga0VnFFhqLtDMALbLdk6McwRSGE9yp8gmLFqyNweaeF+mn8sH5VntDLvHyqDu6mkjvg7H/ZXd4fOSEofocPmpP1AEwZsrodmDIcGunJo9iFZEZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736253013; c=relaxed/simple;
	bh=SbiW47PK2VdDldJSNiTyXXjompnyG9UpusszDUoRMfQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TL9CdzceYtIIMsInBUbvvjaPwvgQxsq0+JwLh+xh6/q9yz90HmanyMWPZGNpyhZdxpEoHM0B+qC6cuyuTdVRwou45pYqvucCFo4utNjpW7CVDN4551xY1JhzLgymOZyrFSaFTgm6O4YudJbYOgK1j7atH1gZSkWKPkZYvyi6JnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8tEyHr0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DD2C4CEDD;
	Tue,  7 Jan 2025 12:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736253012;
	bh=SbiW47PK2VdDldJSNiTyXXjompnyG9UpusszDUoRMfQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n8tEyHr0XJe6dqmU487jvsdRDxvO8kzvW9i1//zGuw50jS+yVkNMu22MvNgcATKL7
	 sXzUy+Tstlzssfs4ro5DQgt2Yr+bOxJVKLsHSarJSjxjMo5dOFsoIexGKdqNecexp7
	 7p17AlSNXc7HQDsuRufVflfFkpvhYozZpQbCG/Qi4W1jvm37B5jiofRb1YG08BXURz
	 NL88vDPcVR/5ICwLg6OEdkIDpaVQvqiBnIiiaZwMDLVgc73cOxqn5z4rUxAXbVkcTT
	 mYBDn6vlbyLaXZx3upMWgrbg2Wn0F1QWPos6T9ycsTtLIL1XL8sidSyq7bOx8c7A7c
	 EZOlK67f8HQzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34163380A97E;
	Tue,  7 Jan 2025 12:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] eth: fbnic: update fbnic_poll return value
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173625303373.4137400.4491759064285580088.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jan 2025 12:30:33 +0000
References: <20250104015316.3192946-1-mohsin.bashr@gmail.com>
In-Reply-To: <20250104015316.3192946-1-mohsin.bashr@gmail.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
 andrew@lunn.ch, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 damato@fastly.com, brett.creeley@amd.com, kernel-team@meta.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  3 Jan 2025 17:53:16 -0800 you wrote:
> In cases where the work done is less than the budget, `fbnic_poll` is
> returning 0. This affects the tracing of `napi_poll`. Following is a
> snippet of before and after result from `napi_poll` tracepoint. Instead,
> returning the work done improves the manual tracing.
> 
> Before:
> @[10]: 1
> ...
> @[64]: 208175
> @[0]: 2128008
> 
> [...]

Here is the summary with links:
  - [net-next] eth: fbnic: update fbnic_poll return value
    https://git.kernel.org/netdev/net-next/c/2f4f8893e07a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



