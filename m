Return-Path: <netdev+bounces-266422-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJPHI7fTsGmLnQIAu9opvQ
	(envelope-from <netdev+bounces-266422-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 03:30:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C5425AF8E
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 03:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7661A3064F3F
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 02:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F7D3164D6;
	Wed, 11 Mar 2026 02:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9KyyTmQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84662D73B9;
	Wed, 11 Mar 2026 02:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773196212; cv=none; b=HK0+F44C6XCQfK31K9Swrh60vkKtJ1107JF846yaFij6I9tAjzKpX/cuBapA/QcH/B6cTBXSAXalTWuGZlz4sfAhwDyp7SFskik3H4+t9TNSP9f6dLDQBa9EGHuOY8q7VCjg7WIBFyAru3pmuZDKtWHyunFgnAYQaOISJ+0vus0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773196212; c=relaxed/simple;
	bh=/mhdTkWcFYzfhmabe4wdOfcjP4DM+L6htZA3voec/MM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FaVKHvnu4dBPd0ZH0BM9b7Y5eOLJaHoRltI1bGNqbIgMOrsKiXisr8lCzOvFsF9FxI85VQH1AIp9k8pQHoLW3yDZJ9DOjgfGNAoDdX3hQGrFc8RqouE4O0TP2dW7BPHzMqshTG1EcMRfZNISiOypf7ZbGdqXcfVnA8f7zE/SC38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9KyyTmQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C44C19423;
	Wed, 11 Mar 2026 02:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773196211;
	bh=/mhdTkWcFYzfhmabe4wdOfcjP4DM+L6htZA3voec/MM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b9KyyTmQRKi3wypiAFEfMxmT3t//XKlohjJ0qppXibViwBAt5j7RrOjyBEVEHdTEB
	 EoebxEX1K5DF330tjf6X9owHEYqNuKI6AxvADT559SU4r8a+WubJWKuUPeOLnkJvVQ
	 M9eq+EtPY5SXk98XQ6X+aZsPq2rW1uLaXN7KRxWWJftUd/+KWcf/q5JvEQ6fzGPXuq
	 s+WN5BGvhLT1Qdc12R6Y51fNhEa3hGvF/Srwuyry4vcvQxDYssnC0U7bikkwp+FJpL
	 mZQF+C6KNK66jXcKfO1BmrAMxb0Y8hZ+1gymsYsKbR0IFBWiiymNdGgV0U6gJMmQKQ
	 xOBWvDll4YZAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FEDA3808200;
	Wed, 11 Mar 2026 02:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: mxl862xx: don't set user_mii_bus
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177319620777.3011849.7918373050266861971.git-patchwork-notify@kernel.org>
Date: Wed, 11 Mar 2026 02:30:07 +0000
References: 
 <0f0df310fd8cab57e0e5e3d0831dd057fd05bcd5.1773103271.git.daniel@makrotopia.org>
In-Reply-To: 
 <0f0df310fd8cab57e0e5e3d0831dd057fd05bcd5.1773103271.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: E0C5425AF8E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266422-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Mar 2026 00:41:56 +0000 you wrote:
> The PHY addresses in the MII bus are not equal to the port addresses,
> so the bus cannot be assigned as user_mii_bus. Falling back on the
> user_mii_bus in case a PHY isn't declared in device tree will result in
> using the wrong (in this case: off-by-+1) PHY.
> Remove the wrong assignment.
> 
> Fixes: 23794bec1cb60 ("net: dsa: add basic initial driver for MxL862xx switches")
> Suggested-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: mxl862xx: don't set user_mii_bus
    https://git.kernel.org/netdev/net/c/f441b489cc66

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



