Return-Path: <netdev+bounces-256103-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICCnHZBpgWmvGAMAu9opvQ
	(envelope-from <netdev+bounces-256103-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 04:20:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DB908D411E
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 04:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8D3E3022912
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 03:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70B22E972B;
	Tue,  3 Feb 2026 03:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZfBRAww"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8466F175D53
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 03:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770088816; cv=none; b=DVBHZ1G6CX6M5Z2CPa7S/4AC538xNb9rpvVtLPadHtUmMs8+3xS3lzNZhsdWNx9t+zEw49E65Lv2x54b8W0M7CZHWjz3BTzkAaGNMDnXOAKiWCUwSrQYmj2Z4LQxsQzLyCj94C1KIHLCha6QvV9kuZTNLIhXkmeY+/UUo623U6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770088816; c=relaxed/simple;
	bh=s3JCSBIzTmNuGCJD/5jI8VEjBvBh01FRCXRjgvKtYSs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l9fTYo3HoRSVmRHnrkbcAk3WIv70v0UkFHkAkMcSQ6AAyfw3/DodrHEd5PLH4/gnkMSZkYI3qLD3V02NZrwbER47RbNk9pQgJTeviSkzrdaA8Eb55AfCldUwkQsS2wZigI54Pei7OJgPOLZhoUUo+EULgHMIzQW797kDfTbmhRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZfBRAww; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232B6C116D0;
	Tue,  3 Feb 2026 03:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770088816;
	bh=s3JCSBIzTmNuGCJD/5jI8VEjBvBh01FRCXRjgvKtYSs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PZfBRAww5iTqwTfzWKc1ZpiXM8dsP6EZvLuhd6/8ir78k6TBj8UfMCSOT+mm2b6db
	 CThEcJQ+PqaqUiUSrzU4MOlvHCPsqLEPB6fT7yVag4dhux/yzqndDN5YUH74gpqbgw
	 41Rwuo8iGvmIV0oSoXAcEMtJq8gdeml2VOMfX3NpaPaVbvXvZOzuV33CFhmwqhnxkg
	 Jd7BXmt1MgyFw/rf5vbP5M7ItcVHtJg9DEryuWb+p2OiwbNjnUL9SITILgsyJzTM9C
	 k2Ip7bcWA3w80nI+Frz5uPzTI06uVFgOLEtnYAtgWhk32GHJpCtE+rowjXGcbi5mGd
	 fhOea7ogcAqIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 16DE43808200;
	Tue,  3 Feb 2026 03:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: stmmac: pcs preparation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177008881287.1295553.6986810799216029120.git-patchwork-notify@kernel.org>
Date: Tue, 03 Feb 2026 03:20:12 +0000
References: <aXyRlFw7ZuhRPiKo@shell.armlinux.org.uk>
In-Reply-To: <aXyRlFw7ZuhRPiKo@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 pabeni@redhat.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256103-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB908D411E
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 30 Jan 2026 11:10:12 +0000 you wrote:
> Hi,
> 
> These three patches prepare for the PCS changes, which, subject to
> Qualcomm testing, should be coming in the next cycle.
> 
>  .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  2 --
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 18 ++++++++++---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c   | 31 +++++++++++++++++++---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h   | 24 ++---------------
>  4 files changed, 44 insertions(+), 31 deletions(-)

Here is the summary with links:
  - [net-next,1/3] net: stmmac: clear half-duplex caps where unsupported
    https://git.kernel.org/netdev/net-next/c/83957d6cae5b
  - [net-next,2/3] net: stmmac: move most PCS register definitions to stmmac_pcs.c
    https://git.kernel.org/netdev/net-next/c/eb4a1fda2c2f
  - [net-next,3/3] net: stmmac: handle integrated PCS phy_intf_sel separately
    https://git.kernel.org/netdev/net-next/c/69a586e8866b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



