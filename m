Return-Path: <netdev+bounces-35762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C437AAFFD
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 12:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id BD192B20AD7
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 10:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A93199C6;
	Fri, 22 Sep 2023 10:53:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566DB9CA4C
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 10:53:36 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7568AF
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 03:53:34 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50302e8fca8so4373e87.0
        for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 03:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695380013; x=1695984813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smLn+CxRtpxX9ctNIYYoCY5z1MOW9XNgU+98WVi/0+U=;
        b=AxOBIGTOi5aFfIFdu+jZKKHjiXpVUkO+uJ2WuGg5V5QVIDPCGiFN8j4WR7DkCg4qEJ
         keosl79YXj5lfQNiriiNr1eqhAZBYcY0Rq4rT+KVvaFRol9xVMWvNuZWFWwleJcyFf4F
         THwG3ItJCZB64X7UPFe/Z0cEKauQBksdSCntWI0N5hLsdWQ7PdazG18pdp6Wa3Ql0bGz
         CX3qe6iqktEplh58j2MBSB7dFQlVFtNUqDrfAqppEogNlYPbGFPxP4BOBBMiXKaQsl1S
         vJk3JMgGc7h3XjOTRuEiV/Q3iwJcFy/gq6HDBxvQd00Zhn9/2rByOtD3ooupuNMW6Dl+
         gK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695380013; x=1695984813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=smLn+CxRtpxX9ctNIYYoCY5z1MOW9XNgU+98WVi/0+U=;
        b=FLjjZywMGSZW+AxHL1WNqFrT2sibHer2UDIEQM16+bO9fLTLfTN6F1uSz3CW2NUgno
         hfRSa4VFuRSvDbsf4xZJg5B3YDWY42/9h5N3ckIhO/ts6dh3ydt42iRMlRU9GY4XlAK1
         hUFeWnP3ROVMGJJM+3XkWVYHdnfMhqNUw6rgrZN/lSd2a866En6Jt6LPhtyzun1UslHV
         Qm+D3qQ7dOw2I/3kgyGgDj5sF4gGbCTF5S33jpgocG2Ndf2giwKbfme83VrAo+VdrpqG
         Ifsq8B6f01VpKKj1rucXXt1UNIHJddCNrHMTv/CbBUwlBO0WZnnHfEF8DaI4fD0JB27C
         NKag==
X-Gm-Message-State: AOJu0YxGT6O7HTZtjODNxSn7Mgm54gXd2HH90GmKQA4ugdjysUYE3d0E
	lKnH3d9g2+yaantNl6cz6gCQD2ByiRTJ9/VXVTei/Q==
X-Google-Smtp-Source: AGHT+IHimQVwhgruO9dyU8+5sQvDyv/ixPddnfMzzlJu/e9gNLhAOUrnJ4tgBPDvB/lZ1x1AUiS4FSeAwCoZ1uZ8mic=
X-Received: by 2002:ac2:447c:0:b0:4ff:8810:ef6d with SMTP id
 y28-20020ac2447c000000b004ff8810ef6dmr25307lfl.1.1695380012598; Fri, 22 Sep
 2023 03:53:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920172943.4135513-1-edumazet@google.com> <20230920172943.4135513-4-edumazet@google.com>
 <89a3cbd7-fd82-d925-b916-e323033ffdbe@kernel.org> <CANn89i+-3saYRN9YUuujYnW8PvmkyUTHmRDX3bUXdbYoGfo=iA@mail.gmail.com>
 <e4aeef69-9656-d291-82a3-a86367210a81@kernel.org> <CANn89i+bXkgHWSgkqYToAGofE4qdJC142MmSR4eV2uD4408nVA@mail.gmail.com>
 <26be5679fdae405f9a932bfc3f28c203@AcuMS.aculab.com>
In-Reply-To: <26be5679fdae405f9a932bfc3f28c203@AcuMS.aculab.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 22 Sep 2023 12:53:19 +0200
Message-ID: <CANn89iK_sMY1=OOqJ_XPuumJFBGesw964EJY1JbU9oGRUH1c0g@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] tcp: derive delack_max from rto_min
To: David Laight <David.Laight@aculab.com>
Cc: David Ahern <dsahern@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Yuchung Cheng <ycheng@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"eric.dumazet@gmail.com" <eric.dumazet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 11:59=E2=80=AFAM David Laight <David.Laight@aculab.=
com> wrote:
>
> From: Eric Dumazet
> > Sent: 21 September 2023 13:58
> >
> > On Thu, Sep 21, 2023 at 2:37=E2=80=AFPM David Ahern <dsahern@kernel.org=
> wrote:
> > >
> >
> > > My comment is solely about mismatch on data types. I am surprised use=
 of
> > > max_t with mixed data types does not throw a compiler warning.
> >
> > This was intentional.
> >
> > This is max_t() purpose really.
>
> Apart from when it gets used to accidentally mask high bits :-)
> (Although hat is usually consigned to min_t()).

As explained, this is not an accident, but a conscious decision I made.

>
> Here
>         u32 delack_from_rto_min =3D max(rto_min, 2u) - 1;
> would probably be safer (as in have no casts that might have
> unwanted side effects).
>

I find my solution more readable.

max(-1, 1) is 1.

If this was not the case, many things would be broken in the kernel.

