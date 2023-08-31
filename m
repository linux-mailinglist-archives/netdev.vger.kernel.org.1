Return-Path: <netdev+bounces-31479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB21C78E474
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 03:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50261281281
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 01:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365871118;
	Thu, 31 Aug 2023 01:40:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF21010FA
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 01:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 757EEC433CC;
	Thu, 31 Aug 2023 01:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693446024;
	bh=WBP5ApnoxdaS2/3dwM99XBwgOegr4AV7fBBFQHI+S9c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BuGxL4TNzSh1D9PNjK/8JC/GlPuepXbfH++yMvBqT7JjtJMqMZdqiw4xrJoMwpNVP
	 hIZq3Dqnf3LxJDZBj25AXGIhvTlb2F5zPymmsBEL837KIokhRGb/g8LRkmCE/CeP0v
	 GBr9sM/2J2Zmhyws6r5R5llpqr3JNmTr3Zw0F952DYkRjtnPwBdeQMEjFuy8QM8mxC
	 Tvk8Ynbkn1px1dMBfgJXsckJzimiGhd+9A1fwB9Go0mYaiHEwyAIeboZ3/YFH3eCMQ
	 OgcIyWITFhkE1SOlI/bSsbwqemLt4LA94qIwPSCyy0I3nqmArqz01ZK/kC1Irqxkjl
	 XByOI4ZmdukJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E6DFE49BBF;
	Thu, 31 Aug 2023 01:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] doc/netlink: Fix missing classic_netlink doc
 reference
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169344602438.11127.13205499863264248928.git-patchwork-notify@kernel.org>
Date: Thu, 31 Aug 2023 01:40:24 +0000
References: <20230829085539.36354-1-donald.hunter@gmail.com>
In-Reply-To: <20230829085539.36354-1-donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, corbet@lwn.net,
 linux-doc@vger.kernel.org, jacob.e.keller@intel.com, sfr@canb.auug.org.au,
 donald.hunter@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 29 Aug 2023 09:55:39 +0100 you wrote:
> Add missing cross-reference label for classic_netlink.
> 
> Fixes: 2db8abf0b455 ("doc/netlink: Document the netlink-raw schema extensions")
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
>  Documentation/userspace-api/netlink/intro.rst | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [net-next] doc/netlink: Fix missing classic_netlink doc reference
    https://git.kernel.org/netdev/net/c/ee940b57a929

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



