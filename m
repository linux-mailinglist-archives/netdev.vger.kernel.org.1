Return-Path: <netdev+bounces-294519-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZkLuOb6RH2opnQAAu9opvQ
	(envelope-from <netdev+bounces-294519-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 04:30:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A93633A5C
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 04:30:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DLZHpG6m;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294519-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294519-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 519773026C2E
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 02:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E7E3BE146;
	Wed,  3 Jun 2026 02:30:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAD0191F98;
	Wed,  3 Jun 2026 02:30:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780453816; cv=none; b=EDNHz+OJn0T+TRr2vBo+BxaODu05l1MfylhQ3eAbA7kg8GZyNnbUlvtp2ItCbIyqvfCy5fpR2KL8Glb545SjpCUDvBJ65LQYB/Vy6lZx03DUFxrmydoJlE63CBkngxtzGRqpk3ILAIu+AAL4W9cWNRSfA1ijA5cnk+EY6OkoiL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780453816; c=relaxed/simple;
	bh=9/uiqv8fw35Qw93n9wCZZjxe5mnQyONa5wF9QDXBccc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YLeuR9NgjGj5DF0ecH/xdzPWArRJOxE1YFMOXX3UAQ8STEmUEOFKrwvhxjjIGwslMlzX06kkT/NNd0dLEYYMzrBBa/r2CWRv7RBKa/cvPOvuqZSmbzP/ouDC4Dh08lRxCwvse4Uoyr3BjUBxGHZEU20zra04vDYhQwi6Am84e4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLZHpG6m; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93B01F00898;
	Wed,  3 Jun 2026 02:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780453814;
	bh=5ITnF7ay4ftLCHu/BLhxLwIG86UnJYyOAOI8BrdE0ZI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DLZHpG6m7uoCSKhyP/wwRLqkJtB9UHsOgNgWfSqZ8eUEwGkGNUTSDvXVkZo95oHbB
	 5NC0vB22iHYbE7AZRgT6SFMQv7J5DDCO9USKsmLS7+NxIJMLS10rGrMXylIyVDwx31
	 9WnvtdB28ilL7Ajy6pmoWP1iL/xGWVz4Qw3foKpOs32y26p2Hq1UvGb1uTjvhGm/Qq
	 RTHtgddVdWGmcO37atKqcT2YUQtlkXMcFlS5DqDsqQIZ4IqTbVbbMVGNMqIr57XBjU
	 PA6SvYCJsAHlqkox0XdZSvF2VElhn+pMeJz/yzz21+NU+msBz31ywdxPK3PTI4ZgQn
	 tSsgVsiyE4yGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93AE8393003B;
	Wed,  3 Jun 2026 02:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] dpaa2-switch: various improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178045381614.1178989.6902316582033247652.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jun 2026 02:30:16 +0000
References: <20260528173452.1953102-1-ioana.ciornei@nxp.com>
In-Reply-To: <20260528173452.1953102-1-ioana.ciornei@nxp.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-294519-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ioana.ciornei@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 70A93633A5C

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 May 2026 20:34:47 +0300 you wrote:
> This patch set is a comprised of improvements and fixes for
> long-standing bugs which were only caught by sashiko while reviewing the
> LAG support patches for the dpaa2-switch:
> https://lore.kernel.org/all/20260512131554.952971-1-ioana.ciornei@nxp.com/
> 
> In order to not just add to the already big set, I am submitting these
> before any v3 of the LAG support patches.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] dpaa2-switch: rework FDB management on the bridge leave path
    https://git.kernel.org/netdev/net-next/c/efc1d92eacf0
  - [net-next,2/5] dpaa2-switch: fix the error path in dpaa2_switch_rx()
    https://git.kernel.org/netdev/net-next/c/74c1c9f5c0c3
  - [net-next,3/5] dpaa2-switch: remove duplicated check for the maximum number of VLANs
    https://git.kernel.org/netdev/net-next/c/9e9f5e299805
  - [net-next,4/5] dpaa2-switch: support VLAN flag changes on existing VIDs
    https://git.kernel.org/netdev/net-next/c/9111f0286117
  - [net-next,5/5] dpaa2-switch: fix handling of NAPI on the remove path
    https://git.kernel.org/netdev/net-next/c/e23d7c8c1d4b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



