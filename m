Return-Path: <netdev+bounces-97171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2AF8C9B01
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 12:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 878491C20AFF
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 10:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2594D595;
	Mon, 20 May 2024 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/Zy/CPt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B2D4C624;
	Mon, 20 May 2024 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716199829; cv=none; b=au48su5c+vLF6neFqVMxgKRi3KVHtGYhadhbaWyYrLPC7rk7hc+uWIoLnssgji6PfleTXWWUgZAqslneiZAqhsUpytr/6C1lKr/5Cgeilhp13EK5rTCtSgZM3jUyhYp99kaeMFtMvP6bFAvbXCmBbbu4BdyC3aiT4nUsWkajGkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716199829; c=relaxed/simple;
	bh=TNK9Jar8YJmnNeoHJ9Ha26Z++4zG5iduTJAAtSVf+IM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RJXGoj1xMKCR8z+ozKWpmVDR8eTT2EdertxJN2xgFAWcXdThIIhW9hVOxDn0MNEzvE7++45ft+X/tkImbrZF+wmRSRxRZkkFGSX0eNaObVWJILEEK51Rh9tjIk8KcSOjkPZe8QchnHY6299YrjB2e0ttBbhSH5sheKV/9Vz5oG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/Zy/CPt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6916CC32786;
	Mon, 20 May 2024 10:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716199828;
	bh=TNK9Jar8YJmnNeoHJ9Ha26Z++4zG5iduTJAAtSVf+IM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e/Zy/CPtqaqE2CvEKLArDsFHeqGbt6RDBhgQKr7MGY0XDmMxNKzdhSL9jiFvBW++h
	 M6Jnko0fA06Kn/k47Ce5VSXOX1bQxQANwRXvKYk7bUm9lz63Iu6UZ5sah6pWXHuTS8
	 m27CiHRS9BJBfbrMbgAAcnZu9z8qwh78SSDsNuGbzRvvlcBWnkWCgkJuspRmN14H6w
	 /1jo3V5cblLk1fucf6YvDCr3kz5+D4Os+8KfyHQxQ/IFlsc7Nv8UGpum8Oo6md9rCw
	 Xec/N+9O8giYux0ajVlQJbY5K1yO8N2+ItkPqYmzbH5nYs0cW9aPr/sPJH7P3wm4Pd
	 G2E39XaoI+w4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5007CC54BD4;
	Mon, 20 May 2024 10:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: Always descend into dsa/ folder with
 CONFIG_NET_DSA enabled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171619982832.25234.9983760519411876794.git-patchwork-notify@kernel.org>
Date: Mon, 20 May 2024 10:10:28 +0000
References: <20240516165631.1929731-1-florian.fainelli@broadcom.com>
In-Reply-To: <20240516165631.1929731-1-florian.fainelli@broadcom.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, stephenlangstaff1@gmail.com,
 aleksander.lobakin@intel.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com, f.fainelli@gmail.com,
 alobakin@pm.me, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 16 May 2024 09:56:30 -0700 you wrote:
> Stephen reported that he was unable to get the dsa_loop driver to get
> probed, and the reason ended up being because he had CONFIG_FIXED_PHY=y
> in his kernel configuration. As Masahiro explained it:
> 
>   "obj-m += dsa/" means everything under dsa/ must be modular.
> 
>   If there is a built-in object under dsa/ with CONFIG_NET_DSA=m,
>   you cannot do  "obj-$(CONFIG_NET_DSA) += dsa/".
> 
> [...]

Here is the summary with links:
  - [net,v2] net: Always descend into dsa/ folder with CONFIG_NET_DSA enabled
    https://git.kernel.org/netdev/net/c/b1fa60ec252f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



