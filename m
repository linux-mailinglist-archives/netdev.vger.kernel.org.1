Return-Path: <netdev+bounces-256959-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLKHDhokhGnKzgMAu9opvQ
	(envelope-from <netdev+bounces-256959-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 06:01:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BCAEE9D0
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 06:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D90A30214F9
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 05:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40863296BDC;
	Thu,  5 Feb 2026 05:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJgo7JQx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4642874E6
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 05:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770267628; cv=none; b=RQhvcxMF855X349bvQH8HU69TgvZ7yW19ueYd70+V7pVQ34yIhZmcVLOuE4ZaaN1zjYn3iPQ9KMHdSdcLoGYE9C+V+3qRLc6m028gBi2I8LEtUrr0S8COdFu2oRxVBEd0FywgwuAV0c/FrbjeU3bmD4akQab7KB5IgB3lUA6YfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770267628; c=relaxed/simple;
	bh=Ugwf7nuySvJF0pm1EZ6sYChpkqrG6unVjUpZaqu1rqk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RHUAHkrar5WUyLIWHei3pELWTDKww4QwhD644VM73PTxVLTO3QivGeyzGcQfKBFlmnB/syJoP+p/HtIHiq1rjavjST2BOiiJksZxAqRgHUl7AzYwPDAdmvyJCRzrmQtDtth7RsBLH2NKSnOKwfXeH86hy0C/q8dRzeXD4YJSr5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJgo7JQx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE6AC4CEF7;
	Thu,  5 Feb 2026 05:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770267627;
	bh=Ugwf7nuySvJF0pm1EZ6sYChpkqrG6unVjUpZaqu1rqk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TJgo7JQx+lazQiQ1XhvOHdzF8+jsz824b6KYy2ao9gY9WRIG3OIcXz9/vE2oFX+Ju
	 fyw1TcMkhjKVnLNdMv0dCAJoXbgmjscU52Ke/ws/ETVtowrAP8gu/6c3C9tjHGb32B
	 mKyfYmKjZ1n6Nyn4T1042T+6cOUlp8OjgHvTUUDtCEAql5jioCiDNN9pdU2FJsTzSW
	 hymWQurh+xvwATFyG3R2lTy8sky0Lf07FQuQFgoMIAioLBb437t8CwUNiofuerzRIO
	 m1O8nODDuJ/+Ycv8Gas1GhTNjmzmOFAwI137AB6EYj1eNbxiraQyOGbUaWYDmVzKG3
	 MG7gD5t3I3XEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B3143808200;
	Thu,  5 Feb 2026 05:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] net: stmmac: fix serdes power methods
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177026762582.167759.9447025168347496232.git-patchwork-notify@kernel.org>
Date: Thu, 05 Feb 2026 05:00:25 +0000
References: <aYHHWm5UkD1JVa7D@shell.armlinux.org.uk>
In-Reply-To: <aYHHWm5UkD1JVa7D@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mohd.anwar@oss.qualcomm.com,
 netdev@vger.kernel.org, pabeni@redhat.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256959-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 61BCAEE9D0
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 3 Feb 2026 10:00:58 +0000 you wrote:
> The stmmac serdes powerup/powerdown methods are not guaranteed to be
> called in a balancing fashion, but these are used to call the generic
> PHY subsystem's phy_power_up() and phy_power_down() methods which do
> require balanced calls.
> 
> This series addresses this by making the stmmac serdes methods balanced.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] net: stmmac: add wrappers for serdes_power[up|down]() methods
    https://git.kernel.org/netdev/net-next/c/3302126a9b2b
  - [net-next,2/4] net: stmmac: add state tracking for legacy serdes power state
    https://git.kernel.org/netdev/net-next/c/9bfcf5460b70
  - [net-next,3/4] net: stmmac: add missing serdes power down in error paths
    https://git.kernel.org/netdev/net-next/c/3019a1333e66
  - [net-next,4/4] net: stmmac: move serdes power methods to stmmac_[open|release]()
    https://git.kernel.org/netdev/net-next/c/61aaa6253714

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



