Return-Path: <netdev+bounces-222378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2F6B54015
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 04:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 420317C1DB8
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 02:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD431D5146;
	Fri, 12 Sep 2025 02:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvAdBuOh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43FF1C861A;
	Fri, 12 Sep 2025 02:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757642431; cv=none; b=QJMB6tI7Vy2oE6O3D+g4RnID1utniybGfeKFtjUAX+/LHKhxVQwNLJxz33bJvY+nHOOK2uh4iKyjbn5+yFRGtpbfvyI15plHmplpASInc5aTqrg9+0mHQ2ThMy6FgdznFCtbyxYDKEEoEGz+dWZCkwGS965+mma3lE/y1oRoY/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757642431; c=relaxed/simple;
	bh=TdbZxSnvieCSrjZnnZ2t1OUCezbwMzYoDiL3DVs10z8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rftIsoWDajh7Zpr3SBL/cAUEfXoabS3Q9/X8jJ+t22ymrEQ1I+NGh0sO8mwGP8eQy7fLp40cUP3jly4GL+P1FC9DFkQH4u5lF6EiQ/kuCA7gR+c92yoY+eF38VzwJYiSVD5fzIOGVUnobSZth6XZt9iyRbRYSeoa2sCCU1/UsiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvAdBuOh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A411EC4CEF0;
	Fri, 12 Sep 2025 02:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757642431;
	bh=TdbZxSnvieCSrjZnnZ2t1OUCezbwMzYoDiL3DVs10z8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cvAdBuOhvZkD5DT5YW7wMxli0oVzhh/q0Iy3KJT4eJotjnjnvJktMngbzCOtIssY+
	 jMzFvGReNLcE0udlE72KBitruUOUrLA0l2p1SkZajcCUv9+x2hnvyOm+qERdD7t1Xk
	 HziNfQIKzl0grWY5fVDT5OtERlNLCLvzjuSio7m1/TBtxSfGWP6Ti9e8wqSW7C65Dv
	 FESsXZk2vsev3k0LW4NfQTSFj+8GV/mzZvsPyn3FUs90jpC7xdSpHpxUotpFh12kch
	 GQbewnM5fW6KSQ4C2MCTDQ3tpFWXiT9XUftzRkTn0fjGeF+Y8rjGXjGKxs+uKf45ap
	 oqKlXINT53gvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F20383BF69;
	Fri, 12 Sep 2025 02:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] geneve: Avoid -Wflex-array-member-not-at-end
 warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175764243424.2373516.12165345909541767678.git-patchwork-notify@kernel.org>
Date: Fri, 12 Sep 2025 02:00:34 +0000
References: <aMBK78xT2fUnpwE5@kspp>
In-Reply-To: <aMBK78xT2fUnpwE5@kspp>
To: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 9 Sep 2025 17:42:39 +0200 you wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Move the conflicting declaration to the end of the corresponding
> structure. Notice that `struct ip_tunnel_info` is a flexible
> structure, this is a structure that contains a flexible-array
> member.
> 
> [...]

Here is the summary with links:
  - [next] geneve: Avoid -Wflex-array-member-not-at-end warning
    https://git.kernel.org/netdev/net-next/c/4094920b19f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



