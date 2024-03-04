Return-Path: <netdev+bounces-77027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5416586FDD5
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 10:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDD32282D58
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 09:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC75224DB;
	Mon,  4 Mar 2024 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDnly2/D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6B4224D5
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709545229; cv=none; b=Zq7HawErNZ2yLSg9bK33pwzBzIVgqaOusJ7NOJ2vbWAPnbyK6OHBz2Kzgk44UUJv2yPy0fM0B+rYPys3rP2OLqnPOppJozy9+MjNSdKASmu8tZMqdfVIgDYNMDB5VjY3fqwxVYHA9SaBFjSDfKc1UJ+qWRQAjPHCl/tfHTPzjtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709545229; c=relaxed/simple;
	bh=1bRgjt1ewTvB4EIAc3Uoj/owx1o27WbtIqxTLeyvjpk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jtvww2HK0M2c0ldgak1zd2lINEFEEmqCJ7MAQNbk0RDLQj35CN9y6KNa5drg8JVuMn5NwCli1IMbHtjmCoVKiYoTpK8zqR/UzfPy3o+DoLGABathETBONOeuAg9RP9cUdKUUEx9EkIXKurgqj5Yd59DxM1Ou/rR4TfkQTkbb8T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDnly2/D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11731C43394;
	Mon,  4 Mar 2024 09:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709545229;
	bh=1bRgjt1ewTvB4EIAc3Uoj/owx1o27WbtIqxTLeyvjpk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XDnly2/D7GaBuCY3BVE5bReI9G5LUhlgNZ4v/q9iC3sokIRIWhE//tpPqj7SFqnaK
	 gZOW6XuaSySZ+KJ6/tcQ+gV0zjIuRBOQ9td+vrTDPPoo01mY9tV7sGWz/JQ84J99bT
	 IJQsVLJHKWZ7T6VRyZ3PYX8kT4J40sFtBukCe6zbnOzDUfQwz/wnIZQkyy1I0KqgF6
	 EKyM+Nuoz9pp1BAIj8YJww3opBSyEGDy7LiNhLm1jbfyx2sEIqLL7UQuq3PxL8nJhO
	 IUCvZ7qXkdnUFbZq6o+5wuzTzIfXmGEDIszfg6at+mjWyzmOXMKMFGxuN2iL7HWd2S
	 C9yv8Wezp0HPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F35E3D9A4B9;
	Mon,  4 Mar 2024 09:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/12] ionic: code cleanup and performance tuning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170954522899.11015.6841934362857016006.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 09:40:28 +0000
References: <20240229193935.14197-1-shannon.nelson@amd.com>
In-Reply-To: <20240229193935.14197-1-shannon.nelson@amd.com>
To: Nelson@codeaurora.org, Shannon <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, brett.creeley@amd.com,
 drivers@pensando.io

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 29 Feb 2024 11:39:23 -0800 you wrote:
> Brett has been performance testing and code tweaking and has
> come up with several improvements for our fast path operations.
> 
> In a simple single thread / single queue iperf case on a 1500 MTU
> connection we see an improvement from 74.2 to 86.7 Gbits/sec.
> 
> Brett Creeley (10):
>   ionic: Rework Tx start/stop flow
>   ionic: Change default number of descriptors for Tx and Rx
>   ionic: Shorten a Tx hotpath
>   ionic: Make use napi_consume_skb
>   ionic: Clean up BQL logic
>   ionic: Check stop no restart
>   ionic: Pass local netdev instead of referencing struct
>   ionic: change the hwstamp likely check
>   ionic: Use CQE profile for dim
>   ionic: Clean RCT ordering issues
> 
> [...]

Here is the summary with links:
  - [net-next,01/12] ionic: Rework Tx start/stop flow
    https://git.kernel.org/netdev/net-next/c/061b9bedbef1
  - [net-next,02/12] ionic: Change default number of descriptors for Tx and Rx
    https://git.kernel.org/netdev/net-next/c/4d140402c6e8
  - [net-next,03/12] ionic: Shorten a Tx hotpath
    https://git.kernel.org/netdev/net-next/c/97085cda1227
  - [net-next,04/12] ionic: Make use napi_consume_skb
    https://git.kernel.org/netdev/net-next/c/386e69865311
  - [net-next,05/12] ionic: Clean up BQL logic
    https://git.kernel.org/netdev/net-next/c/bc581273fead
  - [net-next,06/12] ionic: Check stop no restart
    https://git.kernel.org/netdev/net-next/c/138506ab249b
  - [net-next,07/12] ionic: Pass local netdev instead of referencing struct
    https://git.kernel.org/netdev/net-next/c/1937b7ab6bd6
  - [net-next,08/12] ionic: reduce the use of netdev
    https://git.kernel.org/netdev/net-next/c/25623ab9cb37
  - [net-next,09/12] ionic: change the hwstamp likely check
    https://git.kernel.org/netdev/net-next/c/b889bfe5bd0c
  - [net-next,10/12] ionic: Use CQE profile for dim
    https://git.kernel.org/netdev/net-next/c/8aacc71399be
  - [net-next,11/12] ionic: Clean RCT ordering issues
    https://git.kernel.org/netdev/net-next/c/bc40b88930bf
  - [net-next,12/12] ionic: change MODULE_AUTHOR to person name
    https://git.kernel.org/netdev/net-next/c/217397da4d52

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



