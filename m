Return-Path: <netdev+bounces-32758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CFD79A354
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 08:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DC071C20847
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 06:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D09023CF;
	Mon, 11 Sep 2023 06:09:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE3423CE
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 06:09:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B17126
	for <netdev@vger.kernel.org>; Sun, 10 Sep 2023 23:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694412567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hhw6H1r3eKnafn3hUCZd2q6G4h9A2hT4AZD8u0TVs7o=;
	b=Ut8dQIYRv5gY2PAeW5r8sUQbHJsVAxZ/dbKvY+zYle4mOKLHMqbzqyFDjA4SD8cAzZFRdD
	NoAFO71AMLGYW6CrJUDxYOS7lo+Fmm375pUgCLcLJi2fbiQpPHCaXZygSKFv6gt7Jzcik8
	puZSf1JUOLzC/ojVEtWb5WwkS1/WDCM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-dcBBtsxnNkuvRmsxynHqZg-1; Mon, 11 Sep 2023 02:09:25 -0400
X-MC-Unique: dcBBtsxnNkuvRmsxynHqZg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9aa25791fc7so19945266b.1
        for <netdev@vger.kernel.org>; Sun, 10 Sep 2023 23:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694412564; x=1695017364;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hhw6H1r3eKnafn3hUCZd2q6G4h9A2hT4AZD8u0TVs7o=;
        b=Ix0EN/DhFadzV88Ork+chKYxoR14hzRjr8UvyQ49Q7vZDRWqILBuixyg1/qoca+Wjv
         ub+NRz6elJGay+Le1zFivehcaeKQzQZ6llBtG9V54HJjQq5JEdr6HPwZJSH5cdq6UIKf
         71P4t8wyhWoEGbMUxeyERZQ4UbRReAYzyLF4RHGaF+2qi0BcMFMBQHLTHyhWjWmSqlOR
         yjfV7dlXYBDfJgwkwJk0Njzo0+hyxD5OyWnoIuBp9cxrQbNiL3lSmPvTLVhJYAP8Jf5a
         t9AkqR7mrOyQzsh68aF2Vw7t2VJfPSpIAnYUQnCtQrxI4SXVVpnvkzgWhv/SU8GX67FX
         rt9A==
X-Gm-Message-State: AOJu0YxQRP+x9QyIsLkl1MoJ5sN0mojFofzPPSxumRm0v2YN0iO31BsR
	549GbO61kaWjU8OgtUtRAsECXy873FxoWuV8YkHhsTaQ4DRjUwTe6VmtdcqbiU5MQm5NS5Gxpq9
	VThfYMk8ifiajemd40/Ys6VDW
X-Received: by 2002:a17:906:d8:b0:9a1:aea8:d7d1 with SMTP id 24-20020a17090600d800b009a1aea8d7d1mr6663996eji.4.1694412564352;
        Sun, 10 Sep 2023 23:09:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeETDunHStUQ9A4LhidF5vq5fHdxxWZOA6yRW0zlaSmyXswo8x3TW2JE+ZoSRY8hcKyhIstA==
X-Received: by 2002:a17:906:d8:b0:9a1:aea8:d7d1 with SMTP id 24-20020a17090600d800b009a1aea8d7d1mr6663988eji.4.1694412564079;
        Sun, 10 Sep 2023 23:09:24 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-243-166.dyn.eolo.it. [146.241.243.166])
        by smtp.gmail.com with ESMTPSA id z19-20020a170906715300b009a2202bfce5sm4772472ejj.118.2023.09.10.23.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 23:09:23 -0700 (PDT)
Message-ID: <4033fcc4e96bc478af551a8ffb6c1b18b9c4fe68.camel@redhat.com>
Subject: Re: [PATCH net] fix null-deref in ipv4_link_failure
From: Paolo Abeni <pabeni@redhat.com>
To: Kyle Zeng <zengyhkyle@gmail.com>, dsahern@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, ssuryaextr@gmail.com
Date: Mon, 11 Sep 2023 08:09:22 +0200
In-Reply-To: <ZPqSfGGAwa1I69Sm@westworld>
References: <ZPqSfGGAwa1I69Sm@westworld>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-09-07 at 20:18 -0700, Kyle Zeng wrote:
> Currently, we assume the skb is associated with a device before calling
> __ip_options_compile, which is not always the case if it is re-routed by
> ipvs.
> When skb->dev is NULL, dev_net(skb->dev) will become null-dereference.
> This patch adds a check for the edge case and switch to use the net_devic=
e
> from the rtable when skb->dev is NULL.
>=20
> Suggested-by: Paolo Abeni<pabeni@redhat.com>
> Suggested-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Kyle Zeng <zengyhkyle@gmail.com>
> Cc: Stephen Suryaputra <ssuryaextr@gmail.com>
> ---
>  net/ipv4/route.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index d8c99bdc617..1be34e5eea1 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -1214,6 +1214,7 @@ EXPORT_INDIRECT_CALLABLE(ipv4_dst_check);
>  static void ipv4_send_dest_unreach(struct sk_buff *skb)
>  {
>  	struct ip_options opt;
> +	struct net_device *dev;
>  	int res;
> =20
>  	/* Recompile ip options since IPCB may not be valid anymore.
> @@ -1230,7 +1231,8 @@ static void ipv4_send_dest_unreach(struct sk_buff *=
skb)
>  		opt.optlen =3D ip_hdr(skb)->ihl * 4 - sizeof(struct iphdr);
> =20
>  		rcu_read_lock();
> -		res =3D __ip_options_compile(dev_net(skb->dev), &opt, skb, NULL);
> +		dev =3D skb->dev ? skb->dev : skb_rtable(skb)->dst.dev;
> +		res =3D __ip_options_compile(dev_net(dev), &opt, skb, NULL);
>  		rcu_read_unlock();
> =20
>  		if (res)

The patch LGTM, but if you are going to re-post to address Vadim's
feedback, please additionally drop my Suggested-by. I only reviewed a
previous revision.

Thanks!

Paolo


