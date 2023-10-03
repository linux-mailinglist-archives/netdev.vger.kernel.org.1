Return-Path: <netdev+bounces-37627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D6E7B6617
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 12:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 22ACA281612
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 10:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A96C1C6AD;
	Tue,  3 Oct 2023 10:10:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AED7DF57
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 10:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9DD33C433C8;
	Tue,  3 Oct 2023 10:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696327825;
	bh=uXqJyKIEjoRjDoUyS9dLAC8UnkEHjOxuTUIcvQjD/x0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Gde5yY8GdNxo/cFr8EPOZtRU43fyfBC4BHFflrxiwW0CubZ6hwrL6huhPjjlRvboZ
	 4gxuByUDdNyOcxgE0hRrpciZsHktKTqzVhA9A0QT/TdkttDMSS808iD65A8vzDADrn
	 tqEO2aH7+VaxNjBf4hzavYFEFJK/89NMJi4iAFDN/efiF4HM24wTGNgYJ0zdOSZg3A
	 Vq+a05tFGycY6Jgo9OjQfPE2wbJluxt0x1Aob62CHKB3X8xrLs629PbG2FeH9xVgp+
	 E9/EJMZa1GXqvudVzGl7BnAryi3BTKbCvW4m7koihQQ/25qL+qRfwQv9IAJhrQqONq
	 m/3cN9C/67ihQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 85312E632D1;
	Tue,  3 Oct 2023 10:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv6: mark address parameters of
 udp_tunnel6_xmit_skb() as const
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169632782553.9249.11688827949033557863.git-patchwork-notify@kernel.org>
Date: Tue, 03 Oct 2023 10:10:25 +0000
References: <20230924153014.786962-1-b.galvani@gmail.com>
In-Reply-To: <20230924153014.786962-1-b.galvani@gmail.com>
To: Beniamino Galvani <b.galvani@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, gnault@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 24 Sep 2023 17:30:14 +0200 you wrote:
> The function doesn't modify the addresses passed as input, mark them
> as 'const' to make that clear.
> 
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> ---
>  include/net/udp_tunnel.h  | 5 +++--
>  net/ipv6/ip6_udp_tunnel.c | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [net-next] ipv6: mark address parameters of udp_tunnel6_xmit_skb() as const
    https://git.kernel.org/netdev/net-next/c/f25e621f5d4c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



