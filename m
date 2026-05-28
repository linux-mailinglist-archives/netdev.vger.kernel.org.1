Return-Path: <netdev+bounces-292491-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Jp6F5yPF2oUJQgAu9opvQ
	(envelope-from <netdev+bounces-292491-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:43:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B32C95EB506
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8298A308976D
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 00:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939381A6823;
	Thu, 28 May 2026 00:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gk8msbES"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F287194A6C;
	Thu, 28 May 2026 00:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779928808; cv=none; b=QKYwtnzRfmj8I5+1K5uLa0bGtrSDAFlVSFD9SlEMJcA22/Om/waEJTJ3hRC6TaUtQTQqDqAlv1eNDB7xtEFgr53NliBNJ/eg6h8469TiGat3LbDHfxH1qA9/oG9x8Ch8XOedPXDmRaGbOPVxgFy7xL/0e3nCN1qTc6r+dfozXNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779928808; c=relaxed/simple;
	bh=t66nOEgL3ornetJni2oTz+QuwJDk2gjsW8B0sLYPtXs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iVu/9NAt4iUUt6mmBuSh5LOVc1OGtC1y0uiuKfOjnJo80TPWD18JG/gFeT7F0MlpQjWTqfg8JNfbCrAnmq2ZHVcZqqN+PupMKjFs5FWxyglBlNwsa7GlJIpToTefbL7sa0om7KinzLQ5SRNMTLhfag5trPq1BLk57xsOC+0jd/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gk8msbES; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 266EF1F00A3A;
	Thu, 28 May 2026 00:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779928807;
	bh=GdCtR5aV9vBP4cypsa0m+ljbgTd5qyfhRQC6c2XNDvA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Gk8msbESO/xILARX12U3y/kaMX9cgK7dRBmSWAXb3XAJhi2vzDryGGJdpP+3exp4K
	 yzGkcTCaz+PV2N0adv57jybw7Uo66wMhkrSBbWqK8bD71fEN6tOroPSs5pVEKEJecP
	 XAg/4GcaxzbNYH8zNHfPUGiZZjEHUdIWEoCEElGF0PmztZIxRsaNjuTzAR7m2ijb+6
	 5y4nPhli1RG8KxSuspz7ExhwZ11SVW90L4Kbeq03ERh7K9QPlru/8RJ/oX65ZbTyKr
	 CTkcQ6DPhfg8NEK0giXV3HpCNK4UyE0lC/gJOrZei57Imth3vLX5md5WP3miKUsEFk
	 l5sRvNTnROiYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AED380CFDE;
	Thu, 28 May 2026 00:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: sfp: add quirk for OEM 2.5G optical modules
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177992881189.696403.14388154133198752084.git-patchwork-notify@kernel.org>
Date: Thu, 28 May 2026 00:40:11 +0000
References: <20260526055206.1750-1-weixiansen574@163.com>
In-Reply-To: <20260526055206.1750-1-weixiansen574@163.com>
To: Wei Qisen <weixiansen574@163.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, avinash.duduskar@gmail.com,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292491-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B32C95EB506
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 May 2026 13:52:06 +0800 you wrote:
> Some OEM-branded SFP modules are incorrectly detected as
> 1000Base-X and fail to establish link on 2.5G-capable ports.
> 
> These modules do not properly advertise 2500Base-X capability
> in their EEPROM and require forcing the correct SerDes mode.
> 
> Add sfp_quirk_2500basex for:
> 
> [...]

Here is the summary with links:
  - [v2] net: sfp: add quirk for OEM 2.5G optical modules
    https://git.kernel.org/netdev/net-next/c/5af067bf8a64

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



