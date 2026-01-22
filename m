Return-Path: <netdev+bounces-252162-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oA66NsmacWmdKAAAu9opvQ
	(envelope-from <netdev+bounces-252162-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:34:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F3D615D1
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 75D464E6E43
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 03:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C091F3DA7F2;
	Thu, 22 Jan 2026 03:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NF9+lXhx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6483D3D15
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 03:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769052613; cv=none; b=QP/Ul7VgjsUWJ/3+S6Ke/DwUlS287j4KDBlwUx/K+WGFpd+22fQwykpe/haz7L69jt9yWGyup0/zqXbXywTkUirHPAA6D0g0U3xo/sW0/rZ53zUi0XH2v1Z18iDoLrENMYZdoRuB/yn+m/ECh5pHOT/e19X4I8dfQxav2NqvBV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769052613; c=relaxed/simple;
	bh=SW4kZj8p54A7WYNDtsDaOcytHZBfw55vdzJjXr51XPc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sZMDOoV2bjwRy35EVzun3jmuDsIJY7sXM7KX8WE/+c+csOxHR/rQ2yZaReh2hxirWxi2QPhxm40+ys++bH0LMmNjhacqYlLt+dF0/IBO935qsivKU8qf90y+aqfKoaEz2DApC6kx+durMH6N6ecOSwCHeE9JhoOuoCOkEhQLLIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NF9+lXhx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21404C116C6;
	Thu, 22 Jan 2026 03:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769052613;
	bh=SW4kZj8p54A7WYNDtsDaOcytHZBfw55vdzJjXr51XPc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NF9+lXhx0rPoupyv51KEqkZC2ibiRK9rWjwSk+68bJ1hAyGsxHBlHKILYjiMDSe9U
	 eAruGNNR8hXJzrRk/zWzHvzrf/23tNZlmqqO4yktbGV9yrUayTnj8xgwfI6V7zZi88
	 f6Qd9c5GlOB5N5ygiuVH1NW8I6NRIT0pVp0Hi3dHdViHe7UQ15jBmwm207m32XqD3s
	 FRdg0i5i2aKHme34ORFxS85kcSvliJJE4M6nGPUMbbPgeQJ+qWsXe8UVvChs6bIkkc
	 sHNHAl8xdnvE9bBsKLaXZ3m1s/hCPNTEBpc+W9oI1dhZjnZQdB+lDvb1F+B4uQnbW4
	 8qbN/ou9YP/qg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11D1F3808200;
	Thu, 22 Jan 2026 03:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bonding: provide a net pointer to
 __skb_flow_dissect()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176905260960.1542867.1806985746457384098.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jan 2026 03:30:09 +0000
References: <20260120161744.1893263-1-edumazet@google.com>
In-Reply-To: <20260120161744.1893263-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+c46409299c70a221415e@syzkaller.appspotmail.com, mcroce@redhat.com,
 sdf@fomichev.me
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com,fomichev.me];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252162-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,c46409299c70a221415e];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 85F3D615D1
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Jan 2026 16:17:44 +0000 you wrote:
> After 3cbf4ffba5ee ("net: plumb network namespace into __skb_flow_dissect")
> we have to provide a net pointer to __skb_flow_dissect(),
> either via skb->dev, skb->sk, or a user provided pointer.
> 
> In the following case, syzbot was able to cook a bare skb.
> 
> WARNING: net/core/flow_dissector.c:1131 at __skb_flow_dissect+0xb57/0x68b0 net/core/flow_dissector.c:1131, CPU#1: syz.2.1418/11053
> Call Trace:
>  <TASK>
>   bond_flow_dissect drivers/net/bonding/bond_main.c:4093 [inline]
>   __bond_xmit_hash+0x2d7/0xba0 drivers/net/bonding/bond_main.c:4157
>   bond_xmit_hash_xdp drivers/net/bonding/bond_main.c:4208 [inline]
>   bond_xdp_xmit_3ad_xor_slave_get drivers/net/bonding/bond_main.c:5139 [inline]
>   bond_xdp_get_xmit_slave+0x1fd/0x710 drivers/net/bonding/bond_main.c:5515
>   xdp_master_redirect+0x13f/0x2c0 net/core/filter.c:4388
>   bpf_prog_run_xdp include/net/xdp.h:700 [inline]
>   bpf_test_run+0x6b2/0x7d0 net/bpf/test_run.c:421
>   bpf_prog_test_run_xdp+0x795/0x10e0 net/bpf/test_run.c:1390
>   bpf_prog_test_run+0x2c7/0x340 kernel/bpf/syscall.c:4703
>   __sys_bpf+0x562/0x860 kernel/bpf/syscall.c:6182
>   __do_sys_bpf kernel/bpf/syscall.c:6274 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:6272 [inline]
>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6272
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
> 
> [...]

Here is the summary with links:
  - [net] bonding: provide a net pointer to __skb_flow_dissect()
    https://git.kernel.org/netdev/net/c/5f9b32909659

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



