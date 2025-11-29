Return-Path: <netdev+bounces-242670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D52BC93821
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 05:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B513D3A9DE8
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 04:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF8022333B;
	Sat, 29 Nov 2025 04:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pB1YgrB4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36721A08CA;
	Sat, 29 Nov 2025 04:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764390803; cv=none; b=i2ftbXhH4y9my8K2ecLCNjBASMoyZZ4jO7omrdEuJjj3gFV4i2g0xnqqGMhrFd7D37bLIbeY6D+e4m7sOgHWIR6ELde78Jn/n5d/xBPtN5OT4Nou49rLxLwLd5dwZJFLZoGrAYwb2//xvKY3iA58H/DfAX8Sl2bQGBW/pVhFPEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764390803; c=relaxed/simple;
	bh=oNAFWCzxlkfKaI8Gd5NkajAWcHcN1+6vH64HKna4pSE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CdmXdirDgCgsHmokMBqzsljE2bpYSaWJi7BYcOqbIJ+nomxEc6srXfNgT+b7ZZkTvB5pLPb/cD4MvTy2m1mkLNS27hVfESPaQRynm+JMdrcFX5fb5zd9pMQjQ4YFtM5A9gcV5ePwGS9N7Htf6DKwvZHMM6QkrpJsF1590t6Oous=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pB1YgrB4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F3CC4CEF7;
	Sat, 29 Nov 2025 04:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764390802;
	bh=oNAFWCzxlkfKaI8Gd5NkajAWcHcN1+6vH64HKna4pSE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pB1YgrB4HjvTGvsisqCKP1B7PmOD7kWBhYTbioLthC52ETxgNyeSLdpBcjQkW6Yfv
	 Ayv7AnM3MsykwZd4KWmz9BtS6h5Xz13MUmFUrkN7cOjWt+e46OS0SifKv4mS0qIaVh
	 mIEWiwDIlIsRDImeq0wGTAEJ2hljNla5dZSg/t4LpqSYPWKqN+4Tl3d+3+PpJsMk9d
	 JntEeK/yFlXoGZ9I5AI/AykfMVwZ1YPxNw/yNAwrtFpydDscD9TKlDz7QTFeSNwFD8
	 nCfjMS3nN7ACYqDQMp3EpjJW8lofqLMpM7SolN+Efgk1QhmlydIFw3+/HSPxk85chG
	 GeIq8+aUrwmOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2A9D380692B;
	Sat, 29 Nov 2025 04:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: ipconfig: Replace strncpy with strscpy
 in
 ic_proto_name
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176439062377.907626.14135702597040681363.git-patchwork-notify@kernel.org>
Date: Sat, 29 Nov 2025 04:30:23 +0000
References: <20251126220804.102160-2-thorsten.blum@linux.dev>
In-Reply-To: <20251126220804.102160-2-thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: david.laight@runbox.com, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Nov 2025 23:08:05 +0100 you wrote:
> strncpy() is deprecated [1] for NUL-terminated destination buffers
> because it does not guarantee NUL termination. Replace it with strscpy()
> to ensure the destination buffer is always NUL-terminated and to avoid
> any additional NUL padding.
> 
> Although the identifier buffer has 252 usable bytes, strncpy() copied
> only up to 251 bytes to the zero-initialized buffer, relying on the last
> byte to act as an implicit NUL terminator. Switching to strscpy() avoids
> this implicit behavior and does not use magic numbers.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: ipconfig: Replace strncpy with strscpy in ic_proto_name
    https://git.kernel.org/netdev/net-next/c/ff736a286116

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



