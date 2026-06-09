Return-Path: <netdev+bounces-296790-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w3EiERRYJ2oGvAIAu9opvQ
	(envelope-from <netdev+bounces-296790-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:02:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8602965B41C
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:02:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SdY3+SZJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296790-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296790-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEFE3304817B
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 00:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2402BE02A;
	Tue,  9 Jun 2026 00:00:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2B33033E7
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 00:00:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780963218; cv=none; b=cvEvDFbSLqfELDaAlvglgNrowMjhXg0emY+2fmDxiCOlI2ZcZAzx/e8QNYam+IaLPBKVhELMbQyF/J4GUFFaGhq3+Kz+y0SoqAnWwOxV/vcaXXzUR1LYWgDznzqdU3tYOa9kY9JloQuSxgPDIU/PjmFtI7XoIpsvq1m86OmqKgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780963218; c=relaxed/simple;
	bh=6tGSF+TEf50yY88lsalB7jBruJKVPX3SzWNcg10iAHM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cjdlnXXNJmZv6WaV+0kNJYDTAtAxRtgJzQhTyUfOcT+MtKIHIALrEaSGdkwNMvAhEjc/cTOn4fYRu2LwrOSrfT0IEfTLSnSELGVXL4dOgaVW+lD7mJ3xPZ0BAZ8xbuTGzJ5U9pubpidEzysTLO1k/psclmiA1ikwhCp3RSNajX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdY3+SZJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB6D1F00893;
	Tue,  9 Jun 2026 00:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780963217;
	bh=egrpFzwC76q9qf4nIB7lcB2gT/DHgjKsY6cCnNpHavI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SdY3+SZJeWERyRXdIi+TaO8NITTj+6NAuGE5OFt8Mrv0zT48r8ZTmQicP+JeKA0nQ
	 NKWlrgTlx/v1aQAMO/h0r3TyWhwob+PgPSsFJsT1nORXY5UBimGdXeR/ceZOVshaSm
	 pjxZAI41YJGyuFYrv2nLL0G51LXWadtlojXY0AdmHLpVwgAazTxrmWoevswjsALifV
	 jmJLo9FLHfpl9Zds3u73wv99EzMKj48oDr1t6KHrwdLjj7GsuTf9JfOnBCLfYUKwcO
	 wc0NMMTDQXdQ+umv951VxSK59nXI8JMgwiASDiQViOvr9ySBH8oa+VJ69RFSikjW4B
	 x9R8vJrq9oXbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1983E3812FDA;
	Tue,  9 Jun 2026 00:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] geneve: Move udp_conf.local_ip6 under
 CONFIG_IPV6
 in geneve_create_sock().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178096321564.1718110.2533406780367970151.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 00:00:15 +0000
References: <20260606204848.1987046-1-kuniyu@google.com>
In-Reply-To: <20260606204848.1987046-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org, lkp@intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,intel.com];
	TAGGED_FROM(0.00)[bounces-296790-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:lkp@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8602965B41C

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  6 Jun 2026 20:48:46 +0000 you wrote:
> Unlike struct ip_tunnel_key, struct udp_port_cfg does not always
> define IPv6 address fields.
> 
>   >> drivers/net/geneve.c:778:12: error: no member named 'local_ip6' in 'struct udp_port_cfg'
>        778 |                 udp_conf.local_ip6 = info->key.u.ipv6.src;
>            |                 ~~~~~~~~ ^
> 
> [...]

Here is the summary with links:
  - [v1,net-next] geneve: Move udp_conf.local_ip6 under CONFIG_IPV6 in geneve_create_sock().
    https://git.kernel.org/netdev/net-next/c/4728f2509f2b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



