Return-Path: <netdev+bounces-41849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2CE7CC0D2
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 12:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 547391F22D2F
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 10:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE38F1A584;
	Tue, 17 Oct 2023 10:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ss2REQ1S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC4841754
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 10:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4340AC433C7;
	Tue, 17 Oct 2023 10:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697539222;
	bh=u8k8pmN/h4vs1rmhF6Yk6yFwZY/0y50KVMEX3zDUuco=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ss2REQ1SRYDgjMw+ZVxUoPm0aFUeGEJgKAhVnr22grQeTi/1c8RvdypivChQsaM6n
	 unna6w1tYErGy/XIvTK65ChZZI7vToU02hEMX/xYhls6Ul06YLVZhoVvtB1+37KTFC
	 1JPqhjO0i+SHMpwSM7javzw7JhIzrKy3+QU3Hba0ylJNzVM+jfQ8zJa0wPaNVyi9Ri
	 9OmHXSNI9auCvpFwBwXbVdydmT1TphQADjpC1nAzkNeZZic/q4EHtKNjOl9LoiLeON
	 AT0OcbP7Nkz2+ht4FRizIBkndP8102mb2QttRTiNkK0J5XVIp8uU7UljvcvLNQoopN
	 XYXrgnnDyAo5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A320C04E24;
	Tue, 17 Oct 2023 10:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: gso_test: release each segment individually
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169753922216.12508.1269731123856685030.git-patchwork-notify@kernel.org>
Date: Tue, 17 Oct 2023 10:40:22 +0000
References: <20231012120240.10447-1-fw@strlen.de>
In-Reply-To: <20231012120240.10447-1-fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 12 Oct 2023 14:02:37 +0200 you wrote:
> consume_skb() doesn't walk the segment list, so segments other than
> the first are leaked.
> 
> Move this skb_consume call into the loop.
> 
> Cc: Willem de Bruijn <willemb@google.com>
> Fixes: b3098d32ed6e ("net: add skb_segment kunit test")
> Signed-off-by: Florian Westphal <fw@strlen.de>
> 
> [...]

Here is the summary with links:
  - [net-next] net: gso_test: release each segment individually
    https://git.kernel.org/netdev/net-next/c/1b2d3b45c194

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



