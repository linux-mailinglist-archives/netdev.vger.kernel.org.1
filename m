Return-Path: <netdev+bounces-251722-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDyrEsI9cGnXXAAAu9opvQ
	(envelope-from <netdev+bounces-251722-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:45:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A644FFD7
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A4A7D7EF604
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B50350A06;
	Wed, 21 Jan 2026 02:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkc5puMY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E84350281;
	Wed, 21 Jan 2026 02:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768963239; cv=none; b=QdPOCltBrQo+A7sxSx5AijqFYeROTVCvBAkjSEac1TgSF5NGc4/I5NjEAk7TtqVZNP4LVJyKcMduGPoJX8zV83p5t+OMHIOnMjRTla6bdVxFDDXylYVGRjZgh2uTLrHMFzIuSkA9G3s5fXvY1Q9xpulaItj6aokOsklm3DTsaDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768963239; c=relaxed/simple;
	bh=EnxmJpB0NNpUFsPj1aBMHwqtF7MLvVsZNzqIxPdxnHs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Kp4sfw2eRKJHpQP2+MElFJdkZ9sQvOvGIK1GFqKUDNc5xv434HrrFkIB8IZdMvY0SIv4i3M65Lrg9ojmIz/yc2IhvfQBMAs7uEPFyGN/jE8AB38N58bGueTEcIVeb1Pp9vx3+OTO7cy0QmAsMhZECKk339jnXjaU1DdgDmfGFNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkc5puMY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3983AC19423;
	Wed, 21 Jan 2026 02:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768963239;
	bh=EnxmJpB0NNpUFsPj1aBMHwqtF7MLvVsZNzqIxPdxnHs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tkc5puMYIZjgRzpKl3bQBzZC9fQk7SsejO9P2ojofZLMZSvmEw9JnxqD5ud03WCk2
	 EVYpjKkMZguUjN+jt21GSw32kO1Wl4jJLapYrJAZY0mWEMm4cTeozOhuoXYsJxmOxJ
	 UNC86Fwkg5gTl6mVtntLFY88qknKtuBJnzKJ6XdVNw6JKlTZHOKkRCZMuThwpWJ5c9
	 ZGiypji31+BnOBBU6Xy29gMSlMaekjP7BhtN7K5DVfm+4ieUC1itRAz4+U0AgGxiUi
	 19BcpjwSoYUwp9gIPGaIvQUO828rPRI1PHyLE4ujBRJx0M+Nt8UnlmYPcpmdij8GxL
	 uc9WTfy+KVM4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8CCF380820D;
	Wed, 21 Jan 2026 02:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: usb: r8152: fix transmit queue timeout
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176896323659.699622.12478505738537738657.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 02:40:36 +0000
References: <20260120015949.84996-1-insyelu@gmail.com>
In-Reply-To: <20260120015949.84996-1-insyelu@gmail.com>
To: Mingj Ye <insyelu@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, nic_swsd@realtek.com,
 tiwai@suse.de, hayeswang@realtek.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251722-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 24A644FFD7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Jan 2026 09:59:49 +0800 you wrote:
> When the TX queue length reaches the threshold, the netdev watchdog
> immediately detects a TX queue timeout.
> 
> This patch updates the trans_start timestamp of the transmit queue
> on every asynchronous USB URB submission along the transmit path,
> ensuring that the network watchdog accurately reflects ongoing
> transmission activity.
> 
> [...]

Here is the summary with links:
  - [v2] net: usb: r8152: fix transmit queue timeout
    https://git.kernel.org/netdev/net-next/c/833dcd75d54f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



