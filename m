Return-Path: <netdev+bounces-299664-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BhpVLIqNMGppUQUAu9opvQ
	(envelope-from <netdev+bounces-299664-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:40:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0439768A9D1
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:40:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QkuZZPZR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299664-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299664-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C08530C3E5E
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 23:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67BF340403;
	Mon, 15 Jun 2026 23:40:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF0834887E;
	Mon, 15 Jun 2026 23:40:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781566824; cv=none; b=Ka0ZqirOJ8AhgWOBw8tkwEj4cuTVFL/in1fYcvB+tY310f8yplCIu1Qb/em3Xvh5PBYnkmxy8ELZw0YJcqE60+fX0ICHfazz+eu9F7+hEijkzY58y5Zws1Ue9+IHvyZvtEHfxjkCSZpt1wrgHPu9u4wXK7Pn7z0KliPk6gslOyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781566824; c=relaxed/simple;
	bh=ZyOLMaLwJs6p6k/MNvaM2k6PKzaG9mXiPuBRfBfovk8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XF4we298+du41tgdIwOxJAlOm4A+ZIAFepRPWFyGB1aeDqq6Xtf224MZPzhc+9Cbt4z0AOVAUM4hUgX5k3k6Oh5s001F5IXzD4bRohm/U5QkI4knlNx9PwKsx+h1x8MLtAlWTUEem2FQ5F4gCv+MtZOU9T7Z+/WQcBUmga60eFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkuZZPZR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4D71F000E9;
	Mon, 15 Jun 2026 23:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781566823;
	bh=+1apkrB1jbaFhw7WCwrOwJDH1R+HLyNSgYxDojcEzTQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QkuZZPZRfnL1Eptpvfskua2yScD3nyWGmdhfvWNs1MWDvy9FyHM4kjp7z0+mBephC
	 fMPeNTjIIDDPdxqsI6tDzTW+v9ziCpsg8RntwOqtTZzcb0gMW3TqAuH0517KZGMfti
	 FuRMsSc+HWCfsHuhrswN+DEbh03o2B5l3NU1a2+p7lic1FNWCaHK807IRIcZFzvzO5
	 sDWDLyGwN8904FQ7JfWPgf2D6vt+yvNMlvCGSJczUtvPdcQBYncU8HOZRlzyP5cyvE
	 MewLRBrhNEFYLDxgfgvmOvYx4ZI/vJySklKssl5vMJdqzYWAIfxnocJZEQCX/mYt8N
	 nqZEaN5mGB25Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939433839A08;
	Mon, 15 Jun 2026 23:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5 0/4] MAC-PHY interrupt changed to level triggered
 interrupt
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178156681813.339383.7315045393443753551.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 23:40:18 +0000
References: <20260611-level-trigger-v5-0-4533a9e85ce2@onsemi.com>
In-Reply-To: <20260611-level-trigger-v5-0-4533a9e85ce2@onsemi.com>
To: Selvamani Rajagopal <selvamani.rajagopal@onsemi.com>
Cc: parthiban.veerasooran@microchip.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 pier.beruto@onsemi.com, andrew@lunn.ch, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, conor.dooley@microchip.com,
 devicetree@vger.kernel.org, Parthiban.Veerasooran@microchip.com,
 Selvamani.Rajagopal@onsemi.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299664-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:selvamani.rajagopal@onsemi.com,m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:pier.beruto@onsemi.com,m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:conor.dooley@microchip.com,m:devicetree@vger.kernel.org,m:Parthiban.Veerasooran@microchip.com,m:Selvamani.Rajagopal@onsemi.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0439768A9D1

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jun 2026 14:55:37 -0700 you wrote:
> According to OPEN Alliance 10BASE-T1x MAC-PHY Serial Interface
> specification, MAC-PHY interrupt is "active low, level triggered".
> The specification mentions about the conditions in which the IRQ
> is asserted and deasserted.
> 
> Bug is inadvertently introduced by treating the IRQ in the OA TC6
> framework driver and in dt-binding YAML file as edge triggered.
> 
> [...]

Here is the summary with links:
  - [net,v5,1/4] net: ethernet: oa_tc6: Interrupt is active low, level triggered.
    https://git.kernel.org/netdev/net/c/b542d13fab0f
  - [net,v5,2/4] net: ethernet: oa_tc6: mdiobus->parent initialized with NULL
    https://git.kernel.org/netdev/net/c/a221d3f7e3f3
  - [net,v5,3/4] net: ethernet: oa_tc6: Remove FCS size in RX frame
    https://git.kernel.org/netdev/net/c/a5a1d11dd372
  - [net,v5,4/4] dt-bindings: net: updated interrupt type to be active low, level triggered
    https://git.kernel.org/netdev/net/c/31e56112e654

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



