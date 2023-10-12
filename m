Return-Path: <netdev+bounces-40199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 479F67C61B3
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 02:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0731C209C9
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 00:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69050641;
	Thu, 12 Oct 2023 00:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOn1TBzR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEAD364
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 00:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AAFA5C433C7;
	Thu, 12 Oct 2023 00:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697070624;
	bh=SmqVFlP+o0DEuOFneU8W57x6vZHM0a9iuOjnFbiGyE8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tOn1TBzRBV48ElW7lnYAFdztfbzOyBdjCrtuSSLzXubS+Kwel2QlXRlw+E7IISEwW
	 6+HqVVQHy+ySR/Ug3lg6OQj0kOh47o8Vn/zlK+Sj2vaZF0/rq03NpvyHJRE8wTrp9S
	 0yYLcg/V0RRr9k06E28w/i0Neh2p7FceQaTClhND4GSpkZsIY0AKrfjIWbLY9N31TV
	 DDFXHhU7LS01fRDvyh9Li5gVc8+qXHiOAMAT4RIROPSWOH2W/rOA51ViRQRYH9qfK7
	 0qtkDJ9Ew4Mn/FqPxF9RuUAxksLAtwEigt3kCEtU+yTP5agw9l9DVcFu7g3sHzzOuD
	 Jaj9xFcfJYViw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8CF4FE000BB;
	Thu, 12 Oct 2023 00:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: tcp: fix crashes trying to free half-baked MTU
 probes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169707062457.15864.16528334906282807183.git-patchwork-notify@kernel.org>
Date: Thu, 12 Oct 2023 00:30:24 +0000
References: <20231010173651.3990234-1-kuba@kernel.org>
In-Reply-To: <20231010173651.3990234-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, dsahern@kernel.org, clm@fb.com, osandov@osandov.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Oct 2023 10:36:51 -0700 you wrote:
> tcp_stream_alloc_skb() initializes the skb to use tcp_tsorted_anchor
> which is a union with the destructor. We need to clean that
> TCP-iness up before freeing.
> 
> Fixes: 736013292e3c ("tcp: let tcp_mtu_probe() build headless packets")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] net: tcp: fix crashes trying to free half-baked MTU probes
    https://git.kernel.org/netdev/net/c/71c299c711d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



