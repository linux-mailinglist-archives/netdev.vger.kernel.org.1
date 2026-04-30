Return-Path: <netdev+bounces-282585-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIItDCqz8ml1tgEAu9opvQ
	(envelope-from <netdev+bounces-282585-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 03:40:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F0249C0EF
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 03:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BBB123008081
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 01:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99D7265CA2;
	Thu, 30 Apr 2026 01:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8GGDnc2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63822580F2
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 01:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777513250; cv=none; b=btvvkNGLRikcs+BAFWhhwFeLqz0PELEsfo1u7SRpWKZmVZ+43D83iyjWuEurSRi649xk6rw57pZ4u1wz8VkJO0fZIM4q66izzJTMobd/RwhK21TNeDxGjmZhQDjJpRRBTe60dn7bL21rWvxEDkBNucd5TiGeuYuOXKrNg88gNgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777513250; c=relaxed/simple;
	bh=pADFW97s8ZAWiuq7aYrAylX+v7UiOD00KyYmiR8D28Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bw6FxPokcT/QAEAjWM8UvRE2Zs4ed5JtpfGA7Ru2LXGgingvR14UTp7rnlK1Hlff2f6mKMkkOoyTYrb1tQtteWF2ZhI+sTqBBxWUUhFq6V10LSEEO9tkMff+P6abti6GntO3I8xjv+f2dzRY5b+UhGps99IEKSTHViJYlXYKWBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8GGDnc2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165D8C19425;
	Thu, 30 Apr 2026 01:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777513250;
	bh=pADFW97s8ZAWiuq7aYrAylX+v7UiOD00KyYmiR8D28Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j8GGDnc2gQWvGdulSV0ssXIDv7sRTO/JReua58HqR2+xHmsKcLy+it/P8HMhtJ/sd
	 leSgJ9pdKTiyLgePIEk9PgCw9uDZlx6ZLxDh+5maD2tYJxmCU3j9aBnvFwN9ZjP0aX
	 mw3siJjChRI44qEMuXWzjs4TRzAyevZWsIWa3dvsxION2Ln1z83+av0EToJ7Yswwyt
	 XpJHhvxmZIptbvypf9z85WdYhb/h1maYlE0BPJvy3RAMMslo9nDofT2VOvrJx+NBnR
	 tpDAYe9X+BWA0tGJR8aSEAggVNxQsWxQRxrPO+oCbVzcSb/GBHwsnzbI3I9v89AytZ
	 /UIiz1QjRnZLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D0B63809A33;
	Thu, 30 Apr 2026 01:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: airoha: Do not return err in ndo_stop() callback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177751320505.2255030.5166228559357523797.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 01:40:05 +0000
References: <20260428-airoha-ndo-stop-not-err-v1-1-674506d29a91@kernel.org>
In-Reply-To: <20260428-airoha-ndo-stop-not-err-v1-1-674506d29a91@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
X-Rspamd-Queue-Id: 36F0249C0EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282585-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Apr 2026 08:53:16 +0200 you wrote:
> Always complete the airoha_dev_stop() routine regardless of the
> airoha_set_vip_for_gdm_port() return value, since errors from
> ndo_stop() are ignored by the networking stack and the interface is
> always considered down after the call.
> 
> Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] net: airoha: Do not return err in ndo_stop() callback
    https://git.kernel.org/netdev/net/c/4ca01292ea2f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



