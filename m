Return-Path: <netdev+bounces-269862-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OGOKlURvWlf6QIAu9opvQ
	(envelope-from <netdev+bounces-269862-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 10:20:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BB62D7E76
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 10:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C8DE302C908
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 09:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99436344DA0;
	Fri, 20 Mar 2026 09:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ks/aEIW2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768EE3431FD;
	Fri, 20 Mar 2026 09:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773998355; cv=none; b=P+zwPgPFuKNJ/oNnfwYr/NWD0pBF3K0tCt/f/OJxyiUvWha7pP9HnIffRGW5sV7jPuQl8bgk4KzSLhDGy2ybj2eUWeE3YN6WKkZIvqmiu7qDAz+AIc37XjETrtCdaKnop0yxT570eyQp7G3mZuP5OHxnqJf94/cLzh55wMZgvmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773998355; c=relaxed/simple;
	bh=JLKw73ohj/QWfUHrQUxCpAL7Gq62XIAzZiPnKSwJqhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPJQDmdIFY/PHhTKunUAZEZhUzYB8M5vGXGPkVTRZHwDJGXYUAWp10IeLvx9FdSlMZxB5M3Rix1xoyHqlOD74LdP/UyyEA6GSXhckatdv9OM+MCAeW/aJZ5KpGLmDHdr89hP9opSZfIF3rIRvtKvdOkPbbCmI0of1g4bvO6dxYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ks/aEIW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BFBC4CEF7;
	Fri, 20 Mar 2026 09:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773998355;
	bh=JLKw73ohj/QWfUHrQUxCpAL7Gq62XIAzZiPnKSwJqhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ks/aEIW2RkRuah1iRt1pbQ2uxhWxOeymIEAkVo1q9pBfP0Lq78j33l9pG+AQMAmIL
	 YgKKb7LYyIPbskUm1PHE7HItIoT8puuK+etnLvCEq7bbExtL0CGlr0xJXuUYcnMaUU
	 l1td14x5KBuNNEKiSwK7p/dcSiVFVRRw8FMz77ZzmL5sna8+NMZ811Vw4H0TNdRG3n
	 PifvmechBcrs6FOvRVtkmituwlbZJ809PTHoVhApWZ23h9iz2IMQi82szXWSFEzRmT
	 zZLM/jBn4g27Fjf4xGzizxASRaPmvEGLTk/632wk9+As2GB0eV4OZ1I9gYp3bNPiXe
	 slh5EU/j4Lvgg==
Date: Fri, 20 Mar 2026 09:19:10 +0000
From: Simon Horman <horms@kernel.org>
To: Qingfang Deng <dqfext@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCH net] net: airoha: add RCU lock around
 dev_fill_forward_path
Message-ID: <20260320091910.GA2048760@horms.kernel.org>
References: <20260319032649.337812-1-dqfext@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319032649.337812-1-dqfext@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269862-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.979];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 16BB62D7E76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 11:26:49AM +0800, Qingfang Deng wrote:
> Since 0417adf367a0 ("ppp: fix race conditions in ppp_fill_forward_path")
> dev_fill_forward_path() should be called with RCU read lock held. This
> fix was applied to net, while the Airoha flowtable commit was applied to
> net-next, so it hadn't been an issue until net was merged into net-next.
> 
> Fixes: a9af709fda7e ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>

I understand from the patch description that the problem didn't manifest
until this merge commit. But nonetheless I don't think using
a merge commit in the Fixes tag is the best approach. For one thing,
it seems somewhat difficult to use effectively to guide backporting.

I would suggest using the flowtable commit as the fixes tag:

Fixes: a8bdd935d1dd ("net: airoha: Add wlan flowtable TX offload")

Or perhaps fixes tags for both a8bdd935d1dd and 0417adf367a0.

Flagged by AI generated code review, which also suggested citing a8bdd935d1dd.


...

