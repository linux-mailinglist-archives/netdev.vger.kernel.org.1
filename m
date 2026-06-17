Return-Path: <netdev+bounces-300065-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DmNmOhxaMmrQywUAu9opvQ
	(envelope-from <netdev+bounces-300065-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 10:26:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 404B469786A
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 10:26:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TJWE13wk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300065-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300065-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DCD2301E5A2
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 08:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1AC380FE5;
	Wed, 17 Jun 2026 08:24:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237DE17BCA;
	Wed, 17 Jun 2026 08:24:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781684666; cv=none; b=OuYQa+k9KGqQzPK1UmvGFsUL0s3b2K2he87ddfqokSpo9Gf3eW0LLAxGpGxs/pS5TBK9aujCV9R2cHFXO/Z4SY2IGkD/jstAPB5vfdTKXhzikq1jPI3cDcLPgHX4/NQivJRZELZxXnrZ4CtajbAa46SU1/RXV3vWp2dJz8qKpaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781684666; c=relaxed/simple;
	bh=kuBApJ0y7Vi88cCvSqzgNTYzLnc0J2FB38jctZzfGg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuJhWlsWjXOfG1I2xo7Q8PFoEdQ1rnqRB2/7zdYIO/u7RFh2JnmbRLBCWLppQnVcSTXuTCFf0SGxqJ5QNJSAIfAJsFZEffRAHwCO79KlhUBiljw5dL4G5PgOXXmBd5bFYzRdukR+gUmf3hVmhZOutpDECGAEBTwddSX8BfCbHU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJWE13wk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D404C1F000E9;
	Wed, 17 Jun 2026 08:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781684664;
	bh=SuzyLArYe5bj+f7+Tp/IYxWPm7dZk8dVDaRvB9u0vM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TJWE13wkvsj53uRMwF+qNTzbENIExxm1mw03vCAc7ZAxBamTeiUoVbH99HJjzd9Q8
	 lvmUJz2JAH2Qe1m9/FndJ3qrqoM31Yoaw7hjTvRQ9Nv8R0OZHGAEr5uENW/1EhdPE3
	 LrSg3vo4uV5KxJjVdIZYJXvcoivt95jw74yIDIMQeXVuakjeMLlPXWZqyMCjlOQpCx
	 /G6IiAvnQ2jOC1TFU5YLn6RbuMtpoCblH2ybG94EMpMfNAVo6zUx3YDH3M7sxvJTsY
	 l1Hdn7vhJCfiyG1H+B+LGO4CZorVrAGiVhmd3MYm9hniNVFrr0WhkH8DUTEd5V2CIn
	 6VSO4bqJUy3Cg==
Date: Wed, 17 Jun 2026 09:24:20 +0100
From: Simon Horman <horms@kernel.org>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Masayuki Ohtake <masa-korg@dsn.okisemi.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: pch_gbe: handle TX skb allocation failure
Message-ID: <20260617082420.GA840150@horms.kernel.org>
References: <20260615125043.3537046-1-ruoyuw560@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615125043.3537046-1-ruoyuw560@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300065-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:ruoyuw560@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:masa-korg@dsn.okisemi.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 404B469786A

On Mon, Jun 15, 2026 at 08:50:42PM +0800, Ruoyu Wang wrote:
> pch_gbe_alloc_tx_buffers() allocates an skb for each TX descriptor and
> then passes the returned pointer to skb_reserve(). If netdev_alloc_skb()
> fails, skb_reserve() dereferences NULL.
> 
> Make pch_gbe_alloc_tx_buffers() return an error when an skb allocation
> fails. On failure, let pch_gbe_alloc_tx_buffers() clean the partially
> allocated TX ring before returning the error. While bringing the device
> up, release the RX buffer pool through a shared cleanup helper before
> unwinding the IRQ setup.
> 
> Fixes: 77555ee72282 ("net: Add Gigabit Ethernet driver of Topcliff PCH")
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
> ---
> Changes in v3:
> - Move the partial TX ring cleanup into pch_gbe_alloc_tx_buffers(), as
>   suggested by Simon Horman.
> 
> Changes in v2:
> - Add the kernel-doc return value description for
>   pch_gbe_alloc_tx_buffers().

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>


