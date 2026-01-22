Return-Path: <netdev+bounces-252437-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMtlO/Zacmn5iwAAu9opvQ
	(envelope-from <netdev+bounces-252437-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 18:14:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF266AF7C
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 18:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D09632978EC
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495853F5DC8;
	Thu, 22 Jan 2026 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHzXYE/7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79533F5DA1;
	Thu, 22 Jan 2026 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769098811; cv=none; b=VDC7BQWLEQni5AKD6cjPqMDxLfQO+YDCqFN64OXtz9LaqayYHp+U1YbXc83YJQfsDetLZQ6UdHeeBUy1laSLKZwfOaqPFi6Z/uSWKvmaclR2QQSFfTNaX/Ex3r8wdpETZAdw/yBvQ2IEAz/fJ5+f1Ws+VhlhQi/PDzpwg17dyLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769098811; c=relaxed/simple;
	bh=qPbI85oCPsngtW0HnfIrWRIK0csne/ZBBmiulrYotrA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H6aVdB6l3kwESnmoJWjSVACbs+pRB393koEkO5MFhGh04uJ8ekZSf1Pa+VvYeF2TuLkWf6PZdh8wUvZupWkyYGoeMXmKEUnU5Za8cu7dpdH63mFHPHQY1ayVzTsaGvaxVglcWPtuDlIOsKdiiyB29YekOYNtKO5Q2/eQ4LIN5MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHzXYE/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9D7C116C6;
	Thu, 22 Jan 2026 16:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769098810;
	bh=qPbI85oCPsngtW0HnfIrWRIK0csne/ZBBmiulrYotrA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QHzXYE/7Tq+nHor25wRCHALeVUqIgg+OA4k28dZkFQ+341erWNqgzZ8cb9hoGtVoP
	 iiWbaxWOH5LfN0AIBkkORmSuRRdfe2EcIx+8a+2FMi46BVF42pinZAahTtFeABZLvR
	 Tln0AEYfS4ui9mCT4X/BnbvJAxDtKldf3Avjs6/aCx3R869aB/dxPTZ7XPH2C8gbAQ
	 v6Jb73vCpqsYVTcAysT2DeXNMDmZMWes2LcIdW3qRdrWBCKjZHGCYcFZFTAw831HAY
	 8hwWYJe0J7Jci2hId73mhnuDZUBJ0mdtz4JPgTiYyxZSUCDT+xnypLUI4SsREpDuBf
	 ap2EhuutAO77Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8C523808200;
	Thu, 22 Jan 2026 16:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net Patch] Octeontx2-af: Add proper checks for fwdata
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176909880660.1793166.958298769361922114.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jan 2026 16:20:06 +0000
References: <20260121094819.2566786-1-hkelam@marvell.com>
In-Reply-To: <20260121094819.2566786-1-hkelam@marvell.com>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, sbhatta@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252437-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7AF266AF7C
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Jan 2026 15:18:19 +0530 you wrote:
> firmware populates MAC address, link modes (supported, advertised)
> and EEPROM data in shared firmware structure which kernel access
> via MAC block(CGX/RPM).
> 
> Accessing fwdata, on boards booted with out MAC block leading to
> kernel panics.
> 
> [...]

Here is the summary with links:
  - [net] Octeontx2-af: Add proper checks for fwdata
    https://git.kernel.org/netdev/net/c/4a3dba481882

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



