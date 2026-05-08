Return-Path: <netdev+bounces-286052-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HJGKqZ0/mkzrAAAu9opvQ
	(envelope-from <netdev+bounces-286052-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 01:41:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE4D4FCDD3
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 01:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9EC9B300FCDE
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 23:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB441367F4A;
	Fri,  8 May 2026 23:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dvfl50An"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8742536494B;
	Fri,  8 May 2026 23:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778283661; cv=none; b=qYmd4PxB7oQw0+klIVR8rUlOSVrvyF3JcU8aguIL3zcyJyzK/p0YzLvxlD6zUxwRa52fW/f/db+d1tjoAkXvEHSt+GGJIavAgqMWmkP7YwAc9j05wq/ZeyfeAYka6+ICzru1nOIwYj/MWeB3gb7VMLGppiwjyWnUJ3ZQHaVHNV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778283661; c=relaxed/simple;
	bh=Z/8KTR3j+ve+V99wkggaNMSNth3+9ByymkKWAYxhruQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YEJFJ4OC7nd44V6QTEbi1DVI1py79YuH/AXPfMlW8+wwzzM7i+0P59IPdLd+GiFjgSpBptPncV+lhayFYFhcuqV/ckPeBFNWPE6umAV+WeBURcWfumoRJBkJt+0/YhJuvJLnk2BFstGAi1oxIOJ7C9v0wRlEq7V/E1x9DT8agXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dvfl50An; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2141FC2BCB0;
	Fri,  8 May 2026 23:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778283661;
	bh=Z/8KTR3j+ve+V99wkggaNMSNth3+9ByymkKWAYxhruQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Dvfl50AnyAJgNyA/he+IRvFoDyWrWecB0Az4Vig0+vX74ZwitTku1NQBbbYhFE9np
	 CT2+V5WiFQ3zmCsEwj3PuQqJwjNsCETj5T8cC9qU1IEl8jwW0jug5Ba0VxKLwujjjv
	 2JMagvng++bLEiM8+dYEsZTVY2RUgAFoMhDjx4aYYSSEWJLDBs9SPOwamYje+Iumuz
	 EMT7bp9ttkoPNU/USVReeu0ksQqGuXdmBnoUQClWpGshv/TzyBbwcr9dndTv2iJbOc
	 IpI/P/Jsb2YgO0zH6KxpOc4dZgR4BGrHTxV8PfWzRehWz+GgMT5KmrexAdcqUXsrX5
	 IBpWaL5RN3LVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EA438119DF;
	Fri,  8 May 2026 23:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] Add USB Ethernet controller (LAN7500) node in
 VAR-SOM-OM44 devicetree
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177828360953.897985.17310434488861318624.git-patchwork-notify@kernel.org>
Date: Fri, 08 May 2026 23:40:09 +0000
References: <20260506-b4-var-som-om44-lan7500-v2-0-b8af59ab877c@bootlin.com>
In-Reply-To: <20260506-b4-var-som-om44-lan7500-v2-0-b8af59ab877c@bootlin.com>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, aaro.koskinen@iki.fi, andreas@kemnade.info,
 khilman@baylibre.com, rogerq@kernel.org, tony@atomide.com,
 o.rempel@pengutronix.de, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, nb@tipi-net.de
X-Rspamd-Queue-Id: CBE4D4FCDD3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-286052-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_TWELVE(0.00)[21];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 06 May 2026 14:13:02 +0200 you wrote:
> In this second version I added LAN7500 and LAN7505 definitions in
> microchip,lan95xx.yaml as requested by Krzysztof. I also added Nicolai's RB
> tag in devicetree patch.
> 
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---
> Changes in v2:
> - add Nicolai's RB tag in patch 2/2.
> - add LAN7500 and LAN7505 in microchip,lan95xx.yaml instead of creating a
>   new file.
> - Link to v1: https://lore.kernel.org/r/20260403-b4-var-som-om44-lan7500-v1-0-0dadde850143@bootlin.com
> 
> [...]

Here is the summary with links:
  - [v2,1/2] dt-bindings: net: microchip: Add LAN7500 and LAN7505 devices
    https://git.kernel.org/netdev/net-next/c/f3fd582d1705
  - [v2,2/2] ARM: dts: ti: var-som-om44: Add USB Ethernet controller node
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



