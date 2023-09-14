Return-Path: <netdev+bounces-33822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 033F87A0637
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 15:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A44B281990
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 13:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C3F219FE;
	Thu, 14 Sep 2023 13:37:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F57219F2
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 13:37:11 +0000 (UTC)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F114497
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 06:37:11 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-450f5be2532so505159137.3
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 06:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694698630; x=1695303430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9O4TF+WISC+7TP/+LygIGuYTUo94pS+tuIPDE4Lh6U=;
        b=Jmv+XA3EkuoPttTC5lfhV925aE/bt5pv1Yzwp9LJpW27h1+sGnbp+s6uhb1hYIifa3
         5F9YOIMuRr67iiVJoP8KbnXFZCptalDzIyl+1dd21LKx3KPuxaA1ZzMOP4qilJpUf2Gt
         mBvPZRxExjQp42dERc4TVbxNOn4T6z3wRGtF+epbm5q8OoqlXt08S4WYkXimIIhNTVKs
         KnLA3DbnC3oNIUkk7P45/fZ5PipoFXz5JWZl1p4SBYJbS9dt8oGFUrdjcGjiSaOLRRz1
         JLkn9VUIDL0lLzl1g+yVxptMZqheZmeQ124VsEM9MuwKWUi/DFcKS06cWFoSdR+0Y4fo
         vCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694698630; x=1695303430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9O4TF+WISC+7TP/+LygIGuYTUo94pS+tuIPDE4Lh6U=;
        b=khYFBAQ796x6dYzgJZPZy1l9JzSdElHAParTU9rLU8oFcgdB7PS7u1WD4PU0Q9/1t1
         Rd/olMzu6bKBalm+jc3/JKI5KkG0ZrUAWKco7sDFnERBUSdXYf54r78TnjHkKV0Ti68D
         8IxGQFkECx4MfrecLYtJd3dtC4DE09YUDAQQUdoEBpOSTDgKdOjkTsgKThb9y7owWRZO
         aQrkey8x18LXA1VZGXo9nc9y1XXibyHat1y3DyoGijAkeqC2SPNqpxDhrZisPcJUnG2b
         ldIL/7aJXA4bpllteRoT12WLDY+zri3DNBlCkYmY0JaE7E33a14G2p2iB9BhyI1/m8OT
         Pc6Q==
X-Gm-Message-State: AOJu0YzIPx+eU2KptixTkWNCFCwvbseuVNzc4/gWhB2zefVkE72AprCf
	DAjbSre/yXeoNFkqnUzY33TNkzVHdpoU5GoJBzN/JbhEb8e22Zp9LEs=
X-Google-Smtp-Source: AGHT+IFGLhOdSrMZNvbguHKky+b8utHnVfXyZ5/jGI03fDwiQ0/+L7onC+dTE8xOPCoQu1e6bn/enE7Uc13n458lQMY=
X-Received: by 2002:a05:6102:2c1c:b0:450:fcad:ff23 with SMTP id
 ie28-20020a0561022c1c00b00450fcadff23mr3475956vsb.32.1694698630273; Thu, 14
 Sep 2023 06:37:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912023309.3013660-1-aananthv@google.com> <20230912023309.3013660-3-aananthv@google.com>
 <e3ed5c1e03d14dabb073bbb6d56f0fb825e770a4.camel@redhat.com>
In-Reply-To: <e3ed5c1e03d14dabb073bbb6d56f0fb825e770a4.camel@redhat.com>
From: Yuchung Cheng <ycheng@google.com>
Date: Thu, 14 Sep 2023 09:36:30 -0400
Message-ID: <CAK6E8=fbiVVEtbGavo2uVi7fVCB9dVDVypTWZBtzymc51EW0bg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] tcp: new TCP_INFO stats for RTO events
To: Paolo Abeni <pabeni@redhat.com>
Cc: Aananth V <aananthv@google.com>, David Miller <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 5:02=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Hi,
>
> On Tue, 2023-09-12 at 02:33 +0000, Aananth V wrote:
> > @@ -2825,6 +2829,14 @@ void tcp_enter_recovery(struct sock *sk, bool ec=
e_ack)
> >       tcp_set_ca_state(sk, TCP_CA_Recovery);
> >  }
> >
> > +static inline void tcp_update_rto_time(struct tcp_sock *tp)
> > +{
> > +     if (tp->rto_stamp) {
> > +             tp->total_rto_time +=3D tcp_time_stamp(tp) - tp->rto_stam=
p;
> > +             tp->rto_stamp =3D 0;
> > +     }
> > +}
>
> The CI is complaining about 'inline' function in .c file. I guess that
> is not by accident and the goal is to maximize fast-path performances?
>
> Perhaps worthy moving the function to an header file to make static
> checkers happy?

or simply remove the inline keyword since it's only used in that file.
>
>
> Thanks!
>
> Paolo
>

