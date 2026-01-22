Return-Path: <netdev+bounces-252197-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCt2GiijcWmgKQAAu9opvQ
	(envelope-from <netdev+bounces-252197-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 05:10:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BE8619DE
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 05:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A5BA34ED29A
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E2A3385B5;
	Thu, 22 Jan 2026 04:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="suxncde7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC28296BBB;
	Thu, 22 Jan 2026 04:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769055010; cv=none; b=IjxToZQEeNU4ybuvoiALqV/wIpYe2On/uqkdJkALywqQAadu6Ki7NzFWZSO9fQsRsi7BRlIwFuYIOpLXKczGl5p9eMV7EPOsS/kF11Uqv4Is2qd59k/dW+bYYNND93yV9wqOE7OLMpuBM5g39N5bDXve6RtCEpHsAB8VIUgWv8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769055010; c=relaxed/simple;
	bh=ofP1gtLiqq1eTObDexbFNR0ZvruNYC4IYExlkuReqX8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZyVl2pFjnY2jdTEW8N4GSNk/149q9jdodb1hXsozJjauaskuoR8RhLzKuy5MrduuArqIqCNbC+cOMAf+yISINtJYRQt5K3WkitobG/Vc3ALyYfpgfWm9269MeTgFjK5rnPrU1YZ3mwScxbz0HA08VUQwjAu8vMXxZGfcXSPxOEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=suxncde7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A2AC116C6;
	Thu, 22 Jan 2026 04:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769055009;
	bh=ofP1gtLiqq1eTObDexbFNR0ZvruNYC4IYExlkuReqX8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=suxncde7DILcjPCLzvEb2KXoGjOpkBnPB1ty2yQRKP1NSEqCZ/jzaCwnNTiehRUrM
	 5tWrEZzEaP95w2oWTG+aOH4p3iC4nmyjIKoa+XjWjBMWewr4oT1V6xelY57Slg6bQW
	 n/XjCw2IkuIcJlYSfRWDNpneqVnQ2lCqmxDy3MZnExQ79inaBJjVZHEB/ot6CyKhUv
	 rTFSBRGpFbLoJd+eyx1BwXKdimgQvbiyJKH5RwFHJWOx/NFfdsg0my2zOz9ypUg2xf
	 hs7SM1lXFvoDho/hqWM/FOyRIFT0XqiR4dIQJ5VeXzIzw5l1elD3qzp3QFeGR1SQ7P
	 gKlPd8K53kFhg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BB2C3808200;
	Thu, 22 Jan 2026 04:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: pcs: pcs-mtk-lynxi: report in-band capability
 for
 2500Base-X
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176905500636.1552379.14340282395835713572.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jan 2026 04:10:06 +0000
References: 
 <b1cf26157b63fee838be09ae810497fb22fd8104.1768961746.git.daniel@makrotopia.org>
In-Reply-To: 
 <b1cf26157b63fee838be09ae810497fb22fd8104.1768961746.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: lynxis@fe80.eu, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, axel@gembe.net, Josh.Bendavid@cern.ch
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FREEMAIL_CC(0.00)[fe80.eu,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,vger.kernel.org,lists.infradead.org,gembe.net,cern.ch];
	TAGGED_FROM(0.00)[bounces-252197-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: C7BE8619DE
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Jan 2026 02:23:17 +0000 you wrote:
> It turns out that 2500Base-X actually works fine with in-band status on
> MediaTek's LynxI PCS -- I wrongly concluded it didn't because it is
> broken in all the copper SFP modules and GPON sticks I used for testing.
> 
> Hence report LINK_INBAND_ENABLE also for 2500Base-X mode.
> 
> This reverts most of commit a003c38d9bbb ("net: pcs: pcs-mtk-lynxi:
> correctly report in-band status capabilities").
> 
> [...]

Here is the summary with links:
  - [net] net: pcs: pcs-mtk-lynxi: report in-band capability for 2500Base-X
    https://git.kernel.org/netdev/net/c/e8ca461f7d19

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



