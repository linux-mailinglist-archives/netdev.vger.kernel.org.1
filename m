Return-Path: <netdev+bounces-298810-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XnygFIiPLGoASwQAu9opvQ
	(envelope-from <netdev+bounces-298810-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:00:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FCE67CF3E
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:00:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=kernel.org header.s=k20260515 header.b=nJPgxl8F;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298810-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298810-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=reject ("signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8D1E30DF29A
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 23:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB293A9630;
	Fri, 12 Jun 2026 23:00:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA1B324716;
	Fri, 12 Jun 2026 23:00:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781305213; cv=none; b=epK5GH9HOR7RrUzf3rqIJA+64OIP4pydrzA7qy7i8AvvHXIfb/je0/fhBKUT2QtiDrYNkH3QeEG4LI62XbmV8FLmaEvW2Zhh8HwbFCz2ChaRRv75+DuTtyxt7ikhtjbT8Tul2ymrTc+nkaTQKxGtfL8x79RhPRqWpOaosqKq/yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781305213; c=relaxed/simple;
	bh=ckIpLdfffslJHpLZX9WpHTw7HmvnQKTHrWp+Cw0oqaE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nQYADd00PdsC/oMIIGOeBJByouWuGPzcUUxZykabacZVZsjeRQoZXrfPsocic8zGBGODvR0UhRvKJf/Msocpsx7nKPYFckh8N9K94/U1fv4ejIlz2nVOyGkqBdh62shSEDxiD23mZi0AwWtK3mhdEt6tPkFQq9vt3FwU8LHw2Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJPgxl8F; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B329F1F000E9;
	Fri, 12 Jun 2026 23:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781305211;
	bh=KPPsE6Mq7X7Jv8wcIcvGg54GWecAH3/fdAe6Pu+nlOs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nJPgxl8FGa1RL+UydA4NG2Qxgq6ZEgO7UU1u3BgFBkMPOFyQHgDjWD+K8Bwv7JsON
	 kpyHFg1GLaG9Sf/4NN0zHjkqwfHrXbpS6eVM4EJecqsXKaeDSax2Tkh2QYjEkbGowo
	 bIcoYkKmr7tKKyJOTDHwNHESSdaf84eIjqRM1HwqX0pOz2T2DQolb57I+piLbLtrD8
	 IKXZSbDq9M4jiILMPF3hoHk2vhhNDgePc8a7gfajML13YvltyvBpm/9ahru5VdXRCa
	 PqfMWzwW6dZ1HuAE3M85XoOqVSSgvUZlSK+M+Xw6m10WjtZOPEFE6tcHJhHSx85ncK
	 CvjE2RN4ZMvRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939ED39E9600;
	Fri, 12 Jun 2026 23:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: stmmac: xgmac2: disable RBUE in default RX
 interrupt
 mask
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178130520813.1282281.6129214120774000716.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jun 2026 23:00:08 +0000
References: 
 <20260609121703.9736-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
In-Reply-To: 
 <20260609121703.9736-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Nazle@codeaurora.org, Asmade@codeaurora.org,
	Muhammad Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 rmk+kernel@armlinux.org.uk, maxime.chevallier@bootlin.com,
 Jose.Abreu@synopsys.com, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,synopsys.com];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20260515];
	TAGGED_FROM(0.00)[bounces-298810-lists,netdev=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS(0.00)[m:Nazle@codeaurora.org,m:Asmade@codeaurora.org,m:muhammad.nazim.amirul.nazle.asmade@altera.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:Jose.Abreu@synopsys.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:-];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B1FCE67CF3E

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Jun 2026 05:17:03 -0700 you wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> Enabling the RX Buffer Unavailable (RBUE) interrupt is counterproductive
> and can trigger a MAC interrupt storm under heavy RX pressure. When the
> DMA runs out of RX descriptors it fires RBUE continuously until software
> refills the ring.
> 
> [...]

Here is the summary with links:
  - [v3] net: stmmac: xgmac2: disable RBUE in default RX interrupt mask
    https://git.kernel.org/netdev/net-next/c/d3265c19b35d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



