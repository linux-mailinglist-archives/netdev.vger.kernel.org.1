Return-Path: <netdev+bounces-269728-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UChMCVuRvGlU0gIAu9opvQ
	(envelope-from <netdev+bounces-269728-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 01:14:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2A42D46B0
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 01:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1121830F6E3B
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 00:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B483594F;
	Fri, 20 Mar 2026 00:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1023s2O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F58926AE5;
	Fri, 20 Mar 2026 00:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773965421; cv=none; b=TuAvImZuDJM3IZD4JK0xfPu2qp08LpOweVbRIxS0zfzHJqmbKuhWM7Fekzv3KlTdaOQAwQAyD0J1zqfAIMPudQfskmxnGK9T/DhYKEb1TOZuIBxZe4L3RbrQg8mg9D+SpgIUVy/gjRrWhGzRJk0Yn9RCp/mqvPmFfODf1+M5B/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773965421; c=relaxed/simple;
	bh=sWK1dCbv3qpxRqcpvOm7/Wrmcu7KdWHyvoGXdTciTZA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qZeK5/zCoPnDq8M1PfchotKMEJFKz8tkYnnDyWcxvaVp0t1i8g+bJzmBpkfaFv35GEmsmG4XMHrqO79ZbFpDKdtjiM+ez+Ouc2G9CoKUPoC2nEO+r22b3Aqnv/ff/TINyfmaKXsJBEErnIFmsDGTM37EW0M1HOOHShQidvzKpDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1023s2O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AFCC19424;
	Fri, 20 Mar 2026 00:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773965421;
	bh=sWK1dCbv3qpxRqcpvOm7/Wrmcu7KdWHyvoGXdTciTZA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B1023s2OyCo+KwvodTye6x6+Smzxq6l7bdQ+pZz2SZPQy7FsHWrDhmInvCKbMFCw8
	 nCD4rrviersG5CB6iv/LsgAfMm7RbMmfhqBzeb2GYEPtkpT9eT49fDuXq9/w8Meba/
	 48DCCGeIph19DGCAcNLKjh64BirsB/Co57FEbUa2kWSxrdBh3gX/nEBgRmzANCTR2j
	 tztH9sjh8orZ4lMTxE1R5S24b4VGH0xt56xIL9TZtk2XwX1agQBCvCSUqnRqMOCTPx
	 1yZEyXucGMhfALNSaxDEtFjueKV+Z4G6JqOOMnKP3OmIbjUrxodO9ktrShNCfh/hqL
	 MvHUIl2EhhXAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CE439302F6;
	Fri, 20 Mar 2026 00:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/6] selftests: drv-net: driver tests for HW
 GRO
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177396541154.1856894.14020657481074915954.git-patchwork-notify@kernel.org>
Date: Fri, 20 Mar 2026 00:10:11 +0000
References: <20260318033819.1469350-1-kuba@kernel.org>
In-Reply-To: <20260318033819.1469350-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, willemb@google.com,
 petrm@nvidia.com, dw@davidwei.uk, mst@redhat.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269728-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A2A42D46B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Mar 2026 20:38:13 -0700 you wrote:
> Add tests for HW GRO stats, packet ordering and depth.
> 
> The ynltool and bnxt patches from v2 were applied separately.
> 
> v4:
>  - [patch 6] rename [FAIL] -> [MISS]; NIPA thinks every [FAIL]
>    means test failed, 'cause bash test don't ktap :/
> v3: https://lore.kernel.org/20260316224505.279672-1-kuba@kernel.org
>  - [patch 3] add a note about fq being needed
> v2: https://lore.kernel.org/20260207003509.3927744-1-kuba@kernel.org
>  - [patch 3] do not enable SO_TXTIME for multi-flow tests
>  - [patch 6] move the test to cover SW GRO
> v1: https://lore.kernel.org/20260205220541.2992807-1-kuba@kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/6] selftests: net: move gro to lib for HW vs SW reuse
    https://git.kernel.org/netdev/net-next/c/8888bf4fb980
  - [net-next,v4,2/6] selftests: drv-net: give HW stats sync time extra 25% of margin
    https://git.kernel.org/netdev/net-next/c/9b29afa11660
  - [net-next,v4,3/6] selftests: drv-net: gro: use SO_TXTIME to schedule packets together
    https://git.kernel.org/netdev/net-next/c/f26d43acf12f
  - [net-next,v4,4/6] selftests: drv-net: gro: test GRO stats
    https://git.kernel.org/netdev/net-next/c/ba5d4128fca8
  - [net-next,v4,5/6] selftests: drv-net: gro: add test for packet ordering
    https://git.kernel.org/netdev/net-next/c/ff1cb3ad2abc
  - [net-next,v4,6/6] selftests: drv-net: gro: add a test for GRO depth
    https://git.kernel.org/netdev/net-next/c/7dae8ffb0987

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



