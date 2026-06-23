Return-Path: <netdev+bounces-301490-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fYDUED32OmrmNAgAu9opvQ
	(envelope-from <netdev+bounces-301490-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 23:10:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 848046BA34F
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 23:10:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fjPvmyDz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301490-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301490-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F59E30210D4
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 21:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE433AD530;
	Tue, 23 Jun 2026 21:10:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB57318EF4;
	Tue, 23 Jun 2026 21:10:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782249018; cv=none; b=bvBTyVRAdgSlTpkanSsD9NSR6ba++8rIb+elFayvewqQdYB074R6t/DrEQ2T99SY+c+8v3YZOv+FAb/Tho0CWPlAYe/TJshUuS6PUdXSIerLXaNwb1A/FJx39Ifb2mO/XJcT4mBELw6fbjo46kgwD0puCr1YiwZjjH+raOxANj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782249018; c=relaxed/simple;
	bh=bZjDxBh1FTzcUsz2U22c8jdsy+yEm5raNKlogj/qWQA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uAe+LWioDfLHMINXT7Ag5N4/rvTKHjpi9S6pSbjUdNXZ+Ky3VnrDzO1jpoonigIu+yBH3Tgs3P9q+C6OTTlDyz1NP59HdOd1/k+kddq2Bj9JDKN4hqgmjHi9VdgaS0lcfvO+p14sdXEFFzXP55vYd9g4QI5lLvHtswTdaW5+XvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjPvmyDz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52BF1F000E9;
	Tue, 23 Jun 2026 21:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782249016;
	bh=bSm7Rjw2H8AFvKLoIJK27se2HOcf4FzeNFVGgDBIMiA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fjPvmyDzqZDd1dJONU8ICqC+OCzLWAKzUvhjaiEtrfh5Vmlkt9tbCFBH3Tzh17YtE
	 3Xh0esK6EqSIKksVmUjxfkNu6RJKomGZHWUzri7mDlCRXzlEBiR5E6c8Z0WYLJ1uv/
	 FJ25cqvl6py3rt6rhB99VSLZkXcXTnVDGJ1owZ7khoPjfQdyfCPRTXzNKRbEYxPbjU
	 IBIb81hAJJqqZkliK3rkrbKvWXRw87tYY7GKTc5YmSRESuNTG868GOVHzQpTarlcYu
	 PtJfAdu5PjqR8VS50JMnygKeTiGDmN70PpOYFEDSCZYXegzPDT3XPq7tCZ5ROH2iAb
	 zMBSeRV+EtovA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938FE393100A;
	Tue, 23 Jun 2026 21:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net,
 bpf: check master for NULL in xdp_master_redirect()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178224900627.2420505.10383467266563822848.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jun 2026 21:10:06 +0000
References: <20260620201531.180123-1-xmei5@asu.edu>
In-Reply-To: <20260620201531.180123-1-xmei5@asu.edu>
To: Xiang Mei <xmei5@asu.edu>
Cc: daniel@iogearbox.net, martin.lau@linux.dev, hawk@kernel.org,
 jiayuan.chen@linux.dev, netdev@vger.kernel.org, bpf@vger.kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, ast@kernel.org, joamaki@gmail.com,
 pabeni@redhat.com, bestswngs@gmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[iogearbox.net,linux.dev,kernel.org,vger.kernel.org,gmail.com,fomichev.me,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301490-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:daniel@iogearbox.net,m:martin.lau@linux.dev,m:hawk@kernel.org,m:jiayuan.chen@linux.dev,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:ast@kernel.org,m:joamaki@gmail.com,m:pabeni@redhat.com,m:bestswngs@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 848046BA34F

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 20 Jun 2026 13:15:31 -0700 you wrote:
> xdp_master_redirect() dereferences the result of
> netdev_master_upper_dev_get_rcu() without a NULL check, but that helper
> returns NULL when the receiving device has no upper-master adjacency.
> 
> The reach guard only checks netif_is_bond_slave(). On bond slave release
> bond_upper_dev_unlink() drops the upper-master adjacency before clearing
> IFF_SLAVE, so an XDP_TX reaching xdp_master_redirect() in that window
> still passes netif_is_bond_slave() while master is already NULL, and
> faults on master->flags at offset 0xb0:
> 
> [...]

Here is the summary with links:
  - [net] net, bpf: check master for NULL in xdp_master_redirect()
    https://git.kernel.org/netdev/net/c/e82d8cc4321c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



