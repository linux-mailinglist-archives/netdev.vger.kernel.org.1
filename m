Return-Path: <netdev+bounces-287419-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKiAOV/1A2rKBAIAu9opvQ
	(envelope-from <netdev+bounces-287419-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 05:51:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 614B252D037
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 05:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B42A030FB2A4
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 03:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734B63932D5;
	Wed, 13 May 2026 03:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqlAmmW1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F5C3563E8
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 03:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778643994; cv=none; b=hT+2mNRA5PD7JUCS6tnZnWpFM0eDGUM50xPJ2pI6fsIGhjunNx3ZJEMYaEYzagIVmZsYsp93tXc1yDC80ok7Lux2mH8ZDpAwc2y4b6WZI7Ff5O2SmBVEm4TtltqyoFT7qmWonTtt5/rHoVCTbjGi93nnoIU/vugQt+go1/JoA7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778643994; c=relaxed/simple;
	bh=WZtIkqiJsaeL4Kf0gI8siB3RW9i+SNO2hAiv+CwmxL4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ocr5FPyc7KR+CQOhN37BB/GEHEekJZoRBVQN2++Z7JnWS7yAA/QK3EFoZKov9u4YrwMZqb225v96jH8CLajEb74ss1HXlq0zv4eBmTE7sdEuxzVw3WTjlLdfiURqOwwtifXsxHO3u+JVSZhcWLc/VDthRtC3JJnHVvPYAhyjY/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqlAmmW1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091CEC2BCC9;
	Wed, 13 May 2026 03:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778643994;
	bh=WZtIkqiJsaeL4Kf0gI8siB3RW9i+SNO2hAiv+CwmxL4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WqlAmmW1dZp51qlM4bLvOWuCRKESotWx3NY0xe/f+rVNf6DIijBdvMSSCIumG9Oxv
	 dcCxq2TziTBf+xSVEZgS3KQCqX+c3X8ycs957br33zwDkG/UbYrv0i+gDI51Zoh+Sa
	 oOdLRi9I482MzdaA9/MWyJ8aszhILYVFTqdtYIyJbEMGAYIXnncXF9ws6WMzpSAwyM
	 FTpqSt1zYmhzktR00VDgtwAmXFyAbAwCCPnPXLfIB9/3f946ZK+w/FjwDpdcHN9hNA
	 2q3dvmjB2mR6pMHdUhFcQL3zPbTXCZQXSPcuqVNN110yWwiEF5Q2q1Bqry8BIJpxJT
	 s2Dzx2aGL8jlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CAA3822D60;
	Wed, 13 May 2026 03:45:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] rtnetlink: add RTEXT_FILTER_NAME_ONLY support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177864393954.3173643.6785318335975690741.git-patchwork-notify@kernel.org>
Date: Wed, 13 May 2026 03:45:39 +0000
References: <20260511070244.971028-1-edumazet@google.com>
In-Reply-To: <20260511070244.971028-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Rspamd-Queue-Id: 614B252D037
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-287419-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 11 May 2026 07:02:44 +0000 you wrote:
> iproute2 can spend considerable amount of time in ll_init_map()
> or ll_link_get() to dump verbose netdev attributes, contributing
> to RTNL pressure.
> 
> Add RTEXT_FILTER_NAME_ONLY new flag so that rtnl_fill_ifinfo()
> limits its output to:
> 
> [...]

Here is the summary with links:
  - [v2,net-next] rtnetlink: add RTEXT_FILTER_NAME_ONLY support
    https://git.kernel.org/netdev/net-next/c/b588019e85f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



