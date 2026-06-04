Return-Path: <netdev+bounces-294996-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NYcGG6nRIGqw8AAAu9opvQ
	(envelope-from <netdev+bounces-294996-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 03:15:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF43263C2B2
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 03:15:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JC+aiJkS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294996-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294996-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62C94303CD37
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 01:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F89248166;
	Thu,  4 Jun 2026 01:14:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE5B238D54;
	Thu,  4 Jun 2026 01:14:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780535660; cv=none; b=PDf49r5HojbgNGvdnvt+w77/BNup5YU6dd8GWazesm8urSmNDqH5c5Ot6NabwYIwXX46rdojnDCTkTQiXLqhzQvigp6PwvPJJ+EF1cHwiJwujhZfYvhVq+pONdwK6er+e+euT1U7vspwyaopJtF6SzgIlsGM1kG9be5jBY2X3lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780535660; c=relaxed/simple;
	bh=AvQcOYV3R/7eO2B1DK5jCcSAQMNVBo/2CdInG88GKXg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IuIGLjDP8etCik/pihyefICsyCNMIS01xCZr/GymCN+0q7P0GpF/ejlr8ps2SYgNMkXwGkMO8O58Gpsbd5+KhXOr88MWenuCVINTreQsObaqkqvfoeLHCgVMg1g9V3J9+spmZDQ2BqOWHffFSxQe4u4sCSINWC7GimVQVDTPF9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JC+aiJkS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3E91F00893;
	Thu,  4 Jun 2026 01:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780535659;
	bh=jiIcQ71vfVf+xwbx2q42NM3vgT8HX9pPFNgaMCQ8yjE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JC+aiJkSm4WknpDBIG88SMnq0gxDGi+frmllGC7q77KB1eIz6dmV4Wz8kESq37dAl
	 nUpzuaImCJmZ1jztjpzDrWEjzMY2NQVLPYLTYFD7wLNzPGQuTPeILxXsGgFVyvXd0O
	 y2FEom+v9Qr5Linp8F0uJBSiRB8SlFQS2JZm4ZRqzojGLZwzk/xxhwZ44cSXuNsNhV
	 AV6yyXeFTB5K1DShfvZCC9gApjBN3JN0dgdA12EsgLZrdv/NnzEV/Q3HhGhU1Ea+RZ
	 O50MngBYyCS97+wdPLTvlT1nQwSUzex/rZ275jjpsQyEijB7UgH/e5/n7//iUx3XHh
	 0J8cTKtOyiArQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A5E39308DD;
	Thu,  4 Jun 2026 01:14:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] xsk: cache csum_start/csum_offset to fix TOCTOU in
 xsk_skb_metadata()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178053566039.2042071.1462371315566294486.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 01:14:20 +0000
References: <20260530042630.80626-1-kerneljasonxing@gmail.com>
In-Reply-To: <20260530042630.80626-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, horms@kernel.org, andrew+netdev@lunn.ch,
 bpf@vger.kernel.org, netdev@vger.kernel.org, kernelxing@tencent.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294996-lists,netdev=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS(0.00)[m:kerneljasonxing@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:bjorn@kernel.org,m:magnus.karlsson@intel.com,m:maciej.fijalkowski@intel.com,m:jonathan.lemon@gmail.com,m:sdf@fomichev.me,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:kernelxing@tencent.com,m:jonathanlemon@gmail.com,m:johnfastabend@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
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
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF43263C2B2

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 30 May 2026 12:26:30 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> The TX metadata area resides in the UMEM buffer which is memory-mapped
> and concurrently writable by userspace. In xsk_skb_metadata(),
> csum_start and csum_offset are read from shared memory for bounds
> validation, then read again for skb assignment. A malicious userspace
> application can race to overwrite these values between the two reads,
> bypassing the bounds check and causing out-of-bounds memory access
> during checksum computation in the transmit path.
> 
> [...]

Here is the summary with links:
  - [net,v5] xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metadata()
    https://git.kernel.org/netdev/net/c/22ba97ea9cc1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



