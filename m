Return-Path: <netdev+bounces-15077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFA2745820
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 11:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FBC41C20902
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 09:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1506520F5;
	Mon,  3 Jul 2023 09:13:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C771371
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 09:13:04 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387D912E
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 02:13:00 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b69ea3b29fso65762711fa.3
        for <netdev@vger.kernel.org>; Mon, 03 Jul 2023 02:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688375579; x=1690967579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZrwT1Q3TAFyAuNKoN7EOZ5Cv2Yr0/LJBy2LmWg9cbY=;
        b=EENhMT6+gEKiVaKV6FC/2yp1vEbMfTtLXmOFgN/Os0u/ruBReeC5uoDwsHyPDJhDtC
         oS5GN0MeMDBVypbluHs9nePvDk9Cptz6TyxqSEWXy96cri6YPPRpXWYZ7PXRcjeMVCXU
         UOUNQ6X/5tOzi04ElvfOzn1VWQFq6nS1S0ENw0hxu2ZA0WtvwdkLF/5oUFoLMex3bkG6
         ccjfAOVBOHORjce0Vls88I0j+uL+lwLKDkdK8gnySPjIW+txSOi6bIZm/jlWVv5NNz5w
         lJnCFr6V822R9Kwsg41Arp3XnEoPiBE7qh+Lh4kBKScSQ1YrqKTsBiHQE/6rIxwBHxpw
         8C8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688375579; x=1690967579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZrwT1Q3TAFyAuNKoN7EOZ5Cv2Yr0/LJBy2LmWg9cbY=;
        b=JmQbdh9Glp33h+PvXYyCUBgoSN8RqEjl3/Z4SiGEi8W9C0CeLWmLgbiB5QoKwm9GIz
         y5dY1x0MQkoSaJ9UmNOpFYEWf4HQ6GM3m/Z2+lgcu0CeibVlIu7uLP3xtn6uL2ozZZdv
         OyDLwFa2fry3lKudNt8yyMHNpOsMOk7rDr/BJTH4FiTXAmF519YYDPsQHAfpco7RApZ3
         pU+xv3V9pfVPsIZdkvldgebrPRG4NwpZEtvNsqONlqBe1iT/i2wI4Ci7BODKzE8MiEvB
         O8RbcBZXaFEotGHG1yxZsb2W9PMsmoDQN8iKsbB4+eFD99B7IbZABl5YruFqMFaayKWG
         A5/g==
X-Gm-Message-State: ABy/qLZIyLGH/y+fFT9AkkN1ESb5ztOfUTGSAqK9rm9RbjjTZNs2ToWX
	Md8LTSoSdFog4rxvb2E7rAQ9ao1jm1xkmeRrLgo=
X-Google-Smtp-Source: APBJJlGiEIhuJWt9PkvquGJt1MeSXSJ7AVLRpXeD7L74gidR7Vr6TrY9v5r7VDPsblXIIHB68Qf9dorTg7RA+F2qXsM=
X-Received: by 2002:a2e:9b07:0:b0:2b6:c405:f249 with SMTP id
 u7-20020a2e9b07000000b002b6c405f249mr5546164lji.1.1688375578667; Mon, 03 Jul
 2023 02:12:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230628121150.47778-1-liangchen.linux@gmail.com> <20230630160709.45ea4faa@kernel.org>
In-Reply-To: <20230630160709.45ea4faa@kernel.org>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Mon, 3 Jul 2023 17:12:46 +0800
Message-ID: <CAKhg4t+hoOiVWMbBiD7HCu_Z5pSdCsZrev2FMEKhbWvzgHCarw@mail.gmail.com>
Subject: Re: [PATCH net-next] skbuff: Optimize SKB coalescing for page pool case
To: Jakub Kicinski <kuba@kernel.org>
Cc: ilias.apalodimas@linaro.org, hawk@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linyunsheng@huawei.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 1, 2023 at 7:07=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 28 Jun 2023 20:11:50 +0800 Liang Chen wrote:
> > +static inline void page_pool_page_ref(struct page *page)
> > +{
> > +     struct page *head_page =3D compound_head(page);
> > +
> > +     if (page_pool_is_pp_page(head_page) &&
> > +                     page_pool_is_pp_page_frag(head_page))
> > +             atomic_long_inc(&head_page->pp_frag_count);
> > +     else
> > +             get_page(head_page);
>
> AFAICT this is not correct, you cannot take an extra *pp* reference
> on a pp page, unless it is a frag. If the @to skb is a pp skb (and it
> must be, if we get here) we will have two skbs with pp_recycle =3D 1.
> Which means if they both get freed at the same time they will both
> try to return / release the page.
>
> I haven't looked at Yunsheng's v5 yet, but that's why I was asking
> to rename the pp_frag_count to pp_ref_count. pp_frag_count is a true
> refcount (rather than skb->pp_recycle acting as a poor man's single
> shot refcount), so in case of frag'd pages / after Yunsheng's work
> we will be able to take new refs.
>
> Long story short please wait until Yunsheng's changes are finalized.

Sure, thanks for the information. I will wait until Yunsheng's changes
are finalized before proposing v2.

As for the "pp" reference, it has the test
page_pool_is_pp_page_frag(head_page) there. So for a non-frag pp page,
it will be a get_page call.

Thanks,
Liang

