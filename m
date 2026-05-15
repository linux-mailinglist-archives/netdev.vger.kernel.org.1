Return-Path: <netdev+bounces-288148-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKejNyV6BmqFkAIAu9opvQ
	(envelope-from <netdev+bounces-288148-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 03:43:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 646335487CA
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 03:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D496B3077564
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 01:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3748936EAA2;
	Fri, 15 May 2026 01:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvTtLbjY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E2B36BCC2;
	Fri, 15 May 2026 01:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778809269; cv=none; b=PYumal3nVgydo5PYWNFwVLXNTm+/xaXUAMtko+QbjiJ/NwzxLt/mAyfDhWFKgYLtu5yEadYBJQqrwGUeTPQcC0eq07o78WdwRmDYCNdr5dZYQGe3XzHdi98BVSCR/AxrLDsAgEMsHB2rkmruIK7lbCcRG6rUGNYLdep8SyS1yyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778809269; c=relaxed/simple;
	bh=F/Xyogd7TdbHFNyzzTlI80ozu2yO0hrkvNATJNh3EEc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hKSBxDTwg94/DFKfO93VpKgVOgAmAL2pSBCogFc8uLGIINdwjP1XWERTzAg4LBRf/+Jq2UTUdCimdQackur9cLi3oW5L3ARgVKfrN1viVSkZmbyaezCtRIxC401Gydk6b8w/4F5bHFrN6htuv6ZlkalT+Inyo5S88cNcfUUdi/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvTtLbjY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B02C2BCB3;
	Fri, 15 May 2026 01:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778809268;
	bh=F/Xyogd7TdbHFNyzzTlI80ozu2yO0hrkvNATJNh3EEc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uvTtLbjYpROnf9NsJaPSupXfqiLwyNyckbWsnfJ5Bapx0rNb15xdYllyCrEszCGlL
	 unjb6aTLFA8rYg4WrGfQgDShK0+bsP/azTSqc7Nv1HdPErb8qe0i9aA7FuD08gmJWc
	 J8d8CBSEvj/i57J1eAP4kCXjVU2NooPQPdWCbA5VZaSTHyeRcoeh4+VHJahCFAY99l
	 ShWYwSZ8N11YDsjGibwGZJkmnS/UMtJJrp3p/mqf1jG/8JoAcwk6mhRnwCkck4mm1W
	 6IGg37msi6ThOP4pq5A5Cclwj/nR1AzUy1+5ea7dNQWSViu1OttFOkvQcfawxc1iHg
	 8HanyLO6SHpZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7183339E4DB8;
	Fri, 15 May 2026 01:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: usb: usbnet: use proper ep number macros
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177880921329.156468.16729351420271370966.git-patchwork-notify@kernel.org>
Date: Fri, 15 May 2026 01:40:13 +0000
References: <20260513132916.39896-1-oneukum@suse.com>
In-Reply-To: <20260513132916.39896-1-oneukum@suse.com>
To: Oliver Neukum <oneukum@suse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: 646335487CA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288148-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 May 2026 15:29:16 +0200 you wrote:
> We have macros to retrieve endpoint numbers now.
> Use them.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> ---
>  drivers/net/usb/usbnet.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)

Here is the summary with links:
  - [net-next] net: usb: usbnet: use proper ep number macros
    https://git.kernel.org/netdev/net-next/c/822d4a8e390a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



