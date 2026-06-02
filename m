Return-Path: <netdev+bounces-294404-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ok1KOnU9H2oqjAAAu9opvQ
	(envelope-from <netdev+bounces-294404-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 22:30:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 681DA631BFC
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 22:30:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TPz3prVe;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294404-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294404-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4AFEC3035F2B
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 20:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AB4324B33;
	Tue,  2 Jun 2026 20:30:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5B235838E
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 20:30:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780432214; cv=none; b=q9u0K6AFEUSGw6JvonsZxnYyvYw7hHE7gNXJHPSt/VMWnfUSharFKxaj7RCQNdFfmV8jOZNehjnvEXBYstSHTiLmluOguCvQ22xBf4b5Mo1jdjWY3ThuxX3yErdKWE8BRFDpdKdlwOMLPH6NqrQHXiWNAb7EaUgx3jZCy5qe45w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780432214; c=relaxed/simple;
	bh=HjJqMpeHljdTYrToT5sxT92/3e4ZeXSmbeiktWXOx64=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KqB8C6flulXjk0f4Hgv6KhqEvyfL3gQ5pJGSrfb6b99Om7k9TVbRoUDfBhlhNHiJ58DavSAreuSeb6Bwe0q7KXTnYSt4OIiYebmwx7bPhOWV2EpXcvQQKw+TtXtBlcmp1CyRjeVRLGBPoZuBojGtBvfTILqrH9y1GWjaDxZU+/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPz3prVe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D4A1F00893;
	Tue,  2 Jun 2026 20:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780432213;
	bh=gjwMGrTESknD5peX+eFGJBM0//MZxOS4/vrUF8k4h4A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TPz3prVeOVPs6tmHop7zUrzU2L7EkX1/zBZUQPFQIzu3j1/B+Vt0vZh7knErzYWYY
	 AWSCvweUNkAe8As9Hy/CMzQOjIKgY7+g7d1NhqjaJSN7DYFOfSjXEOyssLEf0saPHl
	 lJojBMJE/Hfd0+JEFwwyiE8zYTIspelQhFYuVcoTc+qFlKpc5ynQHVE4JtYuwcG1Vo
	 Y9raz6xnyT3vo3QlCgIaH+oIOlTh3tyJ77U/5VcZDKBXpOJdBaFSm0g+mK4GbQmOQl
	 BoCgZhi7/HomqVfUoC7THg/LkS08QvPK1UzHX+LuGgIzx0ulUU4bvGhRWa2PlpLog/
	 DyRGp1RK/lIiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569AD3811A72;
	Tue,  2 Jun 2026 20:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] net: airoha: Preliminary patches to support
 multiple net_devices connected to the same GDM port
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178043221514.1036678.2722673754198790557.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 20:30:15 +0000
References: 
 <20260527-airoha-eth-multi-serdes-preliminary-v1-0-ec6ed73ef7fc@kernel.org>
In-Reply-To: 
 <20260527-airoha-eth-multi-serdes-preliminary-v1-0-ec6ed73ef7fc@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, xuegang.lu@airoha.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294404-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:xuegang.lu@airoha.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 681DA631BFC

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 May 2026 12:21:14 +0200 you wrote:
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
  - [net-next,1/6] net: airoha: Introduce airoha_gdm_dev struct
    https://git.kernel.org/netdev/net-next/c/ec6c391bcca7
  - [net-next,2/6] net: airoha: Move airoha_qdma pointer in airoha_gdm_dev struct
    https://git.kernel.org/netdev/net-next/c/528c5153a557
  - [net-next,3/6] net: airoha: Rely on airoha_gdm_dev pointer in airoha_is_lan_gdm_port()
    https://git.kernel.org/netdev/net-next/c/eca4f59b5367
  - [net-next,4/6] net: airoha: Move qos_sq_bmap in airoha_gdm_dev struct
    https://git.kernel.org/netdev/net-next/c/069626af6dfa
  - [net-next,5/6] net: airoha: Move {cpu,fwd}_tx_packets in airoha_gdm_dev struct
    https://git.kernel.org/netdev/net-next/c/962c17dd2878
  - [net-next,6/6] net: airoha: Rename airoha_set_gdm2_loopback in airoha_enable_gdm2_loopback
    https://git.kernel.org/netdev/net-next/c/842a7ee50d68

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



