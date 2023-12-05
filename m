Return-Path: <netdev+bounces-53968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A14805799
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 15:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F018A28228F
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 14:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677994A987;
	Tue,  5 Dec 2023 14:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ycj0Kwlv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB0965ED2
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 14:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB709C433C9;
	Tue,  5 Dec 2023 14:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701787224;
	bh=Cqjr/l2HE0/9mBSB9DQ/q7hDg0gN44Wa6VbJWXCLi7s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ycj0KwlvU/XrBOh4qMaM1Cc9yWoaiG3a2xkRQsl4vHpQy5hFHoaC4bOhGb6PZm7Jv
	 WYrR9woUtM4PA2blktSDxLxA5svTYkmD+r903o8iXvI6CilisjQYl38tdblKkfYZkI
	 tHwuxgpLwK7MhoAk7uhWAjKIoXZtqARJypJG4wGxhDAE2Ri/oeOp5MzjCqSIFFtLpc
	 X/wLgk048d0Ud3M+VUBlEw7wO+8jSJfU5IHZHANbd/wq7mPaXWA+Iw+HQzOQ2ycRS3
	 r4VvER6Rq4K1dJ3ziyGoLhU5E2kmqCMep2nSAIVkFc/+sYlZfbSgHRZkVUd3zCTDy0
	 udfH/RtPH0BLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ACEBFC40C5E;
	Tue,  5 Dec 2023 14:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next,v2] macvlan: implement .parse_protocol hook function
 in macvlan_hard_header_ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170178722470.32384.9967935254321756458.git-patchwork-notify@kernel.org>
Date: Tue, 05 Dec 2023 14:40:24 +0000
References: <20231202130658.2266526-1-shaozhengchao@huawei.com>
In-Reply-To: <20231202130658.2266526-1-shaozhengchao@huawei.com>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, weiyongjun1@huawei.com,
 yuehaibing@huawei.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 2 Dec 2023 21:06:58 +0800 you wrote:
> The .parse_protocol hook function in the macvlan_header_ops structure is
> not implemented. As a result, when the AF_PACKET family is used to send
> packets, skb->protocol will be set to 0.
> Macvlan is a device of type ARPHRD_ETHER (ether_setup). Therefore, use
> eth_header_parse_protocol function to obtain the protocol.
> 
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] macvlan: implement .parse_protocol hook function in macvlan_hard_header_ops
    https://git.kernel.org/netdev/net-next/c/cb297cc5e194

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



