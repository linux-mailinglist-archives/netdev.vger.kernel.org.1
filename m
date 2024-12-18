Return-Path: <netdev+bounces-153057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEA99F6AED
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 17:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C5DB7A32B4
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B331F2C4A;
	Wed, 18 Dec 2024 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xbahw0U9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD72D1F191B
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734538815; cv=none; b=lMGKdbkSDTCr0LyPi61pznGl0+2W+1MN2/Vdp9EFatzcyVzJ3EjkCY7UxEpdRyBqvyShH4h65jqqvXWVWO1Hbk8esi3nmZk8H1dbMQEvRSHQLuGT0fIw4HgsxNM3Jv1UKkP9ceRa7GMzSxA+r0QsjTD/CSH504efvh5CO3BtUU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734538815; c=relaxed/simple;
	bh=teYgoloo9Jcf5t6CqZEjcUJfq/7l2HiTyZow5Mv+H4Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HmE5JqVp0ssOb9thszONPnk31QnxlQcpIeNA3oOr5x/ORdOqTmWyQAX9j1Y1DEOtTxNvEmbFlURjoWulA7k8tbwHchzL4bqMdhXkL8LSQc0E7tmN9nDC1SoF8vApVuvddpxhsf7nppgylCpdF0xQE87Hp5jBrCoA2rSB3C0pxfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xbahw0U9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6C9C4CED7;
	Wed, 18 Dec 2024 16:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734538815;
	bh=teYgoloo9Jcf5t6CqZEjcUJfq/7l2HiTyZow5Mv+H4Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xbahw0U9l+8wnW1VRUkKagikb5BSOJEZ/EKo/goQxRIly30Q1Dk1tOVHffMjJz6xU
	 zABeWTt/929E2niU6dHUUiVlOk+sH51fFisF5ck0/m2Uj4uF0RzB/pBaZljEK4U8Ax
	 ZJvZJIywXGuHUjbEl9zXGG/YAusVdzl+gf42k16yfsqUlzz+gOCGbX3JGZEChyk8jT
	 BQcRyXwcICBwcoy9ySF7jTtQj82plIHvb6PYEHHqge5vxIrHOaSr7LBqZJm8BBasWx
	 KNTMfqowlsVr/o4oitcQTyfDmqvWILKdb3jwtHH1dJTSTGkloBE7Zba0M3ZZnQvZ8A
	 6beTbHJEluEAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACA73805DB1;
	Wed, 18 Dec 2024 16:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next, v7] iproute2: add 'ip monitor maddress' support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173453883275.1662908.14154492989231218657.git-patchwork-notify@kernel.org>
Date: Wed, 18 Dec 2024 16:20:32 +0000
References: <20241218150852.185489-1-yuyanghuang@google.com>
In-Reply-To: <20241218150852.185489-1-yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 roopa@cumulusnetworks.com, jiri@resnulli.us, stephen@networkplumber.org,
 jimictw@google.com, prohr@google.com, liuhangbin@gmail.com,
 nicolas.dichtel@6wind.com, andrew@lunn.ch, pruddy@vyatta.att-mail.com,
 netdev@vger.kernel.org, maze@google.com, lorenzo@google.com

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Thu, 19 Dec 2024 00:08:52 +0900 you wrote:
> Enhanced the 'ip monitor' command to track changes in IPv4 and IPv6
> multicast addresses. This update allows the command to listen for
> events related to multicast address additions and deletions by
> registering to the newly introduced RTNLGRP_IPV4_MCADDR and
> RTNLGRP_IPV6_MCADDR netlink groups.
> 
> Here is an example usage:
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v7] iproute2: add 'ip monitor maddress' support
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=19514606dce3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



