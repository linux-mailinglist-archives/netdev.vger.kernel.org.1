Return-Path: <netdev+bounces-97132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA40E8C94C3
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 15:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 335A91F21435
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 13:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3D447F6C;
	Sun, 19 May 2024 13:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ccS0E3Ik"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A4A18059;
	Sun, 19 May 2024 13:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716124781; cv=none; b=izKUJm+M+J4IZNh1JHiagwFlcyQK7cPiFTYAfNM7/+G66vMIa6xtC1cYypJsiSZ1roKBNBnr1DwADkdUPlBzmCwCUZxVtYr2gjU0WYu4XbMOsEsU2HH8vP6QSTY1dzpDdOAf4g2GQKNf1LyNChre0OQUPKhk2jpvJTvzu/I4AKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716124781; c=relaxed/simple;
	bh=sh/gMqg0EESdbiUTTuj1g+LtsVyzDOYSvCTYuSBIJjk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=fqWIjGZ7pgUDowvq4FkuCM3TWbm/e2LNwKV8FxnnaDLxkpLa3+jj9uKHJOru6xFt5oBkOIf7uLCyHB8XiZ3QuVke1DmKdqp3wARGbrm/vVV85jzTNPcXHJb4FfRyTm+yFx0jIeIMo+gE1GwDhlWwemP1BOmlHUxhGgz3GMbtBfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ccS0E3Ik; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716124743; x=1716729543; i=markus.elfring@web.de;
	bh=Lk4qtabSjxRoCOhNPQMtKweAUzgftFfZ+B+bn/XHG+k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ccS0E3Ik0HkOSnZriJ7WjhcKk1gXHMkl4RsHDnvk6GeroajMkrCcDYdrpPKv5YlS
	 h4WPqCNARnoSO0UWACkPggHYip0fL1jTAYIRhv9O7SIHA+gtNReC7007g0ZrOoxgJ
	 t8V6eQb3hQor2YntBYj8Ka1VjJnS89okqmU20hfclNjCa/bsEY4No01pbG18KoTdc
	 T8l7J6iWdi9pheOH1EVABLQEiTkk6bgxTdVVERVlYGPW9cBonn4vbwUByAoY8dt0J
	 wZsYfNJgcfbBseDwhBYmEeViXbhbrAJQx3b3HQvL4ruSONrUWQ/WOVCrgJ+Sj53Dm
	 oQXdV90PNt76xJrHgA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MSIJ0-1rxZYF1vR2-00SjTQ; Sun, 19
 May 2024 15:19:03 +0200
Message-ID: <f9470c3b-5f69-41fa-b0f4-ade18053473a@web.de>
Date: Sun, 19 May 2024 15:18:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Siddharth Vadapalli <s-vadapalli@ti.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-janitors@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 MD Danish Anwar <danishanwar@ti.com>, Paolo Abeni <pabeni@redhat.com>,
 Roger Quadros <rogerq@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
 Misael Lopez Cruz <misael.lopez@ti.com>, Sriramakrishnan <srk@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
References: <20240518124234.2671651-13-s-vadapalli@ti.com>
Subject: Re: [RFC PATCH net-next 12/28] net: ethernet: ti: cpsw-proxy-client:
 add NAPI RX polling function
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240518124234.2671651-13-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/3uoYAxcF9ekf/7FNbb49aneEw5ylQTjVfmWK1vUXNNqFnCJ0/K
 MQUmHaPEFke+/dSnp5at7YYkw87y7UiZhVDCXhlkarC5vlD3UUe0e7qkk5kF/zTobHGZFFk
 vAsepCwlvi/PyhSa6dM0YzWBJpRaDBjtrH++k+9DU6sGvrvlqAVp+zKh4//2vFsGji1q/0R
 VjM0eXcFcXnJYRC1nv2Bg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OP4700k9zPo=;VCkvx6LeC7jih8NnSdv6M5q1hla
 /MVArGVPhR9LytY9FqUrZSLp0u0Rb3gvn0WcDR2AVoipaLTpBYylU27pqltJ2YSUtJgVKVjwb
 wZ8xFRsdaUVb5zqbTxA06n2SRw2+2svefzJ2/WJ1x7/jcSB2yJOcTXdGmkD4w11YoYj8PPLLD
 qaDhRPukJebcVcBUUzo2hFfwT97gUR/dX/2j+TLRGFs+ZqDJ+Vfr2BfR+NF4L8fyCBGHTRhF7
 ZyPBjZVy45SwgI62ZopPawEoXVG0ACuIcqHRbCTFUwtwkERV5oiueNnSHPPx5IQlL5XGQ6oxM
 RB8gLam/tTY3lQwZKDxJ0ugGsWM4FMkOWIs+VEvGxgQKZuw0L6nnqDIp2qH4OAsxqVZJh+iYG
 aRfTnsvYe8DEdsXfb+SjnP1AvtZm3oQXOYf6q6lYiphNHhwCY8U7yymEH/wv3N0q8JhV4+0v1
 1bzp+yKtezgRK2W88FvZ40/GmoYK6gbLNMUVgHr/fVzy4MPoiUr7DLxUznGtRVzW4UouiMYzN
 ypAM0XxrURiKWoRQ8vGOGnHnPXXYuve8YZB0kAzTXysjjAE7lqJ5dOsyYWBgYxiH2aJfaA3gW
 l8VKql/ilmLgNd8JPyomGnKeOZo5Via61cfLlzAv6N/A1/mrk8w8A0ULOxcejsxcA5WKU0/2k
 D2VBiIdNrnawpco5oRA83MjIkkqNd20k+X/lnoHuRikfnYeO97vriQWRdnMZofpd4FkNqwkP4
 N+MB+BnUMo/AX/+GRJEliUokzpadtlIFAk0gfwnLZhobz4S5xN/VcE5aDNxpdEGCmNZnbDEbW
 GHHNaXm8s0+EyBzAAbH1kKM0Fd3P1bOvro39qofQ7rnuM=

=E2=80=A6
> +++ b/drivers/net/ethernet/ti/cpsw-proxy-client.c
=E2=80=A6
> @@ -988,6 +994,189 @@ static int vport_tx_poll(struct napi_struct *napi_=
tx, int budget)
=E2=80=A6
> +static int vport_rx_packets(struct virtual_port *vport, u32 rx_chan_idx=
)
> +{
=E2=80=A6
> +	if (unlikely(!netif_running(skb->dev))) {
> +		dev_kfree_skb_any(skb);
> +		return -ENODEV;
> +	}

I suggest to move such exception handling to the end of this function impl=
ementation
so that it can be better reused also by another if branch.
https://wiki.sei.cmu.edu/confluence/display/c/MEM12-C.+Consider+using+a+go=
to+chain+when+leaving+a+function+on+error+when+using+and+releasing+resourc=
es

How do you think about to increase the application of scope-based resource=
 management
also for such a software component?
https://elixir.bootlin.com/linux/v6.9.1/source/include/linux/cleanup.h

Regards,
Markus

