Return-Path: <netdev+bounces-277238-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AmUL8dx2Gk5dQgAu9opvQ
	(envelope-from <netdev+bounces-277238-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 05:43:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 535BB3D1E84
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 05:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1CD330523F5
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 03:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89B932B9B5;
	Fri, 10 Apr 2026 03:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1jGZZqQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8495132B99E;
	Fri, 10 Apr 2026 03:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775792452; cv=none; b=c0NnWU/BA8L3GVRhxPo07oy3aSjosj1GSxaB8wB2QS9wF3OK1ZGhvh/aS6n/KANF/XfhpAxUeav2DskW3zk3WKe+E2C+QDxp9RPkGv0jsByJVbI3CthePeKfPctNPV3gSaAA3hEbnIbsJJIjPwqnbNSOVJeRQocazGyB+yqUdSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775792452; c=relaxed/simple;
	bh=my7kSuC/Perf7BC/m4JKHMgLdU6sYLcXFcsnbMGvBOI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=miQMu+kMB/neSBnHic+CYFcMqwCv8/Vli9tQo8np0sfmS1VF267brBYeKO0WIb5aKn1eRkMspsBEXSizK1atsnH9b7mW97FxznLuMx2zW1bRMru/xQymoyrLbdeWzOUsYXXkobgi7hVz1ZpmMTb6pMIBlN4+SzqjB5DttLLMifU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1jGZZqQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F7DC2BC9E;
	Fri, 10 Apr 2026 03:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775792452;
	bh=my7kSuC/Perf7BC/m4JKHMgLdU6sYLcXFcsnbMGvBOI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F1jGZZqQNBuMhh7D/PrTZDFvlSrWGcsbQ+hrtZGnko6GW3gVwbD5HhthQwXj3GwRG
	 TVY+/UZWUxBa0quw4iZuQ3s9hcQkPf6ggVIWq5ZcOM020E3BSkoQMexU0aPQrH3Ec4
	 phDTJSH+mB5NkWyFhbZZ7njDKixjeDPlyZH2QqPlS7ZupEwpWvhHoS0r9TWCE1WycZ
	 x3DIiEgcLswaGs7i0Nj8VUHueQUjGpj7Xw+TMKybnTIHDZE+pOZC0pnP4a6+vHhSKF
	 LQXjHan5kWTI9xckH3pTU3yacMdngNnX1Nqdoj0A1rL/XZsubOB4uF2m9iROVRaNZE
	 VWpJd48KoWHBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CCB33809A22;
	Fri, 10 Apr 2026 03:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: net: py: explicitly forbid multiple
 ksft_run() calls
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177579242707.1854480.11270474673185223414.git-patchwork-notify@kernel.org>
Date: Fri, 10 Apr 2026 03:40:27 +0000
References: <20260408221952.819822-1-kuba@kernel.org>
In-Reply-To: <20260408221952.819822-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 petrm@nvidia.com, willemb@google.com, linux-kselftest@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277238-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 535BB3D1E84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  8 Apr 2026 15:19:52 -0700 you wrote:
> People (do people still write code or is it all AI?) seem to not
> get that ksft_run() can only be called once. If we call it
> multiple times KTAP parsers will likely cut off after the first
> batch has finished.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: net: py: explicitly forbid multiple ksft_run() calls
    https://git.kernel.org/netdev/net-next/c/3d2c3d2eea9a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



