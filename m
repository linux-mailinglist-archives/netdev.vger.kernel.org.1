Return-Path: <netdev+bounces-61053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5D2822564
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 00:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 579C9B22467
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 23:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BB81772C;
	Tue,  2 Jan 2024 23:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emBQyuMD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C3B17981;
	Tue,  2 Jan 2024 23:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5ED6C433C9;
	Tue,  2 Jan 2024 23:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704237025;
	bh=I83Wln+gVak8S4n4e6ON1v102WAZKo59JfLD7bgYLEY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=emBQyuMDyldrPNwgtuRmV3JVtoPCHTOFPK9W6aeXmQU18hfSN2va/3AmSdO1dGj9z
	 Q9OVedtOnVajlPz1ObKk5++nX2AdA6+t8KKPELpgYcp2PDoHVmSakJj6fH+9p+Vri6
	 2HB8x296ifir9tia6tXZgUNygZJwVFawogVi2g8naw7FL1t+XvXYUAx5w4hvDVtcty
	 PxPvfEROblTfdVjrGgITW2ghEqGi3b3iuENysSaFOLyWpv2ySAQumvAp/H75eM1i3y
	 LScpGOVtn3kDY0T6RR14wwx4i00au82mLJb6PeNOy5qBbfZC8glDuBTwgoHZNxiHpV
	 642zUBEvHoG/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C5EFBDCB6CE;
	Tue,  2 Jan 2024 23:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Revert "net: ipv6/addrconf: clamp preferred_lft to the
 minimum required"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170423702480.9754.17776012946815256992.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jan 2024 23:10:24 +0000
References: <20231230043252.10530-1-alexhenrie24@gmail.com>
In-Reply-To: <20231230043252.10530-1-alexhenrie24@gmail.com>
To: Alex Henrie <alexhenrie24@gmail.com>
Cc: netdev@vger.kernel.org, kernel@vger.kernel.org,
 regressions@lists.linux.dev, dan@danm.net, bagasdotme@gmail.com,
 davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, linux-pabeni@redhat.com, jikos@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 Dec 2023 21:32:44 -0700 you wrote:
> The commit had a bug and might not have been the right approach anyway.
> 
> Fixes: 629df6701c8a ("net: ipv6/addrconf: clamp preferred_lft to the minimum required")
> Fixes: ec575f885e3e ("Documentation: networking: explain what happens if temp_prefered_lft is too small or too large")
> Reported-by: Dan Moulding <dan@danm.net>
> Closes: https://lore.kernel.org/netdev/20231221231115.12402-1-dan@danm.net/
> Link: https://lore.kernel.org/netdev/CAMMLpeTdYhd=7hhPi2Y7pwdPCgnnW5JYh-bu3hSc7im39uxnEA@mail.gmail.com/
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> 
> [...]

Here is the summary with links:
  - Revert "net: ipv6/addrconf: clamp preferred_lft to the minimum required"
    https://git.kernel.org/netdev/net/c/8cdafdd94654

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



