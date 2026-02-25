Return-Path: <netdev+bounces-260719-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EM+6BgVcnmlrUwQAu9opvQ
	(envelope-from <netdev+bounces-260719-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 03:18:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5DC190D19
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 03:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25C7331DA7F0
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 02:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204FE270EDF;
	Wed, 25 Feb 2026 02:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gs1Cq5Zz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA1126560B
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 02:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771984806; cv=none; b=ehTY1SGpfQYt/m0+bzi5WnqgGQz9cuTrsIU+ZXyH+FUsg2iZCXo8nsap4OUA+FgBNiJvAjGoq2QbVMga6JwRwD6yfuCzssvLv25aLZWbQ24BhCzyCAVvAF8QKyukXy+prpN6zhatpxrZm/knlFJTwkixtmgSngs9WXwnkcrMhM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771984806; c=relaxed/simple;
	bh=UMqzoy9cGXlU3Qf+PPr+vPGpC9apLG4Wtu4tMQNGXqM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h4No5Ha9fXcTmHGVz6Jb28GJ1ZebKQqkzNdtvjciR0wX0pDHBZjOAV7P658qARwU80nrPUHgq2r7QaRyEjnbZOpoz2dKEPBDKatuOEjiTHS09AfmFokKNlYjHoJg+oCyRot/CiL4GKZ0lpLY0FNcSNDahqt5VmmcUY8hJWHfxy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gs1Cq5Zz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF473C116D0;
	Wed, 25 Feb 2026 02:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771984805;
	bh=UMqzoy9cGXlU3Qf+PPr+vPGpC9apLG4Wtu4tMQNGXqM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gs1Cq5Zz4hT3mGGrohwSKeU/PG95LZnU0gJ5fTK5rGcmYmBt2HmyZ8rZQ2USwoG6Z
	 kjdvClHCoqigI2RDf6vczS4vfDvfqIq36JgI40wBzt5+sixMccCMpawsbIa/Z+DPkn
	 HS33VozYGaaqBlMQ065hcp+Vtt3GYsk8aig9WxJB3ESaeeiSrdsgvAG0UErXxREurc
	 9stOHbb6pksaGhNH2oYzzwn3mbIf/7CwZPPa4x87O3mL4mPvecNLgp5qE0auw1Novt
	 wmS/Lpr+QCZK1Z5/5+gWjuFTfywlfDVAJ85445a4fsKVCRJerTOMhLnij5RM7DI2d6
	 bXHMs1q7F610Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE213808203;
	Wed, 25 Feb 2026 02:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] icmp: increase
 net.ipv4.icmp_msgs_{per_sec,burst}
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177198481078.34120.11369353220877926499.git-patchwork-notify@kernel.org>
Date: Wed, 25 Feb 2026 02:00:10 +0000
References: <20260223161742.929830-1-edumazet@google.com>
In-Reply-To: <20260223161742.929830-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, dsahern@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-260719-lists,netdev=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: AB5DC190D19
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Feb 2026 16:17:42 +0000 you wrote:
> These sysctls were added in 4cdf507d5452 ("icmp: add a global rate
> limitation") and their default values might be too small.
> 
> Some network tools send probes to closed UDP ports from many hosts
> to estimate proportion of packet drops on a particular target.
> 
> This patch sets both sysctls to 10000.
> 
> [...]

Here is the summary with links:
  - [net-next] icmp: increase net.ipv4.icmp_msgs_{per_sec,burst}
    https://git.kernel.org/netdev/net-next/c/64db5933c7ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



