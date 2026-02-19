Return-Path: <netdev+bounces-259542-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFG9CXJLl2m2wQIAu9opvQ
	(envelope-from <netdev+bounces-259542-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:42:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F0F161584
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05B8A306777A
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 17:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301B8353EF4;
	Thu, 19 Feb 2026 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAVmVZPn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBF3353EF0;
	Thu, 19 Feb 2026 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771522830; cv=none; b=h0W99PfdSgX248U3Tsu/WbKW39hhjVWMLAO7nlzai/rA1yhx9WtvZW0EUBwaKuPPGS7WMSwPSvNK8ccXIAOkPzchamjbfV2Zmh0p47Zz2U+xPg+qzZuCjmaA5nVRuv9K9AP7yhlsPzPvsAHVDkOgPAIz82TWAxlXzb/vDWN2iwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771522830; c=relaxed/simple;
	bh=8oxFrKHsfsUJOzmAeljt7C7P6PkbmesDvyGIAenNlQc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=StF86582xNWmYGXuIMZMNmmG2mp1YbwdQp2AvKRAsFUSh21bhMacR+aBUYR6HjbRIWV4pDJFoS4S/ekitFbdxcMRnjt1nvaXji0KYz3HYQLcF2zTsNKeS2dg2r/mZjKEhW3e7D95zm6G2cWMZUYEiL61HqkL+IOZcZ8BPXYAxbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAVmVZPn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C4CC4CEF7;
	Thu, 19 Feb 2026 17:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771522829;
	bh=8oxFrKHsfsUJOzmAeljt7C7P6PkbmesDvyGIAenNlQc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qAVmVZPnEg74kcDxvHa10CCS1rCkZEfEng21gQxmiBg4ADjP+bq03fxXoLRYO8i9C
	 Xjl94eD0+GunZRJT8Is5vfdNbac/FkdooySUTd65IKFHjvvaqDta8Utagi3e2Oek7D
	 AYKlKGgQuC0MMa4PFhrCmUycLbZwyRy3btoT9X/5Pd09yhlOmVWro7eWCsMSS3ZHpx
	 Zfi6/QVo1d32kvs2e0dXcZfUlW64WfOniOPTleBeXjmPZQnf1Ea5I8uFgBaA+hzL+p
	 k0ysXvCJpRg4t4gMoU/EeFDx3oNeGVV0t2U8jAE6EuMhy9ueL+hP/gQZUZtkxHnMk7
	 lAR/vNC3IiOcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B368380CEF3;
	Thu, 19 Feb 2026 17:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] bnge: fix reserving resources from FW
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177152282058.2317554.12742596886136607960.git-patchwork-notify@kernel.org>
Date: Thu, 19 Feb 2026 17:40:20 +0000
References: <20260218052755.4097468-1-vikas.gupta@broadcom.com>
In-Reply-To: <20260218052755.4097468-1-vikas.gupta@broadcom.com>
To: Vikas Gupta <vikas.gupta@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 rajashekar.hudumula@broadcom.com, bhargava.marreddy@broadcom.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259542-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 81F0F161584
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Feb 2026 10:57:55 +0530 you wrote:
> HWRM_FUNC_CFG is used to reserve resources, whereas HWRM_FUNC_QCFG is
> intended for querying resource information from the firmware.
> Since __bnge_hwrm_reserve_pf_rings() reserves resources for a specific
> PF, the command type should be HWRM_FUNC_CFG.
> 
> Changes in v2:
>   -Fix commit message.
> 
> [...]

Here is the summary with links:
  - [net,v2] bnge: fix reserving resources from FW
    https://git.kernel.org/netdev/net/c/604530085b2e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



