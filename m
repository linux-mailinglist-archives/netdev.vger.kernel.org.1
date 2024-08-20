Return-Path: <netdev+bounces-120173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8122C9587C2
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 15:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B49041C21186
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 13:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4F418FDC5;
	Tue, 20 Aug 2024 13:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWxSGpbn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E7C18E77B
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 13:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724160065; cv=none; b=gx72fI2LZWArLJXKJnm/ykrEyS1fvyPorH8DaJTuZsdYjrfyi9rGJg8F9joz/XJ3nzwl/zSfus62faBubny/XTqxYMAsfWRW3zpEKQAP77/n5xXjmEuqbsBPZVkRbqA+Ko5hVz9X1InloDhM8wHgf4lwvFFAGC5KBU2AgsnnTE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724160065; c=relaxed/simple;
	bh=iyjPkgjTDKcIMoA6X5Mi7CYtCCMI1T7GBFJKy5b1+T4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kHPnLfTlXSicyz++ymiGK+BM/1HOTsPWnJYPWSDZSHWoZvbRmXzqmGHRveWmjbZxpTezdD8HXGaeirQKS8brOpaXJgDRiZymv9SzV9FMoRwVi3OHjShv7jXqd21Oi7Tmcw+afuxhqhuAXr1QHmahP029lfJ3RNXp9y3C5SeVo+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWxSGpbn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B243C4AF12;
	Tue, 20 Aug 2024 13:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724160065;
	bh=iyjPkgjTDKcIMoA6X5Mi7CYtCCMI1T7GBFJKy5b1+T4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UWxSGpbnTu55v1bP0M7N37eWPgRUm/zQYVEMU/gwKAYdtt3oYY4FJ2YSJKQpBKE5c
	 Z9ctrdVoHZQJGDi9xWI9Fo7AcTba7MQPVgKJ5qPXygpVMwx6Epwg2ceqRNy3W+45FU
	 AspsoAlCLO7R6XEODNlAXILO+2B44NBDoK5h16qYwvKEfY1+TU5oteQVab3H5KI60p
	 SYv3JEF9PkSE6MxbPmAb0a2Uzk2myzGshg7SKs7ZvbaGQ+8EpSRkeBANXdWXMDwt5E
	 P/ykwcTnDfkFVyF+STKkOBFzxKZomjhxObmx5p2Ric9K35E71lss9yMIWVohMWyqZ3
	 XlcWSk6aou1RQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF8D3804CA6;
	Tue, 20 Aug 2024 13:21:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ethernet: ibm: Simpify code with
 for_each_child_of_node()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172416006476.1138694.15089223949781964403.git-patchwork-notify@kernel.org>
Date: Tue, 20 Aug 2024 13:21:04 +0000
References: <20240816015837.109627-1-zhangzekun11@huawei.com>
In-Reply-To: <20240816015837.109627-1-zhangzekun11@huawei.com>
To: Zhang Zekun <zhangzekun11@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mkl@pengutronix.de, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 16 Aug 2024 09:58:37 +0800 you wrote:
> for_each_child_of_node can help to iterate through the device_node,
> and we don't need to use while loop. No functional change with this
> conversion.
> 
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
> ---
>  drivers/net/ethernet/ibm/ehea/ehea_main.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Here is the summary with links:
  - net: ethernet: ibm: Simpify code with for_each_child_of_node()
    https://git.kernel.org/netdev/net-next/c/797653865b98

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



