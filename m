Return-Path: <netdev+bounces-18989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D82CF75942D
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936B92815EF
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0F713AE6;
	Wed, 19 Jul 2023 11:30:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4855512B89
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 11:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE7D8C433CB;
	Wed, 19 Jul 2023 11:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689766221;
	bh=a7KKUkj3eRm9pjZ4FEI858AHV5epeHZPINNPyg0TIZ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DSLnS7Dum21EL6qE0ZVqBYbBjdHpp80V5vjRoihOCG5gwJKdqEIIdgHpX6QSpmruy
	 lBHcjcREXBw4MBv1uH2mAQICreEB2zoihESBA321fVKbqoOj182dCaOsVRH4nGTNfM
	 jJ/edQW545fbtfiDe3mzStB2y8Eu8dycq+iImEWlbDfIHb7LDu9T9Rz3oYB2ndoCAI
	 6TMd3wsLMX2pPCsZkJGl3OHWhu8y3h9uMNa9NADXlHxTdXhkt+rKOPoIyQKzWQoHwh
	 FrnqY8Ueh+bMNDTOqu5OKe99I5F0YwKVdX8KGb88K2fd9V9ACRA3Ouz9cd0GyQTQIk
	 Fe/SQiGHY1XtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CDFE1E21EFF;
	Wed, 19 Jul 2023 11:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/1] net:ipv6: check return value of pskb_trim()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168976622083.17456.694186626107816653.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jul 2023 11:30:20 +0000
References: <20230717144519.21740-1-ruc_gongyuanjun@163.com>
In-Reply-To: <20230717144519.21740-1-ruc_gongyuanjun@163.com>
To: Yuanjun Gong <ruc_gongyuanjun@163.com>
Cc: davem@davemloft.net, dsahern@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 17 Jul 2023 22:45:19 +0800 you wrote:
> goto tx_err if an unexpected result is returned by pskb_tirm()
> in ip6erspan_tunnel_xmit().
> 
> Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
> ---
>  net/ipv6/ip6_gre.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [v2,1/1] net:ipv6: check return value of pskb_trim()
    https://git.kernel.org/netdev/net/c/4258faa130be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



