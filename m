Return-Path: <netdev+bounces-301244-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FrWlGpvnOWqhywcAu9opvQ
	(envelope-from <netdev+bounces-301244-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 03:55:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A91816B36ED
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 03:55:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CmMGfp5M;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301244-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301244-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88F44307C94D
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 01:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB0C386455;
	Tue, 23 Jun 2026 01:50:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4209637B011
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 01:50:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782179422; cv=none; b=DBrX+cplB9Mh7OV99q5hOLot9qtp69ttLF6r+eHqM7FJMH3OQs/1+RUsokMiP+6hzNyZWRp7441/qQ4LhGUx1snjDTbVM07DsDK4s6frRzfyOn+m5Qn2WALwO0lMUtleDV46+dHlo2jLadfsh1H9dn4aDMtaDJNjdjxDZGxhIqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782179422; c=relaxed/simple;
	bh=kWACsxTpXNpykEBCU5q8AHx5IQArXlAu2VrsYU8D/kA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UmqkUf6TjrOAiZ463xX6lKhV+oIThWk1hJpGXz72NI6Cs0UmiX+WxvlPLw70GZW/DRC2X6tISt85T3c92GQD3fg6kK5Q+iIoujU4BEbC/NVUfQnyo1ZrMLpODoxqfYAY+5pNSGswbfaMv+p2f0iPYTu9XZyUw/xY2XovnVLhZGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmMGfp5M; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A081F000E9;
	Tue, 23 Jun 2026 01:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782179420;
	bh=MgV3A0z68J02yKfbcLS+1+NrNtmGJJEdD8OBYFhKreE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CmMGfp5MqkETquWZfuifPfG3o6MDn4s1k4YE7F1mD01+4Q8TxEfmwNMUdACgtBuUj
	 xOLDMKGydMwPjP0vSJOBlbJGOpTFFosRibvuBZjtm3Hw/fyd0hqypBbrgt0x3Tr4vf
	 jjdZw2ZShaaWXMqecJSULJ1mw0OZhjpYta908pLBarn8TJz+eu/tR5On37NvYZOm3v
	 S2RoeYXT/m3498uNORNEhZQwr2MqN+W+/zGnoBefFwwExUaESERz4BN+ZjCyzZqNMX
	 vGOqnbADywjqy/pYmiQUnevBrJWSIQliKGIKx1oKoKHDLWaFCO4Brt9qYejIihfjD5
	 b8T1Wh3sSWNDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A993930A08;
	Tue, 23 Jun 2026 01:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] ipv4: fib: Don't ignore error route in local/main
 tables.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178217941104.1502813.488643379355950272.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jun 2026 01:50:11 +0000
References: <20260619212753.3367244-1-kuniyu@google.com>
In-Reply-To: <20260619212753.3367244-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuni1840@gmail.com, netdev@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301244-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A91816B36ED

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 19 Jun 2026 21:27:20 +0000 you wrote:
> When CONFIG_IP_MULTIPLE_TABLES is enabled but no rule is added,
> fib_lookup() performs route lookup directly on two tables.
> 
> Since the first lookup does not properly bail out, the result
> of an error route in the merged local/main table could be
> overwritten by another route in the default table:
> 
> [...]

Here is the summary with links:
  - [v1,net] ipv4: fib: Don't ignore error route in local/main tables.
    https://git.kernel.org/netdev/net/c/b72f0db64205

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



