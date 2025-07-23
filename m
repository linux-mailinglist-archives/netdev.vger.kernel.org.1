Return-Path: <netdev+bounces-209544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4052CB0FD01
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 00:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 213147AE67A
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 22:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF465271A6A;
	Wed, 23 Jul 2025 22:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWYuC6wm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CD04A2D;
	Wed, 23 Jul 2025 22:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753310388; cv=none; b=DXJMFk8MqUknqR5TsbZoMh0Y0M5r404WBkf+g6bgrEyr649zth4dqtsxV/A38CPI0ksz8befyzZQEL/nY6/EGkWdWbSqPdoqcxBWg4fOaHkboBIm96QNmSDdPzYBvsS1KumN8tw9/zmqLwk6e1zsMd4pZ9Ic+v0I3MHijk5ZzIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753310388; c=relaxed/simple;
	bh=hgnkJrnN6sK/XOfTEvvAXSxWgRpJ2PYqa06SFODCGfY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QAMB4K5BSJ7EtvncqBUQvOmumjYOMVysWx9hivqZKINuDj4KFjKoYlyg1XxkaGYGLPBygqcZPSSv+LbyV8o+jCeJc9jdri27Vhw10wi3PSbsiVn/FNXmn57grvaM6wCpVAAZhp8XTNW8VgDFjuxx3UTnPWhyE9k+U/RB/TyO5eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWYuC6wm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E19DC4CEE7;
	Wed, 23 Jul 2025 22:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753310388;
	bh=hgnkJrnN6sK/XOfTEvvAXSxWgRpJ2PYqa06SFODCGfY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nWYuC6wmZ4JIVrr/lCjOuORXJfHlY5NTb3thJyTOoczlPYQMx/EFTjNOk3YlN1WJw
	 XHrsoQvL1Zo9HCmjD8Im4XumTAPFTrLX+iFKp8QWuJkh2COJ2pxG1c9pum7py+xKwf
	 xu9XxLdcB0NLAEkX56Ch8MS0ODYTwITIKRj+SvdWFJJ73mkp8jdktCIpEkcsYfJuu8
	 0NIEKqy3uzK1rmgwGpvtm4ss2RtXGiSu/GfYt8L1S+tWjlxruA2NcUdGhEXvtLldGd
	 lUgZDSMXm5JP1RNCK1jNjm6pA44mNiLnXVXXAMn6TpYrpXjWh/oMCGCCm1UVRkSFRB
	 M42EGWnI/SWKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C12383BF4E;
	Wed, 23 Jul 2025 22:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] MAINTAINERS: Add in6.h to MAINTAINERS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175331040626.1803663.10946559776281993316.git-patchwork-notify@kernel.org>
Date: Wed, 23 Jul 2025 22:40:06 +0000
References: <20250722165645.work.047-kees@kernel.org>
In-Reply-To: <20250722165645.work.047-kees@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Jul 2025 09:56:49 -0700 you wrote:
> My CC-adding automation returned nothing on a future patch to the
> include/linux/in6.h file, and I went looking for why. Add the missed
> in6.h to MAINTAINERS.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: <netdev@vger.kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] MAINTAINERS: Add in6.h to MAINTAINERS
    https://git.kernel.org/netdev/net/c/14822f782700

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



