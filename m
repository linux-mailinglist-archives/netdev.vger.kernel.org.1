Return-Path: <netdev+bounces-264439-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNVfNaacqWnGAwEAu9opvQ
	(envelope-from <netdev+bounces-264439-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:09:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9D121433D
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6D55430CED57
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 14:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C970D3A9D8E;
	Thu,  5 Mar 2026 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SP9Q5uyz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F013A7F4F;
	Thu,  5 Mar 2026 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772722205; cv=none; b=pzfIf5V/HdCPNAYSQQdRhbYTvhW+wLE8uSG+uWGiBDBCGgDtvGFMuvuyNSkh0mAA0I52xQWzUG6F+L07gazzwMo7GmLoaGIwlZFidY0woHF4sfIT5KZ9zfHZQA4XVy42fDTSwa0RKOThOSCzrowV7+mRHtAEYOjGi55Cy8OwZbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772722205; c=relaxed/simple;
	bh=/WZhfj/29xuJ8osr61NntsurluVSN8see7f/hVhr8Co=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UsACsMrj9okHE6QjFLhKzgpFQQeXM36dd2sIX8EXBL1uS8SESvgRawV2JO5tRZB/7sE1ViLFqWyV+N6VQwGehcHyNziYhrn9T8F1a/Xdw3dpuvoPumoRIIJBcTgh2ju2DXg02crVW0D2FzRQfdnzqnuJiTwUyKnDc7kyuywW0zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SP9Q5uyz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC36C116C6;
	Thu,  5 Mar 2026 14:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772722205;
	bh=/WZhfj/29xuJ8osr61NntsurluVSN8see7f/hVhr8Co=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SP9Q5uyzcmI8WcYuzR/Z8kBFrPNZ6Uy5on/4zN7Z3Copa0y37o6bxt9XelVOJsyjt
	 8MxWnKFYpmaMIUQu/9YIFMDzeX6ybkG2q5gTIXFiZnGY+bMorwnnDuSYCK//qFTnoF
	 SPlYrKUE9En4fH4dNPVurX1VdnYFeLrDQkhxiXVMnyp1gjOV/i/W0b4v7nNpmiaPRD
	 8n892+bsTNtCsuQ23HAphMmcQliInVzJ+eCdjBb7D5vuzDB3mN64E1Swiq70q3xJnS
	 PnWTgkHnWTmPv7u6+CIpcYMfgq//srGhQwITKfUPFOxomBc3rhw3ImS8Uz0PqfrGds
	 Ttelth+aqwUOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EC73808200;
	Thu,  5 Mar 2026 14:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ethernet: mtk_eth_soc: Reset prog ptr to
 old_prog in case of error in mtk_xdp_setup()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177272220555.3153977.11048346484291533386.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 14:50:05 +0000
References: <20260303-mtk-xdp-prog-ptr-fix-v2-1-97b6dbbe240f@kernel.org>
In-Reply-To: <20260303-mtk-xdp-prog-ptr-fix-v2-1-97b6dbbe240f@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: nbd@nbd.name, sean.wang@mediatek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, pvalerio@redhat.com,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, bpf@vger.kernel.org
X-Rspamd-Queue-Id: DD9D121433D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264439-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[nbd.name,mediatek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,collabora.com,iogearbox.net,fomichev.me,vger.kernel.org,lists.infradead.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 03 Mar 2026 18:56:39 +0100 you wrote:
> Reset eBPF program pointer to old_prog and do not decrease its ref-count
> if mtk_open routine in mtk_xdp_setup() fails.
> 
> Fixes: 7c26c20da5d42 ("net: ethernet: mtk_eth_soc: add basic XDP support")
> Suggested-by: Paolo Valerio <pvalerio@redhat.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ethernet: mtk_eth_soc: Reset prog ptr to old_prog in case of error in mtk_xdp_setup()
    https://git.kernel.org/netdev/net/c/0abc73c8a40f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



