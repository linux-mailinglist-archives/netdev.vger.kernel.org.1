Return-Path: <netdev+bounces-103218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A56907146
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 14:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3E76B24569
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 12:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7A814265E;
	Thu, 13 Jun 2024 12:35:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA87E14199C;
	Thu, 13 Jun 2024 12:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282114; cv=none; b=dDF5bkMBkcvhFCshFNXo+RtZIXea+pRx/YB3QwB4GdDwIeSl13bxwWax37VjuM/CZAD8k4ob8/GeBvkFFDFFJT+wDUZAySK28pKB1rCWOaqp50EnYujxofhw+0/HIoVG9kzPwel5ezAovcX41OEjKX5/OZMn3eeAtNxurYTHqzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282114; c=relaxed/simple;
	bh=Toz5hjv/Fc2vhd9W5Bvfsxt4JvCxbgfNTxqzBTzdYNc=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=EksosMMe8+omhYxMC0R/Ty0b5t7y6qejudvjJ1u/H3qStL3n2LzVRfPSn6Pk5zDgamhY7s+q9/GehUsiorL4Qz31+f1UunwFKI9swRrJCgJ5wRrmPoyLrPp+Ng9QcJ7CqyTF+ChB8QTs3evbBqo9Fz4NKHCwa6Z4lRJNgwTrS0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=99085fba10=ms@dev.tdt.de>)
	id 1sHjfa-00234K-PE; Thu, 13 Jun 2024 14:35:10 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sHjfa-00FOry-80; Thu, 13 Jun 2024 14:35:10 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id F01BF240053;
	Thu, 13 Jun 2024 14:35:09 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 8594D240050;
	Thu, 13 Jun 2024 14:35:09 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 25B803852A;
	Thu, 13 Jun 2024 14:35:09 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 13 Jun 2024 14:35:09 +0200
From: Martin Schiller <ms@dev.tdt.de>
To: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 08/12] net: dsa: lantiq_gswip: Change literal
 6 to ETH_ALEN
Organization: TDT AG
In-Reply-To: <20240611135434.3180973-9-ms@dev.tdt.de>
References: <20240611135434.3180973-1-ms@dev.tdt.de>
 <20240611135434.3180973-9-ms@dev.tdt.de>
Message-ID: <234a55f08593f7c8d003d87b3ff1aac9@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate-type: clean
X-purgate: clean
X-purgate-ID: 151534::1718282110-DD5928CF-66249D3A/0/0

On 2024-06-11 15:54, Martin Schiller wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> The addr variable in gswip_port_fdb_dump() stores a mac address. Use
> ETH_ALEN to make this consistent across other drivers.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  drivers/net/dsa/lantiq_gswip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/lantiq_gswip.c 
> b/drivers/net/dsa/lantiq_gswip.c
> index 58c069f964dd..525a62a21601 100644
> --- a/drivers/net/dsa/lantiq_gswip.c
> +++ b/drivers/net/dsa/lantiq_gswip.c
> @@ -1413,7 +1413,7 @@ static int gswip_port_fdb_dump(struct dsa_switch
> *ds, int port,
>  {
>  	struct gswip_priv *priv = ds->priv;
>  	struct gswip_pce_table_entry mac_bridge = {0,};
> -	unsigned char addr[6];
> +	unsigned char addr[ETH_ALEN];
>  	int i;
>  	int err;

Signed-off-by: Martin Schiller <ms@dev.tdt.de>

