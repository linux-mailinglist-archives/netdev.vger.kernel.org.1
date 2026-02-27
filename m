Return-Path: <netdev+bounces-261691-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOTCHucPoWlDqAQAu9opvQ
	(envelope-from <netdev+bounces-261691-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:30:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F541B2450
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBCED30DC0EF
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6A75464F;
	Fri, 27 Feb 2026 03:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owJxw78b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AC632AAD3;
	Fri, 27 Feb 2026 03:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772163013; cv=none; b=KkrQyZSRuNHV+rNL4+Zcunf7VL/31wQET3b8cjKZma/VhVyTi3o0tBYBtHzk9sI3X1BThWNQReJLC21Ij1tLS4u+1j00hQk2D3F8Lzg3Kifho237FXa9Rp8PGeCdC32u4kg4qrA+pVZFkjUp4UpwSOMirbfa7zhMcDNko+dxQhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772163013; c=relaxed/simple;
	bh=vjVjgWLNlA/J6rr/ogC8rfA8JqX+lpuDGrFMCw9J4+A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F2yiqujCj9ZxE115xM1KVj3H4z07scaq8TDtDBpfMdT3Eq6380lYTM3MVNBKohS6OhcfjgG7FVltmyu1xVplNmLVcsM2/eYgjYCxlLAIbuZHo8kHmnGDRQTwQfVTHRZIXYsvwc5Vr66+lHWmrHdG8exd8icl7oJD3vy3i2MbI8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owJxw78b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662DAC19424;
	Fri, 27 Feb 2026 03:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772163013;
	bh=vjVjgWLNlA/J6rr/ogC8rfA8JqX+lpuDGrFMCw9J4+A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=owJxw78bdHL5ohcQo6W6j81MAe5znJXfCPym1tHEy7bWAPyIfk6s3Bxea6wIae3rM
	 Aq/LlnnSm1W2/Jv5e2+jUkAaaGB77JGis/vaOBB2QdP2Nxf1q2M9BKVuem8RPpMZxL
	 IctfJYJNQuYluMVZ8svYv1A3Z0DKbUryxdS0xLXT6Ml4QbIuDf7iOBD87ho8YN51oo
	 1g/inswWMV3cBRPXk2wUhAzlEzkLUd7tRZyLnOD6L9UMOcBIgosC6hG7qeJ3D22I4G
	 Z7xYgE6wjKCWvv+Ssp5iZeArd7j5JwHRJLikAgV5+rTn7LEH1PCz1j3jIwEFv6lMsE
	 gafKpZPfg6PxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E97393109B;
	Fri, 27 Feb 2026 03:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] Support PHYs that have inband autoneg
 disabled with GEM
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177216301753.1958105.10516758353239021540.git-patchwork-notify@kernel.org>
Date: Fri, 27 Feb 2026 03:30:17 +0000
References: <20260224202854.112813-1-charles.perry@microchip.com>
In-Reply-To: <20260224202854.112813-1-charles.perry@microchip.com>
To: Charles Perry <charles.perry@microchip.com>
Cc: netdev@vger.kernel.org, sean.anderson@linux.dev,
 nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-261691-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D8F541B2450
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Feb 2026 12:28:51 -0800 you wrote:
> Changes in v2:
>   * Add a cover-letter
>   * Remove the spinlock in macb_pcs_config() (patch 1)
>   * Add the macb_pcs_inband_caps() ops (patch 3)
> 
> I'm testing SGMII with a VSC8574 PHY [1] and microchip HPSC SoC [2].
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: macb: fix SGMII with inband aneg disabled
    https://git.kernel.org/netdev/net-next/c/1338cfef1ff1
  - [net-next,v2,2/3] net: macb: add support for reporting SGMII inband link status
    https://git.kernel.org/netdev/net-next/c/7f44b2acc5a1
  - [net-next,v2,3/3] net: macb: add the .pcs_inband_caps() callback for SGMII
    https://git.kernel.org/netdev/net-next/c/d3549e2b4818

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



