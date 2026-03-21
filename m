Return-Path: <netdev+bounces-270155-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKYHI6wAvmn1FAMAu9opvQ
	(envelope-from <netdev+bounces-270155-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 03:21:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 205A52E2E58
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 03:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 637F2304E705
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 02:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBDD2D47E6;
	Sat, 21 Mar 2026 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfPettm/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2925C2D0C82;
	Sat, 21 Mar 2026 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774059630; cv=none; b=WLSm+VmRr2PXnsIMNJvX4aGDg5l1brt5n3HlhMfuaCp0w06RCB0lowKI5BJGSLuaBZXCvfe/37VsylE48bqoicwh7Y5YnqokJ1x3GN1gMW192WQQYhwx7uabb+AzJgKwCCFxxLYQXRa2KBnAhXwkCAylOJ7mrpab/FIaxOnfbto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774059630; c=relaxed/simple;
	bh=gXNKOCmNerpVV/NOO0dCyuAakP8EpPfmmuvmAPRKI3c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BlGTh9m0fbaUrQ2USVjju3q4ilp14skDsroGhJcK/jh8V4UIaU3ZhRtQUgrwYs5QiDRMiTR+pYhk6etdSD07N/5pgHFwkLZAdYta8Snc5HJbKQZ6ZVO0v4fE8YAmw3m0wKLjcqi1AkYRgHoFCxSx8RNfyLuBNeYO1NN2L26iAV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfPettm/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0929DC2BC9E;
	Sat, 21 Mar 2026 02:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774059630;
	bh=gXNKOCmNerpVV/NOO0dCyuAakP8EpPfmmuvmAPRKI3c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kfPettm/ivfGg2JZL5RJwuMVFHGBhOcc7zcekvLHwTO5J6hW3lfFCN2X7A3U6AbM/
	 D6FrgUuxjFyhw3U4NDO0/8bJJiVHGADeLMupuH9j/7eTEjvKOLtnFmGiy1EHx8GR95
	 D2Ybhv5i4JnLbLjYrT8UbexqspdT88+Bz2QxeIh/YI0izVe93ww7uTXdeIwxFFGTPH
	 DT+UJ4Za5SFMZykBhhOgoKBlUdirEAYxqTarKGRMpvD4a5GcAZrPpOGE12BgcOBD2X
	 Ngc/ekRWeVxTggmwOZuem446+ZDaooOT4a8WmFw7nq3Of0P6lAJdRMGYQzjuxppPus
	 D7gOyQ3v9hMfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD6F3808200;
	Sat, 21 Mar 2026 02:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethtool: re-order local includes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177405962003.2725242.17526920920036950474.git-patchwork-notify@kernel.org>
Date: Sat, 21 Mar 2026 02:20:20 +0000
References: <20260319180555.1531386-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20260319180555.1531386-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, yangbo.lu@nxp.com,
 piergiorgio.beruto@gmail.com, o.rempel@pengutronix.de,
 kory.maincent@bootlin.com, daniel@iogearbox.net,
 thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270155-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,davemloft.net,google.com,redhat.com,nxp.com,gmail.com,pengutronix.de,bootlin.com,iogearbox.net,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 205A52E2E58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Mar 2026 19:05:54 +0100 you wrote:
> Most local #include in the ethtool command handling is out of order,
> with either :
> 
>  #include "netlink.h"
>  #include "common.h"
> 
> or even :
> 
> [...]

Here is the summary with links:
  - [net-next] net: ethtool: re-order local includes
    https://git.kernel.org/netdev/net-next/c/82a5852595f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



