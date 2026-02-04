Return-Path: <netdev+bounces-256535-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJVYAy+7gmnLZQMAu9opvQ
	(envelope-from <netdev+bounces-256535-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 04:21:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FA1E1388
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 04:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B299630DCC16
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 03:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C257728853A;
	Wed,  4 Feb 2026 03:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1wYf+14"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA02272E6A
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 03:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770175230; cv=none; b=eAI72K2gHWU2tCv8rQxj50h589JKYQ3puhkNXjfYcTTaaMD/sKMP5pEP2rd6Sc40AZF0KqAtRqowFO+KQA+QveIpL4AdV0oZgYs1RZh1t3w72NtyV0PmtY8CnHLnmQ7GMfhSYH8t4bO/sqRXno2s30rmO9+CtCYPgI49zHcpUOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770175230; c=relaxed/simple;
	bh=gHmM2ZjEnro/lzlK6i3SYqm0I447P+5N5u36K6NBE74=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JgZXz94xv4jjfryZg76qqw1IZyjI3qzy3uHk7PSJ0lNkKJouCwP/wJLDSCnreCXvtc0aF1dMBlX3t981xibUsjVyifSbDXjXEeF82sy+HmYdHjmQaEM23wHUIg/piHFzWOSZxKpw7MBof6QPfM5ubwCeT2DuAsLPW4GlzoTRJC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1wYf+14; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B528C116D0;
	Wed,  4 Feb 2026 03:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770175230;
	bh=gHmM2ZjEnro/lzlK6i3SYqm0I447P+5N5u36K6NBE74=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f1wYf+14b9gipvn5gApCoaFoofSrRCcAIpPqhc4t8SWqgaGlq3poYYuJC44mEUltH
	 XH2Dp4Ix+weI4Rsih59lSfkfZ3lguVBhUYNraPz5l8Xk418NhHWudJSgNOVyr+jT1p
	 esxkHWU9Iew4U7gib8v+puHX9RFNCI6IsznnOZlwpc4EIkDlYzHy8E0Frcz+yqiJl0
	 mCo0v+qif36W7m3z/1/k+vfR/twXPpWBN2DIKBXdEbQhfRCLDwtRTxBKzqQKa7QWje
	 4ywzjUrOpyMsqf+G8ASrrCbjw1ZQTrQMgI0yPbuRzsTJtvu4XqllZwlMtt/DlcBzvu
	 qW+xQvLRLPamQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 910193808200;
	Wed,  4 Feb 2026 03:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/10] net: stmmac: rk: cleanups v3: mode and
 speed for most
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177017522608.2163463.14435686221837710351.git-patchwork-notify@kernel.org>
Date: Wed, 04 Feb 2026 03:20:26 +0000
References: <aYB2cKRu3DQh6yXK@shell.armlinux.org.uk>
In-Reply-To: <aYB2cKRu3DQh6yXK@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, heiko@sntech.de, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 pabeni@redhat.com
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
	TAGGED_FROM(0.00)[bounces-256535-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 64FA1E1388
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 2 Feb 2026 10:03:28 +0000 you wrote:
> Hi,
> 
> Third installment in the rk cleanups, this converts the interface mode
> and speed configuration for most RK SoCs.
> 
> --
> v2: disable clocks on regmap_write() failure
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/10] net: stmmac: rk: convert to mask-based interface mode configuration
    https://git.kernel.org/netdev/net-next/c/31d28d062aa8
  - [net-next,v2,02/10] net: stmmac: rk: convert rk3588 to mask-based interface mode config
    https://git.kernel.org/netdev/net-next/c/600fe01e947a
  - [net-next,v2,03/10] net: stmmac: rk: move speed GRF register offset to private data
    https://git.kernel.org/netdev/net-next/c/82d1df4b4143
  - [net-next,v2,04/10] net: stmmac: rk: convert rk3588 to rk_set_reg_speed()
    https://git.kernel.org/netdev/net-next/c/8e4b4004e847
  - [net-next,v2,05/10] net: stmmac: rk: remove rk3528 RMII clock initialisation
    https://git.kernel.org/netdev/net-next/c/0c8107dbe720
  - [net-next,v2,06/10] net: stmmac: rk: use rk_encode_wm16() for RGMII clocks
    https://git.kernel.org/netdev/net-next/c/b9544c128c30
  - [net-next,v2,07/10] net: stmmac: rk: use rk_encode_wm16() for RMII speed
    https://git.kernel.org/netdev/net-next/c/4dc66f93b419
  - [net-next,v2,08/10] net: stmmac: rk: use rk_encode_wm16() for RMII clock
    https://git.kernel.org/netdev/net-next/c/33c5c9473a23
  - [net-next,v2,09/10] net: stmmac: rk: remove need for ->set_speed() method
    https://git.kernel.org/netdev/net-next/c/3cf4dfa7b040
  - [net-next,v2,10/10] net: stmmac: rk: convert px30
    https://git.kernel.org/netdev/net-next/c/5031e35f3499

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



