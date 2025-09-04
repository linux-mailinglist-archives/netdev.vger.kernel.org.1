Return-Path: <netdev+bounces-219969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 902EBB43F69
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 16:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FC297C5394
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 14:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9494330E0FB;
	Thu,  4 Sep 2025 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xqsd7H0V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712E430DEC0
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996826; cv=none; b=Ari6sg/F0LtgAw72aB1GVOvPJJVq7H6HBZaCJXJPCWfE16daMj49YWxsm28F4EupSK/XUPDvVd7TL/IUdgEyUr5EFsBpBLfE9SBK8YFlk+mwqK8Nd7GgUwOFaLB9BYDK0H6Mdw+J4BGmQvVL/RedNuKHUtOoXxl9I9yqTSAH1ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996826; c=relaxed/simple;
	bh=bqfLUNWL1vkzr9iRKc+51tzumv+4NjiT4OVtePVt2XE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ven5awn12nPBux5Nl2BgC2xX/f+q+3ti3KLKSTQEg9Jao+Lv8CkrlHbf0ilEsRjCANkse53Tl3CRX+PhS3sqEEw1mihAieihfIvjfSJUPdWqaCe0t0mLdHkC2PAo1GtbJ2Yu+7Qt59YmUgd0/P597iH9CXN645DDp2Nr9rv032k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xqsd7H0V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5BC2C4CEF0;
	Thu,  4 Sep 2025 14:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756996825;
	bh=bqfLUNWL1vkzr9iRKc+51tzumv+4NjiT4OVtePVt2XE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xqsd7H0VTcnPw+HsCB1kcDumHyu7wJ/eYj+V7oEZNU/z5H/bhPuFpkpneN4XyNGAv
	 63HVU24NQgansvivppTo11MU0w33uSxd6vwShoMuutQZtH6sSkKHXNT8pm9xrtSkDO
	 gbHkU09wza6Kf12pmtNM6LLYaawoP6c/2PP1WfmsdsVcjL1uqRpMQdILVjOd91C1y7
	 xmWzXJH8C2oSs2cB7TMqutxyVMNmyfPh8SBKnAckQRbI3miqwed1ewPYt0MAQko00N
	 Qht9vobZ9lPZ6RzX9F8CqPrPuWJm8AyPoiC+JUMvnxfwzI5zSIY7fkHnCfEjVZYBvb
	 NM5dbW9czMu/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB80F383BF69;
	Thu,  4 Sep 2025 14:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] gve: update MAINTAINERS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175699683074.1834386.65562113882261334.git-patchwork-notify@kernel.org>
Date: Thu, 04 Sep 2025 14:40:30 +0000
References: <20250903175649.23246-1-jeroendb@google.com>
In-Reply-To: <20250903175649.23246-1-jeroendb@google.com>
To: Jeroen de Borst <jeroendb@google.com>
Cc: netdev@vger.kernel.org, hramamurthy@google.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, willemb@google.com, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Sep 2025 10:56:49 -0700 you wrote:
> Jeroen is leaving Google and Josh is taking his place as a maintainer.
> 
> Signed-off-by: Jeroen de Borst <jeroendb@google.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net] gve: update MAINTAINERS
    https://git.kernel.org/netdev/net/c/b1ab3b029ff1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



