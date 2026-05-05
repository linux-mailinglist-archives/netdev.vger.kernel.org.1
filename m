Return-Path: <netdev+bounces-284174-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLrhNrRW+WkK8AIAu9opvQ
	(envelope-from <netdev+bounces-284174-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 04:32:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 536EE4C6043
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 04:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AAC9303B4F2
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 02:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4F83AB27C;
	Tue,  5 May 2026 02:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcRNPZP6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2AC3AA4F2;
	Tue,  5 May 2026 02:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777948270; cv=none; b=lX+qGj+m16yvmLFSsBSYoNGlunlIfQrQFkGVvsYp3gcmOrT1TlHtrUjbD/174EinNTX4AnBnc5eTnyS3NwQlqpn1TT7P4VMZbtNqSoAebU4SD4aetMQjZzDzd0WgDNSYLVSKSa3phrAq+6Z9prHrfBGdNmWO7/CyRAAnrcdO+n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777948270; c=relaxed/simple;
	bh=M/p16af5Ln1fL6+e6QEP7Sj9701xNucASUan+tM7aRc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gQ9H1HL9xjzuQkxVVojLwdC1Cl+NSltEO6+jiTsvkt02Il9Fxrnu2hUx+qVwtO9aUF/0K4UDeMUsA8aDjzI6CCz9BzJ04hVdu8fgrD89odyVx3FWlLyr6yrdRmduuDeLOyXLYsgBKK3G/IZhjoV8Nh3EfdrVd0tNC7r9SXCSJ1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcRNPZP6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3816C2BCB8;
	Tue,  5 May 2026 02:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777948270;
	bh=M/p16af5Ln1fL6+e6QEP7Sj9701xNucASUan+tM7aRc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BcRNPZP6Q6mGDgVWXnOvAplprohg+mbn+Q7BP7T4UUes4shZmzGrlotOzEwjRw/0u
	 Bd6Ga3JR9cFP++KIVCaYgq8KpJzW9BlFCA95QqfPwJg+Z2K7S3FQQuo32GMQO/IQa9
	 RDg8HmyHjOXhO3aXj5PKc6FvNaj37HDxwirEL3KHW5etdMvQzUK9Nd7KfZqHnbYNrn
	 8TEtMtJEJQ2yrgQS3aMtcGXJaecs0VoR+yYGCa9P1ZGaNjr0W2lsQJCV/vTGxu+7PL
	 0cVzTP3AaDTdLgqvS7aE7qK1pGtFNdQPxk9ygYCIuY+UF1zg6nVbKAXaoK8F5aliyC
	 mPiLdOwVgeCaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9DC939301A2;
	Tue,  5 May 2026 02:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: realtek: replace magic number with
 register bit macros
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177794822129.1394832.3566254923812339895.git-patchwork-notify@kernel.org>
Date: Tue, 05 May 2026 02:30:21 +0000
References: <20260502092857.156831-1-olek2@wp.pl>
In-Reply-To: <20260502092857.156831-1-olek2@wp.pl>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 daniel@makrotopia.org, vladimir.oltean@nxp.com, michael@fossekall.de,
 ih@simonwunderlich.de, rmk+kernel@armlinux.org.uk, marek.vasut@mailbox.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: 536EE4C6043
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-284174-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,makrotopia.org,nxp.com,fossekall.de,simonwunderlich.de,mailbox.org,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[wp.pl];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	RCPT_COUNT_TWELVE(0.00)[16];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  2 May 2026 11:28:47 +0200 you wrote:
> Replace magic number with register bit macros. The description of the
> RTL8211B interrupt register is obtained from publicly available
> datasheet[1].
> 
> 1. RTL8211B(L) Rev. 1.5 Datasheet
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: realtek: replace magic number with register bit macros
    https://git.kernel.org/netdev/net-next/c/052065add1b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



