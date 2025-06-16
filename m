Return-Path: <netdev+bounces-198317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE956ADBD3E
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 00:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF27F3A2DBA
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 22:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1DF225415;
	Mon, 16 Jun 2025 22:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jua0AQ2+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8C01F4701
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 22:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750114206; cv=none; b=IhBX3N9lPMewTgvX1C0utHOn7Zje2Ae9WAWDDCIOAxrmAhsSQc1Av4Ne0CfX4oNBeM/W5zClS9jJX4imUeTq0K4cBNkDIdt9aO8D1eGtRoWeOFhvZzKPozHIyjSAMfSaVhWLNAExhLM4/Blk2OPQ/Wqsq4ABU8yvrr00F7e9Oq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750114206; c=relaxed/simple;
	bh=SmWnRG6eEl7ACoQ9/ExaW5EGqILz5t75lisEa+laksc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u0M2ZkU9HaB8djgnuPZseW3x/rwn+7OxYBFZ4msohz3O5aL3CtAMeMt6zLRM46fRGMJiOG8sicl4YOVKqCVc2HmD4cZPSDrwJDTco8nZNg0nkM3Gaalyzh2qP9cFLbbfJ3iNCOyEXmxTu9S8mt6tzqK4ilmBnHkeA+h4t821w8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jua0AQ2+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B123C4CEEA;
	Mon, 16 Jun 2025 22:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750114205;
	bh=SmWnRG6eEl7ACoQ9/ExaW5EGqILz5t75lisEa+laksc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jua0AQ2+0XGvXUxdc+vtgvBJ8H6ruDQJpXA5qVpP1rLYyxYEYgfA/GaUFpyKNGb3v
	 rs/ktD0lCTXoWojGTJ0YyI6qYrfnsbGl4Hl892ezX/maL99yvl3XFbESXop2obGyn6
	 FWdx82LA55KTNZXbwFqWfd6U2gB0JUK0rpIZhKjqyfjLvDyYgoomnjRxhxiYO2S9Nq
	 IGiSuPmDPPAP+3zuVHbPK3V1urVBI9tgBzA6NJqB6qx4p7L1ZodinKVo0lk0iWIJTE
	 Vax+q/pN7f2XxQryxM4xW4oRxcq3AnEnNNHlUAmks+0/Mx8UDHe9XwouiIOt1LNuQK
	 3KWaQLnz7v6eQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E0C38111D8;
	Mon, 16 Jun 2025 22:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] seg6: Allow End.X behavior to accept an oif
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175011423425.2542482.12100686603827257473.git-patchwork-notify@kernel.org>
Date: Mon, 16 Jun 2025 22:50:34 +0000
References: <20250612122323.584113-1-idosch@nvidia.com>
In-Reply-To: <20250612122323.584113-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, andrea.mayer@uniroma2.it,
 dsahern@kernel.org, horms@kernel.org, petrm@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Jun 2025 15:23:19 +0300 you wrote:
> Patches #1-#3 gradually extend the End.X behavior to accept an output
> interface as an optional argument. This is needed for cases where user
> space wishes to specify an IPv6 link-local address as the nexthop
> address.
> 
> Patch #4 adds test cases to the existing End.X selftest to cover the new
> functionality.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] seg6: Extend seg6_lookup_any_nexthop() with an oif argument
    https://git.kernel.org/netdev/net-next/c/01c411238c06
  - [net-next,2/4] seg6: Call seg6_lookup_any_nexthop() from End.X behavior
    https://git.kernel.org/netdev/net-next/c/3159671855d4
  - [net-next,3/4] seg6: Allow End.X behavior to accept an oif
    https://git.kernel.org/netdev/net-next/c/a2840d4e2527
  - [net-next,4/4] selftests: seg6: Add test cases for End.X with link-local nexthop
    https://git.kernel.org/netdev/net-next/c/04d752d60c19

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



