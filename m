Return-Path: <netdev+bounces-280326-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IA4WDApu6GkSKQIAu9opvQ
	(envelope-from <netdev+bounces-280326-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 08:43:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8310C442890
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 08:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A209308B5BF
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 06:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06ED0315D58;
	Wed, 22 Apr 2026 06:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ok4uYw1Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4A730F7F2
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 06:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776839680; cv=pass; b=t9hbDDgf2l2sMJat36Bmz9N/6uOw7zEva99LJVwQQMYMvKPVlmuao4ULtF64OL9Qn80ZlM6eg1XTgvd4CBTm9p/Uo56yKz+tVMDIvvQXx2zdMbeBptmqb4eab6NlSq3M14dj727AIoPXq8hJocIWIpvjhmCAuIkYwcWL9av9YAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776839680; c=relaxed/simple;
	bh=L5xw+IE6r4iubLQXw2KRZiyATRr5PhUz8ChPPezbBD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJ6PgQ6dzKKW2fPa/C0SXlTGmpCoTtghCOEJNbz70qZnWApZDSTBhIQOS5shHvNa3aSNUnaUkIW0X7XvQIPRMIzob87lvSupaqtSjDtElYG3YZYWk/bfopGz/r0oK2sdTyIQJWATeRL4phPN6kGlF/a1B8Il5kENugVI2jamCBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ok4uYw1Q; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso29330495e9.2
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 23:34:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776839678; cv=none;
        d=google.com; s=arc-20240605;
        b=e+lH01T8UFlu1kFoz8z78BSITUon7XAilMoiGPJ0He24alHlFRgGUoPCmSYu7wMEC4
         bc0dbKJHHEQK8vkpUo4nECprVsNkKxKu/QWvCoPGAS7HxNpGoKyrNUsdRfBM9MouHHh3
         W+WCIOEneZjxTmNkK8iPFTL+bVvNmv2yfzL9jsoSq2Hkb4z5J53GJvJBlKxW90AEPFqT
         pp2a3CI/vPEhveX7sZ2KwYTSdnk+Ww7IcVL5vicyOE0CxUgVtSwlm4VYQxbPjJR0ordG
         yVJ+TInT8HW3QCtH1UQNIFLQRWQ93mwe/AnmoQFf+2zXY3h7ZpHexlXBIl9kzki1TsOT
         4IvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=shDKR9F1B5bz8bwMraZHyZozJCPGpiT8/hqG0ENFR6g=;
        fh=9JXoo3JKEwUKA8Cu9IdPdtXaaa+zmhqZUyyaq+78OpA=;
        b=EmdQl/sLg0HhL6nfkEi86aORzH0yS1lGtk/iSqgaqThD4HAx5eJMudhKJUlMqF0LhJ
         O5B8/K8Y8Tp/onfZ1nZ2mG40WIocmonKJGc1PNkOwCrCWX9dSMNOBtNcvd10IFTllqy3
         LUJJk5Tm5TOspfwOuejd6qcvz/q0yHNcLkqyQczbGtKWUWpBmR95GHzpKJ//kP24JB3D
         8R8v2fikWkhdJSiCeo68ysmNIkKTbr9SckLwWZH/Piw1g66wdRsoxitQqQECPM9VdTtw
         N/uQfwuH14FrOPUEHNrPQ22avpNEgTPGZvVpkITfDwuZvJjdTugXIP+qawh8eFo22oXQ
         1jHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776839678; x=1777444478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shDKR9F1B5bz8bwMraZHyZozJCPGpiT8/hqG0ENFR6g=;
        b=ok4uYw1QPkKjNVFvbFhzbEJtl6vyk8TfekSxM1yIScj9TkM8sG7qlyq3mBMSfaUNKK
         I1u9ZTXLZzTV6xBxWOm5n3pt+BWXq4irskUj9zIgFqkTBRtkYHkr86LWeFEjvvO8HXZu
         Fs0qi270IouOBvsZmQ+yjxJ/MmgVVwuwX5Ff+y4giK7mrnRIS5r1rA18cGbFmIHmd85L
         RC8mQJTc4rV47s42PuuNj4y6VJUis3/hwCzuYStM/cLsL40lRhz3a0tqZTRhqYujt6qQ
         hFcADLdv9jmDADAh2f4BIyEAGChJdhBcLr4c/x80okRhg3FtTARiFos6mDwMQ/gEbDmB
         Z8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776839678; x=1777444478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=shDKR9F1B5bz8bwMraZHyZozJCPGpiT8/hqG0ENFR6g=;
        b=V90Jagu8ixn0DTpUD3wph6LXRIbMELieAkle8OROn0QnDNJbMGOMUJ/wY4pMqALlEY
         pUCZa3P/T3S1/iv0z5hcOEN7IG+aTMi84tU7bR/3WrVTZ6rA0JvRp3Ypb0g+imuMTJ8C
         fvnc6fiVA1G2eUUPicHeUHEmhngHXpUZQ1nMJHEF87QiYdlOaC+fvNV7L4q/wumFDSaK
         effM761T32EvYhKLhlCfHwNDgDVMAVL8iYJZArkF1i6fqZJH1WyFE/kJlwIwUyP3NCzx
         yIBZD9YuMOHcvpCa8J/MMoWE74A+rn+nSNpF7MGA3Uc1fJFcbZbVeXKVJlrvrPzNlRwl
         YAkw==
X-Gm-Message-State: AOJu0YxXn3YWixKvMZO7wRo1OOc2U1R3K+lxWeQmY5PYfd79s6jTJmfA
	+ZiDChwrpaUHv8O8Q4xWVig11H/Fy/JItlYNxIqo1G+AzsiQLuxJ6Wh0qfzsRXqH/AIS60YYNHJ
	VwHQgCZ2Id1aCBATRYYWFfuWiAvLUol8=
X-Gm-Gg: AeBDievo6caVtYUXbp+/h5puMh5voXXRhQuI8KgNLDMaUltn8RAhZQJeH9yo0zKNkK0
	Q0cNIW119WJVXXcXHdSMH9ArFgENpv+Ofg8otlIZByvSwKIXwDa5qsRcRdyV66hN3ni37SF74ZZ
	b2d+vsNQmpL8fVdwdapGBAFs+zjggeOq+so8OiAFx5e6GxX+f2rD2YHDkQtRyqp8H9L0alyAlDe
	nBfgR1qs4CuV41nlzw/DTJctvcmOYHj2QjjN2rs3+fG5M8OlbOzN2mGJ5wd+tvNo4QXYi73+Xre
	d/nBJ81+Sz/iy19cAuux7LCpfw==
X-Received: by 2002:a05:600c:5295:b0:486:fbd1:9dc0 with SMTP id
 5b1f17b1804b1-488fb780463mr287378505e9.22.1776839677598; Tue, 21 Apr 2026
 23:34:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422024554.130346-1-jt26wzz@gmail.com> <20260422024554.130346-3-jt26wzz@gmail.com>
 <CAJ-ks9=FKMoczH+Z=GQ7C40T42=zdknYzzHCa8UVFOtq2H69cw@mail.gmail.com>
In-Reply-To: <CAJ-ks9=FKMoczH+Z=GQ7C40T42=zdknYzzHCa8UVFOtq2H69cw@mail.gmail.com>
From: Zhenzhong Wu <jt26wzz@gmail.com>
Date: Wed, 22 Apr 2026 14:34:25 +0800
X-Gm-Features: AQROBzC_BaY3iZ1CRhgFDwy25PnKfhx-Ku3vnltXXcbsiy_AoyisatnBkns9kC0
Message-ID: <CALgi0XnM49xUZm2-YAjPFoc_8j_F=y4gmVemGHacyH8aXeXaHw@mail.gmail.com>
Subject: Re: [PATCH net v4 2/2] selftests/bpf: check epoll readiness during
 reuseport migration
To: Tamir Duberstein <tamird@kernel.org>
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com, 
	kuniyu@google.com, davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-280326-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jt26wzz@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.co.jp:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8310C442890
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks Tamir, I will fold this into v5 - there's already a precedent
in socket_helpers.h, so I will just include it from there.

On Wed, Apr 22, 2026 at 11:04=E2=80=AFAM Tamir Duberstein <tamird@kernel.or=
g> wrote:
>
> On Tue, Apr 21, 2026 at 7:46=E2=80=AFPM Zhenzhong Wu <jt26wzz@gmail.com> =
wrote:
> >
> > Inside migrate_dance(), add epoll checks around shutdown() to
> > verify that the target listener is not ready before shutdown()
> > and becomes ready immediately after shutdown() triggers migration.
> >
> > Cover TCP_ESTABLISHED and TCP_SYN_RECV. Exclude TCP_NEW_SYN_RECV
> > as it depends on later handshake completion.
> >
> > Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> > Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> > Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
> > ---
> >  .../bpf/prog_tests/migrate_reuseport.c        | 49 ++++++++++++++++---
> >  1 file changed, 42 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c=
 b/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
> > index 653b0a20f..c62907732 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
> > @@ -7,24 +7,29 @@
> >   *   3. call listen() for 1 server socket. (migration target)
> >   *   4. update a map to migrate all child sockets
> >   *        to the last server socket (migrate_map[cookie] =3D 4)
> > - *   5. call shutdown() for first 4 server sockets
> > + *   5. for TCP_ESTABLISHED and TCP_SYN_RECV cases, verify via epoll
> > + *        that the last server socket is not ready before migration.
> > + *   6. call shutdown() for first 4 server sockets
> >   *        and migrate the requests in the accept queue
> >   *        to the last server socket.
> > - *   6. call listen() for the second server socket.
> > - *   7. call shutdown() for the last server
> > + *   7. for TCP_ESTABLISHED and TCP_SYN_RECV cases, verify via epoll
> > + *        that the last server socket is ready after migration.
> > + *   8. call listen() for the second server socket.
> > + *   9. call shutdown() for the last server
> >   *        and migrate the requests in the accept queue
> >   *        to the second server socket.
> > - *   8. call listen() for the last server.
> > - *   9. call shutdown() for the second server
> > + *  10. call listen() for the last server.
> > + *  11. call shutdown() for the second server
> >   *        and migrate the requests in the accept queue
> >   *        to the last server socket.
> > - *  10. call accept() for the last server socket.
> > + *  12. call accept() for the last server socket.
> >   *
> >   * Author: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
> >   */
> >
> >  #include <bpf/bpf.h>
> >  #include <bpf/libbpf.h>
> > +#include <sys/epoll.h>
> >
> >  #include "test_progs.h"
> >  #include "test_migrate_reuseport.skel.h"
> > @@ -350,21 +355,51 @@ static int update_maps(struct migrate_reuseport_t=
est_case *test_case,
> >
> >  static int migrate_dance(struct migrate_reuseport_test_case *test_case=
)
> >  {
> > +       struct epoll_event ev =3D {
> > +               .events =3D EPOLLIN,
> > +       };
> > +       int epoll =3D -1, nfds;
> >         int i, err;
> >
> > +       if (test_case->state !=3D BPF_TCP_NEW_SYN_RECV) {
> > +               epoll =3D epoll_create1(0);
> > +               if (!ASSERT_NEQ(epoll, -1, "epoll_create1"))
> > +                       return -1;
> > +
> > +               ev.data.fd =3D test_case->servers[MIGRATED_TO];
> > +               if (!ASSERT_OK(epoll_ctl(epoll, EPOLL_CTL_ADD,
> > +                                        test_case->servers[MIGRATED_TO=
], &ev),
> > +                              "epoll_ctl"))
> > +                       goto close_epoll;
> > +
> > +               nfds =3D epoll_wait(epoll, &ev, 1, 0);
> > +               if (!ASSERT_EQ(nfds, 0, "epoll_wait 1"))
> > +                       goto close_epoll;
> > +       }
> > +
> >         /* Migrate TCP_ESTABLISHED and TCP_SYN_RECV requests
> >          * to the last listener based on eBPF.
> >          */
> >         for (i =3D 0; i < MIGRATED_TO; i++) {
> >                 err =3D shutdown(test_case->servers[i], SHUT_RDWR);
> >                 if (!ASSERT_OK(err, "shutdown"))
> > -                       return -1;
> > +                       goto close_epoll;
> >         }
> >
> >         /* No dance for TCP_NEW_SYN_RECV to migrate based on eBPF */
> >         if (test_case->state =3D=3D BPF_TCP_NEW_SYN_RECV)
> >                 return 0;
> >
> > +       nfds =3D epoll_wait(epoll, &ev, 1, 0);
> > +       if (!ASSERT_EQ(nfds, 1, "epoll_wait 2")) {
> > +close_epoll:
> > +               if (epoll >=3D 0)
> > +                       close(epoll);
> > +               return -1;
> > +       }
>
> I think you can avoid this goto using `__attribute__((cleanup(...))`:
>
>   static void close_fd(int *fd)
>   {
>         if (*fd >=3D 0)
>                 close(*fd);
>   }
>
>   #define __close_fd __attribute__((cleanup(close_fd)))
>
> then in the test:
>
> __close_fd int epoll =3D -1;
>
> there's an example of this in
> tools/testing/selftests/bpf/prog_tests/socket_helpers.h.

