Return-Path: <netdev+bounces-298862-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W611IAKuLGqSVQQAu9opvQ
	(envelope-from <netdev+bounces-298862-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 03:10:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C7567D67A
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 03:10:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Y0jfBpME;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298862-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-298862-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 191BB3016C6F
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CFA235358;
	Sat, 13 Jun 2026 01:10:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DF21DDC1B
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 01:10:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781313021; cv=none; b=VV/AVSecUqsCKqaZiAfSgHT801QGSXku33rIm7Rjvsjw6MrBLMhYTpAjFuEiNmoNAr1p8g4LZAM49xaHLT9TSAR5AM3waoVRw8KzvYGApXB2m8KpXbGRRvEufHnLDIznaXnEiD1Ok1EaOUIMxw5y+5nZVcO5ZaGhgOoqKsxJU8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781313021; c=relaxed/simple;
	bh=9vHFjbt/wsWQatJePMQrK/eFayDBSHziZU3Dcj/b1mg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VKwaCAprux52V7lDZ+YhoNAZ80f0KkMQC8STVpKd80LRp7HDhCCvxLfuERvle+cQ4YODK39heYER8jxU/tYooxccBKq9ubXCs1Hi+Gii2v89GXbSM9cWiCY7b8jEvriY980R4W6vmo4/G7K81MHm0DjuGrycmhWZX/bUUsSOVQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0jfBpME; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B541F000E9;
	Sat, 13 Jun 2026 01:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781313020;
	bh=HM7phR7ArlnYN7eFaM+6ttPKRw2bRHAo+mGjNH1LS6I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Y0jfBpMEYjDg0wCH1elHkTyjw1Aa995rEOJmvbr3KeiAh07fY4zroQCtMelIgSdl0
	 cocB02BzFugl9Z7TneBUPYxIaxEMvgVzqqXnd4Wg7YZUVFlqNodXIQER8Zl0Ymnaxz
	 zyFtMSoauTLWy44mpFfsMPjIpS+BVpU55H30ke9P7NR3rx3t9UP0pYqThm796nXZDH
	 aYB6GFHnJtPGDqWUmNNgUJ9vXCM941VcLNgtRINH47zH4ivtvzM3HBn9WFXhthWzmR
	 Vpp7Hi8dHQRa0gmp2KIb8QHeZ18ZXdnaH/4ZnnSU8W3vHAErdhVrJvI4LrQCnyQk1C
	 HAPNoCWievxjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198BA39E9607;
	Sat, 13 Jun 2026 01:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 0/5] net: bridge: take care of p->flags
 accesses
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178131301663.1317911.9588743141453529549.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 01:10:16 +0000
References: <20260611203453.3067462-1-edumazet@google.com>
In-Reply-To: <20260611203453.3067462-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 idosch@nvidia.com, razor@blackwall.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,nvidia.com,blackwall.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-298862-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:razor@blackwall.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 22C7567D67A

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jun 2026 20:34:48 +0000 you wrote:
> (struct net_bridge_port)->flags can be read/written locklessly,
> and thus can fire KCSAN warnings, or real bugs.
> 
> Prefer atomic operations (test_bit(), clear_bit(), set_bit())
> and use READ_ONCE() for the remaining uses.
> 
> v3: addressed Sashiko's feddback on patch 2.
> v2: addressed Nikolay's feedback on patches 3 & 4.
> 
> [...]

Here is the summary with links:
  - [v3,net-next,1/5] bridge: use atomic ops to read/change p->flags in sysfs
    https://git.kernel.org/netdev/net-next/c/391932e24915
  - [v3,net-next,2/5] bridge: use atomic ops to read/change p->flags in br_netlink.c
    https://git.kernel.org/netdev/net-next/c/e92df84bcc3b
  - [v3,net-next,3/5] net: bridge: use atomic ops to read/change p->flags (I)
    https://git.kernel.org/netdev/net-next/c/65b8de45ae05
  - [v3,net-next,4/5] net: bridge: use atomic ops to read/change p->flags (II)
    https://git.kernel.org/netdev/net-next/c/55b2d7ae7bea
  - [v3,net-next,5/5] net: bridge: use atomic ops to read/change p->flags (III)
    https://git.kernel.org/netdev/net-next/c/f76ae12b6ba3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



