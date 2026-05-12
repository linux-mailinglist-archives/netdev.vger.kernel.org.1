Return-Path: <netdev+bounces-287079-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGkVLZoEA2r1zgEAu9opvQ
	(envelope-from <netdev+bounces-287079-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:44:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1684251ECD6
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BB7C3058BB8
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14D9395ADA;
	Tue, 12 May 2026 10:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8OZbZBu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94244349CF8
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 10:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778582460; cv=none; b=oR8mM+x/kYHQwsrSg3qjWsted7s+0wN2M3LmGc/BwAS6yEOX3t4yoT+hVWTHKVOc6fo7iXR972O0ZGqGfI3H/IR9Gn/Td17H9c8mbtwcybq7AFnvcN8rDoaAkHZwU32CvKyrOAa+f6XWepFKdV9Y+ivv3OVoKdfDDIJP1P8I1/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778582460; c=relaxed/simple;
	bh=KemSZ9bwOd8fBAANMIPARXqN/uZixY3Q9033+r2TlmI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GM+flooJR6VLJvX2SWni9ETxhYc7zak6Q84Bvb1/plFo5FoLotDcoeM6akH6JjcPpXXquLvBpVuNZYeAiqgmkyx6IT/xKBnsImucQajwq6MddJasnmXEZEKLvqCVIoT2CcUHbmK4efy38OBPYGp6BMXz50vhA1tAv9QHzfMWfqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8OZbZBu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39722C2BCB0;
	Tue, 12 May 2026 10:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778582460;
	bh=KemSZ9bwOd8fBAANMIPARXqN/uZixY3Q9033+r2TlmI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r8OZbZBuWphHT5TTkYmmT1+p/51ZDw7rRom7+JDFHdyXxZGgQwD/ih77trLZOEr4H
	 5vsY1Qj1Bxu1pyee5UGo97cu713H8L44YMeWZs2ClF6Djt4HFmveImaTCHGgi/jZC7
	 CV8ohqRema19cVJkbCE+Q/zIEbp8XiPp9oapzAcIohDVXabJzCrIA0LMVrpqixlXdR
	 O6O6uJ4P4xGyYbu8OHQ7ZxIUa/OBUwvhlc1rfMvdljme+G+gGDifFu5e67V0d3T1Ej
	 k4DFT3AsiawNrsF3nSIEv60rcXRdA7jGDgUOjdiVqbMUn8m8FFusujq17o0PjMvLnh
	 YqjLMBJ1TcayQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDFA380A979;
	Tue, 12 May 2026 10:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: hsr: fix NULL pointer dereference in
 hsr_get_node_data()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177858240630.2796465.7028277115824206441.git-patchwork-notify@kernel.org>
Date: Tue, 12 May 2026 10:40:06 +0000
References: <20260508124636.1462346-1-2022090917019@std.uestc.edu.cn>
In-Reply-To: <20260508124636.1462346-1-2022090917019@std.uestc.edu.cn>
To: Quan Sun <2022090917019@std.uestc.edu.cn>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, fmaurer@redhat.com,
 bigeasy@linutronix.de, luka.gejak@linux.dev, mingo@kernel.org,
 arvid.brodin@alten.se
X-Rspamd-Queue-Id: 1684251ECD6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287079-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  8 May 2026 20:46:36 +0800 you wrote:
> In the HSR (High-availability Seamless Redundancy) protocol, node
> information is maintained in the node_db. When a supervision frame is
> received, node->addr_B_port is updated to track the receiving port type
> (e.g., HSR_PT_SLAVE_B).
> 
> If the underlying physical interface associated with this slave port is
> removed (e.g., via `ip link del`), hsr_del_port() frees the hsr_port
> object. However, the stale node->addr_B_port reference is kept in the
> node_db until the node ages out.
> 
> [...]

Here is the summary with links:
  - [net] net: hsr: fix NULL pointer dereference in hsr_get_node_data()
    https://git.kernel.org/netdev/net/c/911f54771ca9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



