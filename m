Return-Path: <netdev+bounces-274340-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBolEKrczWmliQYAu9opvQ
	(envelope-from <netdev+bounces-274340-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 05:04:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A27D0382EF3
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 05:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F03AF3064E20
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 03:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B53355F5C;
	Thu,  2 Apr 2026 03:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERMhb8fv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04C6355057;
	Thu,  2 Apr 2026 03:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775098829; cv=none; b=J2cd7T3AHEM86hph74Y85otrDmaXAsZoGBy4FsG7PC2rt6vmo1Qx00Tl3TV0e8EFNihggT4SmmzV+I1Vb7iGNDXfkKZy8xXKArMGsxGfPIk4Se5XvFuRx+0MRvUcrW0MhveRc5aN6QSoiFRkCHEqVbOBHNt0BEzV3mz3j1+VJnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775098829; c=relaxed/simple;
	bh=5NKIqcecnLtsnKn0cxi0SwUoFKRhC0G+JRcQ2rsql8A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DZRQ5rAvh/IMPzcFzK8lB8iqO2ziu2G7lEiuf8Trbs6pn+ONBlmb/Rz1tn8HO3M7VDcLBBBlo0mK4mXaWfQ9NOkEVTL7kbQqpHpFr2thO7X1pouytoKLYzSs1UCum15J4i6Y+7ulGmEehFTpEbkcq+65gRWm5o+Cg0KWILw7xbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERMhb8fv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E60EC2BCAF;
	Thu,  2 Apr 2026 03:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775098829;
	bh=5NKIqcecnLtsnKn0cxi0SwUoFKRhC0G+JRcQ2rsql8A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ERMhb8fvpKal0dBLdrSN45dhZxUMyQF7o6KNTtWej9t123iHQD5T67iPtkBVXONvW
	 hAc7NYJIKkFLNmMXZngjMXazCOv4nd5f6aqmtMV3mqXt/XKyYqx6JGHQL4QBm3GUt1
	 48pvXLabE54gy1zVJDSWEBjnrtL7Kly/dtmyZnmfHPfTYy6xOLEIjkIU71t91HE01w
	 1Fk3pj6hIgTeBh58dW+Vo0yWYo1C4CW2VOKMSADb1n4ebzyHh3YuyYVhGkV7rZifsA
	 vaY/Y04hakAcfqgzneWoBAJIkUCwvjD8utDeVOQ+mHsw1icBEDnKqovWy4YQp2xQ0s
	 3Fjhp1ZyaOmXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD9B3808203;
	Thu,  2 Apr 2026 03:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] net: macb: fix clk handling on PCI glue driver
 removal
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177509881178.3966658.17912738150226737431.git-patchwork-notify@kernel.org>
Date: Thu, 02 Apr 2026 03:00:11 +0000
References: <20260330184542.626619-1-pchelkin@ispras.ru>
In-Reply-To: <20260330184542.626619-1-pchelkin@ispras.ru>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 theo.lebrun@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ztong0001@gmail.com,
 bfolta@cadence.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274340-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[microchip.com,tuxon.dev,bootlin.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,cadence.com,vger.kernel.org,linuxtesting.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A27D0382EF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Mar 2026 21:45:40 +0300 you wrote:
> platform_device_unregister() may still want to use the registered clks
> during runtime resume callback.
> 
> Note that there is a commit d82d5303c4c5 ("net: macb: fix use after free
> on rmmod") that addressed the similar problem of clk vs platform device
> unregistration but just moved the bug to another place.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: macb: fix clk handling on PCI glue driver removal
    https://git.kernel.org/netdev/net/c/ce8fe5287b87
  - [net,2/2] net: macb: properly unregister fixed rate clocks
    https://git.kernel.org/netdev/net/c/f0f367a4f459

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



