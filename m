Return-Path: <netdev+bounces-297413-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bBblN5zOKGrqJwMAu9opvQ
	(envelope-from <netdev+bounces-297413-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 04:40:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9826657A4
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 04:40:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ndG13QBh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297413-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-297413-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 30180301A4FD
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 02:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC3F278161;
	Wed, 10 Jun 2026 02:40:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9134418A92F;
	Wed, 10 Jun 2026 02:40:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781059222; cv=none; b=c4gwU7fNTjBumZqzQ9xBItsfZBFx+H5IA5de1ttrd7+1fY2BwvJSOmHoOFp5kpYoTEkcfNsjF0cCCxh3VtHCnAhCys1Hzh+jPtK0mitCjdHV9z6YEznel++mWrLjaIEWbLqI45h2QaNeNFTnmyq0hGukxq8LAQ+zDez0AKoSm6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781059222; c=relaxed/simple;
	bh=lIj8MK2N9N7srRtJLosWe/4cgLY8+xZkoOdBilgRNbU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GwlnQJojx6OldWj+uG2ucfQbbnwgY2+PmS38Td6KyghN0/s3AVVTUB53ffIX4k3tCyv2eO32u64FAWcZsUoQtu3dmpS++GRGpEsGcm+xU6gcOEKhmGtR7EGiVt3qEVzQdIK4Cd3ofTCNmyQ6Ew9UlHWrizySthjVkNqtr4iou4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndG13QBh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DFD51F00893;
	Wed, 10 Jun 2026 02:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781059221;
	bh=VUGlurW/KFurlvPVpYqfvt8cTRk0ttrU0x2vGArdzbs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ndG13QBhJSbDVbJlpB6w0+7o3g1WItdwpIeQGu3iReJla7oDaBkoZ7zP71EYKFwhG
	 SWxaDRBMhZsOKT0noBl5GN0nzNLOPBTATsteecIS0i5O1i4iRVBBsZ3Q7ntoHo7J/c
	 qlqiY3/c0uhrdrLTQAfyXCbbyFJ2RzgZlnOZGjhnbKnDPVtIZ0sZTi959sbd4bppO7
	 hZxM0Q9L8UGrF1Dpt7nzb+qGWybTUUlYx46ds/zoBzluEdaPbBBo62uc0qVwW8i0cO
	 bc653VgFz+FbPsT7ZpuiMmTAeuRHBUnLh5N0wPCznvrgALUOrl48N8jkw+88FL1WTY
	 UjjUvYaEIbwcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939BF3930A20;
	Wed, 10 Jun 2026 02:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v13 0/9] net: dsa: realtek: rtl8365mb: bridge
 offloading and VLAN support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178105921939.2803230.4599444523749741721.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 02:40:19 +0000
References: <20260606-realtek_forward-v13-0-b9e409687cbe@gmail.com>
In-Reply-To: <20260606-realtek_forward-v13-0-b9e409687cbe@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linusw@kernel.org, alsi@bang-olufsen.dk, yury.norov@gmail.com,
 linux@rasmusvillemoes.dk, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, namiltd@yahoo.com,
 abdulkader.alrezej@gmail.com, ynorov@nvidia.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org,yahoo.com,nvidia.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297413-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:luizluca@gmail.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:yury.norov@gmail.com,m:linux@rasmusvillemoes.dk,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:namiltd@yahoo.com,m:abdulkader.alrezej@gmail.com,m:ynorov@nvidia.com,m:yurynorov@gmail.com,m:abdulkaderalrezej@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA9826657A4

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 06 Jun 2026 05:29:24 -0300 you wrote:
> This series introduces bridge offloading, FDB management, and VLAN support
> for the Realtek rtl8365mb DSA switch driver. The primary goal is to
> enable hardware frame forwarding between bridge ports, reducing CPU
> overhead and providing advanced features like VLAN and FDB isolation.
> 
> Some of these patches are based on original work by Alvin Šipraga,
> subsequently adapted and updated for the current net-next state.
> 
> [...]

Here is the summary with links:
  - [net-next,v13,1/9] net: dsa: realtek: rtl8365mb: use ERR_PTR
    https://git.kernel.org/netdev/net-next/c/a543687227d8
  - [net-next,v13,2/9] net: dsa: realtek: rtl8365mb: reject unsupported topologies
    https://git.kernel.org/netdev/net-next/c/36c572fd60d6
  - [net-next,v13,3/9] net: dsa: realtek: rtl8365mb: use dsa helpers for port iteration
    https://git.kernel.org/netdev/net-next/c/51a4a22301b0
  - [net-next,v13,4/9] net: dsa: realtek: rtl8365mb: prepare for multiple source files
    https://git.kernel.org/netdev/net-next/c/0e692c27fe84
  - [net-next,v13,5/9] net: dsa: realtek: rtl8365mb: add table lookup interface
    https://git.kernel.org/netdev/net-next/c/fbafdd3b224a
  - [net-next,v13,6/9] net: dsa: realtek: rtl8365mb: add VLAN support
    https://git.kernel.org/netdev/net-next/c/9da2c8672f77
  - [net-next,v13,7/9] net: dsa: realtek: rtl8365mb: add FDB support
    https://git.kernel.org/netdev/net-next/c/336e3e4a1ab3
  - [net-next,v13,8/9] net: dsa: realtek: rtl8365mb: add port_bridge_{join,leave}
    https://git.kernel.org/netdev/net-next/c/183bd68b1fe1
  - [net-next,v13,9/9] net: dsa: realtek: rtl8365mb: add bridge port flags
    https://git.kernel.org/netdev/net-next/c/660a9e399ab0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



