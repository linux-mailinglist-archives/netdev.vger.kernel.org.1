Return-Path: <netdev+bounces-54238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F468065A5
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 04:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4FF7282037
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 03:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBB2D27A;
	Wed,  6 Dec 2023 03:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPNzn8U7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6763CA69
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 03:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D217C433C8;
	Wed,  6 Dec 2023 03:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701833424;
	bh=L3quwkd7+PNevs5xM+KrK33Y+Q17LCodhRGFKwWPclw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fPNzn8U7sXjTqJNc9O6x7qGLfOF8sKWm4dmn1CZKNAq8+yRwABCD6w0UpKGu4d+o0
	 ta12exkoqt5iUAFhzIKTRCQcdU6THjr9a1gnENlS/u7ViNbUFIew4aFVvvgRebPo/8
	 6L/yAKfjRaznqp2Dv5ul2Dx8sRMtciTjw5teW2/QRbZ5gFkb3xsFVAAUFSDwu4A+El
	 CYxbKNKpdOE9CKWc7SBFxeGOGA8lOp71k7LUfkJ1yxBD2Ub69bvGudW+BEOzO8N+lF
	 4hkdpe4nKDsa7mmtXBN5wVzKbfSBt+o88z5JQ69nx5WEwAIAFnXhXd+SwmQlA+xYnY
	 pOsBVCJYEW3VQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 30E39C41671;
	Wed,  6 Dec 2023 03:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: veth: fix packet segmentation in
 veth_convert_skb_to_xdp_buff
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170183342418.17091.108615054025738723.git-patchwork-notify@kernel.org>
Date: Wed, 06 Dec 2023 03:30:24 +0000
References: <eddfe549e7e626870071930964ac3c38a1dc8068.1701702000.git.lorenzo@kernel.org>
In-Reply-To: <eddfe549e7e626870071930964ac3c38a1dc8068.1701702000.git.lorenzo@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, lorenzo.bianconi@redhat.com,
 linyunsheng@huawei.com, alexander.duyck@gmail.com,
 aleksander.lobakin@intel.com, liangchen.linux@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  4 Dec 2023 16:01:48 +0100 you wrote:
> Based on the previous allocated packet, page_offset can be not null
> in veth_convert_skb_to_xdp_buff routine.
> Take into account page fragment offset during the skb paged area copy
> in veth_convert_skb_to_xdp_buff().
> 
> Fixes: 2d0de67da51a ("net: veth: use newly added page pool API for veth with xdp")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] net: veth: fix packet segmentation in veth_convert_skb_to_xdp_buff
    https://git.kernel.org/netdev/net/c/a61f46e11025

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



