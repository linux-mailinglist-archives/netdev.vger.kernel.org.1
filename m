Return-Path: <netdev+bounces-23042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEAD76A76D
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 05:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8991C20E12
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 03:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E63E211A;
	Tue,  1 Aug 2023 03:20:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B4C139F
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 03:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B971DC433CB;
	Tue,  1 Aug 2023 03:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690860023;
	bh=ahxgk78QsKZbjacZt3OFHUk3/T0+1TNsBU0moZ+CxpQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t+KVYo1h4B5cFYn0SETqeHd+sF02rvQ50g3TZo3mg9T6axSsgtWs/f2jg6I/+2sh3
	 Uom2B75t85Xb1pg2CfuQT9G0FDSHzsfy35xa5mQ3m7Z0/HVwYMNECuxIVASHeKVnO8
	 kVj9E/Ek+fG4ugafi+3f2onfysKZvo3AEAmnSjfr+nOE+QhdNPtuxmBnhIeRDk+tt6
	 1w2ib8h5IPTkJBJyFpq88vWOQh0HZCDonEyPW4Hc4mgPTPSb9zIKvbji1BONefbU+G
	 GAANWOq0C9PDjJtWxes9Il7UYFV26AdpJ721K/akAoFhv4kPOID1CJfOCm9awvegjk
	 1urgHYi/9htOA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F751C595C0;
	Tue,  1 Aug 2023 03:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/hsr: Remove unused function declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169086002364.11962.15301594077499918218.git-patchwork-notify@kernel.org>
Date: Tue, 01 Aug 2023 03:20:23 +0000
References: <20230729123456.36340-1-yuehaibing@huawei.com>
In-Reply-To: <20230729123456.36340-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 29 Jul 2023 20:34:56 +0800 you wrote:
> commit f421436a591d ("net/hsr: Add support for the High-availability Seamless Redundancy protocol (HSRv0)")
> introducted these but never implemented.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  net/hsr/hsr_netlink.h | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - [net-next] net/hsr: Remove unused function declarations
    https://git.kernel.org/netdev/net-next/c/2f48401dd0f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



