Return-Path: <netdev+bounces-258186-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CriN34DjGnIegAAu9opvQ
	(envelope-from <netdev+bounces-258186-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 05:20:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA0712125D
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 05:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 465EE30193B2
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 04:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A618350A2C;
	Wed, 11 Feb 2026 04:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZtfmBAU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BA5346E4A;
	Wed, 11 Feb 2026 04:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770783610; cv=none; b=H3i8grDhhZ1AioujhZPV3TDYqFb5HniqidM2IKR4nQyu49QNtxZYPPA742AmUACrbfJC1ZwBI/j3dOyckkXNp4GzEEnTV1IYNK0opL6NMngN6QeG9yU1pdQmC06Wj7pB708ZkgnlW2rL7odbbHB5NTXT8sQWyD8PR9Zz+u7Km+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770783610; c=relaxed/simple;
	bh=G2tLwo/2n9hhAlv6xVc8i+YA/OmVFW87ttb9ICV8Ngw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F8NeHTZOlGfsyNjw0xzCSiTKgQxwspJ1MKk+UCvyFNz1exFQZPZshTNZzPNd8U615o3fxRWCQxa+fV1xW4I0DcdHZ/c46pDo9GVKi+RF+029k9TBcJ3JHQzonZC0OflN7Wo5n87En9i8YMM5RY/mpUMh1mcP7u4xW3hLHWz/mVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZtfmBAU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1DAC4CEF7;
	Wed, 11 Feb 2026 04:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770783609;
	bh=G2tLwo/2n9hhAlv6xVc8i+YA/OmVFW87ttb9ICV8Ngw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HZtfmBAUb6xhK22iVKo9Z6PGeN0Ek/r4vVa8KBsDnkDfHu4MwrRbvc6ILFl3pG4Fc
	 zFaHM7QpDSjhS3CgX4iALos4yfjfxNmr/YCveSMRpm+Ups+90qV8goih6sCJlBk8u6
	 qnyAte6qTV4IkHKymhLgkh/f0ukH9rU+Pwd9JoU9Iobmql5snmxdKpfN9v1047f4X1
	 WBXdjPEKRik019Aw390vEpCq1cC/tp8Q1ePaLlQyXepkvvcIUDq2nz0N/hcyfpc03V
	 LPVa5eMhN/vZ6PA8UJLg1GaV262dUbOc3HfIkM19Annxusdhvt9BKOzYUhLcOAdzAw
	 mOrmmX3Uoanuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B183380AA50;
	Wed, 11 Feb 2026 04:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] octeontx2-af: CGX: fix bitmap leaks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177078360482.4190841.12442475614535152274.git-patchwork-notify@kernel.org>
Date: Wed, 11 Feb 2026 04:20:04 +0000
References: <20260206130925.1087588-1-bo@mboxify.com>
In-Reply-To: <20260206130925.1087588-1-bo@mboxify.com>
To: Bo Sun <bo@mboxify.com>
Cc: kuba@kernel.org, pabeni@redhat.com, gakula@marvell.com,
 sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
 horms@kernel.org, bbhushan2@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, sumang@marvell.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258186-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5AA0712125D
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Feb 2026 21:09:23 +0800 you wrote:
> Patch 1 fixes the RX/TX flow-control bitmap leaks in cgx_lmac_exit().
> The leak was introduced in commit e740003874ed ("octeontx2-af: Flow
> control resource management").
> Patch 2 converts the existing kfree() for mac_to_index_bmap to
> rvu_free_bitmap() for consistency with the alloc/free API pairing.
> 
> Changes in v2:
> - Update patch 1 to use rvu_free_bitmap() instead of open-coding kfree()
> - Add patch 2 to keep the alloc/free API pairing consistent
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] octeontx2-af: CGX: fix bitmap leaks
    https://git.kernel.org/netdev/net/c/3def995c4ede
  - [net,v2,2/2] octeontx2-af: CGX: replace kfree() with rvu_free_bitmap()
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



