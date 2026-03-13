Return-Path: <netdev+bounces-267285-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SErfEMR7s2lmXAAAu9opvQ
	(envelope-from <netdev+bounces-267285-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:51:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CD54927CEE0
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 726013094FA2
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C8434D394;
	Fri, 13 Mar 2026 02:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMssmiyq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B1234AAF2;
	Fri, 13 Mar 2026 02:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773370226; cv=none; b=cFKbNkZJMTephdk1nb1hAlqEggEO5W6h1BxGKYReX1QPnalfZD3YHJ6r3Ug0j6hmZngAPek6NuLs1xoIPKITI0B6onAGl0LNjBVcgMOc21OP+bfEAsB5dRSuAfJIGmsyBZ9565bmB5hO0gcs36CfJm8bLCcgBa2BGR6klkNknqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773370226; c=relaxed/simple;
	bh=b16QUDTMAutuW/1R8w2lua3AGQTyBl8EQZ/4anXK4ng=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n/47bx77mXJ7oWeuXVKCfPeunZgDe/icI5UrHOL8cmSBaFIr6ztxCSEiKSyWYih5RvjBC+tzJib4DcnZUlngpOhTa/+E8qNakYwcYwsYgjCEn0p4AymdWALRAHcxLnsirijWYkl8fF307DaW9BdUk43VCiAo1dAEgaV5XAm8f8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMssmiyq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94010C4CEF7;
	Fri, 13 Mar 2026 02:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773370226;
	bh=b16QUDTMAutuW/1R8w2lua3AGQTyBl8EQZ/4anXK4ng=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mMssmiyq0wKip3x+rjow36JyXZk8qZOzXwvRXS+hEyEEHmk7TdWexrSnJHtB3hIfN
	 hi5ehVS+jHobGG9z0EavDW1cu+ygp0FpIOwGHKuGNNTR3a3saME6DbUARmunghFXZC
	 78a3rpQWwn9Pf9dt3r6GKvMtSLtuuwA6kUdSVUadChaUlMwgCPOBQ4WLWf1KGnA2QV
	 xrJcK3qTdXiz0QGBQhxfYrHh5c22MwDmOUOOt2QWqep0R+LW0FrviSj2W767KRQuQU
	 S7IKOTtvX9ME82be0pMp35YVKk1F+ag/3v0mMQvNtCanldVWmu6vo9gJJ64Osl1FBl
	 wKb4Vk9qi2Cmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CC53808200;
	Fri, 13 Mar 2026 02:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] qlcnic: update outdated comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177337022179.648356.12259222576794658612.git-patchwork-notify@kernel.org>
Date: Fri, 13 Mar 2026 02:50:21 +0000
References: <20260311133012.519-1-kexinsun@smail.nju.edu.cn>
In-Reply-To: <20260311133012.519-1-kexinsun@smail.nju.edu.cn>
To: Kexin Sun <kexinsun@smail.nju.edu.cn>
Cc: shshaikh@marvell.com, manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com,
 netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, julia.lawall@inria.fr, xutong.ma@inria.fr,
 yunbolyu@smu.edu.sg, ratnadiraw@smu.edu.sg
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267285-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CD54927CEE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Mar 2026 21:30:11 +0800 you wrote:
> The function pci_unmap_page() was a compatibility wrapper around
> dma_unmap_page(), and was removed by commit 7968778914e5 ("PCI:
> Remove the deprecated pci-dma-compat.h API"). Update the comment
> accordingly.
> 
> Assisted-by: unnamed:deepseek-v3.2 coccinelle
> Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
> 
> [...]

Here is the summary with links:
  - qlcnic: update outdated comment
    https://git.kernel.org/netdev/net-next/c/886d56099d94

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



