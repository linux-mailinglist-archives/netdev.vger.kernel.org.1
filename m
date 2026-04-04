Return-Path: <netdev+bounces-275417-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGYgDOCY0WmdLgcAu9opvQ
	(envelope-from <netdev+bounces-275417-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 01:04:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8417D39CD22
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 01:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2691C300EA92
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 23:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3BC367F5A;
	Sat,  4 Apr 2026 23:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0ztXRYAL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF1F33CEA8;
	Sat,  4 Apr 2026 23:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775343799; cv=none; b=T+EVkp2+DL2zVvE5ZVTnIRCAQ8ryRX8l2ZG3fSkMSQnOHiBAJEbJZvxQqfJQNX3kxtup8mp5uWGX0vTyVJxSGgG9JabriUBuM8joux++kWaMlcHm1xYtPq36v9FuEkIZbg+5SVF/gZRxv4Xg2ot4JeF7CAaRTdu0GyfblQQ6wC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775343799; c=relaxed/simple;
	bh=oPQr98i+WQIiqEuivy6k9noL1FzfXDmyrBCbyTQQjHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEso+19egK2FjUxqhn1DTFTfD6AoMEM6X1D9Eg8V206Tr7MZ0pf1N+05IntUYbvLiW4aXx3FJ1W+8Tepq6X9TpOEz3SXAfz8SpiPfySX2JXvYFK4c4yhzuRSc+pUgkcDV9vRQlxY+3PBDp+umVqUz6mK49vWwA0bU/JinpI9bFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0ztXRYAL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=KeGvgB06YzFJ6/v7FdOL64jsdd8t+dT4L0PYONqQZVk=; b=0z
	tXRYALj2co6AjtmiPQD3TVKFPlGvxkdz1lakt+qiMBALb6lde2KnjYTxyh8DvJ6ZNZ0bPfNluW22U
	A6QGjignCpvhUGKVmGosF+f2uj/FxUJPHtNLCpyqbXvxQqtbdiXdAqj+LIdll6qw66HMWNJwIdcbl
	/uACTXZwNPwkGkI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w9A1E-00Eop9-7e; Sun, 05 Apr 2026 01:03:08 +0200
Date: Sun, 5 Apr 2026 01:03:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
Cc: pavan.chebbi@broadcom.com, mchan@broadcom.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, lszubowi@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] tg3: Add PowerEdge R740xd to AER quirk list
Message-ID: <975ec123-e3df-41d5-bb15-f3af8af2c340@lunn.ch>
References: <20260404225023.1254-1-rayfraytech@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260404225023.1254-1-rayfraytech@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275417-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 8417D39CD22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 05, 2026 at 12:50:23AM +0200, Oskar Ray-Frayssinet wrote:
> The PowerEdge R740xd is a variant of the R740 that also triggers
> a fatal PCIe AER event during system reboot. Add it to the DMI
> list to apply the same workaround.
> 
> Fixes: e0efe83ed325 ("tg3: Disable tg3 PCIe AER on system reboot")
> 
> Signed-off-by: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
> ---
> v2: Also add "R740XD vSAN Ready Node" DMI name as reported in
>     bugzilla #221279 by Thomas Berger
> v1: Add "PowerEdge R740xd" DMI name

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

says: 

 * don’t repost your patches within one 24h period

> @@ -18216,6 +18216,18 @@ static const struct dmi_system_id tg3_restart_aer_quirk_table[] = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R740"),
>  		},
>  	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R740xd"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "R740XD vSAN Ready Node"),
> +		},
> +	},
>  	{
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),

When you look at tg3_restart_aer_quirk_table[] they are all Dell. Are
there any Dell systems which actually work? Would it make sense to
mark all Dell systems as broken and enable the quirk? Then there is no
need to play whack-a-mole.

     Andrew

