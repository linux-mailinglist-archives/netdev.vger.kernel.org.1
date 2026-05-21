Return-Path: <netdev+bounces-290485-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBnbBZsgD2pSGAYAu9opvQ
	(envelope-from <netdev+bounces-290485-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:11:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBE45A803F
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 747013309B55
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6CA2E36F8;
	Thu, 21 May 2026 14:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QwNDpych"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDE042AA9;
	Thu, 21 May 2026 14:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372482; cv=none; b=Xz5Kiy1A/Q5A+PlEfIMyKWyjB9Xrcpx1rWr+lZIJ554rQ8O44u8E03onhU6/3Gcn1ug9m7uVYkGOfnQ2a77BP/u92vRqYvW7kLd4BFNSNyxOiRnJ35f9clSrvzmYDCDCKBjLtZ4kfl/yUo0OEO9I+oSeMa4XHoordk6r69MwJNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372482; c=relaxed/simple;
	bh=IybO72gHpSFq97Hi6hxyumuabx1WFfFCGZ7w/BXsp6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=F7MQiCxX64p9XWaoFNYXfzxBUULyPXuCU32bSV9FvkJ2kM0YCQwYr5UwOw785LuWckmcwBNsuYQrMKZCj9TXGtvXfSmCFLO7MHUxhq6LsGuAhUq8v217xzEyGbwDEelfdpb51JfcprU/bT6KXImvfooF7wn8dL3lhcHJf63YBgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QwNDpych; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id EF3504E42CC0;
	Thu, 21 May 2026 14:07:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C398860495;
	Thu, 21 May 2026 14:07:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 87043107E8BAE;
	Thu, 21 May 2026 16:07:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779372478; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=UVANFKx6KDhtmIiuadft9F665lyw0dXe5pf2r94srQA=;
	b=QwNDpychoqs9rVuRdKi9kb1/7s7T29PH2QjGAkAGNaq92kmPoxJznNWJ58hIrKJwDCQfbb
	ZWSaE8calO6UYzBREUr/HWgiAgHEoFBwvlXlnP7mJhxe4kJ+dF8I/pkXrE1NnnhQ/E+OSB
	IvvZ88XubBLXb4FqSu3lSsVH9lxDCFbNCVCg5+GgQ1MCX0lP2bQqniNjk+vK9W7Z2Tw932
	odyo7wYIgnBCsUYUiUG+u2dzLzEpe5ouA8yk2q2M6tLjqkcZ3cA4V0GXOSHbJUKYkskJZv
	MST1454HBLMqcdOItiFIEbvpC2jBZTasfuzASWfqKAodwL64hYEUweHF5txGOw==
Message-ID: <aba1e067-1eb5-4be4-b571-99a5eb03bc76@bootlin.com>
Date: Thu, 21 May 2026 16:07:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] net: dsa: mxl862xx: move API macros to
 mxl862xx-host.h
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <cover.1779330653.git.daniel@makrotopia.org>
 <b6682128d4550c6d1591ad27a21866e4d6c5507b.1779330653.git.daniel@makrotopia.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <b6682128d4550c6d1591ad27a21866e4d6c5507b.1779330653.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290485-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,makrotopia.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6EBE45A803F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 5/21/26 04:40, Daniel Golle wrote:
> Move the MXL862XX_API_WRITE, MXL862XX_API_READ and
> MXL862XX_API_READ_QUIET convenience macros from mxl862xx.c to
> mxl862xx-host.h next to the mxl862xx_api_wrap() prototype they wrap.
> This makes them available to other compilation units that include
> mxl862xx-host.h, which is needed once the SerDes PCS code in
> mxl862xx-phylink.c also calls firmware commands.
> 
> No functional change.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
> v2: no changes
> 
>   drivers/net/dsa/mxl862xx/mxl862xx-host.h | 8 ++++++++
>   drivers/net/dsa/mxl862xx/mxl862xx.c      | 7 -------
>   2 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-host.h b/drivers/net/dsa/mxl862xx/mxl862xx-host.h
> index 84512a30bc18..66d6ae198aff 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx-host.h
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx-host.h
> @@ -9,6 +9,14 @@ void mxl862xx_host_init(struct mxl862xx_priv *priv);
>   void mxl862xx_host_shutdown(struct mxl862xx_priv *priv);
>   int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *data, u16 size,
>   		      bool read, bool quiet);
> +
> +#define MXL862XX_API_WRITE(dev, cmd, data) \
> +	mxl862xx_api_wrap(dev, cmd, &(data), sizeof((data)), false, false)
> +#define MXL862XX_API_READ(dev, cmd, data) \
> +	mxl862xx_api_wrap(dev, cmd, &(data), sizeof((data)), true, false)
> +#define MXL862XX_API_READ_QUIET(dev, cmd, data) \
> +	mxl862xx_api_wrap(dev, cmd, &(data), sizeof((data)), true, true)
> +
>   int mxl862xx_reset(struct mxl862xx_priv *priv);
>   
>   #endif /* __MXL862XX_HOST_H */
> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
> index a193f3c07d35..0b1a23364eb5 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx.c
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
> @@ -24,13 +24,6 @@
>   #include "mxl862xx-host.h"
>   #include "mxl862xx-phylink.h"
>   
> -#define MXL862XX_API_WRITE(dev, cmd, data) \
> -	mxl862xx_api_wrap(dev, cmd, &(data), sizeof((data)), false, false)
> -#define MXL862XX_API_READ(dev, cmd, data) \
> -	mxl862xx_api_wrap(dev, cmd, &(data), sizeof((data)), true, false)
> -#define MXL862XX_API_READ_QUIET(dev, cmd, data) \
> -	mxl862xx_api_wrap(dev, cmd, &(data), sizeof((data)), true, true)
> -
>   /* Polling interval for RMON counter accumulation. At 2.5 Gbps with
>    * minimum-size (64-byte) frames, a 32-bit packet counter wraps in ~880s.
>    * 2s gives a comfortable margin.


