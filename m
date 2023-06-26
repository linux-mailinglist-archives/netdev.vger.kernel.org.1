Return-Path: <netdev+bounces-14071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C2E73EC61
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 23:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF473280C26
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 21:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC31D13AE5;
	Mon, 26 Jun 2023 21:01:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF2714A82
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 21:01:52 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEC0D9;
	Mon, 26 Jun 2023 14:01:51 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b69f958ef3so26601011fa.1;
        Mon, 26 Jun 2023 14:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687813309; x=1690405309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEzlsaUmZXPnWU2Adei6SoQasb2UVBNAtJg+OJameMI=;
        b=cTYOGQnpwPMCPf3IJICbOnspn9is3TyiDc38a9Hmvy5OCHC/oSXJXVz5Yppiv+bg6e
         R8uX0qvBmRpj/Tln1Td5thtDGArJZnrUFIHqEA+FWXbBjYIyOom9P0hIIx69MB1gsAQ5
         GgdNSK90BiYfX0JJf3NyxI9TInUzrzVT46b0f5fml2w5kTWyqBDL9uFCNIRAPxxOYBO6
         ARseH4ugXCbu4LKdhtPEOtE/+WyOQvPItfO1l2vnIRKGMN97boUnKRzmsnAmmkNtBrAl
         L/FvgouoyHFyhsWAvBXl5RYbqd31q84ZKNu1btwBYafj2bu5Eg0oNWZ9ideMdGxcq4O+
         IxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687813309; x=1690405309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jEzlsaUmZXPnWU2Adei6SoQasb2UVBNAtJg+OJameMI=;
        b=Uq89FFBtPjtPMff2nX2zyQ9M3EkQKTDOrjEj2lE5/r3bT/09zNHSGvPi92MVGLlYPk
         tI72EZINwbMXZvF5yESOnUSlNmuGfN8/Cl0tiAIAmChBzgsq7xI+0XgkWgZcZ3MN6Nqc
         jyY5hHpaTcb6+X91L3vqNVJwx+L05tzjLgc88tNouJaY97imw2jKJlwCf3PmFhBad2L1
         feh927MIipEJsAtp74GrORMj3PFNNlo3mrHFO6NDYpIKS+qPVxq6KPezuWMTXpC+XFU2
         c9tmhrxApJJQ9GklziwkDk0/ooFj79POM2wcttFpRAB1MhJ8m4lnmpoDTtDgUzmMWtlh
         r7Vw==
X-Gm-Message-State: AC+VfDytS/O+ey7QaqtbB5T3G7av7O4YvLlXUxBSehjWgq6LRX7K3bHZ
	OQedixoVPy3JwEcQEGms+BY3+6xIHpB987gqSUk=
X-Google-Smtp-Source: ACHHUZ7xKMNm6A1vIDbxhQP9GjPBJ+rANHnqBKz1mGtMsQWZx2HxYp/X48ttGDtA/xHvUTMceGFdUfUwG3KCuchNAeU=
X-Received: by 2002:a2e:83d0:0:b0:2b4:792d:a4b5 with SMTP id
 s16-20020a2e83d0000000b002b4792da4b5mr13512330ljh.33.1687813309269; Mon, 26
 Jun 2023 14:01:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3101881.1687801973@warthog.procyon.org.uk> <CAOi1vP_g70kV_YFjHNoS1hHPpCiMxW1hTfm92Ud35ehYrmv=1Q@mail.gmail.com>
 <3109248.1687812255@warthog.procyon.org.uk>
In-Reply-To: <3109248.1687812255@warthog.procyon.org.uk>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 26 Jun 2023 23:01:37 +0200
Message-ID: <CAOi1vP8nbP93SyjhN4uJDaKEFKmsBcOKH6iGjpt3Qbj8n7CapQ@mail.gmail.com>
Subject: Re: [PATCH net-next] libceph: Partially revert changes to support MSG_SPLICE_PAGES
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Xiubo Li <xiubli@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 26, 2023 at 10:44=E2=80=AFPM David Howells <dhowells@redhat.com=
> wrote:
>
> Ilya Dryomov <idryomov@gmail.com> wrote:
>
> >   if (sendpage_ok(bv.bv_page))
> >           msg.msg_flags |=3D MSG_SPLICE_PAGES;
> >   else
> >           msg.msg_flags &=3D ~MSG_SPLICE_PAGES;
>
> Hmmm...  I'm not sure there's any guarantee that msg, including msg_flags=
,
> won't get altered by ->sendmsg().

If this is indeed an issue, do_sendmsg() should be fixed too.  I would
like to avoid having do_try_sendpage() do one thing and do_sendmsg() do
something subtly different.

But then, even with the current patch, only msg_flags is reinitialized
on the next loop iteration, not the entire message.  Should the entire
message be reinitialized?

Thanks,

                Ilya

