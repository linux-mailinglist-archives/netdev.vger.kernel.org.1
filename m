Return-Path: <netdev+bounces-222746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AA571B55A89
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 02:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5EFF34E1565
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 00:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018D71862;
	Sat, 13 Sep 2025 00:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvaeNJAB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EB0139E;
	Sat, 13 Sep 2025 00:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757722211; cv=none; b=qX383ccEr4G4AQoqFyD+wRacgeiTsm0LXp4djP1tmR4BiUtliNhudfei32NtXAXV72fa/UT60qOGm/TIWpFn7/pEvWBxm+S4jzwLsIO2nUhQXI3pe4NiOPdwSVXjcKCOfMJq1xK30+UGH53QG5Q/uc5SefxmhiHMG2N6neqL7zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757722211; c=relaxed/simple;
	bh=huvopUx+fCF+W27J4ozI5YLGzWrBy737PtGOGcG4H2Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DFk9qoBjnDeNeGpgUMNruztKXtObM1CVt9cR0aVu5I/CASUPoM9MFfZ/TIoKmwwsWDLYSPx71mhcTAbfv+M9MNNwetdkkKQGX6SNKKSpwcWMrEB/Gk17HUiVEkDJgMYnigJPnUr4Tbyt8oWbLEciqY+lHUPIxOwqZF9L4/E6qNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvaeNJAB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A003C4CEF1;
	Sat, 13 Sep 2025 00:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757722211;
	bh=huvopUx+fCF+W27J4ozI5YLGzWrBy737PtGOGcG4H2Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EvaeNJABzLxa6LhqrXHKVF36AkpXQbsvz+v9RyeVtxdNP34QjmT8GSOoXFtJL41yc
	 L9fa9ZC9Y2fW/SNvki+UrPwI4aVkXchkn60Y7pAhT9MzTCEaMOJdy5yOZWsVGv1Tmg
	 2W9DjDaNl5KiKXmEELv/yDtrB12eG9Rm3SDTfZsWCDcZkGQ/VgwjD2Eq4Mv6IfuQwS
	 WniiTnX/xtv6q7zkompLKdq29dYD9k+a4jOWuArCXPm401r7kDz4Qa91Z551VtAtPH
	 s8O2qPPl5/aYv3U1/+I6kmajVP/ON4++MZHi+PxvV2q6AbttUn9mOwSz+fAepwKTOa
	 BE19EAcU2RhXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE329383BF4E;
	Sat, 13 Sep 2025 00:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dt-bindings: net: Drop duplicate
 brcm,bcm7445-switch-v4.0.txt
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175772221351.3109205.11738417185121524239.git-patchwork-notify@kernel.org>
Date: Sat, 13 Sep 2025 00:10:13 +0000
References: <20250909142339.3219200-2-robh@kernel.org>
In-Reply-To: <20250909142339.3219200-2-robh@kernel.org>
To: Rob Herring (Arm) <robh@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Sep 2025 09:23:38 -0500 you wrote:
> The brcm,bcm7445-switch-v4.0.txt binding is already covered by
> dsa/brcm,sf2.yaml. The listed deprecated properties aren't used anywhere
> either.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/net/brcm,bcm7445-switch-v4.0.txt | 50 -------------------
>  1 file changed, 50 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/brcm,bcm7445-switch-v4.0.txt

Here is the summary with links:
  - [net-next] dt-bindings: net: Drop duplicate brcm,bcm7445-switch-v4.0.txt
    https://git.kernel.org/netdev/net-next/c/3456820e01f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



