Return-Path: <netdev+bounces-90745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3968AFE4B
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 04:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1331B2237A
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 02:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBC814277;
	Wed, 24 Apr 2024 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W78lU8+Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720CEBE6C;
	Wed, 24 Apr 2024 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713925228; cv=none; b=lnD/9B9BSpOLo3vXU1nx1DjKdqQFShA+nCATqSlKj7EUVlQv6IG8vn7wY6bXOfQRJvVNKrwAZX2OSfaSAaifcrdAWWEpqZ4BILBlC+/kV80/t6YruhGJriY9KgclSZnM00KXfH3/0fsTfUFfh4YoYOed32llygHmuoDvXAz+MYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713925228; c=relaxed/simple;
	bh=Xz3mB5hnbP738xPCrYXzoIatm0z5YuJxMG59NK9F0s4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aQwG4ONTl24glJDv39FSqYnDwvCy64VHXVzfUnkG2V5uLEKgCbeEZNVntXPvqCw7Tz56DWObfjC0HnIf4sags0sJNM3f/bRPqVCKTC2jhK35dlOJuLW825sCx6cqBgFSxCvC85lHzDV6Y4iRV2H0/1dcz/+LBTIxg2q443op8NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W78lU8+Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F363C32783;
	Wed, 24 Apr 2024 02:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713925228;
	bh=Xz3mB5hnbP738xPCrYXzoIatm0z5YuJxMG59NK9F0s4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W78lU8+ZYF6PHDkDdMnrTZgQTlE6DuuChTUMGVASEuLpAVBiuDX3FRWLC1YDmHSL1
	 wiPHmcFF0p8AREqKe3b27blFWt35NmronaEOCjqE71Cp3GMqwa8h7QlPNG8wQC8Ehz
	 x4X5xq9hxc+cyxPddoaILhpJ9k+QOkGS/eNEUWCrJiDEM+xWwz0aPE7ZVv0JUUKrem
	 snL+BUhCzgQkf3Tc/DtSmNo6vjSrlfEkmLhrQy6wWnUf/jrBNNe2aX3KxiMyovVmMe
	 CEiYsPgmTpbJPdd7heTo1jZPynFKEVApJF/ZKdC0TBvcZnkKWIGrp97aYCG0nskZ3R
	 +6eec9DMZUSww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B3ABDEC7E5;
	Wed, 24 Apr 2024 02:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: usb: ax88179_178a: stop lying about skb->truesize
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171392522810.21916.2630288409501635031.git-patchwork-notify@kernel.org>
Date: Wed, 24 Apr 2024 02:20:28 +0000
References: <20240421193828.1966195-1-edumazet@google.com>
In-Reply-To: <20240421193828.1966195-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, shironeko@tesaguri.club,
 joalonsof@gmail.com, linux-usb@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 21 Apr 2024 19:38:28 +0000 you wrote:
> Some usb drivers try to set small skb->truesize and break
> core networking stacks.
> 
> In this patch, I removed one of the skb->truesize overide.
> 
> I also replaced one skb_clone() by an allocation of a fresh
> and small skb, to get minimally sized skbs, like we did
> in commit 1e2c61172342 ("net: cdc_ncm: reduce skb truesize
> in rx path")
> 
> [...]

Here is the summary with links:
  - [net] net: usb: ax88179_178a: stop lying about skb->truesize
    https://git.kernel.org/netdev/net/c/4ce62d5b2f7a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



