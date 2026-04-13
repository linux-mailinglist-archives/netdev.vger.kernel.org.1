Return-Path: <netdev+bounces-278202-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKsxIMBg3WlpdQkAu9opvQ
	(envelope-from <netdev+bounces-278202-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 23:31:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EED493F38A1
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 23:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9AD7303EEA0
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 21:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB7C395273;
	Mon, 13 Apr 2026 21:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FATgJwyr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4E839525E;
	Mon, 13 Apr 2026 21:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776115873; cv=none; b=Yp8CkKOW/UuKOsKZJCsIVYsOlxyFKA4N+r2KTh5aPKZzBeS6YFivZnp3v3JAi/4FBSD+VXojdtfESEQteMHQuoehRLANYOpJeBV/8llmVVV4Mr5nHNXqsdS0/2rOzv5pvQLNr2DkHxWoOMuoXLU+EoRseA1FP5tBvWjTXPw8Oy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776115873; c=relaxed/simple;
	bh=wsKdTF8nfHymkiOpuDUjPKVHg8i8QZ6B4tycIu4oiJs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KNGgqWLmOn0t1NvHFV1FqcwgU+05kLeg3LaEqE4YdwOGZaiAQq1Jy+udUUacl7SMuvYgIMK6gVS0OSBH0cHXApjC7akdvFHbmR1Y2DXG6NnLnB8HtN7TTtDEfsq+NpiKlBMhgJ3vUcBhiIyGYEsJzT61uSnz2R2O18SoSLnE1mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FATgJwyr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344E4C2BCAF;
	Mon, 13 Apr 2026 21:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776115873;
	bh=wsKdTF8nfHymkiOpuDUjPKVHg8i8QZ6B4tycIu4oiJs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FATgJwyrou+Ow95AQAxOX0IO9ITzI82SNIKQ/Gh3qXzZxXKfpeyWUcZq43ZzLwc3o
	 6qqSZgxNT6vpz6/lJpVnVh2Y/srEt1VJ55T9sJHsOxrb87oqNVp+LOiBAuzBcm9pk0
	 ixC22vzQKWqllX0Kw/ZivwDCAKTEO3Ry93NMYUsdmNNs/mlii9vjZIBBRKDy7mPEfO
	 UDaAN/pkzfQMaVQnc0J4oykoLg+h5Vpm2PkSR2zYxclaA9f5+f5nZbJ2lxkd2g1Qph
	 iqJgdz3gX25gdqpkhmNy7YXUM6gNFL5f+LjtS07JpJbmPWZ2CdVmbgNTzkUwTOc6Ex
	 ChPSshP/WLGxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9DF23809A0C;
	Mon, 13 Apr 2026 21:30:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth-next 2026-04-13
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177611584454.554657.15751070808714863361.git-patchwork-notify@kernel.org>
Date: Mon, 13 Apr 2026 21:30:44 +0000
References: <20260413132247.320961-1-luiz.dentz@gmail.com>
In-Reply-To: <20260413132247.320961-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-278202-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EED493F38A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Apr 2026 09:22:47 -0400 you wrote:
> The following changes since commit 42f9b4c6ef19e71d2c7d9bfd3c5037d4fe434ad7:
> 
>   tools: ynl: tests: fix leading space on Makefile target (2026-04-09 20:41:40 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2026-04-13
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth-next 2026-04-13
    https://git.kernel.org/netdev/net-next/c/e9dc62f25ba6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



