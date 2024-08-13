Return-Path: <netdev+bounces-117898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC5D94FBA7
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 04:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0BC41C21AA8
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 02:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A41317545;
	Tue, 13 Aug 2024 02:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxy4d/Zl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E342E15ACA;
	Tue, 13 Aug 2024 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723515031; cv=none; b=NmGXtthLIijqlp6jbVPd1feGSYKjfP2xFUQwU3aMVm5OsZpeLRKIcbnCW90LCEyIQncHdDiBvFJfpTEJ27pgWHo3cRUlk1lgvGuGCZvNL3LelcMEHsRljDi0eN60PrGXajQK180Z4XGZeZiiOo9QHKsc0rGMaQosh6MBzFK0IkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723515031; c=relaxed/simple;
	bh=SSyX307HYoguETbdmeerMfMF1HDhD1Cb3puxc+fgpTk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eZm6XIEb7VkH8qpoUWAC+BwOTm2BUmBX+m/xQ/P+F7CvwZ/rnxP3IhPlGYije5Pkd1qe9LU0jJ3bfRHPr1mrVDa8ZfISbGSL1RJ9vUFctfPnQbHFIh40hsgQeZnck/+aEqdOCbzvEAj6u0WOcU0uqnS0nnojwNc2J5jeJs7aM0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxy4d/Zl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09EBC4AF09;
	Tue, 13 Aug 2024 02:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723515030;
	bh=SSyX307HYoguETbdmeerMfMF1HDhD1Cb3puxc+fgpTk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cxy4d/Zlgg+qi8IDc8uAlej1yQYJx1pEaGuqTqeRXs/1jVfuDzXzWlReha+DvzuYh
	 W3+gOsNwRcU+BaNPj9Tbom4l0oo/Zp+aPF1JPFyOanEAGHE0WaCk62h3SIb/gyzOJh
	 46oPvh4L7ZBu4K0JHp60gLsJdery6KnILmSN97gny2wKcFTHaS3UsVx083agdGexuf
	 lFjfI1YerxhMXOD1Xer4KkPIM9WT97tTuEeaOK2edTGiElW0kCV/w0e4qFYXQHcCUu
	 /Fstm3R1ZxYHhBGaryhI0L5KL+hSqZjjS5nYled/Sw/QHv3VJ7TPAZUHzIxODE3qwM
	 tnie0qDqi1RCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB07A382332D;
	Tue, 13 Aug 2024 02:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2][next] sched: act_ct: avoid -Wflex-array-member-not-at-end
 warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172351502957.1193412.18255780990146180808.git-patchwork-notify@kernel.org>
Date: Tue, 13 Aug 2024 02:10:29 +0000
References: <ZrY0JMVsImbDbx6r@cute>
In-Reply-To: <ZrY0JMVsImbDbx6r@cute>
To: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 9 Aug 2024 09:22:12 -0600 you wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Remove unnecessary flex-array member `pad[]` and refactor the related
> code a bit.
> 
> Fix the following warning:
> net/sched/act_ct.c:57:29: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> [...]

Here is the summary with links:
  - [v2,next] sched: act_ct: avoid -Wflex-array-member-not-at-end warning
    https://git.kernel.org/netdev/net-next/c/e2d0fadd703c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



