Return-Path: <netdev+bounces-262250-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKzrEntro2mACgUAu9opvQ
	(envelope-from <netdev+bounces-262250-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:26:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A561E1C97EB
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64A19304F225
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AD9368940;
	Sat, 28 Feb 2026 22:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDXJbExg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF3930214B;
	Sat, 28 Feb 2026 22:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772317473; cv=none; b=eJUwV/f1USx34tSTxI8J7a5GPJt1jvYMaOYJcScfLUt15xjR1obnun+MwgqJeRuuCYp/c81SpdOP6fnMD/cYuZvWIGTj20A3/l0WlYoWz3/1zMp+oUTkruDB9bLxMVfr/C4h/it5kD1iGkr6zJMsxmNeoXZd5Zi4ohRlzFn6noI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772317473; c=relaxed/simple;
	bh=llnjNSfGxRyFGCgLYaB7FnkVfp7KlpDX31mcCMQUUHU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KsMl/ohJLiI0p1JFBANkQsFV6yfETx8JdnWWKW6tpY7sZ1vgMusmjKUJ/xFx9VgjKbWnN2JtwBYY/T8oUR+n4T8sP439fNACwzgX8xeEgwrdxFH0F+jUNkOpt7Th4npdjeg/+6PtpuRpZ0UzjY4auIZvebVesLRFl71oF7crBNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDXJbExg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED3DC116D0;
	Sat, 28 Feb 2026 22:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772317473;
	bh=llnjNSfGxRyFGCgLYaB7FnkVfp7KlpDX31mcCMQUUHU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EDXJbExgKRsodDyd0oYabMAPqPcWDV+K6clMtXqS2fQ/AcUtxbCt8Z2OvFz+5r3pR
	 P2aT0Sn+qF/6aqkaR6PAxOOYtS7dILJYtx5tEFrxRkCXoxTYuSBxCeIeHLFZUtfkYk
	 0LeKX/UR4jlsywenrB6dtZcZRo+8V9hLoa+vRNFk03e0V18W2efL+bItcTbeMM7y2N
	 HFhoF2C+ck80YGauRN1Foxj7th/vmuo4O75xtuFO9q4bu76jsAzv9pEWSzxq78hZVc
	 TwfRnvDZAS8TPeeaMQdlyz4JR0OE3rwwdmZtv4swWG7nMi08zDq8c8Ub3oeXufEHv8
	 gFy7xwH3M7IlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF6139F2024;
	Sat, 28 Feb 2026 22:24:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ti: icssg-prueth: Fix ping failure after offload
 mode setup when link speed is not 1G
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177231747630.3111473.16483515662325090090.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 22:24:36 +0000
References: <20260226102356.2141871-1-danishanwar@ti.com>
In-Reply-To: <20260226102356.2141871-1-danishanwar@ti.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, m-malladi@ti.com,
 jacob.e.keller@intel.com, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, srk@ti.com,
 vigneshr@ti.com, rogerq@kernel.org
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
	TAGGED_FROM(0.00)[bounces-262250-lists,netdev=lfdr.de,netdevbpf];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A561E1C97EB
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Feb 2026 15:53:56 +0530 you wrote:
> When both eth interfaces with links up are added to a bridge or hsr
> interface, ping fails if the link speed is not 1Gbps (e.g., 100Mbps).
> 
> The issue is seen because when switching to offload (bridge/hsr) mode,
> prueth_emac_restart() restarts the firmware and clears DRAM with
> memset_io(), setting all memory to 0. This includes PORT_LINK_SPEED_OFFSET
> which firmware reads for link speed. The value 0 corresponds to
> FW_LINK_SPEED_1G (0x00), so for 1Gbps links the default value is correct
> and ping works. For 100Mbps links, the firmware needs FW_LINK_SPEED_100M
> (0x01) but gets 0 instead, causing ping to fail. The function
> emac_adjust_link() is called to reconfigure, but it detects no state change
> (emac->link is still 1, speed/duplex match PHY) so new_state remains false
> and icssg_config_set_speed() is never called to correct the firmware speed
> value.
> 
> [...]

Here is the summary with links:
  - [net] net: ti: icssg-prueth: Fix ping failure after offload mode setup when link speed is not 1G
    https://git.kernel.org/netdev/net/c/147792c395db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



