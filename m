Return-Path: <netdev+bounces-301496-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gMvTL/D/OmptOAgAu9opvQ
	(envelope-from <netdev+bounces-301496-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 23:51:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C096BA4F6
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 23:51:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=K1aVNYNx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301496-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301496-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 717AE3089D41
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 21:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B536D3B47FB;
	Tue, 23 Jun 2026 21:50:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07173B19AC;
	Tue, 23 Jun 2026 21:50:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782251430; cv=none; b=WDkP/0b6iQRBX1e/a+0H73Z7HZPrJx2Jnwpb4CZr3mDfPbmiQiF9duK/aFP32HRPHGFPIvRjLzLVtPV8Iw55+NLJAKV5nWxVFJ+Y2bfh4+pzJPMGx+LNLpQ5k57LLlk1DzU6ThXpdcIEZfVS6DSBTyRyHcFLynVIiRVo4hSbYV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782251430; c=relaxed/simple;
	bh=QFaoAGKmu+8tZ4o7d8snjpPzQdqT+GA58dwrd+aLDlQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iMZBjni8AHkjheU2J2t7lN1lxMVoN7EgUWlUweHsacPkyQtHPmsoK7AmXUTdf4zPRkvQc6/cxhdZtroTLuKMR2iOq7fmk9iwtUVWguv6LIgK9sMwR2FDvrwwB7XxG0QG8cWADtohWkgrvYdFBaVg6u8yZtcspLw7DjRYLqldctk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1aVNYNx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712271F000E9;
	Tue, 23 Jun 2026 21:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782251429;
	bh=+LXSocJl1DkUecLpKUrBX/5IU8myxKdn4oCv6XfckMg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=K1aVNYNxSseuSmNJu3SIiuKdy9KPhkniusTgjlTF1i9b6Cy7e7vBDCuq/g5ciPwf1
	 GM56/nloS2qyhhPo9txQEeMbWecUnD6ea8RJgfRX36ZTPIrUQPlVR05rwdnZxnsGrv
	 ytfVgMYhGS180l2MIiL6QEnWtFDbjPNmBfmrITAj805s6JtnVAfMxyMlqRWGN7A57p
	 4vf76bMfM/0lJ2/37X5l7j9PQW085LN3i/cDRrZxKdYEamZU+cwT8h6204WDpEj8aA
	 I+Hvu7huQnDp8KAu28FFr53eyfmzRL/j6LXbUW27F8DUXxtvKigfXmnLpnqbqqtsLB
	 meRSLNOaq+KWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198D9393101D;
	Tue, 23 Jun 2026 21:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ti: icssg: Fix XSK zero copy TX during
 application wakeup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178225141876.2433118.2854305018338051876.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jun 2026 21:50:18 +0000
References: <20260618100348.2209907-1-m-malladi@ti.com>
In-Reply-To: <20260618100348.2209907-1-m-malladi@ti.com>
To: Meghana Malladi <m-malladi@ti.com>
Cc: diogo.ivo@siemens.com, vadim.fedorenko@linux.dev, haokexin@gmail.com,
 devnexen@gmail.com, horms@kernel.org, jacob.e.keller@intel.com,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com, vigneshr@ti.com,
 rogerq@kernel.org, danishanwar@ti.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[siemens.com,linux.dev,gmail.com,kernel.org,intel.com,redhat.com,google.com,davemloft.net,lunn.ch,vger.kernel.org,lists.infradead.org,ti.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301496-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:m-malladi@ti.com,m:diogo.ivo@siemens.com,m:vadim.fedorenko@linux.dev,m:haokexin@gmail.com,m:devnexen@gmail.com,m:horms@kernel.org,m:jacob.e.keller@intel.com,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:srk@ti.com,m:vigneshr@ti.com,m:rogerq@kernel.org,m:danishanwar@ti.com,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 09C096BA4F6

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Jun 2026 15:33:48 +0530 you wrote:
> emac_xsk_xmit_zc() handles tx xmit for zero copy and gets called
> inside napi context. User application wakes up the kernel while
> initiating the transmit which triggers napi to start processing
> the tx packets. The num_tx check inside emac_tx_complete_packets()
> returns early if no packet transfer happen hindering the call
> to emac_xsk_xmit_zc(). Remove this check to let application
> wakeup initiate zero copy xmit traffic.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ti: icssg: Fix XSK zero copy TX during application wakeup
    https://git.kernel.org/netdev/net/c/d95ea4bc09e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



