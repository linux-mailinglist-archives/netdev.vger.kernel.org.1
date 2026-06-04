Return-Path: <netdev+bounces-294997-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vp2zN+PRIGrD8AAAu9opvQ
	(envelope-from <netdev+bounces-294997-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 03:16:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D41363C2C1
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 03:16:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HDOl492w;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294997-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294997-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 649B23049943
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 01:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D1F238D54;
	Thu,  4 Jun 2026 01:14:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561F825A357;
	Thu,  4 Jun 2026 01:14:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780535662; cv=none; b=gJYPKiUWT7TbvO0hVSIdMP/vEpBrWWRHte20/DlcKalzTb3/OnlFzk1ZeGWg1ICPdu5aVvaSpV9iTCwNP6DMuoqYasjWo4RkmUiTMZnzcDajDYn2g0e5hnYyjzajd6g+ExW9qxoZRSvmqSt7nnS6OoD47yPJD5BLRRZA4S2USl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780535662; c=relaxed/simple;
	bh=NQg4jidV7PH8QZHJhWFCrH0LaupOf2AFtMQpSzWKwhs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q8xJvIhJfDmNFsyaU08ziwB/2uGJlcRbU+k/q11U7o1O0fRr0lhtA9fgao549bDPxFlcnN9w7YQ4kZKGGGzVQwUpdqxZviVpBSNTE5ypiEB+pYa546GIgIgQseWLOeDVqV0+eTfcujRHMiK7LZsAF9cSMUe0RwMexCeUP7IbYK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDOl492w; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F6A1F00893;
	Thu,  4 Jun 2026 01:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780535660;
	bh=3QCN68GJKbKUwT57lIbckUrsBCZuL2jHfiSLycLrtGc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HDOl492wZcnbpARFubHO7ip64BRJ132U1gs6BQk+JpsFm/2N7Vuci2Jf8mhVEqFlH
	 w85jL0qKwYHsm5iQqljizbVf5eOhYX1jVE2UUGxQc+C78aEzoclfsoUqc3eVoLGl0s
	 jA3GZni3UCSy80YWeVlCM0SqyLwyebZPMsF3Uky6j40ApFoWgOEeef4mQb1QqaYN9J
	 zGmmqnMaIY6WBzcz3Xhv3/pmxYgoFTeNfcr1aDGtA5kfs1nInbZWip5YYT/OL8G0AX
	 rob7bRZ50vtZQNi/POjCwVVqj/AA7zDbX1VbCewL9pr2o3nsRIkbBOAXGDVeE7Wp5y
	 WBpu6qNNt6dqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5696D39308DD;
	Thu,  4 Jun 2026 01:14:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v9 0/3] net: sfp: extend SMBus support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178053566188.2042071.12065721387536755015.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 01:14:21 +0000
References: <20260528205242.971410-1-jelonek.jonas@gmail.com>
In-Reply-To: <20260528205242.971410-1-jelonek.jonas@gmail.com>
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bjorn@mork.no, horms@kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294997-lists,netdev=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS(0.00)[m:jelonek.jonas@gmail.com,m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bjorn@mork.no,m:horms@kernel.org,m:jelonekjonas@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,vger.kernel.org,mork.no];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D41363C2C1

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 May 2026 20:52:39 +0000 you wrote:
> Today, the SFP driver only drives I2C adapters that advertise full
> I2C_FUNC_I2C, or SMBus-only adapters via single-byte transfers (with
> hwmon disabled). Several SoCs ship I2C/SMBus-only controllers that
> support more than just byte access -- e.g. word and I2C block -- and
> have SFP cages wired to them. Today, those adapters either work
> poorly or not at all.
> 
> [...]

Here is the summary with links:
  - [net-next,v9,1/3] net: sfp: initialize i2c_block_size at adapter configure time
    https://git.kernel.org/netdev/net/c/56d088551449
  - [net-next,v9,2/3] net: sfp: apply I2C adapter quirks to limit block size
    (no matching commit)
  - [net-next,v9,3/3] net: sfp: extend SMBus support
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



