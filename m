Return-Path: <netdev+bounces-39476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DF97BF6D6
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 11:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DCF81C20A79
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 09:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D78416408;
	Tue, 10 Oct 2023 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QC6kpxL5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796A46120
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 09:08:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A906A7
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 02:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696928909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8SGMaej2az2tqQ+b+aLiXZWX07U/kW/TMxTzjceylHQ=;
	b=QC6kpxL5uiJIdZgvpT2gsP3ax3EIuAoWnsBfL9nyAQIvW/o11Tou92F7bL+Hr1mbgCaiPX
	TMBgXc/mkMKOWzp+3ClSsfigyKaxERg99P2eJE19oIQT91QssR+U04PrmXG6LWosY/PNlO
	Dee0R0QIZCJnavDo8tukRDcXo3zvh0A=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-VJMZPcG8NzSsY9vZBwRUFA-1; Tue, 10 Oct 2023 05:08:27 -0400
X-MC-Unique: VJMZPcG8NzSsY9vZBwRUFA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9b88bcf73f2so99846166b.0
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 02:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696928906; x=1697533706;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8SGMaej2az2tqQ+b+aLiXZWX07U/kW/TMxTzjceylHQ=;
        b=gZO6nyKDFmTIBVO4BWUD+gqA5Mu+3Vad8wBXC55RMczdCs9hYB7mviiQq4uTWNEKDe
         MljJpbrlaE/25OMNEXIOHDOoqJOdQ5vs4D++fee4tBF6PYKG53cJ2b+O2uXCzf/D2XhD
         Xl9nnZv+LoalA0Rufvadd5EPtvXYFszkcB41w2jN2Y0Yt+szdn+aK0Yd8XD2L40Bg1mf
         x94jJbHDoVLpi1a9NqTx0EglIs5Hm2XFmIilgIzeSovcjwlSM2c0NVSJp1Z/t06hQfNy
         TdFU+qesj9Hcv/I7hUqYX8KjNawwmkq1MAqWUdAf+W+CWrECI6T436mnzEl59j/ALWbP
         0+yg==
X-Gm-Message-State: AOJu0YxdlQHaR45bnwhlU8yIcdA37d707gTkFb7HMEb/wkb2Q6sbNb4Z
	6ISdVE0eefk7JC6P23+YRVcdEns50ss1uXY8CEAuzTf4LCLfBlZr84A6kU3NXWBdRHRhWKaRXB+
	aBfytf2KGs8VKTEs4
X-Received: by 2002:a17:906:5185:b0:9a6:5340:c337 with SMTP id y5-20020a170906518500b009a65340c337mr13558709ejk.2.1696928906033;
        Tue, 10 Oct 2023 02:08:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjLPWFW3Oa+Gu8e6F6lxJHXaOM5jSna9R5+67jwslPHND/AsJB3ynGxMcUsiRGISRXdLYOMg==
X-Received: by 2002:a17:906:5185:b0:9a6:5340:c337 with SMTP id y5-20020a170906518500b009a65340c337mr13558697ejk.2.1696928905722;
        Tue, 10 Oct 2023 02:08:25 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-228-243.dyn.eolo.it. [146.241.228.243])
        by smtp.gmail.com with ESMTPSA id qq25-20020a17090720d900b00977cad140a8sm8112570ejb.218.2023.10.10.02.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 02:08:25 -0700 (PDT)
Message-ID: <3b763763b779f95dc478c0b9177c60a97c1881b1.camel@redhat.com>
Subject: Re: [net-next PATCH v3 04/10] netdev-genl: Add netlink framework
 functions for queue
From: Paolo Abeni <pabeni@redhat.com>
To: Amritha Nambiar <amritha.nambiar@intel.com>, netdev@vger.kernel.org, 
	kuba@kernel.org
Cc: sridhar.samudrala@intel.com
Date: Tue, 10 Oct 2023 11:08:24 +0200
In-Reply-To: <169516245672.7377.15243846195860899954.stgit@anambiarhost.jf.intel.com>
References: 
	<169516206704.7377.12938469824609831999.stgit@anambiarhost.jf.intel.com>
	 <169516245672.7377.15243846195860899954.stgit@anambiarhost.jf.intel.com>
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

On Tue, 2023-09-19 at 15:27 -0700, Amritha Nambiar wrote:
> Implement the netdev netlink framework functions for
> exposing queue information.
>=20
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> ---
>  net/core/netdev-genl.c |  207 ++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 204 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 336c608e6a6b..ceb7d1722f7c 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
[...]=20
>  int netdev_nl_queue_get_dumpit(struct sk_buff *skb, struct netlink_callb=
ack *cb)
>  {
> -	return -EOPNOTSUPP;
> +	struct netdev_nl_dump_ctx *ctx =3D netdev_dump_ctx(cb);
> +	const struct genl_info *info =3D genl_info_dump(cb);
> +	struct net *net =3D sock_net(skb->sk);
> +	unsigned int rxq_idx =3D ctx->rxq_idx;
> +	unsigned int txq_idx =3D ctx->txq_idx;
> +	struct net_device *netdev;
> +	u32 ifindex =3D 0;
> +	int err =3D 0;
> +
> +	if (info->attrs[NETDEV_A_QUEUE_IFINDEX])
> +		ifindex =3D nla_get_u32(info->attrs[NETDEV_A_QUEUE_IFINDEX]);
> +
> +	rtnl_lock();
> +	if (ifindex) {
> +		netdev =3D __dev_get_by_index(net, ifindex);
> +		if (netdev)
> +			err =3D netdev_nl_queue_dump_one(netdev, skb, info,
> +						       &rxq_idx, &txq_idx);
> +		else
> +			err =3D -ENODEV;
> +	} else {
> +		for_each_netdev_dump(net, netdev, ctx->ifindex) {
> +			err =3D netdev_nl_queue_dump_one(netdev, skb, info,
> +						       &rxq_idx, &txq_idx);
> +
> +			if (err < 0)
> +				break;
> +			if (!err) {
> +				rxq_idx =3D 0;
> +				txq_idx =3D 0;

AFAICS, above 'err' can be either < 0 or =3D=3D 0. The second test: '!err'
should be unneeded and is a bit confusing.

Cheers,

Paolo


