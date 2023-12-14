Return-Path: <netdev+bounces-57324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E06812E36
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 12:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F372F1F219C1
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 11:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E733F8C2;
	Thu, 14 Dec 2023 11:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBUHJN6N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AC63E495
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 11:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C18DC433C8;
	Thu, 14 Dec 2023 11:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702552225;
	bh=xIw3+OBh9lhu0njk3+DzXcV4JfZZrZBCAnL9j8qHICw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UBUHJN6N8WUS/kKSfCMas1WO+8hB44r4A33ic40OH37fm4rgyl/fv3qdHp9OW6fUj
	 0RwcqgjWIFiUV/j5KFtLhnfFqaCxBN7jZqkYZk8TcnCR2DR2iTI8aIJIzXKZb30n2e
	 iFMA4EJIr9q3jFNhZWZ2lGO79qS5kXrxoZYe7oPbjV7/TfZsVtSPtzMPaUTLcFFJ2c
	 FXfn3mDNtdZvDUcxh+phiNReo/xyiFm49TfpPtM+H1swGe/I+CZqpZ6tOtAJkL3xeq
	 ytmdnDCJu8rTlRffrpHmrHCsuoKe1KuC2HzlxQSBK8Z5v05aNM4iUSNzMSM44fu7WP
	 QQif0t/uSQdbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D30EDD4EFE;
	Thu, 14 Dec 2023 11:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] appletalk: Fix Use-After-Free in atalk_ioctl
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170255222524.10804.9204019996221133985.git-patchwork-notify@kernel.org>
Date: Thu, 14 Dec 2023 11:10:25 +0000
References: <20231213041056.GA519680@v4bel-B760M-AORUS-ELITE-AX>
In-Reply-To: <20231213041056.GA519680@v4bel-B760M-AORUS-ELITE-AX>
To: Hyunwoo Kim <v4bel@theori.io>
Cc: pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuniyu@amazon.com, imv4bel@gmail.com, kuba@kernel.org, horms@kernel.org,
 dhowells@redhat.com, lukas.bulwahn@gmail.com, mkl@pengutronix.de,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 12 Dec 2023 23:10:56 -0500 you wrote:
> Because atalk_ioctl() accesses sk->sk_receive_queue
> without holding a sk->sk_receive_queue.lock, it can
> cause a race with atalk_recvmsg().
> A use-after-free for skb occurs with the following flow.
> ```
> atalk_ioctl() -> skb_peek()
> atalk_recvmsg() -> skb_recv_datagram() -> skb_free_datagram()
> ```
> Add sk->sk_receive_queue.lock to atalk_ioctl() to fix this issue.
> 
> [...]

Here is the summary with links:
  - [v3] appletalk: Fix Use-After-Free in atalk_ioctl
    https://git.kernel.org/netdev/net/c/189ff16722ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



