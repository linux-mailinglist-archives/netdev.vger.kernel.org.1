Return-Path: <netdev+bounces-252981-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0A4ROJD0c2ny0AAAu9opvQ
	(envelope-from <netdev+bounces-252981-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 23:22:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FBB7B1AF
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 23:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31A05301F337
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 22:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EE42D47E4;
	Fri, 23 Jan 2026 22:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjc/MuJ8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B952D193F
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 22:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769206898; cv=none; b=OUFTeI9NeHZ0WtmyBaLTxjR1RIMtnFeD8XplI+azJ0dNZMlzVoidhroPYVi4fSQE0ci3CxBC5VfwTQpuA2YG5bkHhyG4/+guPVVVTT30Pj8F7+Y30At3gaj1REkuxyI0wJjzM+lgINV5XJXhkjGsC0lpb2zTfdHIkw9bLH6i66g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769206898; c=relaxed/simple;
	bh=T6TR1jTlNaaH5ct2xSbGhQbjFlDMgajXDEqI0PznqoE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j5KF9cUqRaZXgM3+MPcyGPz887UGpAPg2TkdWfKPKnU4Ck5QUkrN228eENzGzmz2KgzsuEM4n+PtDR/ZsrZ9tArXT3Dq0zPDVA6vU2WB9yfdhnRQMqdAM49H03LkS+t7SZEk7pL7xSu/7qIZD/0eOKuYVy+P66MdCW5j9fJ6e44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjc/MuJ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E6FC4CEF1;
	Fri, 23 Jan 2026 22:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769206898;
	bh=T6TR1jTlNaaH5ct2xSbGhQbjFlDMgajXDEqI0PznqoE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gjc/MuJ8hQnBzGRhgy0F0ebTR3o+QbKFj/xbAdjBq5jiRaYlJWfzRTsWze3U60bWS
	 bfs/E74p07tJK/28jszeBoE/ZEjcEVy35+uXWYZa40klu2N1+4KBAcgb9auLphxx+B
	 9lQ+X+N2fk2Xi7C8Vb/izs/Fm5KcovDAtjHu/7L8/1mBppuN0A6W7gWqIuyUWKNg0g
	 WiczZDcgKRQFPV5495yQbGseSSb7SV5CJybIQYVZ5hnkBaBKokTgzhYVwdodpFIe1c
	 V7A/reLG3V2Rc6MXUPWWMJFSZY9O3fNZJJRvnbRJSnaeJ1phhQFlcF93Kwn0xhsXWA
	 SdQdckE/R4K/g==
Date: Fri, 23 Jan 2026 14:21:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
 alexanderduyck@fb.com, alok.a.tiwari@oracle.com, andrew+netdev@lunn.ch,
 andrew@lunn.ch, chuck.lever@oracle.com, davem@davemloft.net,
 donald.hunter@gmail.com, edumazet@google.com, gal@nvidia.com,
 horms@kernel.org, idosch@nvidia.com, jacob.e.keller@intel.com,
 kernel-team@meta.com, kory.maincent@bootlin.com, lee@trager.us,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH net-next 0/3] net: ethtool: Track TX pause storm
Message-ID: <20260123142136.21ddc213@kernel.org>
In-Reply-To: <aXPiZ8H-usRn1pcD@pengutronix.de>
References: <20260122192158.428882-1-mohsin.bashr@gmail.com>
	<aXNAjOjkCqOESf5y@pengutronix.de>
	<aXNbTVF5KNz1yV-1@pengutronix.de>
	<20260123104031.16d914e4@kernel.org>
	<aXPiZ8H-usRn1pcD@pengutronix.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252981-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,fb.com,oracle.com,lunn.ch,davemloft.net,google.com,nvidia.com,kernel.org,intel.com,meta.com,bootlin.com,trager.us,redhat.com,linux.dev,pengutronix.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 77FBB7B1AF
X-Rspamd-Action: no action

On Fri, 23 Jan 2026 22:04:39 +0100 Oleksij Rempel wrote:
> In my tests, I was able to trigger an Rx stall and a pause storm (if
> flow control is enabled), for example by partially disrupting the USB
> connection. Since this controller is used in medical devices, it will
> be good to detect these anomalies and attempt recovery.
> 
> Sorry, here I want to hijack this discussion for my purpose :)
> 
> Since a pause storm is only a symptom of an Rx stall, should we have a
> common method to detect it? Is it even reasonably possible? In my cases,
> I tried to detect it by monitoring the level of the Rx queue, Rx HW
> counters, and Rx SW counters. But maybe I just have a blind spot and
> this is a naive way to detect things.

Not sure what USB connection disruption entails exactly but there's
presumably a lot of things which can go wrong in critical infra and
for which some daemon must periodically check and remediate.
IDK if this belongs in the kernel, but perhaps folks with more embedded
experience would find it useful.

