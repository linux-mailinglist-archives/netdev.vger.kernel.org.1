Return-Path: <netdev+bounces-247553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 99118CFB9E3
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 02:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FAB130477CC
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 01:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAFA1C8626;
	Wed,  7 Jan 2026 01:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wadg7ULf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397C910FD
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 01:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767750209; cv=none; b=mF1ruStVWfAIqWUXXoCBqnS0dSwkYZIdVptv/WSDaCuUAOYWkH2lLQiVGBTejRKWg8qS5r1iJBLEJlUJxz1K+RCuU8N78QrAh6Xi+zWUbxNmbe7ScdkKqvXHL7fhFZh6J4PyR5+rBav8YEUMTAA+p/wZpImG/3UBy3ptCoQfQmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767750209; c=relaxed/simple;
	bh=GinRvRCFt0GAsM0LG3lAqSeG4GR3P5wK+45cesHNa20=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aeOmGhSLKkabNMUQMz4RXf/bxN6140iu8NAjpLy30xOL/4WmgKqX2nvoLZ1nyVd0FkGvn9vZ3RgC0Ec6/dWJf6I7I25u+d+tISXW6SNY9iB83ANgi5PNtscf5LWvHu0gaiT9pjHpCvoS4IGXfQKq2JvxxD7iwDBQKLoaR/A3HOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wadg7ULf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B943C116C6;
	Wed,  7 Jan 2026 01:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767750209;
	bh=GinRvRCFt0GAsM0LG3lAqSeG4GR3P5wK+45cesHNa20=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Wadg7ULfj6puHpOlmxh8u5/VQivP/csUY8SObkawnOQwvEG5O5M3CtMvh/Ue07uV7
	 Vw2m/y1oPUNKlmLl+wGBe6yxjxH5z/rdC6DAp4yj/mrW7MuP6P0ZOKvbm4qwtc26PX
	 RsLsfwmSHtei87rd5cCVOG1Xh/UYS0qQKObU0+ItDsEc+bwNOPRFuaxB1w+rdyMV4B
	 INALZNBQWWGZzuvOJjuhAG9qv+UF9SFnLMV8pZGSLmkOid9uTdrQhcsdqlE3U08oGa
	 9Z3qwiC1ybYncdg1EY09pxFoOo9gsV0/8OxVTTK1w1UZO+Vw/HZxrUictMU6bRahFL
	 iZD5GssuWK7mA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B58CA380CEF5;
	Wed,  7 Jan 2026 01:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net/sched: act_api: avoid dereferencing ERR_PTR in
 tcf_idrinfo_destroy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176775000629.2194089.18152172133277668812.git-patchwork-notify@kernel.org>
Date: Wed, 07 Jan 2026 01:40:06 +0000
References: <20260105005905.243423-1-shivani07g@gmail.com>
In-Reply-To: <20260105005905.243423-1-shivani07g@gmail.com>
To: Shivani Gupta <shivani07g@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org,
 syzbot+8f1c492ffa4644ff3826@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Jan 2026 00:59:05 +0000 you wrote:
> syzbot reported a crash in tc_act_in_hw() during netns teardown where
> tcf_idrinfo_destroy() passed an ERR_PTR(-EBUSY) value as a tc_action
> pointer, leading to an invalid dereference.
> 
> Guard against ERR_PTR entries when iterating the action IDR so teardown
> does not call tc_act_in_hw() on an error pointer.
> 
> [...]

Here is the summary with links:
  - [v2] net/sched: act_api: avoid dereferencing ERR_PTR in tcf_idrinfo_destroy
    https://git.kernel.org/netdev/net/c/adb25a46dc0a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



