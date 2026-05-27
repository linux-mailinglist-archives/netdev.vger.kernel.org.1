Return-Path: <netdev+bounces-292259-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHwIDZ3dFmo9uQcAu9opvQ
	(envelope-from <netdev+bounces-292259-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 14:03:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D79065E3CB5
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 14:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C599A30054D5
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AF6275848;
	Wed, 27 May 2026 12:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTlbxlv2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63F91AB6F1;
	Wed, 27 May 2026 12:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883418; cv=none; b=t3Ree9xTA1RvlUeIxhogUOrJT897i4ETL2nOOkSctYyl3BJeKlGCbFg3AIbXbMFaU++Zgu7SOgzX8ZJcgOoyAaErmbc0wXjhlR6b2PjzFOQb03mvBGCvN3R9r1K4gi6KDiFSdnxdoMEJa4+YLTYW0tcONONqkHMVws0/jgCeFnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883418; c=relaxed/simple;
	bh=a496n5sTC7BfmYWW6eYgn0TqTm9K39oP4g8vv+LxFjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KU5WP4IZS6fMHpdeIb7klAuYswl0BkvKKjjY5QYvUIdqXX5v8ki85i5OwiJNdpAVY4f8kw2Ll94e0MozFR7pZUnMI/bKsXuiY+Zdsswbi9Vz3+yvMlBFu5TbNpddo3hcdI6BuNFneilJ7V3sp58pbqfx8gGSx0eJIUmGMlrrb7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTlbxlv2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C011F000E9;
	Wed, 27 May 2026 12:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779883417;
	bh=MgyJIuDX8DjcMC2ItkXGm+xZ0l0lqXTDmtritZLXgZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MTlbxlv2Ej5I5fbPMMBpHlV8MAjfxrRNflR69autOhX7r3iw+mMialUKnCM9+WQ0p
	 pAQ5NVccVYPbD8en2OImYICzCvZ5OP6RuR9UObs5wfrfuIAAq/oaApKv6akPly1wSN
	 NzrUhAd1bjbWc+nvIzmKuQcY3vhgHN5emDXKImSGQ9nsgDnTbtjS5+Exm/+wvqeVeM
	 8/3nBfjpyNd9bqR7PNo5WCsfzbgCqVje7NgW+ixrGngucGUADZOe2GfUHDcD7HfUs5
	 7ejvj8JGYFdL5BBdmbjhHhJyDDkog4QVTh85XB6eJo/+f3cdkcYdV/n7F6D6CzINin
	 nL9y+E5uxg+hg==
Date: Wed, 27 May 2026 13:03:29 +0100
From: Simon Horman <horms@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Amir Goldstein <amir73il@gmail.com>, Tim Bird <tim.bird@sony.com>,
	Christian Brauner <brauner@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/dns_resolver: consolidate namelen checks in
 dns_query
Message-ID: <20260527120329.GL2256768@horms.kernel.org>
References: <20260525095400.821912-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525095400.821912-3-thorsten.blum@linux.dev>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,sony.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-292259-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:email,horms.kernel.org:mid]
X-Rspamd-Queue-Id: D79065E3CB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 11:54:01AM +0200, Thorsten Blum wrote:
> Consolidate the namelen checks and return -EINVAL early if needed. Drop
> the namelen == 0 check since it is covered by namelen < 3.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Simon Horman <horms@kernel.org>


