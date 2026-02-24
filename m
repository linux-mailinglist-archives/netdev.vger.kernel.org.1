Return-Path: <netdev+bounces-260455-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAjBLI6CnWlsQQQAu9opvQ
	(envelope-from <netdev+bounces-260455-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:50:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 38805185A75
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9BF5A30C367D
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CA137AA99;
	Tue, 24 Feb 2026 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PybV4RJB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC0634C808
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771930202; cv=none; b=tdxp+cmpTKJpkjbYXvxrluFcIkJcTnk9zf8vgt5mtgVrWEM+Hxzx0a2vvZFliJ3xQVfzQ3sxiCmQpV8hijcALKoT8iLP6pPddQSXas2W/Cd8XnYotd76NKcr8daymNO1ogl6+PITEjRn69Y4TT5pl/LcdmFyZ+jHVFx7pwmpXxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771930202; c=relaxed/simple;
	bh=5tqj531gv8KZdtq9oHhLggIC9gwOoNdbPobw9bHrr1E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XQDf/ne8EKknjQzcaRkxbkyoS+/hckUO9f47b4fut8u7aVHf2L9TrlLo4mAEN1rpkQ8uWKM33DDZUC/bHk8+7Wjk+qaiIn8nfPCDQehFon+Ncq1nPk7MisxyKi/9yUi7gASd4cs8rywpV5v1H8O4ms+M+w2HCunBzb2alwY5JdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PybV4RJB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82488C2BCB0;
	Tue, 24 Feb 2026 10:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771930202;
	bh=5tqj531gv8KZdtq9oHhLggIC9gwOoNdbPobw9bHrr1E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PybV4RJBrsoHEXwnOGQZyDNEa1oIYFd7Tnhs/gGJc+kvB8KH+o8cDPTSltIYmKXuM
	 xqw7PpPAonwOkq/igasNSNs9hl1vr5Hnh6GAl07EcThttqW2jHhcLuZEVeCoNLVF+X
	 bZxjJXTZzFq4cIxdYxBGKracM4zSi9nwfEONupFlU1Of1h+P/4E3Hj2Nhye/3NPuHV
	 n9odDqMzwyouUKY7GqH61/0Ii3RkvznXUTXCld7FsSrPECsrQ684rodGTdpFs9RQBV
	 qca1BaVrvFnnMwdOM5CJySEdjHYbDSArDUqewDO5HvW3ljnZN8us6nfmMRVsvPN1Zs
	 TUzJYCkrBRdfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF323808200;
	Tue, 24 Feb 2026 10:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: Drop the lock in skb_may_tx_timestamp()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177193020629.3444651.13248671448207071630.git-patchwork-notify@kernel.org>
Date: Tue, 24 Feb 2026 10:50:06 +0000
References: <20260220183858.N4ERjFW6@linutronix.de>
In-Reply-To: <20260220183858.N4ERjFW6@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 kurt@linutronix.de, pabeni@redhat.com, horms@kernel.org, willemb@google.com
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
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,linutronix.de,redhat.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-260455-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 38805185A75
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 20 Feb 2026 19:38:58 +0100 you wrote:
> skb_may_tx_timestamp() may acquire sock::sk_callback_lock. The lock must
> not be taken in IRQ context, only softirq is okay. A few drivers receive
> the timestamp via a dedicated interrupt and complete the TX timestamp
> from that handler. This will lead to a deadlock if the lock is already
> write-locked on the same CPU.
> 
> Taking the lock can be avoided. The socket (pointed by the skb) will
> remain valid until the skb is released. The ->sk_socket and ->file
> member will be set to NULL once the user closes the socket which may
> happen before the timestamp arrives.
> If we happen to observe the pointer while the socket is closing but
> before the pointer is set to NULL then we may use it because both
> pointer (and the file's cred member) are RCU freed.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: Drop the lock in skb_may_tx_timestamp()
    https://git.kernel.org/netdev/net/c/983512f3a87f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



