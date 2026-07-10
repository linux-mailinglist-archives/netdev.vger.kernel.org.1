Return-Path: <netdev+bounces-306582-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VBdRI7r7UGoU9gIAu9opvQ
	(envelope-from <netdev+bounces-306582-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 16:03:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA9E73B915
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 16:03:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="g/RN9mgk";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306582-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306582-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2675302C4A0
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 14:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C4C342526;
	Fri, 10 Jul 2026 14:00:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA472F8EB3;
	Fri, 10 Jul 2026 14:00:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692030; cv=none; b=hK45Nus9NCkthRZsOp/k6Xj2MtVbIlSW3fyTDZtcjm7BC/fPrQwrTSpv/H/lFaUzILXH7xmHLRe7mcHhP6rKe0B0MvBP58L3zRXaBqo4jVBK8pyaDtTZ6LdUtoyDdwHXek1gBShcyeOuVIS3NvNa2yra0bBCPkuTe/5WE73Z6EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692030; c=relaxed/simple;
	bh=5xl278SyMIeXe5hjqQOVoSesKHXlOLanCZzGWAf2Le8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kNGXfr8bvNkbW8NobSJvG4VifZbwba3DultO5/ZQA7wHJxlWuINdRXX7nuXa/o3+yrxx/fsQ7Z3mCLvjL4zEluA13rQOfYBOhoF1HmSSj6MbX6UlbQrdvC7ztYNTffu1aEg+nv1kgXmlGuYvGiqmPyWysqSlC2rK5q0WIKffsR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/RN9mgk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CC01F00ACA;
	Fri, 10 Jul 2026 14:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783692029;
	bh=hfTSfVuhgjiaz3JRn5CsmJKebZiPr5216oywMdpMHXw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=g/RN9mgkA0lZelzmXPeo+3dJPVUCv93XRvdZTyuQ/fnGvPkh8KsnZ/jPcDeMg1KqE
	 ytoW0fYdXl2WBSa8/WRPXTdZItR/Y/KDdfmhAIfe2fXe6yiyxKb7kPdj4riz7g5AVe
	 bXNcTxKSwJk0n28MvnLmcz1/ntTsMNO7cN1eCHS280vjTVeW2jdL4QOK4V2OSo4Lk8
	 Rw3PzGsycb9CXgZug4Fr/7wCT4aMQcNHHmnpqsnR5UZGOMcDMlcuqzUDizUhq7LOGB
	 qfUdXWwxMyXQPCbaV/iY928Q2PB/kUgYM3bPEAiUuASZ6QhuTWOzJkGNnt8tB4VTec
	 09EnUV+UKxLOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938513924F95;
	Fri, 10 Jul 2026 14:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: chelsio: cxgb4: Use str_plural() in
 mem_intr_handler()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178369200704.698057.2108068559084153307.git-patchwork-notify@kernel.org>
Date: Fri, 10 Jul 2026 14:00:07 +0000
References: <20260704121010.201016-3-thorsten.blum@linux.dev>
In-Reply-To: <20260704121010.201016-3-thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: bharat@chelsio.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306582-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:thorsten.blum@linux.dev,m:bharat@chelsio.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5BA9E73B915

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat,  4 Jul 2026 14:10:11 +0200 you wrote:
> Replace the manual ternary "s" pluralization with str_plural() to
> simplify the code.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/net/ethernet/chelsio/cxgb4/t4_hw.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: chelsio: cxgb4: Use str_plural() in mem_intr_handler()
    https://git.kernel.org/netdev/net-next/c/d5d7554052f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



