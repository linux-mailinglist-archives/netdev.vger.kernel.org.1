Return-Path: <netdev+bounces-261662-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFnEL0/4oGmboQQAu9opvQ
	(envelope-from <netdev+bounces-261662-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 02:50:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6566C1B1A0F
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 02:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 965163012BFC
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 01:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A24B26E6F9;
	Fri, 27 Feb 2026 01:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRGCYSXO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D761D5151;
	Fri, 27 Feb 2026 01:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772157002; cv=none; b=pVwP4sJrSrbff0ERterp2nxwHZx/9Yb619746bhvl1ivYxWFeCBXuufrjdlGDn79oDiaA+Nj9TG4eVoRq/5zFQ9sZk744NdyMlr3yGS9W1r+FPCAb/nbt64iXzYQQAKUrOMQso8r5Q1EY45iSKCv6OXR1EkbYGMDz1QddvkOuos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772157002; c=relaxed/simple;
	bh=eVMCoHiNhy887YblJvrCcX9NSgn0+7gqukZmBKq5uC4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WgB9H1PJO2ssvfrSeiSJLnSAWtVPJ06qs0QysZ8Rg2vgN3BOK2plvSHhRfYv72m2QgtXdaZvw4uPlO6ecp9sQtr0EWPOrYS/6ChT2WVbckvE14zGvM9UpGlSvzSopkyJLx6+coq/0DabYJDFmzqCwVUIxDghpQdq9IUkD22+W74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRGCYSXO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF67C116C6;
	Fri, 27 Feb 2026 01:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772157002;
	bh=eVMCoHiNhy887YblJvrCcX9NSgn0+7gqukZmBKq5uC4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oRGCYSXOeyHoIquox+oiVBeYrVpOCjNgoid5dV6PIf58uLysU03DOrqFGih1e0NxJ
	 UxeFkcD8Hx//m2LiHwOWh0JJ8SKWuQzYtfKGEXbIskBM4hsXVrefud/uwWN6uAIOgp
	 VOi7Nu1QdzmqezE1hoF3PNdC+IfEvbYNxRARY3qrsZA6HnprFG0wH7fwznc96Es605
	 1AHiPt19WDkUu+b+8mlW/ZccpkuLpb9nHuufA6wEJm7wjvjR++xgtICzsBJH2mThvi
	 WVsGbpsMlqZv1oc3DmwwqOlJ8MQ/83SjPkr+kj5Tgn+ssr+EVngF2JZ/UI4YHCEMZ2
	 937hiCEcQNVcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0FC393109B;
	Fri, 27 Feb 2026 01:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] docs: net: document neigh gc_interval sysctl
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177215700661.1935486.9832673851361345994.git-patchwork-notify@kernel.org>
Date: Fri, 27 Feb 2026 01:50:06 +0000
References: <20260225095822.44050-1-g.goller@proxmox.com>
In-Reply-To: <20260225095822.44050-1-g.goller@proxmox.com>
To: Gabriel Goller <g.goller@proxmox.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-261662-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,proxmox.com:email]
X-Rspamd-Queue-Id: 6566C1B1A0F
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Feb 2026 10:58:10 +0100 you wrote:
> Add entry for the neigh/default/gc_interval sysctl. This sysctl is
> unused since kernel v2.6.8.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
> ---
>  Documentation/networking/ip-sysctl.rst | 7 +++++++
>  1 file changed, 7 insertions(+)

Here is the summary with links:
  - [net-next] docs: net: document neigh gc_interval sysctl
    https://git.kernel.org/netdev/net-next/c/d68d21ea6b29

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



