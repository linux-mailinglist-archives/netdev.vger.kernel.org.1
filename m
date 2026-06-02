Return-Path: <netdev+bounces-293969-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFT8GXhBHmr8iAkAu9opvQ
	(envelope-from <netdev+bounces-293969-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:35:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C58506274E0
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7528E3091F3B
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 02:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D9021146C;
	Tue,  2 Jun 2026 02:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdkhlrZ4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19603624AE;
	Tue,  2 Jun 2026 02:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367410; cv=none; b=hNxq7FjP1BAhzuowSwjASWjgUo0Jhypq3a9GYzRh+oDcFnJ9P4iNpiRN4RS6ykFqljcB4l66uGfcrFpVjTbDNw/XlC8geTqDrsLeO/6B9QEB/NcLZtJboqD9MqC/wNAHEgtMTQyHK1Hv9/iwghLd6o7Gq4q7v7d8uBYOj13WFas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367410; c=relaxed/simple;
	bh=cPNuRgmaFrMZFm58yTQjYDOhJ8YDN4LOC057+L+4OlY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iTqPF/Tv5l2zWCbTtLpQxVVB9657hcmO9FegVO9ZMKy5VrdMyE/thYAApxMnk/6Y5YcALSc+GpbuONtasSxe4HkwpeojcMX+KXYdTG999fokQ7km23IlMpV7jRSTvqiGRwI2G+QfA/HIOSAeny9XM/mqUhJ/1MxLrqqF+1NvMv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdkhlrZ4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E401F00898;
	Tue,  2 Jun 2026 02:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780367409;
	bh=YHwu7fomjzX+8N6OkA+Gu6EpnSS3smxOcORLCVpt1sY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QdkhlrZ4nBN6czWH2xR2Ye5jErl+omcs0GEFYaqgczUJXZ1Rx5qSxgKe7moA5AiFR
	 UTQNOLzMj1t0JR8xJAEHndn2KDJbOPD7hm4EEJxgBRep81qrSM1Fve0rKeWuMb9YYs
	 iTzziGWzWNxz/BNU0iSGIPH2Jn2UzGO3I+ICEqEqfYO8N6OktTyVwo8I19MtixR1GO
	 X4azV4KHMwgOEhL7S1QtOFVuRWpD94Vd9wQUmnOKNXntJ4uY1wBriS+mPS3PPBCmMS
	 dOZNcYHAqzp7lu02l5faUhTqxcTatKrtu+C+WYikALgbN9yWh4tMNBgZ3cnotZLyDT
	 pKI6H8gkiwgbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199B238119F9;
	Tue,  2 Jun 2026 02:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 net-next] net: fec_mpc52xx_phy: Add missing
 MODULE_DESCRIPTION()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178036741164.211970.9129060267963522002.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 02:30:11 +0000
References: <20260527025139.10188-1-rosenp@gmail.com>
In-Reply-To: <20260527025139.10188-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293969-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C58506274E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 May 2026 19:51:39 -0700 you wrote:
> Fixes error during modpost:
> 
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/freescale/fec_mpc52xx_phy.o
> 
> Assisted-by: Claude:Sonnet-4.6
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> 
> [...]

Here is the summary with links:
  - [PATCHv2,net-next] net: fec_mpc52xx_phy: Add missing MODULE_DESCRIPTION()
    https://git.kernel.org/netdev/net-next/c/996ea50ee957

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



