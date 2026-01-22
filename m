Return-Path: <netdev+bounces-252188-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKW6CTGhcWmgKQAAu9opvQ
	(envelope-from <netdev+bounces-252188-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 05:01:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F585618FE
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 05:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2FD914ECAEB
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F0A40F8E2;
	Thu, 22 Jan 2026 04:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCcwfd1l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3D242B723;
	Thu, 22 Jan 2026 04:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769054433; cv=none; b=csnKg3awltv5BiT0YWSdiV0+oLS/jAExAGIGvqpx2j0Y2hs0oX7b+6MCA3osOQFm0+KgDbuckmSBCDHPOHPqmTFp9FKCCSeWTVeBnjvFm6aZVikpVTKpRCgMLSYmzR3KUNeRmWVanQeh5qFn/MTe0Fz05QQpIFZYJ0g/CQOclMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769054433; c=relaxed/simple;
	bh=0TPXQcGcMeb4eSWYC3RqEvW0ZdfKCckPeLy2PavJ0R0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y2aV1bxI0oQvl19wovir0evmoK9FarvuApZTL8qXk5RrPkrbhQIwtx7j8JsBQgC70hupv42aAl2QoCsAqO46isCFUgd0yk6/BNfUTRw4TQJKtFW1iTwTkvu3fTgcsBZ2IYbM/0v1HhdmSmXEb6FKaY/2kBn0CpBIwMOp7Ob5rTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCcwfd1l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BC6C116C6;
	Thu, 22 Jan 2026 04:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769054431;
	bh=0TPXQcGcMeb4eSWYC3RqEvW0ZdfKCckPeLy2PavJ0R0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OCcwfd1lkmOcRECRwLzXlmifA802QJkRdfrj6rKGp9N4qPBxNHvDg0jajn7i97E4j
	 euaCzy1VKjqlY5y1+DQNez96fMf2sUQfdC2qIEEqxr50yML2wp3nYqDnm3xRae54RS
	 vSSFN8bD+RzO/Ge8gJkO44gaAmdp41a443moCgMrOMBdC9tTLNaO3ea8XV1442WZmh
	 TMTy8dKYbrOCtgX6KEBqMVjIJJohKbLQzhO1mwHiY3dkiUVNXlqnsW9oTtm0LvZEQm
	 5oaYAW9Fx9rr6TFsxv2JUy5gnAZNAaTyH0oFivFZBECVfWfXQHa5TipEREsrfLeRGI
	 hxT+y8MCOGKVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11A5B3808200;
	Thu, 22 Jan 2026 04:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net-next 0/5] PHY polarity inversion via generic device
 tree properties
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176905442759.1550373.5368781764680170431.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jan 2026 04:00:27 +0000
References: <20260119091220.1493761-1-vladimir.oltean@nxp.com>
In-Reply-To: <20260119091220.1493761-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 daniel@makrotopia.org, horatiu.vultur@microchip.com, bjorn@mork.no,
 andrew+netdev@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 ericwouds@gmail.com, lynxis@fe80.eu, chester.a.unal@arinc9.com,
 dqfext@gmail.com, sean.wang@mediatek.com, nbd@nbd.name
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,makrotopia.org,microchip.com,mork.no,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,fe80.eu,arinc9.com,mediatek.com,nbd.name];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252188-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8F585618FE
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Jan 2026 11:12:15 +0200 you wrote:
> Using the "rx-polarity" and "tx-polarity" device tree properties
> introduced in linux-phy and merged into net-next in
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=96a2d53f24787df907e8bab388cc3e8f180a2314
> we convert here two existing networking use cases - the EN8811H Ethernet
> PHY and the Mediatek LynxI PCS.
> 
> v3 at:
> https://lore.kernel.org/netdev/20260111093940.975359-1-vladimir.oltean@nxp.com/
> Changes since v3:
> It was requested that v3 be resent with just the networking parts, there
> is no change.
> 
> [...]

Here is the summary with links:
  - [v4,net-next,1/5] dt-bindings: net: airoha,en8811h: deprecate "airoha,pnswap-rx" and "airoha,pnswap-tx"
    https://git.kernel.org/netdev/net-next/c/44f62aa1b120
  - [v4,net-next,2/5] net: phy: air_en8811h: deprecate "airoha,pnswap-rx" and "airoha,pnswap-tx"
    https://git.kernel.org/netdev/net-next/c/66d8a334b57e
  - [v4,net-next,3/5] dt-bindings: net: pcs: mediatek,sgmiisys: deprecate "mediatek,pnswap"
    https://git.kernel.org/netdev/net-next/c/9f841922ebd0
  - [v4,net-next,4/5] net: pcs: pcs-mtk-lynxi: pass SGMIISYS OF node to PCS
    https://git.kernel.org/netdev/net-next/c/bde1ae2d52ab
  - [v4,net-next,5/5] net: pcs: pcs-mtk-lynxi: deprecate "mediatek,pnswap"
    https://git.kernel.org/netdev/net-next/c/8871389da151

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



