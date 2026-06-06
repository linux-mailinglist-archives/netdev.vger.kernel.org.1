Return-Path: <netdev+bounces-296024-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2AAGFpqBI2reugEAu9opvQ
	(envelope-from <netdev+bounces-296024-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 04:10:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 528E364C309
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 04:10:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TfEVPsW2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296024-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296024-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 776403010526
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 02:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9889926B08F;
	Sat,  6 Jun 2026 02:10:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FBC26A0DD;
	Sat,  6 Jun 2026 02:10:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780711828; cv=none; b=HK3XAJLyVh7as68iWNP/ITEl7al7FTnoj8nY3hcUapGsftmxvhrsrq+qs8zHaSwaWcKbcXuHVrxDtGYnJUclgsJH2IkVrF9GqPhfY3pyYdcI6+w/7No0bpm+Ldx1T+2ZGETgmjbi/f7Nwme9XOwS7QwMgqrNwciAG8gi5wS3NbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780711828; c=relaxed/simple;
	bh=3oET53BtoKjeKejtdmFfbuVC8CFcPGGTFD5nOUfdbAI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oZ4te+a3foh0Dt2R533CqaN+C/0gdpLXZR3HOJ6RtINgsw33EkQMu+EmQl399SmYXPdZMopbeJlLWZWIfwg+pHV7jHaFUacl8m67HR2fMlZ48yPekFtw49p+h8aFlHmqbkdI9bHwp8tEovcaXq3T6Z2fL0E2tQ6+KPwyaMQju7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfEVPsW2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B5F1F00893;
	Sat,  6 Jun 2026 02:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780711825;
	bh=kMLca7nfWY9RizQfqQEviPppjRfuz0UhEGaO/4cVevs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TfEVPsW2JDPmWdJxiQloAJKrWYcn3IRGJ6yfNo8yR35J7dWRDFDbOaS5l/Duu393s
	 r61sP4XE9OxzRF3L2TvMvtCPVtG0h5Ra9cTPqTrSsZLOyLQ0ml2m9dpVfmL0CfEFm2
	 ywl+PjirMHj7sUS/bAKuVauTatFDdExPcn7dEzpqCn8XPOTKQbnnPdnoy7pi5GDfOV
	 v8PZ01Lu+CQBfaf+Kgl0lmFfCpfTjvsYzFAwvAAqwLgVyALQXaEEnPk+QGNkWTqEzd
	 zk7o8yl41w5La+mgN8zQGebVZHqlF8dqKb2QvKyoPSPTablFn0J9XqamR5xjFK8duD
	 OnilhwFDZ9uWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198E43930A9C;
	Sat,  6 Jun 2026 02:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v9 0/6] net: airoha: Support multiple net_devices
 connected to the same GDM port
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178071182563.3993660.16859528929943768907.git-patchwork-notify@kernel.org>
Date: Sat, 06 Jun 2026 02:10:25 +0000
References: <20260603-airoha-eth-multi-serdes-v9-0-5d476bc2f426@kernel.org>
In-Reply-To: <20260603-airoha-eth-multi-serdes-v9-0-5d476bc2f426@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, ansuelsmth@gmail.com, benjamin.larsson@genexis.eu,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org, xuegang.lu@airoha.com,
 madhur.agrawal@airoha.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296024-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org,airoha.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:ansuelsmth@gmail.com,m:benjamin.larsson@genexis.eu,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:xuegang.lu@airoha.com,m:madhur.agrawal@airoha.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 528E364C309

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 03 Jun 2026 08:00:14 +0200 you wrote:
> EN7581 or AN7583 SoCs support connecting multiple external SerDes (e.g.
> Ethernet or USB SerDes) to GDM3 or GDM4 ports via a hw arbiter that
> manages the traffic in a TDM manner. As a result multiple net_devices can
> connect to the same GDM{3,4} port and there is a theoretical "1:n"
> relation between GDM ports and net_devices.
> 
>            ┌─────────────────────────────────┐
>            │                                 │    ┌──────┐
>            │                         P1 GDM1 ├────►MT7530│
>            │                                 │    └──────┘
>            │                                 │      ETH0 (DSA conduit)
>            │                                 │
>            │              PSE/FE             │
>            │                                 │
>            │                                 │
>            │                                 │    ┌─────┐
>            │                         P0 CDM1 ├────►QDMA0│
>            │  P4                     P9 GDM4 │    └─────┘
>            └──┬─────────────────────────┬────┘
>               │                         │
>            ┌──▼──┐                 ┌────▼────┐
>            │ PPE │                 │   ARB   │
>            └─────┘                 └─┬─────┬─┘
>                                      │     │
>                                   ┌──▼──┐┌─▼───┐
>                                   │ ETH ││ USB │
>                                   └─────┘└─────┘
>                                    ETH1   ETH2
> 
> [...]

Here is the summary with links:
  - [net-next,v9,1/6] dt-bindings: net: airoha: Add GDM port ethernet child node
    https://git.kernel.org/netdev/net-next/c/a4597204b681
  - [net-next,v9,2/6] net: airoha: Remove private net_device pointer in airoha_gdm_dev struct
    https://git.kernel.org/netdev/net-next/c/4408f5206809
  - [net-next,v9,3/6] net: airoha: Support multiple net_devices for a single FE GDM port
    https://git.kernel.org/netdev/net-next/c/a9c2ca61fec7
  - [net-next,v9,4/6] net: airoha: Do not stop GDM port if it is shared
    https://git.kernel.org/netdev/net-next/c/99b9d095d71e
  - [net-next,v9,5/6] net: airoha: Introduce WAN device flag
    https://git.kernel.org/netdev/net-next/c/7758cb462ff7
  - [net-next,v9,6/6] net: airoha: Support multiple LAN/WAN interfaces for hw MAC address configuration
    https://git.kernel.org/netdev/net-next/c/ef2aee987174

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



