Return-Path: <netdev+bounces-215459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FBFB2EB4F
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 04:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4F3DA064D0
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 02:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A402257452;
	Thu, 21 Aug 2025 02:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttnz1A1Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710382561B9;
	Thu, 21 Aug 2025 02:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755744003; cv=none; b=quvrhUa4tNybc1gB0b8EieOz7NXCFhl7kB0H3mRB/dqycw6lIhoMMYefb8Ed8TG5KAF18PKqw2FEOah2q9C0ndcAG9/9I/AUeKUFaZxZMhwfYoP8RANIyoq2tXWZhpJVNRyqTcrnML5SidtzsRAXmxGphuEbgeTyPuwKLbj6mIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755744003; c=relaxed/simple;
	bh=4JUcDIKvKRrx1WSQ0jGBlG6JpRR8MXZUBY2bjNElP+4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UX6tbbyjEy42EJ8GR0cL+AoesYw9j2ethl6CUly+7aDLR+q/WgZnmBuwir1pRPg/s2uIN33oY1oSEqO9L4GHSiWtDUeXkXXOMxTsjraDokgPJBf82r62FUIaOoPrpBV2qy42MN9XkIIYX/FtkynfvSvHQeiY/T8td0ls4M3xxm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttnz1A1Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A14BC113CF;
	Thu, 21 Aug 2025 02:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755744003;
	bh=4JUcDIKvKRrx1WSQ0jGBlG6JpRR8MXZUBY2bjNElP+4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ttnz1A1QGTcamkKqp1bWmOcRZhTd7BrLD7LNCwvHs+5eSTVa8WtPoRcPBEB1annJx
	 RNFm2X4ioLMAVk5noZJkwAy3WjQ+Esxi79LnjF41mbMOXquRy9XgKFvoS5iwfRKNXc
	 3Q8e4jn7A5+zVe9bietO+7PK9fTnkII9cojjioNmfUVcNoRNQNEpUnRvlh2BuLjTAw
	 dUkj+OlEfMxfJflBZGtp4U5qGEZHSs+IPDuvI5M2HUmSs8hA66BAUoFTMKcjzrIT5d
	 SanjQzlHCxeCC5Q5ODx57poDEcUKLE3izBzjwuMaiuwDSExsSuZrLt1RgPQN1aTuTl
	 qzabIdmxgpGHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF44383BF4E;
	Thu, 21 Aug 2025 02:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: microchip: Fix KSZ9477 HSR port setup issue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175574401274.482952.3195956969119987359.git-patchwork-notify@kernel.org>
Date: Thu, 21 Aug 2025 02:40:12 +0000
References: <20250819010457.563286-1-Tristram.Ha@microchip.com>
In-Reply-To: <20250819010457.563286-1-Tristram.Ha@microchip.com>
To:  <Tristram.Ha@microchip.com>
Cc: woojung.huh@microchip.com, andrew@lunn.ch, olteanv@gmail.com,
 frieder.schrempf@kontron.de, lukma@nabladev.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, tristram.ha@microchip.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 18 Aug 2025 18:04:57 -0700 you wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> ksz9477_hsr_join() is called once to setup the HSR port membership, but
> the port can be enabled later, or disabled and enabled back and the port
> membership is not set correctly inside ksz_update_port_member().  The
> added code always use the correct HSR port membership for HSR port that
> is enabled.
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: microchip: Fix KSZ9477 HSR port setup issue
    https://git.kernel.org/netdev/net/c/e318cd671459

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



