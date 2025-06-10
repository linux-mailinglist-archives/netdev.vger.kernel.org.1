Return-Path: <netdev+bounces-196349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE11AD457C
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 00:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D0F917D364
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 22:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA0C29ACD7;
	Tue, 10 Jun 2025 22:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLgPEd6t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4877E29616D
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 22:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749592804; cv=none; b=nViWiTY8B0ZAL5lQa7eHoytCWLEed5I0+UWR9KdTedH8OiMUotlMDnHQHjzOxtAUVSf0PJHF4xeQaY3S7phI4S5tMXYUmoAPOiwgUVRRPk52w/NXWrO6Rny0gjNHs3Ocnbadcnph7XtltlAtgmAonTmUHxEihIcDqoEVwri5slg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749592804; c=relaxed/simple;
	bh=Vwya+ihq2a3w6vCKzcJQ6yS3QFyOcEIyqg4k8rpL/tA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UhJyjREnRxXTILf6LX8xrfcY+h6yNo3jW4PVt/6U2JVOjlpbhrBc8RUFN+fsngSpfM6zKLsU6hEf7kdEETTTsfBSOwt3c4PPmP+4vXeDgJsoW0Mvw0TUpWj70+0dVcb0dw1RYDlmw4fH65tS2rb9yaJM28W9hwJ0xEosL8yKkeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLgPEd6t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC83C4CEED;
	Tue, 10 Jun 2025 22:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749592804;
	bh=Vwya+ihq2a3w6vCKzcJQ6yS3QFyOcEIyqg4k8rpL/tA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pLgPEd6tOWfRZAZwd4g686VsJItm2Twju+sUe6uJ4fvIz4Q8dREwg0Thye4k+EbR2
	 vnJpDsQzHJNmWveAayWO0jRCLe9fNFotS4LBI0ALtCv84e+bk7iUxZLePUqXulk7D4
	 m3oy3uclplTNmPsbzLkcLRX+IDQBDvVTCCNStLabjSrx0BCTWA+F/l/hG+PGYgYIb9
	 DSKRLDa+hXGZXy7QJunWqnL07hJIwUHbHoUuOswBdiX1bNwXZ3F4k7vFNW2Bbhx5mp
	 CiV1+lYv/v4BP4ps67KWAfdPZjamlJehGJ69fjq+LiEEtJS6/Tqs7ohjB3aaFyGFx1
	 TqhI7xjRsq7wA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBC038111E3;
	Tue, 10 Jun 2025 22:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] uapi: in6: restore visibility of most IPv6
 socket
 options
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174959283424.2624817.13317438796223681599.git-patchwork-notify@kernel.org>
Date: Tue, 10 Jun 2025 22:00:34 +0000
References: <20250609143933.1654417-1-kuba@kernel.org>
In-Reply-To: <20250609143933.1654417-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 stephen@networkplumber.org, hannes@stressinduktion.org, willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Jun 2025 07:39:33 -0700 you wrote:
> A decade ago commit 6d08acd2d32e ("in6: fix conflict with glibc")
> hid the definitions of IPV6 options, because GCC was complaining
> about duplicates. The commit did not list the warnings seen, but
> trying to recreate them now I think they are (building iproute2):
> 
> In file included from ./include/uapi/rdma/rdma_user_cm.h:39,
>                  from rdma.h:16,
>                  from res.h:9,
>                  from res-ctx.c:7:
> ../include/uapi/linux/in6.h:171:9: warning: ‘IPV6_ADD_MEMBERSHIP’ redefined
>   171 | #define IPV6_ADD_MEMBERSHIP     20
>       |         ^~~~~~~~~~~~~~~~~~~
> In file included from /usr/include/netinet/in.h:37,
>                  from rdma.h:13:
> /usr/include/bits/in.h:233:10: note: this is the location of the previous definition
>   233 | # define IPV6_ADD_MEMBERSHIP    IPV6_JOIN_GROUP
>       |          ^~~~~~~~~~~~~~~~~~~
> ../include/uapi/linux/in6.h:172:9: warning: ‘IPV6_DROP_MEMBERSHIP’ redefined
>   172 | #define IPV6_DROP_MEMBERSHIP    21
>       |         ^~~~~~~~~~~~~~~~~~~~
> /usr/include/bits/in.h:234:10: note: this is the location of the previous definition
>   234 | # define IPV6_DROP_MEMBERSHIP   IPV6_LEAVE_GROUP
>       |          ^~~~~~~~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - [net-next] uapi: in6: restore visibility of most IPv6 socket options
    https://git.kernel.org/netdev/net-next/c/31557b3487b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



