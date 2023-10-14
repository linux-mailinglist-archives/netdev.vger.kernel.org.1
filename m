Return-Path: <netdev+bounces-40905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28A27C919B
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 02:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BCC7282E5F
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 00:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8454A262A7;
	Sat, 14 Oct 2023 00:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g51YRqoZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6055512B76;
	Sat, 14 Oct 2023 00:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0620C433C8;
	Sat, 14 Oct 2023 00:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697241625;
	bh=T/rhZgLqYprt6fGDBRWjkewervZRhxFXZK11xFRoG48=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g51YRqoZQFdKTLWefjb7FB1fJ5GU/xOeaL+cbcb5u//lJiOJRZTAnoIL+mNKk64SU
	 oWPkp7T72LjO4a7eynB1UHRKifz4Kjpu5N7aONqTPeY8ctB9IvxfZAe6ThBp4eel+Z
	 gVTrYerK/iNxy+6J3hol/Q5U4bK41Y0p847ZNexRX4R/dXpj9yYwXfUWoa9vzRorp2
	 RsrdnNgpArtGRwprTBWBjargsWSu9cQF5L+T/Wi2aD0hOZagAKoaFYcPPqPrz3Lief
	 VKrxUDt5hzdwPRhfnND1nVQ3xH0K8LTrV6e8G+GdZPj1O3pe9Gajmw7aBjv5Cdv++1
	 wMCb4TFmLMRYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C9FBBE1F66C;
	Sat, 14 Oct 2023 00:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] tcp: allow again tcp_disconnect() when threads are
 waiting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169724162482.10042.15716452478916528903.git-patchwork-notify@kernel.org>
Date: Sat, 14 Oct 2023 00:00:24 +0000
References: <f3b95e47e3dbed840960548aebaa8d954372db41.1697008693.git.pabeni@redhat.com>
In-Reply-To: <f3b95e47e3dbed840960548aebaa8d954372db41.1697008693.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, ayush.sawal@chelsio.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, dsahern@kernel.org,
 mptcp@lists.linux.dev, borisp@nvidia.com, tdeseyn@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Oct 2023 09:20:55 +0200 you wrote:
> As reported by Tom, .NET and applications build on top of it rely
> on connect(AF_UNSPEC) to async cancel pending I/O operations on TCP
> socket.
> 
> The blamed commit below caused a regression, as such cancellation
> can now fail.
> 
> [...]

Here is the summary with links:
  - [v2,net] tcp: allow again tcp_disconnect() when threads are waiting
    https://git.kernel.org/netdev/net/c/419ce133ab92

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



