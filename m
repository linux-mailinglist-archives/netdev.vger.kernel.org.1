Return-Path: <netdev+bounces-90087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB2A8ACB91
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 13:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4D71F23C11
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 11:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD5B14659F;
	Mon, 22 Apr 2024 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LetdGlGR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D84146595
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713783629; cv=none; b=rTs1WLJcSKwE47ZW8WWoPutDwx9Qu527SUhA+3RaOKjba/tjeHb3G4fbA4BUPtTpZlrMdVzmxrwsP9a44FLAG7LMHnmV1+vWz0GMuUG/vre3ddY++nqHKDFEslOG+y9QMCYoFlRxvS8Ujx7f3QhtNFgM8e0DOcVLtLsNFCb/TFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713783629; c=relaxed/simple;
	bh=LZ0/Q1lgG/f/LKYgsKV6bgmBVr1XPwk0LcZehKznKRw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XPufdUJ0X4YWUz8Qj8u3ObFW/rSCRSUO5JYpr8CI7eQbV28DV04Zi8+C0BiaEJyHXYcpZHyjq6A4f3NybK0aka0XUnLBY8Qq+3Vq8x5aHB6+oCMBnXkjXwKw/VnB0AWltcRNTcylVxFtpeZEAxANzWiSPb1RbUiQSvl4W8xfBuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LetdGlGR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87372C4AF07;
	Mon, 22 Apr 2024 11:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713783628;
	bh=LZ0/Q1lgG/f/LKYgsKV6bgmBVr1XPwk0LcZehKznKRw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LetdGlGRJ0gTvl6I4dAIYAL6hoP26rYXFWLfTpoco7Qsk+l1GIkSquhnd8N3PyG2r
	 zOo2XBA9MkhOCe1N10+Y0dvAsPSf2QqhoQNEAPOEFLGZKp/5qFjuYAOnYXdHizcooj
	 yYEQT83C6lDS8ILtz4uHGOsQFNTds0SzO1l7N5GMRSTUA/Gt4B9e5Q+40eeP6hZCjG
	 mSgaqnDHHCv8EIake6HTW0dEOs8YvV/DS90l+SZrD/C+qp3OELEk2JbYPIGTnaoqM7
	 M7ZGxYzpyfhwKNOWE8qCfci4E5aK+jaJ4APmgvzI+hVRgqzyTm22r4jITT4d3uWpo+
	 VthT1NBCqdy4A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7AD11C433A2;
	Mon, 22 Apr 2024 11:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: do not export tcp_twsk_purge()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171378362849.5313.1716646872507600905.git-patchwork-notify@kernel.org>
Date: Mon, 22 Apr 2024 11:00:28 +0000
References: <20240419071942.1870058-1-edumazet@google.com>
In-Reply-To: <20240419071942.1870058-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, kuniyu@amazon.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 19 Apr 2024 07:19:42 +0000 you wrote:
> After commit 1eeb50435739 ("tcp/dccp: do not care about
> families in inet_twsk_purge()") tcp_twsk_purge() is
> no longer potentially called from a module.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: do not export tcp_twsk_purge()
    https://git.kernel.org/netdev/net-next/c/c51db4ac10d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



