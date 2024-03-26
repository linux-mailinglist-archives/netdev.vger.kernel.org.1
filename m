Return-Path: <netdev+bounces-82133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EF388C5C7
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 15:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4C3AB227C4
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 14:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0269E13C673;
	Tue, 26 Mar 2024 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbPu/ALU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25BA13C668
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464629; cv=none; b=d/fWDat2HIn1QdS3b/8+xlF/0gR/q3r4zT4qLCAjT2deemRgT0NzcsfOwT+1OKZiOLDtEeznTSWTQWvlVWLJRVbEetugmdKXxPi6DwTHoZjjx0ocgMaIw8W0MFmwS96h2NeeLfujbt7J3nlE8KpBTjPxmFSMpgdU8hkl58HLCBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464629; c=relaxed/simple;
	bh=RL8bocqvYwqCmrd2ycvaqV5iijyrUrS/VqBu8y72uZ0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bKZS3Inr7ylJQqj7VnO69LCrtMyJij3DhCDNaNsO8eBla8PWo6/tXnHw6SKpvtBTAgZ8jk0+3wcQc+wrGYgVgQbiEKYPaXhxuXyPXs9L6nUOokY3WQaJgx7lDWrgtCo2IlSMRtL7Z+Y9Vxz3AvStUc/ZR3Y8iwpUYkvhAO5eoWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbPu/ALU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 775A1C43394;
	Tue, 26 Mar 2024 14:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711464629;
	bh=RL8bocqvYwqCmrd2ycvaqV5iijyrUrS/VqBu8y72uZ0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cbPu/ALUySbz/D7/5SUK+WJ/h6dqQZNOF3j9svuJDWSVgNPwwz4oz8K+DGjjdsnpr
	 X3ZoRh2muWpAw0Y5oPP6Z7qYVKX0ilTfRU1Fm2ZjAp0dUAgp2W/jFCQ0n8A5aFo/hk
	 54drPGdUPq7JGlDJuEmlUyKZ9+3+9bUaB/96Q795XEY3JT2kVSgNFU/8wt8LvYvDAh
	 xkqAgfiGTe1xa3okWlNqPb8FDteUDTy3xrYotPKreiHne5jcBNDECnnOh+3XV54W5G
	 DsbMkGxNfOmbO98OQUckH8bdQPLF7F/gUm+rmmd0StPQh8Sz+naahJX6FpdL7gpwhN
	 u906R3z20yD3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6580CD2D0EE;
	Tue, 26 Mar 2024 14:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: remove skb_free_datagram_locked()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171146462941.14765.9067284482126372902.git-patchwork-notify@kernel.org>
Date: Tue, 26 Mar 2024 14:50:29 +0000
References: <20240325134155.620531-1-edumazet@google.com>
In-Reply-To: <20240325134155.620531-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, kerneljasonxing@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 25 Mar 2024 13:41:55 +0000 you wrote:
> Last user of skb_free_datagram_locked() went away in 2016
> with commit 850cbaddb52d ("udp: use it's own memory
> accounting schema").
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: remove skb_free_datagram_locked()
    https://git.kernel.org/netdev/net-next/c/6e0631203503

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



