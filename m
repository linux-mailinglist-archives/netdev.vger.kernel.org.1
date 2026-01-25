Return-Path: <netdev+bounces-253210-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oD7DNROJdmncRgEAu9opvQ
	(envelope-from <netdev+bounces-253210-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:20:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E31827A9
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDC9B3000E3D
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 21:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DB022AE45;
	Sun, 25 Jan 2026 21:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPJUHKzM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6983EBF09
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 21:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769376015; cv=none; b=RhEXOD9WN1kNX+gxsldk+TZYiEDw+x3zZClUjV9SdBtRvE9HvlZmex6+7V38Qjn9S0blI3cRH+fogUtksj1SpfqkkUMUUOgIdd3kW4GpV4udHJwS3yYg1a/m7v7hG5xyD3JDAvDA0RmfzDSkcfw53oST3rtEQ8XQcPZdb4H9BlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769376015; c=relaxed/simple;
	bh=Z4CdAElUyEh4ug5WgyTka9LfZHXPHUWsJDxtP006B+I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lns8IGd0okOZGAtjYLU92wD/PuDNS+azkyhtmCWN1qFExqkugYIyYgni21tlxf8SwyOQY250cRixiYuc1yg32wvnrEff4GGrrTUBPT9LCNW3aCmFqQLNZTz2lmXoVDUCA23KgeOWwibUJAjAX8n+8gH5WF3Rap19B4h5VxZHZB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPJUHKzM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C67C4CEF1;
	Sun, 25 Jan 2026 21:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769376015;
	bh=Z4CdAElUyEh4ug5WgyTka9LfZHXPHUWsJDxtP006B+I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sPJUHKzMtxEK1ju0sG43C4nEJOOkkcP8g/BRfg+Hjw87NBHX2bIaD3s5cwEgx2PeG
	 F9N4LxsHWtt96xctUm1WQmrkPF5xSxRpe1FAIE85DnBIs/J1VC2z9NI5LN4Xxkti+q
	 FmCDKe1fbbqMQYZFGvDfeK7BG6QGm28IByZJF0vPgy+UP66FQGRhc6B9GEJRDPweQ7
	 I6nZ0bFtXacp2TqW3k0f9al2hyqRE/Y3XaSEJGoTrZ5kM3ts2FU9DYWhIfnbj9gfft
	 xNTdzRLeuwJtLzUeY2GmfxDko5L1JPIfiyDgD7ynSuUtG+5aJBFGzWUxNgJJ0iy1a3
	 qV73EL9oHCoiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11A453809A15;
	Sun, 25 Jan 2026 21:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] bonding: annotate data-races around slave->last_rx
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176937600986.3588307.10080070062581890485.git-patchwork-notify@kernel.org>
Date: Sun, 25 Jan 2026 21:20:09 +0000
References: <20260122162914.2299312-1-edumazet@google.com>
In-Reply-To: <20260122162914.2299312-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 j.vosburgh@gmail.com, andy@greyhouse.net, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, syzkaller@googlegroups.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,gmail.com,greyhouse.net,vger.kernel.org,googlegroups.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-253210-lists,netdev=lfdr.de,netdevbpf];
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
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 03E31827A9
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Jan 2026 16:29:14 +0000 you wrote:
> slave->last_rx and slave->target_last_arp_rx[...] can be read and written
> locklessly. Add READ_ONCE() and WRITE_ONCE() annotations.
> 
> syzbot reported:
> 
> BUG: KCSAN: data-race in bond_rcv_validate / bond_rcv_validate
> 
> [...]

Here is the summary with links:
  - [v2,net] bonding: annotate data-races around slave->last_rx
    https://git.kernel.org/netdev/net/c/f6c3665b6dc5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



