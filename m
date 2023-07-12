Return-Path: <netdev+bounces-17059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D0074FFB7
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 08:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0528728160E
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 06:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB791FD2;
	Wed, 12 Jul 2023 06:50:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C90620F2
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 06:50:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D13DC
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 23:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689144612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t/l4l2llIvkeYOOhz2I58lxas5zvAcDYWXpunKWC/44=;
	b=bjoNGogaWaAqMHliuWfoW8fbJd9PIqdR9b0Ov4kzspbBTPS2foc1nD7TwfffF8w1hwN8ju
	JbQtV6QEaQI3rxv3MxWvSPu30drKFue3PE5d9UdAZQVz3CVwpjVbXn7d98lNp/boGeVQEN
	YKEHM0yLRgQ7lMe5rR2pIg/STen+MGw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-SRxuqeSYObCCNJxDU4w1Bg-1; Wed, 12 Jul 2023 02:50:10 -0400
X-MC-Unique: SRxuqeSYObCCNJxDU4w1Bg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-767b80384a3so98831785a.0
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 23:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689144610; x=1691736610;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t/l4l2llIvkeYOOhz2I58lxas5zvAcDYWXpunKWC/44=;
        b=IlVCzYSc1MDBrloxDqoYfjBmfm3WfshP3WT2ZTjXi2mDtX2NbTPwWUCtmlxTnC5oPk
         BWfl8gjiPw3bpsg/wWXAHivRpRFElyxmvDTcoi/ZZbyJEo+RYOQRbi62kcEGo7zwEMeb
         ZAEx24iK1sHtLIj7LXAPxmvJ9VF6clawTZsHjRQ2Co8BgH+RJCJAhhBO9Zx3VKrhcHHN
         ziCNt7/aDbw8LMl2RANWQgzTDOq02ywU+TuM1zGulPZNRwin7e+GR/pi5ZUZ/6k7Bl/N
         ARlE6cHxyoDZqBVpGo1SyAIf2dAQAE7vR96fLjD25zKCGCm7tj3Rhpx4wwvG8sfbQBSC
         WPWQ==
X-Gm-Message-State: ABy/qLaA/OTx1ae075Le/HHl1d2bq1+vGhw2jyQJaaMZZzWQNSH5KGU3
	dAUDP2JP5RiFRfnVeRcnJOg1pYnAGIxLFvm398rXVFy0opKP7Cc9H4gPq40Tx3vqsuXrZanOW72
	r9eoZt9AAdtH7xswHr1s2cTvP
X-Received: by 2002:a05:620a:4510:b0:762:41d6:c3dc with SMTP id t16-20020a05620a451000b0076241d6c3dcmr21932370qkp.0.1689144610208;
        Tue, 11 Jul 2023 23:50:10 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGOwGJRGW4tR3jEXjuiKzegFioU+QlfxiBtzlBJi1QOktBF3HTz1ELy8hA8fGQvke12IkrxCQ==
X-Received: by 2002:a05:620a:4510:b0:762:41d6:c3dc with SMTP id t16-20020a05620a451000b0076241d6c3dcmr21932348qkp.0.1689144609885;
        Tue, 11 Jul 2023 23:50:09 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-188.dyn.eolo.it. [146.241.235.188])
        by smtp.gmail.com with ESMTPSA id i28-20020a05620a151c00b00767d5b81920sm1893287qkk.85.2023.07.11.23.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 23:50:09 -0700 (PDT)
Message-ID: <5b722084c6031009f845e6af8b438d49b9ea7dc1.camel@redhat.com>
Subject: Re: [PATCH net-next 3/3] eth: bnxt: handle invalid Tx completions
 more gracefully
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	michael.chan@broadcom.com
Date: Wed, 12 Jul 2023 08:50:06 +0200
In-Reply-To: <20230711181919.50f27180@kernel.org>
References: <20230710205611.1198878-1-kuba@kernel.org>
	 <20230710205611.1198878-4-kuba@kernel.org>
	 <774e2719376723595425067ab3a6f59b72c50bc2.camel@redhat.com>
	 <20230711181919.50f27180@kernel.org>
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
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-07-11 at 18:19 -0700, Jakub Kicinski wrote:
> On Tue, 11 Jul 2023 12:10:28 +0200 Paolo Abeni wrote:
> > On Mon, 2023-07-10 at 13:56 -0700, Jakub Kicinski wrote:
> > > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/=
ethernet/broadcom/bnxt/bnxt.h
> > > index 080e73496066..08ce9046bfd2 100644
> > > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> > > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> > > @@ -1008,6 +1008,7 @@ struct bnxt_napi {
> > >  					  int);
> > >  	int			tx_pkts;
> > >  	u8			events;
> > > +	u8			tx_fault:1; =20
> >=20
> > Since there are still a few holes avail, I would use a plain u8 (or
> > bool) to help the compiler emit better code.
>=20
> Is that still true or was it only true for old compilers?
> With gcc version 13.1.1 20230614 :
>=20
> $ cat /tmp/t.c=20
> #include <strings.h>
>=20
> struct some {
>     void (*f)(void);
>     unsigned char b;
> #ifdef BLA
>     _Bool a;
> #else
>     unsigned char a:1;
> #endif
> };
>=20
> int bla(struct some *s)
> {
>     if (s->a)
>         s->f();
>     return 0;
> }
>=20
> $ gcc -W -Wall -O2  /tmp/t.c -o /tmp/t -c
> $ objdump -S /tmp/t > /tmp/a
> $ gcc -DBLA -W -Wall -O2  /tmp/t.c -o /tmp/t -c
> $ objdump -S /tmp/t > /tmp/b
> $ diff /tmp/a /tmp/b
> 8c8
> <    0:	f6 47 09 01          	testb  $0x1,0x9(%rdi)
> ---
> >    0:	80 7f 09 00          	cmpb   $0x0,0x9(%rdi)
>=20
> $ gcc -V
>=20
> Shouldn't matter, right?

Surely not a big deal. But some users (possibly most of them!) have
older compiler. Including an assignment in the test code, I get this
additional difference:

-   c:	80 4b 09 01          	orb    $0x1,0x9(%rbx)
+   c:	c6 43 09 01          	movb   $0x1,0x9(%rbx)

with the bitfield using the 'or' operation. Not a big deal, but the
other option is slightly better ;)

Cheers,

Paolo



