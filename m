Return-Path: <netdev+bounces-252164-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCtgAgibcWmdKAAAu9opvQ
	(envelope-from <netdev+bounces-252164-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:35:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D62A615EE
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E57FE3C7B59
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 03:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8939833C1AA;
	Thu, 22 Jan 2026 03:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBBNUwSx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653103ED12D
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 03:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769052622; cv=none; b=m6uCyfPVPoeX2ngFlHaAjwSsUA2uu7akxYUqyuSf9iYfuTynrZBN7VEJJQHfRghOLi0C/Nag3XOIJG9jkGL/KGgHUQ/C0TDGL6hbwzN9sWM/0cMVNhqI+FtuB1g5wCiYOIWSfw5bbLXVUYL80zxXAP//RZyAbpROL08a9V5gfu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769052622; c=relaxed/simple;
	bh=wVhphtw/Z6Z30S4kcU4jxxzvIQyGOud6gBZ4csv+EME=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=feIbUH5XshVcfK2XoxqQTcljpiGP7YaQBqwyiF3EU0te0t/tIhtJvET6u9qmIhEfGnjyZFVf+9VAs65RACMAeIkSTD7vRYBs2SbCr5QJNjxS0hRRw/PhtGha0rDEYfZ6+SeifbBcyqEYtqDwr76hTlzANHFjnSEQMHGsOjK+DrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBBNUwSx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45326C116D0;
	Thu, 22 Jan 2026 03:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769052622;
	bh=wVhphtw/Z6Z30S4kcU4jxxzvIQyGOud6gBZ4csv+EME=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CBBNUwSxSWVDelv3b7qDpHELyyJJsGBx2uOkZmjZsHFrAOUxpCkZ8oQSKZCc7OLn8
	 G0XJhEDJnQXv53XRf8k015qtG7WWJVKKL1qEBhM12/SeJ3LespL7EAh283aW5VZyBa
	 VvIREW8q6/48rtlPcDGsCYJfKSbmKFD6NgjzdTtKwxWOU6OOaqNiU7onimOHVoOVDf
	 lyDad8RVj5Z/7dlTLtqP7By9x8dPKG3KmENRvVaWfnCGnDAQF/LQal/r1q8n5XfJm5
	 ILAnyLD47/uKaQTrfYfcB4v5OwfF2eKHDjnTQb2dWvTGpnyLAEpPv7B+9cwyFC2J0A
	 V7e21aeamF41g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EC383808200;
	Thu, 22 Jan 2026 03:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: preserve const qualifier in tcp_rsk() and
 inet_rsk()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176905261885.1542867.11045113592731404342.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jan 2026 03:30:18 +0000
References: <20260120125353.1470456-1-edumazet@google.com>
In-Reply-To: <20260120125353.1470456-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-252164-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9D62A615EE
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Jan 2026 12:53:53 +0000 you wrote:
> We can change tcp_rsk() and inet_rsk() to propagate their argument
> const qualifier thanks to container_of_const().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/tcp.h              | 5 +----
>  include/net/inet_sock.h          | 5 +----
>  include/trace/events/tcp.h       | 2 +-
>  net/ipv4/inet_connection_sock.c  | 2 +-
>  net/ipv6/inet6_connection_sock.c | 2 +-
>  5 files changed, 5 insertions(+), 11 deletions(-)

Here is the summary with links:
  - [net-next] tcp: preserve const qualifier in tcp_rsk() and inet_rsk()
    https://git.kernel.org/netdev/net-next/c/a4674aa58be5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



