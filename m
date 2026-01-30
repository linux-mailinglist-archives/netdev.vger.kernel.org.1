Return-Path: <netdev+bounces-255004-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIRiHnMjfGnJKgIAu9opvQ
	(envelope-from <netdev+bounces-255004-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 04:20:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D55FB6C81
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 04:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B906F30120E6
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9279284665;
	Fri, 30 Jan 2026 03:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDZoCuJY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CE52AF1B;
	Fri, 30 Jan 2026 03:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769743216; cv=none; b=QHANGdNlNLF/C/98QGhe7RZaZwhXcQK4OX1jZrvvF8gZ7DwN5BhZbo9gh3MWWpv51APkKnfNz2GJLDxD+aewpnPgY1qmrjc2qTy206YFIyigr9rVlP/YodglhtIHFbA+Z/G3sqTsFtbQH8ZoAwKrk/nLkGdA7j7UnxcAOhK6SOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769743216; c=relaxed/simple;
	bh=eNtq/xiCws8a5zOs02HkAb+y7OIE8dyz6CZ/Wn19U54=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iW8EH4IzckUkKrUr58p3bJH5vqO3KsTsM8US3v687DH1ebs/sVD0z71avipnGa2jKnRa7QrQrIKafpwQ/tpPk0fpxiyrERRC+R7ow4NOasC/CB1AJT/TlBzEaC0zLdGle+LZZ6gKMJ9/dd8fK/YhXqZqwWCw4CHY13uoYkhdr38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDZoCuJY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E53C4CEF7;
	Fri, 30 Jan 2026 03:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769743216;
	bh=eNtq/xiCws8a5zOs02HkAb+y7OIE8dyz6CZ/Wn19U54=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nDZoCuJY4trh2lYLNh/UjWlmKELK2sppSTkJByjAiONCJNryB15CUr3kIhemxEEkR
	 4+KMy1gQmI3HnBLlolx9EFdy7LfOA59Ha5S8LcuHUczV1qK8Jz9fLVQQ2g3Ulm4GOi
	 xUEPCVP1Og2stvWR1XW/xkAtB98LCPkq1kkTC39c75VEMFYzYR5dqhQrth83XIYrAb
	 sK9RdZJEbu0gLAQmzie9FS8o/hTcpZ19U5OkohI3urwop3SIDSfGkr+0vucxImIci7
	 HjdmbnSi2QqLwUmxl3FCigQix4LpYLq8Cxws1Q0UW4OnfKGk8XlFbEfraXAb6zE/lS
	 li1Lpovhyf9rg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11A62380CEE0;
	Fri, 30 Jan 2026 03:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/3] Airoha AN8811HB 2.5 Gbps phy support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176974320885.3156878.13001931519129200363.git-patchwork-notify@kernel.org>
Date: Fri, 30 Jan 2026 03:20:08 +0000
References: <20260127125547.1475164-1-bjorn@mork.no>
In-Reply-To: <20260127125547.1475164-1-bjorn@mork.no>
To: =?utf-8?b?QmrDuHJuIE1vcmsgPGJqb3JuQG1vcmsubm8+?=@codeaurora.org
Cc: netdev@vger.kernel.org, lucienzx159@gmail.com, daniel@makrotopia.org,
 vladimir.oltean@nxp.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,makrotopia.org,nxp.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:-];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255004-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	NEURAL_HAM(-0.00)[-0.499];
	TAGGED_RCPT(0.00)[netdev,?=];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0D55FB6C81
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Jan 2026 13:55:44 +0100 you wrote:
> The RFC patch posted earlier has been split into a series based on the
> feedback received:
> 
>  1/3: preparing the EN8811H driver for maximum reuse
>  2/3: adding support for the new AN8811HB hardware
>  3/3: adding (optional) clock driver for AN8811HB
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/3] net: phy: air_en8811h: factor out shareable code
    https://git.kernel.org/netdev/net-next/c/28693bceee97
  - [net-next,v4,2/3] net: phy: air_en8811h: add Airoha AN8811HB support
    https://git.kernel.org/netdev/net-next/c/5afda1d734ed
  - [net-next,v4,3/3] net: phy: air_en8811h: Add clk provider for an8811hb
    https://git.kernel.org/netdev/net-next/c/0a55766b7711

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



