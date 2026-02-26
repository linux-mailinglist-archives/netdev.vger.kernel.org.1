Return-Path: <netdev+bounces-261313-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKc6Dt80oGkqgwQAu9opvQ
	(envelope-from <netdev+bounces-261313-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:56:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE47F1A56BB
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C214030B3D77
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 11:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA86376BE5;
	Thu, 26 Feb 2026 11:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Az8cIXCm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1B837648E;
	Thu, 26 Feb 2026 11:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772106602; cv=none; b=i9cg0C0FvJ0JjmeXP0zgIv9wTSkDoOCHPrNGhmanjjbA7XrUmpj2mEe/ajkrZ648OE4lAUPvrtlAYY0ReP1Wir55qkMkqqfPnVU8fm42Mm8uWamIJT4UOgNBRJAXPXItqsxNXF4eDlxFYFMFUqbhSXbYEH3AoHCqrD+a9mKAaIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772106602; c=relaxed/simple;
	bh=lT4Xub/QrLsn4es2pEv30xlp4wCT1eDztvI3YQRUbNw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GYLTn8Hvx2qpn343l3TL7OIrUieIHwT6iwO0anTHezOJyqJmeO2FFG2cJFZtDHna2i+214/n+c5LBYTWH+VsTsDr55Xg1dHm4HW2uczTQQgIyCJIqt5EBSbjXQlHAUoxVtYmj9oWoFTLYCznZ07vS1ql53uF3522AkLbEbO2uDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Az8cIXCm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08991C116C6;
	Thu, 26 Feb 2026 11:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772106602;
	bh=lT4Xub/QrLsn4es2pEv30xlp4wCT1eDztvI3YQRUbNw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Az8cIXCmqiBAD42RG7toQh74OUA9LBn21mcE5XSjDXddzo4QXsyi+rln3omy3CfQR
	 Yyws1sUXKOjhlH8t5mA4PdgkB69R2ORRKurPBHxW7rtAjjbyLlDHRejieax3cOLO0/
	 hwZXe7KRWEQTxF33ekCBOenIkZqbCqBQOGsvEIUoohvGUbecoIGiqY7GROJJjCYMBa
	 b61KgWVlp7mE7nIyDO2f9D6IIqdUlp9r+AtM+iWRRfYlPbQJ1gQ+YTreUND4PvVu1i
	 yk+I2vPN1I9AP7WiAKmmHldOuMNHf/bKQge2wjBUE2fHpERSLa4eeZ0R1vToy1lA+H
	 ivB3rMEgIY5KA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9FA93930906;
	Thu, 26 Feb 2026 11:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] dpaa2-switch: validate num_ifs to prevent
 out-of-bounds write
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177210660655.1180063.5937643745258110065.git-patchwork-notify@kernel.org>
Date: Thu, 26 Feb 2026 11:50:06 +0000
References: 
 <SYBPR01MB78812B47B7F0470B617C408AAF74A@SYBPR01MB7881.ausprd01.prod.outlook.com>
In-Reply-To: 
 <SYBPR01MB78812B47B7F0470B617C408AAF74A@SYBPR01MB7881.ausprd01.prod.outlook.com>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: ioana.ciornei@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 vladimir.oltean@nxp.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-261313-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
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
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE47F1A56BB
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 24 Feb 2026 19:05:56 +0800 you wrote:
> The driver obtains sw_attr.num_ifs from firmware via dpsw_get_attributes()
> but never validates it against DPSW_MAX_IF (64). This value controls
> iteration in dpaa2_switch_fdb_get_flood_cfg(), which writes port indices
> into the fixed-size cfg->if_id[DPSW_MAX_IF] array. When firmware reports
> num_ifs >= 64, the loop can write past the array bounds.
> 
> Add a bound check for num_ifs in dpaa2_switch_init().
> 
> [...]

Here is the summary with links:
  - [net,v2] dpaa2-switch: validate num_ifs to prevent out-of-bounds write
    https://git.kernel.org/netdev/net/c/8a5752c6dcc0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



