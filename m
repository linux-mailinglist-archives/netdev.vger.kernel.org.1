Return-Path: <netdev+bounces-123449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C848D964E50
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 21:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA0C1F227C1
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 19:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928B11B9B40;
	Thu, 29 Aug 2024 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqJIbhJl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8AF1B9B36
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724958028; cv=none; b=ouALvpinvXU4AtNn46LH1LU5NtlfI/XejI/oCRBWYPzcb2YDLh1wlD1Mq2xlXKxupuITAexTmIQKIPYmzXehKnaRDZfLorsbY78Y+gfS/ufAC474/lEcj8U18W4TsRnLAIRAJGJL+YfygkHM+fo8OivcyjgK9O+nLA0wb0vnyq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724958028; c=relaxed/simple;
	bh=3/N7iqo0WxsNYFAaGLtuFo7fvnmRn+R+gUqg+J/QYnc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uJO9/U6U1KsJM5UK+o1dFkPN6GcXKeXZTrqT5MV1TAKEHOZQTbfZIb1GMTzEe9knUSUhyZlZ4IsW8XgX3acrwMaeY9VwptQDKfWn+gTLwq/fJwgXTo1zvcGJpv6fcwNuUmMV5NZwm++/ERM5vxjLLlTBc90MUZfzIRkt/YOIUmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqJIbhJl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5A2C4CEC6;
	Thu, 29 Aug 2024 19:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724958028;
	bh=3/N7iqo0WxsNYFAaGLtuFo7fvnmRn+R+gUqg+J/QYnc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JqJIbhJlFWKGjx6sCuWLQPt+behH4+pcmT2RJJfocLq6+I0ztFux1zwdWRGnVsYpz
	 /8SFOAIMRKWsIOLgnKoSxfOMRfUT9/DZi5QMLV9/CNY6gcSy+mS0Bnd3DKx8atlyuZ
	 FRzuSVUTGpEanIal0S3TAcIIxKOKtVKYJy+PZRhzDh2OuTllVfc9e5bKmMG8kfU2Aa
	 eoWhXXX86WJLKWt0CPFmo81o9v7EpyNJu/5Alhu9ODrFg4lZDJ4zV9Wcrqjz3oBwFm
	 UTlkHsWB7f28u4abOai+2GoeWIF+krQ+YnQ5E2BGy1FQJ6xJvDOnVkv76SbWIl1nbf
	 8aa8UdHFmOX/g==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E3AB3822FEC;
	Thu, 29 Aug 2024 19:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ipa: make use of dev_err_cast_probe()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172495802937.2053394.10084182758728825689.git-patchwork-notify@kernel.org>
Date: Thu, 29 Aug 2024 19:00:29 +0000
References: <20240828121551.3696520-1-lihongbo22@huawei.com>
In-Reply-To: <20240828121551.3696520-1-lihongbo22@huawei.com>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: elder@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 28 Aug 2024 20:15:51 +0800 you wrote:
> Using dev_err_cast_probe() to simplify the code.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>  drivers/net/ipa/ipa_power.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [net-next] net: ipa: make use of dev_err_cast_probe()
    https://git.kernel.org/netdev/net-next/c/a41de3b12ec1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



