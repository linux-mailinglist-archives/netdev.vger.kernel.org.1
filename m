Return-Path: <netdev+bounces-295321-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /9xFJNCkIWodKgEAu9opvQ
	(envelope-from <netdev+bounces-295321-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:16:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 812F6641C09
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:16:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EFwcHWoG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295321-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295321-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 47118309F41C
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 16:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AA347A0C3;
	Thu,  4 Jun 2026 16:00:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CF63E1687
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 16:00:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780588830; cv=none; b=XCdkfTxHEQ3feTS4xqR8wXyaRfUzSGwYcLyjnyKKBkBB5cF6dFORVlL5jwC9/YikyS5NH2QbQniEmvL2xqOw1ZbrOXjnP9tqkknpVD7zxW+JNP19AUl7R6uq563lhDOrDgpP8dRfvGX4QTSaZfb1noHJODPQ2RaPzmGCmpd4EwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780588830; c=relaxed/simple;
	bh=KlFX57cnW5BSTLbfr9V70xdcrEDD+AfRHfMS6ohMz34=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=soQmxr+kHSCab3wQjXZj0hkq99HSlyDQBpHOIAOCEEWsjE4ZcmZCj6g2L4r+rF0m5pFiUj5E89LL6CeqwwdKr85AIfGyO2DQ3a0+9L8IzdABdJk6ocwGm99YuKZxtUXgUJFSMuwmKuCMfvsUIOWrOZ5KcQ7WLjB+d740kN9gmFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFwcHWoG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30281F00893;
	Thu,  4 Jun 2026 16:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780588829;
	bh=Hro0gi99KmBsc4frq0Tvz/7m/n33Eu8GMR5E1Lpqz5M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EFwcHWoGj6TooKsuahNCbZATEnUmxzY0KQBGO/e5a0+Ec5onmT4tgVtDRtjG1MlaV
	 PtFCSySWvM7d/bFnDr5ZOErjhX1KfhuJ65HsE+4+JcJI3idTvm1isRa+y3O2H4wOUw
	 dxqdJqxW2S3oU2c+Q6aYn33cHoE8M8wYZ/G8MJziNCOERqXkH+CVt1seIdTvRvmsPQ
	 5o8spVvje879EKoyFcExKEbj7g5HxuCXxRu+bswWuLy0DdIQV+nQ/sIdiLC//JvVUp
	 12/7y7phqgthGinZiNfJotiNAjY6cHbwFdoelrGmW9ABqG1+CjTOPXacIBnvj/B54P
	 amsmlDK7NsJBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09A139309B7;
	Thu,  4 Jun 2026 16:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ieee802154: 6lowpan: only accept IPv6 packets in
 lowpan_xmit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178058883039.2493857.14674144949588359883.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 16:00:30 +0000
References: <20260603072955.4032221-1-edumazet@google.com>
In-Reply-To: <20260603072955.4032221-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+f13c19f75e1097abd116@syzkaller.appspotmail.com, alex.aring@gmail.com,
 stefan@datenfreihafen.org, miquel.raynal@bootlin.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com,datenfreihafen.org,bootlin.com];
	TAGGED_FROM(0.00)[bounces-295321-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:syzbot+f13c19f75e1097abd116@syzkaller.appspotmail.com,m:alex.aring@gmail.com,m:stefan@datenfreihafen.org,m:miquel.raynal@bootlin.com,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,m:alexaring@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev,f13c19f75e1097abd116];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 812F6641C09

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Jun 2026 07:29:55 +0000 you wrote:
> The aoe driver (or similar) generates a non-IPv6 packet
> (e.g., ETH_P_AOE) and queues it for transmission via dev_queue_xmit()
> on a 6LoWPAN interface (configured by the user or test case).
> 
> Since the packet is not IPv6, the 6LoWPAN header_ops->create function
> (lowpan_header_create or header_create) returns early without initializing
> the lowpan_addr_info structure in the skb headroom.
> 
> [...]

Here is the summary with links:
  - [net] ieee802154: 6lowpan: only accept IPv6 packets in lowpan_xmit()
    https://git.kernel.org/netdev/net/c/3a5f3f7aff18

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



