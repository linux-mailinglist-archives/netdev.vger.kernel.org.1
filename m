Return-Path: <netdev+bounces-40369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 101577C6F49
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 15:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40F901C20D3B
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 13:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B30D29411;
	Thu, 12 Oct 2023 13:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A1rFndWZ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B3727705
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 13:32:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FC1C0
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 06:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697117569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LtslmHir3habw2evAGTaHZ26gf2eKEdUztaY30vLpsc=;
	b=A1rFndWZHN88GBaPt94h0Kz/HPVKRh5MTk9HoCtYVa6RPNCa3g0ElKIdFsJ/FPyXORHdtc
	R3R8wkMsvCyZwNGLGHOlKOV+t0VOVXmlcxJvLOeTMf7QZ4vPSOjwRlZby7y/HN1RVGdjf/
	eJbiiAnQYeto5FIk30NiLFDhxoKTGsg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-8z6a0G4iOwW8wfm8s7R4zw-1; Thu, 12 Oct 2023 09:32:33 -0400
X-MC-Unique: 8z6a0G4iOwW8wfm8s7R4zw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9b88bcf73f2so16072666b.0
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 06:32:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697117552; x=1697722352;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LtslmHir3habw2evAGTaHZ26gf2eKEdUztaY30vLpsc=;
        b=a1+sbKPWuTLeKpUnP67EjGIFVSA+1Ky7rnxoAS8qW2mVPJkmGCf7H/oFFr5uEItOwf
         RgLkv8h/BQCP36cuBEMWhLOYKfG/Q7MaSNZ5qYA8X3frJc2ZgGQSjJtmMLc0xxHRE0YV
         ZEqER+2qRHCkBbyKQdqjc3wbh5C1+nSl699SXr/0ckvarastTBNYxJ6lZDRuL3O+6dOC
         sid7kpGPkzoXlVnHx919MaZszUH7gWi2GQEn2/2oemyL2aqn2LxZDx1ti6Hd9LuY4jYD
         HbgJOgJbz28uv9wqq5W+fO5+VaxTW3Srs51TU9+u2M8iolI3S8uA9BCtU5K7v68GMAtk
         m6Cw==
X-Gm-Message-State: AOJu0YwXCJYLwAxt2fDk06m9jdxVoRM+24Scg1nBFx8Ed9wlvdpFh5Js
	73NIpp52aJFH77o3cMRiY9toxF7Wt8Pm+tv7cFsghPT2yeNNa7VvkWZ9GyQ6KWDZLyVfI2h2PmD
	Yg8jz21EJs7Y75WrZ
X-Received: by 2002:a17:906:5185:b0:9a6:5340:c337 with SMTP id y5-20020a170906518500b009a65340c337mr18974389ejk.2.1697117552399;
        Thu, 12 Oct 2023 06:32:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfj2K02XmkF5Oc8GuB4G8hnkX9EnQ/RlQRHY79U6GUbjy/eUYbH9aVydYc2hdVxzLfZ5sxqg==
X-Received: by 2002:a17:906:5185:b0:9a6:5340:c337 with SMTP id y5-20020a170906518500b009a65340c337mr18974374ejk.2.1697117552080;
        Thu, 12 Oct 2023 06:32:32 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-228-181.dyn.eolo.it. [146.241.228.181])
        by smtp.gmail.com with ESMTPSA id k24-20020a17090646d800b00992e265495csm11049937ejs.212.2023.10.12.06.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 06:32:31 -0700 (PDT)
Message-ID: <6b70eecb1f571e51d772baea63fe66a92454b870.camel@redhat.com>
Subject: Re: [PATCH net-next] net: gso_test: fix build with gcc-12 and
 earlier
From: Paolo Abeni <pabeni@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Florian Westphal
	 <fw@strlen.de>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>, Tasmiya
	Nalatwad <tasmiya@linux.vnet.ibm.com>
Date: Thu, 12 Oct 2023 15:32:30 +0200
In-Reply-To: <CAF=yD-K2NmgM=kVFWNgJHahkjXnTF7HdfAEneM5vNLqiuUVU0g@mail.gmail.com>
References: <20231012120901.10765-1-fw@strlen.de>
	 <CAF=yD-K2NmgM=kVFWNgJHahkjXnTF7HdfAEneM5vNLqiuUVU0g@mail.gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-10-12 at 08:15 -0400, Willem de Bruijn wrote:
> On Thu, Oct 12, 2023 at 8:09=E2=80=AFAM Florian Westphal <fw@strlen.de> w=
rote:
> >=20
> > gcc 12 errors out with:
> > net/core/gso_test.c:58:48: error: initializer element is not constant
> >    58 |                 .segs =3D (const unsigned int[]) { gso_size },
> >=20
> > This version isn't old (2022), so switch to preprocessor-bsaed constant
> > instead of 'static const int'.
> >=20
> > Cc: Willem de Bruijn <willemb@google.com>
> > Reported-by: Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
> > Closes: https://lore.kernel.org/netdev/79fbe35c-4dd1-4f27-acb2-7a60794b=
c348@linux.vnet.ibm.com/
> > Fixes: 1b4fa28a8b07 ("net: parametrize skb_segment unit test to expand =
coverage")
> > Signed-off-by: Florian Westphal <fw@strlen.de>
>=20
> Reviewed-by: Willem de Bruijn <willemb@google.com>
>=20
> Thanks for the fix, Florian!
>=20
> Note to self to not only rely on my default compiler.

Unless someone barks very loudly in the next 5', I'm going to
exceptionally apply this one well before the 24h grace period, for
obvious reasons.

Cheers,

Paolo


