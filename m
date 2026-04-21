Return-Path: <netdev+bounces-280081-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLx4MItc52l87AEAu9opvQ
	(envelope-from <netdev+bounces-280081-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 13:16:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1FE43A00C
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 13:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5712030157BF
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 11:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4825E3B8937;
	Tue, 21 Apr 2026 11:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgE4dPdA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871A239E6E4
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 11:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776770180; cv=pass; b=gyMBnc9cM5vIXHJC4w1Tx7PCg37YabpQaYM2CfW3JFbUq6YYbnD5sXYgdDEmKxOGYSvH2U8GTWDfXBdchBQCOzXBaOosByzX02lI4kBqMcJP4qLN86AVY3bxREGFwyMc2zqDNWSsqAdP1iucoAVC16CWSNOuW/y1eVKItAKgpsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776770180; c=relaxed/simple;
	bh=xHtU+c81PCV+Q/mDHpL1ndBQSjxWRpiFVJjZ2lwUM9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DGGa6+OQzKgashr0l6go+yg/S1PD54ebrlK/ftfQrB907bCxEoCgmqCa/uApQ+cceVjmTTjGh/8u/WWhOPCRLoLJHCHYph99nz/5DcXbVEipCY+3mcKayAtjPSCBgh7zK9JTs6WKww6sHlvhIUfEsAf9s4LqZRzMtTal7jT0utg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgE4dPdA; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4890098abbaso27737975e9.0
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 04:16:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776770176; cv=none;
        d=google.com; s=arc-20240605;
        b=HNcsMwGEUypNV+MIBpDdPWzxypLb6jM/isUjzqcqMcUgXIRRdfIwqhT/lJGflmuLSs
         S4qqjr8BTj8kI9QeWhUUnpEktQxPgEo3w2xX6frahZ5a9afcdqsrCToUpresW9Il7o75
         QLqVbNj3v8oPZ51oFy9/WYNTRIJu0Lo2QpNYfW8JRfQOBgqm+P7+r2XJHeF/e0lX3zlN
         M90/b/3CFiDoFC2E53fm41thvY9Bl2zgd0c+oh7PtvqKBzgKBG+I2udvy0SiR4vejeuA
         qOkHVi7mxVCr4iXQ2MIAPP3p4DnZFqBfE34yDkVi5w5shDnW0oSXLv2xgmquEdJLQvU3
         FciQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fq2YTgqHTIIyD2rszM0vRaUMqiq0NDdNvW+3dfjj9hc=;
        fh=0lXWVvmRDgMWjuWIFQ+Yi6kUkg9kMUzTUFtQhZ2PB7A=;
        b=GfXIZX2mfTZ8vTNXIvQ/LAMK+8ZE4SswoI/Qyp3yXAJ+wtvd+s3epn2aWpFnktIHVF
         fs9UB7aWplhYhGw/t99BbjPMzpJKSJBQtQ632I1ALT88HHhB/wtpEjuGsixzAcxnxnJ3
         D/jj7LSV3QYffcQlBDuJMcCGBl/d2wiN9/2BF5srzOhzhllfhsba2HK/TgvO1r+WqpG6
         UDbGdW3MJwaJ3MLM6d4PlC81OV4PVz/Bl1VtqValI9f3rG6+GSJupS3fDVsCcTl+tNpI
         cMnnW4+rx6TGV7vaIPRe3DIjbk84axG1MZGuSXNBAYsSCL5eyN0J3CnG6NqHd05b93Ag
         25zA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776770176; x=1777374976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fq2YTgqHTIIyD2rszM0vRaUMqiq0NDdNvW+3dfjj9hc=;
        b=EgE4dPdAkIZHIf39obU0Zbkj8vLWDscdLtMB8ESx7LtQ4Pd27YLdDCgvQdB1W8t43U
         QaT+PyT2grZ+DoMmcJ4pFH6nTSYXeeFCf0hlvDEckoQjUAzwv0X4IiCPApW2eYIqZ2SG
         7su1Z249aMLn9/xORFNf5a28haSjDeVZWNACiKxbYQY+w5Xaiyj/79G/U0wbP2SaLz26
         RoQ/vj8UTGRYS/pTIljtVyTJEs2joE0E7JryBoASXtOMIkCyZkcY5fpUU0qIWrLkp8Oi
         ckiTLF9CRUYmytN0YFGvCDnMmTXal8sJelu5rjbTBXsVATXtFmwfYCU2D9o5cBVKjnmB
         su5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776770176; x=1777374976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fq2YTgqHTIIyD2rszM0vRaUMqiq0NDdNvW+3dfjj9hc=;
        b=En+qjQpR+tLps2xhynKQ1M/qRbcScEc9smCHvR2C38zbl/0AAglzHwJMf+5ZQShBQi
         cZJU0PBSqoi/6XF/2gxTxW8EclgCOQCmyOzErZDnTD7PXq+feU00oCtp7jTmdYOMauNp
         3Y+xz04Jn/SjbbRqqQNpPs/g/p0Oqw88vgjl+U8peVuI/cLHpKW4wf+jfFK+LAcdgb98
         qb8OXtIdGkqOAenmAgZkUfChJFUNjW2M3bKJkIJfLOD1RJpNHHqdJeWLEnDgAg47uNHJ
         IMEn05ORE0CZGGe+Lylr/LX59u1zmGol7Jg9PAY2bz/a+Plb1tJspAI6FrUVOIEPH+q6
         zhMw==
X-Forwarded-Encrypted: i=1; AFNElJ8DBBmik1f++548UBPIku7aeDOHw6FthEuEjCOnrOBTKBh5KzzYxh17N8sqYrxxk+eWz5YErEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW6JnyvFxa163pwIsRG+NyV6CMN6gg4lgiQpExcxMHOG7flzCj
	xkf/tvcAzPE/x8aIMjRiz7NVjUK4GWIqRR15Ac7LxBQF90m/ZP9eHVmhcXjWP0bjJFutW2F+XZo
	jO7Y+R94qO2CHt2hl3mYJSSkGV7HFOZQ=
X-Gm-Gg: AeBDieuXEOZeYBH8OEwkRk4CJ4sSaygTCb1Gnu6u2GIPlOmutH0tYnd7+SyXRQ+vHWs
	GyRIfodzC3TB/GOfMJESD+PrTIbRixLoPpLj7YoOXtNLDaOCfH17zlpv71QObvrCSjoYgydBQzR
	G9ivMaPZs6d+pnH4JcduSbhc1s7tI0v6aWv1QSURu2/gCkn7tQVvEwZfCspOYsrBqUVMNi6fA1+
	dy64P5PVh8nmpJVJzUco5m503D97CADlWNws1g8xAdfXrnFE9g3JXJmm3g/n+FA7JXWL68HcDwm
	oG/lZXLznA2OLQpAWiZl
X-Received: by 2002:a05:600c:3596:b0:48a:563c:c8c5 with SMTP id
 5b1f17b1804b1-48a563cd1b2mr30378475e9.8.1776770175648; Tue, 21 Apr 2026
 04:16:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418181333.1713389-3-jt26wzz@gmail.com> <20260421072017.1653163-1-kuniyu@google.com>
In-Reply-To: <20260421072017.1653163-1-kuniyu@google.com>
From: Zhenzhong Wu <jt26wzz@gmail.com>
Date: Tue, 21 Apr 2026 19:16:02 +0800
X-Gm-Features: AQROBzCfYeb2hFc2XS6OvyD81f4Di5fu65_4FeaU9mS2NrZi535PDG1ANc77Ggg
Message-ID: <CALgi0XnMTCZVEaq7+nEhZ5OANOJkwh4GCvtUNsZcsXDvXrg4bg@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] selftests/bpf: check epoll readiness after
 reuseport migration
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, ncardwell@google.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, shuah@kernel.org, tamird@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-280081-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA1FE43A00C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks Kuniyuki, will fold this into v3.

Your approach of checking epoll right around shutdown() is much
better. I didn't think to put the check inside migrate_dance(). With
my original placement, the test still passed without patch 1 =E2=80=94 I
should have called this out in the cover letter instead of settling
for what was effectively just a smoke test.




On Tue, Apr 21, 2026 at 3:20=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> From: Zhenzhong Wu <jt26wzz@gmail.com>
> Date: Sun, 19 Apr 2026 02:13:33 +0800
> > After migrate_dance() moves established children to the target
> > listener, add it to an epoll set and verify that epoll_wait(..., 0)
> > reports it ready before accept().
> >
> > This adds epoll coverage for the TCP_ESTABLISHED reuseport migration
> > case in migrate_reuseport.
> >
> > Keep the check limited to TCP_ESTABLISHED cases. TCP_SYN_RECV and
> > TCP_NEW_SYN_RECV still depend on asynchronous handshake completion,
> > so a zero-timeout epoll_wait() would race there.
> >
> > Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
> > ---
> >  .../bpf/prog_tests/migrate_reuseport.c        | 32 ++++++++++++++++++-
> >  1 file changed, 31 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c=
 b/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
> > index 653b0a20f..580a53424 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
> > @@ -18,13 +18,16 @@
> >   *   9. call shutdown() for the second server
> >   *        and migrate the requests in the accept queue
> >   *        to the last server socket.
> > - *  10. call accept() for the last server socket.
> > + *  10. for TCP_ESTABLISHED cases, call epoll_wait(..., 0)
> > + *        for the last server socket.
> > + *  11. call accept() for the last server socket.
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
> > @@ -522,6 +525,33 @@ static void run_test(struct migrate_reuseport_test=
_case *test_case,
> >                       goto close_clients;
> >       }
> >
> > +     /* Only TCP_ESTABLISHED has already-migrated accept-queue entries
> > +      * here.  Later states still depend on follow-up handshake work.
> > +      */
> > +     if (test_case->state =3D=3D BPF_TCP_ESTABLISHED) {
> > +             struct epoll_event ev =3D {
> > +                     .events =3D EPOLLIN,
> > +             };
> > +             int epfd;
> > +             int nfds;
> > +
> > +             epfd =3D epoll_create1(EPOLL_CLOEXEC);
> > +             if (!ASSERT_NEQ(epfd, -1, "epoll_create1"))
> > +                     goto close_clients;
> > +
> > +             ev.data.fd =3D test_case->servers[MIGRATED_TO];
> > +             if (!ASSERT_OK(epoll_ctl(epfd, EPOLL_CTL_ADD,
> > +                                      test_case->servers[MIGRATED_TO],=
 &ev),
> > +                            "epoll_ctl"))
> > +                     goto close_epfd;
> > +
> > +             nfds =3D epoll_wait(epfd, &ev, 1, 0);
> > +             ASSERT_EQ(nfds, 1, "epoll_wait");
>
> Thanks for the update, but the test passes without patch 1.
>
> I think it would be best to test just after shutdown()
> where migration happens.
>
> Also, TCP_SYN_RECV should be covered in the same way.
>
> ---8<---
> diff --git a/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c b=
/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
> index 580a534249a7..66fea936649e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
> +++ b/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
> @@ -353,8 +353,29 @@ static int update_maps(struct migrate_reuseport_test=
_case *test_case,
>
>  static int migrate_dance(struct migrate_reuseport_test_case *test_case)
>  {
> +       struct epoll_event ev =3D {
> +               .events =3D EPOLLIN,
> +       };
> +       int epoll, nfds;
>         int i, err;
>
> +       if (test_case->state !=3D BPF_TCP_NEW_SYN_RECV) {
> +               epoll =3D epoll_create1(0);
> +               if (!ASSERT_NEQ(epoll, -1, "epoll_create1"))
> +                       return -1;
> +
> +               ev.data.fd =3D test_case->servers[MIGRATED_TO];
> +               if (!ASSERT_OK(epoll_ctl(epoll, EPOLL_CTL_ADD,
> +                                        test_case->servers[MIGRATED_TO],=
 &ev),
> +                              "epoll_ctl")) {
> +                       goto close_epoll;
> +               }
> +
> +               nfds =3D epoll_wait(epoll, &ev, 1, 0);
> +               if (!ASSERT_EQ(nfds, 0, "epoll_wait 1"))
> +                       goto close_epoll;
> +       }
> +
>         /* Migrate TCP_ESTABLISHED and TCP_SYN_RECV requests
>          * to the last listener based on eBPF.
>          */
> @@ -368,6 +389,15 @@ static int migrate_dance(struct migrate_reuseport_te=
st_case *test_case)
>         if (test_case->state =3D=3D BPF_TCP_NEW_SYN_RECV)
>                 return 0;
>
> +       nfds =3D epoll_wait(epoll, &ev, 1, 0);
> +       if (!ASSERT_EQ(nfds, 1, "epoll_wait 2")) {
> +close_epoll:
> +               close(epoll);
> +               return -1;
> +       }
> +
> +       close(epoll);
> +
>         /* Note that we use the second listener instead of the
>          * first one here.
>          *
> @@ -525,33 +555,6 @@ static void run_test(struct migrate_reuseport_test_c=
ase *test_case,
>                         goto close_clients;
>         }
>
> -       /* Only TCP_ESTABLISHED has already-migrated accept-queue entries
> -        * here.  Later states still depend on follow-up handshake work.
> -        */
> -       if (test_case->state =3D=3D BPF_TCP_ESTABLISHED) {
> -               struct epoll_event ev =3D {
> -                       .events =3D EPOLLIN,
> -               };
> -               int epfd;
> -               int nfds;
> -
> -               epfd =3D epoll_create1(EPOLL_CLOEXEC);
> -               if (!ASSERT_NEQ(epfd, -1, "epoll_create1"))
> -                       goto close_clients;
> -
> -               ev.data.fd =3D test_case->servers[MIGRATED_TO];
> -               if (!ASSERT_OK(epoll_ctl(epfd, EPOLL_CTL_ADD,
> -                                        test_case->servers[MIGRATED_TO],=
 &ev),
> -                              "epoll_ctl"))
> -                       goto close_epfd;
> -
> -               nfds =3D epoll_wait(epfd, &ev, 1, 0);
> -               ASSERT_EQ(nfds, 1, "epoll_wait");
> -
> -close_epfd:
> -               close(epfd);
> -       }
> -
>         count_requests(test_case, skel);
>
>  close_clients:
> ---8<---

