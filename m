Return-Path: <netdev+bounces-297398-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /NQZJSrEKGoaJQMAu9opvQ
	(envelope-from <netdev+bounces-297398-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:55:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2361C665590
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:55:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SCyeWuJT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297398-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297398-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64E0330F6232
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 01:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EC6286D70;
	Wed, 10 Jun 2026 01:50:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D575E2D0C89
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 01:50:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781056216; cv=none; b=gpAQASJYu5WFwmcQfqHetVYqSm0oagQlqQH3I4dGNZ3GPlomgIb0EtYv5zYH6eZn1RubpvyXzv+d1k1lxtYYVRMGZTmID++pF1YYx7J0vE8lXb0zdZ7UWHU3CraG/d6Agpl1HRaDAYgnaZ8AsX61rbh4ipbFYJqNnxZ03sa3F9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781056216; c=relaxed/simple;
	bh=qL6MQ6t36PSwyA0g78/hlHSf0izkr7AqKNpJMYpOmtA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uW2KWD/uj82HRd3D6hIN+gc2JFXM0fybWkiva6GzU8DaELtah7nfBLWgZ4wFvgyBsAXPu67KacDQUt1/LTeZaboHjtLxQhkVxJR/S/U8U4xyW1nMVeeW4ODwveRk2LSZwt7/manri45S+pVWSyd07m8wMEcUIFU0h0Fw/SqzaUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCyeWuJT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378E01F00898;
	Wed, 10 Jun 2026 01:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781056212;
	bh=vBGc5mloHJvkVvjP+3gOFYWDIHOBl0pVH/hofRDP5HE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SCyeWuJT95XTKMBYI7pdvdXA8+Bq8jIPy9uskCPXvJfMMdUHQ8n/14+62xk3rJjoz
	 4UPeeW6qzxaiaae/SbAQ7X8FU4v/kVLzZ2+w0nKwu4Sl5CU28a48IzVm252H+hyIrm
	 S00UaPQpg/LVCzTU0kWodxOll+RmfNYtfDrjGsfQE3w21HJKGVTJGbiDvvw9FSxB7m
	 ftg8MQY7HCJNfRzetdvwO1CYhcsqAb5Jmap1p8f+9lJ0DrqTk/lquE2933Uwk8FmYW
	 kcF1obo0+ZbWaG0vrtJIcQySOFG1SI/QQ1+ASUGeWZ7wFWJ7rfWzSYS7KM1EFPn01c
	 SXSo++onQt+RQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9391A3930A1F;
	Wed, 10 Jun 2026 01:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: guard timestamp cmsgs to real error queue skbs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178105621013.2788910.11039512667983412711.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 01:50:10 +0000
References: <20260607021819.49698-1-kylebot@openai.com>
In-Reply-To: <20260607021819.49698-1-kylebot@openai.com>
To: Kyle Zeng <kylebot@openai.com>
Cc: netdev@vger.kernel.org, kuniyu@google.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297398-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kylebot@openai.com,m:netdev@vger.kernel.org,m:kuniyu@google.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2361C665590

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  6 Jun 2026 19:18:19 -0700 you wrote:
> skb_is_err_queue() treats PACKET_OUTGOING as the sole marker for an skb
> from sk_error_queue. That assumption is not true for AF_PACKET sockets:
> outgoing packet taps are also delivered to packet sockets with
> skb->pkt_type == PACKET_OUTGOING, but their skb->cb is owned by AF_PACKET
> instead of struct sock_exterr_skb.
> 
> If such an skb is received with timestamping enabled, the generic
> timestamp cmsg path can read AF_PACKET control-buffer state as
> sock_exterr_skb::opt_stats. With SO_RXQ_OVFL enabled, the packet drop
> counter overlaps opt_stats. An odd drop count makes the path emit
> SCM_TIMESTAMPING_OPT_STATS with skb->len and skb->data. For non-linear
> skbs this copies past the linear head and can trigger hardened usercopy or
> disclose adjacent heap contents.
> 
> [...]

Here is the summary with links:
  - [net] net: guard timestamp cmsgs to real error queue skbs
    https://git.kernel.org/netdev/net/c/1ee90b77b727

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



