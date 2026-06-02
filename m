Return-Path: <netdev+bounces-293992-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oG4uDthJHmq+iQkAu9opvQ
	(envelope-from <netdev+bounces-293992-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 05:11:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91047627942
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 05:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91DB63033ABF
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 03:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CDA36923B;
	Tue,  2 Jun 2026 03:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRRQ1pqd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC71536827E;
	Tue,  2 Jun 2026 03:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780369819; cv=none; b=XvuGMvrGwPBVxN3mHWyVhKenrSoSwLyLOUxhzW3Gtcgggr302Xg41bhdn+nUCK0uE+XHyh2NaJSeZejeTu2Jc4TmCpKnWauTPvucqJKjxG5bNDe3URJ/OCbP6BbHUtK2Yq2ZKa6kot0yzLLZJQ80dOnR4doy1xmaKPf9/K55QB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780369819; c=relaxed/simple;
	bh=HLyOgvSHU/Cp6+udXd425A9lP6dSIUNCdTyeTliiLpc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PiYj/8yf6dGbE5Asypy6S3/JDmYHpaoj3Ixb4wkqgqYm+NUfqmz+HTJ6Ick3CdUkho5A+fFXCZ1q/h4A+sq9jlxvoW0cii2AeH02XS/+9S/gDt1L+svGKtYbT6kgoJvY8lHUrDoJIAeyD17vu1DdPfKgmbukYliJBgUtYJ19eAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRRQ1pqd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686BF1F00893;
	Tue,  2 Jun 2026 03:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780369818;
	bh=VjB3Duk4pKCg7BBLhef69aD+tZGI3CEsL/2O83litgI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JRRQ1pqdagvHZZvElpvaqV0W3yyhbPsrDeQrIOLd0hLgT7mhx2mrG4aV/W4TWtA0y
	 sf/KqN2X3yZfJ6BtZPlUOrQJ0KVOQ1Qjavsei7DOe/oUqBpQ3Xea6sjiAQ3lbmzPET
	 cHczzo3r9qe//4IV18OjQMzP9kT89wzv41MmufYJsEstjnIFbHzdkPNV6BPMpgEiwT
	 78Hb+yVcU/vPq5BQEVg1OK1hzgWzWooJJEtmGDA9DrfSl32xhCmBtH6gsSleS0J6tr
	 SabwjMWSopmid1cqeIuzeCpoecdFJJEeMCo+0Z1qaWRKlHB8BosyYLJ02yB/epP0dv
	 rp+kp+bCny4xA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AEC38119F9;
	Tue,  2 Jun 2026 03:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: lan743x: avoid netdev-based logging
 before
 netdev registration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178036982039.224606.17999454816934283921.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 03:10:20 +0000
References: <20260528165017.421576-1-davthompson@nvidia.com>
In-Reply-To: <20260528165017.421576-1-davthompson@nvidia.com>
To: David Thompson <davthompson@nvidia.com>
Cc: bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@armlinux.org.uk
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293992-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 91047627942
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 May 2026 16:50:17 +0000 you wrote:
> This patch updates the lan743x driver to prevent the use of netdev-based
> logging APIs (such as netdev_dbg) before the network device has been
> successfully registered. Using netdev-based logging prior to registration
> results in log messages referencing "(unnamed net_device) (uninitialized)",
> which can be confusing and less informative.
> 
> The driver must use netif_msg_ APIs and device-based logging (e.g. dev_dbg)
> until netdev registration is complete. This ensures log entries are
> associated with the correct device context and improves log clarity. After
> registration, netdev-based logging APIs can be used safely.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: lan743x: avoid netdev-based logging before netdev registration
    https://git.kernel.org/netdev/net-next/c/e3c6508a46f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



