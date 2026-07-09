Return-Path: <netdev+bounces-306281-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IVQTKIG7T2rLnQIAu9opvQ
	(envelope-from <netdev+bounces-306281-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 17:17:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A20732B95
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 17:17:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KStBVaM+;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306281-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-306281-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 568093069B1B
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 14:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219D13815F3;
	Thu,  9 Jul 2026 14:40:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8D337C91C
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 14:40:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608031; cv=none; b=gU0CpHP+sAT4R+Wqrq0Df/Q5NL4dk8VyK4kPrv+bTIfGIK0D+yhT24lNibCLWMjOMzR983WlUHxqVhtHcwwSVPt//pOg37KpGGaasNdzojAoeOFXzc0+tuGHcQlfW3du8XNGypZF94HZhSiS3m0YZmRuU1KZ3Ihyzya0DGvuH2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608031; c=relaxed/simple;
	bh=MLkOLtF8ZpsjMDyEzPrILqHZXdEXWU2sCDtlifoTaZM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lYp76ZQ7ij94Q1Lug9ckPRaGOgWYmGdbQPgc9PzJUtkRYlV1WK5Cklar75NveblE6DV1V+zF3fkwgfBLclNAuv1/ZUqqJbLrX4ASBZ5nip9w4CUE7pNueS48SdG5EQsJqgjE5zUKMkEPQEjBxK5T+YW/Z3rAhRhzjHPmF8lXAZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KStBVaM+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0531F00A3A;
	Thu,  9 Jul 2026 14:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783608029;
	bh=n+8TreBjJR0NsVNYH5XZdWC7GOkYGFx0XRVhgnNTGBY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KStBVaM+r2/2Pk+pv6ur1yaW56dTWeSrY//lpZQDFUPcDaSatOqUi5ffGBN9Mx1pe
	 SnOHkGAmVAd8J1n4cy98+FxuHkPH6eEdYxfZvm+EBjlMveWCz4/s+SrmyQazwUKceC
	 kfzHTppZjJIsmFWaJqXtbN9n3WQhlpM8Xvtm3ZYtSDjGK4M79tM5MLsvXYDi+E3NNq
	 DVScBPVpHe/S2X+33qFFo94ejqr4g4UiufQcbYDtj9m+SfFEysJjDxQlAZ5QXKp2R9
	 DMCD43h7E63q6+Y+NZpSCCLU+ZgUZ8Tog3NCS5F70dy26tliXr0g0t22XK0CjmsvXh
	 rOQDLCIhn8mAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A7A39250D8;
	Thu,  9 Jul 2026 14:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v2] ip: add OVPN device mode support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178360800813.3521873.860956225332938003.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jul 2026 14:40:08 +0000
References: <20260709102819.48809-1-marco@mandelbit.com>
In-Reply-To: <20260709102819.48809-1-marco@mandelbit.com>
To: Marco Baffo <marco@mandelbit.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, stephen@networkplumber.org,
 antonio@openvpn.net
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306281-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:marco@mandelbit.com,m:netdev@vger.kernel.org,m:dsahern@kernel.org,m:stephen@networkplumber.org,m:antonio@openvpn.net,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 89A20732B95

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Thu,  9 Jul 2026 12:28:19 +0200 you wrote:
> ovpn devices (OpenVPN data channel offload, kernel v6.16) can already
> be created with "ip link add ovpn0 type ovpn", but the mode is always
> left to the kernel default (p2p mode).
> 
> Add ovpn link type support so that point-to-point (p2p) or multi-peer
> (mp) mode can be selected at creation time and shown by
> "ip -d link show".
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v2] ip: add OVPN device mode support
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=92f89d0e66b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



