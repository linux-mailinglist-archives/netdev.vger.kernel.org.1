Return-Path: <netdev+bounces-263037-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMWvAxVopmljPQAAu9opvQ
	(envelope-from <netdev+bounces-263037-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 05:48:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6152A1E90F0
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 05:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15D643057EA1
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 04:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725E732A3C8;
	Tue,  3 Mar 2026 04:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwjAgncI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB372E541E;
	Tue,  3 Mar 2026 04:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772513217; cv=none; b=H6Mqmm3YT8ULqCABrGGC5PS8R7m5n2bA980N9Pu+hKfr9sLJRrucLLDvh89OjpO9nfbvPqC//N/aSKln7ZIHbcsUuFpv/LpPIAXHBn8zopab0htEuW8QrvV/sbwYJntUTfioYTUy75maF33fU4lRBZJxGOSYoQkfhx+QvsvCRU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772513217; c=relaxed/simple;
	bh=bqq+HE4FBe0fKsVqSm7v5/lJc9pFDuDowz8zZZkp54Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Mis2vT/UVUZ1w8CcKB73gvklX5xGTArspgrqWIYZftVxnE04PV9r5txqih2ODdzulpeqSMSmYdkf7Jcl9M5yqieF/hWetXuWnGd0sJbdMK62k72tlIF1EGisoRiRQYmkdV2ayADMouS9Yd20M9TAa2uRy3K/K9KyKPJSVSW4PbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwjAgncI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E04FC116C6;
	Tue,  3 Mar 2026 04:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772513217;
	bh=bqq+HE4FBe0fKsVqSm7v5/lJc9pFDuDowz8zZZkp54Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KwjAgncIblxLQfFjjsK6bj2NgBGLE5GGK4qN7QUQH2dvju7S6POP6WJ5Htc7JHA/e
	 8eCc1msP27KZ7GVbQc+2yO56QjlP2I1N+oIwRdMwKee6PqjPN4H8vboagwxSwezAT0
	 8ZBy1/YX5AZw9ywJFYgVErwhaLR/ooUDodyTv2CAKbF3/CxsHThZ4JhjA/tRVAg8h5
	 5nsmmKlg+YOFQptX8RYHEGClhoYHwY5Deq3Hr6+gmkLpOY4az7Z7dKBhR/L8Rv/F3J
	 Yaz5MfKZWx9xa5bjm5AMZRF4IydfTXhWbov6CjoU/zu2Vj0GmPceIu1D/UOjW6zo2x
	 BhR273ZQyZJGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E623809A80;
	Tue,  3 Mar 2026 04:47:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/9] net: sparx5: clean up probe/remove init
 and deinit paths
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177251321859.625663.7210895565494108353.git-patchwork-notify@kernel.org>
Date: Tue, 03 Mar 2026 04:46:58 +0000
References: <20260227-sparx5-init-deinit-v2-0-10ba54ccf005@microchip.com>
In-Reply-To: <20260227-sparx5-init-deinit-v2-0-10ba54ccf005@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Steen.Hegelund@microchip.com,
 UNGLinuxDriver@microchip.com, richardcochran@gmail.com,
 maxime.chevallier@bootlin.com, rmk+kernel@armlinux.org.uk,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: 6152A1E90F0
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
	TAGGED_FROM(0.00)[bounces-263037-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,gmail.com,bootlin.com,armlinux.org.uk,vger.kernel.org,lists.infradead.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Feb 2026 15:56:38 +0100 you wrote:
> This series refactors the sparx5 init and deinit code out of
> sparx5_start() and into probe(), adding proper per-subsystem cleanup
> labels and deinit functions.
> 
> Currently, the sparx5 driver initializes most subsystems inside
> sparx5_start(), which is called from probe(). This includes registering
> netdevs, starting worker threads for stats and MAC table polling,
> requesting PTP IRQs, and initializing VCAP. The function has grown to
> handle many unrelated subsystems, and has no granular error handling —
> it either succeeds entirely or returns an error, leaving cleanup to a
> single catch-all label in probe().
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/9] net: sparx5: move netdev and notifier block registration to probe
    https://git.kernel.org/netdev/net-next/c/b8909aad5b8d
  - [net-next,v2,2/9] net: sparx5: move VCAP initialization to probe
    https://git.kernel.org/netdev/net-next/c/3a95973e7c79
  - [net-next,v2,3/9] net: sparx5: move MAC table initialization and add deinit function
    https://git.kernel.org/netdev/net-next/c/13cb1b68842b
  - [net-next,v2,4/9] net: sparx5: move stats initialization and add deinit function
    https://git.kernel.org/netdev/net-next/c/e180067a03ca
  - [net-next,v2,5/9] net: sparx5: move calendar initialization to probe
    https://git.kernel.org/netdev/net-next/c/274182ff34fd
  - [net-next,v2,6/9] net: sparx5: move remaining init functions from start() to probe()
    https://git.kernel.org/netdev/net-next/c/cdc374359fe8
  - [net-next,v2,7/9] net: sparx5: move PTP IRQ handling out of sparx5_start()
    https://git.kernel.org/netdev/net-next/c/0432c60112b4
  - [net-next,v2,8/9] net: sparx5: move FDMA/XTR initialization out of sparx5_start()
    https://git.kernel.org/netdev/net-next/c/8b1e4a6747b8
  - [net-next,v2,9/9] net: sparx5: replace sparx5_start() with sparx5_forwarding_init()
    https://git.kernel.org/netdev/net-next/c/1e540c4d8f32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



