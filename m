Return-Path: <netdev+bounces-265967-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPLOEM7rr2nkdAIAu9opvQ
	(envelope-from <netdev+bounces-265967-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:00:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF9D248FCD
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4E7B3042243
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E94643E9CE;
	Tue, 10 Mar 2026 10:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIsDJj8V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0618364050;
	Tue, 10 Mar 2026 10:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773136812; cv=none; b=HyMr9uofdUa1rMJ7GzkSaLQjRBwomz/MQF0lE5Z6Vw5KVP9ONOq03XNS+VepR5DsVtCqsJhJJVaa7tVu4OtIg+zkAbilwTT/pmp4WPELQPuaEl3QPIYkpHDoI52/+Em84xYIRxuoNgQAevzm2zW0mOoB+TK7SU2c7x8mc5ARp/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773136812; c=relaxed/simple;
	bh=qeOmsAAuFmoQcKx/nAU9xA9YKRufsp+wW0hvZJeoFvg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aM+U8iN7zHqYsS1FA7N9lynUIq1xuUsEotQ3wOyuxEsQqxn0KOuB+tbRJfcqYZfJwojPEuTGkNDqpunoiOSpJjrj9zM5A5gdx1kXo8lcJxbx6zeg0Pelo5BkRI4X8yjrbjer9/RIXvTp0VK/bzM9o4KOFcHTmguh06q0+49jFfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIsDJj8V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D240C19423;
	Tue, 10 Mar 2026 10:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773136811;
	bh=qeOmsAAuFmoQcKx/nAU9xA9YKRufsp+wW0hvZJeoFvg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jIsDJj8VeVtDg4M0YHOE+qCSDqhyvHUA2lVXdjGuDFa5zh+cQxZn+VO5Sjpf0m/C3
	 iGCbxI+NlRebqXtrq2M412ix8ebnmJOYhJ7JcuhjCN+NP+LhfPbg+ClvCXoNTZVF0H
	 YDw5XvPEns6/ZWIfZBxQmJeQ0Im/JHYylHP5YW+ZyJu7KeWvX0cMv9Uh96Ktgb+JiG
	 AV/Eydoknoq4aSvAL/vMbsIZ8avdNvPmw8Vy1bkF9D0XVX7JrmDz6evGKEOcFZD4AG
	 RTEljmqYrNdhTMBezimRpsJOmKM7QZyDFD3aymCbr7NqhGgZ0tRzRXiOAb3KHI/Di0
	 hAI0ZjW40d9AA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E853808200;
	Tue, 10 Mar 2026 10:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] net: enetc: fix fallback PHY address handling and
 do
 not skip setting for addr 0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177313680829.2167779.1393804264443460774.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 10:00:08 +0000
References: <20260305031211.904812-1-wei.fang@nxp.com>
In-Reply-To: <20260305031211.904812-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, alexander.stein@ew.tq-group.com,
 aziz.sellami@nxp.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev
X-Rspamd-Queue-Id: DBF9D248FCD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265967-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  5 Mar 2026 11:12:09 +0800 you wrote:
> There are two potential issues when PHY address 0 is used on the board,
> see the commit messages of the patches for more details.
> 
> ---
> v2:
> 1. No functional changes, only split the v1 patch into two patches.
> 2. Collect tags.
> v1 link: https://lore.kernel.org/imx/20260303103047.228005-1-wei.fang@nxp.com/
> 
> [...]

Here is the summary with links:
  - [v2,1/2] net: enetc: fix incorrect fallback PHY address handling
    https://git.kernel.org/netdev/net/c/246953f33e8c
  - [v2,2/2] net: enetc: do not skip setting LaBCR[MDIO_PHYAD_PRTAD] for addr 0
    https://git.kernel.org/netdev/net/c/dbe17e7783cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



