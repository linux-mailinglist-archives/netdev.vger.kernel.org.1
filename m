Return-Path: <netdev+bounces-287782-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id A9TFCzwvBWr9TAIAu9opvQ
	(envelope-from <netdev+bounces-287782-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 04:11:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A95553CF14
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 04:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2B886300B51F
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 02:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0406032FA2A;
	Thu, 14 May 2026 02:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRbdsn6i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54B331F989;
	Thu, 14 May 2026 02:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778724660; cv=none; b=dSCLKD6wkC0Z/tX0v9YgWbR4dvSrsAAj64/tL7vIdIifEKgeh3BQAYJmGGYOpOedsBbJnRLEkw2MfcyjHQmIElteyV2cZOYYLUyMRmxVTKVAT+GD+QGSazbJn0J9z9a6Lvb2exdybsqgDLKzV8p9IX/eI8bdZDIxhp/D8UEv5Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778724660; c=relaxed/simple;
	bh=LFmPmup5LjziaMIrWqaqSCFotJ6H44cj75Ztn02pIIY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bz65pXwtXzoin9YfAU3PnRJnyEZ1jM5tNKs3/wPEdsde/g7k0NUbFPiCtz1IduU9WwRSU+Mq+EX6xLaDjgwdMaYgKCdj54LunQmEyO2Wm8pcWBBoDLdE2TBJSdGvvK1F20LR8bmY/e10GcBPazoM+aCZaJcUniiokz+QM0iycGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRbdsn6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6961EC19425;
	Thu, 14 May 2026 02:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778724660;
	bh=LFmPmup5LjziaMIrWqaqSCFotJ6H44cj75Ztn02pIIY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RRbdsn6ipSwVx9ulLSg3jdE6JDJWWdHvXSHu7WalSHojvpnBoKXUgi6s/cmyINgiO
	 r0x41PLpIk+SAbXFoGzHDJG2kuKJTBKEaoVA4XMVw1O6ehxjS1eA/Zuj2VeARdMmMr
	 SjstR3se+CrzKgWxcZYeD63AVsZnBQ6FDS9Rf7wGJaRoL/ZqvowtxPME9f0TvLxJPq
	 utZfczj4tk0tJhHWWK/GsCRW3nPDJ9BAObkJ6m/3WnsAhFsCTHeE9a1xh13RK/MqFY
	 jA4RKVnpklQwdMBI00nvS5q7VdsG9LFVjQNYhDTw28MsHOnN5pwul9TC3SOFOU2DFL
	 vcZLMe3sHxRdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F46382330B;
	Thu, 14 May 2026 02:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] net: net_failover: Fix the deadlock in slave register
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177872460555.3922273.10860420108465524891.git-patchwork-notify@kernel.org>
Date: Thu, 14 May 2026 02:10:05 +0000
References: <20260511140552.3284563-1-faicker.mo@gmail.com>
In-Reply-To: <20260511140552.3284563-1-faicker.mo@gmail.com>
To: faicker mo <faicker.mo@gmail.com>
Cc: sridhar.samudrala@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 sdf@fomichev.me, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: 2A95553CF14
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287782-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 11 May 2026 22:05:51 +0800 you wrote:
> From: Faicker Mo <faicker.mo@gmail.com>
> 
> There is netdev_lock_ops() before the NETDEV_REGISTER notifier
> in register_netdevice(), so use the non-locking functions
> in net_failover_slave_register().
> failover_slave_register() in failover_existing_slave_register() adds lock
> and unlock ops too.
> 
> [...]

Here is the summary with links:
  - [v4] net: net_failover: Fix the deadlock in slave register
    https://git.kernel.org/netdev/net/c/b84c5632c7b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



