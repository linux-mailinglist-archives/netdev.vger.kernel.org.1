Return-Path: <netdev+bounces-284580-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLs8CY5R+mnyMQMAu9opvQ
	(envelope-from <netdev+bounces-284580-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 22:22:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C32B4D39D2
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 22:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6816A30243BD
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 20:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA8F39EF0B;
	Tue,  5 May 2026 20:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DVF4PV6t"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD1A37B014;
	Tue,  5 May 2026 20:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778012372; cv=none; b=kZ2eM8LsxTbaqerbaqme8a4UBoxKDB1hbxw8bLWdxIdS6AFaKCtLr6v2NBPUu3dtgA6Gs6CGM8NxdAXYxP9fELXHJCnHIJV5FYHIHADEUv+06yz0n3CNT24gryWFVAaQ1el3sGFyhdEpuHGRp/8jlWO8mX+6D+4or1g6vVkSoXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778012372; c=relaxed/simple;
	bh=9C4iOv1T0RHeZnEFiazbMZ3CuTprMKwewOnJ0QYXfGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEfjib+/Ja739bAgHRgq3SRnIA82W/38k6H7U5w+lcAAMVf6dnos63jg099RPyZNmvGay4b4PLb9bzmMU+bYLu+YNUGAUu/8roMDV7EYm+q+0hs+QVvUwfQBRJ1WzOfRLUYCmA1qQVbUDuVJ5lPbJhu9Ajrf4yUrt8LdQwbX1qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DVF4PV6t; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7VnGX7EcaPdvzWSwmZrI+5GCYCODv3iJmNrN+Xto4Zc=; b=DVF4PV6tlsd6Xl4NQj+ENz6T7b
	nGyz+UDHvqlR2dc8m0jm2Bm2cre0Z137wUg9ZFk24Sq5ZJBS2EPN9k541MVfSj1BfrCsNlMc3dTF3
	ltmxinTwCVXFMnGxYvIqT3/YfCtLZC+jP7hIkFrdQ1KkNGP498vvOOKhEcUiYRrKSfDI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wKMEi-001X7f-Oy; Tue, 05 May 2026 22:19:20 +0200
Date: Tue, 5 May 2026 22:19:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lucas Poupeau <lucasp.linux@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] llc: fix coding style and memory barrier documentation
Message-ID: <c731ce37-e5d8-4259-8b6c-46b01c257fbd@lunn.ch>
References: <20260505192549.74382-1-lucasp.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505192549.74382-1-lucasp.linux@gmail.com>
X-Rspamd-Queue-Id: 1C32B4D39D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-284580-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	BLOCKLISTDE_FAIL(0.00)[100.90.174.1:server fail,104.64.211.4:server fail,156.67.10.101:server fail];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid,checkpatch.pl:url]

On Tue, May 05, 2026 at 09:25:49PM +0200, Lucas Poupeau wrote:
> Fix multiple style issues reported by checkpatch.pl to improve code
> maintainability and compliance with kernel standards.
> 
> Changes included:
> - Add mandatory explanatory comments to memory barriers, specifying
>   the reasoning and pairing context.
> - Insert missing blank lines after variable declarations to improve
>   readability.
> - Relocate EXPORT_SYMBOL macros to immediately follow their respective
>   function definitions as per the modern kernel coding style.
> 
> Note: Some indentation warnings from checkpatch.pl persist in this
> commit. Despite several attempts to align them, the tool remains
> capricious regarding these specific blocks, and further manual
> refinement proved counterproductive.
> 
> Reported-by: checkpatch.pl
> Signed-off-by: Lucas Poupeau <lucasp.linux@gmail.com>

Please take a read of

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

The Subject line needs to indicate what tree it is for.

Please also break this patch up. One patch per type of fix. You are
aiming for patches which are obviously correct. Such patches are
generally small, and have good commit messages.

> -#if 0
> -#define dprintk(args...) printk(KERN_DEBUG args)
> -#else
> -#define dprintk(args...)
> -#endif

It is not obvious why this is correct. Is dprintk() not actually used
in this file? That would be something you would say in the commit
message.

> +    /*
> +     * This barrier ensures that any previous memory operations
> +     * are visible before the handler is executed.
> +     * Pairs with the smp_wmb() in [indiquez ici la fonction ou le fichier].
> +     */

Please do specify the function here. Otherwise the comment is useless.

	Andrew

