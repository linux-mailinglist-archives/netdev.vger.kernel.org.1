Return-Path: <netdev+bounces-18599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62004757D2F
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 15:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BF241C20C4C
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 13:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CE6D2EF;
	Tue, 18 Jul 2023 13:20:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A86CC2F3
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 13:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8DD6EC433C8;
	Tue, 18 Jul 2023 13:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689686419;
	bh=esPAIdLijgrpckijkuN7a0s8e5HfXIfXq/YXmb2ssMs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LzC7J1UsKlB84p2dB3juxMvyatRNE+OoxqNhUZwNY+PY1IyzxDXC9ve8aTm6QcSMe
	 hV0lUy0UJMV66SHF9xH8Ujz4m5wZRaK3LNFuhLyYSci7EYzCrQ4cF3aWC2KA7qNiU+
	 x8n1wHFbfCkPHPYqzjVM5OHhz36pGHItlEZ3CFsenPaVlotxaFVFg+J9qWld30h+cG
	 D0qLRHW9nMywPqir7hPy4WRyuvohhhaHU+XJSDNgM6nMkctuOZaB/CokF9pXB8mLhP
	 nvdgW+Hl2I+ZjJzCE1oM7QZw6jDqvMKmCtW9CuOnxhOX23pmhA3QNAn1gmYbdaz1Xn
	 CPe3xvHyJyTKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6698AE22AE4;
	Tue, 18 Jul 2023 13:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] rtnetlink: Move nesting cancellation rollback to
 proper function
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168968641941.29657.11670688122269581626.git-patchwork-notify@kernel.org>
Date: Tue, 18 Jul 2023 13:20:19 +0000
References: <20230716072440.2372567-1-gal@nvidia.com>
In-Reply-To: <20230716072440.2372567-1-gal@nvidia.com>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, edumazet@google.com, simon.horman@corigine.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 16 Jul 2023 10:24:40 +0300 you wrote:
> Make rtnl_fill_vf() cancel the vfinfo attribute on error instead of the
> inner rtnl_fill_vfinfo(), as it is the function that starts it.
> 
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> ---
> Changelog -
> v1->v2: https://lore.kernel.org/all/20230713141652.2288309-1-gal@nvidia.com/
> * Remove unused vfinfo parameter (Simon)
> 
> [...]

Here is the summary with links:
  - [net-next,v2] rtnetlink: Move nesting cancellation rollback to proper function
    https://git.kernel.org/netdev/net-next/c/4a59cdfd6699

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



