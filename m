Return-Path: <netdev+bounces-277832-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FHDLJnG22lHGgkAu9opvQ
	(envelope-from <netdev+bounces-277832-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 18:21:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9392A3E4BDC
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 18:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE7D7300B5A2
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 16:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF10302149;
	Sun, 12 Apr 2026 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyzzqefF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB6B2D7DF1;
	Sun, 12 Apr 2026 16:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776010850; cv=none; b=p1UPzWlBaBN2V3yoqnIO5zSADIjNCeVD5hcvGvaYi1oHdL8mUzxmgJkumrvzruJGA6EWO0qHP7zBGnIEtraO0ObGN5+maN+TpQ/0gGGlU4BKqnkLIBCn1oIeYQ7EsBn+qefHcoMqSvbKu8/EEZP8dqZpJCwK3U3ePREBZhZmZnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776010850; c=relaxed/simple;
	bh=87KTUAqhEi/6QiDqlgSjG7MVIIL4jH8Ib/2N7SY7Kj0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W2U9ebCN5s40C0LldpqxU5FoBh+P1HVZyThkyuoJFVY0eOWVfNlLkCDnfxcrL/H6P1vMkX3W3y2iKU3NUnMgQMbOiE4KP9W2LgKgJWFYt4KgFG95m/Tvmf5jHIu9m6Y2LfCuqH29ZV/VI7nD53Ogc3bZOniD+sdyIcJPG8FLDos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyzzqefF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09F6C2BCB1;
	Sun, 12 Apr 2026 16:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776010850;
	bh=87KTUAqhEi/6QiDqlgSjG7MVIIL4jH8Ib/2N7SY7Kj0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lyzzqefFlJWzzPz/u3o72TBzj304mrkPvkiHXbuS0DfQUXMTK4gF1UEahtS0oMtHH
	 q+RuNXgQ5tm3SK54SGcCD+/QIKN2bLRMtjLcch4TtnDNM6xo8urMVJQYdWtnrzMKjo
	 6rXh4sp3vStko0QBKERAmFn5+lIEpOd4G71L3Gsb/575of/guxLHFw4QZjUKJJ95I/
	 CakhnaG3LgZM1r48BKieXdamNlFECEzz275wksRxcIifi1u/kqaz1F7iAc5531isX8
	 DBUIA2cFieoODfkJQFELyc6QsrtMR8Tk9PA9M1R/3yfYLSAtOSVR4Yjn5G8ajijYZr
	 QMEdhHQFIsk4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE253809A8B;
	Sun, 12 Apr 2026 16:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH 0/2] net: dsa: tag_rtl8_4: fixes doc and set keep
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177601082303.3330556.5967550202445648760.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 16:20:23 +0000
References: <20260408-realtek_fixes-v1-0-915ff1404d56@gmail.com>
In-Reply-To: <20260408-realtek_fixes-v1-0-915ff1404d56@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, alsi@bang-olufsen.dk,
 linusw@kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,bang-olufsen.dk];
	TAGGED_FROM(0.00)[bounces-277832-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9392A3E4BDC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 08 Apr 2026 17:31:00 -0300 you wrote:
> This small series addresses two points in the rtl8_4 tagger used by the
> realtel rtl8365mb driver.
> 
> The first patch updates the documentation of the tag format while the
> second patch sets the KEEP flag bit, ensuring that the switch
> respects the frame's VLAN format as provided by the kernel.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: dsa: tag_rtl8_4: update format description
    https://git.kernel.org/netdev/net-next/c/297e1f411ed4
  - [net-next,2/2] net: dsa: tag_rtl8_4: set KEEP flag
    https://git.kernel.org/netdev/net-next/c/82f37bd9a4d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



