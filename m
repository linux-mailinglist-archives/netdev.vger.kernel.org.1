Return-Path: <netdev+bounces-301529-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oAgGJjg/O2qeUQgAu9opvQ
	(envelope-from <netdev+bounces-301529-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 04:21:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 002196BAE8E
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 04:21:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jGluRis+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301529-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301529-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B7FE309D211
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 02:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D82A2F7478;
	Wed, 24 Jun 2026 02:20:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809C12F5A06;
	Wed, 24 Jun 2026 02:20:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782267657; cv=none; b=et3/gvvgS0SX2kdHo9LIGbZcc21yqgutnHJFdmk/5qRbzEAzMjrXCFFtShlMi9lhjJvg4PIhGlVLC074paLrLK4PeETiwTknL+ekv6mEek+VkByVikNPE6TSqzHJ1A+LMPGPVOLG5467jK5W2SXfJCKEZCYvTBzTDJd79zbYle0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782267657; c=relaxed/simple;
	bh=Byt/a5YwQm/EbwETwfYl3nWaMfwquFX0yVQBFnyXY3c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=biNdp28LVJADhSy82a+/5Mi4ViOnHkad6RgwhA/QR9u5jAu9rNqQaoO1LZ+gRzbyFimdGW17QTYDv6LTppcR7gnu2mmYvjyFRVbaatWLHzOb7X5xdWVD5lwxZhbyEbmm3sEgDpB6vv1qlmY+WfgEM8U/827sKSQNNRotx32sKY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGluRis+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287D71F000E9;
	Wed, 24 Jun 2026 02:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782267656;
	bh=8iv5NZ0EhjGf04DMhe6kkoG+u1oTq9Sgycti5VptFuU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jGluRis+/NBJFDkJeRk23Bpx+TQDW8Ooq2S3tbRmwMv6TqWew9T0nYuxHRh0BDDj5
	 JWRVEj6IhBYdNGiheQcZ3C7xmzJ6QFqdwQuslzklmv0tzo01bhkjroImGTtqkC+FoS
	 8MptUCBlfkOpxJV/InHJ71m4SoCKap6o7xsvIulCzH0uSHoQ68T/V3iZZwUR0bhZUW
	 8hGmiMZWfoiBCu8+z2e5HZUecf/ym2SEzSu4mGGB43DtKg2U5evrP2uhPDE2k/AY0J
	 zefadzhz6/DjNm/7Y2ppEFa1qOPl+lm/15z+naO9+AOTtMQjKAS7L5tIjkp2SxNbzg
	 wainOGAJ/ITYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938A8393102A;
	Wed, 24 Jun 2026 02:20:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: Orphan SUNPLUS ETHERNET DRIVER
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178226764506.2513445.9930233925704678428.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jun 2026 02:20:45 +0000
References: <20260622180721.28334-1-wellslutw@gmail.com>
In-Reply-To: <20260622180721.28334-1-wellslutw@gmail.com>
To: Wells Lu <wellslutw@gmail.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 shital.gandhi45@gmail.com, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 shitalkumar.gandhi@cambiumnetworks.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,cambiumnetworks.com];
	TAGGED_FROM(0.00)[bounces-301529-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:wellslutw@gmail.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:shital.gandhi45@gmail.com,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:shitalkumar.gandhi@cambiumnetworks.com,m:shitalgandhi45@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 002196BAE8E

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Jun 2026 02:07:21 +0800 you wrote:
> I have left Sunplus and no longer have access to the relevant hardware
> to test or maintain this driver. Mark the driver as orphaned.
> 
> Signed-off-by: Wells Lu <wellslutw@gmail.com>
> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Here is the summary with links:
  - MAINTAINERS: Orphan SUNPLUS ETHERNET DRIVER
    https://git.kernel.org/netdev/net/c/89adcf17ee7a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



