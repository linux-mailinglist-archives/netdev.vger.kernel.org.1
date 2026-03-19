Return-Path: <netdev+bounces-269257-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAoMJXZUu2lMigIAu9opvQ
	(envelope-from <netdev+bounces-269257-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 02:42:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1932C4956
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 02:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 231DD30BBE80
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 01:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA97318EE2;
	Thu, 19 Mar 2026 01:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyqAIxA3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A620D322C67;
	Thu, 19 Mar 2026 01:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773884421; cv=none; b=chYULaB8pwvONU1roVbv75wDphCjX8FmfDGP5l1UKdzlMGpIefpDXHUIbj52hXk6lci+7TEIIZ2oQwZbCj9j73YDdLFuXKb56YQrLC21u4k8M9H0jsjuoeLNWcGTXbWpNzcKfPEIThxPPQFatXLDhtVsICeEpTi8JPbwg16N6nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773884421; c=relaxed/simple;
	bh=g/BBLJ6seR7FT/DfJMu+VlJVUjEuMmhbzCLKpt2O5KY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OXKediv/E4tDV9cckBH87JjA1CFP45jlBUgVNgtEd5SicwZoT3SNgUXGu8nrKuxvq9SpWeN1fqo7AqRtFyMvo5W4PjexOvhSZ+7t5WAtpYF5dAf7B/WWFDYVyvAuOvSZE4stCXtB3U0skvpLCsxKNKwD+mXcQHaGio3K/iRf6b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyqAIxA3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC10BC19421;
	Thu, 19 Mar 2026 01:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773884421;
	bh=g/BBLJ6seR7FT/DfJMu+VlJVUjEuMmhbzCLKpt2O5KY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AyqAIxA3rOzOz8I7gOp0+qJ1ewKHmpKHLChoC0bF8EB5lSr7EuvV0lS1FVsDh23BG
	 1UIRC0S03TPwbR49R6dnF8eVTLf8qV+N228PXlFa8YzDJybUspzG15uDV80FjUtUur
	 R8RDk7127JngKp8XWZgXCtTKfsDZudI5wcUtPgulGbaU3AeDb0alm6w4A01TnxSULY
	 8vc76DgcXMePxsCDbZmOyPgxUPjdo5VpQdvyMvn1DmrVbp7m97BHc2b0GieIH0PCvN
	 mYnWZregaQBk+ruVr8M3b63cJoeX3jU8K48+3q7FxOyBeGwFltjB+MfuKVgHLm/5CX
	 VkdwEGZLuJPKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF503808200;
	Thu, 19 Mar 2026 01:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] remove Kconfig sysmbol MDIO_BUS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177388441229.982294.10744427582237657565.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 01:40:12 +0000
References: <bc63cf87-3dba-4ab6-9c84-caa7357c3273@gmail.com>
In-Reply-To: <bc63cf87-3dba-4ab6-9c84-caa7357c3273@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, linux@armlinux.org.uk, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
 broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
 dakr@kernel.org, netdev@vger.kernel.org, driver-core@lists.linux.dev
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269257-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EC1932C4956
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 15 Mar 2026 17:47:47 +0100 you wrote:
> MDIO-based regmap is the last user of config symbol MDIO_BUS.
> MDIO access needs a MII bus, which requires PHYLIB for the provider part.
> Therefore make REGMAP_MDIO depend on PHYLIB, what allows to remove
> config symbol MDIO_BUS.
> 
> Heiner Kallweit (2):
>   regmap: mdio: make it depend on PHYLIB
>   net: phy: remove Kconfig sysmbol MDIO_BUS
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] regmap: mdio: make it depend on PHYLIB
    https://git.kernel.org/netdev/net-next/c/e611a97032f0
  - [net-next,2/2] net: phy: remove Kconfig symbol MDIO_BUS
    https://git.kernel.org/netdev/net-next/c/91283bd5b008

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



