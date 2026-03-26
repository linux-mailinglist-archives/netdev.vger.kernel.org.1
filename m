Return-Path: <netdev+bounces-271946-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDO5EfD5xGmC5QQAu9opvQ
	(envelope-from <netdev+bounces-271946-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:18:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE547332268
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A69AC302B182
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 09:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94328317147;
	Thu, 26 Mar 2026 09:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="U53i+EXs"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70DA314B84;
	Thu, 26 Mar 2026 09:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774516712; cv=none; b=ecY7nu+rqdUW/gwwHSBGAyEkgSJaTBKX6WDDNk+SFIqnnKn8Z/mS+YMdeeZguy2yu1bf3gWJE2+m0xjAYiAZ11+YxhRfpT09u1qXZpyK089Yl7ml6kKHZ4GHVS1T3Ahn32ELef4gCcdbD0CHwg6ncnxoafgV0g3PBWJnVMhII2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774516712; c=relaxed/simple;
	bh=vvbrnA0+898pMRQlJ9PQpXwM80nzyirRDqrs56qTSnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPNw4tt+aqfZZClA3xGOvcretFChp0RsJk+XNfIW90RUEsdAaF4+MK4amRQNrlAHXW7iBghyELuFjltFPMJWeyQj8J0n9hDgfLkIL8A0VjpRLRD+Hf7Oli3XeLkIXG5EvJ1Mwx/8OIkCjp3TybMBgcOlHRbwYKw7MDAdehXpXho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=U53i+EXs; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rQFc9TaMPa+MJvbas5O7gxSnkgSoNa81YzdAVy0iL4c=; b=U53i+EXs40w+2RO57CuIxtBEvV
	a/eRL+yyV0sDg9RwSPdxSOhWmisdR/bATD35Kt8IINksMi/rAsAM3OqpKqSh2BdSrGh9/yXAW1lNj
	ECWxn6jsWNeQGKPPF1nh5sOR0iEr2bIdDOWqrX16OblKuRWeHdDwAMouYC9Zgqt8tJKkxwGX1OCpd
	nxedaaxfHgGH3eWjsXG8/qKWcJtMdbRtRm3X/5nOhGZNSne9OsVFQVU4ostMuxSbD3+saAXpvy47e
	4T2Q7g+QjQn5EhrZfJwtTbMXly46uzJAz6PKtTgZsa9NbOUPniFdl0+uTFDgmlho2Rb/jysly+buX
	lyU3lV/A==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w5gqr-009kHn-V9; Thu, 26 Mar 2026 09:18:06 +0000
Date: Thu, 26 Mar 2026 02:17:59 -0700
From: Breno Leitao <leitao@debian.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Edward Cree <ecree.xilinx@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
	Jeff Garzik <jgarzik@redhat.com>, Ben Hutchings <bhutchings@solarflare.com>, 
	Arnd Bergmann <arnd@arndb.de>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Brett Creeley <brett.creeley@amd.com>, Kees Cook <kees@kernel.org>, netdev@vger.kernel.org, 
	linux-net-drivers@amd.com, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] [v2] net: sfc: avoid format string warning
Message-ID: <acT4fg86n7kpdm8e@gmail.com>
References: <20260325134557.3406655-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325134557.3406655-1-arnd@kernel.org>
X-Debian-User: leitao
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271946-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,solarflare.com,arndb.de,amd.com,vger.kernel.org,lists.linux.dev];
	TAGGED_RCPT(0.00)[netdev,lkml];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EE547332268
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 02:45:44PM +0100, Arnd Bergmann wrote:
>  	/* Event queues */
>  	efx_for_each_channel(channel, efx) {
> +		char unit_str[ETH_GSTRING_LEN];
> +
> +		snprintf(unit_str, sizeof(unit_str), "txq%d", channel->channel);

The original EFX_CHANNEL_NAME macro expanded to "chan%d", didn't it?.
Shouldn't replace txq by chan in the line above?

		snprintf(unit_str, sizeof(unit_str), "chan%d", channel->channel);

> @@ -258,23 +253,23 @@ static int efx_fill_loopback_test(struct efx_nic *efx,
>  	struct efx_tx_queue *tx_queue;
>  
>  	efx_for_each_channel_tx_queue(tx_queue, channel) {
> +		char unit_str[ETH_GSTRING_LEN];
> +
> +		snprintf(unit_str, sizeof(unit_str), "txq%d",tx_queue->label);

You probably want a space after the comma here:

		snprintf(unit_str, sizeof(unit_str), "txq%d", tx_queue->label);

