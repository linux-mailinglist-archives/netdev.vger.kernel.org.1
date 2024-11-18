Return-Path: <netdev+bounces-145969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8418F9D16A3
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 18:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBD51B27154
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832FE1C1ACF;
	Mon, 18 Nov 2024 17:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+odnam8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F34918B47E
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 17:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731949223; cv=none; b=npAcHw4v+QncLF9uMfr2pS8tscbUtZf4Xw+ixd77jeYhM+2YuOcR0Js5P4wWfH/WBWVKu/2+O9d2Tu/Zp5jtY1xYX3YVOnrkCAszsNSckGzAK9lgXCxreTW5BdMeDDaaaWL9KwE9AyvlSXfKnKtDf18AuVQHP/K9oJ1wI/XoqXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731949223; c=relaxed/simple;
	bh=74hiOyEt0taKhGeoL7ZDX4n4Po+OeKIsKKjjpTGtaI8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=id8ZZzobWgrBNStFXabg6B1rSPainxl3mbPWx/ngORhEIfXCA/IwmfmsQA8mMMZN0WFJfqzW60aLJTflw28pGacpnBKIQ/v2srdCjHietb90W6Lpcyuql4g/RYfOqJLPD36IGFJFEGGdJGWPci14OaiQNgR1TPSSj/Yey5l3wsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+odnam8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB94AC4CECC;
	Mon, 18 Nov 2024 17:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731949222;
	bh=74hiOyEt0taKhGeoL7ZDX4n4Po+OeKIsKKjjpTGtaI8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a+odnam8QjbYMfLCQw96CwsM299axoQDOzaT0qFeo8vayoSjQCwT5Y0TxgO8Oj3Dz
	 nYDFaRmaC4cSACVTar6Q0g7z5qpukqDcTRLV3jaB0kYB2kWlngUaEc4HDqyznLSPoa
	 iEbpmZ2wWVOqswV6qIv6c4h+bGwbd/kbvOG30rRm1eAzSUwcgajxhklzSxcRVEJpFt
	 vH8GS5oZS2qxqP5JD3uEMoredE4DK1ApJ95qeZxeBNyQFAU/+iWtiXFmrfpHZhzqOT
	 fUpnVMLd0cs+qMyepT9Q2ZKFtkxPh6wos/9FBZl6vgW0TcU5/yIMoEumR9jvdeKfDY
	 cOmoJr1cG8/rQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7131E3809A80;
	Mon, 18 Nov 2024 17:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v1] tc: Add support for Hold/Release mechanism
 in TSN as per IEEE 802.1Q-2018
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173194923408.4109060.4045390927300131499.git-patchwork-notify@kernel.org>
Date: Mon, 18 Nov 2024 17:00:34 +0000
References: <20241112040029.3196975-1-yong.liang.choong@linux.intel.com>
In-Reply-To: <20241112040029.3196975-1-yong.liang.choong@linux.intel.com>
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Tue, 12 Nov 2024 12:00:29 +0800 you wrote:
> This commit enhances the q_taprio module by adding support for the
> Hold/Release mechanism in Time-Sensitive Networking (TSN), as specified
> in the IEEE 802.1Q-2018 standard.
> 
> Changes include:
> - Addition of `TC_TAPRIO_CMD_SET_AND_HOLD` and `TC_TAPRIO_CMD_SET_AND_RELEASE`
> cases in the `entry_cmd_to_str` function to return "H" and "R" respectively.
> - Addition of corresponding string comparisons in the `str_to_entry_cmd`
> function to map "H" and "R" to `TC_TAPRIO_CMD_SET_AND_HOLD` and
> `TC_TAPRIO_CMD_SET_AND_RELEASE`.
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v1] tc: Add support for Hold/Release mechanism in TSN as per IEEE 802.1Q-2018
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=863c96cea49d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



