Return-Path: <netdev+bounces-278235-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMpwNFGB3Wl3fAkAu9opvQ
	(envelope-from <netdev+bounces-278235-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 01:50:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB243F4500
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 01:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E75E7301FD78
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 23:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C23E35AC04;
	Mon, 13 Apr 2026 23:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUthv2sj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394C830EF6C;
	Mon, 13 Apr 2026 23:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776124239; cv=none; b=bTJmXPWZ4YOf5vBaC1cC6BVH6Qrl2cYGGxcX3b7QgR48z/Rhb2X6nw73C4bigNGo0Lz0nIxGvOo+YJJT3Dkl+bp2zBcV7JHiN2uViPAOJEwqIEtUa3aWMFpjzgIxWVGI/WbMLrBTi/X5zgyLFdCApqUp26Bz4MXRhUPl5631uvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776124239; c=relaxed/simple;
	bh=PpLyzf9ofDSy9QX3ziyfomujOjdmap2nWynqmeoKVTU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AwnQ7iegwI9jLCpDF9qPF3bLZ4KjBd4xKsyvFDzH5J0JLIPY7yBUdYAMTNZI1Or4MtIz/vNzzjF1OaZdV79xa+x/QKRg0CVfZz+b5gjk14LQV2D1D76j0JplM/vnRiwXlDc7GR34QlEDC4LxcMXfoFroT55R0NPgn/f+z4nm1GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUthv2sj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A37C2BCAF;
	Mon, 13 Apr 2026 23:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776124238;
	bh=PpLyzf9ofDSy9QX3ziyfomujOjdmap2nWynqmeoKVTU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FUthv2sjMobgzCOJaGkmlcPNfbG4yUskuFbsVEyu2XriO/kDta2FMxfSKf42kljWe
	 aY1tKYG8R+aL+okpIWWhzkdWXXc2fTrmcFSIMWTHQHD6DJseCIK4TwK6eOEUK8qfsc
	 BLq4VW3spwyIuv2mhzPUcgTiR4+e0Pi5Gu2GJIYd3PTuQwRwIs1dWsfalzSdS/PSDQ
	 m0npmuEcYx4jArw9QlQ+bHZw1bLruCV9O/a2m/9Ju4Pski31mLfOXHs99AIRDI4BSn
	 riZ7KvpUPubTC2cxW5vSWP1XPIkhNhXc6iuiGAHZ/GhH4mIchzhP/LAEa8yx/pZBpI
	 RJLsS1faMOs7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC753809A0B;
	Mon, 13 Apr 2026 23:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: phy: realtek: use LEDCR page number define on
 RTL8211F
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177612421005.603926.8666412432128634594.git-patchwork-notify@kernel.org>
Date: Mon, 13 Apr 2026 23:50:10 +0000
References: <20260411105150.184577-1-olek2@wp.pl>
In-Reply-To: <20260411105150.184577-1-olek2@wp.pl>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 daniel@makrotopia.org, vladimir.oltean@nxp.com, michael@fossekall.de,
 daniel.braunwarth@kuka.com, ih@simonwunderlich.de,
 rmk+kernel@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278235-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_TO(0.00)[wp.pl];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,makrotopia.org,nxp.com,fossekall.de,kuka.com,simonwunderlich.de,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,kernel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3AB243F4500
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 11 Apr 2026 12:51:45 +0200 you wrote:
> Replace the magic number with an existing define for the LEDCR
> register page number on the RTL8211F.
> 
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> ---
>  drivers/net/phy/realtek/realtek_main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Here is the summary with links:
  - net: phy: realtek: use LEDCR page number define on RTL8211F
    https://git.kernel.org/netdev/net-next/c/43a2deae3661

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



