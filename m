Return-Path: <netdev+bounces-70667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C4584FF22
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 22:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ACC71F21C1D
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 21:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488D31A71B;
	Fri,  9 Feb 2024 21:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKVz9dk2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BFD63B8
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 21:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707515429; cv=none; b=l61quv0pL960M+8dOKxe9hVDLwUJXKPP8dHSW9grTg6EreTOr0QVbpT4LksRVmSnvsXfa2QO5V/ioo/xGW1nGVJ/rP3YY5AW4nE/pIRmJTinxmFwSLgLsmyREufHqLg0jqr4XV0qyvEYpra2SJ0C+GsqfVOGUSOyxOzuht8zojE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707515429; c=relaxed/simple;
	bh=CtFnZntUSVmUiczX9BA9vmGqR/J2n35aQJgg9DfrCm0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DypYB19IA57Mw1NntCyYkDSzEkqSDxD8ObBaJr0rRycDohoebxH2VXVTzKE8sgovVQRp5+vIw8M2zCg61hhZXFfL8QGvK2MB/8C2gPZ/rgODzt0U76KtwDfDSXlpeAiv5i2hAx2Jzm7Kg7mQZEiGjqf6oTcFmW/XnSkcNY4luRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKVz9dk2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB592C433B1;
	Fri,  9 Feb 2024 21:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707515428;
	bh=CtFnZntUSVmUiczX9BA9vmGqR/J2n35aQJgg9DfrCm0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FKVz9dk2TUl+pJGtts4QCcfcgJNFekMhtoxMr+afk/5fpaRPz5pQBVoATotNtS3Yh
	 WAEsHevU2728pHqjgH2uYErzMvH/86H9cJJWUQFUC9JdHbcWFGs+nbx0KTFGRhf2QA
	 EZ69v01dLnVu2UqZrX7KYRu7UNHyQa2R4ArcUzVRcOl3dl2s0XWbvW6hYKNgBaYzh+
	 tI1jvnIOdSvti5ya4OIezumlv96mlTb/5G9jI7gfebg5tN2vSdUvLKz1uz9+bIUhLG
	 C0ifHvGZP/00MLcvpQFPGhJgnepNg9JC9/j6hV8eACY57rbpwaK67MzNs4zvoidcKy
	 YQNNMauPjyAUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8D39D8C98B;
	Fri,  9 Feb 2024 21:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] bnx2x: convert EEE handling to use linkmode
 bitmaps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170751542875.4610.14368046036204129985.git-patchwork-notify@kernel.org>
Date: Fri, 09 Feb 2024 21:50:28 +0000
References: <948562fb-c5d8-4912-8b88-bec56238732a@gmail.com>
In-Reply-To: <948562fb-c5d8-4912-8b88-bec56238732a@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
 davem@davemloft.net, andrew@lunn.ch, linux@armlinux.org.uk,
 aelior@marvell.com, skalluru@marvell.com, manishc@marvell.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 7 Feb 2024 17:35:28 +0100 you wrote:
> Convert EEE handling to use linkmode bitmaps. This prepares for
> removing the legacy bitmaps from struct ethtool_keee.
> No functional change intended.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - remove not needed linkmode_zero in bnx2x_eee_to_linkmode()
> 
> [...]

Here is the summary with links:
  - [v2,net-next] bnx2x: convert EEE handling to use linkmode bitmaps
    https://git.kernel.org/netdev/net-next/c/1c96a63af5c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



