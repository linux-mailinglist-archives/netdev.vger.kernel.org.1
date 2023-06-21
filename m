Return-Path: <netdev+bounces-12467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8947379D9
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 05:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E33BD2814E7
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 03:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC26BE61;
	Wed, 21 Jun 2023 03:40:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B8C15BE
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 03:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F4F8C433A9;
	Wed, 21 Jun 2023 03:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687318822;
	bh=guk/06o7LZA+5U9RuKFJhdP5CGB0duQTyV9WuylmEWo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qr1TFLJbmpJJtWxnvuXruPzyCx4Ce2I5lKWWvNw7BG+wWuyb1aR3cXLtUc5WzfsPT
	 cEP/PII02CvS1fpdWFLUxe40Bc1P31amWfxIrKC9DZQLB1kLHjsxQALtC45DDPn1GX
	 9tApa+z0Hcz31v3RmjUC+tRTW4+boXZ1tNsUwqQ/xk6rupRFhcJb6OtBdnPXLstRi3
	 gPYP5PxX5nLm3PcQ7VALm+Z+6vzvfL0wWvctfMvI4nmBEAuhyHY4uW0sHQP99biZS7
	 JPooGZEiiAvtBy5w4J+bhgbByWp8SebuRWXO0NeQYi939ARNAXmlr/Nf7jXqvVBmKO
	 A8Qq+zO4CpjjQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 27565C395D9;
	Wed, 21 Jun 2023 03:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] octeontx2-pf: TC flower offload support for rxqueue
 mapping
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168731882215.8371.13113440505535258115.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jun 2023 03:40:22 +0000
References: <20230619060638.1032304-1-rkannoth@marvell.com>
In-Reply-To: <20230619060638.1032304-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sbhatta@marvell.com, gakula@marvell.com,
 schalla@marvell.com, hkelam@marvell.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Jun 2023 11:36:38 +0530 you wrote:
> TC rule support to offload rx queue mapping rules.
> 
> Eg:
>    tc filter add dev eth2 ingress protocol ip flower \
>       dst_ip 192.168.8.100  \
>       action skbedit queue_mapping 4 skip_sw
>       action mirred ingress redirect dev eth5
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-pf: TC flower offload support for rxqueue mapping
    https://git.kernel.org/netdev/net-next/c/365eb32e4b45

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



