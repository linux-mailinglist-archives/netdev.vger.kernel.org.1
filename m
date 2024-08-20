Return-Path: <netdev+bounces-120355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CEF959081
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 00:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 325D2282AFA
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 22:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964431C8FB9;
	Tue, 20 Aug 2024 22:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtgSlBOm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BF91C8FB5
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 22:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724193037; cv=none; b=LpdN7MyKdXPJsXe8Mi3r+3nGty5lwGKlHszKfu/gv4EPwCTuvEtUo4tOW7WvInuGMTgN0FXkXeqLCacDTg8CNPZe63oaT0tScJQpvBR1aZyd71sFGtvPraO3Hp4yJV8+azAaIaKAfyDwJOCeFkYyzhWbsY2uQ+n48lV7smKq9gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724193037; c=relaxed/simple;
	bh=oLK3n+7uCUc8HNV7xTGj3a3ta0ydMMW6c58ZOQSqHc4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cAUR3gQp8aqrALAToxJjiyVweYZDOAWi71a3YMQqyEZjukxJK0IY8O6Rhv3xGMtMG2B59+cU5e5ghrGp1Z2Zu6SwAs7KWrbBS7O8n2jrLEaLC7SCYVN7jNBY8L57MzmUT9NOmrA/hAI9HnmEGlHm5v9g4jysClNVgRhmGiN8AB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtgSlBOm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEED3C4AF17;
	Tue, 20 Aug 2024 22:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724193035;
	bh=oLK3n+7uCUc8HNV7xTGj3a3ta0ydMMW6c58ZOQSqHc4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gtgSlBOmzJ0cZzG/UVJufeMMAABQzrQEJbeP0gU2QiuA5NV0007yV/6TaP+bMdOx3
	 7BpAZdKfbs2p/GxFWddJTWSAsAxmS59JRsJHJrSzyaGvVMOV25dLHnyZKWs81Axke2
	 76MO0ntI6xJiwcryxB6+mCQjRAKoR5zvFG5HDZChDrcYXebLP1Ma22LwaAzb1C+c9Y
	 YHxkGq+isa9gEuQrMyv2WF8SE1OsToL8niz7xAVo+/R/TGZkWR7Sqny2Vz/UCIp5cN
	 qO4He63GwyQTL/Xk9/1tBbH5JI7jMatJ0CxG3oECu85Y0+NMKOGKK0cRRICZIpYpgB
	 hc13iAovypjag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EFD3804CAE;
	Tue, 20 Aug 2024 22:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: hns3: Use ARRAY_SIZE() to improve readability
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172419303525.1256151.7065471894964139061.git-patchwork-notify@kernel.org>
Date: Tue, 20 Aug 2024 22:30:35 +0000
References: <20240818052518.45489-1-zhangzekun11@huawei.com>
In-Reply-To: <20240818052518.45489-1-zhangzekun11@huawei.com>
To: Zhang Zekun <zhangzekun11@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, shaojijie@huawei.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 18 Aug 2024 13:25:18 +0800 you wrote:
> There is a helper function ARRAY_SIZE() to help calculating the
> u32 array size, and we don't need to do it mannually. So, let's
> use ARRAY_SIZE() to calculate the array size, and improve the code
> readability.
> 
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: hns3: Use ARRAY_SIZE() to improve readability
    https://git.kernel.org/netdev/net-next/c/2cbece60a4af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



