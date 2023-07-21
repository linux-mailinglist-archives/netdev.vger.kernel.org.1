Return-Path: <netdev+bounces-19968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C9F75D06E
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 19:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F8E282376
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 17:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA6C200AD;
	Fri, 21 Jul 2023 17:14:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F7827F00
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 17:14:55 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75642D56
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 10:14:53 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b95efb9d89so33158691fa.0
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 10:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689959692; x=1690564492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9K5VHhZFEzQffhn522CBvGHgBcaIDvu9FEQtTEAlvh8=;
        b=v9suOoHBlIk67EKDKPqWLhrvssc3VmdYen5EzwX5m/TcUyTOkr+Ok1N1Qaa2m2hhVU
         dqHw3CQNBMJ741j1Q41aKPaQP8tzE+Ad/rNDqGHrMjkShpnw72khf+y+t5siZc4LowW8
         oTLzbsiQo87tyS4+gTUmElWm6wi61LFe0O8IY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689959692; x=1690564492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9K5VHhZFEzQffhn522CBvGHgBcaIDvu9FEQtTEAlvh8=;
        b=E7yMyvY0vYXQxPDdAHXoRgU3wYYw92a9vXtSqomhahVD9wRny0eN9LapSAiNRHj5sE
         t20XMsi9xrJ7Vm9ABH0s7U0p01ZvMAvBWMUWt1CLKO+tjX5szZr22J7L6iN5qJewOjpP
         gBx4aOft4vvqq3YB808gjKQ0Pyf3lMK9y0d7osuzuJMazjrLwsuLmKk6cTJVeUKBDAyN
         pBRCPMbcFi5r2aUqMylTkxV5ORr8w21Q5/b1fYiMShbAQFhchyqwZZX4hM0/g9wg2KcV
         hBtZiZp0erNKyHwFBunlkTqdgrA8QgWLuUW61+6QAiee0gYjjYRjD79NO7kwKoWMYBOa
         x01w==
X-Gm-Message-State: ABy/qLYvG54BKC9H0+k7Ab4Y05OkM2D/fqz6imY4ZZBKQJP6XnJVnV/P
	Oznm98t2wMW/8eIEUY3THi3ajB33Z7XXSN3XmQZYyw==
X-Google-Smtp-Source: APBJJlFcu8j3/DkgCopyZdnnpMfBq1CbxSvKbDwtsMsSsOQpSDKDCSmQi43l3aGLy2W0gXu1smDknxyIQxjYzck0H0o=
X-Received: by 2002:a05:651c:205:b0:2b5:9f54:e290 with SMTP id
 y5-20020a05651c020500b002b59f54e290mr1980021ljn.0.1689959691909; Fri, 21 Jul
 2023 10:14:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <E9CF24C7-3080-4720-B540-BAF03068336B@gmail.com>
 <1E0741E0-2BD9-4FA3-BA41-4E83315A10A8@joelfernandes.org> <1AF98387-B78C-4556-BE2E-E8F88ADACF8A@gmail.com>
 <cc9b292c-99b1-bec9-ba8e-9c202b5835cd@joelfernandes.org> <962bb2b940e64e7da7b71d11b307defc@AcuMS.aculab.com>
In-Reply-To: <962bb2b940e64e7da7b71d11b307defc@AcuMS.aculab.com>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Fri, 21 Jul 2023 13:14:40 -0400
Message-ID: <CAEXW_YS_raHUrvVAFPpnhL2PRH0hkcqT=1hD+gQOg_cMLkGrjQ@mail.gmail.com>
Subject: Re: Question about the barrier() in hlist_nulls_for_each_entry_rcu()
To: David Laight <David.Laight@aculab.com>
Cc: Alan Huang <mmpgouride@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 21, 2023 at 11:59=E2=80=AFAM David Laight <David.Laight@aculab.=
com> wrote:
>
> ....
> > Right, it shouldn't need to cache. To Eric's point it might be risky to=
 remove
> > the barrier() and someone needs to explain that issue first (or IMO the=
re needs
> > to be another tangible reason like performance etc). Anyway, FWIW I wro=
te a
> > simple program and I am not seeing the head->first cached with the patt=
ern you
> > shared above:
> >
> > #include <stdlib.h>
> >
> > #define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
> > #define barrier() __asm__ __volatile__("": : :"memory")
> >
> > typedef struct list_head {
> >      int first;
> >      struct list_head *next;
> > } list_head;
> >
> > int main() {
> >      list_head *head =3D (list_head *)malloc(sizeof(list_head));
> >      head->first =3D 1;
> >      head->next =3D 0;
> >
> >      READ_ONCE(head->first);
> >      barrier();
> >      READ_ONCE(head->first);
> >
> >      free(head);
> >      return 0;
> > }
>
> You probably need to try harder to generate the error.
> It probably has something to do code surrounding the
> sk_nulls_for_each_rcu() in the ca065d0c^ version of udp.c.
>
> That patch removes the retry loop - and probably breaks udp receive.
> The issue is that sockets can be moved between the 'hash2' chains
> (eg by connect()) without being freed.

I was just replying to Alan's question on the behavior of READ_ONCE()
since I myself recently got surprised by compiler optimizations
related to it. I haven't looked into the actual UDP code.

 - Joel

