Return-Path: <netdev+bounces-280281-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGdJC44Y6GnWEwIAu9opvQ
	(envelope-from <netdev+bounces-280281-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 02:38:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7E3440E4C
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 02:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7ECB2301A77C
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 00:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790EC1DED4C;
	Wed, 22 Apr 2026 00:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5kxBIlT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EBE19B5B1
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 00:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776818314; cv=pass; b=HMwbiGMafRW+XGCUiEgVwegf6Wh4BtGe+2JfpGmHuN/5CqlKn/JFBpEYcLN7Ueq7d2hG6SIDKgeQAE2TAfxS0XzTh0q8PcISDCs/4fnb1STQusg99Zvn413znZLd/k8iAnGleZU5FigUIxeNL00g8RDmHUbvqqD8/8/xKxrLq5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776818314; c=relaxed/simple;
	bh=MvfDZ3IJ+pAGJgyo/drGyRM18kwJEa8gkPZl9/L5ZYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mWxlWdLdX773gmwkeL9uTdapo/cq/n0JFbCbJ2PEN8YSUgmenge1dVVLEeft5p9W7QPszfD9HdAPnrZin39Z/l+FDL2U3YrutK75VXm3Qe17FdVqRuKx00jlkAB5fdXSe1txGiQUjHwJf1XZwJ5msY8jGPEis8DSmUyWzTK9mTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5kxBIlT; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so61841905e9.0
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 17:38:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776818311; cv=none;
        d=google.com; s=arc-20240605;
        b=fIZCnVTNyyavYa7zNJ2kmU9WKlZYtm0tg9BeTBC77+FfUVcdWyDF/ifaPxeXsCKXd1
         cCn6CsBBV7j9K0I/4yKAcIFvkIcBrfRFw3fFUcqHm8JKM8UIVsWZT0xKS0L66sx/Nfw6
         c5/01YoiYfhVExIPocCqfOI3npE5DHo/gwsdSY40yX/jRnBMALg/XLDCOHY3cA29sl9y
         Q89W/0dYoeTTerA3z7ZxYTUK3+TfYTk4e744o7OgPDOgOrXPzUHOVvAVQ8SarNc0XSXv
         JcAUgNlg3MBtkD9E1Wp910hfqBueYmF8aRStAgn2lQ92W+ZBAEf03ofJ1EZf+jV1xuH7
         qKmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+WKb54h3+M8yqPA04t5MI5hcgx20ftmUyS8BLYJJG/8=;
        fh=+3PkQwVn6hLT9ZPWsXJyRPY9dhPLjEfY5+ZBr6RoxsI=;
        b=HZvn5zmQ6jRT5O3K7zitVq5sWiLfIm0YukX+fshO2W91peGmZiG4dH6qEDqH5dfmoc
         ATpyH8rb0x/QDTxc0aeahhbkjUUcokfHSfNOQeWF+10MBj/5NXoGF6H4sqiuIjwiMxNU
         4t4QYIqjkEET81ptYjncXQwM0Fq7+IM+0BFWj6acSvByfgd0V8hukAVn6TWfEj6pTHw5
         2rL3iCCahrUdqAwfnFRWXXsnSOK1bffcETjAJkxm2EbPZWWTevQ4HoCED8dYRc4V+8Ol
         S0gYeB2B54KBEtriEGtfXV3/wG8tfjwrAMD5Z6JzYoB5K4ViWDOFbPwFlLHeKU66qcje
         BKFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776818311; x=1777423111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WKb54h3+M8yqPA04t5MI5hcgx20ftmUyS8BLYJJG/8=;
        b=m5kxBIlTVn6ZKCeppYmncCsJTHG2uz0FsM4jM5ulXCpzKvm/Sz4YH7kndEnklJ6u8t
         61r9oB2QdaIMLTE/NUD/L3akTBZLCfSCREnbTLJUi1stuxVWza5QEeunM5Vw0erSzB/8
         sXrkls0EREBnqH6NQMY9YlmstfmBx4EQeTSWVFFN11jbAg20IbjMM2xtekpwf4PWcnRe
         tLkAsZYHrtjTxrZYzym58uRjbap35TrIQjlGL6TgignW1hCY/3io4l/BJ96aPheTLZ82
         F9STgzrfBKVq/uaE6WbZxTJorgiIuqJ1pJW9ECzyBZw9rZ1FntcZD9wJwlHQRly695Zm
         HVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776818311; x=1777423111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+WKb54h3+M8yqPA04t5MI5hcgx20ftmUyS8BLYJJG/8=;
        b=bFCIoTT8IrUIx0x+LKhlfW7DGAgHl6X+QDuy+wwiLfEL+HJdv9sJMhlbR9Wc7AoZDp
         451gZNUssQ9G+mmt+mu0tJMkLA0LQWNm3AQuYER3kTFJPmQMul2UGQHCxAARu9U3lZzi
         LQzsmqDbZkNTBxA778F2rZNOoWpZILFRftwvjFNAKNEtUmR7Nx64PNQgR/B/8SwqGGT7
         dWDGkIoveFJ3w4QbqnTNyKkuSJLzTE8hKB6yNj5m++3D48tMFtyM/LNcuP1H9jrORoqk
         2xnCvB2nro9vctqb/clKuRnpLeXaOwU+zZ2QtaHgwxlOLs179xWYUl0SRzHzxcjJN/bx
         CQeQ==
X-Gm-Message-State: AOJu0YwPzdxPNJ5Kk6uVdtVU9xv4qlf2NsMwpJ5EtTyQacOG4WdSHvTr
	ddM7R4n+kbaCiC3xt1edrs+ZpzFDmE+sYf0yg7o6x6dShEO6Q5996+jUZOC1nCnTVoLYi7MCarL
	7vtOBnJ1Om7oBEl4Hy6fxdXMH06668/E=
X-Gm-Gg: AeBDievRebBXx57590Rd5Cmlp5XatRGUo83Bbc/8hJGSfSSBRBOjwnb3uPCm8n+I8fO
	jLP9rDOtVwBVGmihGxoeO9JQpp9olTjYvuZaZseRgdnEKvOuwkh8K5fHjUChRi47A4EVpjsX2d3
	3CKRFB/Y+e20YXm5jituI/ABwnP2OKBtOVSQ0/wLCOyHvBTXUtCDGKFLE1sun4n6YWNaiqNRIty
	bJSNFTNytE/IBTEuAyUW29dVYGDru988s8lngvxq1sE4f7zRHxExPK6FbPcGxExOrBC2GMn1IDZ
	sUH2BpxPkVOVQDub5eyo
X-Received: by 2002:a05:600c:1549:b0:48a:761:5808 with SMTP id
 5b1f17b1804b1-48a07615c09mr115171035e9.0.1776818311060; Tue, 21 Apr 2026
 17:38:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421123106.142299-1-jt26wzz@gmail.com> <20260421123106.142299-3-jt26wzz@gmail.com>
 <CAAVpQUDv28sNCYdo6oH25FNKnddZibwrmxMUf4GqgS4fRA8+og@mail.gmail.com>
In-Reply-To: <CAAVpQUDv28sNCYdo6oH25FNKnddZibwrmxMUf4GqgS4fRA8+og@mail.gmail.com>
From: Zhenzhong Wu <jt26wzz@gmail.com>
Date: Wed, 22 Apr 2026 08:38:18 +0800
X-Gm-Features: AQROBzDtNVk9nUAZ66hTEwsTtVGb7ULx7HPZCe8RDVQWcoUKKjcCT-p_wXZJDOg
Message-ID: <CALgi0XmFRv06yWbd4fuVmssg923nEEF1XWyA8t_QuiH21eVMeA@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] selftests/bpf: check epoll readiness during
 reuseport migration
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, shuah@kernel.org, tamird@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-280281-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amazon.co.jp:email]
X-Rspamd-Queue-Id: BD7E3440E4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks, I'll fix the `shutdown()` error path to `goto close_epoll` in v4.

On Wed, Apr 22, 2026 at 6:59=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Tue, Apr 21, 2026 at 5:31=E2=80=AFAM Zhenzhong Wu <jt26wzz@gmail.com> =
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
> > Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
> > ---
> >  .../bpf/prog_tests/migrate_reuseport.c        | 46 ++++++++++++++++---
> >  1 file changed, 40 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c=
 b/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
> > index 653b0a20f..6180a79a7 100644
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
> > @@ -350,8 +355,28 @@ static int update_maps(struct migrate_reuseport_te=
st_case *test_case,
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
>
> Sorry I forgot to update return -1 to goto close_epoll
> when shutdown() fails.
>
> Otherwise looks good.
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
>
>
> > @@ -365,6 +390,15 @@ static int migrate_dance(struct migrate_reuseport_=
test_case *test_case)
> >         if (test_case->state =3D=3D BPF_TCP_NEW_SYN_RECV)
> >                 return 0;
> >
> > +       nfds =3D epoll_wait(epoll, &ev, 1, 0);
> > +       if (!ASSERT_EQ(nfds, 1, "epoll_wait 2")) {
> > +close_epoll:
> > +               close(epoll);
> > +               return -1;
> > +       }
> > +
> > +       close(epoll);
> > +
> >         /* Note that we use the second listener instead of the
> >          * first one here.
> >          *
> > --
> > 2.43.0
> >

