Return-Path: <netdev+bounces-53697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 367C2804280
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 00:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE89C1F21324
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 23:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA0624B2B;
	Mon,  4 Dec 2023 23:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnzhWYt0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1013222F1C
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 23:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CF15C433C9;
	Mon,  4 Dec 2023 23:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701732023;
	bh=07pZUa4YlfdNMLEfQ1aOcLkFyzXeTQ+CRNrm/2WKEyA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AnzhWYt0g59H46omjkd4KOEjR8DsRbaIg+7MV04bVV9lIVvHSFsUUieGGLmHiZUVh
	 bUEFcMpF9A9dqssB4ifBATrH02wnDX+223bSrOhWUgVLTrBbFoRpugVyvUC6du6v8e
	 3g32lSuO5F7/KOcuaqaFf9+EmjTenfyQGeWYbPMzhZpu1CI+4e4QPEo85s1JXavFoZ
	 3eGt/rpdnzeSkD2QoR9vga+ewtKd4Xe9UgzlYT8bKs3KGONgpYNCFFTIGA9+rj6WI0
	 wUOwB+mSkfDeTPdcGoyWZCpDN9GJXwraDQvnEZos4tiZnvj0IkKHtwMDJeg6i1YM+e
	 uSdKeRw5be1Qw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 62633C41677;
	Mon,  4 Dec 2023 23:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] packet: Move reference count in packet_sock to
 atomic_long_t
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170173202339.29919.16182353251638504303.git-patchwork-notify@kernel.org>
Date: Mon, 04 Dec 2023 23:20:23 +0000
References: <20231201131021.19999-1-daniel@iogearbox.net>
In-Reply-To: <20231201131021.19999-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, security@ncsc.gov.uk, gregkh@linuxfoundation.org,
 willemdebruijn.kernel@gmail.com, torvalds@linux-foundation.org,
 stable@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  1 Dec 2023 14:10:21 +0100 you wrote:
> In some potential instances the reference count on struct packet_sock
> could be saturated and cause overflows which gets the kernel a bit
> confused. To prevent this, move to a 64-bit atomic reference count on
> 64-bit architectures to prevent the possibility of this type to overflow.
> 
> Because we can not handle saturation, using refcount_t is not possible
> in this place. Maybe someday in the future if it changes it could be
> used. Also, instead of using plain atomic64_t, use atomic_long_t instead.
> 32-bit machines tend to be memory-limited (i.e. anything that increases
> a reference uses so much memory that you can't actually get to 2**32
> references). 32-bit architectures also tend to have serious problems
> with 64-bit atomics. Hence, atomic_long_t is the more natural solution.
> 
> [...]

Here is the summary with links:
  - [net,v2] packet: Move reference count in packet_sock to atomic_long_t
    https://git.kernel.org/netdev/net/c/db3fadacaf0c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



