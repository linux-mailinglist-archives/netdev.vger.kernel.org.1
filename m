Return-Path: <netdev+bounces-267776-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aALVAcuRtWmY2AAAu9opvQ
	(envelope-from <netdev+bounces-267776-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:50:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6739428DF80
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5EB203016D03
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 16:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30489310779;
	Sat, 14 Mar 2026 16:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPrUC2Fm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D12130FC39
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 16:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773507016; cv=none; b=QjuCR7nvjtYhjioZ2cIQSNRpslK5eDvitHzzdlRUUuFbtb4t+BYyBqH1GWYwB63sWSscZjQxXMbZ2ox27zU/+hGTg+zRoJKw2/MNxVB4jeZrPsruLMnPI81UU2/5dkUpVyK+J+7eFjys5IVI4ybesgzZ9wjcXbwwYJ1BbmRcWIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773507016; c=relaxed/simple;
	bh=C3bv/cpFRHoc6ucznQhWA3TBbqy2kVsBUcYIx9yO+V8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tHlzviNbg7ZWm9H9vIhpVHFMtzlKtXKyzsEYswnTH7fhhyLtMxp7s0UtuclgJyl6K0KqnoLj8QnBw8qM85+BmLfYN4MYQ2XdaBkwTuPJfkjgDBq3a3iWwzyjJ9myR2bt+PClWsSVMOiz8JcbvyZs97ziYFFul9iZc5iXD6gLX78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPrUC2Fm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B02C116C6;
	Sat, 14 Mar 2026 16:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773507015;
	bh=C3bv/cpFRHoc6ucznQhWA3TBbqy2kVsBUcYIx9yO+V8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EPrUC2Fmi/yncgZXB4Cv7fgSekMsKgengVm2R41RpxZrFeP+A6WzSYXwevf4tijNg
	 83I2iER0xLy/9DKO7vTbF9BmpXSG8jquVRlSGDopF0vVYz0Sa3st95BOC2nfL956Hv
	 YlupVu9V2NSTz0m/sB+6zwsqZ8S2HQiCoXsVatY1BT9ohNQ4hV1KkVrafm5ssuyZcv
	 DKDtXhWgkNfRzwh1fYz2J/dXWIL1JObp0TXmPSM65/qWCaQYsh8DvltEwUOn0CG+6n
	 A1fQsK7LRtCTAQZffBQ3QX9ydCzVS6aUoNM666jkVx5qO3V52IbCcc8qLh+nFuKYrI
	 lLuNA+h9xaLiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02F523808200;
	Sat, 14 Mar 2026 16:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: avoid passing pci_dev
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177350700978.1730865.6008377263416026243.git-patchwork-notify@kernel.org>
Date: Sat, 14 Mar 2026 16:50:09 +0000
References: <E1w0evI-0000000CzY7-1fyo@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1w0evI-0000000CzY7-1fyo@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 pabeni@redhat.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-267776-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6739428DF80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Mar 2026 12:13:52 +0000 you wrote:
> The pci_dev is only used to provide the ethtool bus_info using
> pci_name(priv->plat->pdev). This is the same as dev_name(priv->device).
> Thus, rather than passing the pci_dev, make use of what we already
> have.
> 
> To avoid unexpectedly exposing the device name through ethtool where
> it wasn't provided before, add a flag priv->plat->provide_bus_info
> to enable this, which only dwmac-intel needs to set.
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: avoid passing pci_dev
    https://git.kernel.org/netdev/net-next/c/f807b5b9b89e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



