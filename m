Return-Path: <netdev+bounces-34655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A897A5186
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F323E1C20BA7
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 18:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B08266DA;
	Mon, 18 Sep 2023 18:02:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EB5266D2
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 18:02:51 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FF5101
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 11:02:49 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9ae22bf33a0so73226966b.0
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 11:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695060168; x=1695664968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XpNcScx+wZOJr7yQbQOiesQM3TXb3I91M6c1mJphkUs=;
        b=jSzkT9rgfWA4uKisK5YouN0ZUw4sDg//Mnzhrp4va0Mgb6eDPQK54ky/RNmobUMwX/
         kKfElIDqCBofuiNQu7e0SA6NvO8800zDx0MlmSRUB461m9myDBX547MIsKBimkcysrEU
         kFhXAUsEIymsywNSQbptDG6mwos100tNaUBB4ythZzgXu9hnZ1kYjji9CIdVD1N0TE+F
         PbVBkEJO4P8GCUA6w8SjUKs5DubznF6teLojlQ/nNGwv0MYWCOf7uc79T39wtoPimuAQ
         UbnypJ3Qb8VG2cXaiYuwHngCmA3e5NRS/SDXRiwsJJZdDgJ/RjrAhHMWlJ3TW2/boRh9
         FA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695060168; x=1695664968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XpNcScx+wZOJr7yQbQOiesQM3TXb3I91M6c1mJphkUs=;
        b=sb2scUq0OTMwOAWubtb4UdkV8m2CXwUr1fu/bWFoNWXZYGbQg5M+tOfM56uOTR83ha
         Bid6kiSpsm3TeSnP8sFL2yBUVUINm+ifKoNBU3LgtV6tdSNmMT7qji1PWhEUTPUqSFa/
         h6F9WF2rjJ2gu04lv4AVW1GJ42oaWcGCSjH0X869WwWnmy7Cc+TpHrrmydGKlnnxAomm
         JY3s/Gdjwiiws/7FSJIb6xq+Qc+9hvvY+eIRuD4qQpO8Ksm4Wma+mQh9D0QWCFOtf7x5
         ASP/YamLfkd7ArQPXCVitXqpORNz+6ADhne2S1WOSugKxiQRUPRKDme9Qc2QXbI9RgH4
         k3XA==
X-Gm-Message-State: AOJu0Yz3Bp4twqE6YRb8/oPtX3YigYnrFHwVTwoM0NlzDCB3/B7USfN+
	35W9FqbyudKdFmtO/R+5OC/j94eAdwVMaTWTygVnIpFbbFN9oAA7ZbuKVw==
X-Google-Smtp-Source: AGHT+IFKv2MOcnz5Y7IOneYLs8HMnr35slA3pwWCwuLwKdtXHeltfWbzyTTSD3P2Nduxmd1FUZSggclUFRlSt2AbZ8s=
X-Received: by 2002:a17:907:a06b:b0:9a5:9f3c:961e with SMTP id
 ia11-20020a170907a06b00b009a59f3c961emr544789ejc.18.1695060167819; Mon, 18
 Sep 2023 11:02:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918025021.4078252-1-jrife@google.com> <20230918025021.4078252-2-jrife@google.com>
 <CAF=yD-KoKAv_uPR+R+RkVbc3Lm3PREao-n7F1QckPWeW9v6JqA@mail.gmail.com>
 <CADKFtnQnOnaq_3_o5OoWpuMvzTgzL2qKcY5oc=AbdZJvONSyKQ@mail.gmail.com> <CAF=yD-+DmargLvi=i-YJ6JCJov8xYEbyQf8+KhQ00UTYry_9UQ@mail.gmail.com>
In-Reply-To: <CAF=yD-+DmargLvi=i-YJ6JCJov8xYEbyQf8+KhQ00UTYry_9UQ@mail.gmail.com>
From: Jordan Rife <jrife@google.com>
Date: Mon, 18 Sep 2023 11:02:36 -0700
Message-ID: <CADKFtnSoB+_RjEJZsvkM9TpEm6xmmATnBL0jj7n-JbFAxbBc-A@mail.gmail.com>
Subject: Re: [PATCH net v2 2/3] net: prevent rewrite of msg_name in sock_sendmsg()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, dborkman@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sounds like a plan.

On Mon, Sep 18, 2023 at 10:55=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Mon, Sep 18, 2023 at 1:52=E2=80=AFPM Jordan Rife <jrife@google.com> wr=
ote:
> >
> > > You used this short-hand to avoid having to update all callers to soc=
k_sendmsg to __kernel_sendmsg?
> >
> > Sorry about that, I misunderstood the intent. I'm fine with
> > introducing a new function, doing the address copy there, and
> > replacing all calls to sock_sendmsg with this wrapper. One thought on
> > the naming though,
> >
> > To me the "__" prefix seems out of place for a function meant as a
> > public interface. Some possible alternatives:
> >
> > 1) Rename the current kernel_sendmsg() function to
> > kernel_sendmsg_kvec() and name  our new function kernel_sendmsg(). To
> > me this makes some sense, considering the new function is the more
> > generic of the two, and the existing kernel_sendmsg() specifically
> > accepts "struct kvec".
> > 2) Same as #1, but drop the old kernel_sendmsg() function instead of
> > renaming it. Adapt all calls to the old kernel_sendmsg() to fit the
> > new kernel_sendmsg() (this amounts to adding a
> > iov_iter_kvec(&msg->msg_iter, ITER_SOURCE, vec, num, size); call in
> > each spot before kernel_sendmsg() is called.
>
> Thanks. Fair points.
>
> Of the two proposals, I think the first is preferable, as it avoids
> some non-trivial open coding in multiple callers.

