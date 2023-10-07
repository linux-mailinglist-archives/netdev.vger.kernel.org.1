Return-Path: <netdev+bounces-38766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A51D7BC648
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 10:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D3E61C208FA
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 08:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C05616407;
	Sat,  7 Oct 2023 08:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDRuL9Zm"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1A714F84
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 08:59:19 +0000 (UTC)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D839ABB
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 01:59:18 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-77433d61155so187375285a.2
        for <netdev@vger.kernel.org>; Sat, 07 Oct 2023 01:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696669158; x=1697273958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUf9sOp70kUiYN55JuxsmpGKvLF3R4nAObb/JFoRyhM=;
        b=cDRuL9ZmEK5PaLCwN0Tq80t1dAsiEunGQfbaDykeYcoRmacVpAH/QGZA7Szskl9/t0
         hKGzBYJZ1BGvMwfIrE009Hf68sXP91ycElTyq+1/PEA1Re6b1GIqpB3CqgL6t33iAnTt
         qzJU6gJ9QtfwxQ0T32QOouFs/eF++nPWyHsJdqoPJJUBQgLHp1av/bs2I6abaNz2XgsA
         IxHtZaVEQwf82TYB0ubbN4EnxEKLX0t32dZAGHIELmyTHKhbrF5+CiLPBtPjOGbsczg6
         uasq5BmR1H/GHR93w85L3kxvgrcIqrCyC4wlXJ2df8yOcM+urXEdf3n3GFBS4G0PkndL
         brJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696669158; x=1697273958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUf9sOp70kUiYN55JuxsmpGKvLF3R4nAObb/JFoRyhM=;
        b=OOZ5JhQhbFScwdd+qwePFRwIVWLFHRPffLZViXh/KLnFcwvNl1UtoWxAZp1OFhqilt
         plKkJLWCWcff77VrZ46e5+cR/XNARZz0E3slG3SSociq5spR3KSLNrGWTsHr/CNOcqaR
         mpY0d7Bn33Vhneo9rxbAysqqTs0oHYIrl05DY/WIcShynbIrNspqtPWos10KMVe68mZx
         WmtHHaAiK0wgVbRsj55KMjZDmYOpCa/JGAyqVi20tAOQMv1+IIy3lJbKFH4mdiCuUASD
         4YdFjM1pb1Q5y6Epwkbnjd5seGJ/iJJB6QajCkh4kGUV5L7nY12ZtEWtO+XHMVv41rhQ
         DeBA==
X-Gm-Message-State: AOJu0YzlanczSd5pRIc2AxvJ5cPmAiaCwyZYjEyGEENd3lufHq5ozFb1
	HtuS+JZ5FMXvKAS6tftbi00fr5OT//ozC1t6Y0Q=
X-Google-Smtp-Source: AGHT+IHXkKuwBZn+n1QTUatBs8YPXRrkH3/J9YojYHvylW01VEOMcW8y8nbCunZGBd+hQArdTmd+qHt4tjIV6gCirC4=
X-Received: by 2002:a05:620a:b12:b0:775:8e72:1647 with SMTP id
 t18-20020a05620a0b1200b007758e721647mr10886503qkg.69.1696669157908; Sat, 07
 Oct 2023 01:59:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231005134917.2244971-1-willemdebruijn.kernel@gmail.com>
 <20231005134917.2244971-4-willemdebruijn.kernel@gmail.com> <20231006221408.GA11182@breakpoint.cc>
In-Reply-To: <20231006221408.GA11182@breakpoint.cc>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Sat, 7 Oct 2023 03:58:40 -0500
Message-ID: <CAF=yD-L9Ec+KLGsMzGaMo-e68HYGxn0nv8ABftiKrMmpZn5AvQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: expand skb_segment unit test with
 frag_list coverage
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	edumazet@google.com, pabeni@redhat.com, alexander.duyck@gmail.com, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 6, 2023 at 5:14=E2=80=AFPM Florian Westphal <fw@strlen.de> wrot=
e:
>
> Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> > +     /* TODO: this should also work with SG,
> > +      * rather than hit BUG_ON(i >=3D nfrags)
> > +      */
> > +     if (tcase->id =3D=3D GSO_TEST_FRAG_LIST_NON_UNIFORM)
> > +             features &=3D ~NETIF_F_SG;
>
> Out of curiosity, this can't be hit outside of this test
> because GRO is only source and won't generate skbs that
> would trigger this, correct?

My understanding from commit 43170c4e0ba7 is that this happens when a
device allocates non-uniform strides in its rxq. If packets cover two
or more such strides, but otherwise are of gso_size, then GRO will
create GSO packets with a repeating stride pattern. That's a
generalization of the initial frag_list support, which required equal
size of gso_size.

That said, I may have misunderstood the behavior (given that that
seems to cause a panic without _SG). That's one of the difficulties of
defining tests after the fact: reverse engineering what it is that
this function actually is intended to cover, and no more.

Thanks for reviewing the series, Florian.

