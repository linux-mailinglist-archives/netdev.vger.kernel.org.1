Return-Path: <netdev+bounces-295015-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DNicBXPcIGpd8gAAu9opvQ
	(envelope-from <netdev+bounces-295015-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 04:01:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 738AB63C557
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 04:01:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=J+zho631;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295015-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295015-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCC6B3058881
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 02:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF0F2DB7B8;
	Thu,  4 Jun 2026 02:00:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35CF2DECDF;
	Thu,  4 Jun 2026 02:00:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780538416; cv=none; b=BKjw3KUR5lzEtKVYpPJ3ABEtZ9ks/SikX3SnbQRes29qp42BNmMO0yWiHAWsqDBtcBFtaARFQVeGV4rbqFOWb1nZpLkgod//w3UcaZUe85g2Mk66yVa8/lP1/yYKiObrEOYYtzlO2kJ/Gh5Oq2beDaZSzIhte8SgJDE9DeKSivs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780538416; c=relaxed/simple;
	bh=j5C9fCliWd49VtDuAMk+Ux8kmPBS/14ZGa6IY19k5gI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Kv7+G0j/Ld97i0/E50x70ThyDmEgLvzqpKVrVA1ljKmO60sDqIAtmPCwTCIefgfng3/ttRNo7Dk1t2NCnb05MVPJ6QM0QcEbF2GFQLjbAqaFP/uauRl5OIDuaIeIwBTq4JDuFW+aHBUF0LVI84FLwy6Cr/3fvreZfg4B5B4Wtcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+zho631; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BFC51F00893;
	Thu,  4 Jun 2026 02:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780538415;
	bh=RdUSp4/k7vcFjxr4tpxGwAhNlKCf27nZcmnEILmB25k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=J+zho631bm+qkeelPvqUR+kcRmhOl+qeN37/CejZPQfCQ8g8RgDel8fQGsbQNQITt
	 /ZfvmsIiIg66TYXIMLBB3vyjwXydMdrRkca3ZodXQ73esMeErgQQn33lcvW0UwD34E
	 uSxdM9FPW8W3yiChZbDfLx0e9AzWAluAywrgu6Rp9siiYm89yhRkdG3dsUwB5tdJgH
	 +tcd+9LcdKBoUw73vfd20uJciUaOvaNAKnMmO5p3AWsc2u+k3v8dGlqT07tIsVGwrj
	 ySwKW8VDUNGB7SVQh7B9aD9SSGq55jNleyCFPzYRYZ4W7I8K2lU3Hofd2KbZc5WmJi
	 3hJ45+zNAfsOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A1939308E0;
	Thu,  4 Jun 2026 02:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-pf: Fix NDC sync operation errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178053841639.2201066.13935205117548909147.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 02:00:16 +0000
References: <1780054677-17249-1-git-send-email-sbhatta@marvell.com>
In-Reply-To: <1780054677-17249-1-git-send-email-sbhatta@marvell.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com, gakula@marvell.com,
 bbhushan2@marvell.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-295015-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sbhatta@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:gakula@marvell.com,m:bbhushan2@marvell.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,marvell.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 738AB63C557

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 May 2026 17:07:57 +0530 you wrote:
> From: Geetha sowjanya <gakula@marvell.com>
> 
> On system reboot "rvu_nicpf 0002:03:00.0: NDC sync operation failed"
> error messages are shown, even if the operations is successful.
> This is due to wrong if error check in ndc_syc() function.
> 
> Fixes: 42c45ac1419c ("octeontx2-af: Sync NIX and NPA contexts from NDC to LLC/DRAM")
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-pf: Fix NDC sync operation errors
    https://git.kernel.org/netdev/net/c/a910fb8f7b9e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



