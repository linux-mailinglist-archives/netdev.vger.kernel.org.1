Return-Path: <netdev+bounces-272722-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GgixJblUx2lTVgUAu9opvQ
	(envelope-from <netdev+bounces-272722-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 05:10:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D8534D3D4
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 05:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A14F13048EF1
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 04:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BDB2BE641;
	Sat, 28 Mar 2026 04:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lq5tuJt9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5DF10F2
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 04:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774671030; cv=none; b=sJJv1nMyWIf+2p2c83TDf6A31s4fNyn05kPD4V5+fmZPFCC80A9GzYVHWA3C0KxTn7V9rmVdDEZS1Q60Xo4OPLIgcDcU1rDcsX6LElasF9cfXjPXUOf87WbFSZ93wa+ONaT6mtv7ck4A/eQChAr+ln7lKr4Qc/w1dgv3KJ8WMdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774671030; c=relaxed/simple;
	bh=+YQ9m+m0QFuWTDaW5ySs7YO2DyDqnApb6IxeACl51wI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E/qFEPsXRwKAdu8swJx6SE96JdO2kh4bVUKQbyXnLohF/qJH/LrlqOZy0UOBlbCZQF5izaciNsDYtpcNWfwRieqoOUCV+gUsWavJVats4Xrp/VTeto3UHie00CAKflCVnf0oGsy8sQma64z9aWw9Gpjznq7gtuNv5a3GbUbfLdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lq5tuJt9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F23C4CEF7;
	Sat, 28 Mar 2026 04:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774671030;
	bh=+YQ9m+m0QFuWTDaW5ySs7YO2DyDqnApb6IxeACl51wI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lq5tuJt9uk5+ALv/7YDnj05RmB8rMDbkptmBNkvx3ORHeAs9DiPD0iibCRzYnSPLA
	 qwdtifkwtta7Dr+eJwVSWZS+5AWK+54bbycy2qZf5vaaagtXNseDC3Yk6S6K88qjQ/
	 YaK6K/RyenHbefBFX1BwQ5a1SOZ2hPwAQE1iQMzoaljYrX30G91cONKWREI8zTe0q+
	 mVGWZXHpiA6KGFJZfksB6p57HQ3m8as/uEaRSICwTiQB6sb0oBYdp1WnxvbmEgonyy
	 z6CGXk7+QVzKrb+l8BF/5fdce8+657fGtBp3on2Qqid6ezeN/510f2lSRvGaePg5LA
	 WzGWd73wrewQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE113930181;
	Sat, 28 Mar 2026 04:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] vrf: A few cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177467101604.4182342.17079713304515719113.git-patchwork-notify@kernel.org>
Date: Sat, 28 Mar 2026 04:10:16 +0000
References: <20260326203233.1128554-1-idosch@nvidia.com>
In-Reply-To: <20260326203233.1128554-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
 andrew+netdev@lunn.ch, petrm@nvidia.com, lirongqing@baidu.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-272722-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E8D8534D3D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Mar 2026 22:32:30 +0200 you wrote:
> Perform a few cleanups in the VRF driver. Noticed these while reviewing
> a recent patch [1]. See individual patches for more details.
> 
> [1] https://lore.kernel.org/netdev/20260310105331.2371-1-lirongqing@baidu.com/
> 
> v2:
> * In patch #3, remove RCU protection around dst entries instead of just
> the synchronize_rcu() calls.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] vrf: Remove unnecessary NULL check
    https://git.kernel.org/netdev/net-next/c/ae3cdfd4e0b8
  - [net-next,v2,2/3] vrf: Use dst_dev_put() instead of using loopback device
    https://git.kernel.org/netdev/net-next/c/50504e2579c1
  - [net-next,v2,3/3] vrf: Remove unnecessary RCU protection around dst entries
    https://git.kernel.org/netdev/net-next/c/075196489a37

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



