Return-Path: <netdev+bounces-260759-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGE9EEt2nmnCVQQAu9opvQ
	(envelope-from <netdev+bounces-260759-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 05:10:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F7519182E
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 05:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F35530D64DB
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 04:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A14D2C21C2;
	Wed, 25 Feb 2026 04:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWAs7loy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2CF2C15BA
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 04:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771992591; cv=none; b=MV56TtWCAb1vLY0zojoTHhBQ6ooanDPM8jDZQe/xJYVEAA9ogJf5xNnZhhadXS5/1u2ji6Sc1bzaw/ijnRibHfh7QtaCc8jPvqqWAmrOQFJXbB0V3qrAz+NaCVm2Pq2ba3RKWhgj0kN4IGYm+cpCobQX98N+3Atb8K0QlTXOKfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771992591; c=relaxed/simple;
	bh=ogwPug3RASCdULuK0pAT4HYzg0zwOdINmppl7vi+fu8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VFcaIQ/XgxppGAuQIyVPhqjK9SiBfYwwhl6vNW2HPAMnYgeHGZKYD26nMKB9xV8cL6VEIblpS206GA+4Sw+SfA1WRM7BmohlIOfwW+utSqBvimIp0p4Aj1eAWoN6KMJLG5+nvW4RAgwNX98crvCB5HWsMATm9hMhjphY4NHlQuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWAs7loy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA83C116D0;
	Wed, 25 Feb 2026 04:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771992591;
	bh=ogwPug3RASCdULuK0pAT4HYzg0zwOdINmppl7vi+fu8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qWAs7loyrIVOxCC4GHqyJJlynL5DIbNvzab/M1K2v7NdSh6KVIJYPghJDsrai709i
	 rt8EPj0U0fd5Lhu09JPbUVW3ZAQWYsTj0T+VXXcQXYwi28s0S0kVgJCrcXIhka2nFG
	 HV02eBcD77DR3Wj4Iha5EByP4TQuXD6s1zGfWhr8kyhCzZiNdNrUkhjWwubZRGEA91
	 NYBtqIkvnqAwcqN64BRbCJQv3yeL22G09sdaYoyBzmKuhjA4rdVc4pzmiLsIxjKPba
	 di15jHU1wBdkp24S0YoFklmQaViAn3POdp3yl7M849StOyX8FIFYhdPaVYJuRmGiBk
	 3lhMclk5genlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FEE4380820E;
	Wed, 25 Feb 2026 04:09:58 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] bonding: Optimise is_netpoll_tx_blocked().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177199259679.36698.45241655765971962.git-patchwork-notify@kernel.org>
Date: Wed, 25 Feb 2026 04:09:56 +0000
References: <20260223230749.2376145-1-kuniyu@google.com>
In-Reply-To: <20260223230749.2376145-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuni1840@gmail.com, netdev@vger.kernel.org
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
	FREEMAIL_CC(0.00)[jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-260759-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B0F7519182E
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Feb 2026 23:07:18 +0000 you wrote:
> bond_start_xmit() spends some cycles in is_netpoll_tx_blocked():
> 
>   if (unlikely(is_netpoll_tx_blocked(dev)))
>       return NETDEV_TX_BUSY;
> 
> because of the "pushf;pop reg" sequence (aka irqs_disabled()).
> 
> [...]

Here is the summary with links:
  - [v1,net-next] bonding: Optimise is_netpoll_tx_blocked().
    https://git.kernel.org/netdev/net-next/c/fc1f97929ada

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



