Return-Path: <netdev+bounces-156415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF284A06535
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 20:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182AC3A7D69
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 19:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D6A201022;
	Wed,  8 Jan 2025 19:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hA3VYU/2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD49386333
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 19:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736364019; cv=none; b=PL0TS4Tlnay7ujKaQZxHWAB5NKZ67uHDDrj8/ooV4+KZBaZw9pG7micA9ZLoCGYXbLyJWzxVIKqLW3f7ln+ijNS+q4ZVzMmIUkwz/b4DpdeDWkMrmsX/LDcK0HLGaXsCpglrh/P3UDhDy9gk/rCpJBrbGL8POLxvANDiaoH16Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736364019; c=relaxed/simple;
	bh=tjvfz6Lv3m6VoiDQ0KrFLlDaSmrapCbXP23R2oTU8JM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fonbt2t2v0YBKdZMBVrXXMdpjyVilQ8/X+Cm48+mrRaW5U3w2RgyRadREWR7CWcrSQRf2+oTviVRUn0CTHG96dnSjfFf4YuVc4P/MkPOOdZzw+fsvIUymd2mY4u3z2gHyREybvzMvVebZ/UgSB4vaoN1rK/5lOaidtXBQ+aV8/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hA3VYU/2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3B7C4CED3;
	Wed,  8 Jan 2025 19:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736364019;
	bh=tjvfz6Lv3m6VoiDQ0KrFLlDaSmrapCbXP23R2oTU8JM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hA3VYU/2BJibEbUrZ1xqsSx05obxp15KvaY4THVYxFz84k0LvbOdObURH9BFeU7B3
	 jaOPELynCNuVEHgyrJZBG6LvsbM644LVMkCXa4GXbsy1kkuDvyO+xcYbbrKD2Dkg/B
	 IFyMQQHJovDlz8kRpaFnLKcnKwY0cQAyvdaFlPLi5shu+7kZJenVQQKMLJyyFuq210
	 VrrtdySraHKOOYR/sAdy3hHXwSxxnH/hPHcO3Lg+hsSGxibsyGeE8vYFik8MQEd+jl
	 TWDF+mC1xqY2nFJgrVMIYg2tdoxqqnVUdjsi3dUi7IaqvKAdoz+eBWXVIZZuvIm44d
	 RZgZbLk25EDTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C84380A965;
	Wed,  8 Jan 2025 19:20:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: Annotate data-race around sk->sk_mark in
 tcp_v4_send_reset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173636404100.752119.13634651681023317571.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jan 2025 19:20:41 +0000
References: <f459d1fc44f205e13f6d8bdca2c8bfb9902ffac9.1736244569.git.daniel@iogearbox.net>
In-Reply-To: <f459d1fc44f205e13f6d8bdca2c8bfb9902ffac9.1736244569.git.daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: edumazet@google.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  7 Jan 2025 11:14:39 +0100 you wrote:
> This is a follow-up to 3c5b4d69c358 ("net: annotate data-races around
> sk->sk_mark"). sk->sk_mark can be read and written without holding
> the socket lock. IPv6 equivalent is already covered with READ_ONCE()
> annotation in tcp_v6_send_response().
> 
> Fixes: 3c5b4d69c358 ("net: annotate data-races around sk->sk_mark")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> 
> [...]

Here is the summary with links:
  - [net] tcp: Annotate data-race around sk->sk_mark in tcp_v4_send_reset
    https://git.kernel.org/netdev/net/c/80fb40baba19

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



