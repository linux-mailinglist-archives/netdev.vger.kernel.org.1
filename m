Return-Path: <netdev+bounces-258081-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAMPOJcpi2kbQgAAu9opvQ
	(envelope-from <netdev+bounces-258081-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 13:50:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A45811B038
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 13:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F6F3303B97C
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 12:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4658531ED6D;
	Tue, 10 Feb 2026 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hl7ZFUvG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C1D319871;
	Tue, 10 Feb 2026 12:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770727829; cv=none; b=rx9YJfbsf+O7xRnXaNIbm6dkU5UKe4RvC3FYy4qD2hAqRglQ/YuX7TsFBSekZx8uVf5KLhXolfdw3wY1uvpX+P4maIS0TZxtaI0Of9HpjGxzYF2dlOm9w5Y3gNmkc4GPef9AxRyI0OTyYLYnb4RPGA2WqYqc8icXEDB2OxjVdeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770727829; c=relaxed/simple;
	bh=RKdUFykfg3eijFUGIigQm9NagtVXDcNEQW7sZByjMhA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HdGxMzfbN2WpZ8YIt5L4Vd3+8gE/V25CsnLYFjyGxVikUiaeTStvYABVKXRJws+Qri1+01UdowY5It2MdH2THbikntiTwTgv08WewMcg1h+MVYGU0g81NkZNiUB4INTJyumABxi7vHKui8DVXYv3Ecbg+P2Ae3iT+ACj0glg38w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hl7ZFUvG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5409C116C6;
	Tue, 10 Feb 2026 12:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770727828;
	bh=RKdUFykfg3eijFUGIigQm9NagtVXDcNEQW7sZByjMhA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hl7ZFUvG6S2OgHNjrH778L5obKI2pr28FyAAximlCvqZxbAoodf2XTd73KCI05Wdo
	 hcexidUmAETkVzJRBtgBwiaOMlJ2pUdDtlZoOid9WvCnFl7iosoO9skmyYuGf383/l
	 vj7lpywq3NuF9uT8xmwtr5w7XzidgdLzKhmfQcb5JbQQgUVF/uGthZ6rhbYdODNySn
	 WqQomSEhjJCP2wANdiucXBVrDlkmqG0aOknkgMCGIkIf5EIehY/GMyfl5SD1kFlgGA
	 YMbch9n0KYsyzCiHHQa4VAogQsTvm48jCllsK1N7SPXxKURT/NFhuw65eVeLBIiPSC
	 jvBXTr9XungaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4809639B167B;
	Tue, 10 Feb 2026 12:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 00/15] net: ftgmac100: Various probe cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177072782408.3501567.5350897408494661386.git-patchwork-notify@kernel.org>
Date: Tue, 10 Feb 2026 12:50:24 +0000
References: <20260206-ftgmac-cleanup-v5-0-ad28a9067ea7@aspeedtech.com>
In-Reply-To: <20260206-ftgmac-cleanup-v5-0-ad28a9067ea7@aspeedtech.com>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew@lunn.ch, horms@kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-258081-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A45811B038
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 6 Feb 2026 11:17:40 +0800 you wrote:
> The probe function of the ftgmac100 is rather complex, due to the way
> it has evolved over time, dealing with poor DT descriptions, and new
> variants of the MAC.
> 
> Make use of DT match data to identify the MAC variant, rather than
> looking at the compatible string all the time.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,01/15] net: ftgmac100: List all compatibles
    https://git.kernel.org/netdev/net-next/c/03a2aba50b2c
  - [net-next,v5,02/15] net: ftgmac100: Add match data containing MAC ID
    https://git.kernel.org/netdev/net-next/c/41fbe5aa5086
  - [net-next,v5,03/15] net: ftgmac100: Replace all of_device_is_compatible()
    https://git.kernel.org/netdev/net-next/c/9b42f74808de
  - [net-next,v5,04/15] net: ftgmac100: Use devm_alloc_etherdev()
    https://git.kernel.org/netdev/net-next/c/f4bef838a455
  - [net-next,v5,05/15] net: ftgmac100: Use devm_request_memory_region/devm_ioremap
    https://git.kernel.org/netdev/net-next/c/67127f88c80b
  - [net-next,v5,06/15] net: ftgmac100: Use devm_clk_get_enabled
    https://git.kernel.org/netdev/net-next/c/4659ccedf22b
  - [net-next,v5,07/15] net: ftgmac100: Simplify error handling for ftgmac100_initial_mac
    https://git.kernel.org/netdev/net-next/c/d1d8392883bf
  - [net-next,v5,08/15] net: ftgmac100: Move NCSI probe code into a helper
    https://git.kernel.org/netdev/net-next/c/7535d70ba0e7
  - [net-next,v5,09/15] net: ftgmac100: Always register the MDIO bus when it exists
    https://git.kernel.org/netdev/net-next/c/efeb21441173
  - [net-next,v5,10/15] net: ftgmac100: Simplify legacy MDIO setup
    https://git.kernel.org/netdev/net-next/c/3e523741aae7
  - [net-next,v5,11/15] net: ftgmac100: Move DT probe into a helper
    https://git.kernel.org/netdev/net-next/c/20248a719dc8
  - [net-next,v5,12/15] net: ftgmac100: Remove redundant PHY_POLL
    https://git.kernel.org/netdev/net-next/c/0855b43d8218
  - [net-next,v5,13/15] net: ftgmac100: Simplify condition on HW arbitration
    https://git.kernel.org/netdev/net-next/c/96b4887a718c
  - [net-next,v5,14/15] net: ftgmac100: Fix wrong netif_napi_del in release
    https://git.kernel.org/netdev/net-next/c/201dddf68899
  - [net-next,v5,15/15] net: ftgmac100: Use devm_mdiobus_alloc/devm_of_mdiobus_register
    https://git.kernel.org/netdev/net-next/c/7ac5dddef516

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



