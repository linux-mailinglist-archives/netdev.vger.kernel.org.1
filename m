Return-Path: <netdev+bounces-276777-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIftFK0K12nNKggAu9opvQ
	(envelope-from <netdev+bounces-276777-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:10:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9303D3C5734
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E50430086EE
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 02:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5307635F185;
	Thu,  9 Apr 2026 02:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuNaJF57"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F63A1FF1B4;
	Thu,  9 Apr 2026 02:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775700650; cv=none; b=RvIixMF5SyCjlRj9z/nD4icQdu/2spvBbp+T2iOq8NGMEwjFpwqj/eCWcoBp3axbcQkbC8SrqdO2d07RQqAjonFqgZWSgaJ02+0uGokUFOegjl3SzL56vCfs6Aj4dzmQUZMAp0oiNDsSCR0oK8jo/z7xUlJWexZeURK4Q2zbjto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775700650; c=relaxed/simple;
	bh=R1z8BTC+SJ44mKiYOGpR+gP/SXPNtc31TQTefFy8loI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CX+BMJsRWeTtEYZw/zPSGSODIxwtM6H0yDbiluYI3AcDgCag4yG/OGug/M/l1rDr24nyW0COQFPbw3FZiiJvP4jUT2EeZcYK0KMZifzwPYdf8awsOKTHU0DqeIytI/bZ2F4VBe/OaLs3+JFHqvW3R3S0LcniEWqiRJAocydChr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuNaJF57; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C325AC19421;
	Thu,  9 Apr 2026 02:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775700649;
	bh=R1z8BTC+SJ44mKiYOGpR+gP/SXPNtc31TQTefFy8loI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iuNaJF57xBWSAGyONb6E+kAsgBOvPQERzCP0BJSktJZRQtXRFi48BF9kRPP5aRGFS
	 yMaTxNoRB1tL2YUMH1FwlY5mzwAK6VwPYEdIWkHUiU91tPBDOZ4C8kwxKpolbNYkMg
	 ykQeAqF8YzfbCNYABevA4V7MJ4JgqLtm6BfIqH1cfTmb6fgcGor1Q8odDHonHHy9S9
	 8JXdSnowjoPCUeO6xH2R0/MzAY1lUyYyZyy0+tibhyriFtTy+0gUucSck/NFw9LJ8B
	 j5SW7hE7OMy5gAMhrigpoHp57QdbSH9No/UQHHMXHB/HFOYALfs2u9IJBJUS8sgYG7
	 4EF2xTsl5EE2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FF353930793;
	Thu,  9 Apr 2026 02:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] docs: netdev: improve wording of reviewer
 guidance
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177570062604.956260.9581226138946613970.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 02:10:26 +0000
References: <20260406175334.3153451-1-kuba@kernel.org>
In-Reply-To: <20260406175334.3153451-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-276777-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9303D3C5734
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  6 Apr 2026 10:53:34 -0700 you wrote:
> Reword the reviewer guidance based on behavior we see on the list.
> Steer folks:
>  - towards sending tags
>  - away from process issues.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] docs: netdev: improve wording of reviewer guidance
    https://git.kernel.org/netdev/net-next/c/bd5c24e4001d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



