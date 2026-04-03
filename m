Return-Path: <netdev+bounces-274818-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMy6KgcUz2nXsgYAu9opvQ
	(envelope-from <netdev+bounces-274818-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 03:12:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DE138FE0E
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 03:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91F1D3050419
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 01:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995A727281E;
	Fri,  3 Apr 2026 01:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlmJnLWO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F83271464;
	Fri,  3 Apr 2026 01:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775178649; cv=none; b=PyEri2ShiH30GGMnLL2v8kJ2+N+EWN0Gbf3oyU0e9MJl1MWrPh5n4TR3AXnzvNYno8mSNIVaMUbRuA+6hW1GJGvr6bQmWldO6WNhhZoEeHhwzldOFd5hYaCAGAlN362AF6EkWWiF52n5U+utrG/uEZGrTKx1wr2d5YawEMrgCwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775178649; c=relaxed/simple;
	bh=27loUcoPXeHLhyKDFnOphIo4PvqNw5IHA9skuW/ozxk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hWAlb8eCWyrkUPNGgW8IMmGgCIpchEcx8HbPsUYvTOMpCzv6SIOUoM3ernkLIBzyiiv5jQxyOKWUxciSUiJXY5A5eDYTnVpHoAs/35L4sKKPidEC5QOmKCy+myRUYxP+/oBk/qH5Bj18RLUT3Q3gs5nfmUT+efHVLgKos57ZuLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlmJnLWO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A698C116C6;
	Fri,  3 Apr 2026 01:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775178649;
	bh=27loUcoPXeHLhyKDFnOphIo4PvqNw5IHA9skuW/ozxk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RlmJnLWO0ZR8Do9n7kBhgL75Odm73frEqU+uW0qDcJBndCG+fSLdxD5JDgtXEwSHh
	 rQ9mrSnIyzVUQ4U88NmJFpTD4c3tScb0VXoOHqq4vtUEBSczkxpmkv8VR6OpJbIHv8
	 XoVUFbu97Vlgm0OZ85OcDZ4DjYc1Vh/4FsI1ZzlqVSFlwE/div3vOKbqNK3OxdgE47
	 S4EW7WpFqWLmcKkGOgE4ZIV6OatEDE0SKuXQTRLzvV4VPwM9SdvZmCGFvoX8PVP5+6
	 4HEXO3I+5XQP/ceSDLpITxwcbej9zk3/gIArY/7LPJR9U7Nxz1/MO+fc1tSoCZfpYJ
	 3JkBtSWEs4tmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF553809A09;
	Fri,  3 Apr 2026 01:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/6] enic: SR-IOV V2 preparatory
 infrastructure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177517863103.685228.4446344909237183027.git-patchwork-notify@kernel.org>
Date: Fri, 03 Apr 2026 01:10:31 +0000
References: <20260401-enic-sriov-v2-prep-v4-0-d5834b2ef1b9@cisco.com>
In-Reply-To: <20260401-enic-sriov-v2-prep-v4-0-d5834b2ef1b9@cisco.com>
To: Satish Kharat <satishkh@cisco.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274818-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 22DE138FE0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 01 Apr 2026 08:31:10 -0700 you wrote:
> This is the first of four series adding SR-IOV V2 support to the enic
> driver for Cisco VIC 14xx/15xx adapters.
> 
> The existing V1 SR-IOV implementation has VFs that interact directly
> with the VIC firmware, leaving the PF driver with no visibility or
> control over VF behavior. V2 introduces a PF-mediated model where VFs
> communicate with the PF through a mailbox over a dedicated admin
> channel. This brings enic in line with the standard Linux SR-IOV
> model, enabling full PF management of VFs via ip link (MAC, VLAN,
> link state, spoofchk, trust, and per-VF statistics).
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/6] enic: extend resource discovery for SR-IOV admin channel
    https://git.kernel.org/netdev/net-next/c/74fb32ed733c
  - [net-next,v4,2/6] enic: add V2 SR-IOV VF device ID
    https://git.kernel.org/netdev/net-next/c/803a1b020279
  - [net-next,v4,3/6] enic: detect SR-IOV VF type from PCI capability
    https://git.kernel.org/netdev/net-next/c/56a4d7a86586
  - [net-next,v4,4/6] enic: make enic_dev_enable/disable ref-counted
    https://git.kernel.org/netdev/net-next/c/0266ecb59d52
  - [net-next,v4,5/6] enic: add type-aware alloc for WQ, RQ, CQ and INTR resources
    https://git.kernel.org/netdev/net-next/c/730ce15d4497
  - [net-next,v4,6/6] enic: detect admin channel resources for SR-IOV
    https://git.kernel.org/netdev/net-next/c/4368f5fab419

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



