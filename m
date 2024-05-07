Return-Path: <netdev+bounces-93924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C858BD98B
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 04:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 828D81C20F9D
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 02:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0003821101;
	Tue,  7 May 2024 02:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aobyJvp9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB3646A4
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 02:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715050226; cv=none; b=r9pJb3pajFazzg2Lw0a1EjtVcsML98g32rsvaBqRjTlfO+Yfz2+C4OE1u1KB8Xz0fL2rjPhx9VljhtswiTnUdSPN//oZ/++GOLSKc+zlZKlKd5GUaFZNvfwajYL6fNUrDmKVgLPR2bMiCnnSL9KZTeHHwwMZWst0Bpz0dWerDW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715050226; c=relaxed/simple;
	bh=s+62aNLSXkNgkxlR2lRfNBxI8xrcPSPgM4YRPAgxLLA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Cc3J5F7OIWFqOBiFkj8DLQq3SLR/jfuzMi1obBxwCizj7TbbNVogzDBTT3LqQt3hK0qkj4yyy5FUhg0WEiruWB2qPyWkIz3/I/riY73qUy6PHrrGAEpWVytdXZS/YUVTNSxGFJL8oT7TSk2VYHzkFbYKZIyxQQAGl0C6zDOdXUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aobyJvp9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C4D0C4AF18;
	Tue,  7 May 2024 02:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715050226;
	bh=s+62aNLSXkNgkxlR2lRfNBxI8xrcPSPgM4YRPAgxLLA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aobyJvp9gw1wF+hm+9sM6ywZU6zTsqIqH+dh7xKcRnT/mnqAY7srvv5IIr4KZoUTI
	 VPcutFNbHSNvCn/OR0h6llHMl+VRHSw1gwX0/xsoWa5VnFbspmjbQPHDo2yVxjz+Y4
	 P6kIvWSdSFYCGHcmDYm3lTtkt+SZjeh7DVggGqlJ3JGAvTwmFTk+H6qbLjFnSW4LIF
	 ls1+fb/4eg16rwuBzwyRk2ZRICH6BBOrJj6RrjcloOLhC64cjdwu/3mPzmmJHvdz3e
	 9Y3Zvc7IzmuZjjlK7FRcKGURfiRjt3T3+tQcct3r326oLZVnGUonnpDHbbhjTntgTl
	 a3N6sfX2uxyiw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4C3DAC43337;
	Tue,  7 May 2024 02:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] netlink: specs: Add missing bridge linkinfo attrs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171505022630.7000.13115007485294763859.git-patchwork-notify@kernel.org>
Date: Tue, 07 May 2024 02:50:26 +0000
References: <20240503164304.87427-1-donald.hunter@gmail.com>
In-Reply-To: <20240503164304.87427-1-donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, jiri@resnulli.us,
 jacob.e.keller@intel.com, jnixdorf-oss@avm.de, idosch@nvidia.com,
 razor@blackwall.org, donald.hunter@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  3 May 2024 17:43:04 +0100 you wrote:
> Attributes for FDB learned entries were added to the if_link netlink api
> for bridge linkinfo but are missing from the rt_link.yaml spec. Add the
> missing attributes to the spec.
> 
> Fixes: ddd1ad68826d ("net: bridge: Add netlink knobs for number / max learned FDB entries")
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net,v1] netlink: specs: Add missing bridge linkinfo attrs
    https://git.kernel.org/netdev/net/c/9adcac650618

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



