Return-Path: <netdev+bounces-305677-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gNfvL68HTmrMBwIAu9opvQ
	(envelope-from <netdev+bounces-305677-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 10:17:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5265C72310D
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 10:17:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hTQuXiYY;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305677-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305677-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 090E03039897
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 08:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533193D6662;
	Wed,  8 Jul 2026 08:10:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387953E1718;
	Wed,  8 Jul 2026 08:10:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783498227; cv=none; b=hUfjcTx4CLk8XgSzmT7ODJ9iNG+dBak+ymJ6cry69wc5p4Ky2a4VPUgU8C8k583HgOC1BzNLBeRECAbzlsxffapMfHFn6rPHdqRsgG5Tham51nT73TjqcSlVdIFbke8SWC0giXnJEA78RzkScXmTYEUh5lWukbi9qwezOwgiL8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783498227; c=relaxed/simple;
	bh=yCqSS875QpHsbFoa2bk23+nvYovKpFiry8Jjh/B8F7Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z4jxvHR7dH+Q47g5N0Ub+pJATZSiQ23pkB6skyOCi908O2/rWQ4zQqj2eEUo7UUyJ9j1EQScZPXxLBU4C1bDisT+9BLNAu3aSaZvVLMRTxIiBjo7h5MQaEdX05dGxN7k94Cre2tCjp5IDZ2hAnUviiOufotviL9xeYPU9A3KojA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTQuXiYY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65441F000E9;
	Wed,  8 Jul 2026 08:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783498225;
	bh=GgV78O363yhQjW/mjMg5O2ccLPnLEWk0RTgUkDs69oA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hTQuXiYYVkRMp7d1/Pa2YQwcmHonvxgag+V7+chaFddpQzq9hUYEb/dW/y1abE+uL
	 WGe7au04gJKnfuln1bNIqXW40DJCOksR9GULiJDaqu0c0X14thRYC/deWzY5tcjYpT
	 +vBPY46uymIVMNW5haPIGGdaa9nHjMN5u2GgN8KAY2EYrOhs8M7WA/shwv32Ju+nlP
	 ZT+ykpTQj9gtU9FylhaM8sZhIkBf/aA5SpDpnA4J8ny0Xdwm+oENAdAAmyRWpSQIYF
	 D5SDMZ/Xi8VcIYWDBlZ6EVQI8zHVsKtUfcnq8lzh0ATO0b6N1MmHM2hBbuHhL9DFZ9
	 3okoGfSrNwiWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569443926383;
	Wed,  8 Jul 2026 08:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mdio: select REGMAP_MMIO instead of depending on
 it
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178349820489.2361978.9830216385714459265.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jul 2026 08:10:04 +0000
References: <20260702032653.1580616-1-rosenp@gmail.com>
In-Reply-To: <20260702032653.1580616-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dtcccc@linux.alibaba.com,
 linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,linux.alibaba.com];
	TAGGED_FROM(0.00)[bounces-305677-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dtcccc@linux.alibaba.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5265C72310D

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  1 Jul 2026 20:26:52 -0700 you wrote:
> REGMAP_MMIO is a hidden (non-user-visible) tristate symbol. Using
> depends on it is incorrect because there is no way for the user to
> enable it directly. Change to select, which is the convention used
> by every other driver in the tree that needs REGMAP_MMIO.
> 
> Fixes: 8057cbb8335c ("net: mdio: mscc-miim: Add depend of REGMAP_MMIO on MDIO_MSCC_MIIM")
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] net: mdio: select REGMAP_MMIO instead of depending on it
    https://git.kernel.org/netdev/net/c/1a3267a8c9ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



