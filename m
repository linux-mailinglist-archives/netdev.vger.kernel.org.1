Return-Path: <netdev+bounces-295334-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4+TOCXiqIWqJKwEAu9opvQ
	(envelope-from <netdev+bounces-295334-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:40:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A540641EF3
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:40:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JAniZSzh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295334-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295334-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B5A330FDAF4
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 16:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36A943DA39;
	Thu,  4 Jun 2026 16:20:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1042E436370
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 16:20:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590025; cv=none; b=h4B5OaWTfsvJk3XQvspj7c683dqDr9E96FSX8LdqmxJ8lrwJw7NlpCduFvLGcMPGSMhHK0gOcIqZByMaCLaBxyIA6BQYZdMDBchhQbVpZcixgCUMgRZ5efu8UVSP2bXyY+N2sI1BuLhn/X7/lij1cGOXVuwewtp85KsJY4aFtD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590025; c=relaxed/simple;
	bh=aup8HTiKQfUqry8P0kgORd18OFamHC3o+jXNFMbjVrY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K3lwRttgKQL8rdJRsL7Zb68cPZOiUNLrfWVbgv+ilpA9K0n5k7ZZdY9u1cKgnrQ6OHaVbqxsr1uaj+h1ibvKZDDQd0w+vzRjZR7mP8hkC5Q1qRqE+RQfhAHavKrsHgRrbr3xv/zN8JhnY9m+nHCbsNbJvdO2PL33GpS7Ag9IbT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAniZSzh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A4B1F00899;
	Thu,  4 Jun 2026 16:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780590021;
	bh=RhtekSOVIQzr2aepyVmUdnEYZlM5K7pE02qAYN9k4TE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JAniZSzhh37AWdgY/3gnAW6OvA4kHID6ls5YxJmKsDL5gR3YCyCPc8O9hodWPzJIp
	 xQUAOVOxKw/hgr04RWxrSfLWvy/z0fVk/jAxl9+b/7OfJ60fW0qHB20NqsznppT+9q
	 PXKHsVmZEl5F9TeqlbRyZU4SChIzV7H0chMr6fnFtSqEOSKoLqKZSlBHrVcGzOxD5/
	 GRTwCWQn/EGPFLV0bJoYU7r8fsniw8A69kzlyzBe672hpP1IIS/XANr7SJ33E9/lKj
	 86V+ouvZWv+1gpCwr9gAilY4jtLZ3nAn/gd2BOMnqV7c4i/fkjRkCx6FTuUKFJ6qjX
	 mUW4OgVGbae/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A4539309B7;
	Thu,  4 Jun 2026 16:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] Reapply "bnxt_en: bring back rtnl_lock() in the
 bnxt_open() path"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178059002239.2502005.9669162484916365855.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 16:20:22 +0000
References: <20260603195845.2574426-1-kuba@kernel.org>
In-Reply-To: <20260603195845.2574426-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 leitao@debian.org, michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 sdf@fomichev.me, aleksandr.loktionov@intel.com
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295334-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:leitao@debian.org,m:michael.chan@broadcom.com,m:pavan.chebbi@broadcom.com,m:sdf@fomichev.me,m:aleksandr.loktionov@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A540641EF3

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Jun 2026 12:58:45 -0700 you wrote:
> This reverts commit 850d9248d2eac662f869c766a598c877690c74e5.
> This reapplies commit 325eb217e41f ("bnxt_en: bring back rtnl_lock()
> in the bnxt_open() path").
> 
> Breno reports a lockdep warning in bnxt. During FW reset the driver
> may end up calling netif_set_real_num_tx_queues() (if queue count
> changes), so calls to bnxt_open() still require rtnl_lock.
> 
> [...]

Here is the summary with links:
  - [net] Reapply "bnxt_en: bring back rtnl_lock() in the bnxt_open() path"
    https://git.kernel.org/netdev/net/c/b6197b386677

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



