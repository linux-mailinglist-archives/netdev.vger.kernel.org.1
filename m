Return-Path: <netdev+bounces-264646-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PdnFJ1LqmmIOwEAu9opvQ
	(envelope-from <netdev+bounces-264646-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 04:35:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B498421B289
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 04:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1429305F7DB
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 03:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15F234028D;
	Fri,  6 Mar 2026 03:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYS5TTwk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD7931578E
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 03:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772767974; cv=none; b=fyJrzNB0gOXrlDNiOvK7ds45EeEOnFesEFXD1QOFO0nuyYDfgcRD8faGDw9BVtY7w0JeNZFk4GKQAPvy3qiAszNiKhKdOmIhLTN8qFPGznbsOtLwpoer7DAxsIH/9wMopFsI25/g2m14tGfyVPwT5/vUnHJzkn+Cj0GYovRiyj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772767974; c=relaxed/simple;
	bh=vhNod20kfAE7wOnKP5rqijyYcGC4yv2qCfb9p+ZXvH8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G7XARggQPdZCclqk26y20hlh1VfpVaMv2fU3+7woiTv/NxQ+jcQ076mEhLljO3FTBQErJ0nKdFrR1G4QDtXy4HJyeKOX57k4GDhC6gR+AG019NwXEsEENbhTqK1DJE8iUMXnqmlwc5lrfgSyLOrU0E0oZIw+yvbS1kW5vNWNaqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYS5TTwk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1356DC2BCB1;
	Fri,  6 Mar 2026 03:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772767974;
	bh=vhNod20kfAE7wOnKP5rqijyYcGC4yv2qCfb9p+ZXvH8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nYS5TTwku7/C2LmwZXloanE26Zqg8hdzO1TRrnTCarpCEpAh0/Jil5jNUhBxy0HS0
	 nsd8O/epAEyIlq6Vdqo/xm3BjaFgTDgADzuvKbD0OQZOG3asL+RJLxkmgPBimF8oGT
	 a1dA3IL40xFeKMgJgTwtX5YpThuV2oJr8Gc1B/N4ZwZK3p3MWRmlxD+E9ywM0GSqiP
	 xXYkYNisrIXCYdYJsfx6oAU71UYEyqDG/KRq5SpkI2r0fUxHivmIVj+M5BXPmOIm7U
	 N4viLEgqMg8gmyKe0Zcg5tO0EB0R6WqBbadMDWHjm7gxU01QBI1NocjDqvkInmwDgs
	 CL/pgEdfFFWbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 031583808200;
	Fri,  6 Mar 2026 03:32:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mdio: xgene: Fix misleading err message in
 xgene mdio read
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177276797365.3348267.7991707746750448647.git-patchwork-notify@kernel.org>
Date: Fri, 06 Mar 2026 03:32:53 +0000
References: <20260304195755.2468204-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20260304195755.2468204-1-alok.a.tiwari@oracle.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, quan@os.amperecomputing.com,
 keyur@os.amperecomputing.com, iyappan@os.amperecomputing.com, andrew@lunn.ch,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, alok.a.tiwarilinux@gmail.com
X-Rspamd-Queue-Id: B498421B289
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
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,os.amperecomputing.com,lunn.ch,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-264646-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Mar 2026 11:57:36 -0800 you wrote:
> xgene_xfi_mdio_read() prints "write failed" when the MDIO management
> interface remains busy and the read times out. Update the message to
> "read failed" to match the operation.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  drivers/net/mdio/mdio-xgene.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: mdio: xgene: Fix misleading err message in xgene mdio read
    https://git.kernel.org/netdev/net-next/c/54f5a89da9e0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



