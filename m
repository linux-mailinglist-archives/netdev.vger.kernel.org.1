Return-Path: <netdev+bounces-292030-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOxdEW5EFmqUkAcAu9opvQ
	(envelope-from <netdev+bounces-292030-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:10:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 944B05DE26D
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F1E23031EB8
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 01:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4C330E858;
	Wed, 27 May 2026 01:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqWIDflN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AFC30DECB;
	Wed, 27 May 2026 01:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779844201; cv=none; b=ZXxVBYKD+ugo1Qomvig9fwY+TGTiHgjCQOL7hkyrHanfNOGV2IrxbfbABuTgQ7aGrsgNTP9NNX0/5O4lgadl1/8QB02FooCtle5kmHGFPeJ+qarraEm7DlZMzK1n85+yBGq3Jyc8uW1GTalufSl2tuDKRGliMEdyFo/PX7ty8H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779844201; c=relaxed/simple;
	bh=Ed8x2SZHOTe5mtvj1jtmiJQLzwR1/kv1cEF6mpJ2C+0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C8ltrS8GCsdCxy8dx356EADt68b6WFX+eaG74LqzQ7SWTgKG4K7tEDxw91cTxDOwjeguAiHTMXnqaBYNRUp/kmPzmy9g88YF+cdV5oWj+T5fqt5wNyS8pQ8M/kawlIOr99+RWY5YB/9MINMvLdnc7CEnXqvgPdQflAblYhBKjHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqWIDflN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B5F1F000E9;
	Wed, 27 May 2026 01:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779844199;
	bh=OUg/v/rfIwMMXg5AHY86gULejwr6TE05UXwQnOZC14I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fqWIDflNavU53//hpKs39AqIBUSlaaXrdhINRkX2rn5TiFGis0EcS7ZinubxLZ2Oc
	 qz/aYVd0ctcF8rEvCI71jT1ZH6n8tDiorKTf4Sew33mpsywOjlqZTtNvikR040Wyb9
	 20ckuvy5aOYXBHACSL7LNwPebqWOsS6q8KR52Pu+SYie34Z3DCc0wPy3umpGQGCNWd
	 0qr4NMhPTpC+RjvRZr3wDliq9LMf5MdjttJDaRoDdguVvHmmjjU2RRxQu34fvfkdhh
	 HH73Qj37H9MnNJpPOmMU1wgSYQyj+JZI0uQP3hcGAbgCC/rEde9dFK0dDv0G/gAple
	 cCUGGi5aPykbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5692E380CEED;
	Wed, 27 May 2026 01:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6] net: phy: air_en8811h: add AN8811HB MCU
 assert/deassert
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177984420515.4036929.14528553996717645091.git-patchwork-notify@kernel.org>
Date: Wed, 27 May 2026 01:10:05 +0000
References: <20260524063915.47961-1-lucienzx159@gmail.com>
In-Reply-To: <20260524063915.47961-1-lucienzx159@gmail.com>
To: Lucien.Jheng <lucienzx159@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bjorn@mork.no,
 ericwouds@gmail.com, frank-w@public-files.de, daniel@makrotopia.org,
 lucien.jheng@airoha.com, albert-al.lee@airoha.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,mork.no,public-files.de,makrotopia.org,airoha.com];
	TAGGED_FROM(0.00)[bounces-292030-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 944B05DE26D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 24 May 2026 14:39:15 +0800 you wrote:
> AN8811HB needs a MCU soft-reset cycle before firmware loading begins.
> Assert the MCU (hold it in reset) and immediately deassert (release)
> via a dedicated PBUS register pair (0x5cf9f8 / 0x5cf9fc), accessed
> through a registered mdio_device at PHY-addr+8.
> 
> Add __air_pbus_reg_write() as a low-level helper taking a struct
> mdio_device *, create and register the PBUS mdio_device in
> an8811hb_probe() and store it in priv->pbusdev, then implement
> an8811hb_mcu_assert() / _deassert() on top of it. Add
> an8811hb_remove() to unregister the PBUS device on teardown. Wire
> both calls into an8811hb_load_firmware() and en8811h_restart_mcu()
> so every firmware load or MCU restart on AN8811HB correctly sequences
> the reset control registers.
> 
> [...]

Here is the summary with links:
  - [v6] net: phy: air_en8811h: add AN8811HB MCU assert/deassert support
    https://git.kernel.org/netdev/net/c/d895767c3378

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



