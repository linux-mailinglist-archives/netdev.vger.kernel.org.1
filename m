Return-Path: <netdev+bounces-43769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A857D4ADD
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 10:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DB4EB20C5E
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 08:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35E714F77;
	Tue, 24 Oct 2023 08:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZYB6nuc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFBD2F5B
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 08:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EDD81C433C8;
	Tue, 24 Oct 2023 08:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698137424;
	bh=j4HL2aupPBACZEv/S/x7M5eQl4uU26MAymTGtHLc+8A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NZYB6nucGCi3fCtKKh33IznbS2fs8ZV6bEXn3gtMPo+Qo/R68YHP2lhyl1gUNAr+F
	 mlf3yfXP0VHhNryLhc0LmFqZ84n5JjWnjX5g30TS9TIWlcvAm0tbJXaei7pKlks6H6
	 K9/OP6EY1EwId2LOhEicGkORn/gStS+iuK/TU/6MNxOiVH+4U4AuRGm021zH36ogF2
	 fPpuIdVNNd9frixcJawjNhA6B6PK7/6Kl4L7tK5dzGeseH2ZJD35mlW8WmVV5QliMa
	 G5yfIcx5mpp772jLXYkhS8DxcWQGy8/RdxjWUehhr+GJEXiO2YOZ+W2wFwI/Lq5WA+
	 rwC5P0EJhJsdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8BC3C41620;
	Tue, 24 Oct 2023 08:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 1/3] sock: Code cleanup on __sk_mem_raise_allocated()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169813742388.16775.7785724351431638461.git-patchwork-notify@kernel.org>
Date: Tue, 24 Oct 2023 08:50:23 +0000
References: <20231019120026.42215-1-wuyun.abel@bytedance.com>
In-Reply-To: <20231019120026.42215-1-wuyun.abel@bytedance.com>
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shakeelb@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 19 Oct 2023 20:00:24 +0800 you wrote:
> Code cleanup for both better simplicity and readability.
> No functional change intended.
> 
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> Acked-by: Shakeel Butt <shakeelb@google.com>
> ---
>  net/core/sock.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)

Here is the summary with links:
  - [net,v3,1/3] sock: Code cleanup on __sk_mem_raise_allocated()
    https://git.kernel.org/netdev/net-next/c/2def8ff3fdb6
  - [net,v3,2/3] sock: Doc behaviors for pressure heurisitics
    https://git.kernel.org/netdev/net-next/c/2e12072c67b5
  - [net,v3,3/3] sock: Ignore memcg pressure heuristics when raising allocated
    https://git.kernel.org/netdev/net-next/c/66e6369e312d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



