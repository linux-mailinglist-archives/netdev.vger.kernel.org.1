Return-Path: <netdev+bounces-259014-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DkOH1xRlGktCQIAu9opvQ
	(envelope-from <netdev+bounces-259014-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 12:30:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E671E14B5ED
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 12:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D540A302AF04
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 11:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF39332EB2;
	Tue, 17 Feb 2026 11:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DN9+9ItP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F6432C326;
	Tue, 17 Feb 2026 11:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771327813; cv=none; b=se8/3tUfvjOLOuFrp9x1F8aKXUK1z6tjCnv2qxak4FqvC2pR0jw+Rro58CTJei0fvjfwVXmK/3l26rbkUODXvlNNfBjBsDjmGWlHYAKL6HUPUYO1F5OCFe4joz6TAW6Nz22p2r1JHK/uAhl93jqK+Dgntyb13A/heljbcdELY+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771327813; c=relaxed/simple;
	bh=9Xhjc0OBvj/8d1Ycss2igtE1RRYYJfTZXJlDYJwMHGU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JOJir/QPak4V9uPLbyUYDJwz2dveYZtaKJqzy/j31OBnLOJtQdmiBCPWTuRCVffXe/xgS0TB/2R4f+jTRa9bfI2K/eQVePsbUKZNLo7yIQQjgKAQOy+t3gr61PokwtPdn35GfGpaaZDcUtGcYul+eDEsWz2PN4wtU/t8MqTc7+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DN9+9ItP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4BE2C4CEF7;
	Tue, 17 Feb 2026 11:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771327812;
	bh=9Xhjc0OBvj/8d1Ycss2igtE1RRYYJfTZXJlDYJwMHGU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DN9+9ItPkX7TK75tlWl/OFY5jRouD6xhPk3H0yQ2mQ24Vl3nvIanU6svfg12/kBfs
	 GgZUBIlwaS7nUa2PqTPRay/a7XzcIueJDaL0MpDdd5IKd6LokLZg95De+r1UaBq+hn
	 3mXtRSiBbMTdqWo5z5RJtBgT7QwqQvQJMrju7xts7/CTvpMPIdIQp02JkFVTdeYYMT
	 5MceVVJiHbqKogyESIuDahuo4k7XnG5lOI06PsaGAPH1olZVquyEsWG6eSSYzgVK/z
	 QqCqzl8YKrWYM/mStUUa/wz2PRA+cp+NjCXv4RBhRvc4eKy40HbTIHwyUExq9/GxEI
	 Q1CBPxoZsReQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B2A4380AAD0;
	Tue, 17 Feb 2026 11:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: arcnet: com20020-pci: fix support for 2.5Mbit
 cards
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177132780483.32659.10566185049614469441.git-patchwork-notify@kernel.org>
Date: Tue, 17 Feb 2026 11:30:04 +0000
References: <20260213045510.32368-1-enelsonmoore@gmail.com>
In-Reply-To: <20260213045510.32368-1-enelsonmoore@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, horms@kernel.org,
 m.grzeschik@pengutronix.de, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, zheyuma97@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,pengutronix.de,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-259014-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E671E14B5ED
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 12 Feb 2026 20:55:09 -0800 you wrote:
> Commit 8c14f9c70327 ("ARCNET: add com20020 PCI IDs with metadata")
> converted the com20020-pci driver to use a card info structure instead
> of a single flag mask in driver_data. However, it failed to take into
> account that in the original code, driver_data of 0 indicates a card
> with no special flags, not a card that should not have any card info
> structure. This introduced a null pointer dereference when cards with
> no flags were probed.
> 
> [...]

Here is the summary with links:
  - [v3] net: arcnet: com20020-pci: fix support for 2.5Mbit cards
    https://git.kernel.org/netdev/net/c/c7d9be66b71a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



