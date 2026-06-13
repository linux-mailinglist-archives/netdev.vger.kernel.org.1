Return-Path: <netdev+bounces-299052-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nuEUF5XJLWockAQAu9opvQ
	(envelope-from <netdev+bounces-299052-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 23:20:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B969867FC52
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 23:20:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Xx1TXxSa;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299052-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299052-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF6D6300D68D
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 21:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66512388E76;
	Sat, 13 Jun 2026 21:20:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D453596F8
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 21:20:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781385616; cv=none; b=uKsZnABtBKea88yBvwR/wl/1LXp8HDFcSD/LU1i6b6GzZJJ0K6Wfjzde1jXW0HYxwwSszmmyDgi+QWGVmrXwzmMuu2xmvrQfvvqeZASRsL62omOsgrj6eUxEL04rOhOGFNFXAGXDw54JUlW2YPo//Kt9tndE6GVT89IAQkUHj/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781385616; c=relaxed/simple;
	bh=ebTTSNe9LJ3qXW5DSd18/Sv46y3AwdemOmGHewN51o4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UK98WtTomMDpcRzj/q+GBhEAfO/RCXb/Y3Rp2knedPLtJ1HMF43wMX+Zlrk2EdTmleQRSHigHRyXmLNQ33Qyr7yGpUt9B5vHhYWYI4NmMPAbmUA12kkdSWCHCkZr7gZQxEUTSvsYve1U1AFNrQG+rJYiqxHnmb5TVWxylMGs/48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xx1TXxSa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393661F000E9;
	Sat, 13 Jun 2026 21:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781385615;
	bh=I4kzmpmCTTRcxfTkHzZI6KgBD0oGVt0Td+ywSBpsUes=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Xx1TXxSaqI7tsoPemAtCD6oNNylkY7oNg2Wd8y7CcDaRH0jUpgA/YlflCh2eeDx2P
	 REzoe4BF/BILZOtMzXw6fTSl+GyeM+d0ebqiV6t+QaG2vALnHNidoCXwe+E69SsThB
	 caBY7yuUAPool1RLSemJ5Vn6fQ3boTv1lQJIfJbRT4CgUsGhRCaNdJOjZq8G/8gBtz
	 GyYVB+Qzxw49qtcGMiuCnQD6KqQfyJSAnifFscB85/h+RZxROJ1y4Dz6POy/UZX+5M
	 wv21uJqUjwwFlyGphrstgWeKjQI/qr5bBX87OUUAtGVrvoB3Isr3xlxI8yaD5xlupe
	 m31MBxN3RixLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9391D3A54A32;
	Sat, 13 Jun 2026 21:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/3 net-next v6] ipv4: centralize devconf sysctl handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178138561113.1597380.7779221670234945181.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 21:20:11 +0000
References: <20260609204520.4670-1-fmancera@suse.de>
In-Reply-To: <20260609204520.4670-1-fmancera@suse.de>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, nicolas.dichtel@6wind.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-299052-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:fmancera@suse.de,m:netdev@vger.kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:nicolas.dichtel@6wind.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B969867FC52

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Jun 2026 22:45:18 +0200 you wrote:
> The logic for handling IPv4 devconf sysctls is scattered. Notification
> and cache flushes are managed in devinet_conf_proc(), while a separate
> ipv4_doint_and_flush() function and DEVINET_SYSCTL_FLUSHING_ENTRY macro
> is used for properties that solely require a cache flush.
> 
> This patch refactors the sysctl handling by introducing a centralized
> helper, devinet_conf_post_set(). This new function evaluates the changed
> attribute and handles all necessary operations like triggering netlink
> notifications. It returns a boolean indicating whether a routing cache
> flush is required.
> 
> [...]

Here is the summary with links:
  - [1/3,net-next,v6] ipv4: centralize devconf sysctl handling
    https://git.kernel.org/netdev/net-next/c/3a29b55505f3
  - [2/3,net-next,v6] ipv4: handle devconf post-set actions on netlink updates
    https://git.kernel.org/netdev/net-next/c/489730ec2a73
  - [3/3,net-next,v6] selftests: net: add test for IPv4 devconf netlink notifications
    https://git.kernel.org/netdev/net-next/c/32229484e381

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



