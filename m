Return-Path: <netdev+bounces-289704-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SH4oNLYVDWq5tAUAu9opvQ
	(envelope-from <netdev+bounces-289704-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 04:00:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 704EB586AC9
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 04:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F25BC304683B
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 02:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7355E277035;
	Wed, 20 May 2026 02:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5Uvk6vb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAD22F8EAF
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 02:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779242418; cv=none; b=XU6cPBedV7vrn49sBCluMR97gRDMPgWXce+Pz2XNDqgHxc3B52MWZ5uw4aw5FM+REZSDKnA8VfGoiHVsjR5WwOqhwNXwMLZ0xlrmMbiKaLdk7fEP+L3IenDS8GaQMVmXsYsgRaE+PbZPZ6DvM49R6zZhJE6gz9uXD2K4U7B2UN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779242418; c=relaxed/simple;
	bh=sV5+g2KST7Ft3mgtVlfkQlmd+2hlYbcoMxTu66P/1bk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sT6hqQz9rerx2tIoAnU5fkWVdzuUio1wbx/dU29t7Z53f7WohGDb58AM2liiXWLcGZnfl6qAzF2V8l3qvbrdvr6MkyecvzzF97v5xEuzYeh19iyx4rMs6/zhKjS0dHW2IDRR6i73wREs2nfr2ycgatIz8pdBhgQnUTGWBvNb6ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5Uvk6vb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD981F000E9;
	Wed, 20 May 2026 02:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779242411;
	bh=5spzlKnVMhWZCSzjzCWzb9JLZ/e8rrt3UIHXRTR/Yd0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=M5Uvk6vbGkfqcc7NB+dXQFfPgXjFgv4zxE22B3RyYSKc1BiiLfEkqTvTQb+BNxRh7
	 E4T45zOMuR0Hk6OoDUBUkLaR+Ep/j8GrFOvOEnfPiL/v/AkM6wfJJkPxSYORjqEfJX
	 NZ3BNR+EhB6bVxPsQxz3Ch3z1txu7Glji/qHSUwB5x32KRiWAJGAydulJZcDE83dmO
	 5PPwOE0D+jK0q9y7VUMFYYgCCjqmhlXm4Wj0aDt0btRo4T0okyG7p4DQaDtcqRpg1S
	 H25K8jvsMoorsByh/QV9SB0NqtT+5V6V1h4ZVrpujiw3wRStj/e26nOFZE+hG8skL6
	 NOyqjMrzG35dA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198E8383BF53;
	Wed, 20 May 2026 02:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/sched: sch_htb: fix htb_dump_class_stats()
 vs
 offload mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177924242163.2949285.4462026164907275161.git-patchwork-notify@kernel.org>
Date: Wed, 20 May 2026 02:00:21 +0000
References: <20260518090518.629245-1-edumazet@google.com>
In-Reply-To: <20260518090518.629245-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, victor@mojatatu.com, jiri@resnulli.us,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, maximmi@mellanox.com,
 tariqt@nvidia.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,mellanox.com,nvidia.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-289704-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 704EB586AC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 18 May 2026 09:05:18 +0000 you wrote:
> htb_dump_class_stats() and htb_offload_aggregate_stats()
> call gnet_stats_basic_sync_init(&cl->bstats) which
> is wrong on 32bit arches when syncp is cleared.
> 
> Make sure to acquire qdisc spinlock and use
> _bstats_set() to ease future lockless dumps.
> 
> [...]

Here is the summary with links:
  - [net-next] net/sched: sch_htb: fix htb_dump_class_stats() vs offload mode
    https://git.kernel.org/netdev/net-next/c/231c53e1a529

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



