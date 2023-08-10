Return-Path: <netdev+bounces-26467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8710F777E61
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B89DA1C216EA
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 16:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CF51EA6F;
	Thu, 10 Aug 2023 16:36:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97061E1DA
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 16:36:46 +0000 (UTC)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A10270A
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 09:36:45 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-40c72caec5cso3751cf.0
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 09:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691685405; x=1692290205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WXJ4Ac8ZrfiC8vWnhH2SUJ5neAV2ZW3QOyj2KRn8zU=;
        b=JbNoHcIiT/z2acAdqbiUO8g/cOGh0L3F5oRFmg9TB14p1Sc0tOk3M8J0Mtj60LaprB
         6h3Qdzdki20pO9d4k3U6x4iquh/JBGMjKFNdj472LnJGTEfP5LahDTDyEmDvY1t9KkAR
         GO/6bV4bcPBov9w7AIhvZW5/JVp/ztkoamOq02VaXLCnJOsg1rtGro0q9OLZc0rxW4V9
         sgs6ayd/vWzmqRblXouJtkL3oe1wZy1ZHYBlmxbbz4Y7j9+5TnyT89FlUdHbh8HhVgB2
         jdDffce1noPhB10kt0ASQ5MJryI55ogRkDMu2wvXO3Ur4wm6MdjrG2focS8Z68AV3sGS
         IhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691685405; x=1692290205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3WXJ4Ac8ZrfiC8vWnhH2SUJ5neAV2ZW3QOyj2KRn8zU=;
        b=EY7wxdk8uHG7lJVeEyOft6R+Sr9TuBuXdrMTfKGXsS/9uUbl2jwXXigLrjkwDTAwdP
         /4v/pDnJyKRJVsaP02qj/IQ70Ant8qqR89iY3ck8SMBvEqDPdpT64wSlJD268zAW5Zrb
         E+fMhvGBYLIZFCmxuTR9g6liKk1YBmojaG2koizVLNDmyOR6xwFS0yHEx84Q3UpA3iuj
         8PUGk9rWpXxWwXfpdACv1bGdMEkW4di4B+eA3mxP2nnBGynCz1GxVfzQekuW4UZAwImm
         fi0R+rn2oJOgMde5TMbOH3RbZaTxHuNxHLcZwlqCDidgGJbTakC6Fqz9dUepVt4LhrqO
         9bzA==
X-Gm-Message-State: AOJu0YxO4jrJSFB39+tZJM8fk4cll5uETc7QZVhNoJz+nVKGYz0bjO5u
	6aNgBuTW1x9FuJyD15GjtIuQYpiPPnfL0rS3Xrygxw==
X-Google-Smtp-Source: AGHT+IHKN3bMpYx4QJUGgMKmi08gOaaxLgPZkrJ1v+JUXHXkQ/GmXnKEvceDhiabhIac/81old3tI5TjQrkU2jbx1Xc=
X-Received: by 2002:ac8:5707:0:b0:403:ac9c:ac2f with SMTP id
 7-20020ac85707000000b00403ac9cac2fmr443520qtw.17.1691685404570; Thu, 10 Aug
 2023 09:36:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230802172654.1467777-1-dima@arista.com> <20230802172654.1467777-17-dima@arista.com>
 <CANn89iKjT3i-0rZLu8WE_P94aN65rj8uBAw3MyMPhsnMKWSs_A@mail.gmail.com> <d84888b2-8b5a-103c-3e8a-1be5e5833288@arista.com>
In-Reply-To: <d84888b2-8b5a-103c-3e8a-1be5e5833288@arista.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Aug 2023 18:36:33 +0200
Message-ID: <CANn89i+eUrn6tzQBNQjywyS-rsqm_uamJRdfP0-o_Pz2Dv1t8A@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 16/23] net/tcp: Ignore specific ICMPs for
 TCP-AO connections
To: Dmitry Safonov <dima@arista.com>
Cc: David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
	Andy Lutomirski <luto@amacapital.net>, Ard Biesheuvel <ardb@kernel.org>, 
	Bob Gilligan <gilligan@arista.com>, Dan Carpenter <error27@gmail.com>, 
	David Laight <David.Laight@aculab.com>, Dmitry Safonov <0x7f454c46@gmail.com>, 
	Donald Cassidy <dcassidy@redhat.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Francesco Ruggeri <fruggeri05@gmail.com>, 
	"Gaillardetz, Dominik" <dgaillar@ciena.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Ivan Delalande <colona@arista.com>, 
	Leonard Crestez <cdleonard@gmail.com>, Salam Noureddine <noureddine@arista.com>, 
	"Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 6:27=E2=80=AFPM Dmitry Safonov <dima@arista.com> wr=
ote:
>
> On 8/8/23 14:43, Eric Dumazet wrote:
> > On Wed, Aug 2, 2023 at 7:27=E2=80=AFPM Dmitry Safonov <dima@arista.com>=
 wrote:
> [..]
> >>
> >> +bool tcp_ao_ignore_icmp(struct sock *sk, int type, int code)
> >
> > const struct sock *sk ?
>
> Well, I can't really: atomic64_inc(&ao->counters.dropped_icmp)

I think we could, because this would still work.

 struct tcp_ao_info *ao; // This is rw object

ao =3D rcu_dereference(tcp_sk(sk)->ao_info);

This helper looks to accept unlocked sockets, so marking them const
would avoid mistakes in the future.

