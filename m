Return-Path: <netdev+bounces-29045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 259F0781749
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 06:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6281C20DD1
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 04:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94F61391;
	Sat, 19 Aug 2023 04:02:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D05136B
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 04:02:59 +0000 (UTC)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9890421B
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 21:02:57 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-40c72caec5cso156801cf.0
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 21:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692417777; x=1693022577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uN6D9xvFZfgwyqzVnW396BvDxiSNO9nXCF0dIdCs9QI=;
        b=Eb0PTVtuuDC0r81QdiNisML1YjsRmbxJwy+KLX5Bm7n4GKnoZDs49+XuBu12t4eNHp
         1cqvpbrYOICt2B4cljxbdna8xwjk9zYfBYtCQNAzU1+ye2WrhJnWR3Kgs9t8CnUol3o5
         i7toSM7jFT3aDmbYRKwK0WYlBErRCrU4gm/Ke6ovgpxyhTo7LBEHSmz16DElyAZyclo0
         WZ7FD7MKM8go587m/muziKVMjGYKc66bqc6cxT33n/7Wivv4j9PfL9lZv7iR2hhxqDwI
         KU39A/M5sc49Y27JZ6ZhZaUHzW1S9ittF03S4K3wPCe6bUtviDqOw6mHrnRVVS5oiS8T
         OGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692417777; x=1693022577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uN6D9xvFZfgwyqzVnW396BvDxiSNO9nXCF0dIdCs9QI=;
        b=WzOQfsB4Ec2tdUSB5o/mL0P0xc0nDrWjatWtGcD0FcA4JGfFmbKZWoKlrFI6miIDl6
         onkf3+S7QJnzPJJkqVNy2cjm79oTcrMT0APApCn/wX9KY4Cf36PDdSMRaSCipgV5Y0Bt
         t/6Iu0Yy3F8zUU2SpnYfcXY2ycYaaDTHPxRfL/ThR2a7txjsUUrUE8GUsoMAyLYE5lnL
         74kosP2bGqEQN8B3KPAu4qUBUcZL9hTVRU/CISQCcKdkS2bmSfyI1H7Htp6HtbvsdhnN
         6A6balbX6IdwMTev73SK+JpcTONyTcPCwd7L+0iUDm9DJ5uIkbNB3KyiIqdm0xmLAdQy
         cGKw==
X-Gm-Message-State: AOJu0YzIJTgrj8LdbJa415HMaklZ8xwZFcx3GKWT3aw6dRIs9ZtpeEnA
	24fDlFcksgDn4rb4m0RlEclU/CjxyIFE3YKSRb4WvA==
X-Google-Smtp-Source: AGHT+IFhRtHlY9Dnks1Is/Jx6qh8I2gK8isp8yx30RCwxOSbOGOzI2ZOpAif8PlUFE+VLxyojTzt94GEh62M9RNlW2M=
X-Received: by 2002:a05:622a:144:b0:410:4845:8d37 with SMTP id
 v4-20020a05622a014400b0041048458d37mr324414qtw.29.1692417776650; Fri, 18 Aug
 2023 21:02:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230818021132.2796092-1-edumazet@google.com> <20230818192850.123e8331@kernel.org>
 <CANn89i+2_exCdN=qMGJ=cYmpx9P58am98nW5x4fju1PpsMFW_Q@mail.gmail.com> <20230818200436.7625c590@kernel.org>
In-Reply-To: <20230818200436.7625c590@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 19 Aug 2023 06:02:45 +0200
Message-ID: <CANn89i+sVXF-uam7Q+FmQDS_gQw0KROF_P+8UFVzwOcudobvcg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: annotate data-races around sk->sk_lingertime
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 19, 2023 at 5:04=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 19 Aug 2023 05:03:47 +0200 Eric Dumazet wrote:
> > > net/core/sock.c:1238:14: warning: result of comparison of constant 36=
893488147419103 with expression of type 'unsigned int' is always false [-Wt=
autological-constant-out-of-range-compare]
> > >                         if (t_sec >=3D MAX_SCHEDULE_TIMEOUT / HZ)
> > >                             ~~~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~~
> > >
> >
> > Ah... I thought I was using clang.... Let me check again.
>
> Could be a W=3D1 warning.

Indeed, I will use an "unsigned long t_sec" to remove the warning,
(compiler also removes the dead branch in 64bit builds)

Thanks.

