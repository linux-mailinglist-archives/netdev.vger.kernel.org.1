Return-Path: <netdev+bounces-299598-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nGDkDc9ZMGr9RwUAu9opvQ
	(envelope-from <netdev+bounces-299598-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 22:00:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCF8689A2D
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 22:00:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="AexXUxI/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299598-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299598-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 808A6301CFEB
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 20:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC47C38B12E;
	Mon, 15 Jun 2026 20:00:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF99D31E106
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 20:00:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553612; cv=none; b=fJQdcz/qkzx1Y7hfQkUvj2n5V769p17qf9t45vj92F5rgFUOF7tOd7cSZNfUblQCswC1BU/J4hrQmZUoFNhWh+V6TtW8Yw8h7ZL7e+Pe9a5EButwWQ4E1aj1kFuYrLgN861PbL1iKmWlsyZ0Jc9C/d+9ZpFrmhtNK0U1pjKJMrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553612; c=relaxed/simple;
	bh=ELHbhRUMqgbc91OYQejyiB48+XwjNjhcJ1wo6GB4MsE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YanPUWGoRAg7Unpi8jzL9SqjN6vyb2Umz4QB++cbaktNLpHl2BqNV9NcCu8pmSdwTLeLupyZMlQKMMDfdIqozYvp8WGGkJLeEMKZ7qTXvNtA6k0Wm+fPUIfzsNqYdNt57ytgTZMlVv0/eSQJuYr9o7uzAteJ6A8utoU0DW4kykU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AexXUxI/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B931F000E9;
	Mon, 15 Jun 2026 20:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781553611;
	bh=ZSlPBQgCCyjZetRsD0IOO8PwMyhCB+1BS4cIArHHAco=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AexXUxI/JByrDGFTIOmNYislfvY9E4bdOfN5ZVBNPRf4QSkZEOxDsk4MwSqlohf/M
	 pjAadbzYJbq/XKU0h/nJ0c8+WUk2ip8hIT3dL7zzOP1HhKvTDEctkzDaYway8EKyZa
	 ixT31kAObMW5qqePvJLKp5wl8n4SgxFNWtz357cv+bPHEufPCOy8YuLQFeTpYANKPS
	 9KUthzvmWmPXXBR5wrSjvnTlTQ6AlOLdDGYnFjEZF4rHc9li7JCBfvVg7Yp5peZgkc
	 pCJHpH8ZjTsdWgscQfbuYtcU6U2djXzqcAXo/rlAtkouspHAXuZTeT/OiixT6e8ko5
	 l0LZJEWZeqHyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A623839A06;
	Mon, 15 Jun 2026 20:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: ipv6: clamp default adverting MSS to avoid
 GSO_BY_FRAGS (0xFFFF)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178155360639.272818.5043247062078863651.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 20:00:06 +0000
References: <20260612162517.83394-1-edumazet@google.com>
In-Reply-To: <20260612162517.83394-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 idosch@nvidia.com, dsahern@kernel.org, ncardwell@google.com,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+ebdb22d461c904fc3cb2@syzkaller.appspotmail.com,
 marcelo.leitner@gmail.com, lucien.xin@gmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,nvidia.com,google.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299598-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:syzbot+ebdb22d461c904fc3cb2@syzkaller.appspotmail.com,m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,m:marceloleitner@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev,ebdb22d461c904fc3cb2];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8CCF8689A2D

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Jun 2026 16:25:17 +0000 you wrote:
> When MTU is large, ip6_default_advmss() can return IPV6_MAXPLEN (65535).
> This is interpreted by TCP as mss_clamp, allowing the MSS to reach 65535.
> 
> However, 0xFFFF is also used as a magic value GSO_BY_FRAGS in the kernel.
> If a TCP packet with gso_size=0xFFFF is passed to skb_segment(), it will
> be mistakenly treated as GSO_BY_FRAGS, leading to a NULL pointer
> dereference because local TCP packets do not use frag_list.
> 
> [...]

Here is the summary with links:
  - [net] tcp: ipv6: clamp default adverting MSS to avoid GSO_BY_FRAGS (0xFFFF)
    https://git.kernel.org/netdev/net/c/2bf43d0e2e6a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



