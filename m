Return-Path: <netdev+bounces-53967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C92D805798
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 15:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4582D1C2107B
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 14:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677F04D11D;
	Tue,  5 Dec 2023 14:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKpWuv8I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA2765ECE
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 14:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D91CDC433CB;
	Tue,  5 Dec 2023 14:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701787224;
	bh=xKSg6YWd7FptnbFK0b1ZsI2xozjfbGnWlRTS4lTvbGc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nKpWuv8IFzA3Ji27KInyHKLxU0qf7XENZNDJjsueusK3UkOMAhZ/Ee68GPXO2xa/m
	 yPT2IcRVyIlgBBt6AljHBkZo0rtzO02wQ4pp9mqo3lim1YzZBNxrila9KaYt8k24pk
	 Tbx8ArKdpyLAIo6hewFiOIrc1hDDh6znuUNjv0Z5ZdOOqmes5L79fproRLrIDgl0EB
	 z8vQ7zddYswgYCxkySIFCILsk9xqy6lp5bzy0ihXcZNA6o0M8+2j2Y0NgSdC8EQU52
	 W0+M1cvwPHio6nYj3AN4rLVk6vjXZhBbKXCBlYeka36QY1bLa7uO1EM0r5S6p9soWa
	 UR9D3MOWTI4aw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B6AB4C43170;
	Tue,  5 Dec 2023 14:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next,v3] ipvlan: implement .parse_protocol hook function
 in ipvlan_header_ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170178722474.32384.10492437388064744383.git-patchwork-notify@kernel.org>
Date: Tue, 05 Dec 2023 14:40:24 +0000
References: <20231202130438.2266343-1-shaozhengchao@huawei.com>
In-Reply-To: <20231202130438.2266343-1-shaozhengchao@huawei.com>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, willemb@google.com, luwei32@huawei.com,
 willemdebruijn.kernel@gmail.com, weiyongjun1@huawei.com,
 yuehaibing@huawei.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 2 Dec 2023 21:04:38 +0800 you wrote:
> The .parse_protocol hook function in the ipvlan_header_ops structure is
> not implemented. As a result, when the AF_PACKET family is used to send
> packets, skb->protocol will be set to 0.
> Ipvlan is a device of type ARPHRD_ETHER (ether_setup). Therefore, use
> eth_header_parse_protocol function to obtain the protocol.
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v3] ipvlan: implement .parse_protocol hook function in ipvlan_header_ops
    https://git.kernel.org/netdev/net-next/c/fb70136ded2e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



