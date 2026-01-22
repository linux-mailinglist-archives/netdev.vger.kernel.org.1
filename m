Return-Path: <netdev+bounces-252173-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLeSGxCecWl6KQAAu9opvQ
	(envelope-from <netdev+bounces-252173-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:48:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D46A61755
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4E7893E552A
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 03:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0CE421F1C;
	Thu, 22 Jan 2026 03:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXZ0yI1u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B79421EE9
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 03:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769053217; cv=none; b=k8OBaIZ8Y1bVTjUYLovW72d55f9E2yuBPKT098njDvdq67hU/z7ggPMIAOEPDvELB44g6X3OLBknEzY8Oj20iXewnAwo/BK0bz4qYduUE53wCr9jWdHVDOCE3Ue9htjbIwvpnHlJp9QhOGEiHQBcWbb7lppcmxjJBrX4M6ONLSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769053217; c=relaxed/simple;
	bh=F/HLWo1nb0umw5OHc+XB6puSsOQS+eEIfqFAb2QddTU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d0FW61+RzxvHB6zU6OwRV0A/nAy6eFsV6Cq1IVHlv7XQf9hxgILbUTSE417QWjRG1Y/cSQiikcfOA6GScHqdtTEi3y4v+XlpxgQVsa9eSPYIhkwMTUSDznyk+wdEVhLjejvtAkkvQoLIgVojgkMlb/92sdySuxgFgkI3HccSET4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXZ0yI1u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A76C116D0;
	Thu, 22 Jan 2026 03:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769053216;
	bh=F/HLWo1nb0umw5OHc+XB6puSsOQS+eEIfqFAb2QddTU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NXZ0yI1ug9d6BSBcqf6vhCxNkvSd5LBsblcAveFQzksme49UzlJx7Jm0U5Ilq3f9x
	 sS60iq0Tn8vLBymPdxYY6Kr9exeqVpcccwmk2n5MfaYgJe71Gjk0mWs6GG7r1Ww0ms
	 nXr1XH/9Fx+Pl0eQ3k2thH992ageXl1ZtQ51eJnYI4le0DAs7hUkIkSx4x5KgWyG+r
	 iq+Ccr7mqECQKBzrFuljxk66bJmQxtT8XzwSSUiyr7VeKwFG8JhEjBwyvseNlyBb9k
	 5TBNviJzBSf04O0ezZUbeokKW0qZOJZeIq3clJw7imcLgQLWsRQL1Cb7YmTekJG8Pi
	 PaB3vRkD1gVKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BE2B3808200;
	Thu, 22 Jan 2026 03:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 0/3] gro: inline tcp6_gro_{receive,complete}
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176905321309.1545617.12379390026240054084.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jan 2026 03:40:13 +0000
References: <20260120164903.1912995-1-edumazet@google.com>
In-Reply-To: <20260120164903.1912995-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
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
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-252173-lists,netdev=lfdr.de,netdevbpf];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5D46A61755
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Jan 2026 16:49:00 +0000 you wrote:
> On some platforms, GRO stack is too deep and causes cpu stalls.
> 
> Decreasing call depths by one shows a 1.5 % gain on Zen2 cpus.
> (32 RX queues, 100Gbit NIC, RFS enabled, tcp_rr with 128 threads and 10,000 flows)
> 
> We can go further by inlining ipv6_gro_{receive,complete}
> and take care of IPv4 if there is interest.
> 
> [...]

Here is the summary with links:
  - [v3,net-next,1/3] net: always inline __skb_incr_checksum_unnecessary()
    https://git.kernel.org/netdev/net-next/c/9bd6ff503077
  - [v3,net-next,2/3] gro: inline tcp6_gro_receive()
    https://git.kernel.org/netdev/net-next/c/87737cd76e44
  - [v3,net-next,3/3] gro: inline tcp6_gro_complete()
    https://git.kernel.org/netdev/net-next/c/b8d9b7daf0af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



