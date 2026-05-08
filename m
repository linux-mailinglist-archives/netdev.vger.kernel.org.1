Return-Path: <netdev+bounces-285710-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OXULPKV/WmXgAAAu9opvQ
	(envelope-from <netdev+bounces-285710-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 09:51:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEA94F3497
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 09:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 441FA3002D52
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 07:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4437637DE99;
	Fri,  8 May 2026 07:51:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE62B37A4AF;
	Fri,  8 May 2026 07:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778226672; cv=none; b=aVC4svE8up5e00FY3bPYN0bNWB7o+r59Z6dFki0oX3FEWPCateEcpj4BG1c8Je8HLJ0aqC8WhJdh8SU0LUy39MqUQ6MwwkujhllssYcPptirfB7UiVxCrtz07I3sHEXV8cjUaty/m9AgcCOPw4GOA8L0srwFsYS7DrYCu6ySKyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778226672; c=relaxed/simple;
	bh=ywr9BYG0SsUCA8Xw3Ma+dyznX1/GjYIJ9T7zinYMS58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MKXCmgrhngWmMB6hZZkQddWw9/6GVzZ19zuWgZ5mOdHxHDarMF14ipy5je6xly/M78IfWfbEtYkkvcckY0x5F89cola0oaAdwNa3AqclMjZkgSR/1ywT2BHkK+2gEaGurfzNztbwr5TFFVGIFpD9d8Rw6hLvYd8BpjsK6WOXoqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D43C2BCB0;
	Fri,  8 May 2026 07:51:07 +0000 (UTC)
Message-ID: <f5158347-3c9f-4c29-bb2f-4beaaca3cd20@tuxon.dev>
Date: Fri, 8 May 2026 10:51:04 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: change maintainers for macb Ethernet driver
To: nicolas.ferre@microchip.com, theo.lebrun@bootlin.com,
 conor.dooley@microchip.com, netdev@vger.kernel.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260507120444.9733-1-nicolas.ferre@microchip.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260507120444.9733-1-nicolas.ferre@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4CEA94F3497
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285710-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:email,tuxon.dev:email,tuxon.dev:mid]
X-Rspamd-Action: no action



On 5/7/26 15:04, nicolas.ferre@microchip.com wrote:
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> I would like to hand over the macb maintenance to Théo, as I'm unable to
> keep up with the recent flow of patches for this driver. After speaking
> with Claudiu, he indicated that he is in the same position as me.
> To help with this work, Conor has agreed to act as a reviewer.
> 
> I was given responsibility for this driver years ago, and I'm glad to
> see it continue with talented developers.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Acked-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
>   MAINTAINERS | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 37b105a443dd..ad60104f30a1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4181,8 +4181,8 @@ F:	include/uapi/linux/sonet.h
>   F:	net/atm/
>   
>   ATMEL MACB ETHERNET DRIVER
> -M:	Nicolas Ferre <nicolas.ferre@microchip.com>
> -M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
> +M:	Théo Lebrun <theo.lebrun@bootlin.com>
> +R:	Conor Dooley <conor.dooley@microchip.com>
>   S:	Maintained
>   F:	drivers/net/ethernet/cadence/
>   


