Return-Path: <netdev+bounces-294387-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bsK6Nho3H2o0iwAAu9opvQ
	(envelope-from <netdev+bounces-294387-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 22:03:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E706319B0
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 22:03:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VPUYt6wl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294387-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294387-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3494B3061E8F
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 20:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E49C308F03;
	Tue,  2 Jun 2026 20:00:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139E72594B9;
	Tue,  2 Jun 2026 20:00:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780430414; cv=none; b=m4OdUOkuYobErz8+G1WiWrnMk9jMLVYI8s3WA8zFDHxzGyRmfMM/hVZZo9tbfgFoxche4EdolE/ELdkj9QiSHKLsDOBEXzp4fcpv9OWFc1U/U+8KdOAzmC2eUXcOV9m8VhaSTuZxV0NsqrjXWLCKIRCVSx/jemFDG0hF32q9eKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780430414; c=relaxed/simple;
	bh=ig99uttJ3INywOf9YOGjs0iQmIKkN5pwWs7pa+Sfjls=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hZYRAjgOM1NraCpm7nS6qzrsrS0WIa/59ifmzOXJULi2hdkbtpesY87s0zpziyh37c+HREWqEkXfKKM48UDzXljwvWJ/H8zwyrT5/cpiXzYrnz2qHzyu0g0Zs/KHSFCIsD8szfqlpyCLhtUgq77gcvxlS8RF26YYk/lA2Ye8LUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPUYt6wl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9531F00893;
	Tue,  2 Jun 2026 20:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780430412;
	bh=wDmt0+bYW+BiXIeOtAqJVe2jYnfCOGhWCkrws2RCxWo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VPUYt6wlsF2YFzggvcxKk6Rk1ZQBa7LTo8m9pPcqVz2hda1Bp4lCP1Xqt3wuv0rvd
	 fCCLCk2AhcKdyiQQnZizfRsfEwFNmCl8CBW2oVP7e7nLfTMqmjeah+bmHMWpFcznMG
	 PhpVUjVPc4TngojTPvjdS7Qc3wLLxR57as9VoQz/KEDqIJ+gvJe/hBb/kxnH6mTLo0
	 9CaNA7JpRsWFBBiCnwvo4k7PdBnhlp4otN5sfU7N9VlQL3itjqKwSW/InnRukVdUgJ
	 9zt2o+R9iOi2sstKot4dlLLubTmax3POklDYwYXGPbj3Bk31weA0qJF0BurUbSN8T3
	 yLmYLI/2lUuDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B5C3811A6E;
	Tue,  2 Jun 2026 20:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: drv-net: tso: add new tests for
 ip6tnl, ipip, and sit tunnels
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178043041439.1026900.2229242425685341727.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 20:00:14 +0000
References: <20260529-tso-tunnels-v1-1-3771ee9eaaa9@gmail.com>
In-Reply-To: <20260529-tso-tunnels-v1-1-3771ee9eaaa9@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294387-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:daniel.zahka@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:danielzahka@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 32E706319B0

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 May 2026 05:45:55 -0700 you wrote:
> Add new tunnel test cases for ip6tnl, ipip, and sit. ip6tnl supports
> ipv[46] as inner l3 header, and the other two tunnels only support a
> single inner l3 type.
> 
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> ---
> Example run:
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: drv-net: tso: add new tests for ip6tnl, ipip, and sit tunnels
    https://git.kernel.org/netdev/net-next/c/b04015d769cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



