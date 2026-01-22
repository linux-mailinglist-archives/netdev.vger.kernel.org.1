Return-Path: <netdev+bounces-252430-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OG5MHIJQcmnpfAAAu9opvQ
	(envelope-from <netdev+bounces-252430-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:29:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B5769F8F
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6C163001BD6
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D913D7278;
	Thu, 22 Jan 2026 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCBNJ8jU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4543A7338
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 16:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769098222; cv=none; b=KkjLEaVSiO5dqeFzfHBMsyX7prXRwmGFYetyW57MlRZ1VClkYRkqLEwVa36BjrvCmi7OV4arhUw8Cnmu/Pa7Ve5+booN9d/0CUHUET3ToQg9CqTEu+woL8JWZy6/dD1Pk3TlY4qCdls7+0xt4vZybXXOTJnHWABrBbR7YL9nuyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769098222; c=relaxed/simple;
	bh=zWeyOItYb4yXMDh8K/2lZRV7w0gPDrYzo5N+1It+1LE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZPd5t4pYhrRnwLicknTyoqRBtJIEeu4ezqFpBN5z90K/lr3e3ylQI4jzn5s+NRwYiBWpJ6GUObMHyamk2IuelmEhVgvOSgVilPka8LrHfpd+S5btpSPk3ItO0AAKYPVYnT26lhKdc95xUw3SiGyL9vQZb6eOVW1Bbp7bxsTy7i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCBNJ8jU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D16C116D0;
	Thu, 22 Jan 2026 16:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769098221;
	bh=zWeyOItYb4yXMDh8K/2lZRV7w0gPDrYzo5N+1It+1LE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RCBNJ8jUuUVcXouQ1ZaZ+7RQdDM2Z6WyT0+rgy6Cp+sMT1JR5AzEfYJpL9fO2hrz+
	 XSsVccH2M1+888XoZOSFaIFleDMveNcrWauywcOjEHYV/PPPVHazwLIyjyOGHEdjJe
	 wTK7VdRAd0cM8k1DFE3YsREeFyhi86Hj/mY7VKOskbxavrcRlY6S3Jrrl4An7XgkTx
	 dyuJFE8cmNf0q+P8hlTvwy1M1VJ00o+RnpmvM0TPsOgdmDEsnPwatOUG1R5/OS83aI
	 Ry0sYjjKDAxR71TfXZotgnaxdzi+2C+Qa47zHmpjaKdQ8p+P5E5lHlrIwrAOFU4ihk
	 EVilLu8vtVkvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BC553808200;
	Thu, 22 Jan 2026 16:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: act_ife: avoid possible NULL deref
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176909821810.1785789.2790553125370808839.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jan 2026 16:10:18 +0000
References: <20260121133724.3400020-1-edumazet@google.com>
In-Reply-To: <20260121133724.3400020-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+5cf914f193dffde3bd3c@syzkaller.appspotmail.com, yotam.gi@gmail.com
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
	TAGGED_FROM(0.00)[bounces-252430-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,mojatatu.com,gmail.com,resnulli.us,vger.kernel.org,syzkaller.appspotmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,5cf914f193dffde3bd3c];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D6B5769F8F
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Jan 2026 13:37:24 +0000 you wrote:
> tcf_ife_encode() must make sure ife_encode() does not return NULL.
> 
> syzbot reported:
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>  RIP: 0010:ife_tlv_meta_encode+0x41/0xa0 net/ife/ife.c:166
> CPU: 3 UID: 0 PID: 8990 Comm: syz.0.696 Not tainted syzkaller #0 PREEMPT(full)
> Call Trace:
>  <TASK>
>   ife_encode_meta_u32+0x153/0x180 net/sched/act_ife.c:101
>   tcf_ife_encode net/sched/act_ife.c:841 [inline]
>   tcf_ife_act+0x1022/0x1de0 net/sched/act_ife.c:877
>   tc_act include/net/tc_wrapper.h:130 [inline]
>   tcf_action_exec+0x1c0/0xa20 net/sched/act_api.c:1152
>   tcf_exts_exec include/net/pkt_cls.h:349 [inline]
>   mall_classify+0x1a0/0x2a0 net/sched/cls_matchall.c:42
>   tc_classify include/net/tc_wrapper.h:197 [inline]
>   __tcf_classify net/sched/cls_api.c:1764 [inline]
>   tcf_classify+0x7f2/0x1380 net/sched/cls_api.c:1860
>   multiq_classify net/sched/sch_multiq.c:39 [inline]
>   multiq_enqueue+0xe0/0x510 net/sched/sch_multiq.c:66
>   dev_qdisc_enqueue+0x45/0x250 net/core/dev.c:4147
>   __dev_xmit_skb net/core/dev.c:4262 [inline]
>   __dev_queue_xmit+0x2998/0x46c0 net/core/dev.c:4798
> 
> [...]

Here is the summary with links:
  - [net] net/sched: act_ife: avoid possible NULL deref
    https://git.kernel.org/netdev/net/c/27880b0b0d35

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



