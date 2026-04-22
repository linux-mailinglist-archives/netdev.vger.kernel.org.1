Return-Path: <netdev+bounces-280332-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHtLLzJ26GmVKgIAu9opvQ
	(envelope-from <netdev+bounces-280332-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 09:18:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E42442DFA
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 09:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 030973044B95
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 07:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC8336C592;
	Wed, 22 Apr 2026 07:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STFUNdij"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C203D36C5A1
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 07:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776842060; cv=pass; b=jpzFTG2h9VIVaNr2Bd58wkmK9LEkgtfRQX1Z8tmMsd7HaewvbFQWdHon2UF4Mb1Sk+rNK/+Yv3r1uEyTWqd2jC08CB/Kqu3AhI53xC8VFR/7j6ij2Qyfqw6nvko5I3HovA3LWciBOtbLhByrei7CKBq5UFeGPcZ4aET2USxxFSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776842060; c=relaxed/simple;
	bh=XowSd59N4h93jym+TJycNOip1Un2FoiepuvLyVCQEyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uXw62igBsBiQ6us5tqULaxXIvhmbb/PvkxhPipBON1sjpyjtTT6iXmB9Li/MLMm/B3f2IyF2xUXaxmQsDhWLl2nVe8t4PG7PxTUlhEXGiNsZd/YVCGYyPpVqQj1COIFX6VoI1VeNEy7w9Ayxxopix6Z/8xLmOif9jzmhHzrHYx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STFUNdij; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso19151415e9.3
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 00:14:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776842056; cv=none;
        d=google.com; s=arc-20240605;
        b=IlwzOnOwJunRl7sWVYZsJ8MC2rQa94HtUdJqCrSwFp0QgjxAB2QPlWhTmQxBgusal6
         b5q7h1o9MbU5Sl9zLL+Cs8CuzBXUbINVRuEsHHPXeeA4I1QRwEOVkhs0aooC8o3yMIS6
         +PdurY6z8lXGgK7nQEcyt3supZheEdoXkUGs8LWhq5XMAcOiRUQwucqr2Slq3Fh0tUqd
         6+OFsHmh81IqKVNx2F5DI+gWFJkjnbttlFYdvzn2JLk0SXFabYQDIp5vBt2dfZhjDzJL
         lhJu3g/LrEJrxzrP9a+iMmFytC6mAssX3P2M7PHp43+LpoX+d30S/orMLeXY+Rkgsmlw
         Fy9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bqnR6HI2Fa/Xow2KsNl3iKJdbqbKp2MgpRDTzxPIh/8=;
        fh=EqEa8UYjqmFxuIFqUXImSqWlw+gJeHuhznG33E4WHsg=;
        b=g3panAXTeUAboHZmvQqWmU/WjrtiWFmVchVn87M78kyYkpXXXMTg0H8pgSlESgLvcO
         yE8eYt0qNFBZPXzVWsZJuTTWtvqCpHjpgXYx94T65v05itlSClY9mqzbiQouF1+Ib8Vu
         ftZd17THa1CVWfzKnSRoXfKi+CcXnxwtFeq64+SCQq7g2+pUvy2kiAZTxAtYze2Mnen/
         MDLFYyTynczcVm0cl9AP4x8X5PgZpcjuiqpyKrZhOoYXiM8eRNwRQ4GxafoIBdYqvgVJ
         qSY2FKkwECFFhcH/zpiiJ8CKnSdyT2npG/+1PIAsx4AfwzpzpuaNlXj9c35gwH5aNUat
         Yu/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776842056; x=1777446856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqnR6HI2Fa/Xow2KsNl3iKJdbqbKp2MgpRDTzxPIh/8=;
        b=STFUNdijZrCHWnDhAbFY77gtD4bOPf0qPu5JXOD6cwNYNm2Pow4futGiRlCh3zeVlQ
         igeb3L8sSkj+H4WZOpSZx/9d3p0xl4aJ3yq+YBtI/4dzFFEyJAF6/r5O+1hMVmLSJI6s
         Y7jfQ5NBkOfWew1mQj9onTdyR7mpjj9npxRLb1xVtqC0cCvwkIwYSlFGireBfKliyGr8
         YL0ajtsTkpCWpPFHfvn3zWBG1AgKSrXqJDBPsqBgG+RDtSeF1IRW/aybEucmqSrVQWaV
         NbCTdc0tQiDIjgq06G7ezeVeN4Os2a7RX7LiCNJ/l67MYMam6+ZzSJjvpdo0pRqNGsZV
         ZyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776842056; x=1777446856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bqnR6HI2Fa/Xow2KsNl3iKJdbqbKp2MgpRDTzxPIh/8=;
        b=YEXEtVn7bQufJDVnwnqKUS3Jk4hyjiyg2PSPSjcxWn3jNKnAN+rFG3ATFYgkgU7Qtf
         7kaT91QfQ0ogl0D4jj+jIRnr7w0DtXfVB0KxTvKC+NdUFXos2ZS5wgUq+ySPJ14Ov12M
         YvHouP/KzCZ5BtBPs3xZX1wo+SVtwgtD0ejfmgkgjGFP4RqQxn4fQvp0tF20VIBTC30+
         svCEYYOpiuDn3bRWWR0mp6cdus163w3Utr8/MYKwCrpMKbijXcOk98MD5CqN13AOURg/
         ZU0MiznQP2hW6K2gnpXgULXyz8FQ72/dBRtF4DOBhoWnH5ykQeSvsbJ5M3j1c9YGKGiR
         A0ww==
X-Forwarded-Encrypted: i=1; AFNElJ9KQdW0ueIletw67SOiSU3uAt+8irZ9DotEnLrQdZQ1cl4SIGDP4lUa7FVyfmB6OxAJVNTXLkY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjy9zVBufiYFVBESj6tZsEuJGSkx8SL6WL6xx8Esb98LDVrf/l
	yO6qtQtnMzVurRsiAL/1bmxc++Ctj9PLFp+O1fG9671eZe9jGDeMuh1U+djVkdeSM8kyexpuUa5
	9Lb5tOClzJ0XG6J8IElbPipKJ241x3H0=
X-Gm-Gg: AeBDievJ6TdiBdD8EkTKgPO5B+tkGHB8HRNZV2rFOHR3W3JH3EZ5B3CurWIzw2xQOqF
	r5wVjw6SaEcb3ZUF8nxfcPgCwpnJ0aDmBR4anP1Dy11/ciPmSgA8+fIEKSlvX0A+s/lAbQWakz9
	3/4BwEGMvXq9TEV/TpRW22RhWufatojHwrVc9s5gKoByov6yZEt1m7ZPu/IiSXmhJv1DTbnt+7o
	JF9SCsC1ex4s9LRC//kyftoPXsDG9ZOKhNWpggtaGodbclmJ6A8vrpJ9u8sRJ0bju0n8u6PoHz3
	d/mDtGScWU+ZYKSCOVm0t00LvA==
X-Received: by 2002:a05:600c:8b55:b0:48a:57e1:d8cc with SMTP id
 5b1f17b1804b1-48a57e1d8d4mr65879105e9.9.1776842055910; Wed, 22 Apr 2026
 00:14:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422024554.130346-1-jt26wzz@gmail.com> <20260422024554.130346-3-jt26wzz@gmail.com>
 <CAJ-ks9=FKMoczH+Z=GQ7C40T42=zdknYzzHCa8UVFOtq2H69cw@mail.gmail.com>
 <CALgi0XnM49xUZm2-YAjPFoc_8j_F=y4gmVemGHacyH8aXeXaHw@mail.gmail.com> <CAAVpQUAKCDVPHhFjWch2-zpKp2rHEPzvwE4R1UrDTMd_6Y2HYA@mail.gmail.com>
In-Reply-To: <CAAVpQUAKCDVPHhFjWch2-zpKp2rHEPzvwE4R1UrDTMd_6Y2HYA@mail.gmail.com>
From: Zhenzhong Wu <jt26wzz@gmail.com>
Date: Wed, 22 Apr 2026 15:14:03 +0800
X-Gm-Features: AQROBzBPry-HAb88G-Fx1bXIMUprfrxusGK4mpwNqFKy-bWEEZuX23LA3vZxfvI
Message-ID: <CALgi0Xm7+_uREQ3Sv19O8vfFyuwXNxVdUS9KQEvtkQHc=g2B4g@mail.gmail.com>
Subject: Re: [PATCH net v4 2/2] selftests/bpf: check epoll readiness during
 reuseport migration
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Tamir Duberstein <tamird@kernel.org>, netdev@vger.kernel.org, edumazet@google.com, 
	ncardwell@google.com, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, 
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
	TAGGED_FROM(0.00)[bounces-280332-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 21E42442DFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks both. Keeping the goto for consistency with the rest of the test.

On Wed, Apr 22, 2026 at 2:40=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Tue, Apr 21, 2026 at 11:34=E2=80=AFPM Zhenzhong Wu <jt26wzz@gmail.com>=
 wrote:
> >
> > Thanks Tamir, I will fold this into v5 - there's already a precedent
> > in socket_helpers.h, so I will just include it from there.
>
> The test does not use cleanup in other places,
> no need to mix them up.
>
>
> >
> > On Wed, Apr 22, 2026 at 11:04=E2=80=AFAM Tamir Duberstein <tamird@kerne=
l.org> wrote:
> > >
> > > On Tue, Apr 21, 2026 at 7:46=E2=80=AFPM Zhenzhong Wu <jt26wzz@gmail.c=
om> wrote:
> > > >
> > > > Inside migrate_dance(), add epoll checks around shutdown() to
> > > > verify that the target listener is not ready before shutdown()
> > > > and becomes ready immediately after shutdown() triggers migration.
> > > >
> > > > Cover TCP_ESTABLISHED and TCP_SYN_RECV. Exclude TCP_NEW_SYN_RECV
> > > > as it depends on later handshake completion.
> > > >
> > > > Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > > Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > > Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
> > > > ---
> > > >  .../bpf/prog_tests/migrate_reuseport.c        | 49 +++++++++++++++=
+---
> > > >  1 file changed, 42 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/migrate_reusepo=
rt.c b/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
> > > > index 653b0a20f..c62907732 100644
> > > > --- a/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
> > > > @@ -7,24 +7,29 @@
> > > >   *   3. call listen() for 1 server socket. (migration target)
> > > >   *   4. update a map to migrate all child sockets
> > > >   *        to the last server socket (migrate_map[cookie] =3D 4)
> > > > - *   5. call shutdown() for first 4 server sockets
> > > > + *   5. for TCP_ESTABLISHED and TCP_SYN_RECV cases, verify via epo=
ll
> > > > + *        that the last server socket is not ready before migratio=
n.
> > > > + *   6. call shutdown() for first 4 server sockets
> > > >   *        and migrate the requests in the accept queue
> > > >   *        to the last server socket.
> > > > - *   6. call listen() for the second server socket.
> > > > - *   7. call shutdown() for the last server
> > > > + *   7. for TCP_ESTABLISHED and TCP_SYN_RECV cases, verify via epo=
ll
> > > > + *        that the last server socket is ready after migration.
> > > > + *   8. call listen() for the second server socket.
> > > > + *   9. call shutdown() for the last server
> > > >   *        and migrate the requests in the accept queue
> > > >   *        to the second server socket.
> > > > - *   8. call listen() for the last server.
> > > > - *   9. call shutdown() for the second server
> > > > + *  10. call listen() for the last server.
> > > > + *  11. call shutdown() for the second server
> > > >   *        and migrate the requests in the accept queue
> > > >   *        to the last server socket.
> > > > - *  10. call accept() for the last server socket.
> > > > + *  12. call accept() for the last server socket.
> > > >   *
> > > >   * Author: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
> > > >   */
> > > >
> > > >  #include <bpf/bpf.h>
> > > >  #include <bpf/libbpf.h>
> > > > +#include <sys/epoll.h>
> > > >
> > > >  #include "test_progs.h"
> > > >  #include "test_migrate_reuseport.skel.h"
> > > > @@ -350,21 +355,51 @@ static int update_maps(struct migrate_reusepo=
rt_test_case *test_case,
> > > >
> > > >  static int migrate_dance(struct migrate_reuseport_test_case *test_=
case)
> > > >  {
> > > > +       struct epoll_event ev =3D {
> > > > +               .events =3D EPOLLIN,
> > > > +       };
> > > > +       int epoll =3D -1, nfds;
> > > >         int i, err;
> > > >
> > > > +       if (test_case->state !=3D BPF_TCP_NEW_SYN_RECV) {
> > > > +               epoll =3D epoll_create1(0);
> > > > +               if (!ASSERT_NEQ(epoll, -1, "epoll_create1"))
> > > > +                       return -1;
> > > > +
> > > > +               ev.data.fd =3D test_case->servers[MIGRATED_TO];
> > > > +               if (!ASSERT_OK(epoll_ctl(epoll, EPOLL_CTL_ADD,
> > > > +                                        test_case->servers[MIGRATE=
D_TO], &ev),
> > > > +                              "epoll_ctl"))
> > > > +                       goto close_epoll;
> > > > +
> > > > +               nfds =3D epoll_wait(epoll, &ev, 1, 0);
> > > > +               if (!ASSERT_EQ(nfds, 0, "epoll_wait 1"))
> > > > +                       goto close_epoll;
> > > > +       }
> > > > +
> > > >         /* Migrate TCP_ESTABLISHED and TCP_SYN_RECV requests
> > > >          * to the last listener based on eBPF.
> > > >          */
> > > >         for (i =3D 0; i < MIGRATED_TO; i++) {
> > > >                 err =3D shutdown(test_case->servers[i], SHUT_RDWR);
> > > >                 if (!ASSERT_OK(err, "shutdown"))
> > > > -                       return -1;
> > > > +                       goto close_epoll;
> > > >         }
> > > >
> > > >         /* No dance for TCP_NEW_SYN_RECV to migrate based on eBPF *=
/
> > > >         if (test_case->state =3D=3D BPF_TCP_NEW_SYN_RECV)
> > > >                 return 0;
> > > >
> > > > +       nfds =3D epoll_wait(epoll, &ev, 1, 0);
> > > > +       if (!ASSERT_EQ(nfds, 1, "epoll_wait 2")) {
> > > > +close_epoll:
> > > > +               if (epoll >=3D 0)
> > > > +                       close(epoll);
> > > > +               return -1;
> > > > +       }
> > >
> > > I think you can avoid this goto using `__attribute__((cleanup(...))`:
> > >
> > >   static void close_fd(int *fd)
> > >   {
> > >         if (*fd >=3D 0)
> > >                 close(*fd);
> > >   }
> > >
> > >   #define __close_fd __attribute__((cleanup(close_fd)))
> > >
> > > then in the test:
> > >
> > > __close_fd int epoll =3D -1;
> > >
> > > there's an example of this in
> > > tools/testing/selftests/bpf/prog_tests/socket_helpers.h.

