Return-Path: <netdev+bounces-13900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FC273DBC0
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 11:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ED7D280DCB
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 09:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8396FDB;
	Mon, 26 Jun 2023 09:50:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0596FB2
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 09:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C0CFC433C8;
	Mon, 26 Jun 2023 09:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687773020;
	bh=6jAGu5lQf4CVvIL///6M34jDZT1byyGNJUoLjH2OSm8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F+xB68qDImSqJZ4FBogh0YY86J4gXHnPg/o/3GL/zOx/c+NyyNSLwjZ+M+uVpORrP
	 GtlQg8fNptKdTA8y6h6SspRpWzYiKSn9sAO550Qe5/HBX9+YT9tPTvOQTNUHLRnWu/
	 twnJMjrLAQ4wkiHTPZdQ5wp2s+Fe7rMJLoE98OB0PpN84liapJOMAZihAR+9g81ilV
	 u1oVZLsF377JPowzWMJLhlB8UlHUU8V+Sn3S9poWqEhTjBhqwJ6yb0MtV6vzOcOg4e
	 xPWrTN34p9U5GprwDMCyj7w5CYfXid8C2khsfTFiQtcxvzGWzCOzTrZrDnLIZ6+jMJ
	 /622m1i/n9XNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 11D68C4167B;
	Mon, 26 Jun 2023 09:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/3] sfc: fix unaligned access in loopback
 selftests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168777302005.21547.14985682307785128659.git-patchwork-notify@kernel.org>
Date: Mon, 26 Jun 2023 09:50:20 +0000
References: <cover.1687545312.git.ecree.xilinx@gmail.com>
In-Reply-To: <cover.1687545312.git.ecree.xilinx@gmail.com>
To:  <edward.cree@amd.com>
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, ecree.xilinx@gmail.com,
 netdev@vger.kernel.org, habetsm.xilinx@gmail.com, arnd@arndb.de

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 23 Jun 2023 19:38:03 +0100 you wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Arnd reported that the sfc drivers each define a packed loopback_payload
>  structure with an ethernet header followed by an IP header, whereas the
>  kernel definition of iphdr specifies that this is 4-byte aligned,
>  causing a W=1 warning.
> Fix this in each case by adding two bytes of leading padding to the
>  struct, taking care that these are not sent on the wire.
> Tested on EF10; build-tested on Siena and Falcon.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/3] sfc: use padding to fix alignment in loopback test
    https://git.kernel.org/netdev/net-next/c/cf60ed469629
  - [v2,net-next,2/3] sfc: siena: use padding to fix alignment in loopback test
    https://git.kernel.org/netdev/net-next/c/30c24dd87f3f
  - [v2,net-next,3/3] sfc: falcon: use padding to fix alignment in loopback test
    https://git.kernel.org/netdev/net-next/c/1186c6b31ee1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



