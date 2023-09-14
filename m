Return-Path: <netdev+bounces-33735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C6279FC3A
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 08:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1635B20AB6
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 06:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C2C612B;
	Thu, 14 Sep 2023 06:40:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E825664
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 06:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DCB5CC433CC;
	Thu, 14 Sep 2023 06:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694673626;
	bh=+qKydTcjJI5TXTQAlhF/HRlc+eT1o/LHDckqKagvy8E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Yky4LknV/pWCXKtnvajD8lSeg6mcHFJ/WQSoGYKxDkT+VCvc6JrbJtlQ8ddXiR8SN
	 BIlvXgH943tE6zwkALw+3qHAxcNOm2GMQAgg4ry0MCXDhcns3oqJFjd0tS2fil0epT
	 v15U4nG+Eq/bDhbTh2t42ryq/aHKjcgpPN09Hm9rURLTv1JsJ/+AsZUn/zRyZ3lV1V
	 dqNjP5CLHuVy7s5X2PEA2DTMZfNPbCI5AKjn8LCX1o4UEqJNTX240LvpcTNB6bPVuI
	 +2q4o7d3ykMeEJyHVszbXBb1o8ys+aL8VyFV5cymJUj410r9h46DR2EmKKZZZ0Lz8c
	 T5PDdHGx2zePA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BA056E22AF5;
	Thu, 14 Sep 2023 06:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] vsock: handle writes to shutdowned socket
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169467362675.3965.13004245491744168784.git-patchwork-notify@kernel.org>
Date: Thu, 14 Sep 2023 06:40:26 +0000
References: <20230911202027.1928574-1-avkrasnov@salutedevices.com>
In-Reply-To: <20230911202027.1928574-1-avkrasnov@salutedevices.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
 jasowang@redhat.com, bobby.eshleman@bytedance.com, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@sberdevices.ru, oxffffaa@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 11 Sep 2023 23:20:25 +0300 you wrote:
> Hello,
> 
> this small patchset adds POSIX compliant behaviour on writes to the
> socket which was shutdowned with 'shutdown()' (both sides - local with
> SHUT_WR flag, peer - with SHUT_RD flag). According POSIX we must send
> SIGPIPE in such cases (but SIGPIPE is not send when MSG_NOSIGNAL is set).
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] vsock: send SIGPIPE on write to shutdowned socket
    https://git.kernel.org/netdev/net-next/c/8ecf0cedc08a
  - [net-next,v2,2/2] test/vsock: shutdowned socket test
    https://git.kernel.org/netdev/net-next/c/b698bd97c571

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



