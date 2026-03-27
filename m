Return-Path: <netdev+bounces-272347-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NzeHqn3xWkjEwUAu9opvQ
	(envelope-from <netdev+bounces-272347-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 04:21:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0048F33EBEE
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 04:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF80F306CF53
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 03:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E3135C1B6;
	Fri, 27 Mar 2026 03:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ou2vWs01"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E05A2DC344;
	Fri, 27 Mar 2026 03:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774581620; cv=none; b=Bk2yMeYYv2jr/L3eFTnhs/Od8XM+9GxZfZkMkbj9O7XkyyYpuX3rz7GjE8a92APS9BkwUSk3xdPXQNk4YSCZBdbRlEdj3ArMPjRN07ZtuBaGctZvHj/8OP4duehp/2NwTlbIIzU/OIUOwHlt2tPvXUNdAy0i5BJSXes6LZB972U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774581620; c=relaxed/simple;
	bh=vk+zRmQ+v4KaJieMrzy5TUowtEPMCkm9f5/l7bJGDWo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VsyXF8X2nsajd/qUC/p9JHSnq+eReEqghR26E+hmxnsm1OkOQG60XHVuegnFcxe5Id2QbAiSkhkODD2IvBKA7G9Z5HkHrsg9/tLIj+zWAihHIlDwBTC83sHo+KB78ZxQ1A/CD42XLhE1YvIe4DL6ZbR1SKSnHphekR/P4yVdgB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ou2vWs01; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6864C2BCB0;
	Fri, 27 Mar 2026 03:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774581619;
	bh=vk+zRmQ+v4KaJieMrzy5TUowtEPMCkm9f5/l7bJGDWo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ou2vWs01AHnVsUcO0ZvN+4ldvfzkaykEAAIKXBjdEOELEtpWQu94IzI7JoM9PGRIP
	 eyURzRpISEwJdwEbNTA+ulpqU0Zx2s3prSROIIXRNrcQdvXa2S9UJg+LYindvFZhH4
	 rmBokYeOSFRmPVyh/o1+kcP3pSKVMYtBNo9QJKqpT+pRFKUsX5ImqcDzFew66Xm5rs
	 RR/F2aY8ME2Z10pGmf+nEIBfF65FZbqnCRGY7eRhU7kEpx5bnGWLUhXJ7FVchN83MQ
	 MmiSG9V4eJBNn0xipzeFibKiLCZ7CuhWtV+rnuq2zgL0IPOc+m7u9mMioXyDthSSff
	 Xnthos5JPR1oA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE1A380692E;
	Fri, 27 Mar 2026 03:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 1/1] net: fec: fix the PTP periodic output sysfs
 interface
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177458160604.3283168.10059556551058678731.git-patchwork-notify@kernel.org>
Date: Fri, 27 Mar 2026 03:20:06 +0000
References: 
 <8ec2afe88423c2231f9cf8044d212ce57846670e.1774359059.git.buday.csaba@prolan.hu>
In-Reply-To: 
 <8ec2afe88423c2231f9cf8044d212ce57846670e.1774359059.git.buday.csaba@prolan.hu>
To: Buday Csaba <buday.csaba@prolan.hu>
Cc: wei.fang@nxp.com, frank.li@nxp.com, shenwei.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 francesco.dolcini@toradex.com, bence98@sch.bme.hu, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272347-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,toradex.com,sch.bme.hu,lists.linux.dev,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0048F33EBEE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Mar 2026 14:32:30 +0100 you wrote:
> When the PPS channel configuration was implemented, the channel
> index for the periodic outputs was configured as the hardware
> channel number.
> 
> The sysfs interface uses a logical channel index, and rejects numbers
> greater than `n_per_out` (see period_store() in ptp_sysfs.c).
> That property was left at 1, since the driver implements channel
> selection, not simultaneous operation of multiple PTP hardware timer
> channels.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/1] net: fec: fix the PTP periodic output sysfs interface
    https://git.kernel.org/netdev/net/c/e8e44c98f789

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



