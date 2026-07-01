Return-Path: <netdev+bounces-303721-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WzSOEO0xRWoD8goAu9opvQ
	(envelope-from <netdev+bounces-303721-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 17:27:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A186A6EF3C6
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 17:27:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=qE+N8GvD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303721-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303721-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 940D63012CD9
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 15:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755BF48BD47;
	Wed,  1 Jul 2026 15:27:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6A4481239;
	Wed,  1 Jul 2026 15:27:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782919644; cv=none; b=aUHaNKa1WOuUyQlVmVFbicsoxFb6eJCCN4bDMuB+lmnXVYOMVmN5CSCMqL9QMfdii66LI8Ul3pX1vfVWqSgSZ/UQIOCl3qPta522P4kchpL3GG4P+YOimQFasMGs2B/c7cMh2Ks+VASJn2byGyvQcHbV2Pk9nAJECAMn3rLJOpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782919644; c=relaxed/simple;
	bh=tN9N47sy9G+sMnjKBswRNRpH/7OR4sFTu/Zec5SVtys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ocgxps1JujYDZqF0lqeoxXSFDCYN4ac6Iv8QpudbZC6lr4PJF7M2HhRt9cT0yDjEXuxZSxvAVyBnCZ7RkNaTxYMZFEL+logTbAPz9/4zD+ZAXx/L8zTviwGj56bztWw76ga4W+yJO7UrBRapOBSXMUeBZ9JNkowflAoxnOxREZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=qE+N8GvD; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JzmkCOhIhYj5XlquathEHEh27AextJUOcGbIn0m2tj4=; b=qE+N8GvDFYnyDoOiCuDZW0YJ6p
	FknXm5uC5/M1lhcIi/uc+Vxk4pMEnuVkXw3qhe/tMO0RzISuKR6i36QA0wUBKzgWk8899pZLcnkYL
	XhnxA66/8YBqyGnSA0EE5T+AgOT4gkuuZNTY7NyKHvT2xbahCVnF31EDPuma/Yho7PzG0kq1IQmM6
	nt15fYouYM/jo8wZYOsJBsOksLqg4f/xDbwIJQKiW278i1vlwreCbA42YCIHMAOjKt8qrMSlW8iTU
	R9nXksfr2oGAYNV9wgOxXU5ybC8OQidSr2Ws60qA4fcfdGR0ubZ2s8jeEVXGNzKitcGUAW70Obxbu
	12tm0v+g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wewqG-007w6R-0L;
	Wed, 01 Jul 2026 15:27:12 +0000
Date: Wed, 1 Jul 2026 08:27:07 -0700
From: Breno Leitao <leitao@debian.org>
To: Baran Tuna <barant@fastmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:QLOGIC QL4xxx ETHERNET DRIVER" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] qede: Prevent possible snprintf() truncation by bounding
 %s string format
Message-ID: <akUw_GsNELK4NKTN@gmail.com>
References: <20260701144713.197557-1-barant@fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701144713.197557-1-barant@fastmail.com>
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303721-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:barant@fastmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[fastmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A186A6EF3C6

On Wed, Jul 01, 2026 at 05:47:11PM +0300, Baran Tuna wrote:
> GCC warning shows that formatted strings may
> exceed the fixed-size destination buffers.
> 
> Bounding the %s string format
> so the maximum formatted output always fits.
> 
> This eliminates the -Wformat-truncation warning.
> 
> Signed-off-by: Baran Tuna <barant@fastmail.com>
> ---
>  drivers/net/ethernet/qlogic/qede/qede_ethtool.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
> index 647f30a16a94..5428f53150a0 100644
> --- a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
> +++ b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
> @@ -618,10 +618,10 @@ static void qede_get_drvinfo(struct net_device *ndev,
>  	if ((strlen(storm) + strlen("[storm]")) <
>  	    sizeof(info->version))
>  		snprintf(info->version, sizeof(info->version),
> -			 "[storm %s]", storm);
> +			 "[storm %.16s]", storm);

Where is this 16 coming from?

Also, isn't the if above checking for no overflow? I.e, 
we got here only if strlen(storm) + strlen("[storm]") < sizeof(info->version))

For whoever else is reviwewing this, this the buffers:

	#define ETHTOOL_FWVERS_LEN      32
        char    version[32];
	char storm[ETHTOOL_FWVERS_LEN];


