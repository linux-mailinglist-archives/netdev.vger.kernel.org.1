Return-Path: <netdev+bounces-273438-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBExGDcry2n8EQYAu9opvQ
	(envelope-from <netdev+bounces-273438-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 04:02:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B34053633D3
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 04:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7B99306360B
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1B7366836;
	Tue, 31 Mar 2026 02:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cesxZ/k9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CA636680E;
	Tue, 31 Mar 2026 02:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774922423; cv=none; b=ZFDnM/hv7712lmwKhrGaCdbzrq1mWMbuyTlQcVPSiUzAWUBYNXtkiwAGem4j4pJ6fVwGpqxCT0ow5qAsv29kKb4s07is0AKtIDaIRHX/T5gr6XydL+0wAbmtMkuwqaYz3PNNGUKlk2uwZB4voCKQpXzd3EuxV3velpQl3yGSy0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774922423; c=relaxed/simple;
	bh=elnT80cyQLoD7qXS8DA+UH/R598eLWfxqEGHwF7bRNM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZuXnuAlqa8dfYfpWKl9E1AR4jGASkQ3oog/41QYkHbPamLCYNiIVN9W7q/1AWgCazupUjDmfM98+NZ9BTmPZ1fZdF9YVuNsjIJbcXaKM+Qh4YJm57i0PJVxTn6gFRgVPyIMQJA+mcWI7J7bHlqZTmunaJcKXyO2E9v8YgruXCd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cesxZ/k9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593D7C19423;
	Tue, 31 Mar 2026 02:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774922423;
	bh=elnT80cyQLoD7qXS8DA+UH/R598eLWfxqEGHwF7bRNM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cesxZ/k9iWz41ILqlepFDfsP2e5/ij/ptAnrDTP5EmQ+lZJ7Xf4Jd6Whn+98cMxHY
	 A00inHY868cKjVULyHdBij0n0eC2gai+du6jVCQkzT0CHoOXS8KSFEH/AeZ8XtqZ9c
	 b52HPfvBmrBok2xsZE6IbeQzIIgvETd9hq0/SbWsa3vLXm2vTPVgTBjhXeH+yBIQE5
	 kPpGcT2R//y1qa1gvMivF2eXc3rUz7/F95kiWhB6LpKfkpUJT+FuT+UpWOft+uFhl4
	 I3v/kjwlMsWXp5E7yV9zSjwWNDE7HvummECmZtWOxZKVybB3nLppcGC41eRxH0OXx1
	 Nm/lpHE0gzc8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE72392FF99;
	Tue, 31 Mar 2026 02:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] FDDI: defza: Rate-limit memory allocation errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177492240728.2055536.7140801369393163695.git-patchwork-notify@kernel.org>
Date: Tue, 31 Mar 2026 02:00:07 +0000
References: <alpine.DEB.2.21.2603291252380.60268@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2603291252380.60268@angie.orcam.me.uk>
To: Maciej W. Rozycki <macro@orcam.me.uk>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-273438-lists,netdev=lfdr.de,netdevbpf];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,orcam.me.uk:email]
X-Rspamd-Queue-Id: B34053633D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 29 Mar 2026 13:32:34 +0100 (BST) you wrote:
> Prevent the system from becoming unstable or unusable due to a flood of
> memory allocation error messages under memory pressure.
> 
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> ---
>  drivers/net/fddi/defza.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> [...]

Here is the summary with links:
  - [net-next] FDDI: defza: Rate-limit memory allocation errors
    https://git.kernel.org/netdev/net-next/c/f4ef5b1c1331

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



