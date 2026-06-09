Return-Path: <netdev+bounces-296798-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 17KTA7VeJ2oXvQIAu9opvQ
	(envelope-from <netdev+bounces-296798-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:30:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E4165B58B
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:30:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=d1XEsqy4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296798-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296798-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B333F3002910
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 00:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD19123395F;
	Tue,  9 Jun 2026 00:30:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E075246783
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 00:30:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780965018; cv=none; b=BLzyGx++M1ss7BJv0WTa/2AQOSXB+qMZ3kPwc0YrmfC/Jf9D9XURd1sJQuNr3SwWu6GF/wvvvUQ+rtnEjhgtz7SGrun2RbJC5/0rGEde9BF88OL2gBYjUlcSlkgTxKiUXaX4YH3VEqrhe6ZI5WgWInbOiMBOW/BvFyIBTC6hvI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780965018; c=relaxed/simple;
	bh=nWuvcWOKHRZlAICMDGjK2WEQzW1Xfm4NW+ew5YF5pII=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VVNC06dQorOhrUcYFEI4/5oXYnVcAPDZk8xYojv2ayRww1sdO9Gw5RTTQx2rPKX3QLyOSs1iKZQ2IVXkLjeWz1mY6fpqMlMJwytcTsKKjAgauXo3RKdXu+WzY3FyfDKsKlaPTRuaAWDYZZVDgQ6AKORPdogwWoN5PHZvcv/RpdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1XEsqy4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87EA1F00893;
	Tue,  9 Jun 2026 00:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780965016;
	bh=6oflT6M4vpQGh89Fk1A0b9ZXCKAsjZCOBE9yFrqdnsM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=d1XEsqy43TiWZp6xjZr/FekUrH5OV4xC25lci/oH4II9/JgOELqBvLH4BMrVq+cVf
	 mkC2ueEQuw2/0Tf/54X7Dy1UWxcoX9mSN89pkjpIx5M7sloychaZPTCgkwPoEBQ+oq
	 i2fz5khBf4wzsZiuwQsZCc8tVSfkKqJ9eDYPMaqtFqIPsI7o6Rh0RuTTshZJNmBH/M
	 lQGZvkxlkWVFDVo1go+FSp+CGo98wvsFvMP9c5RjXkqEuszQPsRBl5h6GGgtyLhyfC
	 k4ARtBTigJ7swMDWOA3XTxZ+A6cEWK6h8ibjsBLPfRb+wZgb6/E5hEmx5jyRYIXP4x
	 napRxTUqDQ/8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93AB53812FDA;
	Tue,  9 Jun 2026 00:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] pds_core: quiesce DMA before freeing resources
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178096501514.1726280.11716563786761485251.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 00:30:15 +0000
References: <20260604213637.3844317-1-nikhil.rao@amd.com>
In-Reply-To: <20260604213637.3844317-1-nikhil.rao@amd.com>
To: Nikhil P. Rao <nikhil.rao@amd.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, brett.creeley@amd.com,
 eric.joyner@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, aleksander.lobakin@intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-296798-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nikhil.rao@amd.com,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:aleksander.lobakin@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E2E4165B58B

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 4 Jun 2026 21:36:37 +0000 you wrote:
> pdsc_teardown() frees DMA buffers but does not disable bus mastering,
> leaving the device able to perform DMA after the buffers are freed.
> This can lead to use-after-free if the device writes to freed memory.
> 
> Add pci_clear_master() to pdsc_teardown() to disable bus mastering
> before freeing resources, ensuring all DMA is quiesced.
> 
> [...]

Here is the summary with links:
  - [net,v2] pds_core: quiesce DMA before freeing resources
    https://git.kernel.org/netdev/net-next/c/6443f4f20bda

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



