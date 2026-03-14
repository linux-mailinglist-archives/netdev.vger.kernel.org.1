Return-Path: <netdev+bounces-267752-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OoVDF+BtWne1AAAu9opvQ
	(envelope-from <netdev+bounces-267752-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 16:40:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B6228DB98
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 16:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 351AC3012520
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 15:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E292EBB8A;
	Sat, 14 Mar 2026 15:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+hmlKdi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEBD299A87;
	Sat, 14 Mar 2026 15:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773502811; cv=none; b=VAm0718whB/RjZ7QHbeeZdGCB6yYKo1LVm2doLtFslhjrriVTX4lXVVuf3YbzH9ZLhtHPnCeK7icH3YatmuhTft+rLzgOD/89LtxfwMNO27KlulZJ93Thb4nBWp8ebyGT6Ai46rm72mcrgzyGRl614ZXahhqwLi1iYRsI4DujmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773502811; c=relaxed/simple;
	bh=VaEr4zgt11yO0+g30xjvAho2IbqcTqvirp+IouJ0pA0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UEFIXZ06qvatg18Q4D2BXP7k6aH5NRZZ4XOVrvX+PoXZQvA8sAlU+4eEknO0daZ/jk8lDXtkZIWtw/EjpDb091wcruQypsUZz9wtwQerNWTmBLwQ2If3bEVhF4mNtQe2pCwhn9S54dnSb/WV0dEQcSISR71DgqPdwvLuf6BdTho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+hmlKdi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2389C116C6;
	Sat, 14 Mar 2026 15:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773502810;
	bh=VaEr4zgt11yO0+g30xjvAho2IbqcTqvirp+IouJ0pA0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u+hmlKdiggDDVsC7hYMUF1uO50fqj35m1F6+QzioGkU4DfJ7INcGuDxWzigLlFGQM
	 LbAR/4mrn6QlMtvGhePo4EI/PnOmh2sDqAQ89Vh1/N4MXlnRzitcrWxjfTyEG2iIfj
	 kT5QoR1P58swhfbi6xRA/P8pPQqTSwf0WZ4RnS/znISfqExS2pXQJq/pAazrRPnAEw
	 EFC6fHk4sLwEc9xOpvyfUrR73ML7QSvmiOw5lowVXXovTC32k7ftehK2Y4J3GSWDGd
	 X+HuxX5elgK/b3WrKnHcTAgJMqBueEbrCMIEbD1IYtFwNv+VwGfn5fleIxjV2aZ8yQ
	 Me3dCvrOK6rjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDAD3808200;
	Sat, 14 Mar 2026 15:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] atm: lec: fix use-after-free in sock_def_readable()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177350280480.1717807.14508217013356805323.git-patchwork-notify@kernel.org>
Date: Sat, 14 Mar 2026 15:40:04 +0000
References: <20260309155908.508768-1-kartikey406@gmail.com>
In-Reply-To: <20260309155908.508768-1-kartikey406@gmail.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, mingo@kernel.org, tglx@kernel.org,
 jiayuan.chen@shopee.com, kees@kernel.org, netdev@vger.kernel.org,
 dan.carpenter@linaro.org, linux-kernel@vger.kernel.org,
 syzbot+f50072212ab792c86925@syzkaller.appspotmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-267752-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,f50072212ab792c86925];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C8B6228DB98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Mar 2026 21:29:08 +0530 you wrote:
> A race condition exists between lec_atm_close() setting priv->lecd
> to NULL and concurrent access to priv->lecd in send_to_lecd(),
> lec_handle_bridge(), and lec_atm_send(). When the socket is freed
> via RCU while another thread is still using it, a use-after-free
> occurs in sock_def_readable() when accessing the socket's wait queue.
> 
> The root cause is that lec_atm_close() clears priv->lecd without
> any synchronization, while callers dereference priv->lecd without
> any protection against concurrent teardown.
> 
> [...]

Here is the summary with links:
  - [v2] atm: lec: fix use-after-free in sock_def_readable()
    https://git.kernel.org/netdev/net/c/922814879542

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



