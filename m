Return-Path: <netdev+bounces-299589-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JJqkE+VXMGqZRwUAu9opvQ
	(envelope-from <netdev+bounces-299589-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:52:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F6E68997A
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:52:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PgMQ1POT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299589-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299589-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87CCB303AF2C
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 19:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E1B3AFAEA;
	Mon, 15 Jun 2026 19:50:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E06C282F01;
	Mon, 15 Jun 2026 19:50:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553015; cv=none; b=jRFnTg2I0P1153XLOXmkUspXWszTgr4Vf24oexCQbJIsU93wqv2QAVfk+GX6maDZU9qHAlVc53KmbvywibbFt1+5/xm5yJPAuH6zks5WTPIeSlePz9+3zTPb2e1OZGNEeXXOnRpUhryL8wE6sAVqdUmfZ5rmkCv8KNQY+MerB+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553015; c=relaxed/simple;
	bh=SExn4EaZer1k3XF0mf11hKwKp5EhbxAxrIAM335aDTQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QZ1d3QYmoi1zZnfFFCEEtOA8YJonf5Ir0GFc7KneQSEItFPMNycE41J23nJyoZ5sksiBZ1XAyYbNqQsVafzSvEglqPDAw5LbjBz+k9FitavZnjXipZPePos6POBa4XnT4aqsbhTNUnd0rqK+7UXhVkqJWT6DrhcNr00p6WJMS+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgMQ1POT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CC61F000E9;
	Mon, 15 Jun 2026 19:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781553014;
	bh=yEe8kt08WvWXSp2RmIgx61ILSWIZUrmCJaKZ1TVV7Hc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PgMQ1POT2QItBiDMnTUY6Ty/KZEPZsw1l5V2OKvQm7k1NKg4NsxVidgOeNZ4kMUbD
	 MJWRSTbMrgO/KQZw15RKnrZ9oZgZd3i6IEPlt0GC0/X2eTxfmVZknioJ1YjMrVw4X/
	 EeZK6P85D8csbLDg6pt42twHY1+gQIEw2Q9YGcXazaftxajDWNTiCGeZD5x67EDyNG
	 rFAuRoqmCS678fOBIRKbXWos28tZt8Xodo3nGqiiAkq+H7g4ufzlP66h857ONiLfdl
	 DQzdg0bpt8dIU7EejJ+uxTb5f0oziEI6FTqwKER2onJDuAHuWZkU3LxKpHQP/fwA+x
	 BmoUmCqGxOCBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569033839A06;
	Mon, 15 Jun 2026 19:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] octeontx2: quiesce stale mailbox IRQ state before
 request_irq()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178155300889.269508.15289919192491633679.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 19:50:08 +0000
References: <20260611160014.3202224-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260611160014.3202224-1-runyu.xiao@seu.edu.cn>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: netdev@vger.kernel.org, sgoutham@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, hkelam@marvell.com, bbhushan2@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, amakarov@marvell.com,
 tduszynski@marvell.com, linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299589-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:runyu.xiao@seu.edu.cn,m:netdev@vger.kernel.org,m:sgoutham@marvell.com,m:gakula@marvell.com,m:sbhatta@marvell.com,m:hkelam@marvell.com,m:bbhushan2@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:amakarov@marvell.com,m:tduszynski@marvell.com,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B8F6E68997A

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Jun 2026 00:00:12 +0800 you wrote:
> Both OTX2 mailbox registration paths currently install their IRQ
> handlers before clearing stale local mailbox interrupt state, even
> though the code comments already say that the clear is needed first to
> avoid spurious interrupts.
> 
> This issue was found by our static analysis tool and manually audited on
> Linux v6.18.21. Directed QEMU no-device validation further showed that
> the real PF and VF mailbox handlers are already reachable in that
> pre-clear window and can touch the same mailbox and workqueue carrier
> before local quiesce has completed.
> 
> [...]

Here is the summary with links:
  - [net,1/2] octeontx2-pf: clear stale mailbox IRQ state before request_irq()
    https://git.kernel.org/netdev/net/c/f918554fb724
  - [net,2/2] octeontx2-vf: clear stale mailbox IRQ state before request_irq()
    https://git.kernel.org/netdev/net/c/0b352f04b9be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



