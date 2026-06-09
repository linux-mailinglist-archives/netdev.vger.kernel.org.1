Return-Path: <netdev+bounces-296788-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i0DoM5RXJ2r7uwIAu9opvQ
	(envelope-from <netdev+bounces-296788-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:00:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF64665B3FA
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:00:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Ttisx5ku;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296788-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296788-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1F98301907B
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 00:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941FD2874FB;
	Tue,  9 Jun 2026 00:00:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9269B241C8C
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 00:00:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780963215; cv=none; b=eLVMQlfRlcP5tNyoOBM7K9Has3Wuto4svFdr5vdRqKltLSEIBiLjidClbqpCYvUlElEMsXvSezpQSW90gT4Cbt84ZbtVk8UBn6JgxoS/k8W8V/L9stF1mqAY1zlGamB0Qc729jDjzezM/leaURwaK2sWeFe3Lck3ZRAxBEqrWbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780963215; c=relaxed/simple;
	bh=TNsDsyJEvTA+QWWQBWYdiZp+DHQxYUr9dE4sj+Exi0Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EoNOoBB+23H97ltH7oiEqiyuiaYo+Eo6tGNfdtXruq1CofPjkSrhsphOJybN7ZbpJEEb7ymesPpU4wKcq203x2mtaEOhGdYyrxkJmZ/6oQtsFmPOmUzurP3jNydQIkIPJ/R4trcJTpD9MbQ506K1vPqKVOlckH8OMkaAMLMExok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ttisx5ku; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448FA1F00893;
	Tue,  9 Jun 2026 00:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780963214;
	bh=9KAqFjs3jE0Zy9R+aj3I8u1Q1cnQ+i9r9ZcuC1Ij+4Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ttisx5kuCu4G1VGhXA4X6gdCe9wVt3++92xiNQeLCxcl7M/vxvRW+lqKkwt/6ivNs
	 dWZRXqemQFiiaGebjgf8BXeLkeizyOIHJlrQXREHJT5BvNWkblb7GpZ4ZsbHxGTW0a
	 dEO/W3bsEd4nhaBUC7MxHXKNk0+eb8VgtnbQAojPdqFlNk9AyAhK7GnotoRPIoJ9Pv
	 thcXJujqI8WRdRDkoiBzM5K57qv+KKAKmVrTBhit6BPDRDNBLu0qmgJ1V1LLjCT9et
	 rqs3kYL9W6ck69lpS8es4LoPAuKm2tprpzApzZUdicLnPju0GxATbgFdJ3vj88pql3
	 4ZnrNp413ExcQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197FB3812FDA;
	Tue,  9 Jun 2026 00:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] SO_TXTIME improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178096321264.1718110.7522695036462906487.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 00:00:12 +0000
References: <20260604194221.3319080-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20260604194221.3319080-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, willemb@google.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296788-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:willemdebruijn.kernel@gmail.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:willemb@google.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF64665B3FA

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Jun 2026 15:41:02 -0400 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> FQ targets monotonic timestamps as generated by the TCP stack.
> 
> But SO_TXTIME was later added, which can send skbs with timestamps
> against other clocks. It is now possible to detect these through skb
> tstamp_type.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: ensure SCM_TXTIME delivery time is no older than system boot
    https://git.kernel.org/netdev/net-next/c/73f1a618b064
  - [net-next,v2,2/3] net_sched: sch_fq: convert skb->tstamp if not monotonic
    https://git.kernel.org/netdev/net-next/c/c4f796c4f16b
  - [net-next,v2,3/3] selftests: drv-net: extend so_txtime with FQ with other clocks
    https://git.kernel.org/netdev/net-next/c/b016022b127f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



