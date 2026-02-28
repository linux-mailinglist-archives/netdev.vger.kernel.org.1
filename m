Return-Path: <netdev+bounces-262034-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCCzJJxHomkT1gQAu9opvQ
	(envelope-from <netdev+bounces-262034-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 02:40:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B191BFC4B
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 02:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4837230CBDED
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 01:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D0E2FFF8E;
	Sat, 28 Feb 2026 01:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpBaqWE7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562272FF657;
	Sat, 28 Feb 2026 01:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772242806; cv=none; b=hbt2IdD41VrWGcWbEoL4yLLwW/FMYsk9PYiwbdWaQq+noQ83pFAJTJVV2CDUW13kGUMrFP4yyxU2Ea9m4H5n62L5+PBW7OBWqo/n1QR3W0nuX0F9WrXl62jDT7SYyxRW6ougLW90gmuoZQKJa0buU8GxT28pp3etZ3gLLKeyDjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772242806; c=relaxed/simple;
	bh=mvVmIYSapqOyfBBdZEyjqlnLQ4S+7i05GJ4c0k5D9ZY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rKkKzUKWdtxphQu84veH3m306g27OPhyWrwIxvF2N99V2xNbdreRrblZoMZxjqlrO4HOYQZ+e1uY0u4s1yeISKgarIqzMHdUZ9fWa+7A2mzmLHs+SfobbIyLyRYWAXKGrJNhWKehv0eXKNjY5DtclacBmhtPzQirVzCdb4pgrZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpBaqWE7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0304AC116C6;
	Sat, 28 Feb 2026 01:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772242806;
	bh=mvVmIYSapqOyfBBdZEyjqlnLQ4S+7i05GJ4c0k5D9ZY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CpBaqWE7MQgvvYEYjK/ABarxKPRXSahXv9ziSpVpvxo/lH9kpt3uI9JbVRpV+wP3R
	 0EzLYafU8k6IXL5mUruB25CC3dShCXbhWCipuD6U89VznCeO6xfA7FMxYxtLcJ1D08
	 krFbEZYVpl7/JS2ClXPtzhgUIn33JDop9ieZvHq9M+ijFMvSLX89DXNo89P74j5qMz
	 /LE+sHcJAsQ9aYdwUyEszH9fFDX7uYpD7QLAy1HFDg5PjFYZ6msFPqrlob8JGJKq8/
	 /+pSU0LIc/T9pPLe6F1m99Lu5Xj0R6aiOwny0OYsR9CkiEGf9w0ol6K8tEBNuO6Hrc
	 Iec9T1B/r/bgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9FD239EF96A;
	Sat, 28 Feb 2026 01:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: phy: micrel: Add support for lan9645x
 internal phy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177224280928.2834458.1091773478655412701.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 01:40:09 +0000
References: 
 <20260226-phy_micrel_add_support_for_lan9645x_internal_phy-v3-1-1fe82379962b@microchip.com>
In-Reply-To: 
 <20260226-phy_micrel_add_support_for_lan9645x_internal_phy-v3-1-1fe82379962b@microchip.com>
To: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard_=3Cjensemil=2Eschulzostergaard=40?=@codeaurora.org,
	=?utf-8?q?microchip=2Ecom=3E?=@codeaurora.org
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horatiu.vultur@microchip.com, o.rempel@pengutronix.de,
 Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,pengutronix.de,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:-];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	TAGGED_FROM(0.00)[bounces-262034-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.261];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E0B191BFC4B
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Feb 2026 09:24:19 +0100 you wrote:
> LAN9645X is a family of switch chips with 5 internal copper phys. The
> internal PHY is based on parts of LAN8832. This is a low-power, single
> port triple-speed (10BASE-T/100BASE-TX/1000BASE-T) ethernet physical
> layer transceiver (PHY) that supports transmission and reception of data
> on standard CAT-5, as well as CAT-5e and CAT-6 Unshielded Twisted
> Pair (UTP) cables.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: phy: micrel: Add support for lan9645x internal phy
    https://git.kernel.org/netdev/net-next/c/11c0663a5958

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



