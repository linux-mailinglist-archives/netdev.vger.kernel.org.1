Return-Path: <netdev+bounces-177187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFD9A6E38A
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 20:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC2C3ABF93
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 19:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030361A08CA;
	Mon, 24 Mar 2025 19:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdLwGTy6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8A61A08A0;
	Mon, 24 Mar 2025 19:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742844600; cv=none; b=Zi3sf3Rvv4eq69JVZj4U8xk/3DAcMgp2WlEin1a9e9kbnJ8Fxqp/+HoXiaYjhJVsjxvh4+SIRlO3+ZnipFmn9Wx5tCCG/UGj3Q9KDH4EmpcqdG2hHb6XkxtFbRr2XAOG8xuomUaFvdqVY0CH/AeMwsBc+TXpn6Ztl9o4GYaZkTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742844600; c=relaxed/simple;
	bh=XRz8efTQgz8KxnsWJmFmFVFkkB+uLkkRdEVApogpnLQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kSLKKO76eRIanxmuqmjIE4l13XlUVesBRGyI1Y9vgWWQZKqDNWVhmO1ZAdwkRp+eiV10w4JOwEfbn/W9xV8jEBYKlYRx8xwJBewMmHpQo6NAMGyFXqEqV2Du3M6dWOIw59nh0NuI4HnZMijiaoQ+Oey08zxN9hwbcT33LEZbCUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdLwGTy6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B52C4CEED;
	Mon, 24 Mar 2025 19:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742844600;
	bh=XRz8efTQgz8KxnsWJmFmFVFkkB+uLkkRdEVApogpnLQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fdLwGTy6EDVNFXfvyRNELp0c455IPLDtjv0Aqs2YcPXJ5xDb7HY1BdtcMDhXIj7oR
	 puQ01jPMuL50baj6ZReDO7AvjUklNJbsbovmTeS5govIkoQ5Oz5K5hIe8caDmYTr4o
	 TtGi28EVqVfXhHBO164BQyLA3pwOleaeMe6H5TEDFXPofn3YGkQNEG58EwJLD8dUac
	 c+5YvrqKlh7vvP8zbg8GFzYmH+5V6QNbQ49Xlzv+TcCR2+5niCwNMztYhehfjSVoLi
	 XswDxZ4/wHxsGM6OJ3cd1hxUdn6W/RYH7C4Nb+Vs0Pmf57UsVnewQCfmNz508XMp04
	 sMRWQm10whoCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF318380664D;
	Mon, 24 Mar 2025 19:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] docs/kcm: Fix typo "BFP"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174284463651.4144910.11040696837630657048.git-patchwork-notify@kernel.org>
Date: Mon, 24 Mar 2025 19:30:36 +0000
References: <20250318095154.4187952-1-ryohei.kinugawa@gmail.com>
In-Reply-To: <20250318095154.4187952-1-ryohei.kinugawa@gmail.com>
To: Ryohei Kinugawa <ryohei.kinugawa@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, tom@herbertland.com,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Mar 2025 09:51:52 +0000 you wrote:
> 'BFP' should be 'BPF'.
> 
> Signed-off-by: Ryohei Kinugawa <ryohei.kinugawa@gmail.com>
> ---
>  Documentation/networking/kcm.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] docs/kcm: Fix typo "BFP"
    https://git.kernel.org/netdev/net-next/c/4f34c2b7798d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



