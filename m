Return-Path: <netdev+bounces-20859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A62EA761980
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 15:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34804281118
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 13:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559EF1F18F;
	Tue, 25 Jul 2023 13:14:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E091426D
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 13:14:59 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17C2F2
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 06:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690290897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ksJmEPaKPWulxtTekCJOp6ODdDlUKZYiaFvv2EOL5tI=;
	b=DOE26AJObES3blCkw+PEqm9JnHbX8VeOvaOQMSoMzV/d7GtU3a6tmfqtCo2HhIrvxdMVlY
	qLPqw5r1eaJ0/ObO3rGpxPrGAZgHxwtZVMnhPSIOzPIbfS6PoP7t8AQQ3TCLxilYpHvxHJ
	aqmtl0C3PitBhTlHz4VurVTc0yJG8sM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-x5qGy9B8N4OPuh0YPoY2lw-1; Tue, 25 Jul 2023 09:14:56 -0400
X-MC-Unique: x5qGy9B8N4OPuh0YPoY2lw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-635eb5b04e1so14848226d6.1
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 06:14:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690290895; x=1690895695;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ksJmEPaKPWulxtTekCJOp6ODdDlUKZYiaFvv2EOL5tI=;
        b=WKOPD8J8ik9tHl6Br9mWunSxPu4AsGVdMybEIhiaA0wcXi9sEg0/g+cGjk/d8/++op
         8G+bTrPwUmUiBTou4gdv2wadLmOGX6X7Izzs3MWbsy+CXENrlAy1tBCmNbqkaxj9RHA0
         J2sN2dxWqWYArn1n5zsCH037bAm720c1qmkMa1giKAYjWSwbSCkpnWyPIelDFIEgiQxh
         f0XigN54sb4npNj7eUoOZR/sxjKBLVY5bx909mLx+NFLTzh+sWvq7YwNhUmb187RRayv
         vIUDYFOgpKwKHG6F31eaxBAIlz/4s8aKvti2m04VMzAgTvGc1ufrZbgeZtVU6ufemyPf
         j5RQ==
X-Gm-Message-State: ABy/qLaKv3u8NZjjWnMbjUPagbK3gRuEv4Q5RA6tUX9IJQxj3YeOgzFa
	ucuKWAoA8k2ik4itTqPx90BIUH+czp34uUCFLuu2wR3CMd0l32zF4+RBwYO5P10byYMhrN8REjz
	BFBWtkw0x/0xskZG1
X-Received: by 2002:a05:6214:21a9:b0:635:dfe1:c1f2 with SMTP id t9-20020a05621421a900b00635dfe1c1f2mr15494672qvc.0.1690290895632;
        Tue, 25 Jul 2023 06:14:55 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEr111QqZmcswqKjmNhXZtsxOBrugc51d8p2QErOGKHS0I+3k6BM4xKLZId7mbpOE7fkiM/Vg==
X-Received: by 2002:a05:6214:21a9:b0:635:dfe1:c1f2 with SMTP id t9-20020a05621421a900b00635dfe1c1f2mr15494642qvc.0.1690290895384;
        Tue, 25 Jul 2023 06:14:55 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-81.dyn.eolo.it. [146.241.225.81])
        by smtp.gmail.com with ESMTPSA id y13-20020a0ce04d000000b0063d032e1619sm1442976qvk.4.2023.07.25.06.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 06:14:55 -0700 (PDT)
Message-ID: <62e3bfa752f679a1e0520c4276e936e5a9c5e83f.camel@redhat.com>
Subject: Re: [PATCH net-next 4/4] xfrm: Support UDP encapsulation in packet
 offload mode
From: Paolo Abeni <pabeni@redhat.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Jakub Kicinski
	 <kuba@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, 
 Eric Dumazet <edumazet@google.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,  Saeed Mahameed
 <saeedm@nvidia.com>, Simon Horman <simon.horman@corigine.com>, Ilia Lin
 <quic_ilial@quicinc.com>
Date: Tue, 25 Jul 2023 15:14:51 +0200
In-Reply-To: <ZL8xjo40TSPxnvLD@gauss3.secunet.de>
References: <cover.1689757619.git.leon@kernel.org>
	 <051ea7f99b08e90bedb429123bf5e0a1ae0b0757.1689757619.git.leon@kernel.org>
	 <20230724152256.32812a67@kernel.org> <ZL8xjo40TSPxnvLD@gauss3.secunet.de>
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
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-07-25 at 04:21 +0200, Steffen Klassert wrote:
> On Mon, Jul 24, 2023 at 03:22:56PM -0700, Jakub Kicinski wrote:
> > On Wed, 19 Jul 2023 12:26:56 +0300 Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > >=20
> > > Since mlx5 supports UDP encapsulation in packet offload, change the X=
FRM
> > > core to allow users to configure it.
> > >=20
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> >=20
> > Steffen, any opinion on this one? Would you like to take the whole seri=
es?
>=20
> The xfrm changes are quite trivial compared to the driver changes.
> So it will likely create less conflicts if you take it directly.
>=20
> In case you want to do that:
>=20
> Acked-by: Steffen Klassert <steffen.klassert@secunet.com>

Sounds good to me! I'm reviving the series in PW and applying it.

Thanks,

Paolo


