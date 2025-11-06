Return-Path: <netdev+bounces-236137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3012DC38C86
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 03:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCD591A23AFA
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 02:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592E42288D5;
	Thu,  6 Nov 2025 02:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBW3/EaZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC79191;
	Thu,  6 Nov 2025 02:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762394460; cv=none; b=YBjbwUId266iqYY6LS3Y72lEyNEAw9zwgwo3wQxYXzupzwBYRW6d1pA2o4nbf7WxXZifTDpEQ9l+ese+7jAODSpPB36s0mZTMzDSwm7wQaAt2nXytPo9jEgzGj7ka4PJ54CA+Sk6JaAYvvQlw5fofOPTymRbsDMmj0hUy5JVpt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762394460; c=relaxed/simple;
	bh=g5glJOowTX7943JcxtaX4WzDgp9ra7F8qfw4QcXZDWM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A/4OeTI2CKfixJjmGsx9xUhinyFxXv8L4GufAt1M8eM13dYAnvuLMUX5cqSfFKdwLUqj3MBSc4dJGazEGjx9GFQXbje1qgpWvUcmBz8BE0kjkbmMJjF5DcG+1XolSdHE2vFMTyQcR71R7THFC0p09JsCx7HuTBByJyMRmx6ML+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBW3/EaZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3977C4CEF5;
	Thu,  6 Nov 2025 02:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762394459;
	bh=g5glJOowTX7943JcxtaX4WzDgp9ra7F8qfw4QcXZDWM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tBW3/EaZiGs+gaRtzpJRt4ZBM83j3mr2+qz6VE6tppk592sNxw55gGE8FfPaJdXeJ
	 9KcYfPC92+e3z5C6KHifeq5XPg5QyC3ZuE7sSGIuYQtdAOnA0yTm6GxAfg0cv2Byap
	 jYsQykOaXh310co+oKuS36ae0kk44Bj2AL5W0awbL4us9ChkF/lmYg47I+nq6eQarE
	 CZWSiPraX+Yg9riA5xDrtHnAsqqzSrgqqacIPXrKYHE+MvFFeF8120ueaLXsECcGrB
	 /tpwOIb09Tt2khFjGICRnXHM2EOE/N/IzfiRluF8qk3wF5geW4JFF8FOWrNINpW/q7
	 /uADxn/XxGHaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DFA380AAF5;
	Thu,  6 Nov 2025 02:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] ptp: Return -EINVAL on ptp_clock_register if
 required ops are NULL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176239443274.3831359.3134439998474183740.git-patchwork-notify@kernel.org>
Date: Thu, 06 Nov 2025 02:00:32 +0000
References: <20251104225915.2040080-1-thostet@google.com>
In-Reply-To: <20251104225915.2040080-1-thostet@google.com>
To: Tim Hostetler <thostet@google.com>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, kuniyu@google.com, hramamurthy@google.com,
 vadim.fedorenko@linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  4 Nov 2025 14:59:15 -0800 you wrote:
> ptp_clock should never be registered unless it stubs one of gettimex64()
> or gettime64() and settime64(). WARN_ON_ONCE and error out if either set
> of function pointers is null.
> 
> For consistency, n_alarm validation is also folded into the
> WARN_ON_ONCE.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] ptp: Return -EINVAL on ptp_clock_register if required ops are NULL
    https://git.kernel.org/netdev/net-next/c/dfb073d32cac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



