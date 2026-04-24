Return-Path: <netdev+bounces-281038-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wlZNIOC962ngQwAAu9opvQ
	(envelope-from <netdev+bounces-281038-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 21:00:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D34C3462A05
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 21:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2066E30071DB
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 19:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36BB238C3B;
	Fri, 24 Apr 2026 19:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2pGAO03"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80064175A70;
	Fri, 24 Apr 2026 19:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777057245; cv=none; b=QDUobgq6T4r1Ni78IRmJ2O8aMcPP1a417WU+QVn6UmOXUh+L96kll03ZWJIBmiABqDriI9BpVNvBqRlpWqUTyU+EKt3cX7tQR1b2nGt0RGHIWdMyie6yVJMTgEgSuMQ9agnTLKnesjbFtRw9D80tkd6ILL/zI3CgA9LSd8zxm90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777057245; c=relaxed/simple;
	bh=e5THWgQ2qvTqUS6mnHcKfxncvFqBGVEvpaQh+echsvk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M0D8hD5/5t5hc5QPSdQNZpIoPYQ4SGuaQvpwIvFNCtNmpi/OHS/nH4F9DLzT81KxHpEsK7FRqu2LRpu0jNHu731DTitU+rs6tWyLx90CGVf19PuWLXFrEV7lo11lwd+G/q2MePmGNlMosD2eDNQRB/IHoiete8cntzqk0E5CtYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2pGAO03; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CE1C2BCB0;
	Fri, 24 Apr 2026 19:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777057245;
	bh=e5THWgQ2qvTqUS6mnHcKfxncvFqBGVEvpaQh+echsvk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N2pGAO03dVgDIw7lNCjzRk+WTf0KbtYfyzgR0tSvtYm/lJUyPDnViTZNEkRpAIoJT
	 daSbdIO/hjtkDERLHNdptLbAJ8oA2mqsCwQx3KtMtuukjW40lRaK+pvfExH5LuE0Ti
	 49i7iSSPDtaKQro/uj2Wq3CtCQJeClojHllA3g+HZQ/yvt13jDtcaEQ/ISiSyn9Ow3
	 LV3wZ1oGI9eB8JV46jRsR2VacRQjeAtVebaNGCSdD62KMPmhfxD75uy+8YX57eyGeF
	 iKI65CoZg7S4RUotbLCn2aCVYvdd60OusNPf5wDhb56QXrMzrkR42Y8eUsAr9xE+mr
	 SqQzW9LIIClRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EB638119C3;
	Fri, 24 Apr 2026 19:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v1 1/1] bpf: Fix sk_local_storage diag dumping
 uninitialized special fields
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177705720556.1666834.14763637651249845423.git-patchwork-notify@kernel.org>
Date: Fri, 24 Apr 2026 19:00:05 +0000
References: <20260423222356.155387-1-ameryhung@gmail.com>
In-Reply-To: <20260423222356.155387-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com,
 andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@kernel.org, kernel-team@meta.com
X-Rspamd-Queue-Id: D34C3462A05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-281038-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

Hello:

This patch was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu, 23 Apr 2026 15:23:55 -0700 you wrote:
> Call check_and_init_map_value() after the copy_map_value() to zero out
> special field regions. diag_get() copies sk_local_storage map values
> into a netlink message using copy_map_value{_locked}(), which
> intentionally skip special fields. However, the destination buffer from
> nla_reserve_64bit() is not zeroed and the skipped regions contain
> uninitialized skb data can be sent to userspace.
> 
> [...]

Here is the summary with links:
  - [bpf,v1,1/1] bpf: Fix sk_local_storage diag dumping uninitialized special fields
    https://git.kernel.org/bpf/bpf/c/b5c111f4967b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



