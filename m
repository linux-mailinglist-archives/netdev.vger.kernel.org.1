Return-Path: <netdev+bounces-253693-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HDEDno4eGmmowEAu9opvQ
	(envelope-from <netdev+bounces-253693-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 05:00:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8766B8FC64
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 05:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDE223023507
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D58F318B9B;
	Tue, 27 Jan 2026 04:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0OsIkyV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1FE318B88;
	Tue, 27 Jan 2026 04:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769486415; cv=none; b=QsfIZ1xwJtdC4J6ucWb5oTfdNKFhB2FTum6tm7rO8cFr6wBhREdnHnJR9BIn2W+fZqea+REd3CsmDQ1/EDbqato/yvckkQgGPbaTevbEvpWAX5Xh5aVe6P6RUrVrLaN3HCW1DilNj5ckbQwijZzxEsHR3JLUO16wsER2Gmbb1KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769486415; c=relaxed/simple;
	bh=/dnKUp4g2owUpoadHslNe+UnWeyhp45Dv0N1zbazH/0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N7Dr7YXZ2IjOf40zLpre7vxyxQ3IBoa3i79SNCPcCUx8Pl6XVso5LJZ9ixdyFnEYVxSWf25AatNvR57umFqURmqaUuO9Xl7gUXy7+PlNxJ/r7Z3GPp7esv2ambhdloxwijRR4I3+nQoG+BBszeAGn5LVcY87bc3IH8Z18o6cPCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0OsIkyV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C93C116C6;
	Tue, 27 Jan 2026 04:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769486415;
	bh=/dnKUp4g2owUpoadHslNe+UnWeyhp45Dv0N1zbazH/0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h0OsIkyVYOsuapZYA1CVXBKpZ3J91N3a8QTzY3NuQzqhl4duy8HC5TKr0IcRMQinz
	 ClbqsZyNjpWaaUmsAfqAjfeSOy1Ro5z+wiKH8rjouCKGHTMhNDd62qFMk5Q2PLrv30
	 3jjlt7rXW8sSCJNjP4FtyWpZTnBAHN6Pmmo51M6en+Pzw0ynd57CSUc69Dlf0AVp1c
	 0NZ+eHz5l2B2T917CkaT5sSkTjXZKyykXN92jnP0xC7TkGjHtqE5MXigcsEJ2DwiVn
	 jaD6yfy/ZTUk0fEkOs9T7pk7E88/5qiJnVWVevAYlitEcq64AuSTk1DCY2lAy/bYYE
	 ngTbJAoMQuAbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BBA8380A961;
	Tue, 27 Jan 2026 04:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: spacemit: Check for netif_carrier_ok() in
 emac_stats_update()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176948640910.677485.7954248952886250088.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jan 2026 04:00:09 +0000
References: 
 <20260123-k1-ethernet-clarify-stat-timeout-v3-1-93b9df627e87@iscas.ac.cn>
In-Reply-To: 
 <20260123-k1-ethernet-clarify-stat-timeout-v3-1-93b9df627e87@iscas.ac.cn>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dlan@gentoo.org,
 vadim.fedorenko@linux.dev, maxime.chevallier@bootlin.com, pjw@kernel.org,
 palmer@dabbelt.com, alex@ghiti.fr, troy.mitchell@linux.spacemit.com,
 amadeus@jmu.edu.cn, michael.opdenacker@rootcommit.com,
 netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253693-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8766B8FC64
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Jan 2026 11:52:23 +0800 you wrote:
> Some PHYs stop the refclk for power saving, usually while link down.
> This causes reading stats to time out.
> 
> Therefore, in emac_stats_update(), also don't update and reschedule if
> !netif_carrier_ok(). But that means we could be missing later updates if
> the link comes back up, so also reschedule when link up is detected in
> emac_adjust_link().
> 
> [...]

Here is the summary with links:
  - [net,v3] net: spacemit: Check for netif_carrier_ok() in emac_stats_update()
    https://git.kernel.org/netdev/net/c/2c84959167d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



