Return-Path: <netdev+bounces-252198-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHduLDqkcWmgKQAAu9opvQ
	(envelope-from <netdev+bounces-252198-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 05:14:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C28561A3B
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 05:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7834936343E
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE4D423A94;
	Thu, 22 Jan 2026 04:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qyq9rHIx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D80329E76;
	Thu, 22 Jan 2026 04:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769055011; cv=none; b=qTbI21nhEX2X6yVS7TbKUCPa0UguBHP/Z8oFYqK2DmPb2L7D/9cMXuGEzFZZKkMlrwt/z4NfMSGeMi5nW489FoUbOEHJ+LRVWsHJ57eb1lwsYdqdr5tTdA5MTQAgmAxroWdnDv12fcLO/gV/4J2jlGBIoILzNRTao4JOLWAceko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769055011; c=relaxed/simple;
	bh=1WO9TU4Dslvts1asQBOBO2AKJEL/Mh/aFxmLZBy4O0s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eZqnrduuTbPNZd1hzltaZHSorSfhxZZmQCzIQdjSpTbVkUUV3/hSKQYhbvWpQWA1oKjDSvlsOR83FMOuvGz9str9rWkDMNqG+ZcSYBTslog3tPje+OSyq32uSsNByElCaBZzxbwNnP7xojeEEtQa8v7PAu2S+GirnbTKW1iQyMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qyq9rHIx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1009AC116C6;
	Thu, 22 Jan 2026 04:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769055011;
	bh=1WO9TU4Dslvts1asQBOBO2AKJEL/Mh/aFxmLZBy4O0s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Qyq9rHIxgXpAqu0TffHzQvr/Z5zgSF4vPzXIqmo+W3qD8vIAbanGRddZPFQq0ZKAw
	 cKSlxgVU7mQCgSIA60HcYEBfA/a+UKwDBhaHnkpiHStU8Ajkqscf0ish9Fqwxqz2Ow
	 neb0mub4y8LBBIfEiyOCE+mmbsXIbdBzptiLMTindLRpKr94WVbhkVCxANm2mDY6h6
	 IP+69vGkhYmjrLiKMqehXJmuH4zk/74OUVasAR7HAHmhSSE/0M8uTc5Jb5wDNA6MON
	 2VjK2MJuHa+1Z5TXUmXeWZF0nAgY4K9OM2dDLD9f3X2vlbV+00+bpItkj96ShfLENo
	 ZWQ263Nh5FlMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11D973808200;
	Thu, 22 Jan 2026 04:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] rxrpc: Fix data-race warning and potential
 load/store
 tearing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176905500760.1552379.11244217632652361108.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jan 2026 04:10:07 +0000
References: <1107124.1768903985@warthog.procyon.org.uk>
In-Reply-To: <1107124.1768903985@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org,
 syzbot+6182afad5045e6703b3d@syzkaller.appspotmail.com,
 marc.dionne@auristor.com, edumazet@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, stable@kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_FROM(0.00)[bounces-252198-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,6182afad5045e6703b3d];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C28561A3B
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Jan 2026 10:13:05 +0000 you wrote:
> Fix the following:
> 
>         BUG: KCSAN: data-race in rxrpc_peer_keepalive_worker / rxrpc_send_data_packet
> 
> which is reporting an issue with the reads and writes to ->last_tx_at in:
> 
>         conn->peer->last_tx_at = ktime_get_seconds();
> 
> [...]

Here is the summary with links:
  - [net,v3] rxrpc: Fix data-race warning and potential load/store tearing
    https://git.kernel.org/netdev/net/c/5d5fe8bcd331

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



