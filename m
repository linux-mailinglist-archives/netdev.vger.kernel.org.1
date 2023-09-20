Return-Path: <netdev+bounces-35301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AF67A8AE2
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 19:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 000BD281595
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 17:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672CC3FB3E;
	Wed, 20 Sep 2023 17:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BD13E47E
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 17:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C44A7C433CA;
	Wed, 20 Sep 2023 17:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695232223;
	bh=tMf90eA0jpNCqTF12r3NuO9n1Ux0MIz/7x5kx4RuXmU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mSfNodYUUcdrRPrbunIaA42sQAQ0+mWi8t8COosyWD8xfo5prZ5t9d1ehkO9PXfgW
	 DBSZxm06kCPTdCz5ngOl2zd8oLfnLWZ8T8YRqrz8BZjoV5bCPChoI7G2fv6FKsxftl
	 KYKtxFK7Hb1EosgQXxmAyYqQBWmhN49jzVUeK9ff/oVz4T5WzP3+6r+PsD0qUYtsFO
	 UjoyJdrcLRBLukmuyL5sKJC+FQU5MV0xx2AKgWnAs9pUaSAjL+fSubfSzuF9cx5PIX
	 /dNw8pG7b+pwIPhEFWHIkAiKoH9IdsnkkoQpNaX+Uip+drLw4n5D1OzDnC9f+GXO7n
	 4fXkeNMk3IZtw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ABE47C561EE;
	Wed, 20 Sep 2023 17:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2 1/2] bridge: fix potential snprintf overflow
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169523222370.26192.16495501796967388498.git-patchwork-notify@kernel.org>
Date: Wed, 20 Sep 2023 17:50:23 +0000
References: <20230918184631.16228-1-stephen@networkplumber.org>
In-Reply-To: <20230918184631.16228-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org

Hello:

This series was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon, 18 Sep 2023 11:46:30 -0700 you wrote:
> There is a theoretical snprintf overflow in bridge slave bitmask
> print code found by CodeQL scan.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  ip/iplink_bridge_slave.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [iproute2,1/2] bridge: fix potential snprintf overflow
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=4d80122ae82a
  - [iproute2,2/2] ila: fix potential snprintf buffer overflow
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=e8a3fca81cd4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



