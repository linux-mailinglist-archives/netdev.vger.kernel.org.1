Return-Path: <netdev+bounces-119359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 970309554F3
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 04:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5E4FB216F2
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 02:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9389646;
	Sat, 17 Aug 2024 02:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMr1obz/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE8C22334
	for <netdev@vger.kernel.org>; Sat, 17 Aug 2024 02:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723863029; cv=none; b=f0c+sk9zPg/MKKyd8+SaCnzzk1uTPornXTStRUBeRd2lE4VBS0RByrWHEjIanZsdAnCtiB2DVLCxe9WCLrRASd5sqcmWgoFmAp4OeBDMZA576uA73fIpee8UVghZZ9xKjoAaF8QdYN3woOEsW2Pj9KCKUAnCVui53E2lKGpGWK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723863029; c=relaxed/simple;
	bh=Z8jHGZm0w5WYBUWkBHpaGCXstwvgF7AfezcJlln5zDo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a93IeYI24hPyrP/85aKGFC7PD2UxXWO9aEA+v+oaFc5XIHI2NOv2sGlUMWXwFWe9UwjZTVghcgHOtarjFJ3FZc4BhmWykoqEhZSRfg0zQgayCiCqXcLevEcCcJ4bfbFmHRGwUcdARxuNIeuwBZfzLJ+wxmoOBjCCAeBW3xGhgyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMr1obz/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7761C32782;
	Sat, 17 Aug 2024 02:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723863029;
	bh=Z8jHGZm0w5WYBUWkBHpaGCXstwvgF7AfezcJlln5zDo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gMr1obz/jMJFt9PjQssqy1jhUlUsUQuZgiSHMfnuXv9f7lqJh5rU4bSazS9o2qd1J
	 B0IgvSkTx/LGBEqsaZVoHJflg3hUYNY+AHwSay7LIGNbEknmQ9aoj3FcK7wyhDOem1
	 PiHt8QLE88SYNGLEzPeve2x3FvjW+/Y2RPTUGu8rhgc7QBxLibDmPUs67wXw8SAeCc
	 kdCWB1GP1iDR823ZQ08ix+G3J+Iftzlq9D0Scs2xfItOjl4OhmNvCyQxTnCMTxY8FF
	 FO1raXaYo7/pPekklTDjH9qK8pBKQV77eOy/m8Q0PUnaQrKSUPdsP73mEy6yQj2fMQ
	 rJm4X+IRG/y0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D0038231F8;
	Sat, 17 Aug 2024 02:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] bnx2x: Set ivi->vlan field as an integer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172386302825.3683187.17491130875681163118.git-patchwork-notify@kernel.org>
Date: Sat, 17 Aug 2024 02:50:28 +0000
References: <20240815-bnx2x-int-vlan-v1-1-5940b76e37ad@kernel.org>
In-Reply-To: <20240815-bnx2x-int-vlan-v1-1-5940b76e37ad@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: skalluru@marvell.com, manishc@marvell.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 Aug 2024 16:27:46 +0100 you wrote:
> In bnx2x_get_vf_config():
> * The vlan field of ivi is a 32-bit integer, it is used to store a vlan ID.
> * The vlan field of bulletin is a 16-bit integer, it is also used to store
>   a vlan ID.
> 
> In the current code, ivi->vlan is set using memset. But in the case of
> setting it to the value of bulletin->vlan, this involves reading
> 32 bits from a 16bit source. This is likely safe, as the following
> 6 bytes are padding in the same structure, but none the less, it seems
> undesirable.
> 
> [...]

Here is the summary with links:
  - [net-next] bnx2x: Set ivi->vlan field as an integer
    https://git.kernel.org/netdev/net-next/c/a99ef548bba0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



