Return-Path: <netdev+bounces-143542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3A99C2EE8
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 18:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08DF61C20BED
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 17:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF5419D8A7;
	Sat,  9 Nov 2024 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q28NrxUY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D764319CCEA;
	Sat,  9 Nov 2024 17:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731174624; cv=none; b=k4/A9rBJKzYe41cvaLIDETMV146fcij7jXYSoVnJ8hf2GzcKjlu2AB9pjHOz4qsvCyT3ld+gwjdUXIPIfpj+boDsn438TV3dFbqiQcBIR7SBUgM3/V3oNLJXOh3JBNYxY9ZwLVNOHvTKf9kGvrcUti2z+lDYS2EvWjs5ndsZdHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731174624; c=relaxed/simple;
	bh=3vbzvhbG/2XPTt2pMfteL7+7Nx196bGVEUphuDirl2w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gwLeJ3/GvAGD3LojWgFhuBtso9DKflBvA2yj3hXzeYk2mxjGLVHeUn1eDgGWtjb3HA6hSorahnsMsafiWBl3w+hKsrNiZ/rrWxKZ3hBLa2IOx7FoaJF73XKz2jfyXIi054TatOg10zGAGvUgJsRlhzprHMBUyFR1Tk+eOzVnvLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q28NrxUY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC30C4CECE;
	Sat,  9 Nov 2024 17:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731174624;
	bh=3vbzvhbG/2XPTt2pMfteL7+7Nx196bGVEUphuDirl2w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q28NrxUYm5Ku5hahgmapTIr3ROrvzQOY8fBWeDOe6RMGRl66fpzNn21Y7fKaxSim1
	 V8M+uuG7ZXuqCzEaDdkt+GZPnb+rRQTlDNzofYycvM/djw3ZjL9AR1fQQAc+sL2tHj
	 zOTREJur5ZL0kjGKt+bY+teP5jqqxMdR28Qwh8ZU6Z7+PlM6Lp1i8m5xR0B2BcgqNN
	 Dt7qHvK2Txxxkhwltnr+MdG96ebCdaJuOGsVNyA30lwfSbSN4zBjnytjILge/DNOCg
	 ZojWPYLDkuXwzE9CxMz7upuUz15xyEnZbeQdyw6OwMfMoxzH0J16IqTYw0VFD33ZoG
	 UHgAKC8PYDVOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DC73809A80;
	Sat,  9 Nov 2024 17:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mctp: Expose transport binding identifier via
 IFLA attribute
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173117463401.2982634.225795456177475066.git-patchwork-notify@kernel.org>
Date: Sat, 09 Nov 2024 17:50:34 +0000
References: <20241105071915.821871-1-khangng@os.amperecomputing.com>
In-Reply-To: <20241105071915.821871-1-khangng@os.amperecomputing.com>
To: Khang Nguyen <khangng@os.amperecomputing.com>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ampere-linux-kernel@lists.amperecomputing.com, phong@os.amperecomputing.com,
 thang@os.amperecomputing.com, khpham@amperecomputing.com,
 pvo@amperecomputing.com, quan@os.amperecomputing.com,
 chanh@os.amperecomputing.com, thu@os.amperecomputing.com,
 hieul@amperecomputing.com, openbmc@lists.ozlabs.org,
 patches@amperecomputing.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  5 Nov 2024 14:19:15 +0700 you wrote:
> MCTP control protocol implementations are transport binding dependent.
> Endpoint discovery is mandatory based on transport binding.
> Message timing requirements are specified in each respective transport
> binding specification.
> 
> However, we currently have no means to get this information from MCTP
> links.
> 
> [...]

Here is the summary with links:
  - [net-next] net: mctp: Expose transport binding identifier via IFLA attribute
    https://git.kernel.org/netdev/net-next/c/580db513b4a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



