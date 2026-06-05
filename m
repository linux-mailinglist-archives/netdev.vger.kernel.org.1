Return-Path: <netdev+bounces-295542-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lUVdF7skImo/TAEAu9opvQ
	(envelope-from <netdev+bounces-295542-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:22:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 462116445D2
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:22:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GHVJ9wgo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295542-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295542-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E1306301A2E9
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 01:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5FA3B8406;
	Fri,  5 Jun 2026 01:20:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954543B4EBB
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 01:20:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622423; cv=none; b=E/wRFqlHZX3o22BHyzicBul/NWR5UuHmjbG9ljHyxRD3BhDL3fZILahOuoUcxPyhuYKCOBNQTtN3htkemAHt6AWetuYGIizjpR/Bi4j/rXuYxBj7mG1cPRSr6m0bca+AUV0qvJQPAar/ZL33B5D0SXizwprkxaJrrTox21YMmNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622423; c=relaxed/simple;
	bh=l/r40VBOQDnOqZgdgyKpgvvV2c7x5HBfWSjTDu+dX3c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aKOfiOsThnjlSDoIjrERFqsTpBXL9OEV6fwEbVOKB1MkLMTKW4WAQM0fHKUNfQNo74etxDCaZEk99PCD7Iar3yBgt7mifDo2SpzOauVeflc0JrTWVEEAm5y6OmGamBh5W9cVP1COZZxvXdAzAiKFgPgmOyLsHcqGzmYTRrQNiUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHVJ9wgo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6041F0089A;
	Fri,  5 Jun 2026 01:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780622417;
	bh=ekDCFzXsFkRGi0GgX/tAP2jZ+LijT86BaWK9QE9YGXs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GHVJ9wgoY6Mi0gIj8tnQZ1Hl2FLY8x8UFf0KRYeR6Cek/heXF4+S5jDfWe6wHUBe+
	 POYMu8zKLrm2/R3CNYgoJjfEu3IJxry59PGdoTkVx9DwlN+6bLJ9x/Wa2LUOkug+me
	 rGsHDJd1jQ63RiJeWHhwKvCVvYQz/Z60iqZQoQ0IhjKJBT21evMw6SSVtj5dQ4C3ku
	 iVDQ8ZG1xkUZbqLlFUF2ZmCux6MxxVC0gKbIE3HOQsSCxj77LCmhXC8Vt2gxyrhIFU
	 mXydskyFMLjt2SDhnocevq3FcDQiv35aFVpSwbMF3kA37eDd0RQMDuOmiYgOR8y5L8
	 6nyAOaLH0TCLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B1B3930A8A;
	Fri,  5 Jun 2026 01:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] bridge: mcast: Synchronously shutdown port
 multicast
 timers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178062241739.3090676.1203878185997865685.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 01:20:17 +0000
References: <20260603103522.622411-1-idosch@nvidia.com>
In-Reply-To: <20260603103522.622411-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 razor@blackwall.org, horms@kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-295542-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:bridge@lists.linux-foundation.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:razor@blackwall.org,m:horms@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 462116445D2

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Jun 2026 13:35:22 +0300 you wrote:
> Currently, while four timers are set up during port multicast context
> initialization, only two are synchronously deleted when the context is
> de-initialized, just before being deleted.
> 
> This is fine because the structure containing the multicast context
> (either a bridge port or a VLAN) is only deleted after an RCU grace
> period and it will not pass as long as the timers are executing. These
> timers are also not supposed to do any work at this stage. They acquire
> the bridge multicast lock, see that the multicast context was disabled
> and exit.
> 
> [...]

Here is the summary with links:
  - [net-next] bridge: mcast: Synchronously shutdown port multicast timers
    https://git.kernel.org/netdev/net-next/c/7a188fcc18d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



