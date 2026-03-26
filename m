Return-Path: <netdev+bounces-271968-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aP0ZCOkLxWma5wQAu9opvQ
	(envelope-from <netdev+bounces-271968-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:35:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 830AC333756
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC56C317AA73
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1A5396D0A;
	Thu, 26 Mar 2026 10:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3rHLtqg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF013BE623
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 10:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774519897; cv=none; b=Zw9s2cG2AtmE3+Z23ptW2WgB4D4k5sD0nVZGnjsCwgCqRD/LfQDnBzRfHYOkwz7k2ZWc/KUjmHN1+DBuQuBx80Y5icySH0MAFtDbUU0hKgukhSp7rpVvzqaT8c+QWd5SO0K6+SMJQWu+jSSdImjoazqMjw7MtVqEfUgkdeoI9So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774519897; c=relaxed/simple;
	bh=oeyjducO0eQwXB7QdsBIKAJuTRLqVB6IWokn43laGo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fAWP1Prh0tmQJbt1qH7xhy6espS3CS/MS3hh8AMM/q4wqev13/h0vcu5yrVgNQJ+4OsUyHBLUjwenTjK43W6G2F2gP3QsjoS3sSIX8MgulDUlc4VipHZ03PKh/51y1Ki5uRl4b6KK1CK40FN4LpQc3AKrFgJPRt5C/4/LyOuW3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3rHLtqg; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43b446ee9b3so103255f8f.3
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 03:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774519894; x=1775124694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HPONIQtifdjV5TyWL7hOg+/X66KagRgfREtv1fK4Vd4=;
        b=k3rHLtqgvnLixIW3A5JodDGKaGMnZIyLPRATZo/7QOD0gWV2VdO0HIWKr4U7dfPdI7
         MyIHd2HWA5ZfML90Tg1lrn/iIVt2rtvM/UX8O8VIPXUBO6AA2UtR41IqGDpLRyEaIz8S
         GIV2Thd+NQtXfCL1FHhzT6BJpWv1ptrf7bQxMnXSmGnRlXbPWM+1g/eLDhW1NsaWO7na
         sGqGkf9D7ip4YzBsHC4pt/JNSyoW3GkUzBxzZA6gsv1McD8u/EwlL1+3SAz58uPLStV0
         x4S1GPkpukIoo5u5rAeMTCfsVc/BfHJi+bMGPw5FAv6VcF/S+2E4XIPLsVjZXdohEJ//
         9WTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774519894; x=1775124694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPONIQtifdjV5TyWL7hOg+/X66KagRgfREtv1fK4Vd4=;
        b=n3xGlYEQIVO6wYFfurSIiHdfXwCZs1L3fuu4vjJ9eRt4xaE1VYXGzM1LlqBy3AgyeT
         z9jS6B1sqpX4RhCw7O7Nqa5nPVid1TVQKpg3TSj2kH1zDsJYyNcT8u7FH2PlyhdRti9X
         dd1XPfDUUedVHIcjV8omBgw735Hbqo0vibbDciBUPkUOEwLY96ecPc6ClCvjvJcRFncS
         tyXuZphNrQFp3xK0LlxHF0v57Bas586H7MrApH7qq/EOE2TW76tI828w7H9HrC4asrpX
         lVBRY/8BQs9TDCFsNG0z72z1m1qtayqYw0pQ7izq+BFE/3xxqzre5MJI3j72UfyR3Xwv
         MAyA==
X-Forwarded-Encrypted: i=1; AJvYcCXaQ7iVENiMzakAsk35gbwNX3ceydqKBnqL0MrskoiIv0eGx57WvVSrQXRNYDeWzwjVef/jyKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDV8Cy1Zg7PqlmkqHZDU1Vhor3aFG0VxI2xY/zGn774nGEauRD
	USrUfjCEIP/Ucd+Rwwy8X1GNKuYw+pIpZe90xQtUS7PYP8EUPtb2iop0
X-Gm-Gg: ATEYQzywH6GaQnNUlbtAremIBMFjTg+pIB2c8LepqjwWg70nogMHh7sw5CwVw7MgQuX
	NlbbRngGB7KeVmuo4/u3m9Y0OgJgQcnIRiaxlOk+8YXN3ODT2MhkyEWP5eg5FKjxEMFTPNDgnz8
	sAvV/d46OgHT8uxICkISmxTNYC2IlrACCBrudpQ8aIIegrPKgGbe7077s+shY9G0SkY/lYQAr8U
	COM0SbaN/weIQAcHDx1EklzgVjNGpJf+tp2UX8rQv7NCj8S1llvqgAsJH4ffliY/PNlUinhhEan
	4b+EuuoLoBCpvMI9OAkiDH37MpIT2mP/6Hbl/hIjFYAUM1J66qB1jZ4HCU1Wwqass1kKy7IYjx9
	2kJjuJmbntGNyXdceMIhdVx2TzEoqCWerspUc5RAbY6pr64P6nsqtUjUV+Dgbs1drer3etWneYG
	Z1+zGi2ZiMU/UhJkA=
X-Received: by 2002:adf:9dce:0:b0:437:72ce:8954 with SMTP id ffacd0b85a97d-43b88a41cadmr4441954f8f.6.1774519893723;
        Thu, 26 Mar 2026 03:11:33 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d50a:b400:cf79:b8bb:14ce:d80f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b91942e52sm6982094f8f.9.2026.03.26.03.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 03:11:33 -0700 (PDT)
Date: Thu, 26 Mar 2026 12:11:30 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org
Subject: Re: [PATCH net v4 2/4] net: dsa: microchip: Add fallback Micrel
 compatibles
Message-ID: <20260326101130.r7njcfy2u22racco@skbuf>
References: <20260326-ks8995-fixups-v4-0-989abba8f077@kernel.org>
 <20260326-ks8995-fixups-v4-2-989abba8f077@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326-ks8995-fixups-v4-2-989abba8f077@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271968-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 830AC333756
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 10:57:33AM +0100, Linus Walleij wrote:
> Because of forking paths when Micrel was acquire by Microchip,
> two devices also exist with the micrel,* prefix bindings.
> Ass these to the KSZ SPI driver so users can use the more capable

I'm not sure what was the intention, but I believe in literary English
it would be "add these".

> driver.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  drivers/net/dsa/microchip/ksz_spi.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/net/dsa/microchip/ksz_spi.c b/drivers/net/dsa/microchip/ksz_spi.c
> index d8001734b057..e3bb1ccf2331 100644
> --- a/drivers/net/dsa/microchip/ksz_spi.c
> +++ b/drivers/net/dsa/microchip/ksz_spi.c
> @@ -312,6 +312,21 @@ static const struct of_device_id ksz_dt_ids[] = {
>  		.compatible = "microchip,lan9646",
>  		.data = &ksz_switch_chips[LAN9646]
>  	},
> +	/*
> +	 * Legacy Micrel bindings. In 2015 Microchip acquired
> +	 * Micrel which is the originator of the KSZ series, and
> +	 * devices branded for Micrel already existed, as well as
> +	 * some device tree bindings. These two products are identical
> +	 * to the same Microchip products.
> +	 */
> +	{
> +		.compatible = "micrel,ksz8864",
> +		.data = &ksz_switch_chips[KSZ8864]
> +	},
> +	{
> +		.compatible = "micrel,ksz8795",
> +		.data = &ksz_switch_chips[KSZ8795]
> +	},

Could you keep the list sorted alphabetically? "micrel" comes before "microchip".

>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, ksz_dt_ids);
> 
> -- 
> 2.53.0
> 

