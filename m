Return-Path: <netdev+bounces-88944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4618A90D3
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 03:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E11021F2298D
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 01:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76E64EB46;
	Thu, 18 Apr 2024 01:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsjBt7FK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6703BBE4
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 01:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713404428; cv=none; b=gWtNleFcblOVNsykFqMPI5/0bZDjXdldo0jb4PeflWFlxf3XU0qOlZB7U7jIZNJ99OL/l3N5XHu21MTorxhIifZCvtVZWIvqYl1uZ2YDGBMGm+DNOlIF6ymco38YVWiskAU23vRs+toAWKCMDqDvgzVtxgfi1SaAK0mtK7dSO/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713404428; c=relaxed/simple;
	bh=tAAOpB5vuCl/TPM+VO7h9mjLo9JY7Z67HyoWkpLROyw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IH5BeRA+PsNbILH1v8XtGk+xwPG2xPJpiAh7+T4dZABdSha5VpVtlIWm0P3T3sgJl7/5VszPdpfiFiAl1SqPFzxmgvFW96rVCjSIIXYvVjsg9IcbHtUiOjrl5gAYVpE3GKTDoP8N6cwF9z9b2vUd9EfAm/H2jJP6r8sD0r18FYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsjBt7FK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44C6BC4AF0C;
	Thu, 18 Apr 2024 01:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713404428;
	bh=tAAOpB5vuCl/TPM+VO7h9mjLo9JY7Z67HyoWkpLROyw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZsjBt7FKmSU9y0B2TrTH5OcvbKV2rESqOXruoPSCcbCV8egzHtGRwRzr7FzOPF6Vh
	 kj22EYq1FY540z8ohL4//jn9IJfNU0Xel/xehHLkt7Hg0y1Ces6OanEmCQLXcl8QdI
	 DroJAR8UT3Igoqsrh/C8FCKtEXkXqe9mcfYoW8vRqrJ3/58qQMHNRR6rqFr+LW3W7K
	 NBIYgeJvs60CUKjychlzMWazxRbrfiLV0W3qurbEQc0PX480OJOg2m14ACL3V9WfOH
	 5KgJFxaIt3hynaQaXk4J+muF1SzTMfwTBPx23pEMDK92zDk9rA3fSnK4Tm9OtI4VNF
	 t1oN/90xGm/SQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2F7A8C4361C;
	Thu, 18 Apr 2024 01:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: bcm_sf2: provide own phylink MAC
 operations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171340442819.27861.7194499234336908194.git-patchwork-notify@kernel.org>
Date: Thu, 18 Apr 2024 01:40:28 +0000
References: <E1rwfu3-00752s-On@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1rwfu3-00752s-On@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, olteanv@gmail.com, florian.fainelli@broadcom.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Apr 2024 11:19:03 +0100 you wrote:
> Convert bcm_sf2 to provide its own phylink MAC operations, thus
> avoiding the shim layer in DSA's port.c
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/dsa/bcm_sf2.c | 49 +++++++++++++++++++++++++--------------
>  1 file changed, 32 insertions(+), 17 deletions(-)

Here is the summary with links:
  - [net-next] net: dsa: bcm_sf2: provide own phylink MAC operations
    https://git.kernel.org/netdev/net-next/c/03d5a56ef795

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



