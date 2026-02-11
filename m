Return-Path: <netdev+bounces-258187-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIMQJKADjGnIegAAu9opvQ
	(envelope-from <netdev+bounces-258187-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 05:20:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAB1121272
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 05:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4AC9302E847
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 04:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B298353ED3;
	Wed, 11 Feb 2026 04:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhoOpl6B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EEB353ECD;
	Wed, 11 Feb 2026 04:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770783621; cv=none; b=AOhW6T4Dsh4YocrI/CZAqScD0S2mgcFl5wg2rhMR9XA+ZXAriKocJLs3KqVjANymAxXXZSQIgqlVPezcC4/5tL87o5QqWvvxi6vBWSIK8Ir4QnprgonTIkMbJN9ZgL1xB4+STcpOvR4B7MryfHhbt24G5l173Dyfe3TY6ymtMvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770783621; c=relaxed/simple;
	bh=9Oxo+UVl7dL+HcOCaKBVT+8Fs43H69MUeKBDYp2ObPM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YfOY0nTOqpKK8BxAa2C7xoGydGosgpPKtybm/xarBHeycCYvQ6A0xq1g8OMsNHUl3unk7Xp07cWK3/kwnn9xxn/DeOo8t3GGmoXY9OTvOl33yFOFzZnYrNK89QRuCQwJLg2lRpAxr4OZBtIxHdmpyIxuIE30XhQcFfnpsoehKV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhoOpl6B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7FEC4CEF7;
	Wed, 11 Feb 2026 04:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770783620;
	bh=9Oxo+UVl7dL+HcOCaKBVT+8Fs43H69MUeKBDYp2ObPM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EhoOpl6BApE8U0nxvPoKnGdhRZwn8xJS3VYMVEloWz4Nzo1IuTfwyLRx4KIR50RX0
	 kHBkVv120In36fpTQnJj7kK5qGarSpLxH66OJgDgbWUT8fJrGr6wditHzUtvQspk4y
	 tIJ7KCsXSHjzM+u1ZWyJAo17Xg/bM7i4e3ePpWy70yhj8mpa5eGHoAIggAAbILUY1e
	 RMmo9cGps1+C17nPoEFugbIht3dW5ctmhuhAin+l2b36gzKHffxeQ1rHmFlr1uQMX5
	 LWGRxITfj9DFEJ8fmZmnryAZxbVhz7RltcMy6Zh8iaLLjY3akTFewI3AR1+YvevrJw
	 uOERtmCqomLDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B1AB380AA50;
	Wed, 11 Feb 2026 04:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 0/4] net: netconsole: convert to NBCON console
 infrastructure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177078361556.4190841.1165444988893621520.git-patchwork-notify@kernel.org>
Date: Wed, 11 Feb 2026 04:20:15 +0000
References: <20260206-nbcon-v7-0-62bda69b1b41@debian.org>
In-Reply-To: <20260206-nbcon-v7-0-62bda69b1b41@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, pmladek@suse.com,
 john.ogness@linutronix.de, gregkh@linuxfoundation.org, rostedt@goodmis.org,
 senozhatsky@chromium.org, akpm@linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de,
 gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net, mpdesouza@suse.com,
 kernel-team@meta.com, horms@kernel.org
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
	TAGGED_FROM(0.00)[bounces-258187-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,suse.com,linutronix.de,linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,meta.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1DAB1121272
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 06 Feb 2026 04:45:28 -0800 you wrote:
> This series adds support for the nbcon (new buffer console) infrastructure
> to netconsole, enabling lock-free, priority-based console operations that
> are safer in crash scenarios.
> 
> The implementation is introduced in three steps:
> 
> 0) Extend printk to expose CPU and taskname (task->comm) where the
>    printk originated from. (Thanks John and Petr for the support in
>    getting this done)
> 1) Refactor the message fragmentation logic into a reusable helper function
> 2) Extend nbcon support to non-extended (basic) consoles using the same
>    infrastructure.
> 
> [...]

Here is the summary with links:
  - [net-next,v7,1/4] printk: Add execution context (task name/CPU) to printk_info
    https://git.kernel.org/netdev/net-next/c/60325c27d3cf
  - [net-next,v7,2/4] netconsole: extract message fragmentation into send_msg_udp()
    https://git.kernel.org/netdev/net-next/c/eaf35bc63be7
  - [net-next,v7,3/4] netconsole: convert to NBCON console infrastructure
    https://git.kernel.org/netdev/net-next/c/7eab73b18630
  - [net-next,v7,4/4] netconsole: Use printk context for CPU and task information
    https://git.kernel.org/netdev/net-next/c/79ba362b4337

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



