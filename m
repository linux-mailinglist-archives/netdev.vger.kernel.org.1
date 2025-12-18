Return-Path: <netdev+bounces-245394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE52CCCC19
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 17:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CD123023557
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 16:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E4F36C5AF;
	Thu, 18 Dec 2025 16:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISjU+vSa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C2336C5AC;
	Thu, 18 Dec 2025 16:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766074401; cv=none; b=Yi2nt1P6gr9alT7nfCVcdVs9fQiQayq2qEeg2dLCIVNrRxiSGKY+WSmbitqrFJT0YGFQY17SaFdVJKLl75SKkYy17zA9H484FjsyBp8NmV3gibgot5XHdOkRVVIsv+/AzQiZ81HOjyxUXEgJUnlnOkKbOUa/krX0mYVtCl2Mqu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766074401; c=relaxed/simple;
	bh=0uIESzmka6iQyICEUX1VBrTKwbnGboNXhAz9YoubZV4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZNVc8OqvrfQ+y4tb1NJh8UpZLoyT8LOKPT4oU9VfKUS7TaTAAgFI2l+VEjCndgXV3T7bcu9i4ks1hzFC9TYo6p8gX20ys78OWy/H+fTW1zUZFGuNBxaqhsKjM7kLgWiVQjcCFceFnQkHPssFy9gL/zpy+jFaHuGGVfPALeTQ8sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISjU+vSa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30034C4CEFB;
	Thu, 18 Dec 2025 16:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766074401;
	bh=0uIESzmka6iQyICEUX1VBrTKwbnGboNXhAz9YoubZV4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ISjU+vSaVPlSK8cA76d5pfw2Hv5mG26MXQE/HmPIjNkrosv6HJ6PAqg5lkUYz6B9+
	 A0jSD8Lwo4BPQFDo2w+wttQoVi13gQ7u+UW54/b8+4yVsGQNx5AXMgjcNxAaGwL01f
	 TCyZSN9FV0cp+8ZHHb22bQiQGeYlXgBaLa/vPzHUm6Wc7Gx/nuI3GeMhYqiNwZ2U/1
	 RqJM9Wuxl7boHJJHcsZ3nquBlrhF7nGTCzNGbKyejDQOv/WXK980Eicg3Q4bLDixgk
	 OY9+tooAcPBCbvM3Eods+5e6V9nmzVUMvaqdFB0ig2eeYdLMKbrvkVaAqB4yK8r8nB
	 16/iC84kU2ApQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B6349380A96A;
	Thu, 18 Dec 2025 16:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 net 0/3] There are some bugfix for the HNS3 ethernet
 driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176607421054.3030280.2567425407708248921.git-patchwork-notify@kernel.org>
Date: Thu, 18 Dec 2025 16:10:10 +0000
References: <20251211023737.2327018-1-shaojijie@huawei.com>
In-Reply-To: <20251211023737.2327018-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shenjian15@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 lantao5@huawei.com, huangdonghua3@h-partners.com,
 yangshuaisong@h-partners.com, jonathan.cameron@huawei.com,
 salil.mehta@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 11 Dec 2025 10:37:34 +0800 you wrote:
> There are some bugfix for the HNS3 ethernet driver
> 
> Jian Shen (3):
>   net: hns3: using the num_tqps in the vf driver to apply for resources
>   net: hns3: using the num_tqps to check whether tqp_index is out of
>     range when vf get ring info from mbx
>   net: hns3: add VLAN id validation before using
> 
> [...]

Here is the summary with links:
  - [V2,net,1/3] net: hns3: using the num_tqps in the vf driver to apply for resources
    https://git.kernel.org/netdev/net/c/c2a16269742e
  - [V2,net,2/3] net: hns3: using the num_tqps to check whether tqp_index is out of range when vf get ring info from mbx
    https://git.kernel.org/netdev/net/c/d180c11aa8a6
  - [V2,net,3/3] net: hns3: add VLAN id validation before using
    https://git.kernel.org/netdev/net/c/6ef935e65902

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



