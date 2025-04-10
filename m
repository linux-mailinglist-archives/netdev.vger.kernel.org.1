Return-Path: <netdev+bounces-181032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAADA83680
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 04:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D14B8443465
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 02:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E961D2F53;
	Thu, 10 Apr 2025 02:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkMau/40"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCB31A2390;
	Thu, 10 Apr 2025 02:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744252196; cv=none; b=udtEs+jXs8dc1QuXU565Lq+lxKYbBonGf92ZhVllrPnoZeACShgRWzy1fM34Ul6Ce3lWzH3jv0N4A1K5OYEhqDIwiNjHg+pKsUmdCcT0a36X7QzECA7KosxQMBR9lFNu+wOSdENq8hOrUpx5bBnQz1QDrLKik3yobQxdkV0vNDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744252196; c=relaxed/simple;
	bh=E7Des7EK+sUgtkY+WWs2fRdo6Bd/TmZZDDYF1r+l6Bk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uu16V3PkGuDADFjwojPxplbTMqHzdwFnPP23ccjNPmpFQWQb9VVJ+ydhdepi/rdXg84DRLFK4hHVmbrVxy+sgjwuzCIs8En/368xhA+GLmCN9Fr5CfQCRU9NAZD0QzlN+6WRtuaLCnySEozVB/pp6lODnrAVXJilb/V2dr/LM/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkMau/40; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45822C4CEE2;
	Thu, 10 Apr 2025 02:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744252196;
	bh=E7Des7EK+sUgtkY+WWs2fRdo6Bd/TmZZDDYF1r+l6Bk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PkMau/40iG7yghU/12Wz+qD1NdYequg4GpOWJX2XoM9VW32GB2fhJZVeasFTZFPuU
	 XUwAyZ5WnChtpQY6XUjb8gTlyKEKoD4xCG4dQg0VUy1WUL8Z6fiDQGLIoB1qAO5c7Q
	 VcYm163376I29iejxAYjVuU+yKrEtm08M8YLl7hEFuOT6Ipg2FshA7Hmw2+G/yJUF/
	 ZCMHY/4jhTlH2FsJ2C4ueEsPwvUZh5xuFABJdPvA/Eaq+uwvABhJPv2C0gA21P21J3
	 MrY4Vk7FWcF+YPIsKpeWNJ1LJVsd9XMqiyGB6AiOemvUHKWFr+thFgXpHI4TXF4Jeb
	 0uKJNSN2UiWjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB23438111DC;
	Thu, 10 Apr 2025 02:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] bridge: Prevent unicast ARP/NS packets from
 being suppressed by bridge
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174425223377.3120264.13308441300773749640.git-patchwork-notify@kernel.org>
Date: Thu, 10 Apr 2025 02:30:33 +0000
References: <cover.1744123493.git.petrm@nvidia.com>
In-Reply-To: <cover.1744123493.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 razor@blackwall.org, idosch@nvidia.com, bridge@lists.linux.dev,
 mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 8 Apr 2025 17:40:22 +0200 you wrote:
> From: Amit Cohen <amcohen@nvidia.com>
> 
> Currently, unicast ARP requests/NS packets are replied by bridge when
> suppression is enabled, then they are also forwarded, which results two
> replicas of ARP reply/NA - one from the bridge and second from the target.
> 
> The purpose of ARP/ND suppression is to reduce flooding in the broadcast
> domain, which is not relevant for unicast packets. In addition, the use
> case of unicast ARP/NS is to poll a specific host, so it does not make
> sense to have the switch answer on behalf of the host.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: bridge: Prevent unicast ARP/NS packets from being suppressed by bridge
    https://git.kernel.org/netdev/net-next/c/827b2ac8e796
  - [net-next,2/2] selftests: test_bridge_neigh_suppress: Test unicast ARP/NS with suppression
    https://git.kernel.org/netdev/net-next/c/0ffb594212a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



