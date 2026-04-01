Return-Path: <netdev+bounces-273861-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCKBDlGJzGlXTgYAu9opvQ
	(envelope-from <netdev+bounces-273861-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 04:56:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 912453740F8
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 04:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C76F730969AC
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 02:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96ED52D2495;
	Wed,  1 Apr 2026 02:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROf9BTCw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E1932D7F0;
	Wed,  1 Apr 2026 02:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775011822; cv=none; b=IPPzeV5sTEIJFi3fo+3PdHkh8kqSnWM1ySG9zjKp3uB9h16b1KDfEOds8e02aP8LpoSTq7k/7+124dL3OHFxDdvzKuRxijIiixaqzqdNAlyPrPjqLk5psUByPHbr3nE1zXDFdsXv+jtu0dTmRHbUu92r2hmCTl/SOGN1n7WL2c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775011822; c=relaxed/simple;
	bh=1GfZ3GG+Kz4xvMyFmYhFRdKznZF4JhQREtcBgVPA/so=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pguTTtrOVQmAeObMYGQe1GjCjvQezJlH3sBS6RinamFalMr0jGYk3qY0fdrqHj9/XbtyfJNkCHZ73DTUDw+vgcbTqHmFzA+T7+rN95c/LFj/fll90wI3E3ccs4UqPflqZ/zxoSh4JfNnoxckMpRuURNi02JDpqXZ1+X1Um6Hda8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROf9BTCw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BA5C19423;
	Wed,  1 Apr 2026 02:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775011821;
	bh=1GfZ3GG+Kz4xvMyFmYhFRdKznZF4JhQREtcBgVPA/so=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ROf9BTCwb+Ve3iwXZlHBOua2B+weyMxepGGg/FWPqPZ8fc0B6AoNEiMezqthtdxKn
	 3hnIgmBpJUqsvpMIlarNsK2mEgPUAwCAEoucEg2LXr36fkKEkRy6j4cvHEHIE/O0BC
	 vaXmCS/tuDaQHv9R5fVAOhAo0y8Pc+OarNX6H7ciHa9/eXLk6pkX94xXTUVrfd+oWm
	 pDnKFQmFdobLSD8QQenT4xtuI4xSikY3H2IdtWmZf1h8HyWq5Pcqc3o1v9hNoe4TKo
	 8pUHOwGtTSTm/nCeQ8NxHq8oq2KYMouXdv0i1kMq+VwUX83jegI46H+XQYzBnFM24I
	 P9ROQMWgsdsrA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D003808203;
	Wed,  1 Apr 2026 02:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ftgmac100: fix ring allocation unwind on open
 failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177501180479.3045143.14479627194268343314.git-patchwork-notify@kernel.org>
Date: Wed, 01 Apr 2026 02:50:04 +0000
References: <20260328163257.60836-1-yufan.chen@linux.dev>
In-Reply-To: <20260328163257.60836-1-yufan.chen@linux.dev>
To: Yufan Chen <yufan.chen@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273861-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 912453740F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 29 Mar 2026 00:32:57 +0800 you wrote:
> ftgmac100_alloc_rings() allocates rx_skbs, tx_skbs, rxdes, txdes, and
> rx_scratch in stages. On intermediate failures it returned -ENOMEM
> directly, leaking resources allocated earlier in the function.
> 
> Rework the failure path to use staged local unwind labels and free
> allocated resources in reverse order before returning -ENOMEM. This
> matches common netdev allocation cleanup style.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ftgmac100: fix ring allocation unwind on open failure
    https://git.kernel.org/netdev/net/c/c0fd0fe745f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



