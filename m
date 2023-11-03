Return-Path: <netdev+bounces-45887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A0D7E01B6
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 12:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1F53281D12
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 11:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8FE14F86;
	Fri,  3 Nov 2023 11:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fLq0ZmpS"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E412214276
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 11:05:56 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143FF182
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 04:05:55 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54357417e81so10995a12.0
        for <netdev@vger.kernel.org>; Fri, 03 Nov 2023 04:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699009553; x=1699614353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkyzgOcAguIECOGaQE8cnAm9vlwFOFHgvwGD2Qs61bA=;
        b=fLq0ZmpSd7VGfbRyknimK+ekL4boLdn8MJ7v7jZ9daBdvfXbS+VObL5+xiV43j8Dob
         GPSeXBWnNt2dt4Pu63XqfEn22c/qn4pJStys9aIhhiRaCvbn6zqtOm0nIfqXYYHHFnW1
         FRODCLIE54BkopxhbMsG50V7EC2VH3lp9RaIaTsrb4n0lPJs2hHnydRnMM45YGTJE3PG
         Nbu36dKZYJqzy8zUC7EBCQUvSdXarWbAgMauLpA2ju00RkMS/9VrArzqou7/4aFo/g4L
         9qMqJ/sn+Rbr4CXd5zX+ZLGjzZCaarHFEfJTpuJM3bmYeGtcToFYDQaBPMF9KLEduETv
         8qAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699009553; x=1699614353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FkyzgOcAguIECOGaQE8cnAm9vlwFOFHgvwGD2Qs61bA=;
        b=O6+Ogs/vWSrcQsueriprpI8w1fT7S8iXWXRmdWtLF/jE5R1rGGejtuy4OHEnWncyXa
         ZPGCqa6BauikoVCOovqRsouib9d+bopAdlkSftjAtZrIGHveYg8Vw5opETCSZ3OiFLGy
         soRzAoL5Atwfeu0HRcuKirw/hSsqx3cwo1717EWfG7C6vQih3uZV86pz5A7mib9CZKmC
         fGVxvy6k75DmkrGZmnQzt/c4jdhAY4RrmUC6NKiZFW0qbRk/Y8rgW2ntJyHCezSgAwEq
         mWrsQ5cCpqntNeFZtvnxIi80tAREh5/YAHgOqy656MwDGpVSiNc0pUCX0EhbeYALpQk3
         TOcg==
X-Gm-Message-State: AOJu0YxWgmFDceHroPBJULKTcDiGt20vJHskpni3iQG1Ba0zjI7kMlNw
	l7PDLt4abikUs6nE/YY5xHGxf5vLrAgmivYIwvCJeQ==
X-Google-Smtp-Source: AGHT+IEQrMkxU7qPq2Ier5clSh80A+2XUbExlsyt2kT+4YvxowiAHNZh37dP53rUuvlq/ZBJ9De0inVctTQzIZWGyOY=
X-Received: by 2002:a05:6402:350a:b0:543:faac:e136 with SMTP id
 b10-20020a056402350a00b00543faace136mr196207edd.1.1699009553117; Fri, 03 Nov
 2023 04:05:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031015756.1843599-1-sunytt@google.com> <ZUNxcxMq8EW0cVUT@shredder>
 <CAF+qgb4gW8vBb8c2xDHfsXsm1-O2KCwXMCTUcT2mYqED51fHoQ@mail.gmail.com> <fc356b9d-d7fc-4db8-b26c-8c786758d3e5@6wind.com>
In-Reply-To: <fc356b9d-d7fc-4db8-b26c-8c786758d3e5@6wind.com>
From: Yang Sun <sunytt@google.com>
Date: Fri, 3 Nov 2023 19:05:34 +0800
Message-ID: <CAF+qgb6uUF-Z8EkZoqzfboaCZv4PP6yG_r=-2ojaG9T61Kg3jA@mail.gmail.com>
Subject: Re: [PATCH] net: ipmr_base: Check iif when returning a (*, G) MFC
To: nicolas.dichtel@6wind.com
Cc: Ido Schimmel <idosch@idosch.org>, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 10:19=E2=80=AFPM Nicolas Dichtel
<nicolas.dichtel@6wind.com> wrote:
>
> Le 02/11/2023 =C3=A0 12:48, Yang Sun a =C3=A9crit :
> >> Is this a regression (doesn't seem that way)? If not, the change shoul=
d
> >> be targeted at net-next which is closed right now:
> >
> >> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
> >
> > I see.
> >
> >>> - if (c->mfc_un.res.ttls[vifi] < 255)
> >>> + if (c->mfc_parent =3D=3D vifi && c->mfc_un.res.ttls[vifi] < 255)
> >
> >> What happens if the route doesn't have an iif (-1)? It won't match
> >> anymore?
> >
> > Looks like the mfc_parent can't be -1? There is the check:
> >     if (mfc->mf6cc_parent >=3D MAXMIFS)
> >         return -ENFILE;
> > before setting the parent:
> >     c->_c.mfc_parent =3D mfc->mf6cc_parent;
> >
> > I wrote this patch thinking (*, G) MFCs could be per iif, similar to th=
e
> > (S, G) MFCs, like we can add the following MFCs to forward packets from
> > any address with group destination ff05::aa from if1 to if2, and forwar=
d
> > packets from any address with group destination ff05::aa from if2 to
> > both if1 and if3.
> >
> > (::, ff05::aa)      Iif: if1 Oifs: if1 if2  State: resolved
> > (::, ff05::aa)      Iif: if2 Oifs: if1 if2 if3  State: resolved
> >
> > But reading Nicolas's initial commit message again, it seems to me that
> > (*, G) has to be used together with (*, *) and there should be only one
> > (*, G) entry per group address and include all relevant interfaces in
> > the oifs? Like the following:
> >
> > (::, ::)         Iif: if1 Oifs: if1 if2 if3   State: resolved
> > (::, ff05::aa)   Iif: if1 Oifs: if1 if2 if3   State: resolved
> >
> > Is this how the (*, *|G) MFCs are intended to be used? which means pack=
ets
> > to ff05::aa are forwarded from any one of the interfaces to all the oth=
er
> > interfaces? If this is the intended way it works then my patch would br=
eak
> > things and should be rejected.
> Yes, this was the intend. Only one (*, G) entry was expected (per G).
>
> >
> > Is there a way to achieve the use case I described above? Like having
> > different oifs for different iif?
> Instead of being too strict, maybe you could try to return the 'best' ent=
ry.
>
> #1 (::, ff05::aa)      Iif: if1 Oifs: if1 if2  State: resolved
> #2 (::, ff05::aa)      Iif: if2 Oifs: if1 if2 if3  State: resolved
>
> If a packet comes from if2, returns #2, but if a packet comes from if3, r=
eturns
> the first matching entry, ie #1 here.
>

Thanks for your reply Nicolas!
Here if it returns the first matching then it depends on which entry
is returned first
by the hash table lookup, the forwarding behavior may be indeterminate
in that case
it seems.

If a packet has no matching (*, G) entry, then it will use the (*, *)
entry to be forwarded
to the upstream interface in (*, *). And with the (*, *) it means we
won't get any nocache upcall
for interfaces included in the static tree, right? So the (S, G) MFC
and the static proxy MFCs
are not meant to be used together?

I wonder how a real use case with (*, G|*) would look like, what
interface could be an
upstream interface. Is there an example?

Thanks,
Yang

>
> Regards,
> Nicolas

