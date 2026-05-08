Return-Path: <netdev+bounces-286053-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SB8TDed2/mktrQAAu9opvQ
	(envelope-from <netdev+bounces-286053-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 01:51:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7F04FCE67
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 01:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DBF403006B6B
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 23:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE292366DA4;
	Fri,  8 May 2026 23:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QblvcMzS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFB5365A1D
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 23:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778284260; cv=none; b=PiJLfA5xKYLZW9C+5Nlw6Fytjr4V/4i+HJG3URqCmglimLg+Q4PpWed2PE98XUF75NlBvstF/m+kdj8nsPZqSmKshEysMjKQnt339OxThERk9a7izCspOgiK5pJ9URNZ6pz2KFOyzjQwH3ct0ieMCkhAATtFZI8TGQc6+7dX7qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778284260; c=relaxed/simple;
	bh=jI7ggsmfwTWZBeaQARu01YK8qfNkufFgYOFEVZKHRn0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ooNq+ET8LmrjqqMQtyoIby3o5ibrNWIETJaIHevbvlATxGpuM6Btx8TeClyH7WHdgGALq0OcV2Efqu/SS7xzIQ/8QKj5l5IHp6vZnuYFDJN+i6M4GLgq6o6nEeNjNiRMkM9vXOJ3bIFPE8mEMCCyEVPZaJmhauT2BxNdTn4uSpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QblvcMzS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A687C2BCC9;
	Fri,  8 May 2026 23:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778284260;
	bh=jI7ggsmfwTWZBeaQARu01YK8qfNkufFgYOFEVZKHRn0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QblvcMzSjVgUv4EotvmVEQbXenAageFuAgKGG8YJ0we7tPVFI1Ugupof+MSaofjHC
	 I5pouJBFUbSDkmz9hxPvN7rkb5W5zvFL53fjZwzqPEidRgC3K0qz4kPteC4B4+6N4C
	 AQshmZdlWAXHyLuxsCwrqibiA9x41JZU4AsbU8UgzZYnHSPSfh6HVXHm61os0PfUkW
	 9zzYXA+3OoEZccXZSMP8MxZzR2rB0VgUoA1EWOhsaSySdy1FpAAvMoQZvbwFd3MySX
	 P+1S+xUFqt8fn9fYTFb7qJb3Y5hshLbJpgXtmb70MU6Es9PNE6kQ7nqKL+KYy6o4nm
	 3VGy+RS/FsBIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD1338119E1;
	Fri,  8 May 2026 23:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] Keep PHY link during WoL sleep cycle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177828420904.900660.8009057314618437924.git-patchwork-notify@kernel.org>
Date: Fri, 08 May 2026 23:50:09 +0000
References: <20260506213114.2002886-1-justin.chen@broadcom.com>
In-Reply-To: <20260506213114.2002886-1-justin.chen@broadcom.com>
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch, florian.fainelli@broadcom.com
X-Rspamd-Queue-Id: BC7F04FCE67
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-286053-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 May 2026 14:31:12 -0700 you wrote:
> First we divide the init/deinit path to allow for a partial init/deinit
> during a sleep cycle. We also remove some unnecessary small functions at
> the same time.
> 
> Then we modify the suspend and resume path to allow for a partial bring
> down and bring up. This allow us to keep the PHY link up and to resume
> network traffic much quicker. Note we only do this when WoL is enabled
> since the PHY is already powered. In the non-WoL case we want to follow
> the same flow.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] net: bcmasp: Divide init to allow partial bring up
    https://git.kernel.org/netdev/net-next/c/e97ffa4e975c
  - [net-next,v3,2/2] net: bcmasp: Keep phy link during WoL sleep cycle
    https://git.kernel.org/netdev/net-next/c/e447b677bb26

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



