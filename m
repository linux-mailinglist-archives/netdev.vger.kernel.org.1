Return-Path: <netdev+bounces-38715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF5D7BC33A
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 02:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A7C22820B6
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 00:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AFC180;
	Sat,  7 Oct 2023 00:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sDCQtx9D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE86163
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 00:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79DD6C433C9;
	Sat,  7 Oct 2023 00:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696637424;
	bh=NZEjypoI2dzRagDQI0NiAIAHHTzxyMrHzACx/h6ZzOw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sDCQtx9DgosIFNT1FptZDvLmmhItvJWS0H4vQ3q0IcMtKy5+h6MZQJ+/uf7/kTjdt
	 7LeOm9fVf65Px68UC/G7WBjATTedJxkGBXu/xfKevRVbJBxO++PB9hrSUFwS0DJgUr
	 B758XnjEhuRf+n/tXZpKpmULhyU3qOVJYFwB8L3WHxRs6Ui9LWyPOUQQ5FOawvzNFh
	 mMpwxr+ZMpZXCj72wM+PnbniNLR6aE7Mzn0VYviqYLZ7OC0qFZInOSWeanEzzqezRm
	 mm5EQImmfDB4tMV6OZLjHrwOL9GNvbS6Sa6abq8y6NeYKtYsbVSslr9xnf5FTgoJEJ
	 yExJCrfIHVv2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 600A9C41671;
	Sat,  7 Oct 2023 00:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: sock_dequeue_err_skb() optimization
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169663742438.2651.2932612957971412800.git-patchwork-notify@kernel.org>
Date: Sat, 07 Oct 2023 00:10:24 +0000
References: <20231005114504.642589-1-edumazet@google.com>
In-Reply-To: <20231005114504.642589-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Oct 2023 11:45:04 +0000 you wrote:
> Exit early if the list is empty.
> 
> Some applications using TCP zerocopy are calling
> recvmsg( ... MSG_ERRQUEUE) and hit this case quite often,
> probably because busy polling only deals with sk_receive_queue.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: sock_dequeue_err_skb() optimization
    https://git.kernel.org/netdev/net-next/c/48533eca606e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



