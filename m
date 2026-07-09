Return-Path: <netdev+bounces-306165-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WS9FER54T2ouhQIAu9opvQ
	(envelope-from <netdev+bounces-306165-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:29:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7789A72F99F
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:29:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KantdWfS;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306165-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306165-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD50E31037C0
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 10:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF6F40BCD4;
	Thu,  9 Jul 2026 10:10:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1608540BCB7;
	Thu,  9 Jul 2026 10:10:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591829; cv=none; b=Qbq5FZjrDF+tUoSii8c6CSgVGQdzYLAiAqVTLKIjrjPhGLsdeVmi9um5M6o2/IDES0tjvCc6XowmWtq7f0BvP6INj5QZF9t+zXjnuVUoYo6exakSiqZdD2+pcEnfREitYdxZhQobPoYJL2x/El2YyqeGaDnPkUX/1zALAuW0f3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591829; c=relaxed/simple;
	bh=i/FK8fPLitdoE553p1GwMvAyliy17XwACOghFp/tVrg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YLqtKcaojBlxwuiGR2pnSvXSIJACknrKssjBaz7D6CO3fAiD8fNRQruLnfRotasgFNPLeheBHcQstLAhBwjF16t8b57gNveGz14XDLw5nlAZTW/mqvz2/WJESf/F6MEH1lrh00uo8PyqzWDdo7sGjlhz/EyVgsCvXpjkwoW7zJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KantdWfS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B245F1F000E9;
	Thu,  9 Jul 2026 10:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783591827;
	bh=YK07+fqKaXgivIvgLDXYKgRiNA/xEteeQmg8DFg22/w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KantdWfSmKx0mcOgjYanlcb7am2S1JWJhgh6WE/5/1PtEAkmQrC+9Nuswo8AAalHL
	 aqUXw6+jknU6ON1ffE8mZs6eMEFffdSuoktnKyAbfzdV5XLX4j3JcV4PMYmy5HGG0G
	 2F60SGHBubtsQT4ZiHCJzVkjsdlKpRbKPiZJYaW/iUl9CGWcR3u4u6BgBHb3R822xM
	 bi0B1+jCFaMpeuEyXINuzPt8M1VUM0j99+4pdxvcp73TIxaGFfazDJ8ursYUAHPKrW
	 6g2EVfMk6BxRSkgJ2LlD48v1yb07gix9G9XkcIR3M84sT4L30v/VCMgUWGytR/9ieZ
	 mtO51lyrre20Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93939393A964;
	Thu,  9 Jul 2026 10:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/1] octeontx2-af: Bug fixes for VF RX mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178359180614.3386943.3763503743823915105.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jul 2026 10:10:06 +0000
References: <20260702045616.3002773-1-nshettyj@marvell.com>
In-Reply-To: <20260702045616.3002773-1-nshettyj@marvell.com>
To: Nitin Shetty J <nshettyj@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 hkelam@marvell.com, sbhatta@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 naveenm@marvell.com, rkannoth@marvell.com, kirankumark@marvell.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306165-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:nshettyj@marvell.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:naveenm@marvell.com,m:rkannoth@marvell.com,m:kirankumark@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,marvell.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7789A72F99F

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 2 Jul 2026 10:26:15 +0530 you wrote:
> From: Kiran Kumar K <kirankumark@marvell.com>
> 
> Hello,
> 
> The patch resolves an issue where a VF changing its interface
> state could inadvertently delete the RX promiscuous and all-multicast
> MCAM rules belonging to the host PF.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/1] octeontx2-af: fix VF bringup affecting PF promiscuous state
    https://git.kernel.org/netdev/net/c/fabb881df322

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



