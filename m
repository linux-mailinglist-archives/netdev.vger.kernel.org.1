Return-Path: <netdev+bounces-56398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5803F80EB82
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 13:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E86D1F21205
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 12:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636F35EE75;
	Tue, 12 Dec 2023 12:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIMpr+Wj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4249A5EE61
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 12:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF4EBC433C9;
	Tue, 12 Dec 2023 12:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702383623;
	bh=MYzAu2VZM6l1ZM2XRFd6UW4+j2lWmv5yP7myXox5seQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qIMpr+WjzVwul1QKiiNV3ogxul9+JW2Lj4TFwAGldqtcI+ecQJVa95W/48TvoxZZ0
	 xecWwK5MM7QcF0a8uYrNgU21U/zFfoGjAjE5U8j88SMRxKOM5B+n8PCYwUsBuvOnEd
	 wwkG0+uVOvJIPMl8xD6hvovoBQbrTKJy+H8Y6CSuEuU0T5BJQQyQ/hO/B3keF5sRzd
	 79fOALVYJ8n/ZhLP83AutRT/MlRoPBwrzhHxdvvQmzYZNvO6gwNFDnL7+so67uKgq+
	 2FPgidfCfUpSBS7suoc2Xl275gv24a9OY0wlbs8eZYFmAisYkqZp4wNIJPv3lhn6rc
	 1epMXKdx2LMOA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A7616DD4EFE;
	Tue, 12 Dec 2023 12:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] atm: Fix Use-After-Free in do_vcc_ioctl
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170238362367.3796.13496681775483460069.git-patchwork-notify@kernel.org>
Date: Tue, 12 Dec 2023 12:20:23 +0000
References: <20231209094210.GA403126@v4bel-B760M-AORUS-ELITE-AX>
In-Reply-To: <20231209094210.GA403126@v4bel-B760M-AORUS-ELITE-AX>
To: Hyunwoo Kim <v4bel@theori.io>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 imv4bel@gmail.com, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 9 Dec 2023 04:42:10 -0500 you wrote:
> Because do_vcc_ioctl() accesses sk->sk_receive_queue
> without holding a sk->sk_receive_queue.lock, it can
> cause a race with vcc_recvmsg().
> A use-after-free for skb occurs with the following flow.
> ```
> do_vcc_ioctl() -> skb_peek()
> vcc_recvmsg() -> skb_recv_datagram() -> skb_free_datagram()
> ```
> Add sk->sk_receive_queue.lock to do_vcc_ioctl() to fix this issue.
> 
> [...]

Here is the summary with links:
  - [net,v3] atm: Fix Use-After-Free in do_vcc_ioctl
    https://git.kernel.org/netdev/net/c/24e90b9e34f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



