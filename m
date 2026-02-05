Return-Path: <netdev+bounces-256958-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INEbJQkkhGnKzgMAu9opvQ
	(envelope-from <netdev+bounces-256958-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 06:00:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4994EE9C6
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 06:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4910C301CCF2
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 05:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FDA2D7DE4;
	Thu,  5 Feb 2026 05:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddpFw7J3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C9C2D6E78
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 05:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770267626; cv=none; b=bm5MoxwS5J3z1HlxElzl+Pl6Mj5qm34r/o76Djhybu+wtlcDaK/upd6aW3V+E79o0MO61EQdw94gMiOMjBfLEz6rS5RFzNB7ZS90elv+N2RgXM7L6gQslB62oF8Jae4sMq0Hkn8COOgvszByqDr1RV9KlMjBLcK52fY8C+Jj+pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770267626; c=relaxed/simple;
	bh=tYHUc0qOX64BQ1IJlSdjRln/EKpaQ440UZi6+G7w4mw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=snG1zvV31nQJwsGDOs3LFF9cDwBjLUGihvJx5e+WSlGWsp8g6xCxp5QYHHE7zYHFsZJ7fWO+yAtczHc5LnvdiJXKAcJdUVDGPDC9Pco+jPIoxESSe4VzQPRBpuABVw/rSSj95qmKzeSA8NiNdT8SQhWorfNceDTaLE4VLsHjdbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddpFw7J3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B68AC4CEF7;
	Thu,  5 Feb 2026 05:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770267626;
	bh=tYHUc0qOX64BQ1IJlSdjRln/EKpaQ440UZi6+G7w4mw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ddpFw7J3on4isMCOt3H2lue5WuIcQR2SPQyCjWoZHpcNo1ZOTj+0PEi8E25EEkr8i
	 yBMJnQGVARjtPRf9ef7LOw5vY/yM+9Y2z+ek1oOnVhhcPy7Lqh8R/kctmeagk57hxB
	 J7O+Kj9pbl2a5JZU2QKOYIXxHBXHap+mc+VDMlo0wQQv5W2syvn5fsdPkfORbPJ1+S
	 u+UUHFuQCX/dMT7rAwUxM2xANHv47aMRkTTr+88v+1jSOwGN6JqosnkOj0HydENAgR
	 MHTZTCGLy25XnN2BhGDmzmOxgcKX3xyJbmTZnqJI3QUxi77k/zaWdow5KMAS1trpuU
	 0849KzwxQ7hRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C27A63808200;
	Thu,  5 Feb 2026 05:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: remove support for lpi_intr_o
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177026762457.167759.15871089841650371979.git-patchwork-notify@kernel.org>
Date: Thu, 05 Feb 2026 05:00:24 +0000
References: <E1vnJbt-00000007YYN-28nm@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1vnJbt-00000007YYN-28nm@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 ovidiu.panait.oss@gmail.com, pabeni@redhat.com
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
	TAGGED_FROM(0.00)[bounces-256958-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[lunn.ch,foss.st.com,davemloft.net,google.com,kernel.org,lists.infradead.org,st-md-mailman.stormreply.com,vger.kernel.org,gmail.com,redhat.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C4994EE9C6
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 03 Feb 2026 16:50:41 +0000 you wrote:
> The dwmac databook for v3.74a states that lpi_intr_o is a sideband
> signal which should be used to ungate the application clock, and this
> signal is synchronous to the receive clock. The receive clock can run
> at 2.5, 25 or 125MHz depending on the media speed, and can stop under
> the control of the link partner. This means that the time it takes to
> clear is dependent on the negotiated media speed, and thus can be 8,
> 40, or 400ns after reading the LPI control and status register.
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: remove support for lpi_intr_o
    https://git.kernel.org/netdev/net-next/c/14eb64db8ff0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



