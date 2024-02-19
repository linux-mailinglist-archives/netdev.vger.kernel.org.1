Return-Path: <netdev+bounces-72868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AF885A030
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 10:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 560E8B20B01
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 09:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDF325571;
	Mon, 19 Feb 2024 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFlBLggz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A74250ED
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708336224; cv=none; b=Q5YUOY73eObw4+VcbW1XqCrZtwQt3BJNTh4tEWFeSSlBBwp/N8SZpWrnE+MTwURBH5F5X4iMG8diSA42/PzmBR7luB07xvpIlvJ850iUZRRSik0TxulTVsXLfXhrwLci1Gj8btPiwLFYdhaChzzLoiCliMjHhgwevraMuNLvvg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708336224; c=relaxed/simple;
	bh=C1vGfU6o7hly/NMkk64kZxDz79F8MByGpThO1bLp1IY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n+Z9MSpEmSIQRNq2+vf6K76CGnugLrMhLuQy/KHsri/LHADbsE/2wgXF0Mfj7AXIw0/znoPYsyrZDp7vg5+qugW8bBeOOYrFKxs2gpzoe2sbhGLG0cx1DkPGHNeGOVX6DwS1wySrzmEYbdu/Fr5SmSJrF6PEGLkCFO1sGzHjnHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFlBLggz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8BF2C43399;
	Mon, 19 Feb 2024 09:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708336223;
	bh=C1vGfU6o7hly/NMkk64kZxDz79F8MByGpThO1bLp1IY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZFlBLggzz1vD6IB1Q0dlac3qqJtIuOF6Yqbi1q5WpPbr9IX0jo3u8EOXafdOHf21I
	 E0zdNubKNNIWgS+lSvO+O+S0HVlBvNZwMiHQhdCZOI8J2C2bdmia6otTpWNAtEaJBE
	 Irs0yrwHnZyjXlHqvZkG8iqQ+On9R9ECYWMcZ0r7d1sgVKLArOSlnoktl9bLddVDiW
	 Jq/KBppjgsBgu+UIE/LVQS620qUpAfAjFmskKb4ZAE3GghBDAvdxp8F1EwVB8rzOYk
	 LWHduGHHgzlIxg0nW+7aQQ7IhRTS/CcXc37Kb7pCoFSKVKLMizMb6f7qzo9o5WjfWP
	 2Th1VQ8tinLwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0195D990CA;
	Mon, 19 Feb 2024 09:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net-next v2] tools: ynl: don't access uninitialized attr_space
 variable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170833622371.9868.308900236836184671.git-patchwork-notify@kernel.org>
Date: Mon, 19 Feb 2024 09:50:23 +0000
References: <20240215122726.29248-1-jiri@resnulli.us>
In-Reply-To: <20240215122726.29248-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, donald.hunter@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 15 Feb 2024 13:27:26 +0100 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> If message contains unknown attribute and user passes
> "--process-unknown" command line option, _decode() gets called with space
> arg set to None. In that case, attr_space variable is not initialized
> used which leads to following trace:
> 
> [...]

Here is the summary with links:
  - [net-next,v2] tools: ynl: don't access uninitialized attr_space variable
    https://git.kernel.org/netdev/net-next/c/d0bcc15cbae8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



