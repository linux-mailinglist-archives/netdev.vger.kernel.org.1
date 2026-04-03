Return-Path: <netdev+bounces-274817-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAHpGwAUz2nXsgYAu9opvQ
	(envelope-from <netdev+bounces-274817-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 03:12:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7194438FE05
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 03:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 634C33033CD8
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 01:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25650264614;
	Fri,  3 Apr 2026 01:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksNCmFEt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035F11C01
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 01:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775178648; cv=none; b=aMdtJCLMQx255lXpemQBI27mK9/74NcLv1A9/tZLMQHdX56UkwJhVfVy44hyT5KDqmBG3cauIe1Ogqh2ef2HAsJWv3CPNJKC3ZHwuYuUzskmZ400RJ3AD27lETujofqdeyWCPN2QFpM/imCn0SZBrI1+De20tVai2BPPAU/jeHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775178648; c=relaxed/simple;
	bh=hIlEVxHxn+0u31TUjr/YZm97uUqc/Scm5r6kuFkzKWA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mw7yfr1Ez35V8DBRmhbKFwnr+ad//E1AeLF3cit32DY5A8heGjvNCHbGTzNPEbSClSa8ZdUFuNZaDoUbu1CE/8pQ44WZDLx+oTdZ4GQfz99rp2lKTajyGsbOX1SOMXbFjYSxd9hFobZrcP/DDyK1wxGr9hx9/Qu+Y8il7IwUsNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksNCmFEt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2988C116C6;
	Fri,  3 Apr 2026 01:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775178647;
	bh=hIlEVxHxn+0u31TUjr/YZm97uUqc/Scm5r6kuFkzKWA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ksNCmFEtZB+coLKCDAYUOXri/bBWKQqvatys1+20vRpLdJR1OOkCuKJcsCXHSIlx1
	 1PlPEaPD253f7Xt7y9Q/wteLa7VmkQZccmF9Wqs9l/sHAMVt6ioPn7AWgyuiRMFPXa
	 28WuIbDPfSMcQSQJ2V8JgMwJQJEW6ltICRJ8DTff+0AYzduXOoww55izbKo3tWZ+WK
	 RukH0vIwdZ87RaCP/D5083RD6HEYRqW2rbqayKuJ5v4yyZAgvx76V6Hpeva1upWBE5
	 eq/gAUKUcyagL8ySgP9MZomMRpdAFMG70cGU8zC4RJ0xZa/w3HrexafZAJmFGH5LPN
	 AsvUZqVGpVFBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E8B3809A09;
	Fri,  3 Apr 2026 01:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] net: phy: microchip: add downshift
 support
 for LAN88xx
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177517862978.685228.4102361221441517490.git-patchwork-notify@kernel.org>
Date: Fri, 03 Apr 2026 01:10:29 +0000
References: <20260401123848.696766-1-nb@tipi-net.de>
In-Reply-To: <20260401123848.696766-1-nb@tipi-net.de>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, phil@raspberrypi.com, linux@armlinux.org.uk,
 andrew@lunn.ch
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274817-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7194438FE05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  1 Apr 2026 14:38:43 +0200 you wrote:
> Add standard ETHTOOL_PHY_DOWNSHIFT tunable support for the Microchip
> LAN88xx PHY, following the same pattern used by Marvell and other PHY
> drivers.
> 
> Ethernet cables with faulty or missing pairs (specifically C and D)
> can successfully auto-negotiate 1000BASE-T but fail to establish a
> stable link. The LAN88xx PHY supports automatic downshift to
> 100BASE-TX after a configurable number of failed attempts (2-5).
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] net: phy: microchip: add downshift tunable support for LAN88xx
    https://git.kernel.org/netdev/net-next/c/e417ac73d24a
  - [net-next,v3,2/2] net: phy: microchip: enable downshift by default on LAN88xx
    https://git.kernel.org/netdev/net-next/c/70180f72d911

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



