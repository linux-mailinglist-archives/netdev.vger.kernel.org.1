Return-Path: <netdev+bounces-304980-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1EkmJL6fS2riXAEAu9opvQ
	(envelope-from <netdev+bounces-304980-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 14:29:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D331171087F
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 14:29:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OEIE2wXF;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304980-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304980-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9176931574B9
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 11:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41726173;
	Mon,  6 Jul 2026 11:10:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90F63E51F8
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 11:10:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783336227; cv=none; b=plBGgegKlV331beA8CWUIIbVl0hSFILQVD+XTiTZl8qvhrbp7YPY6U6CoR0Ip2rsuo+0Kk0ZQg4en1ir9JT5z0+gtcnkkoQ8KWvx0LVAkLOyk3dKLLVU9xn+b7EWimPRX4jzj3EhCTMzT5xwoRrodOSkPFd09wMJ9ut1/1Vu7HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783336227; c=relaxed/simple;
	bh=ul0i/2isspZkOqKoHRNlHoaDUSJoAVKPAiZZcUeSr8k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b2kGa08gjQ2uPGC9DghHE/RhLVSGiBzuHRKE4ZHNG8I/wOO9Ce2Wly89OVIQI4U2b2OV2fa7En6T/ghGz5g6awQXWafwWH4MllaEcnSikCl6vQ7zvXqr3RxRqfHuXo9hymN2dkm6ujMTUsmPhQRlO4BEokdud+0UcIQ2ilkKj3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEIE2wXF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842671F000E9;
	Mon,  6 Jul 2026 11:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783336224;
	bh=QffKILYnQN9YcSEpazTh7cROVqHGRU+/X5uqZkNYzVg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OEIE2wXFWuccP8Q7dOyia0TkQPWcwCW4iaBInM77fBCLSlSWLTjHLdYLQq/0BYZ5r
	 YzbUmIjpaQqi7vNPM3o/3MitvXaM7lMdFv8biEbGPCi1FRydru/V8VR4r6g04/l00c
	 shwYJtWbEyVnRmzt70cjMhJi6MB3+SaLXZSJSxU61n1xKNaYO9sbn1q3RMXhXkeVuf
	 dCtbfDqNmMEO4hRAm2/aQ9DVOF/X5mb4apYWZzVbQDTZWPuSLNirfzaK+PWhbq6otO
	 U3+kmx7etc7AzaBU17ZbQjxhgr1AbKkfAUJPDBQY6qDPHj1TSjX2jVSX4ujhJDF3qU
	 7pyqajO+W075g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569533ABD2A5;
	Mon,  6 Jul 2026 11:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] amt: fix size calculation in amt_get_size()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178333620514.508475.18254456357684697437.git-patchwork-notify@kernel.org>
Date: Mon, 06 Jul 2026 11:10:05 +0000
References: <20260701122329.3562825-1-edumazet@google.com>
In-Reply-To: <20260701122329.3562825-1-edumazet@google.com>
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
	TAGGED_FROM(0.00)[bounces-304980-lists,netdev=lfdr.de,netdevbpf];
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
X-Rspamd-Queue-Id: D331171087F

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  1 Jul 2026 12:23:29 +0000 you wrote:
> amt_get_size() incorrectly used sizeof(struct iphdr) for the sizes of
> IFLA_AMT_DISCOVERY_IP, IFLA_AMT_REMOTE_IP, and IFLA_AMT_LOCAL_IP.
> These attributes contain IPv4 addresses (__be32), not full IP headers.
> 
> Replace sizeof(struct iphdr) with sizeof(__be32) to avoid over-allocating
> netlink message space.
> 
> [...]

Here is the summary with links:
  - [net] amt: fix size calculation in amt_get_size()
    https://git.kernel.org/netdev/net/c/9e05e91a9a84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



