Return-Path: <netdev+bounces-93926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C10BC8BD98D
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 04:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07F801C20F53
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 02:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4FF3FB9F;
	Tue,  7 May 2024 02:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMmvgCvh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BAE3D97A
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 02:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715050228; cv=none; b=rOLdZ3GVLEzvH0AHLNvL4wJ/4s2fNEZAZzIxfhooN//NGoBBeJ6OUwkOFVrSruSZdfmnqH3/eBgTomVmtXP3+7/BkC4UE6JUsvzGEO8Ov6+fu8L8FtgxBWTZ+uQLjncOQUN31ieJ26hPoUs9074PJ5uaFU9wZMyw4V7cqzkAVsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715050228; c=relaxed/simple;
	bh=JC/nZivik/NGi3BbeW7MtveqL7Ywr6JBQaDAjI0ro3Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CYY3QMKUWM7VQPt6latJA1jR/w52bSCbGPGsRl/JagbyWfpJoEenlh7Ij0SDMhbdErOYCtLDC2wzWc6DWL9THzba6Qj5PC+6rj+xOVcia31DtG/eJrl0YHfSQoYdg+HMNsYuOzzMJlOjFZJH7fZu19fB5RZKSLyuQVdrSzWhAzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMmvgCvh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DEF48C4AF63;
	Tue,  7 May 2024 02:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715050227;
	bh=JC/nZivik/NGi3BbeW7MtveqL7Ywr6JBQaDAjI0ro3Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kMmvgCvhim+riTOpUIEpcI88s83k/F8YoQeLU+DyVPnrF7l+O9xihRbtl07DC6lwC
	 x+5awf7rmmyACFGFa8Qher5Dgc4t6t0qDj+S/NghJsaO9ep45+Lq9jipPQrbYStop+
	 CshdPXMQO4D3oDkT4mWHdtjc34lo1BVcE2HOlf7VT1OsFwSbkDmCNyF7DqGFWipflp
	 EylXLvtqwOixee6e2UPYJIXoX9aioxfQwjDjhTbv87hXhPwjHk1dCStnFU1MTLJp88
	 N2z/RR40gm6v74IDgiOGXUr8EYmza3QApLwFlgDj+qYxFltJlWuy27gxetw091Tn8X
	 l2+t+VQm1jmjQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CD83FC54BAD;
	Tue,  7 May 2024 02:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/5] udpencap: Remove Obsolete UDP_ENCAP_ESPINUDP_NON_IKE
 Support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171505022783.7000.3219553827652297697.git-patchwork-notify@kernel.org>
Date: Tue, 07 May 2024 02:50:27 +0000
References: <20240503082732.2835810-2-steffen.klassert@secunet.com>
In-Reply-To: <20240503082732.2835810-2-steffen.klassert@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Steffen Klassert <steffen.klassert@secunet.com>:

On Fri, 3 May 2024 10:27:27 +0200 you wrote:
> From: Antony Antony <antony.antony@secunet.com>
> 
> The UDP_ENCAP_ESPINUDP_NON_IKE mode, introduced into the Linux kernel
> in 2004 [2], has remained inactive and obsolete for an extended period.
> 
> This mode was originally defined in an early version of an IETF draft
> [1] from 2001. By the time it was integrated into the kernel in 2004 [2],
> it had already been replaced by UDP_ENCAP_ESPINUDP [3] in later
> versions of draft-ietf-ipsec-udp-encaps, particularly in version 06.
> 
> [...]

Here is the summary with links:
  - [1/5] udpencap: Remove Obsolete UDP_ENCAP_ESPINUDP_NON_IKE Support
    https://git.kernel.org/netdev/net-next/c/aeb48a428d7d
  - [2/5] xfrm: Add Direction to the SA in or out
    https://git.kernel.org/netdev/net-next/c/a4a87fa4e96c
  - [3/5] xfrm: Add dir validation to "out" data path lookup
    https://git.kernel.org/netdev/net-next/c/601a0867f86c
  - [4/5] xfrm: Add dir validation to "in" data path lookup
    https://git.kernel.org/netdev/net-next/c/304b44f0d5a4
  - [5/5] xfrm: Restrict SA direction attribute to specific netlink message types
    https://git.kernel.org/netdev/net-next/c/451b50967897

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



