Return-Path: <netdev+bounces-23859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC5D76DE38
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 04:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE16C1C20F14
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 02:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4DE63BC;
	Thu,  3 Aug 2023 02:28:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D31A4C6A
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 02:28:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADA83C16
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 19:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691029612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=16eXgKzfA5P/EWY4YAQOBp0H8DL06af1WhrBTj1x7FQ=;
	b=If1KJVwCmTYf1qf1I7A1ZzJK3F8NStZvRYhinGYnkea+oLPKsHHKYzo/Wg9t5+siUsmnOU
	yzXU8FmB2IZByrnIb6kF8JDUDc3p5NQmOuWa6uzPKw4afnU+QYcnpDpJKONGrsjvVnLQmU
	jV0NKhG1gYMXObtzQwSkVzy2M75SmJ8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-eqxY37DCOIOeH0RYrc9uDQ-1; Wed, 02 Aug 2023 22:26:49 -0400
X-MC-Unique: eqxY37DCOIOeH0RYrc9uDQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b9ce397ef1so3847231fa.1
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 19:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691029607; x=1691634407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16eXgKzfA5P/EWY4YAQOBp0H8DL06af1WhrBTj1x7FQ=;
        b=NYCLHWjUV0SqA6tAMnsHEfen1/0p5JTePTW+Ztm6p0hFMWLxVcSQ0UB3m5D+/plORg
         FloxdJmnooLnnpp/2k5Q6Dv6uMuChxzWj1htcewmSpl9xcvC8GqNbsegPv0f/X/1RIps
         +pE4P4n8QFkHcsU5lTN3MVXR7Mt03dAI58qg7RsvMtK0e1/ENiOYmAxhvLgcBHq0XiJB
         ewWzEU3SREUILDrrK0ie3/cJBl1btgHE4rSKpOvyEsyLco9ZDCjP9Was571jUsb3Bijt
         ZJyyT56maLja4zhc2SG4QXd3Hn9MINlbcUZk5MIgu9mRSuYLkMMlPEmdwcARvC9p/5CM
         XWyg==
X-Gm-Message-State: ABy/qLY7YvJixVKhezgmMJain6mOmqp9lwzl6VmrWv8ok/ghOgrBuBls
	RNKchQ11o8FTFahHuQ4Oiy206JoJsen68HeluuCLx30cAkguGx0GX+5n1/PvbPjCTIMut08JrR3
	NkXl0nYbvtvLpi5QESHzhv8KyTsTc9S6p
X-Received: by 2002:a2e:8395:0:b0:2b6:9ebc:daf8 with SMTP id x21-20020a2e8395000000b002b69ebcdaf8mr5667507ljg.31.1691029607596;
        Wed, 02 Aug 2023 19:26:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEmbkKBsjTZzpx39pnCqGqYmAWOLK8am9wWZxnYBSh3HDLGeLA3rxHYmBscBc+/ozKTN0jw6p9mq/khDi8OXi4=
X-Received: by 2002:a2e:8395:0:b0:2b6:9ebc:daf8 with SMTP id
 x21-20020a2e8395000000b002b69ebcdaf8mr5667496ljg.31.1691029607326; Wed, 02
 Aug 2023 19:26:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230802182843.4193099-1-kuba@kernel.org> <64caa3a09cbbb_2c6331294a6@willemb.c.googlers.com.notmuch>
In-Reply-To: <64caa3a09cbbb_2c6331294a6@willemb.c.googlers.com.notmuch>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 3 Aug 2023 10:26:36 +0800
Message-ID: <CACGkMEu9EkopraAScxigoggdwu+0NRvn8LJOYFymnDUB7JUtdQ@mail.gmail.com>
Subject: Re: [PATCH net] MAINTAINERS: update TUN/TAP maintainers
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, pabeni@redhat.com, 
	Maxim Krasnyansky <maxk@qti.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 3, 2023 at 2:42=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jakub Kicinski wrote:
> > Willem and Jason have agreed to take over the maintainer
> > duties for TUN/TAP, thank you!
> >
> > There's an existing entry for TUN/TAP which only covers
> > the user mode Linux implementation.
> > Since we haven't heard from Maxim on the list for almost
> > a decade, extend that entry and take it over, rather than
> > adding a new one.
> >
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>
> Acked-by: Willem de Bruijn <willemb@google.com>
>
> Happy to do my part. Great to have Jason on board as well!

Thanks Willem.

Acked-by: Jason Wang <jasowang@redhat.com>

>
> > ---
> > CC: Maxim Krasnyansky <maxk@qti.qualcomm.com>
> > CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > CC: Jason Wang <jasowang@redhat.com>
> > ---
> >  MAINTAINERS | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 20f6174d9747..39b3c6e66c2e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -21673,11 +21673,14 @@ S:  Orphan
> >  F:   drivers/net/ethernet/dec/tulip/
> >
> >  TUN/TAP driver
> > -M:   Maxim Krasnyansky <maxk@qti.qualcomm.com>
> > +M:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > +M:   Jason Wang <jasowang@redhat.com>
> >  S:   Maintained
> >  W:   http://vtun.sourceforge.net/tun
>
> Should we drop this URL too?
>
> >  F:   Documentation/networking/tuntap.rst
> >  F:   arch/um/os-Linux/drivers/
> > +F:   drivers/net/tap.c
> > +F:   drivers/net/tun.c
> >
> >  TURBOCHANNEL SUBSYSTEM
> >  M:   "Maciej W. Rozycki" <macro@orcam.me.uk>
> > --
> > 2.41.0
> >
>
>


