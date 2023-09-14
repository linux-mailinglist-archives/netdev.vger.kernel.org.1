Return-Path: <netdev+bounces-33749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0667179FE3A
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 10:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97037B20A1E
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 08:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684C6DF6A;
	Thu, 14 Sep 2023 08:24:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B037DF69
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 08:24:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FCCD1BF9
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 01:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694679846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gIR5+s1oMSRerDuiWqtnK9wcPwcVYnx0k8Wn81GsDhA=;
	b=TninCQt5lHEY5lbU9Y4MjbGC5ByKR/zdsEWl/VBI7jmd2KNEtp13F8DgD+99aau5lbi3RA
	lJW5VpZhyLr5IsA0IIow6igIKM4sRvFQ3Jrv2RCvvhNQSz+nveiyQxVV8F7XcQbvxiL9EP
	GQXfIaPS0cj5RLOfH8JRRb6SX7OBnJs=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-IVYy4uuTPG2XLszHaRMFVA-1; Thu, 14 Sep 2023 04:24:05 -0400
X-MC-Unique: IVYy4uuTPG2XLszHaRMFVA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-502b134fd49so204329e87.0
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 01:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694679843; x=1695284643;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gIR5+s1oMSRerDuiWqtnK9wcPwcVYnx0k8Wn81GsDhA=;
        b=hEgt1Tsexm78x+N9kBPS7MK8wleBqSPY0FzLHfEGbGu+ccdOsYh+JMf68UVpC2wVCp
         fLDG8vMAlCcrGqLbuSCEG2mQ0GrQ8KciS/A2d3mb3gCdST/1jBF7auzDnB6zxmVZE6Fr
         /vCrQTasBw+FNaHpENldy8/LhIpc1yql6NbY+PCF2BKGV81MFRRG3bgXzEORYby6vi9n
         +JRbLPDFisVgEWQwdRKCW8eLkx/y5f/XuvQi7TWCNBhIRtLKP0rsjC+0JQmb6SZSIkFZ
         bQ5lKK45AUfS8HnKkrve8a1XxZvfW92NN/6SBYFRRmJrojAvYqqbD71NHl1U4n27jJ2P
         C+YA==
X-Gm-Message-State: AOJu0YzePRecP2xdRATgBbLfQQkCAFS88Ec7B7jPQAWmXqNWEqMk1KJC
	W+cjbPieloFyV3mmlQMe1N5g/5hYuhM/5ZuH8i+Fgu1zEWH0JKCbDUUr1RZD+XNz9GwOOPfWPdf
	J3PdRiOsIUboVAv4c
X-Received: by 2002:ac2:43b3:0:b0:501:c406:8ff1 with SMTP id t19-20020ac243b3000000b00501c4068ff1mr3989166lfl.5.1694679843654;
        Thu, 14 Sep 2023 01:24:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFchp5mjhV334vvc1PVMFLcO6fNUdkeBdE9dcC+JSVlb/x6yKjca7qdD8I8zSRniNbbvoAZhg==
X-Received: by 2002:ac2:43b3:0:b0:501:c406:8ff1 with SMTP id t19-20020ac243b3000000b00501c4068ff1mr3989155lfl.5.1694679843277;
        Thu, 14 Sep 2023 01:24:03 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-242-187.dyn.eolo.it. [146.241.242.187])
        by smtp.gmail.com with ESMTPSA id l9-20020a056402344900b0051e1660a34esm603531edc.51.2023.09.14.01.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 01:24:02 -0700 (PDT)
Message-ID: <b6ed0ef1346363f11ddc7bb1c390a5f03f3a6b89.camel@redhat.com>
Subject: Re: [PATCH net] net: prevent address overwrite in connect() and
 sendmsg()
From: Paolo Abeni <pabeni@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jordan Rife
	 <jrife@google.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, davem@davemloft.net, Eric
 Dumazet <edumazet@google.com>, kuba@kernel.org, netdev@vger.kernel.org, 
 dborkman@kernel.org
Date: Thu, 14 Sep 2023 10:24:01 +0200
In-Reply-To: <CAF=yD-Lapvy4J748ge8k5v7gUoynDxJPpXKV8rOdgtAw7=_ErQ@mail.gmail.com>
References: <20230912013332.2048422-1-jrife@google.com>
	 <65006891779ed_25e754294b8@willemb.c.googlers.com.notmuch>
	 <1ca3ca8a-6185-bc55-de74-53991ffc6f91@iogearbox.net>
	 <CADKFtnTOD2+7B5tH8YMHEnxubiG+Cs+t8EhTft+q51YwxjW9xw@mail.gmail.com>
	 <CAF=yD-KKGYhKjxio9om1rz7pPe1uiRgODuXWvoLqrGrRbtWNkA@mail.gmail.com>
	 <CADKFtnSgBZcpYBYRwr6WgnS6j9xH+U0W7bxSqt9ge5aumu4QQg@mail.gmail.com>
	 <CAF=yD-JW+Gs+EeJk2jknU6ZL0prjRO41Q3EpVTOTpTD8sEOh6A@mail.gmail.com>
	 <CADKFtnTzqLw4F2m9+7BxZZW_QKm_QiduMb6to9mU1WAvbo9MWQ@mail.gmail.com>
	 <CAF=yD-Lapvy4J748ge8k5v7gUoynDxJPpXKV8rOdgtAw7=_ErQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-09-13 at 10:02 -0400, Willem de Bruijn wrote:
> On Tue, Sep 12, 2023 at 5:09=E2=80=AFPM Jordan Rife <jrife@google.com> wr=
ote:
> >=20
> > > If we take this path, it could be a single patch. The subsystem
> > > maintainers should be CC:ed so that they can (N)ACK it.
> > >=20
> > > But I do not mean to ask to split it up and test each one separately.
> > >=20
> > > The change from sock->ops->connect to kernel_connect is certainly
> > > trivial enough that compile testing should suffice.
> >=20
> > Ack. Thanks for clarifying.
> >=20
> > > The only question is whether we should pursue your original patch and
> > > accept that this will continue, or one that improves the situation,
> > > but touches more files and thus has a higher risk of merge conflicts.
> > >=20
> > > I'd like to give others some time to chime in. I've given my opinion,
> > > but it's only one.
> > >=20
> > > I'd like to give others some time to chime in. I've given my opinion,
> > > but it's only one.
> >=20
> > Sounds good. I'll wait to hear others' opinions on the best path forwar=
d.
>=20
> No other comments so far.
>=20
> My hunch is that a short list of these changes
>=20
> ```
> @@ -1328,7 +1328,7 @@ static int kernel_bindconnect(struct socket *s,
> struct sockaddr *laddr,
>         if (rv < 0)
>                 return rv;
>=20
> -       rv =3D s->ops->connect(s, raddr, size, flags);
> +       rv =3D kernel_connect(s, raddr, size, flags);
> ```
>=20
> is no more invasive than your proposed patch, and gives a more robust out=
come.
>=20
> Please take a stab.

I'm sorry for the late feedback. For the records, I agree the cleanest
fix described above should be attempted first.

Thanks,

Paolo


