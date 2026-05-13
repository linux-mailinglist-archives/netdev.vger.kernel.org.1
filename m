Return-Path: <netdev+bounces-287383-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNeCExrWA2ol/AEAu9opvQ
	(envelope-from <netdev+bounces-287383-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 03:38:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C1452BFF8
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 03:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B1E330B4FAE
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 01:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54739387563;
	Wed, 13 May 2026 01:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cd+D5pxv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335B5386568;
	Wed, 13 May 2026 01:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778636160; cv=none; b=C87iov0Bnj3aGhslsaPjoegDVxuR0mwKMgr6lozdHle5LsWKKZ/GjK0l5xLERUzKeEMPU4FGB9/qYaRXMhiLODvMaPexX54sOZaBh1p6YPng13fSNzTvKGWSjKQM4iEofIf/ogM79v0YAjbxkm30oLyJjV+2PmxC8aXoYSCXwHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778636160; c=relaxed/simple;
	bh=L+4/4cgw69hKnq0XzLW40Qz55POgPrw9dVtvP1ThgBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWKZu2BcXVI4FuWQLhhxhJGffsmHtwb9EgeYQ9BeoDH5m8g5X6dy0nBAcuLsWJ97vZ3Wyvs/4wx9Hr3cCE7YJk02uQWXITRS1rCupGS9M614glSN6GWDmtDAlbuVvo++yJgMCjJ1pLILYngIMR2WCmjCUfvli0FrqiOYMufiKzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cd+D5pxv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4AABC2BCB0;
	Wed, 13 May 2026 01:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778636159;
	bh=L+4/4cgw69hKnq0XzLW40Qz55POgPrw9dVtvP1ThgBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cd+D5pxvevRxCMWvAUT1Du3SsjTqHa2vPl3JtAVbHJkbP8HJqnCqcUgRv4w3hUzLX
	 osvmH2s7a7KtsBqPz0ZEkQf17wjGU8Zkag/4qnQqvc5Q6px3YvmdnsYtBHMEZ1pPX0
	 8zCrtwRIRnQdnpiNFu80XcZhcYIm5mOFGLCLCBjIjG3qAzFK2jQoyP8IHt7O1le8bE
	 nTVGO45+4NS5JyGPh66fGni8GRBPAerk3Fg6fC4MWYNWs6Z57IK1FtDr4UCkiNxy7f
	 1Y6hA1ZQoYw/1wOopNDtFkQO2LiXrx0Ax1YbEhTjgf1x4MshrRe9TLYerSYW44iAiA
	 KsxP16ATLYuxQ==
From: Jakub Kicinski <kuba@kernel.org>
To: michael.dege@renesas.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	yoshihiro.shimoda.uh@renesas.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	niklas.soderlund@ragnatech.se,
	paul@pbarker.dev,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 11/13] net: renesas: rswitch: add passing of rswitch_private into notifiers
Date: Tue, 12 May 2026 18:35:57 -0700
Message-ID: <20260513013558.1408479-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511-rswitch_add_vlans-v4-11-a5a225f8faae@renesas.com>
References: <20260511-rswitch_add_vlans-v4-11-a5a225f8faae@renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E9C1452BFF8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-287383-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: renesas: rswitch: add passing of rswitch_private into notifiers

This commit updates the notifier registration functions to accept a pointer
to the rswitch_private structure, allowing the handlers to access the
hardware.

> diff --git a/drivers/net/ethernet/renesas/rswitch_main.c b/drivers/net/ethernet/renesas/rswitch_main.c
> --- a/drivers/net/ethernet/renesas/rswitch_main.c
> +++ b/drivers/net/ethernet/renesas/rswitch_main.c
[ ... ]
> @@ -2290,7 +2290,7 @@ static int renesas_eth_sw_probe(struct platform_device *pdev)
>  	if (list_empty(&priv->port_list))
>  		dev_warn(&pdev->dev, "could not initialize any ports\n");
>  
> -	ret = rswitch_register_notifiers();
> +	ret = rswitch_register_notifiers(priv);
>  	if (ret) {
>  		dev_err(&pdev->dev, "could not register notifiers\n");
>  		return ret;

If rswitch_register_notifiers() fails here, does this error path skip
cleaning up the initialization performed earlier by rswitch_init()?

It looks like rswitch_init() registers network devices, but this error path
returns directly without calling rswitch_deinit() or the runtime PM puts.

Since priv is allocated using devm_kzalloc, the memory will be automatically
freed when the probe fails. Could this result in a use-after-free if those
dangling network interfaces are subsequently brought up or receive packets?

