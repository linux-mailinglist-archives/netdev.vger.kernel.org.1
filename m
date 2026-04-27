Return-Path: <netdev+bounces-281204-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBXWEvOv7mnxwgAAu9opvQ
	(envelope-from <netdev+bounces-281204-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 02:38:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBB146BB79
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 02:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAE9B30177B7
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 00:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE68227BB5;
	Mon, 27 Apr 2026 00:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+13j8ni"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09AE2253B0;
	Mon, 27 Apr 2026 00:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777250263; cv=none; b=cOeYvqZFBD8+qf0n18FTtl6XyWCrz/1jOFvnKJgsKRmRb1rhz3f7Owhzb7bqIMC30qkZRzJtUaCa/vXb6mKKIKpGcEbHGOxjG2q+i1kYX4D/pq7wCLEo2pXMMfzLdyvMN7oAtgxkj6A4pWaO2F011rBhTJ35fjQQgTRHy8JR9Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777250263; c=relaxed/simple;
	bh=ecotAYMbddRE5w68GqUKdGf6jiz6DoIZilUp6kFaGp4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FuUwJekv+zHZ1o5Vx+qh7srzVUezkP8fpeegYLGz2RNZzsyhIHtjfiFAkwAISXYV3jS5Rn6tmLgKNW1wSSxtFpOHBQfp9HKHXDRamK4zA/5XzMnlisDCHCxTQrPBrDCy+rfGXpjPWVjZZXiucCteQcUkI0OhoV8tt+3U0qEcsPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+13j8ni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFCBC2BCAF;
	Mon, 27 Apr 2026 00:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777250262;
	bh=ecotAYMbddRE5w68GqUKdGf6jiz6DoIZilUp6kFaGp4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E+13j8nitS1b4Gk+NW6fWdrmygDa9lunAgUNOBAeRDMCHxSY3ApXc1/cGZrUhRRLi
	 IWg9Q4FnTIu6Z8zevsd9svJSdCiXvaTanIGkGZhQMm4JeAQu8e2xhEO0EP6BD+XpJF
	 GKsQCBIU2Svx8S5fzBK/cmXevOxXd6slKHt3WSOJStMzfYjaNvT+z3ofAxHaEgQNWm
	 SqtOhOLY7jkMwY/d+OpLnNymI/mJxG2QYriifCOqpTHJ1mYWOJ55u4cdCWluE9VXmv
	 PSspfqFBbbrvRzSvmbbMziaCOGt75Uc9Mq9q56MERfeLwMfKRwZvs1uhtT6Ge5A8x8
	 sni0+Q9XPJ+Bg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FF4A38119E5;
	Mon, 27 Apr 2026 00:37:02 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] net: packetengines: remove obsolete PCI drivers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177725022080.2839245.6272027527094082073.git-patchwork-notify@kernel.org>
Date: Mon, 27 Apr 2026 00:37:00 +0000
References: <20260422044820.485660-1-25181214217@stu.xidian.edu.cn>
In-Reply-To: <20260422044820.485660-1-25181214217@stu.xidian.edu.cn>
To: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, tglx@kernel.org, mingo@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: ACBB146BB79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281204-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Apr 2026 12:48:18 +0800 you wrote:
> As discussed with Andrew Lunn, this patch series removes the obsolete
> hamachi and yellowfin PCI drivers. Both drivers support hardware that
> is over two decades old and no longer in active use.
> 
> Removing them eliminates dead code and reduces the overall maintenance
> burden on the netdev subsystem.
> 
> [...]

Here is the summary with links:
  - [1/2] net: packetengines: remove obsolete hamachi driver
    https://git.kernel.org/netdev/net/c/4cf42f9c3e36
  - [2/2] net: packetengines: remove obsolete yellowfin driver and vendor dir
    https://git.kernel.org/netdev/net/c/aec3202247b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



