Return-Path: <netdev+bounces-300919-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9yjhNFNgOGrfbgcAu9opvQ
	(envelope-from <netdev+bounces-300919-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 00:06:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C666ABB35
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 00:06:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SXQOLWKk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300919-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300919-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44F373051A6B
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 22:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CD4372EDE;
	Sun, 21 Jun 2026 22:01:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C92232395;
	Sun, 21 Jun 2026 22:01:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782079285; cv=none; b=kSxrvoRr1DfZYawqJ0S4sFmISoUzZAi4HGaAfK5Vz5hFUEh/m87VeVxwEBdg+BIQCEieMpgJDpulgFIhWQ2QxgiJh1etbLgqluY5w5cgB924llEJuVs/i5eUhji/G3XhGACLbZj1+ydsvRI60Nsi/Xeozpa4Z3asXDH9mbC324o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782079285; c=relaxed/simple;
	bh=tDqn9iSZiaZWCPqpD4eq2xxQGviIZbFQ5fmVD+F/0z8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=vBRYL4DXdjKW+IroczfoPTmeTrabJTzkspo3DsHhwIlXpVjkU0hCtEBPlOUWnoKWGecWgDIEtg1lTNaMiAnlSqk3a/qkaemVKydscLSCL/wYIfG9423Ouh8k78jxLzD1Vre0a8m1QT8SMZsXw0b13gTbSq3rlcyzlbndE3U87U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXQOLWKk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DA01F00AC4;
	Sun, 21 Jun 2026 22:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782079272;
	bh=3BlpzMyBhSpluKhTievfvkXKBfJ0k8M6QzSAPwuH3DY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SXQOLWKk+6BVIqP/M4To1fOu7wF2pEKUu4iVVr9yGqCv9EXCUMfL5hO4c0Wbs+DGf
	 By2caDj4DohCgOj+kiLCBfjhFDzfRbYAMUeHtlYz1JDxj6SPU+4PHx+RC8qv3djhxe
	 ZypzePqVjUYteXBORJASJYpPZvMCuEJwRi2Hucw5K+OyfY+/AIX1Qhr9jqI1bHXwi2
	 aFTY1EqRrktRyUeU0YZAsW2RSzsy8UZrKqcHxsCTzttlLBXmlk49EYbBqdKUOc4+w2
	 JsuoKMDk/6fQCytl3wVF+zXbdqQf69G7clNwREc+jHVQ3PvcmpsjW0p5Hb6FtvyGS5
	 NJzhWaeDOnwsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D08F03AAA6EA;
	Sun, 21 Jun 2026 22:01:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] octeontx2-pf: Clear stats of all resources when freeing
 resources
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178207926350.516339.6540360928701267415.git-patchwork-notify@kernel.org>
Date: Sun, 21 Jun 2026 22:01:03 +0000
References: <1781636420-19816-2-git-send-email-sbhatta@marvell.com>
In-Reply-To: <1781636420-19816-2-git-send-email-sbhatta@marvell.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com, gakula@marvell.com,
 bbhushan2@marvell.com, rkannoth@marvell.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300919-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:sbhatta@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:gakula@marvell.com,m:bbhushan2@marvell.com,m:rkannoth@marvell.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,marvell.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 20C666ABB35

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Jun 2026 00:30:19 +0530 you wrote:
> When all MCS resources mapped to a PF are being freed then clear
> stats of all those resources too.
> 
> Fixes: 815debbbf7b5 ("octeontx2-pf: mcs: Clear stats before freeing resource")
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - octeontx2-pf: Clear stats of all resources when freeing resources
    https://git.kernel.org/netdev/net/c/fd4460721fb4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



