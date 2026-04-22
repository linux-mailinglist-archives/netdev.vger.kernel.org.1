Return-Path: <netdev+bounces-280497-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wErhHbT46GkgSQIAu9opvQ
	(envelope-from <netdev+bounces-280497-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:35:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1F9448B93
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A824308642E
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EB137C90B;
	Wed, 22 Apr 2026 16:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FflltseT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D4737C93A
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 16:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776875083; cv=none; b=ZKbVSwvffRXJ7cNsfLhsaA6znvL9/JAzcYsSBVH0zeysoqz2vISZ1OUe/IL5L/c9j9LzmH1uq8cTulV8Ux2zR4sA5dRHYnEPr+jLrzJ+KqpWZqVLkIl5EIBPuDAhAkqPyV8KOuGmZqSRwcX38RXq0m1L2CxftDRCkeb26lXA7O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776875083; c=relaxed/simple;
	bh=0aGwa+ZfwVhzwmN1Ab9tz744EVG+Zm510CkUoMldpIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esVljAWIaAOHwDF+304G0UTSPYAGGJ0JmgTP+/UEJH7F9l3cQnnoGw5SqtuVJvBAyGFSsp/hf21wvepNudNfP6DgfYAqv1bpUjf828NnsI4TDrPuaoPEvV7CYIV4KIlWOYQ/QnWYLYh9Q728wwQa2GHgFYyXr6mUebBHGa9vgSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FflltseT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ltP9DunfWhl2+s9+MxA50vZN9AgOfDsyAJHEgnBloug=; b=FflltseTItdQKizF2wi2w0mbzB
	D9lBnedjO93ebRT4qPfx8bTocdBgcOFC8Or84gMFXFF0D/SCzZbXxabTCLsQxvulSx5gcxMo8Rfwx
	KVEGIG8ScT7YynewNP2KeRRVGB/lCzckXF1AqfPQLnSSBQvVJewbCYGJH512rYOAbeQM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wFaNT-00H3f3-SX; Wed, 22 Apr 2026 18:24:39 +0200
Date: Wed, 22 Apr 2026 18:24:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Junyang Han <han.junyang@zte.com.cn>
Cc: netdev@vger.kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	ran.ming@zte.com.cn, han.chengfei@zte.com.cn,
	zhang.yanze@zte.com.cn
Subject: Re: [PATCH net-next v2 1/3] net/ethernet: add ZTE network driver
 support
Message-ID: <8b59cf8d-ffbf-4679-ad1f-48d52d18daf7@lunn.ch>
References: <20260422144901.2403456-1-han.junyang@zte.com.cn>
 <20260422144901.2403456-2-han.junyang@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422144901.2403456-2-han.junyang@zte.com.cn>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280497-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B1F9448B93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> +MODULE_AUTHOR("Junyang Han <han.junyang@zte.com.cn>");
> +MODULE_DESCRIPTION("ZTE Corporation network adapters (DingHai series)
>  Ethernet driver");

> +err_pci_save_state:
> +    pci_release_selected_regions(dev->pdev, pci_select_bars(dev->
> pdev, IORESOURCE_MEM));

The email is still getting its white space changed. Please don't post
any more versions until you have sent it to yourself and got it back
again in a good state.

https://b4.docs.kernel.org/en/latest/contributor/send.html might help. 

	Andrew

