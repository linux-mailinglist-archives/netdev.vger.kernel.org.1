Return-Path: <netdev+bounces-276160-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOD3HXlx1WmN6QcAu9opvQ
	(envelope-from <netdev+bounces-276160-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:04:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E558E3B4D4B
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 692673025932
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 21:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16F637A4BA;
	Tue,  7 Apr 2026 21:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="ISEoigmC"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56767253F05;
	Tue,  7 Apr 2026 21:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775595888; cv=none; b=hipWJeDXcADT6UkreILHKCzLr4YQLbV5Yaavx2jcLRxaEuxRoZYGW8Qyh4BHXHFa+FMQIVu1E1lJ7uUewH+x9FbP5Vbhai1mgiYyuCMU5I+QlWfq9RPDaNH1Um7TVP4zconkHOQ98n6y5p+a6omMUZUWlNBhHLGU08+48HYAnT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775595888; c=relaxed/simple;
	bh=jqvu83wfWERS+A4du18eODKc8zsl2by81Rtu32YYlg4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=hfPMOL2uwrPxUDBRBT4nuUAWNG2hkWEI61Y6bZ2OFzPYarA2afrAWJvwzMlvxIJX1W1TAnXCCWq4olvsH8SK645dJuBNkH2ikbPgxQIj54/4muxCqGfJ4MYyL25tALbX0ONTklHOYnhnLP/FS8gHWSnvmCxaeHJKor7A0nXNO7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=ISEoigmC; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 41356A5884;
	Tue,  7 Apr 2026 23:04:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775595874; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9BugpWoyyC0JTlJJqIH/b68u9qMIscoqZi+/vmLrBBQ=;
	b=ISEoigmC7NVF6PKbXaR5JpDcFsvvZkshxXPfcT5tsbSomgIw+adXHu22jRx9+0N3YlTq12
	Kjw0FJVVDwLeQeMAZiAopo48jC10J3DP6DCszP2nHKK9ZIucxOV167gPP8hfi6nH242/in
	z9/lL2s/YEwQddBNNeJmNLVbHu7S6bRJ2Qo9KUJ+/Zfcqf4j3Cu0cVVuUqXbPqztWS21JJ
	ZO/Juk8ELZRo9LiR+Te2F08dcFDFhGDseuqFeUGtfPpgV2OCQN/6un+kQrtR7pOuBPc023
	317LdcMxOMUYyCJqcwRMuE3rFgsAs2qQKW18iAbjpAVT3Z9rZnSlzIoOI7AqyA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 07 Apr 2026 23:04:30 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Justin Chen
 <justin.chen@broadcom.com>, Vikas Gupta <vikas.gupta@broadcom.com>, Bhargava
 Marreddy <bhargava.marreddy@broadcom.com>, Rajashekar Hudumula
 <rajashekar.hudumula@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, Eric
 Biggers <ebiggers@google.com>, =?UTF-8?Q?Markus_Bl=C3=B6chl?=
 <markus@blochl.de>, Heiner Kallweit <hkallweit1@gmail.com>, Fernando
 Fernandez Mancera <fmancera@suse.de>, linux-kernel@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH net-next] net: bcmasp: Switch to page pool for RX path
In-Reply-To: <20260407162658.4056141-1-florian.fainelli@broadcom.com>
References: <20260407162658.4056141-1-florian.fainelli@broadcom.com>
Message-ID: <028ee7c4c1073056ba11c98a7faf1f13@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276160-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[tipi-net.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,broadcom.com,arndb.de,blochl.de,gmail.com,suse.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:?];
	NEURAL_SPAM(0.00)[0.890];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_TEMPFAIL(0.00)[tipi-net.de:s=dkim];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: E558E3B4D4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 7.4.2026 18:26, Florian Fainelli wrote:
> This shows an improvement of 1.9% in reducing the CPU cycles and data
> cache misses.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---

> [...]

> 
> -static int bcmasp_alloc_buffers(struct bcmasp_intf *intf)
> +static struct page_pool *
> +bcmasp_rx_page_pool_create(struct bcmasp_intf *intf)
> +{
> +	struct page_pool_params pp_params = {
> +		.order		= 0,
> +		/* Pages are CPU-side copy targets; no DMA mapping needed. */
> +		.flags		= 0,
> +		.pool_size	= NUM_4K_BUFFERS,
> +		.nid		= NUMA_NO_NODE,
> +		.dev		= &intf->parent->pdev->dev,
> +		.dma_dir	= DMA_FROM_DEVICE,

Nit: .dma_dir has AFAIK no effect without PP_FLAG_DMA_MAP, so
it's a bit misleading next to the "no DMA mapping needed" comment.

> +		.offset		= 0,
> +		.max_len	= PAGE_SIZE,
> +	};

Other Broadcom page pool drivers set .napi and .netdev. Adding those
here would enable direct recycling and expose pool stats in ethtool -S.

> [...]

Thanks
Nicolai

