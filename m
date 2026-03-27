Return-Path: <netdev+bounces-272316-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEj6HljexWk9CgUAu9opvQ
	(envelope-from <netdev+bounces-272316-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 02:33:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B42433DDD0
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 02:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7BFC03048539
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 01:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3CD312837;
	Fri, 27 Mar 2026 01:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXDXEZvr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF103126B1;
	Fri, 27 Mar 2026 01:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774575170; cv=none; b=BFjgnuFJi7E/HSRIgjidGtx5aJKV7azYkaflSAwF5cHLv9wPxVEA1VWs4zvgFvhBWtUEmZcd3viqPE2pWjy2b/2H6HutKboLK3pKia2jy/TI++1qTEDRO3iJIRzvtzqo2FM+Jljye/5Du2inoFgGW59F64pFjTis0EG+TXdzRBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774575170; c=relaxed/simple;
	bh=2jW+B2lXjwLgZb3cDkL7mX6Gb7T5UWGOWeSgPIBscW0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LzofXt7J/s6SncrrjcGuzqyVnrzAGPzWO2Hpj6lQzO9BBBwDISX91izdzgtcibl0gnBciiTereQrtJGKz/of8yo0kHA5J6ksC7AuEpzzp5r/wKQR60OuGJQN3/2bTrl/d66g914kCRz8KJ1qbkO8H5ybe6/QB/NJblO7j6lmaZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXDXEZvr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4761C19423;
	Fri, 27 Mar 2026 01:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774575169;
	bh=2jW+B2lXjwLgZb3cDkL7mX6Gb7T5UWGOWeSgPIBscW0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZXDXEZvrfbba5SXaPx+s9TyX3f3xwmko6tdteBUp4OqwMzZl2Tu3DijxDIkmFmNGw
	 PQI73u+fc0F62JnMperkHNN/7SG1wze0fLP8r5FfS3+XMYLHSQsUVT/5cKFSff4+4w
	 B9EU2vPnuacs3cFkGNUaC3kWDJPF5YsYUJIzGYmJCxhG2hNuLFW5bo9mo0SCnGiEPa
	 QzdDqnhMFZDvE285ndvp29Ns0cBLREcUN5xmVFjQj9N7KVgsOwsrmLBzqy57bAFCUE
	 5TJwCWQs8YgIyLaJ9k1ukwWOBbNTGDN7z4KzzKZmJ+eplrm0BT4ZbNzG1PjwQpgSYc
	 TKUelsOgpRznw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 400403809A07;
	Fri, 27 Mar 2026 01:32:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] net: stmmac: dwmac-socfpga: Cleanup
 .fix_mac_speed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177457515578.3250412.707977713955076913.git-patchwork-notify@kernel.org>
Date: Fri, 27 Mar 2026 01:32:35 +0000
References: <20260324092102.687082-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20260324092102.687082-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, linux@armlinux.org.uk,
 thomas.petazzoni@bootlin.com, alexis.lothore@bootlin.com,
 rohan.g.thomas@altera.com, mun.yew.tham@altera.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272316-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,davemloft.net,google.com,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,altera.com,vger.kernel.org,lists.infradead.org,st-md-mailman.stormreply.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B42433DDD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Mar 2026 10:20:55 +0100 you wrote:
> Hi everyone,
> 
> This small series does a bit of cleanup in the dwmad-socfpga glue
> driver, especially around the .fix_mac_speed() operation.
> 
> It's mostly about re-using existing helpers from the glue driver, as
> well as reorganizing the code to make the local private structures a
> little bit smaller.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] net: stmmac: dwmac-socfpga: Move internal helpers
    https://git.kernel.org/netdev/net-next/c/845a04411118
  - [net-next,2/5] net: stmmac: dwmac-socfpga: Use the socfpga_sgmii_config() helper
    https://git.kernel.org/netdev/net-next/c/a7be7cc12442
  - [net-next,3/5] net: stmmac: dwmac-socfpga: Use the correct type for interface modes
    https://git.kernel.org/netdev/net-next/c/9b04ecdfb876
  - [net-next,4/5] net: stmmac: dwmac-socfpga: get the phy_mode with the dedicated helper
    https://git.kernel.org/netdev/net-next/c/adf1536f79a5
  - [net-next,5/5] net: stmmac: dwmac-sofcpga: Drop the struct device reference
    https://git.kernel.org/netdev/net-next/c/9bd1af853750

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



