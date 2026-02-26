Return-Path: <netdev+bounces-261146-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJdPEom3n2mKdQQAu9opvQ
	(envelope-from <netdev+bounces-261146-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 04:01:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 947C61A0472
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 04:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8706C308AF5F
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6737A3815F7;
	Thu, 26 Feb 2026 03:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBo2r6At"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224C73815F4
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 03:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772074807; cv=none; b=kP1J7OKZA+uVmX/qR4rp4E/NEDe/cqwIjFA5Dw+ym1hw8ZghX1QFpbQ261iJ9sKpuG9pgrnutWlXeJRNl2k2WmK3ySlB/MSLPGacZZqvgLy2cUKmv7s7iaJdyvtei9zVdHm2ktSs8sYoBRnKA0pZETX1N1FFUrS9ogT82E6/fKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772074807; c=relaxed/simple;
	bh=A2zbObXNUzm7+kP5snmUgIb06U/s9qdVnTXzJHN9oGQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JCB0E82O7a8a4msMA3sutQfBeUVYzB+ZmyCzPpX3WqMyvrO2L/zEPjZwqDvUZeqBe6moT+2AW7kwy38+qgBsWMVO4QDg95xN7ut/lcy7IbyoZCPGFHMGShrG0mqfVBrVM8qWs1XmLMBN9r0DAKLFYv9BMm0LUfnC16V+ZMZIyPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBo2r6At; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8006BC116D0;
	Thu, 26 Feb 2026 03:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772074806;
	bh=A2zbObXNUzm7+kP5snmUgIb06U/s9qdVnTXzJHN9oGQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bBo2r6AtfkuAFpKg11m8RHsT4BlSdkHxWFYvkoSm2tUkh3Yqk0VNkdwteXzjUA1B0
	 BROIs/L196g8MUTCzD/O7ICp3db+N7wUN7rFJ8VNMBiiEYXWbLE6B96gNaB2Re0sJn
	 s2B31cT+UeRjlZqK4yec3qbYLXkh+WwlClY6VJh1uptg1Gge3tEGyJltMcGkIz2spk
	 QxwrZHlLJ/Z/YQWVQIM8XXWqsyS3lWBFfDdKvThCKNR69gIV0FwSo7pmsdKA96eJCR
	 Su5MNQai9kzZHzlf/BGRlGIQzSy4Vy9i+CvjVNoQcTN4XUdbkcW7cXtQCM87z71exR
	 s5cXyaAol9Evw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF7C380A94B;
	Thu, 26 Feb 2026 03:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: fix EEE supportable interfaces
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177207481128.1011529.4880662803643128473.git-patchwork-notify@kernel.org>
Date: Thu, 26 Feb 2026 03:00:11 +0000
References: <E1vuUsD-0000000Afci-0XxO@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1vuUsD-0000000Afci-0XxO@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 pabeni@redhat.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261146-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 947C61A0472
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Feb 2026 12:17:13 +0000 you wrote:
> According to the dwmac v3.74a databook, only MII, GMII and RGMII dwmac
> interface modes are supported for EEE. Restrict EEE to these modes, or
> the modules supported by a PCS other than the GMAC's integrated PCS.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c  | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [net-next] net: stmmac: fix EEE supportable interfaces
    https://git.kernel.org/netdev/net-next/c/8215d7cbfbcf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



