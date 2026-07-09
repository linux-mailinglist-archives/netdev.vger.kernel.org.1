Return-Path: <netdev+bounces-306290-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ltu/E4S5T2panQIAu9opvQ
	(envelope-from <netdev+bounces-306290-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 17:08:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A305732A50
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 17:08:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QqUGILlb;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306290-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306290-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5ED3D31CC95A
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 14:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59760386440;
	Thu,  9 Jul 2026 14:50:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F65136728B;
	Thu,  9 Jul 2026 14:50:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608636; cv=none; b=qeOQ2snnU+CE/b9XicjzFo0xMRnNlGu9c9CHFGmijYkV3qCtNy3yMQGZQZPQRvBt5koicG2VMmsfGmmaT83jUs33OAAtxX7FsRP9f+YFjI5HGVfxbSAzSg9ezCfUhuDxm4c1jt4P6MX816lMWLxqJz6cxLTkGKuzbERl3hiu9rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608636; c=relaxed/simple;
	bh=8feHtHaM3VYnuCxGdFVcvmw3tIcn2puXUaMOrM87c0k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WMswRVn1ONkLsv0AuQPByj7xdPHNVDRf332IbRFzZZh0NIg3SL2DcbJi0En8Jpu4HwnX/z04s7eO7Mk9+LqEgEgsNCrscTeeJ6gp+J6a3jU6mXG3B4wr3CFX0GoV3Nng8szrQc1jXtWAHYUH0h+r731aXZtos/xInXMBMiVRICY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqUGILlb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190631F00A3A;
	Thu,  9 Jul 2026 14:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783608635;
	bh=uv98MjtcWebOB4ubs2NPH7rl0e+o9gY62UBJp8DnjPI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QqUGILlbLe2WqUJoKjKeLIyR8GSLmStxxOYJKi3XydQsSr1W41Qa0ar/SeXSBgnH6
	 51WZ/B+xRkO0jnL4Tdn0vVN1HUxZ8rDxM1yggPHtl+4aC0gu6CvaIlyDlqeTseuuj3
	 kdCOz9pb0FiGnG27ioRjvQhQAFGGevrByi2CjMTZ9KkwHoV5eRq9unFpSXdL/G1QYr
	 07U8P3LIZLNesr5X6yuZw/gnpviXmCmJSd1Is4/XS2BO99ufAPtUjo9wN9c+cQaOgV
	 2Ex1c8E9G+ykmCyb8RU3W18ftPi2qUh+bsfkLs1JI0KWFnKh2khatjcbPtbv9rTQfA
	 xrhMqRuXW8aow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AF739250D8;
	Thu,  9 Jul 2026 14:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v5 0/2] devlink: support u64-array devlink
 parameters
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178360861364.3526087.13562155401332541364.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jul 2026 14:50:13 +0000
References: <20260709035016.911607-1-rkannoth@marvell.com>
In-Reply-To: <20260709035016.911607-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: stephen@networkplumber.org, dsahern@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com, pabeni@redhat.com, jiri@resnulli.us
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306290-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:rkannoth@marvell.com,m:stephen@networkplumber.org,m:dsahern@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:pabeni@redhat.com,m:jiri@resnulli.us,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8A305732A50

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Thu, 9 Jul 2026 09:20:14 +0530 you wrote:
> The kernel gained support for devlink parameters of type
> DEVLINK_VAR_ATTR_TYPE_U64_ARRAY.  These parameters carry a variable-length
> list of u64 values encoded as multiple DEVLINK_ATTR_PARAM_VALUE_DATA
> attributes.  This is used by drivers that need to expose ordered lists of
> configuration values, such as the Marvell CN20K npc_srch_order parameter.
> 
> This series updates the devlink tool to handle the new UAPI and adds
> show/set support for u64-array parameters on both device and port params.
> 
> [...]

Here is the summary with links:
  - [v5,iproute2-next,1/2] devlink: use DEVLINK_VAR_ATTR_TYPE_* in param show/set
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=32e2a8832a53
  - [v5,iproute2-next,2/2] devlink: support u64-array values in devlink param show/set
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=37c491d82ceb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



