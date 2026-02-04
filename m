Return-Path: <netdev+bounces-256543-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBc1A1zAgmljZwMAu9opvQ
	(envelope-from <netdev+bounces-256543-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 04:43:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82704E1577
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 04:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 278BC305DED7
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 03:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661552D739C;
	Wed,  4 Feb 2026 03:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3advtPv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429D1243954;
	Wed,  4 Feb 2026 03:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770176599; cv=none; b=WwJ0EETxuH+E2x9Ln/Ho7SQNYbOCTyS+uXoHGJpzcnerDmoypTuIavVocb9UYRJhE1EXBMuoJ15WxV5PjHQ+YHklk19d4fcGXf2UAe+26nkPVlGjvaYOAp/RS7NQ35i8Y3uLLxQrgJnRzmnVbT3ogzss8y1nG0Lk3U4KY/CdFwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770176599; c=relaxed/simple;
	bh=+RJqmiyAzURP+SiDWU6A61LOWyKxb+Ncd3kVeaDbjq8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J4cckujtBG56k5RQDshZf+x6ksFkfIhqbGcq6YFvtJcJ47NaFzbCf92JYWX/o0cEJxEGW41xAvCgV7T/nXD2esg35YD7aI/PPZm5x/hQp6wbInzx+Kt2BoLWe9y6dmrf6KtS5fp9OuuTTB2235JrggqqzRdJDZldHipK5Zv/xVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3advtPv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA77C4CEF7;
	Wed,  4 Feb 2026 03:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770176598;
	bh=+RJqmiyAzURP+SiDWU6A61LOWyKxb+Ncd3kVeaDbjq8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e3advtPv+Grmivuh2wDpf9EsU3ATDvBpOIJYSJ4RJQuXTVim7rl1jpKS47bTKXDFT
	 aME4vlmsJeFDLKg685u7iGcC8v5UonoTA6TWUeYxs68NPN3JL4DE3XXGtF5Ci9LeYv
	 xaxml5Qay1gpOIaCrO8/WDvh1miGugwLtdZF///ThAk0WwePFTmstreNPhyUtU1Ot8
	 lBO9nxTElLRZRPx3Fai3CYdCBGPNIh6WW66s9n+D7ZimZuMTugNaG2FNl0JegTr3z0
	 tktMZKosBAZNmBtuwNiSISg5Uz8sY2RMtK6+aa8Y0t5sOKd+cWxD+PxN8Tfm5VXbBz
	 QwEjdvewwj/Hw==
Date: Tue, 3 Feb 2026 19:43:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, Simon Horman
 <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Eric Biggers
 <ebiggers@google.com>, "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>, Peter Korsgaard <peter@korsgaard.com>
Subject: Re: [PATCH net-next v3] net: usb: sr9700: remove code to drive
 nonexistent multicast filter
Message-ID: <20260203194317.07432b29@kernel.org>
In-Reply-To: <20260203013924.28582-1-enelsonmoore@gmail.com>
References: <20260203013924.28582-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256543-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 82704E1577
X-Rspamd-Action: no action

On Mon,  2 Feb 2026 17:39:09 -0800 Ethan Nelson-Moore wrote:
> Reviewed-by: Simon Horman <horms@kernel.org> (from v1)

Not sure these annotation on the get are useful, maybe add the notes 
in the change log? Once this is committed the changelog is discarded,
it is no longer relevant that v3 was applied. If anyone wants to do
more research they have to look at the ML archive.

