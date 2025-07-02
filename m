Return-Path: <netdev+bounces-203383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0968AF5B47
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 16:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D02A486F62
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 14:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4873F2F432B;
	Wed,  2 Jul 2025 14:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0l+QKx4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EB026C3A3
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751467186; cv=none; b=kgfZbp3Z45lrROKmS87ZPrfXLvIZyhiMHZSb/4WH/HrJ4lL8jrEpsQyjO6Dqob9blsEfgu8+pkKDUpkHKs8JcbYrf0cxhxsQoItreM8/AwzbG3bo/nOpQbtCMDUBoGmCGLw+6t0/WHYtqX6SRevJhzyxjaaTKI04NFzYE2HO1aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751467186; c=relaxed/simple;
	bh=R19ihR/OzC6bqGGAFeNWZKeZX9q7baXzFvYHJPRF9Po=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QdC5CU9IQKrFd0Tc6/A4mxuzK6ZgAg335GKLhTF9y1XgWRsiBxLIHcuw3oiYpZSN5cdBQUy8YxoD4ZeXih65LH0ydFpp1W4NYDlBLHOxlvhHXnGMqHoEspTVw0qzUv02spbbeOAR1m0OqTumDAXb4ow4lRmBEovJgB3dQMSllYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0l+QKx4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD1CC4CEE7;
	Wed,  2 Jul 2025 14:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751467185;
	bh=R19ihR/OzC6bqGGAFeNWZKeZX9q7baXzFvYHJPRF9Po=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n0l+QKx4kkKS37EgfPZ2gZQy8Qe/TRE0QBf9SRUvqIMsTbK8s/rXQdvi+uMsLgHcf
	 wfC9OaE11W2N80JPNTB51ZpD9dmabCme0o6OgwKdcRk/tE06gHDKeyNJkX8RNOMN2s
	 zQoJdNgZdANzJYtqG7ZxnDHU1Ujma2ACeHERa2uZZuM8pTtblxRhV2l5d+9Nvo033v
	 pE1J5kQQWCdsNhoGWRTU/YlGZ+L58IgAqTfpuTjSa5FDW9LlH1aH6tkU4BTJlgc6L5
	 Aiwxx11abTwbw58Ld24D4DkRPw4UT9Hw9zkCVg3dTCiZT7woMpJ9jnUaM1JFNR/zyW
	 g8EEhO+JCmaDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C4C383B273;
	Wed,  2 Jul 2025 14:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v6 0/3] bridge: dump mcast querier state per
 vlan
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175146721025.744720.14595669667124615372.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 14:40:10 +0000
References: <20250625-mcast-querier-vlan-lib-v6-0-03659be44d48@pengutronix.de>
In-Reply-To: 
 <20250625-mcast-querier-vlan-lib-v6-0-03659be44d48@pengutronix.de>
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>
Cc: netdev@vger.kernel.org, entwicklung@pengutronix.de, razor@blackwall.org,
 bridge@lists.linux-foundation.org, dsahern@gmail.com, idosch@nvidia.com

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed, 25 Jun 2025 10:39:12 +0200 you wrote:
> Dump the multicast querier state per vlan.
> This commit is almost identical to [1].
> 
> The querier state can be seen with:
> 
> bridge -d vlan global
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v6,1/3] bridge: move mcast querier dumping code into a shared function
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=da6fbcf63c13
  - [iproute2-next,v6,2/3] bridge: dump mcast querier per vlan
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=baeeb9a8e184
  - [iproute2-next,v6,3/3] bridge: refactor bridge mcast querier function
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=cdc027cb7f47

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



