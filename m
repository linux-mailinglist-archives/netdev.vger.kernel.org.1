Return-Path: <netdev+bounces-40659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383CB7C8302
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 12:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 695851C20ADA
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 10:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71F84C94;
	Fri, 13 Oct 2023 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXaIxMr+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8893213AD1
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 10:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00158C433C7;
	Fri, 13 Oct 2023 10:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697193023;
	bh=XFXN1rVWQKFJIEUGi+LRYvFsgNMGXpyYSA7pb7WtunU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rXaIxMr+BVkm00GfcigTL0AoybeoeV1Tjj3ht3CJze+wzt9MP+eaPOHiAS0swtQ0r
	 GRMj5nyij+io32A6zk+3ZJDc3rJoZY4Knj2v++6S97KOHSmfjxPDddZMc61US7r3n2
	 1FT6ANx4S5J196yK4MgHbAW9CnF/7yb2cIVLIsuxdEdBkU17QliU6sTfMrku4oFshe
	 T+N+TK0mpixw+NdjrvedaX2AyXqKmLKCUnFiIszw8r5x9//2hbecteZl8jL6nKPIFu
	 0uGNq8X+9ZuOS5FUawD+ywKJWrjNVNYZMO/w99SlZAIRwlwiK7n5Bcdru1klwZpkoK
	 j0luna0IyANDg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DAA90E11F41;
	Fri, 13 Oct 2023 10:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bonding: Return pointer to data after pull on skb
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169719302289.12798.8974107413959216495.git-patchwork-notify@kernel.org>
Date: Fri, 13 Oct 2023 10:30:22 +0000
References: <20231010163933.GA534@incl>
In-Reply-To: <20231010163933.GA534@incl>
To: Jiri Wiesner <jwiesner@suse.de>
Cc: netdev@vger.kernel.org, moshet@nvidia.com, joamaki@gmail.com,
 j.vosburgh@gmail.com, andy@greyhouse.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 10 Oct 2023 18:39:33 +0200 you wrote:
> Since 429e3d123d9a ("bonding: Fix extraction of ports from the packet
> headers"), header offsets used to compute a hash in bond_xmit_hash() are
> relative to skb->data and not skb->head. If the tail of the header buffer
> of an skb really needs to be advanced and the operation is successful, the
> pointer to the data must be returned (and not a pointer to the head of the
> buffer).
> 
> [...]

Here is the summary with links:
  - [net] bonding: Return pointer to data after pull on skb
    https://git.kernel.org/netdev/net/c/d93f3f992780

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



