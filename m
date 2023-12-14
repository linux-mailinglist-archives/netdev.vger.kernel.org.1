Return-Path: <netdev+bounces-57191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D6C812547
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 03:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267501F21660
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 02:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1683180;
	Thu, 14 Dec 2023 02:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqd1fm46"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4230EA3
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 02:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F8A3C433CB;
	Thu, 14 Dec 2023 02:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702521024;
	bh=Ckdwk+2gDWsgpN2DluOrMUpunVXkOi3mwYv69KWeWwI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oqd1fm46KOcdF09P0h3J8yYINkPmKzx7JPGTstqRDn8zUy0FOgG0vrRvOi9vmIqK9
	 2dri1EjPtLzx9tOzP/6fE/7p+kz9j7nNnzOvusBLm7ovt7p6pT1DxMfeBs97azuRXw
	 yzEUqXM0V+1Qk0Xcj70Cc/09TqEvpaitUGmtH6dJWhZWiShNd8UVbh8OYQBXpo+2xQ
	 HtlS0Ew51nhBe7AAhouLeDvYJEraEQRu6KL3yethT1Jfsa5/dAWi3QtLHT2cXwDbQT
	 8OkQUndGhOEJgPRCJDximGXwDbWUYglQz6KI4B/OpVk+eE6S7IpOeWiZUHLPAzY6Y8
	 avR96wiYKTyQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 22669DD4EFE;
	Thu, 14 Dec 2023 02:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: prevent mss overflow in skb_segment()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170252102413.28832.4039691914378719525.git-patchwork-notify@kernel.org>
Date: Thu, 14 Dec 2023 02:30:24 +0000
References: <20231212164621.4131800-1-edumazet@google.com>
In-Reply-To: <20231212164621.4131800-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, marcelo.leitner@gmail.com,
 willemb@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Dec 2023 16:46:21 +0000 you wrote:
> Once again syzbot is able to crash the kernel in skb_segment() [1]
> 
> GSO_BY_FRAGS is a forbidden value, but unfortunately the following
> computation in skb_segment() can reach it quite easily :
> 
> 	mss = mss * partial_segs;
> 
> [...]

Here is the summary with links:
  - [net] net: prevent mss overflow in skb_segment()
    https://git.kernel.org/netdev/net/c/23d05d563b7e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



