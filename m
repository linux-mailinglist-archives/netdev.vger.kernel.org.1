Return-Path: <netdev+bounces-46223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBCC7E2994
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 17:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CB10281640
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 16:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3892029402;
	Mon,  6 Nov 2023 16:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="jjfvaDv0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF8429411
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 16:17:51 +0000 (UTC)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C56191
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 08:17:50 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d9caf5cc948so4751351276.0
        for <netdev@vger.kernel.org>; Mon, 06 Nov 2023 08:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1699287469; x=1699892269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMB8B7TATt5r5tDIc3Au0nx8uNSxtn6/HLVfxQrQuoY=;
        b=jjfvaDv0ExBBVm6wBqJB4AUs4XIBhQfepHlN2PkzOXdSGk7DOcwQer1Zt+Toiq2oU3
         eoSItzrjndGuaDn2LZ8uG/uGGRf5YWgBM4MYnD2wvaid/ZXT32DKjdYojzktgibI7DjO
         azlF7nlI4ZmAEVUFH7cZAOSJXNGadDxipVfNnNb3xHtgOM8aVvunaymVfGbLpufN34cq
         ZeaCsBikXAgJBicTbg0B5fGnsbqv0toR3KSYEnJY9jahwlkT4dZgda9zMwewzIWFYiEm
         HojyPSmfpjGTO5fn+iAsKakBM7dmVYGdBCBEOPi5AdmBgz+2cyPlupdbWuYXTkcSDErk
         OR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699287469; x=1699892269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PMB8B7TATt5r5tDIc3Au0nx8uNSxtn6/HLVfxQrQuoY=;
        b=w74nVVke+rm5ftZ25UPYWO2xlXNIfPSX4m9TyyW6i47s3UP5NBw35i6gBqKhQixExA
         aMRD1xerNocziIP6x507Rn9NR82TuKO4Sph4Ff9MFPN1Pljn+0sXgfKI200ztdE2TbKg
         rJBvQQxjxcHdcSTV0tvJuxztVlDc9kjvErDMijD1YobIH27aGuS3sXDCnbT6zanbOlke
         acrNYjz3WoPoqHfgTU7MgXi0Tl9g2lkAxQ9ty4HkveWNbhAoyCgOCJ/fjGVcZUc2cT+8
         gQnD8d2OOoG6E2iGmIPnegGU/DgxBO2pxNLnkR/8ru3GNBCv+lEhZHhgVRFcNfJDowja
         a9LA==
X-Gm-Message-State: AOJu0YyVb7hwtj2J4C5VEJMMos5Zxbrz8OwfRycGDZjIRyw9k3c0IF1D
	9i4FWrBrFSTmNszE57ckzBqfF7P9jrF30wSTwGxACQ==
X-Google-Smtp-Source: AGHT+IEuHcUaVHI8miNcg7mhb0rI+KxV/sIYLIV9JpJwti5pqb24J0aBEvtyII8qNTujKY5CtdsKcRcY817OTHyWf9c=
X-Received: by 2002:a25:b97:0:b0:da0:ccd6:b8a2 with SMTP id
 145-20020a250b97000000b00da0ccd6b8a2mr26942734ybl.19.1699287469533; Mon, 06
 Nov 2023 08:17:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGXJAmy-0_GV7pR5_3NNArWZumunRijHeSJnY=VEf8RjmegZZw@mail.gmail.com>
 <29217dab-e00e-4e4c-8d6a-4088d8e79c8e@lunn.ch> <CAGXJAmzn0vFtkVT=JQLQuZm6ae+Ms_nOcvebKPC6ARWfM9DwOw@mail.gmail.com>
 <20231105192309.20416ff8@hermes.local> <b80374c7-3f5a-4f47-8955-c16d14e7549a@kernel.org>
 <CAM0EoMm+x2eOVbn_NMDYVu4tEjccvvHObt0OSPvCibMAfiNs5w@mail.gmail.com>
In-Reply-To: <CAM0EoMm+x2eOVbn_NMDYVu4tEjccvvHObt0OSPvCibMAfiNs5w@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 6 Nov 2023 11:17:38 -0500
Message-ID: <CAM0EoM=nzobHqxD45wf+DR-sAGSaxE2m-kUf__40-rekdkhhoA@mail.gmail.com>
Subject: Re: Bypass qdiscs?
To: David Ahern <dsahern@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>, John Ousterhout <ouster@cs.stanford.edu>, 
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 6, 2023 at 11:12=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Sun, Nov 5, 2023 at 11:27=E2=80=AFPM David Ahern <dsahern@kernel.org> =
wrote:
> >
> > On 11/5/23 8:23 PM, Stephen Hemminger wrote:
> > > On Sat, 4 Nov 2023 19:47:30 -0700
> > > John Ousterhout <ouster@cs.stanford.edu> wrote:
> > >
> > >> I haven't tried creating a "pass through" qdisc, but that seems like=
 a
> > >> reasonable approach if (as it seems) there isn't something already
> > >> built-in that provides equivalent functionality.
> > >>
> > >> -John-
> > >>
> > >> P.S. If hardware starts supporting Homa, I hope that it will be
> > >> possible to move the entire transport to the NIC, so that applicatio=
ns
> > >> can bypass the kernel entirely, as with RDMA.
> > >
> > > One old trick was setting netdev queue length to 0 to avoid qdisc.
> > >
> >
> > tc qdisc replace dev <name> root noqueue
> >
> > should work
>
> John,
> IIUC,  Homa transmit is done by  a pacer that ensures the packets are
> scheduled without forming the queues in the NIC. So what David said
> above should be sufficient setup.


BTW, Homa in-kernel instead of bypass is a better approach because you
get the advantages of all other infra that the kernel offers..

cheers,
jamal

> cheers,
> jamal
> >

