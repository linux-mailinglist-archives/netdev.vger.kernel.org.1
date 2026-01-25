Return-Path: <netdev+bounces-253296-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGqVLqandmnLTwEAu9opvQ
	(envelope-from <netdev+bounces-253296-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 00:30:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E09C83249
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 00:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77E243010BB1
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8224330FF04;
	Sun, 25 Jan 2026 23:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnqyA/VV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1AF30E0CC;
	Sun, 25 Jan 2026 23:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769383817; cv=none; b=czZCMwKt1Zx/MKsMMwfXG1blTGkv31w02pDM8OfDnpLE/egzixw+ym15LCRdhbLkyt0YGqpU1yCc/AZ/BJnkp+ibDpB5SQ7eXcaT43qU7X7IGIb/JK29bUjKYv/bRiCc27qcl0w8MKUb95YCm7GoQMYGmP3QIwuU3gsnBCZR9AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769383817; c=relaxed/simple;
	bh=UxjsFzyJDKHZCAmZxzzx2OMG5I4PoYHG+DJ5BLLBlQY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZRHYfxndDSZTm3ntoXkwYXQvy4nArWVSjrOUb+nRXy4h+NWgrIsmsJH75WcispDxSCb1BpsVsZVy9uOsqECy4ELOyMMkoxB+NVC0r30kILqA9rQdg4i/c0hKmkVfvlPrC/bWxKpFHA3n1657WsiQOf6JXsIZuXXcnIPuvv1RCp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnqyA/VV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5D8C4CEF1;
	Sun, 25 Jan 2026 23:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769383817;
	bh=UxjsFzyJDKHZCAmZxzzx2OMG5I4PoYHG+DJ5BLLBlQY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HnqyA/VVKBW6/8dsnaj0Xsip6CDcqvp+nHEvkImf4DAM3Whl8ZKFVZl2AEpsePSDA
	 qyMi46ir/SptHD23d53Na6/+WkoFY7LgXL570UHDJZJJ6b8UjAyE3o3hGuBP8SnwHb
	 gy+p3lWey3UrG8KRrx3CuIvn++AyAP5XDZ/DWnLwLVrcdvi8tXs8J6WJMjGXBWl+YU
	 nFecNNsO2Oad1h4pQ6QIsjdH2haLIQ386Pf8uBOJ/SKOPSfEr4HoOILmTMOfuIwuA3
	 K182p54FTOW7BLdgCzE9TJfE6i33yuu2rTJ+d0RQKBjjSrZLQhiFGNjLEDeh76C8YX
	 T3ta1Fn66fkNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EAB43809A15;
	Sun, 25 Jan 2026 23:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] dt-bindings: net: dsa: fix typos in bindings docs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176938381209.4011909.12223254210240396797.git-patchwork-notify@kernel.org>
Date: Sun, 25 Jan 2026 23:30:12 +0000
References: <20260123150211.2646235-1-weibu@redadmin.org>
In-Reply-To: <20260123150211.2646235-1-weibu@redadmin.org>
To: Akiyoshi Kurita <weibu@redadmin.org>
Cc: robh@kernel.org, devicetree@vger.kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, andrew@lunn.ch
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
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253296-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:email]
X-Rspamd-Queue-Id: 4E09C83249
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 24 Jan 2026 00:02:11 +0900 you wrote:
> Fix "alway" -> "always" in lan9303.txt and marvell,mv88e6xxx.yaml.
> 
> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml          | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [v2] dt-bindings: net: dsa: fix typos in bindings docs
    https://git.kernel.org/netdev/net-next/c/bf2e36c9dab9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



