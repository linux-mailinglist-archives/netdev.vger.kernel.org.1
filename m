Return-Path: <netdev+bounces-253685-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFFPEu0zeGlRowEAu9opvQ
	(envelope-from <netdev+bounces-253685-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:41:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE038FAF8
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D037D30387F1
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 03:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B7930E0DF;
	Tue, 27 Jan 2026 03:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMi2sla2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E9B30CD8B
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 03:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769485224; cv=none; b=fmhpNpsrnL2G4Sv2hHP4pEMd1CNSolnFTFTKeVrztUuyRX4W+PSOF7dY1mcun+fyWU9KfxQN3gk5JdDgB5NnHT5Y7AW2130po62BgKk2cHCpun1kIVDFXxK5Wcknsn5tv5qsWz2+tu+umSYIS5AjS5xWioViJUggIjiUtheHt5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769485224; c=relaxed/simple;
	bh=t3g6TqHeBexi7JVSJ8bqIFKIWvdj9HckRdeqQRddr1w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fuHCI+QJonEg8/gbcpJcoy66r7iNVAvJSAYnzAe3dgpYLu2/94NIhaQSH4aR4Gpl06UVAPw+AICRJFjIk+Aowds7jZ0r/PjtiDlJguTdG4HBvjFJd7xKP71NQhlv4si86VUt1RoKYNrUGkngNeDpck9z119pUM7nypMRcfXnK6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMi2sla2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9ACAC116D0;
	Tue, 27 Jan 2026 03:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769485223;
	bh=t3g6TqHeBexi7JVSJ8bqIFKIWvdj9HckRdeqQRddr1w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kMi2sla2IdS3kFkXj/rwQrL8OW50YC67AIOMhPmIXcU0OZibBKlWJO7KcxvoTZb+9
	 CxvAaMCqH4zjUTOWSpqBAv4yo8pRQO/JmT86kdwFxuUgFtI0PpY27abIBrt0sg7RWl
	 tzchVH2XWOfVUUnncpqf39eWC3eYbkrMc6+/Q4vrcK/gkiUQVdjhDmkdzoUaL7zJjo
	 iRQc+l6gP0gL6Wr+2VWAwWulTRM4SAexwsVn8cqoalIgK73nAFj+xg4QGCEvFmxOAA
	 Euuhsyy3GMgNFZkYWE+Wboro0p+CRHn6ukglnGYzTLXY6Zx8IFKCHkOyZfHlpRxVAy
	 Husrpa+THBFdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4E9E4380A961;
	Tue, 27 Jan 2026 03:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: add support for extended chip version id
 and
 RTL9151AS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176948521785.672496.16492728326006112952.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jan 2026 03:40:17 +0000
References: <a3525b74-a1aa-43f6-8413-56615f6fa795@gmail.com>
In-Reply-To: <a3525b74-a1aa-43f6-8413-56615f6fa795@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: javen_xu@realsil.com.cn, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, netdev@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-253685-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realsil.com.cn:email]
X-Rspamd-Queue-Id: ABE038FAF8
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 24 Jan 2026 22:27:24 +0100 you wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> The bits in register TxConfig used for chip identification aren't
> sufficient for the number of upcoming chip versions. Therefore a register
> is added with extended chip version information, for compatibility
> purposes it's called TX_CONFIG_V2. First chip to use the extended chip
> identification is RTL9151AS.
> 
> [...]

Here is the summary with links:
  - [net-next] r8169: add support for extended chip version id and RTL9151AS
    https://git.kernel.org/netdev/net-next/c/5e3c5a2b85da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



