Return-Path: <netdev+bounces-34640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1A97A5073
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 19:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BE0C1C20FA3
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 17:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E3D23776;
	Mon, 18 Sep 2023 17:06:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5760038FB7
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 17:06:01 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4C293
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 10:05:59 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c4084803f1so6625ad.0
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 10:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695056759; x=1695661559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvV317n6yyGUg56R/7pdLcqCtdADu2ogATpf8Oy64Nk=;
        b=AkIwzN8obNWhC41YNqWF6LUYKion0Rk6vQNlHXfqrZxkzEUniTJVgajYfaYQt9oMnF
         YEhdY7zb6/S5draoWJFMUMF7r+8fwDSRhQuEwWybStVe2lT6GfFS2FQ1PogDlFkRKhp5
         Tpi9rzCZ1tyyIqAwSEXKKZEUaXPzQ3VC8++dBm+Ixu7hV1FPbf3pwCiwPTeInbD4YIxw
         JWfn5+qzPDkt8JS6Q7e9ZtsynduEZVaVxNvMOdKVMoyxC2C2nT68N/yxaoUPle8jDoqx
         i/0NLiGOqU4uLH/FdIox2ENbB69yUXuvHFpykVgRgBH1EFCJR8lcM77zNe2Vxw9KbAvf
         QvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695056759; x=1695661559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UvV317n6yyGUg56R/7pdLcqCtdADu2ogATpf8Oy64Nk=;
        b=aieXytiK9QwM7wz8JuiS18UZM0+y5fRnpD0y8Cc2CjcqwPdjdAXQHnhJX/z1WROaIV
         9Mp0zqb3/NOnIib65C96dtRoNWo+EIUHx1qOLV6XG6hp9iL/HP0a6bs1gIz/YJ8CzuJx
         6LwCcZHG/65n4HAZim9jJCiUt9ymcuHRRups9PPMzidJhgoqxJFv2Q8eDy8hdyXRbYlm
         wyrm8vl2e7Vg/Rcnx1oCqDOWbFn4dI0KoBpqRif8GdZF0mKw894t1okXQUk6H7fSzJrP
         mERnRB+nlKG8AsrLZJVicEkc+ncb5qYRNMyct0yDQh9/jBk8Clb+qZh/Qg4aO2QQbwJu
         lGpw==
X-Gm-Message-State: AOJu0Yz6m/S+wOWHa8rsYOAyq5cDBgqsdUpnK7pFkfocEGnIGKBgTLR1
	s424bh6/FsZon7dqslyoQuh53gcsg5dRlCWvLMhwJ9ASuOpfHHqugNBR3Q==
X-Google-Smtp-Source: AGHT+IG9qqBMe+choJ4leMLCkiIje8FUPx8O31NwXMKGaaM7qF1rlAYaYJnEXhRPBK/ZOM1AGuaJPBQA0/aP9CZaDVI=
X-Received: by 2002:ac8:5ac2:0:b0:417:944a:bcb2 with SMTP id
 d2-20020ac85ac2000000b00417944abcb2mr385498qtd.13.1695045901037; Mon, 18 Sep
 2023 07:05:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3793723.1694795079@warthog.procyon.org.uk> <CANn89iLwMhOnrmQTZJ+BqZJSbJZ+Q4W6xRknAAr+uSrk5TX-EQ@mail.gmail.com>
 <0000000000001c12b30605378ce8@google.com> <3905046.1695031382@warthog.procyon.org.uk>
 <65085768c17da_898cd294ae@willemb.c.googlers.com.notmuch>
In-Reply-To: <65085768c17da_898cd294ae@willemb.c.googlers.com.notmuch>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 18 Sep 2023 16:04:49 +0200
Message-ID: <CANn89iJ39Hguu6bRm2am6J_u0pSnm++ORa_UVpC0+8-mxORFfw@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING in __ip6_append_data
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: David Howells <dhowells@redhat.com>, 
	syzbot <syzbot+62cbf263225ae13ff153@syzkaller.appspotmail.com>, bpf@vger.kernel.org, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-16.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 3:58=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> David Howells wrote:
> > David Howells <dhowells@redhat.com> wrote:
> >
> > > I think the attached is probably an equivalent cleaned up reproducer.=
  Note
> > > that if the length given to sendfile() is less than 65536, it fails w=
ith
> > > EINVAL before it gets into __ip6_append_data().
> >
> > Actually, it only fails with EINVAL if the size is not a multiple of th=
e block
> > size of the source file because it's open O_DIRECT so, say, 65536-512 i=
s fine
> > (and works).
> >
> > But thinking more on this further, is this even a bug in my code, I won=
der?
> > The length passed is 65536 - but a UDP packet can't carry that, so it
> > shouldn't it have errored out before getting that far?  (which is what =
it
> > seems to do when I try it).
> >
> > I don't see how we get past the length check in ip6_append_data() with =
the
> > reproducer we're given unless the MTU is somewhat bigger than 65536 (is=
 that
> > even possible?)
>
> An ipv6 packet can carry 64KB of payload, so maxnonfragsize of 65535 + 40
> sounds correct. But payload length passed of 65536 is not (ignoring ipv6
> jumbograms). So that should probably trigger an EINVAL -- if that is inde=
ed
> what the repro does.

l2tp_ip6_sendmsg() claims ip6_append_data() can make better checks,
but what about simply replacing INT_MAX by 65535 ?

diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index 44cfb72bbd18a34e83e50bebca09729c55df524f..ab57a134923bfc8040dba0d8fb7=
02551ff265184
100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -502,10 +502,7 @@ static int l2tp_ip6_sendmsg(struct sock *sk,
struct msghdr *msg, size_t len)
        int ulen;
        int err;

-       /* Rough check on arithmetic overflow,
-        * better check is made in ip6_append_data().
-        */
-       if (len > INT_MAX - transhdrlen)
+       if (len > 65535 - transhdrlen)
                return -EMSGSIZE;
        ulen =3D len + transhdrlen;

