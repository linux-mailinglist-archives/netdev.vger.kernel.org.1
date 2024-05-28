Return-Path: <netdev+bounces-98350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 126528D10AE
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 02:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3140A1C21983
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 00:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D472D4AEF6;
	Tue, 28 May 2024 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpSdIvO5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6109A954;
	Tue, 28 May 2024 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716854430; cv=none; b=qUU5j6oH+qcyuxNwr9K5M109Zv0TlDR8UVT4dEugUBXR4IDOXylf9BVdN/TJLgtwe2lNH5OtSZezH1h+h3cSDJK6TxTVvZsoLgRuoiwldRoUIddfEV+ipm+ofp7slLkJOsU6F9U+iY2aD4s4q/2DvmGKLuBW8La0jlFSj8TlrAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716854430; c=relaxed/simple;
	bh=TkeI3JIJvfkemQRWIxPmdnV4KioeLN3NQXGMEsBVYeQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t+X90RK2Ix2+iZ4Ngt6MIgQ9SrD5GfapY+0jEjMVJwgtJu+aaioveQxBorrAXmopsySgENUT1RYEyJAoSalHn9wgAlkn45LqaKCS6JUN2YkDijkqsllCB69YU7gNCqOdR6GWoy3KHdmozWn0/+aT4JbxwrDpLbQPNP/KuMeAHpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpSdIvO5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B2E6C32781;
	Tue, 28 May 2024 00:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716854430;
	bh=TkeI3JIJvfkemQRWIxPmdnV4KioeLN3NQXGMEsBVYeQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QpSdIvO5hMryeB7v7ObpsjZfQwaaq7OESGD38UMfYq7UFf/CjqnUCXqLOAcAecDqL
	 4+ZBWyrKE0lMWzDAH9XH21kCUUa/bxJWXJtMDjCG5DM80sVJDRgNduo/yTkiOMPPkX
	 j8Khtsi053UmhU0pzg7/2GAlSrI6LpUJMYzKHSRAzSx4moCroQA9XEnen85XEPrOWx
	 ZRbTXXR9KdZZaNKXtCezHZz5i08vLspKSAhzcUOQJbFJOt1+OkaXJ4Lz9rArwYJcAA
	 wvvW4RenAzqHhPXkCE7IhUSnj7X0ZrL6NnE/V5P/Nkj7LJ+ysk4N5aeI+lafQUhFu2
	 XMI+BN86AU9dg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A16DD40192;
	Tue, 28 May 2024 00:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net v3 PATCH] net:fec: Add fec_enet_deinit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171685443016.27081.2425155450906733033.git-patchwork-notify@kernel.org>
Date: Tue, 28 May 2024 00:00:30 +0000
References: <20240524050528.4115581-1-xiaolei.wang@windriver.com>
In-Reply-To: <20240524050528.4115581-1-xiaolei.wang@windriver.com>
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: wei.fang@nxp.com, andrew@lunn.ch, shenwei.wang@nxp.com,
 xiaoning.wang@nxp.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 24 May 2024 13:05:28 +0800 you wrote:
> When fec_probe() fails or fec_drv_remove() needs to release the
> fec queue and remove a NAPI context, therefore add a function
> corresponding to fec_enet_init() and call fec_enet_deinit() which
> does the opposite to release memory and remove a NAPI context.
> 
> Fixes: 59d0f7465644 ("net: fec: init multi queue date structure")
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> Reviewed-by: Wei Fang <wei.fang@nxp.com>
> 
> [...]

Here is the summary with links:
  - [net,v3] net:fec: Add fec_enet_deinit()
    https://git.kernel.org/netdev/net/c/bf0497f53c85

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



