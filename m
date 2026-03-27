Return-Path: <netdev+bounces-272317-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eN7KJGPexWk9CgUAu9opvQ
	(envelope-from <netdev+bounces-272317-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 02:33:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3797A33DDDF
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 02:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6223F3052F47
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 01:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C37317715;
	Fri, 27 Mar 2026 01:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oh/Bygvn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378643168FB
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 01:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774575171; cv=none; b=eZKu9yHPwVL8Cpvom5NQYqULnXKMHPsEaNqpMCx/D66hcGlQ69cpoMjWwFKvoRo6NalwQUu04EEKO9rg/TKn0SYIz8gQb5dfKIaLtEqPIwNOW15dfDXqvdFCHQoFbK+C6vNMoJ910UeHnH11ijaQcZI3z43h2HnIUolzl1zKlzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774575171; c=relaxed/simple;
	bh=fX9oVCj0uSAfbHNwGzSVaxYoU2+CI6cNZTKdTeVZ4FE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E5sA0q+aCXYn/1KXNoUFaWM/EnIg0tBJZIgAcLvzs1GDuFFc/qnAU4XCrw70ZhFi43ZkED5nMgQZnJmplyCIqOk4gsRXJf+VNXumAhmryvYZXCls1Wj+Yq7lwRfFZ1ES7D7ApJo5cfKLwPmKrRrd4iG5NjicdVuAyrs2qjSTfFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oh/Bygvn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F3DC19423;
	Fri, 27 Mar 2026 01:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774575170;
	bh=fX9oVCj0uSAfbHNwGzSVaxYoU2+CI6cNZTKdTeVZ4FE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oh/BygvnEhRe6mgYUgOccA11GhNrTGIHWa45FUufUxg6dUwvv+DfdBlwDeQViBdQW
	 WNUCwGSvBkLXeqqg4bpnEYaTxsPijxsskXG2wOnEl4epcQw6Dv94gI2D4HawqGuGlQ
	 RRSu56IhmE/7uzuVf005hzZIk0W/5t4XN6Z7NByWPkdAgfdTwzIXROjmnqFRgaS0RC
	 fGJjdd8xXSPYa/DQCNs/w0zPBs7yN1bXN3aimpVhslxAFhSEl+0n85LLXwh1kx0X9e
	 AydXKAG2GXfOQ4IYUdAokJJa4f1CwpaHoRSmFfF3vfj1Y01oCyId2z6/Bgpu62yxvl
	 5IpQH8gHX0iPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE653809A07;
	Fri, 27 Mar 2026 01:32:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phylink: use phylink_expects_phy() in
 phylink_fwnode_phy_connect()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177457515728.3250412.4344454444780966465.git-patchwork-notify@kernel.org>
Date: Fri, 27 Mar 2026 01:32:37 +0000
References: <E1w4zHg-0000000DmC4-2oyb@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1w4zHg-0000000DmC4-2oyb@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272317-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 3797A33DDDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Mar 2026 10:46:52 +0000 you wrote:
> The tests in phylink_expects_phy() and phylink_fwnode_phy_connect() are
> identical (by intention). Use phylink_expects_phy() to decide whether
> to ignore a call to phylink_fwnode_phy_connect().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/phy/phylink.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [net-next] net: phylink: use phylink_expects_phy() in phylink_fwnode_phy_connect()
    https://git.kernel.org/netdev/net-next/c/b83c28328fee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



