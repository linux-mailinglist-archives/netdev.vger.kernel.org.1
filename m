Return-Path: <netdev+bounces-254999-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBcWGD8ffGmgKgIAu9opvQ
	(envelope-from <netdev+bounces-254999-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 04:02:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D58BBB6ACB
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 04:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE5243015737
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2226F25CC79;
	Fri, 30 Jan 2026 03:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="re7eSOPN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C901925BC;
	Fri, 30 Jan 2026 03:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769742020; cv=none; b=IbalI4zuMR+RCzkwVYmmnk7ihP7A/LV0nGP/ePgvjYdnY2JnGMUrUuJx48AQZgJTGOYdEBxCi25nLTZj2EzBxgCmUFGjrkoFoYtFrOYHf0cgsbAwfKm/YP2EfLu1dNovCrQ246DMQwoW9N9T2HcMEvcYANerjWL80/TWIjgWB2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769742020; c=relaxed/simple;
	bh=C/Qfffi+yEKyGzGWexQyUKHMQe9GwN+0uy4RGX15FP4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LQJa/cAS5zvutCxipE1DADlRqihvFp6wTAZucK01kfWoE88OdMFESrX2papD0R9zNUGsiTUJthZELuVBtppCnvdedaSyckcmTbYC1/pcPmA7AORwJtDojeXq4jgRpI+GjkrdX3uC7xzD79vseYV6vu/gzNwtKXsCM3GB8Ep2uEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=re7eSOPN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2911C4CEF7;
	Fri, 30 Jan 2026 03:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769742019;
	bh=C/Qfffi+yEKyGzGWexQyUKHMQe9GwN+0uy4RGX15FP4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=re7eSOPNGUpobpqR8RZQ9DJPyA3qc2I/B0B5KvOsKjLi2bMBm9EftqdP3aNREmA6A
	 P3/i36bb+gXRU4a9j88CpImCDBa0EH69PcOjIm6uxrbybHsZ+WZUFRsG8p25j2+h2b
	 JxsGlttpeUYWQSWx9roXaqGDOXO4TjcJMkkWeuIZPms2Q69PnN8NQ8QOmj8apWnoVk
	 1cboetP6TvaATjph45WbIGUhaEuLOsd2LzMkuInsSbVOn16mDYVSnswy8Z9Sa0Gevs
	 Ws3vJ8rte1wUjTlNutRkzUlkCBSS4JT44JSXbM5i1kjKxNpJb/YCZVOgJnY9F2+J51
	 66UtL/9BJYt4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B8F60380CEE0;
	Fri, 30 Jan 2026 03:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v03 0/4] net: hinic3: Fix code styles
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176974201260.3152167.11856090096391309419.git-patchwork-notify@kernel.org>
Date: Fri, 30 Jan 2026 03:00:12 +0000
References: <cover.1769656467.git.zhuyikai1@h-partners.com>
In-Reply-To: <cover.1769656467.git.zhuyikai1@h-partners.com>
To: Fan Gong <gongfan1@huawei.com>
Cc: zhuyikai1@h-partners.com, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, luosifu@huawei.com, guoxin09@huawei.com,
 zhoushuai28@huawei.com, wulike1@huawei.com, shijing34@huawei.com,
 luoyang82@h-partners.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254999-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D58BBB6ACB
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 29 Jan 2026 12:01:07 +0800 you wrote:
> This patchset provides 4 code styles fixes:
> 
> Remove empty lines between error handling.
> Remove defensive txq_num check.
> Use array_size instead of multiplying.
> SQ use SQ_CTXT_PREF_CI_HI to improve readability.
> 
> [...]

Here is the summary with links:
  - [net-next,v03,1/4] hinic3: Fix code Style(remove empty lines between error handling)
    https://git.kernel.org/netdev/net-next/c/738ff2d2f502
  - [net-next,v03,2/4] hinic3: Remove defensive txq_num check
    https://git.kernel.org/netdev/net-next/c/34bef6a4960f
  - [net-next,v03,3/4] hinic3: Use array_size instead of multiplying
    https://git.kernel.org/netdev/net-next/c/afb81efc971e
  - [net-next,v03,4/4] hinic3: RQ use RQ_CTXT_PREF_CI_HI instead of SQ_CTXT_PREF_CI_HI
    https://git.kernel.org/netdev/net-next/c/2da903d0a84a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



