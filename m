Return-Path: <netdev+bounces-280328-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +M55Cvdu6GmNKQIAu9opvQ
	(envelope-from <netdev+bounces-280328-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 08:47:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F77044293C
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 08:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 151103058087
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 06:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B448D3246F0;
	Wed, 22 Apr 2026 06:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vPZHSoSN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD6818AE3
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 06:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776840035; cv=pass; b=RHufMv/rrnvKiTELtKhpbEy2S3sXMi92WxEYRXDpJNANKFdRRdADEtJl65+yuUxNKjDs+TjoyN5MGJf7Jqckpnfhsax2e1AaaFL2UoG9J0SfYAHCmlpsylrmXO6Z3uDNpv3G7N201Qk8TnUq/MloL+wzeJ9hZisW5EWPBPyHx5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776840035; c=relaxed/simple;
	bh=Dub9yvFw6aVqsBwlj+o9QIz+Ydgw4jm4EZ6nTT2g1tw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Or4FldcnnP+dP9kJFoH4o8MPY3PIw2PNKCnasEYmrB2JmTk0aiMfsB/gQZR3KXKjo93sfNuVsPfRek3KUeX2rskgRge8kiVQGoMiVGGEDrOEyEjCTZNb0+hNSedcD76Vh7LirL8j5EQsXCmQlKNmndRpUIqyK4nCMSM/SejbNqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vPZHSoSN; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12c1a170a50so6312965c88.0
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 23:40:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776840033; cv=none;
        d=google.com; s=arc-20240605;
        b=FvDWSsjt/XkGjQql+GmWdQK5qIERi8jcKgBs52zE571CcdqnoDwWAwBPHFsmLoecus
         45zI1e11vrTMIu4ATA47UQOCIT1p1I4GgJsTB6QtFhgBnXL7xTesFAfjJ7Mm1OLGMrKm
         cADizd/VwATy31TZDd5TcetgMwnDIMX5KNgmfZYRP6rs/jp5l7tvEYSNyhIi89spm1IO
         hmL4D5qB444HM01BbDYlIbSCrLR+C+49KBQxnn9VeHt57otMqI7QmSqVIdRoXzY+cl17
         DFPwQTjXI2aPMEMYyIElJhs3C8lKiEf8wXwk9KAnLMOG5RDYqpsybz8WjEFk8hEiaEKO
         diSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HkR7JxVUSSnzxmBjl0/viks3xyisurlnd8db9S4wWvM=;
        fh=QM2w0BUeoLHZ5J32WWmECsmYnH66Aws1AoN/amXdo+I=;
        b=UnzvEAfYRhx4d7WpVrUIkAazVRRj42B2lbOpt7lZ28ovrzo2dNba9ATcKUMGnfu3Qd
         tR/lCPXVtV/6LSUzAr1SZWWvxcg8zaPquie45AsQ+Dq84pbpgXI+fHYaRBTxkZTFvM89
         lGgwtJk2bcLsPrDwxImL8OhAshUGDfjI5DKhWFyVLIh9bhCGSGop/vwrQcf98aH04ycX
         dz/QJdc08DWrS5ykAHdv7r31uxgVG80FIDNZ5ij3CYhuqL2M9hV05dnSFm7qjTjFkjHb
         FaWgAPPUfNUYeO67+bTM/yT+yBS/NMQ1c9VqeESrDPPm4srG2zCCLmR+jveUc0+RtGzd
         GN4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776840033; x=1777444833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkR7JxVUSSnzxmBjl0/viks3xyisurlnd8db9S4wWvM=;
        b=vPZHSoSNGTyUCfSVRaRDnr33kc9nxRTWt9jYcZkcyXEKbwrg8J8oQGZ03zhAy+xy1P
         jFR6i6QKe1mwKnuwCwJWs4nSVlBl9wKlBfykg6a2niR1stl4rY7NWRXQ0lxhROdtXdiE
         Y9HV0NQgYTLLCN9B55qFG8go1YWmrjWvPfVuJUw9xCL9W+sFU6zkq8WuR9Km7qlaa6z0
         qxm2PxeiC0QW60tjvfJsDbLC+T+hjKH+vKLDFRoUTogP7hZ3z6lplSOwx2NNTkPe2QDv
         hpI4H9uF52ZZgNmfEw9cbWiHHbPzKa6teSVbjqp9KA8m9XvAISvckZ9dZJdfm9SCtH0q
         25/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776840033; x=1777444833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HkR7JxVUSSnzxmBjl0/viks3xyisurlnd8db9S4wWvM=;
        b=ICM+zs/BT39wQl/CIPbZ6fUNWmp5HgfLGmviR1gRVHfjybNVvHD7uNq2UoUXTZGexZ
         FhHaOBoBnpOdyl8cXWMnlMVItpf44u47yP9xoFfjwhfWxxP00S2ARBQ3sbgbO+1rZRp4
         i6DkrRmKUKwgRIZTTKqaVeUsPFHdyQpyBgkqpE8HqJSAzRvtQZ/kR4mWZio1Y48BK9UD
         aQ5tUO4yycylqfTpFIlyiwsVLkeGtP9HO8zH6OCYAhhq2KHWOAXs/NOKhbhdzirCpGZg
         w2Sc/msSxJ/lpxOPP7bai0mkNoZ0YVTARBYniZsnwHExIgZnFjqv5bU2E8CjpLo4Hvrh
         k7ng==
X-Forwarded-Encrypted: i=1; AFNElJ+QjbZc828fsOlHZDdikHJaEvGreZTjgQfvi1yYf21twmpPemSuPR+ynfYrO5cZjBj49Nj6IDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFn+PWP8GJX9YwLQJ7WaUc/T7d91XUqAOtjmImjnI55aEtyGV4
	VAo9UJ37GsSs7KZtVHE2VBuuxaISfOvWBLPD+gyH0hsIOTKd8ja+c3JiBk4/Y4tDVTGUih0TFPX
	zdRBaH6n/oIIa1k9dhE9BPLb4RmfzR3bUPdraD28P
X-Gm-Gg: AeBDiesOAdeJ1EMgHYo6J2tRRvUHUFBFGnLAJuFi7YDmhECb5WlIyyK4MNwh9VeHOV1
	EGiOq2YE2+aXnT/LpNtCECeIygxcdz/pAkqh4TYppCnLtBJy9rqzwy0ROH3PyWHdOM5yWbEbNG2
	Mo9CwL5dNXCLHgImiySlptj+rNz5LZcomPpq4Cy4YOvEZy/4vtc/FnuE2b0cijzCg1GCzgVZn5u
	dpt8c3yBijJZLQRplForIg0dv5RnPbYC7UciDLZ01czW8GbH3Yi4nTgtiC0X2aLQqKI0iaAJDBf
	lsYY4yj+5gF/NYeHWRUp2LkdjoCP/mR4ugj9MohCF2A/p4Dznnr3ehKXW1K6iykijn0hbryYEvU
	K+zZrP4HGKffIrKKWpQnC6G1oyzFpPUNiNtkzUwPSj/tSF67HBF6UNc+gey5dkQlu8cRSso50sw
	==
X-Received: by 2002:a05:7022:ef09:b0:11a:fec5:d005 with SMTP id
 a92af1059eb24-12c73f6c4f6mr11902651c88.10.1776840032640; Tue, 21 Apr 2026
 23:40:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422024554.130346-1-jt26wzz@gmail.com> <20260422024554.130346-3-jt26wzz@gmail.com>
 <CAJ-ks9=FKMoczH+Z=GQ7C40T42=zdknYzzHCa8UVFOtq2H69cw@mail.gmail.com> <CALgi0XnM49xUZm2-YAjPFoc_8j_F=y4gmVemGHacyH8aXeXaHw@mail.gmail.com>
In-Reply-To: <CALgi0XnM49xUZm2-YAjPFoc_8j_F=y4gmVemGHacyH8aXeXaHw@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 21 Apr 2026 23:40:21 -0700
X-Gm-Features: AQROBzA3HpMyxVD5ELxOaE3sdPdgu6IawCkniN8Ei1PdRzCSt78S6iEoyACymtQ
Message-ID: <CAAVpQUAKCDVPHhFjWch2-zpKp2rHEPzvwE4R1UrDTMd_6Y2HYA@mail.gmail.com>
Subject: Re: [PATCH net v4 2/2] selftests/bpf: check epoll readiness during
 reuseport migration
To: Zhenzhong Wu <jt26wzz@gmail.com>
Cc: Tamir Duberstein <tamird@kernel.org>, netdev@vger.kernel.org, edumazet@google.com, 
	ncardwell@google.com, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280328-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.co.jp:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3F77044293C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 11:34=E2=80=AFPM Zhenzhong Wu <jt26wzz@gmail.com> w=
rote:
>
> Thanks Tamir, I will fold this into v5 - there's already a precedent
> in socket_helpers.h, so I will just include it from there.

The test does not use cleanup in other places,
no need to mix them up.


>
> On Wed, Apr 22, 2026 at 11:04=E2=80=AFAM Tamir Duberstein <tamird@kernel.=
org> wrote:
> >
> > On Tue, Apr 21, 2026 at 7:46=E2=80=AFPM Zhenzhong Wu <jt26wzz@gmail.com=
> wrote:
> > >
> > > Inside migrate_dance(), add epoll checks around shutdown() to
> > > verify that the target listener is not ready before shutdown()
> > > and becomes ready immediately after shutdown() triggers migration.
> > >
> > > Cover TCP_ESTABLISHED and TCP_SYN_RECV. Exclude TCP_NEW_SYN_RECV
> > > as it depends on later handshake completion.
> > >
> > > Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
> > > ---
> > >  .../bpf/prog_tests/migrate_reuseport.c        | 49 ++++++++++++++++-=
--
> > >  1 file changed, 42 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/migrate_reuseport=
.c b/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
> > > index 653b0a20f..c62907732 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
> > > @@ -7,24 +7,29 @@
> > >   *   3. call listen() for 1 server socket. (migration target)
> > >   *   4. update a map to migrate all child sockets
> > >   *        to the last server socket (migrate_map[cookie] =3D 4)
> > > - *   5. call shutdown() for first 4 server sockets
> > > + *   5. for TCP_ESTABLISHED and TCP_SYN_RECV cases, verify via epoll
> > > + *        that the last server socket is not ready before migration.
> > > + *   6. call shutdown() for first 4 server sockets
> > >   *        and migrate the requests in the accept queue
> > >   *        to the last server socket.
> > > - *   6. call listen() for the second server socket.
> > > - *   7. call shutdown() for the last server
> > > + *   7. for TCP_ESTABLISHED and TCP_SYN_RECV cases, verify via epoll
> > > + *        that the last server socket is ready after migration.
> > > + *   8. call listen() for the second server socket.
> > > + *   9. call shutdown() for the last server
> > >   *        and migrate the requests in the accept queue
> > >   *        to the second server socket.
> > > - *   8. call listen() for the last server.
> > > - *   9. call shutdown() for the second server
> > > + *  10. call listen() for the last server.
> > > + *  11. call shutdown() for the second server
> > >   *        and migrate the requests in the accept queue
> > >   *        to the last server socket.
> > > - *  10. call accept() for the last server socket.
> > > + *  12. call accept() for the last server socket.
> > >   *
> > >   * Author: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
> > >   */
> > >
> > >  #include <bpf/bpf.h>
> > >  #include <bpf/libbpf.h>
> > > +#include <sys/epoll.h>
> > >
> > >  #include "test_progs.h"
> > >  #include "test_migrate_reuseport.skel.h"
> > > @@ -350,21 +355,51 @@ static int update_maps(struct migrate_reuseport=
_test_case *test_case,
> > >
> > >  static int migrate_dance(struct migrate_reuseport_test_case *test_ca=
se)
> > >  {
> > > +       struct epoll_event ev =3D {
> > > +               .events =3D EPOLLIN,
> > > +       };
> > > +       int epoll =3D -1, nfds;
> > >         int i, err;
> > >
> > > +       if (test_case->state !=3D BPF_TCP_NEW_SYN_RECV) {
> > > +               epoll =3D epoll_create1(0);
> > > +               if (!ASSERT_NEQ(epoll, -1, "epoll_create1"))
> > > +                       return -1;
> > > +
> > > +               ev.data.fd =3D test_case->servers[MIGRATED_TO];
> > > +               if (!ASSERT_OK(epoll_ctl(epoll, EPOLL_CTL_ADD,
> > > +                                        test_case->servers[MIGRATED_=
TO], &ev),
> > > +                              "epoll_ctl"))
> > > +                       goto close_epoll;
> > > +
> > > +               nfds =3D epoll_wait(epoll, &ev, 1, 0);
> > > +               if (!ASSERT_EQ(nfds, 0, "epoll_wait 1"))
> > > +                       goto close_epoll;
> > > +       }
> > > +
> > >         /* Migrate TCP_ESTABLISHED and TCP_SYN_RECV requests
> > >          * to the last listener based on eBPF.
> > >          */
> > >         for (i =3D 0; i < MIGRATED_TO; i++) {
> > >                 err =3D shutdown(test_case->servers[i], SHUT_RDWR);
> > >                 if (!ASSERT_OK(err, "shutdown"))
> > > -                       return -1;
> > > +                       goto close_epoll;
> > >         }
> > >
> > >         /* No dance for TCP_NEW_SYN_RECV to migrate based on eBPF */
> > >         if (test_case->state =3D=3D BPF_TCP_NEW_SYN_RECV)
> > >                 return 0;
> > >
> > > +       nfds =3D epoll_wait(epoll, &ev, 1, 0);
> > > +       if (!ASSERT_EQ(nfds, 1, "epoll_wait 2")) {
> > > +close_epoll:
> > > +               if (epoll >=3D 0)
> > > +                       close(epoll);
> > > +               return -1;
> > > +       }
> >
> > I think you can avoid this goto using `__attribute__((cleanup(...))`:
> >
> >   static void close_fd(int *fd)
> >   {
> >         if (*fd >=3D 0)
> >                 close(*fd);
> >   }
> >
> >   #define __close_fd __attribute__((cleanup(close_fd)))
> >
> > then in the test:
> >
> > __close_fd int epoll =3D -1;
> >
> > there's an example of this in
> > tools/testing/selftests/bpf/prog_tests/socket_helpers.h.

