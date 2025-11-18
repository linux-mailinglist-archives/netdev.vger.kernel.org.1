Return-Path: <netdev+bounces-239581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A04F5C69E3A
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 15:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 227D64EEE8E
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 14:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EB135A952;
	Tue, 18 Nov 2025 14:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WYSAedWI"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9069A34D927
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 14:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763475067; cv=none; b=t4BgPCU42d+ePcapBdqXgWmIOFK3KPPwuAZB2lijjWSgJR0Vu29arp95d4n3aQIUP0UVuPh/Y64DfxO7DSICncecq370kdDAWwSpSsip9Syhbe+2XUHPzHLcOwOsYDYpQyGQmk70tHd+DS6TRmCJgjkQ+nokElC4r4xzWIMKtbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763475067; c=relaxed/simple;
	bh=PQud6e92thFB9c6Au+YY3nmgq5hbNd84jqohl6Xni4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A9WJYzT2TTViFIIYwm8gmPyYPWrw6cMdKvT3FRNyOvSo9zViP7TFqF+EAZNlmS1uY7F6sWO59Mvt7a33W/p+g5mz108uUElc+Zw2a1cDefEJedW/36efJs1Q1MtH4SGjIzmo89x+uFA9xtde0yIS9uZZHpOi3jlTrUfV4Goec3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WYSAedWI; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DC5031A1B8A;
	Tue, 18 Nov 2025 14:11:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AA111606FE;
	Tue, 18 Nov 2025 14:11:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3318710371867;
	Tue, 18 Nov 2025 15:11:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763475062; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=fEyc8tBhzMb3rXZXOABx0llI2kXfmiLR4TsCiclkMc0=;
	b=WYSAedWIp7vQsJdM+ma5o74b/uVpOUFKFpX0F6z5nFZuFswh0GZxndiGHZP9lwwXXBWqqF
	wUt7U1GRXDGRXpCOYq7SB2te3Af2PmyPWr6Gfo9sNz4Bss04ZconS0xwbHvsqjmgbb1AhQ
	eJaBS5vGZ90+oNyDKbe+WvEHAP38O+h14ICPMhB2RfRyC7ui7I5hu3r1EJl1XSihC/wh98
	Vw5HnA8ijaEF8OZLI18PkNj7lTrg82Vn4eeL/wI5t45wwKs0Vt05DcvOwUTvFgUojwRv4z
	fj7KPN++DIsdKFikYM7jJDv71wQ8MRzCS0o4ip3LrVpTaNXdbVsu4eUJqafsZA==
Message-ID: <10541c3d-07b8-4dd7-8a17-b122b1b81996@bootlin.com>
Date: Tue, 18 Nov 2025 15:10:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: dsa: yt921x: Fix MIB attribute table
To: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20251118091237.2208994-1-mmyangfl@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251118091237.2208994-1-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi David,

On 18/11/2025 10:12, David Yang wrote:
> There are holes in the MIB field I didn't notice, leading to wrong
> statistics after stress tests.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Even if this is fixing a patch that's still in net-next, you may want to
add a fixes tag, as this is a bugfix :/

Maxime

> ---
>  drivers/net/dsa/yt921x.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
> index 944988e29127..97fc6085f4d0 100644
> --- a/drivers/net/dsa/yt921x.c
> +++ b/drivers/net/dsa/yt921x.c
> @@ -56,13 +56,13 @@ static const struct yt921x_mib_desc yt921x_mib_descs[] = {
>  
>  	MIB_DESC(1, 0x30, NULL),	/* RxPktSz1024To1518 */
>  	MIB_DESC(1, 0x34, NULL),	/* RxPktSz1519ToMax */
> -	MIB_DESC(2, 0x38, NULL),	/* RxGoodBytes */
> -	/* 0x3c */
> +	/* 0x38 unused */
> +	MIB_DESC(2, 0x3c, NULL),	/* RxGoodBytes */
>  
> -	MIB_DESC(2, 0x40, "RxBadBytes"),
> -	/* 0x44 */
> -	MIB_DESC(2, 0x48, NULL),	/* RxOverSzErr */
> -	/* 0x4c */
> +	/* 0x40 */
> +	MIB_DESC(2, 0x44, "RxBadBytes"),
> +	/* 0x48 */
> +	MIB_DESC(1, 0x4c, NULL),	/* RxOverSzErr */
>  
>  	MIB_DESC(1, 0x50, NULL),	/* RxDropped */
>  	MIB_DESC(1, 0x54, NULL),	/* TxBroadcast */
> @@ -79,10 +79,10 @@ static const struct yt921x_mib_desc yt921x_mib_descs[] = {
>  	MIB_DESC(1, 0x78, NULL),	/* TxPktSz1024To1518 */
>  	MIB_DESC(1, 0x7c, NULL),	/* TxPktSz1519ToMax */
>  
> -	MIB_DESC(2, 0x80, NULL),	/* TxGoodBytes */
> -	/* 0x84 */
> -	MIB_DESC(2, 0x88, NULL),	/* TxCollision */
> -	/* 0x8c */
> +	/* 0x80 unused */
> +	MIB_DESC(2, 0x84, NULL),	/* TxGoodBytes */
> +	/* 0x88 */
> +	MIB_DESC(1, 0x8c, NULL),	/* TxCollision */
>  
>  	MIB_DESC(1, 0x90, NULL),	/* TxExcessiveCollistion */
>  	MIB_DESC(1, 0x94, NULL),	/* TxMultipleCollision */
> @@ -705,7 +705,7 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
>  			res = yt921x_reg_read(priv, reg + 4, &val1);
>  			if (res)
>  				break;
> -			val = ((u64)val0 << 32) | val1;
> +			val = ((u64)val1 << 32) | val0;
>  		}
>  
>  		WRITE_ONCE(*valp, val);


