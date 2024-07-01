Return-Path: <netdev+bounces-108072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95B891DC4A
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 12:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065601C202CA
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 10:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF36A148841;
	Mon,  1 Jul 2024 10:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opFzXCl9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA37D146017
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 10:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829257; cv=none; b=eSKE3NbWy0LVcLJVOmTC7kRomlR3bw1Ax3Qu84zV6ZplDaXVj0pOrl8+TYUrlRLpYhCNa+qfNKITaqDKt8VJ2Jr5ygR9wEFopZnt/gMXhuCxA6zjfw7OWUNAI7FFGsQ68MVP9CyeXV3llTGw+NHBc0oZY3bRM7L9EnnY4mihJyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829257; c=relaxed/simple;
	bh=u+dEoUpNOrlWknRegXxYa5aoHBwDPNM0KwKjpwfoozo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IfCl/uExiFXOeYHy5NLvzoToTVSfOtvz/SzJqPspmo8rKeyjEvntyDLt6c681HS3SJzhn8SDbPW7jI6+QTofHr/+Cl4ONBeXIEREm7/3QCImJ2J92HkQjUxixtobnVYnbMMrqxcxWjo4S+jYd+kbS1ZR1MtAEE/FNCf3Pahowt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opFzXCl9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56804C4AF0C;
	Mon,  1 Jul 2024 10:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719829257;
	bh=u+dEoUpNOrlWknRegXxYa5aoHBwDPNM0KwKjpwfoozo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=opFzXCl97gART6TBDLBhzAX6VNpii6073xEiNuI3abUv3m+dRnLRPppxkCQ98vHZ4
	 yHmBDfCKIZLKZGzbUN/h19snMv4EXowSFj4L/vfvjLgHYCMJJeLiHJzxFo8uphYPpG
	 TBYAeOm3I7dp4/zFcN1mDwvoivIxCZG0x+SusRwXboWJwGg0ACED8SnWqnrb02oAJD
	 5ZnPNMU4d18X5TkonfBTeUDYJWKnptdrH1imtrFwotW90dK9OhkQJVWrOAPh1t+LZe
	 JcxG2B8RR7ZL7P6miN+s+dpshHtmODzMEqGiKjehqOJ30xHWjnOTHK6fEbPrgrvDgu
	 xWmzkyz5E4S9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4BBB6DE8E0D;
	Mon,  1 Jul 2024 10:20:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: tn40xx: add initial ethtool_ops support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171982925730.8939.15623191345331098821.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jul 2024 10:20:57 +0000
References: <20240628134116.120209-1-fujita.tomonori@gmail.com>
In-Reply-To: <20240628134116.120209-1-fujita.tomonori@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, linux@armlinux.org.uk

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 28 Jun 2024 22:41:16 +0900 you wrote:
> Call phylink_ethtool_ksettings_get() for get_link_ksettings method and
> ethtool_op_get_link() for get_link method.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  drivers/net/ethernet/tehuti/tn40.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> [...]

Here is the summary with links:
  - [net-next] net: tn40xx: add initial ethtool_ops support
    https://git.kernel.org/netdev/net-next/c/7433d034ac3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



