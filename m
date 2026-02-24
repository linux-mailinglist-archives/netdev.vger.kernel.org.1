Return-Path: <netdev+bounces-260551-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMu6HaaznWkKRQQAu9opvQ
	(envelope-from <netdev+bounces-260551-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 15:20:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4B31884CA
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 15:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F38E30AE0B5
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838943A0B10;
	Tue, 24 Feb 2026 14:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWeCEdjw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602703A0B07;
	Tue, 24 Feb 2026 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771942800; cv=none; b=fIA3QiHMVCNhEsB46LpAmO87PGEr4P3qxF9K2UBzyn3bpIqzayeYDDpa20jnsaiHpUBdLk390PAoQE4ribytrUbYUUYWtx/BgNwGN9jC3M+e2hw5GZXmQsloxtle57xhSzRXQiV9uKFHRuelS1a2n7ttALSuoMx1Uzgkyl70XbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771942800; c=relaxed/simple;
	bh=XZtNo4Q9LYp0y3SJlFFRrpBuNdLrAJVTIpwEGm8yIPY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rFb8+4QxPnLmJd0kQGOZKvULkJvo6ntmdGkjKONAVILwY2T4QlyrJX2BZLomwFDAjhB+0eKrQ9tcJyUatXWId1DNcVljyE8vLvXqRbO5PPRPptpWrEk5U7deCgXQhGr7SmlYRnIPah02KC8b9Yl0/lTCcJm2RmEXS337gpiXIkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWeCEdjw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A4FC116D0;
	Tue, 24 Feb 2026 14:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771942799;
	bh=XZtNo4Q9LYp0y3SJlFFRrpBuNdLrAJVTIpwEGm8yIPY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iWeCEdjwQjN/SyUhGsYIVuAdPgxD5y7TsK04i5Y4i7c6OnRzd7QJDLjnnLYI4rQP9
	 /HPSWUf+oJ+BrjVycFQfMbmqD4pVMTHXM/8BQJ8itghtwG+sTidIpHvS9q8WnSbL82
	 v7p+7prsuigBa6/xgIFBQn65AJBqNayFQKShnzroi9+USezjOy2ibGOQXke3piUSKf
	 EWQA2+TRaa4G79mhJitg/8Z8p+vI0u2+IAGgEUlhW8imYcDb8lVfVT8ZzUMnf6QeC5
	 2Sgw7htcG1GDB1P8qEMjTVabqyfPSbG51P1w2PoBgdajJnxHEcrUgC5Myu56I/dyYx
	 d61c+NUHY/9vw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EFB3808200;
	Tue, 24 Feb 2026 14:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: microchip: lan743x: add ethtool nway_reset
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177194280555.3589996.14149423047817447038.git-patchwork-notify@kernel.org>
Date: Tue, 24 Feb 2026 14:20:05 +0000
References: <20260223085442.42852-1-nb@tipi-net.de>
In-Reply-To: <20260223085442.42852-1-nb@tipi-net.de>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, rmk+kernel@armlinux.org.uk,
 bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 linux-kernel@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-260551-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tipi-net.de:email]
X-Rspamd-Queue-Id: EB4B31884CA
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 23 Feb 2026 09:54:42 +0100 you wrote:
> Wire phylink_ethtool_nway_reset() as the .nway_reset ethtool operation,
> allowing userspace to restart PHY autonegotiation via 'ethtool -r'.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> Reviewed-by: Russel King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/microchip/lan743x_ethtool.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Here is the summary with links:
  - [net-next] net: microchip: lan743x: add ethtool nway_reset support
    https://git.kernel.org/netdev/net-next/c/8636385b9f01

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



