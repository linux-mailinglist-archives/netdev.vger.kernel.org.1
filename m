Return-Path: <netdev+bounces-283329-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id s8uWNMBF9WngJwIAu9opvQ
	(envelope-from <netdev+bounces-283329-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 02:30:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDFC4B07DF
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 02:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DFD8430090B1
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 00:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F561DF256;
	Sat,  2 May 2026 00:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6biZWL2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCA81A38F9;
	Sat,  2 May 2026 00:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777681853; cv=none; b=kX//EuZ1MwMxEqmr+afMRYQKsQ/+C1XlNSmJy2AYFxI16wa8akaSQBOSoWQH4bRaHJFTcz5cJgWiCDM3shy1yuDk4WtYQcmgQ/88hlfXW6BmVcW7xIDnJxZ2hc2duzDbmsLXcQGTZneOFb1zxQ0IY9eYLfoinP9VPtcMtFwhz6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777681853; c=relaxed/simple;
	bh=RRtpvL3jARRI6pGEBaCQDlDBnw61LfSgnBrRK+dSWC4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F7lk+ySQ0URt5wBfqYuk7r/5yTcg1gQ5XniD6BlyXNwzlQDvf/x2oHYxo8sIS3CmFovRFVfnyGgSfA57Y9lO0Vzsg1DxA/uDinQIYW6+IleSE8AOp2KUqXNLWt7sH8TDeHpcgFEUlMXhk5AE/Vn7MezG5E1Mr2gePhnYDNmUIAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6biZWL2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7B6C2BCB4;
	Sat,  2 May 2026 00:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777681853;
	bh=RRtpvL3jARRI6pGEBaCQDlDBnw61LfSgnBrRK+dSWC4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z6biZWL2drJ5hrL/k00EaG5ZTguBHk1v2uttQqFD/qW/XXNqf6/L+kGyZOsyP25JX
	 vut7fJReY8/7N1c2OLtdrroDNAjTGJ2Pu6vDZb9/ZdvHmVazemjCRigsl3L0tAi1zZ
	 JZsGoko2r5LlipZQEdQARsB7HviEG4AqpWAhbEU4YgJVURuReaS6B/aPaU6atAIs5o
	 fL7M8jrXGYLKLJ6Pd3Pty10vj6vrxPJf9q2IiT0lXEjD+SHC5rthe5k6hgOftclnDJ
	 tSYGE8vrXvpsrgO2RD3TrAR2Xkh65UnRJFHWYKNM3+Yszwd29GE1LgP8dSNiJc0f4k
	 eHGcTxerrpH4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD8D380CEF5;
	Sat,  2 May 2026 00:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: usb: cdc_ncm: add Apple Mac USB-C direct
 networking quirk
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177768180605.3674002.7797567348612816091.git-patchwork-notify@kernel.org>
Date: Sat, 02 May 2026 00:30:06 +0000
References: <20260429175739.34426-1-alex@exolabs.net>
In-Reply-To: <20260429175739.34426-1-alex@exolabs.net>
To: Alex Cheema <alex@exolabs.net>
Cc: oliver@neukum.org, bjorn@mork.no, oleavr@frida.re, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: 6BDFC4B07DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283329-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Apr 2026 18:57:39 +0100 you wrote:
> Apple Silicon Macs expose two CDC NCM "private" data interfaces over
> USB-C with VID:PID 0x05ac:0x1905 and product string "Mac". This is the
> same protocol Apple already ships on iPhone (0x05ac:0x12a8) and iPad
> (0x05ac:0x12ab) for RemoteXPC since iOS 17 -- both data interfaces lack
> an interrupt status endpoint, so they rely on the FLAG_LINK_INTR-
> conditional bind path introduced in commit 3ec8d7572a69 ("CDC-NCM: add
> support for Apple's private interface").
> 
> [...]

Here is the summary with links:
  - [net-next] net: usb: cdc_ncm: add Apple Mac USB-C direct networking quirk
    https://git.kernel.org/netdev/net/c/a5148bc2fa27

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



