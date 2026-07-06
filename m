Return-Path: <netdev+bounces-304952-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gbl8AQqbS2opWwEAu9opvQ
	(envelope-from <netdev+bounces-304952-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 14:09:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48913710549
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 14:09:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lSB5PUMZ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304952-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304952-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E64D356D053
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 10:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB8343B6C9;
	Mon,  6 Jul 2026 10:00:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E588D43849A
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 10:00:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783332027; cv=none; b=kFe1BLv/qUr3lHD2rM0BmPODx9GDGA+WxYUTH4odZLnHWhZA5WfVMkOmfB6dLQMzboMxGA6/K7Z11KKSdWma2oUH4H2mKkB8hyQ1i2FEjcqL+fCGFtwlUcRKQi/RSVJ8jPHoQ/YIrMOR4j1Y91vAKIU56msIKwJXHdO39teA29Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783332027; c=relaxed/simple;
	bh=rHuJPPc5mO9Ua/QGPW6g6+WnTPqoSbnKGKwuUFThzKg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eZpjEFohRNpbYCFU6AyRR4sgQlqvhpJCgNSOrxTNOBuGfCY2VIIvwhZL7QlE+eg1lqaCNGnsaSPVebjfQ5BrWYcGLH6BTAZHKADMQ+D9dA2mlQKApxowxppIsK8N9KBDJDJhLg+EDbZDdoZM7QQ0VIaWAvS3wYISqrdfd5F5GTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSB5PUMZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA3A1F00AC4;
	Mon,  6 Jul 2026 10:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783332025;
	bh=b6fYZeEuOcjTBS1Iwl0tNdJQLy+QnxQeL9bfZEzIIVE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lSB5PUMZDVSwu8B/j9vkJ2zXdTJLW6wmxCjpG9cAw4LkhY/rNh5/SmsK9GwW+C3ZH
	 qCFJ8wu8wkcGpfYF1QPicXlwXyIhA/+UR16RxJp1Nqhm6XV+j5JYWE8d2vdgw1e+FH
	 ImvWbLma+4SMLhPFaIfhUPKPfsmrl6jMLeszajak1PDvygkBm5dGhx7gecLOB1rf0j
	 anRiR5DnRDoGzPpjHGG7TEDVlxmL7WRJOSS97pd7n1XhfocvpCStGeKivdY9wW/inL
	 m/B0/xKooqHYCxYlJwngoDEOMl7I8CVZ2Q6cBy2agj1LsKnswE5yPwbPMG9WKSzGb7
	 GETVCwkwaAuSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568893AB1391;
	Mon,  6 Jul 2026 10:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] amt: no longer rely on RTNL in amt_fill_info()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178333200588.474189.12282683486374169306.git-patchwork-notify@kernel.org>
Date: Mon, 06 Jul 2026 10:00:05 +0000
References: <20260701125016.3650708-1-edumazet@google.com>
In-Reply-To: <20260701125016.3650708-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,lunn.ch,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-304952-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:andrew@lunn.ch,m:ericdumazet@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 48913710549

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  1 Jul 2026 12:50:16 +0000 you wrote:
> Update amt_fill_info() to run under RCU read lock instead of RTNL.
> 
> The AMT device configuration fields (mode, relay_port, gw_port, local_ip,
> discovery_ip, max_tunnels) and stream_dev pointer are initialized during
> device creation (amt_newlink) and are immutable. Accessing them locklessly
> is safe. The stream_dev net_device structure is protected from being freed
> by RCU.
> 
> [...]

Here is the summary with links:
  - [net-next] amt: no longer rely on RTNL in amt_fill_info()
    https://git.kernel.org/netdev/net-next/c/586c4dcf28eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



