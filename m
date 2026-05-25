Return-Path: <netdev+bounces-291410-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UORDKPiVFGpfOgcAu9opvQ
	(envelope-from <netdev+bounces-291410-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 20:33:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD175CDAF6
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 20:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCE4030477CC
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 18:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF923F54BD;
	Mon, 25 May 2026 18:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f772ZbpE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F2D36CDE0;
	Mon, 25 May 2026 18:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779733802; cv=none; b=lz0YzhZvIZZ5GQewKUJW2JgnX3YbCaoShsXiR/R110TDVcepZ0vsJkm8OB63mEZPKOgsR8uyjipNJdyD2WfnK/BWYmWE4nwcP0dRPx3ij1bEnhKOP57ladmGbRK20Pau3YNCpu9lKEu5+IXHgN6RYUfYOf+3apPLLhLznSAzbyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779733802; c=relaxed/simple;
	bh=tWZPEXeOloAC/PAAVkdh643jIUT4LTdVY3wP6uFBEB0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FTgdwVli8vsvY8ZRm5SZuwd5TO8aom3HGVeBiQSYgIaeERlCI1/pXk4L6lqjf98GRybFsKrwCRV8y96TFTg3QahLfitoHI6BTUaSVqj5hnUh8fkYS8DDXnr+CU4Oi2NQ99NV5gyIhAzaBEsJGsp8CFcT6PLq6Y/a7UPh3RsFvj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f772ZbpE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A97A1F00A3A;
	Mon, 25 May 2026 18:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779733800;
	bh=TgeODEogQk8+t5MEKprT+zUJT/o9G+ngILd/P7yJ9Pk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=f772ZbpEFiK7kFZ5Yo7uPJCR7XgzeLDYMwN5/kzEX54aJhSs8NJl/6NZ6yTwxI3yi
	 D8tYz3m+h5ZlNZdjP2KmpzWtbXRI9uLjDBz6meQz2pYIUgj0u5A5HmanJGQS9ReJ9D
	 G7DHZY0ffyAihPL7MrKBBlUVSGugZT0FUmiBHCstO19vnwxjbbb3PRgAs9O9+G1S0j
	 avMz7xfiXj8BmgF+O92JWnMmjBHcptPeBcH5bFpYJEbnwB+tAbEfVQ7d9VYvDChDdb
	 oiiRC9p+RALPxOxi+HXHZYUCdZufRRFKYCJ9aRLg5iliXRnbak7PrQsGPvynOtp5I9
	 fIXUEnwiF2eVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56BE8380AA75;
	Mon, 25 May 2026 18:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] ipv4: igmp: annotate data-races around
 im->users
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177973380690.3078812.5378465604442173917.git-patchwork-notify@kernel.org>
Date: Mon, 25 May 2026 18:30:06 +0000
References: <20260522093906.39764-1-sigefriedhyy@gmail.com>
In-Reply-To: <20260522093906.39764-1-sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: jiayuan.chen@linux.dev, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, idosch@nvidia.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-291410-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EBD175CDAF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 22 May 2026 18:39:06 +0900 you wrote:
> /proc/net/igmp walks IPv4 multicast memberships under RCU and
> prints im->users without holding RTNL, while multicast join and leave
> paths update the field while holding RTNL. Annotate this intentional
> lockless snapshot with READ_ONCE() and the matching writers with
> WRITE_ONCE().
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] ipv4: igmp: annotate data-races around im->users
    https://git.kernel.org/netdev/net-next/c/061c0aa740d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



