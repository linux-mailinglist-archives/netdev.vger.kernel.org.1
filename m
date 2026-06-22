Return-Path: <netdev+bounces-301171-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oJiGDkBpOWpDsAcAu9opvQ
	(envelope-from <netdev+bounces-301171-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 18:56:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C652B6B151B
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 18:56:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TQkcMY9J;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301171-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301171-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 040EE30302B0
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 16:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5239833A9CB;
	Mon, 22 Jun 2026 16:54:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2AA1C84BB;
	Mon, 22 Jun 2026 16:54:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782147273; cv=none; b=jdSHmoZAYxKR830nsa/XdeWtkyEVjBOa/3PFa6ySDYz6aWB/CKhT6EvKfCDOz5mz7oCYNFyYDEUBLgTGvMX4/k1sMgF7rGok/yEkeGslGiGXYgVSmfNnsPfVqsHzW578dmYjtkKkDqFeK8cqBM8bPCoUeE/mxH2AkGIL/udBf/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782147273; c=relaxed/simple;
	bh=rEY+22WAuXME+zioy8ofXflaeALQWMHJmwoPTm/7Jbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pX/+tymZfrPA4pJfCo+zPSuAfl9IakT+TMnobOkQmLrUSLC0v4Bgz2Pf4I1NiO2q15cUy62010dMokYJpoueJA/xAam/83DLvw8kp80fbDQo98cCamswzzAvf3lxQ+4SvyGAf7cEkYMmCs8ynE5FqrQUyqXJTCZgxA/P9TM1VHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQkcMY9J; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7471F000E9;
	Mon, 22 Jun 2026 16:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782147272;
	bh=y+lj1QJg9sxCSW1aSWPJx2v9fHhZXZxcmOxmuF6AeJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TQkcMY9JgrYdqvTC3T35BV897IzjZIDJarS69IG88ey4XzSKe+jYKkubV96OEX3bu
	 4wNOlOQc9lfIstffNUOckztFvFuL9hBiii8b/xVsVKegIUlHM5+Ih9qfRKF2JlrG/+
	 7yOlXYREX2a5+fKQywtEVjM0jh3/4xxj1+ph1CgzAJ/pRgAA9+uTO9tKgrbgjeVDCm
	 VD3b76kcaASV5dLhZidk1VW0bIGYO6lYmnqZ5COkHCNizSUa12QjN1xbCF7WBLDhIU
	 uhjB3utWYrEwGe1JnJ5mluoMEuKg63u3lCW1camAdTXeW4vdQCbeYPYTQNF4dT5cxW
	 idjnDVnBOwmGg==
Date: Mon, 22 Jun 2026 17:54:28 +0100
From: Simon Horman <horms@kernel.org>
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: Re: [PATCH net] sctp: fix err_chunk memory leaks in INIT handling
Message-ID: <20260622165428.GI827683@horms.kernel.org>
References: <0656704f1b0158287c98aec09ba36c83e4a537ab.1781970534.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0656704f1b0158287c98aec09ba36c83e4a537ab.1781970534.git.lucien.xin@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301171-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:lucien.xin@gmail.com,m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:marcelo.leitner@gmail.com,m:lucienxin@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C652B6B151B

On Sat, Jun 20, 2026 at 11:48:54AM -0400, Xin Long wrote:
> When sctp_verify_init() encounters unrecognized parameters, it allocates an
> err_chunk to report them. However, this chunk is leaked in several code
> paths:
> 
> 1. In sctp_sf_do_5_1B_init(), if security_sctp_assoc_request() fails after
>    sctp_verify_init() has populated err_chunk, the function returns
>    immediately without freeing it.
> 
> 2. In sctp_sf_do_unexpected_init(), the same leak occurs on the
>    security_sctp_assoc_request() failure path.
> 
> 3. In sctp_sf_do_unexpected_init(), on the success path after copying
>    unrecognized parameters to the INIT-ACK, the function returns without
>    freeing err_chunk, unlike sctp_sf_do_5_1B_init() which properly frees
>    it.
> 
> Fix all three leaks by adding sctp_chunk_free(err_chunk) calls before
> returning in the error paths and on the success path in
> sctp_sf_do_unexpected_init().
> 
> Fixes: c081d53f97a1 ("security: pass asoc to sctp_assoc_request and sctp_sk_clone")
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


