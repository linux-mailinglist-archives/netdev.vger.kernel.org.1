Return-Path: <netdev+bounces-277232-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cA7ZJTpx2Gk5dQgAu9opvQ
	(envelope-from <netdev+bounces-277232-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 05:40:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D593D1E29
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 05:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 759CA3006946
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 03:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD7231E83E;
	Fri, 10 Apr 2026 03:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LV3Nq1l9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACF0318EC5
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 03:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775792438; cv=none; b=L1y03PPSCPkZmKTLJrCtlxdYDncA9XQ8y9c4EDUiETuMhcBQ5s97LWU/ZXDD3hwKjJ0WK7bScayy3aIelewBNAT6Kjk4KpZe2GdxmeBbl+Ee9HqzHVBMRswYPloVUYArOKpPIQjE/1WCKievK7OuPKBJC8pBBv7wMO0V/IzfZCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775792438; c=relaxed/simple;
	bh=43ON8pCnlkxBAfvfMAWo7SvB3NGbG+ht/WSaeQ5L5tM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BV1uNCSi4/76olbPk5YQGefWGL2R7e4qhy6DUZUKlrDtZLcnz5m3R+yDoGr9KNXcjvn1VuuYRLNNca1DWG0VdBac2JyRPOrYUw7xoSFZt/P0ouSSGNjKSyf6JRw6XwLurH8wm8Has9J2pOuBYsdSnZpmjDTD0WnErugmQL8qbcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LV3Nq1l9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D25CC19421;
	Fri, 10 Apr 2026 03:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775792438;
	bh=43ON8pCnlkxBAfvfMAWo7SvB3NGbG+ht/WSaeQ5L5tM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LV3Nq1l9pgac5Tb7A44a26a4wB4eB3OfMYZj4CRxjAxzGn89WzXOFF15+LTXQjBp7
	 XWqO4m4lW9CHqUg7ogx0/7t618rL8W+PdKaKprC5HdaXhtBIzxEQ5JjhF+cFevPAnN
	 HhZcvQKIQUiVS1EdY6+l6r4h+Fnl2oGm1N5CcRPR4dbJDWvjH9gDwenIs0qE9Y5XGg
	 pPrpkEmQ5haqYQcygv/k1Y4LCyDSmvrm+NxX73YvRIuXuU5h7q5ieLeLAf7hkvAP3J
	 W43BoWcZUilG7sV9tuhbVw926/lH8Cd8zFzfPI3BC9eLraWzvJUspWEAi6btl5OqZm
	 RCbKRsZSVsaOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E383809A22;
	Fri, 10 Apr 2026 03:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/3] net: bcmgenet: fix queue lock up
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177579241354.1854480.4016027802423644177.git-patchwork-notify@kernel.org>
Date: Fri, 10 Apr 2026 03:40:13 +0000
References: <20260406175756.134567-1-justin.chen@broadcom.com>
In-Reply-To: <20260406175756.134567-1-justin.chen@broadcom.com>
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 bcm-kernel-feedback-list@broadcom.com, florian.fainelli@broadcom.com,
 opendmb@gmail.com, nb@tipi-net.de
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,kernel.org,google.com,davemloft.net,lunn.ch,broadcom.com,gmail.com,tipi-net.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-277232-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 02D593D1E29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  6 Apr 2026 10:57:53 -0700 you wrote:
> We have been seeing reports of logs like this.
> # [   39.713199] bcmgenet 1001300000.ethernet eth0: NETDEV WATCHDOG: CPU: 0: transmit queue 2 timed out 7991 ms
> [   41.761198] bcmgenet 1001300000.ethernet eth0: NETDEV WATCHDOG: CPU: 0: transmit queue 2 timed out 10039 ms
> [   43.745198] bcmgenet 1001300000.ethernet eth0: NETDEV WATCHDOG: CPU: 0: transmit queue 2 timed out 12023 ms
> [   45.729198] bcmgenet 1001300000.ethernet eth0: NETDEV WATCHDOG: CPU: 0: transmit queue 2 timed out 14007 ms
> 
> We have two issues. The persistent queue timeouts and the eventual lock up of the entire transmit.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/3] net: bcmgenet: fix off-by-one in bcmgenet_put_txcb
    https://git.kernel.org/netdev/net/c/57f3f53d2c9c
  - [net,v3,2/3] net: bcmgenet: fix leaking free_bds
    https://git.kernel.org/netdev/net/c/3f3168300efb
  - [net,v3,3/3] net: bcmgenet: fix racing timeout handler
    https://git.kernel.org/netdev/net/c/5393b2b5bee2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



