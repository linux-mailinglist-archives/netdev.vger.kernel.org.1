Return-Path: <netdev+bounces-298268-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f2yNO0X6KmqK0QMAu9opvQ
	(envelope-from <netdev+bounces-298268-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:11:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40703674571
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:11:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kivoiqx1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298268-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298268-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDB9333DF3EA
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 17:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FB638333B;
	Thu, 11 Jun 2026 17:58:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF7110785;
	Thu, 11 Jun 2026 17:58:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200691; cv=none; b=agD7jpGB+M8+eXqLD9msBFjB78MDBNS0L6wCizbdftSKldz94I8LuaWqHqP3If9nJwuH4JUfBqIf6dj0Tcyxf6N3ZkO07x1OvWApLJz1ESv5PMcV1CIdKtqVIdW5uG8i+x7drsWQm+XWgk8SDSHwt/KlxRhIeGnhwKO6h+Wmno8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200691; c=relaxed/simple;
	bh=jTupZYfdlibwO7fHX6qwlBQEh/IEIvd0t6JgvAB0ZDI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=puoQ6/TcnuhRY/7w72t0IOeKqHpAGDAkMonRqkE6/qg3V7I3iXLtrAmmufW3SbVUXsHv76biQ9MPrW8NOTA9bMqPiOyjfReN5PDM0tBzAi4mqfzo31L1f5+YGoFJUcgotzXlYx5s6mpu+25oCWzQtYUmPbA62ZE09n4rWD5p2FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kivoiqx1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CEC1F00893;
	Thu, 11 Jun 2026 17:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781200690;
	bh=Gs00lLWhI4VXZ9S62b5ijwbVL87akkIGVr1Q9lteUEg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kivoiqx1Wuzs8zC1sK398UVErkgbLzClya8/iB6XWaUx/SCfT5Nt8CchCIW21AjpT
	 IiLviEpZRupdskKiGG8b3H2XACL4bwGyZHDMYB2/l2xWqfA17XyauP4ZT6y6q7uRr0
	 LEhc37eLmw6F/p4HIcgdMCbg3VBV4Sd1HVm9AvlqDI8iDe7wlEKhFJiHXTcLrewK2l
	 BKZKuCkbCBoqi+s+1kunCseTg3H6wEpqYRcRM8M9VevPlbLXeDLAge8jYhH/IJe08C
	 17gB3ytcM+FtgP2aYfgTm7w5gakW3pb70AjjTecpbYrFORza8M6bFgXnkf8qnw4u5I
	 Vm6k/ARCpxmsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8A3493930F87;
	Thu, 11 Jun 2026 17:58:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2026-05-14
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178120068734.286318.15929310883148009790.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 17:58:07 +0000
References: <20260514172340.1515042-1-luiz.dentz@gmail.com>
In-Reply-To: <20260514172340.1515042-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
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
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298268-lists,netdev=lfdr.de,bluetooth];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:luiz.dentz@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
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
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40703674571

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 May 2026 13:23:40 -0400 you wrote:
> The following changes since commit c78bdba7b9666020c0832150a4fc4c0aebc7c6ac:
> 
>   net: phy: DP83TC811: add reading of abilities (2026-05-14 15:17:12 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-05-14
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2026-05-14
    https://git.kernel.org/bluetooth/bluetooth-next/c/23f3b04f157c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



