Return-Path: <netdev+bounces-292512-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cG6tAFmfF2rlLQgAu9opvQ
	(envelope-from <netdev+bounces-292512-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 03:50:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2AD5EB9CE
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 03:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 298F430AAEC3
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 01:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87961279DC3;
	Thu, 28 May 2026 01:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZX/DTnc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6597C1F5858;
	Thu, 28 May 2026 01:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779933012; cv=none; b=NpFQq6hUrqKuOqUuvPS4+i+byaqC/bEVfoanXrBfcO3nM3R32OxwwGRqlaVB49hSjwnFEv0NpNlk7WcNmiCuz/0+b1uvyR5dtaYXqImSrhW3oJIfVgxVYRsRqtSAslrD59Cy8KONkTgEUEwQ+G20kMXELcwdp5qlXfsP7Idqy0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779933012; c=relaxed/simple;
	bh=4CU6JBS0dQWfLBpm3F8quBrkeVT5U090q0rGX5qMzmE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bXjHB4fTStBV6+UB/ekY04iAZfkdQZ5Iagjv6F5mgPBEIjqRZpeG1zn7Ple+AevJTYw43V6Ms75jVc/1+EEL/PntFga9dOg4KrXXcMlxhsaQVo5DxhpWqoq0MdszCGSo8unaXXoOMCs0oDKTFuAxIX1TBQ88lEJN3a+1n0GTztA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZX/DTnc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBDD51F000E9;
	Thu, 28 May 2026 01:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779933011;
	bh=uOox2uRaVHzcxzDbkU1ncr7dwdyroKxjIXuOl3sptoA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oZX/DTnc5s5KY+hnrBUXkHaGKUTcrVSXOrneobeG6+kpyp5DlCoKLblCcDIXfwxpr
	 OcclAJvDXsKKTqcCyL5GYOFn9iWXzb5MyCZaA6Z6jxUFRzqH+dob0X4vbdHS31CyU9
	 EnNE1fakLRMFjDnk7tD2tTBMZlLN6wYSKHtaOSgTxVFW8Om1iJ6u299CJ+WQ2Uzdx0
	 nz8OqqFIAKUbUPbMJEhqsus+6jp8oQXUSCgm9xzb2rlie8Eql9fOoowbJH7BIlmtMX
	 XSt86LNjLEfBOe//QMZR2gpGQEq/0MbqyudmaNZYRLlwVu6iW2TIBWC/hOGK/b729o
	 MjVc6ZgWNvIXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19BB5380CFEF;
	Thu, 28 May 2026 01:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/6] Introduce Airoha AN8801R series Gigabit
 Ethernet PHY driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177993301589.711996.780315750455117859.git-patchwork-notify@kernel.org>
Date: Thu, 28 May 2026 01:50:15 +0000
References: 
 <20260526-add-airoha-an8801-support-v5-0-01aea8dee69b@collabora.com>
In-Reply-To: 
 <20260526-add-airoha-an8801-support-v5-0-01aea8dee69b@collabora.com>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, angelogioacchino.delregno@collabora.com, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, kevin-kw.huang@airoha.com,
 macpaul.lin@mediatek.com, matthias.bgg@gmail.com, kernel@collabora.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292512-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,gmail.com,armlinux.org.uk,airoha.com,mediatek.com,vger.kernel.org,lists.infradead.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
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
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4E2AD5EB9CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 May 2026 16:58:05 +0200 you wrote:
> This series introduces the Airoha AN8801R Gigabit Ethernet PHY initial
> support.
> 
> The Airoha AN8801R is a low power single-port Ethernet PHY Transceiver
> with Single-port serdes interface for 1000Base-X/RGMII.
> This chip is compliant with 10Base-T, 100Base-TX and 1000Base-T IEEE
> 802.3(u,ab) and supports:
>   - Energy Efficient Ethernet (802.3az)
>   - Full Duplex Control Flow (802.3x)
>   - auto-negotiation
>   - crossover detect and autocorrection,
>   - Wake-on-LAN with Magic Packet
>   - Jumbo Frame up to 9 Kilobytes.
> This PHY also supports up to three user-configurable LEDs, which are
> usually used for LAN Activity, 100M, 1000M indication.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/6] dt-bindings: net: Add support for Airoha AN8801R GbE PHY
    https://git.kernel.org/netdev/net-next/c/ed28bd094db3
  - [net-next,v5,2/6] net: phy: Add Airoha phy library for shared code
    https://git.kernel.org/netdev/net-next/c/dddfadd75197
  - [net-next,v5,3/6] net: phy: air_phy_lib: Factorize BuckPBus register accessors
    https://git.kernel.org/netdev/net-next/c/5226bb6634cd
  - [net-next,v5,4/6] net: phy: Rename Airoha common BuckPBus register accessors
    https://git.kernel.org/netdev/net-next/c/e08f0ea6daf2
  - [net-next,v5,5/6] net: phy: Introduce Airoha AN8801R Gigabit Ethernet PHY driver
    https://git.kernel.org/netdev/net-next/c/fdb9bf7f1658
  - [net-next,v5,6/6] net: phy: air_an8801: ensure maximum available speed link use
    https://git.kernel.org/netdev/net-next/c/f6465e36353f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



