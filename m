Return-Path: <netdev+bounces-268394-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKGyAby8uGmxigEAu9opvQ
	(envelope-from <netdev+bounces-268394-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 03:30:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7522F2A2D2B
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 03:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 609CB3025F44
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 02:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E831434B404;
	Tue, 17 Mar 2026 02:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcJz9kF7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04D5348880;
	Tue, 17 Mar 2026 02:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773714615; cv=none; b=Xm59ve6nXM9vEq7iyHkVL7LNHaa5VRfyrXXJ4YbtpIFuprkKyN696QJXRkOGqtlZe1lFWugi1wavW+7yquKgzB4XYa/LduSziMoiKkGjl11s13cjG2y+6Yqr0igzrDP25/YrqN4e1jtbbWnYEo09KrEMZbWksAZnNteOgwjqc5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773714615; c=relaxed/simple;
	bh=HFGrF+WKuDD37BuJkejevChhMrqJNM8P9feyiAuFfx0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PhYwvEdf2HDyo6YvHzsgw1Z+MoClwjxsHIF3Q6NMuTeiT+TC5FerfekKTZp4Dqg7+7MdjS2uk4i0M5ha86S2BrqDCfoE4c1DOO+s5uy3uISX3laNTFD729JpfgRnhU0/obz/GK/FMvL+SEc4Y7J/X2UWi0xDBq4Fp3UFfRA4hN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcJz9kF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60AAEC19421;
	Tue, 17 Mar 2026 02:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773714615;
	bh=HFGrF+WKuDD37BuJkejevChhMrqJNM8P9feyiAuFfx0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gcJz9kF7PPiFyYYfZ4gPGuHZ96t2EEYgo6V7GUsvUQEqp83IUAB31+hsycHHO0bgg
	 iS5BXXKjAfz8gZOv3cqnuKMrCrMPUncgrZuffaKYhbgOqw5c+vMiq3x4X1FFKlWd7+
	 /Ag2HJ076IkyB8mzzK2xxd4ZBTo/CFEcAv4eLREerqQRXD6EMHvP0ywyj2o0TVqA3l
	 Pfjkk1RJmWgJhfiFixaAH0eBlZD/LCZCnUmXH4YZWBqeNNnNXJy4zJq7wVEM2SxVi6
	 CXfXKXQO4UbiVTJ0WBwWZC+W3Ydt2QHO4jB5cVpnpywbDMtCMhKSXgCH3YukKXP7IR
	 CE7lmAjOIRlIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDC33808200;
	Tue, 17 Mar 2026 02:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: ti: icssg-prueth: Add HSR multicast FDB
 port
 membership management
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177371460779.3397946.14299476389534020900.git-patchwork-notify@kernel.org>
Date: Tue, 17 Mar 2026 02:30:07 +0000
References: <20260311082923.2962937-1-danishanwar@ti.com>
In-Reply-To: <20260311082923.2962937-1-danishanwar@ti.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, m-malladi@ti.com,
 jacob.e.keller@intel.com, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, rogerq@kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268394-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7522F2A2D2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Mar 2026 13:59:23 +0530 you wrote:
> In HSR offload mode, multicast addresses can be added via HSR master
> (hsr0) or directly to slave ports (eth1/eth2). The FDB must track port
> membership: P0 (0x1) for HSR master, P1 (0x2) for slave port 1, and P2
> (0x4) for slave port 2. When the same address is added from multiple
> paths, memberships must accumulate.
> 
> Implement a hybrid approach using __dev_mc_sync() callbacks to track
> basic add/delete operations, checking netdev_hw_addr->synced to
> distinguish HSR-synced addresses from direct additions. Post-process
> to handle overlapping memberships by checking refcount:
> - refcount=2 with synced=1: HSR only (P0)
> - refcount>=3 with synced=1: HSR + direct (P0|P1/P2)
> - synced=0 with P0 set: HSR removed, clean up orphaned P0
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: ti: icssg-prueth: Add HSR multicast FDB port membership management
    https://git.kernel.org/netdev/net-next/c/45339c237c6a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



