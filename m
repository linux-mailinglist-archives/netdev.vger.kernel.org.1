Return-Path: <netdev+bounces-287762-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFxWD3ocBWqtSgIAu9opvQ
	(envelope-from <netdev+bounces-287762-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 02:51:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7B153C737
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 02:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3588B301E163
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 00:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73FD2F290A;
	Thu, 14 May 2026 00:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osDykwT/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C403222A4EE;
	Thu, 14 May 2026 00:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778719860; cv=none; b=CvBKHJRfrHLbGZJFFBUMJ23DY/BMw3n/W4XudabISIxg8PCnZbWt84zWf/Wy7kflaniPQa0FVc+0cHKP5ZiVqAHD617ZV9ctMZHVEm8PcqEb7WeqdYAxb9Ftz4e1ie1E8KE/KpZdwp6zyLmrToCsQRWNvctmPd4tFtmEM6AT2xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778719860; c=relaxed/simple;
	bh=Zj5kUXVCws7hZjYqcl3MzlygNsi7Jib6ERuJ5TsgocE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IpwSOqjhElQPUE1Jj0W/L/H3ctDruTqZ+f6ggFb+CAoPAptx2KSuFGWTvUG9nARXXtIwO7oSm0aAAdhoWfYNM+S+IWC8p07xu4XzNlOJPda3sgtVYI5xALc9DcH0uBLQ/mWahnZRgyP2Y1iKciz3mfI7dhJMc9fNaSENz76qp1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osDykwT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE8DC19425;
	Thu, 14 May 2026 00:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778719860;
	bh=Zj5kUXVCws7hZjYqcl3MzlygNsi7Jib6ERuJ5TsgocE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=osDykwT/+n6AO1gIYCGD7N7LH4h4stGKJ1kb1QHe1dpzcXSwmeIPgy9QxpUOWYlNl
	 240entuAi7WSlqNAW1WKjh6koj0X60hITKBVWLgLDPFUIhqPdUC6g8B+zfxz8roAh0
	 JVg2siGJR8RuDmETP8FVpZbwgsExnswsPIAKgFR1ycsGcHPAskJnRAEsEpkTvZtVoG
	 WcR10veChSC4w5DnLitp0QTXa+ukYffcG0Ze4OwHs11fneJ4XHd68sWorJgmXDfn8G
	 e8l4M/QLahVkFdukBfbka5/Ge5vnkMqeV7l2/huUgbHKsbCOM/2r5tHVh31jCOmyI3
	 c6sT1SLCCVi1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F51393088E;
	Thu, 14 May 2026 00:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] FDDI: defza: Sanitise the reset safety timer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177871980555.3899557.7004016793675338471.git-patchwork-notify@kernel.org>
Date: Thu, 14 May 2026 00:50:05 +0000
References: <alpine.DEB.2.21.2605061216430.46195@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2605061216430.46195@angie.orcam.me.uk>
To: Maciej W. Rozycki <macro@orcam.me.uk>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: 3D7B153C737
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287762-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 9 May 2026 22:04:50 +0100 (BST) you wrote:
> The reset actions of the DEFZA adapters are exceedingly slow, taking up
> to 30 seconds to complete by the device spec and typically in the range
> of 10 seconds in reality, as required for the device RTOS to boot, still
> quite a lot.  Therefore a state machine is used that's interrupt driven,
> however a safety mechanism is required in case of adapter malfunction,
> so that if no state change interrupt has arrived in time, then the
> situation is taken care of.
> 
> [...]

Here is the summary with links:
  - [net-next] FDDI: defza: Sanitise the reset safety timer
    https://git.kernel.org/netdev/net/c/4694efc41641

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



