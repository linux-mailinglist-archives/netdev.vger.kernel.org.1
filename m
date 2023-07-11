Return-Path: <netdev+bounces-16800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3945774EBA5
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 12:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94DE428176B
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 10:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C4C182D5;
	Tue, 11 Jul 2023 10:21:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C24182B1
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 10:21:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE847136
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 03:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689070879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zxNChGIelKjoLuG8SrdI8P5hWqfFpZJORMAj7Wr1DkU=;
	b=CUzGjuj9KAOdkp9UlC7niCxBqcDsgAltnWZeK5m1rymtgAItJ+p4fviEiT93OOGAqjStya
	0VDk7cq56NeubDdL6H0aS4mOBguXOrAXqfI8BvCdGxBSemZX06NByQ1/JMejlty6NdJxp3
	IG2nT1XiEAXRg9pT9tQkuUSWA6p6xrs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-4g4ASwHrNmiKc-59IpSegQ-1; Tue, 11 Jul 2023 06:21:16 -0400
X-MC-Unique: 4g4ASwHrNmiKc-59IpSegQ-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-40234d83032so11494951cf.1
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 03:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689070876; x=1689675676;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zxNChGIelKjoLuG8SrdI8P5hWqfFpZJORMAj7Wr1DkU=;
        b=J6353AmgtAHL1TUD8zSd9fMcZ+Efho98RRcyjEeGOBKsq4F1A/rXRtZaBRqEp6wDt/
         jx5LHCAa9nuHyUqWRezumkzkv//QU3+kEWWpzEZG4ecMoiEKjdUanVxtKeTIaAPxAZIJ
         qoCJzgVOczIc8TdCBbbVMRokPaF9Ihhuwu6LZaEL/l2GvreEAyyCha6rf0yjv28/BBru
         RH0jH2cQdl2d1sJS64o5GRDyT0uTDnAkb6pBdQ4IS2ae8A7ISMux3zhCRfTj+H4enOP7
         IfKJc6dfIEClXz1zjatFmCzZIjvZPE3cOc6GM38/q8KuqcIfSt8mIrfvq2PkjZYAvdwM
         jQXQ==
X-Gm-Message-State: ABy/qLZu+uJ6oKeywbNze0YdwPjuxNNySrX7mfv/hR6G9zNtb06eGhMY
	5BghozYpTfycnalH4+TiHtoCBX9BQ0X/BMU8y6ZwOVT+uaFwMaaO3Nze8cQ3RMpPG9Keft9FkB1
	H2+FNs3Ak/WiiRE05
X-Received: by 2002:a05:622a:1007:b0:3fd:eb2f:8627 with SMTP id d7-20020a05622a100700b003fdeb2f8627mr16474672qte.6.1689070876146;
        Tue, 11 Jul 2023 03:21:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE3KtM/WsWfyD0RTFaAra9Jvq2qFoYXTelie53paqoYE7qWLud5Wx2SOGqm6fMhIg5bzlRT5Q==
X-Received: by 2002:a05:622a:1007:b0:3fd:eb2f:8627 with SMTP id d7-20020a05622a100700b003fdeb2f8627mr16474659qte.6.1689070875925;
        Tue, 11 Jul 2023 03:21:15 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-188.dyn.eolo.it. [146.241.235.188])
        by smtp.gmail.com with ESMTPSA id d4-20020ac851c4000000b00403ad6ec2e8sm954982qtn.26.2023.07.11.03.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 03:21:15 -0700 (PDT)
Message-ID: <2a2d55f167a06782eb9dfa6988ec96c2eedb7fba.camel@redhat.com>
Subject: Re: [PATCH net-next][resend v1 1/1] netlink: Don't use int as bool
 in netlink_update_socket_mc()
From: Paolo Abeni <pabeni@redhat.com>
To: Leon Romanovsky <leon@kernel.org>, Andy Shevchenko
	 <andriy.shevchenko@linux.intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
	Dumazet <edumazet@google.com>
Date: Tue, 11 Jul 2023 12:21:12 +0200
In-Reply-To: <20230711063348.GB41919@unreal>
References: <20230710100624.87836-1-andriy.shevchenko@linux.intel.com>
	 <20230711063348.GB41919@unreal>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-07-11 at 09:33 +0300, Leon Romanovsky wrote:
> On Mon, Jul 10, 2023 at 01:06:24PM +0300, Andy Shevchenko wrote:
> > The bit operations take boolean parameter and return also boolean
> > (in test_bit()-like cases). Don't threat booleans as integers when
> > it's not needed.
> >=20
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  net/netlink/af_netlink.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> > index 383631873748..d81e7a43944c 100644
> > --- a/net/netlink/af_netlink.c
> > +++ b/net/netlink/af_netlink.c
> > @@ -1623,9 +1623,10 @@ EXPORT_SYMBOL(netlink_set_err);
> >  /* must be called with netlink table grabbed */
> >  static void netlink_update_socket_mc(struct netlink_sock *nlk,
> >  				     unsigned int group,
> > -				     int is_new)
> > +				     bool new)
> >  {
> > -	int old, new =3D !!is_new, subscriptions;
> > +	int subscriptions;
> > +	bool old;
> > =20
> >  	old =3D test_bit(group - 1, nlk->groups);
> >  	subscriptions =3D nlk->subscriptions - old + new;
>=20
> So what is the outcome of "int - bool + bool" in the line above?

FTR, I agree with Leon, the old code is more readable to me/I don't see
a practical gain with this change.

Cheers,

Paolo


