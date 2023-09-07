Return-Path: <netdev+bounces-32463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E188D797B2A
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 20:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC6F1C20B47
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 18:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578B613FE4;
	Thu,  7 Sep 2023 18:06:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4600B13AC3
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 18:06:05 +0000 (UTC)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F00290
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 11:05:42 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-40a47e8e38dso32781cf.1
        for <netdev@vger.kernel.org>; Thu, 07 Sep 2023 11:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694109940; x=1694714740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqgTQnEvjKKeK9o8sQieRWzy4tMA9g2ckspm6WILNMs=;
        b=R4hSfVTRCo5+lSHotYq8SB7427IHNjQmjCjRgA0jlqVP22gKGGvIsIr8N5gdLeuq9i
         RmxudfuCg9YvF9S0pXGv1OeR85yhru+vlof9Tgr9ReI8hO58+vNfe2wyTT2cYeyuErvD
         4SBDnJXcXSe9GAzAazV+TfvJZcs0YZn5d9rDJrqWuzIdrQomPIz7v334VVbwZkMIr25Q
         CGqz0AjmvICk7UHa64+YLyGDT3rsi2OC9IPZWkKukD7L74iqfH5G1P12iAWIhsJq4Hw5
         7LNL/F9YbnhKyRx3EAmRfS0a3u5lbrPnXl9u5+0qHHpQRXleuEWk2qeobV8WM2I5El1Q
         JeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694109940; x=1694714740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KqgTQnEvjKKeK9o8sQieRWzy4tMA9g2ckspm6WILNMs=;
        b=C+TnUPIw3Cj+lAQr50cT9m78nr1KP+P3FyfaZZ5vbcVAqDPPx+SpWFL7IC8eDy2G07
         C5OT7Ji5HdPMSpZ6RwH0mDY8jSmU2UC5k5UsIaJ9qouNU4jNkYD38hTwQDoMXzO5b1an
         x8PrYJT45MEEg90NMR7DjZZ1E2glwUoCifyQC6vNNZMJ0XWOJjE8Qj260Hc+NjyzOEmV
         AVcj30hwdGw+BKUVQsAizRp7QQeuDPlngGKa3z9gzn/4anwxZyUB2Oh28dQPW4o008qE
         2pH4UqCDgK+kCfHTn2A9Lm6ahHGRqMIZ20mwA038lNgXHJgVUyKWgyBA8sjHVfU7hnuK
         ItUg==
X-Gm-Message-State: AOJu0YxpaZDWzXxED0ahLG14c/3K5tncBYZxGotemFTOioAr/f1/MQhh
	m6GteYmQMjus5haT5YZVayCw+pi/wYxAaJyjaYUuJA==
X-Google-Smtp-Source: AGHT+IGdg3nleqmHy/68S2e/EU1jzW8vAtpCyqRCxocoWnLaponvLlZYZKkCspGwL9cnemji56GucgX3WQQMCKskbZ0=
X-Received: by 2002:a05:622a:1a28:b0:410:8cbf:61de with SMTP id
 f40-20020a05622a1a2800b004108cbf61demr19058qtb.13.1694109940115; Thu, 07 Sep
 2023 11:05:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230906201046.463236-1-edumazet@google.com> <20230906201046.463236-5-edumazet@google.com>
 <20230907100932.58daf8e5@kernel.org> <CANn89iJY8UypOGqSOJo531ny4isPSiTg2xW-rO_xNmnYVVovQw@mail.gmail.com>
 <20230907110015.75fdcc5c@kernel.org>
In-Reply-To: <20230907110015.75fdcc5c@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Sep 2023 20:05:29 +0200
Message-ID: <CANn89i+TDVA9iXedyOgASce1Z2ZfdMS+7Nfw6ebOKkYerWo43g@mail.gmail.com>
Subject: Re: [RFC net-next 4/4] tcp: defer regular ACK while processing socket backlog
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 7, 2023 at 8:00=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu, 7 Sep 2023 19:16:01 +0200 Eric Dumazet wrote:
> > > Is it okay if I asked why quickack?
> > > Is it related to delay-based CC?
> >
> > Note the patch is also helping the 'regular' mode, without "quickack 1"=
 .
> >
> > This is CC related in any way, but some TCP tx zerocopy workload, sendi=
ng
> > one chunk at a time, waiting for the TCP tx zerocopy completion in
> > order to proceed for the next chunk,
> > because the 'next chunk'  is re-using the memory.
> >
> > The receiver application is not sending back a message (otherwise the
> > 'delayed ack' would be piggybacked in the reply),
> > and it also does not know what size of the message was expected (so no
> > SO_RCVLOWAT or anything could be attempted)
> >
> > For this kind of workload, it is crucial the last ACK is not delayed, a=
t all.
>
> Interesting. Some folks at Meta were recently looking into parsing RPCs
> in the kernel to avoid unnecessary wakeups. Poor man's KCM using BPF
> sockmaps. Passing message size hints from the sender would solve so
> many problems..

Yes, RPC headers make things easier for sure.

(we internally have something similar named autolowat, where we parse
headers to set sk->sk_rcvlowat dynamically)

