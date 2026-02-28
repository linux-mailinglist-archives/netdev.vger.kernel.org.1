Return-Path: <netdev+bounces-262048-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GyuKAORTomnL1wQAu9opvQ
	(envelope-from <netdev+bounces-262048-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 03:33:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0A31BFFB9
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 03:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A5C5D3025E15
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 02:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF2626056E;
	Sat, 28 Feb 2026 02:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Esd41S5w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF313C1F
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 02:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772245982; cv=none; b=oV2g7Pzs6GHhugmG9TjNfqafnvykmDIb5aJkIJpkAhsIt2dEDuWarxQcOq+kF/ZxnBV56FOzqQePmQrZsdVjvIGKLRT0LHvE0Ia14x6g4WTvW3Hu4gKI4HiIcKJb9WDzu/x0UfX2d8QfNzTGOCSDXFEEJTDjx5+W35kTlPQkMHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772245982; c=relaxed/simple;
	bh=yEyfz+MLheKG7FKad8hCjJKqYXd5MIqTopBanRzPx7M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gngRYXjtyYvhUYpMDNsskfrP3pHzfTjIgGCVXG9HR1jt+iVU0P84JQ79vrQFYLbNoi8vMVWrEmSUp+4Xrn2OhLv9gSEdARfbs3mUnS05VnvzMCLhxAkgDGnfgE1h/gGsO3NE4rquOzBAsGoP6YlTG6cNhz8KDl+oKft6SYeMnKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Esd41S5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ABE8C116C6;
	Sat, 28 Feb 2026 02:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772245981;
	bh=yEyfz+MLheKG7FKad8hCjJKqYXd5MIqTopBanRzPx7M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Esd41S5wn3jRV0JfcbLKCKc9uKm99wHiEEeVx/j/gxTsq+jooFgP770EPkfA18hc1
	 dKEV2LvtpoW2qFOHJ30NoNSkZ00CeMdkGD3GpkqGzRgnKvruZNjd45fkGl7Sgfz/C1
	 bALCVCJj9PsjNtYYf1V6vHuI/7n1C5H7D/NkPVhyRVCHKwTSHD2VFn9kPcxBhdIS/R
	 f+m8/Qgh9hHAa5w4FhqQr5s5DPzxm4G2DtSw1yOA4gaaBS0bBFrKMscAupTN13WuWp
	 2lKb05elcL/+JNT0Cgd9lvRg7qdBWEA8gna/uJ+ZWiuWNwJQ9T70zWaYFBHLPF+oyO
	 2RHRuDpnOcb1g==
Date: Fri, 27 Feb 2026 18:33:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Wang <weibunny@fb.com>
Cc: <netdev@vger.kernel.org>, Daniel Zahka <daniel.zahka@gmail.com>, Willem
 de Bruijn <willemdebruijn.kernel@gmail.com>, David Wei <dw@davidwei.uk>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next 9/9] selftest/net: psp: Add test for
 dev-assoc/disassoc
Message-ID: <20260227183300.7a813cd4@kernel.org>
In-Reply-To: <20260224002410.1553838-10-weibunny@fb.com>
References: <20260224002410.1553838-1-weibunny@fb.com>
	<20260224002410.1553838-10-weibunny@fb.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com];
	TAGGED_FROM(0.00)[bounces-262048-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1B0A31BFFB9
X-Rspamd-Action: no action

On Mon, 23 Feb 2026 16:24:09 -0800 Wei Wang wrote:
> Add an env NetDrvContEnPsp which is based on NetDrvContEn, but add an
> additional bpf redirect program on nk_host to redirect traffic to the
> psp_dev_local. The topology looks like this:
>   Host NS:  psp_dev_local <---> nk_host
>                 |                |
>                 |                | (netkit pair)
>                 |                |
>   Remote NS: psp_dev_peer      Guest NS: nk_guest
>              (responder)             (PSP tests)

Can we not have a param in ContEnv to control if the return program is
installed? Is there more to it? The PSP binding can presumably be done
by the PSP test.

