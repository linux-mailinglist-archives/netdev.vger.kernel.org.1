Return-Path: <netdev+bounces-280295-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FY5JmU76GlfHQIAu9opvQ
	(envelope-from <netdev+bounces-280295-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 05:07:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10522441B4C
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 05:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 318173024462
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 03:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3291E3A3809;
	Wed, 22 Apr 2026 03:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+KWwDpw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A823921E7
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 03:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776827077; cv=none; b=O0c7k43rgFyHvL+4MJ+Kn1Aufye95sLAGxZEZadzvxaEH63aiIwfyxxiwiqexhk8+Ci93FEV2+DsE1JmYojTltnwv++H7OjX2skGOrYyt0L40NIHXau3ArvUR7uzST+qMGarCPsWG1W/iqc3cf8Y10xY2R0g6EmA4vn8DzfLSgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776827077; c=relaxed/simple;
	bh=2yG0Na14H8PIlcd1Ov+DXBcxLTZ/NTxyqyYeMX1t74I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A75Lohh6An6+wPU7gk0S/+0ps9i9VmSwgCQbI3J6/oc1G/5s5nsN5iSIfdQgNsq63PUv4c3lFmsW2qK1jpyCeXb0EU/ejowP6EDqru75R/w5oAwguDWhqmKmCC9kufRF49IQ56f5CRZrLMSKaoNvx1OCwnuCueoVcGeS+W+lGas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+KWwDpw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6758AC2BCB8
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 03:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776827074;
	bh=2yG0Na14H8PIlcd1Ov+DXBcxLTZ/NTxyqyYeMX1t74I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=s+KWwDpwVv0yqCrfMHHWg+bpN6sM+xnchwDrlBhkJz0ydnT9rXVPPUBqIxfY1qd1A
	 L/Wo+mOW67vhsWuemdBIEYzwbpOgKn906IUtL/WOM5tRP39Mj57Rh24NXREt1gSdaJ
	 la0yLZ8uqCyJzKKSJGzSyknvO2bkOHMGJrdNz6qPxaplGRYb0fpaZsHhpAJEgvX7Mh
	 1mDt9pb8iKlHfgEuExIjNwJmoumvmnJazDO62TDyEchE/+JcfOhuHlMyBtKOnEwR8y
	 8KHGcxsAR9O1JS0gdJ1IiEiyafl/qdQYNqnOwBiE+UJgaewGhVGS9jlvWlCBHbOqUf
	 FpekFGLj6xE2w==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38e12c67a6fso48423311fa.1
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 20:04:34 -0700 (PDT)
X-Gm-Message-State: AOJu0YydHS29AyCo5dGsW+jOYkYpgjXcdUJ3V/64zTnYPQ5QJoQe0GvJ
	JPgpOi5ON9a2G+dlGHs4tEo2C3jr2pT2oZ2MFEV16I8FAVY67Q8c92sNjyQGrr5uE5Uv/eX1IXc
	TwPRUhDMtPNq+NZvAG87IV7ccn+dKgsI=
X-Received: by 2002:a05:651c:e18:b0:38e:d8a3:e08a with SMTP id
 38308e7fff4ca-38ed8a3e2bemr58167831fa.3.1776827073104; Tue, 21 Apr 2026
 20:04:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422024554.130346-1-jt26wzz@gmail.com> <20260422024554.130346-3-jt26wzz@gmail.com>
In-Reply-To: <20260422024554.130346-3-jt26wzz@gmail.com>
From: Tamir Duberstein <tamird@kernel.org>
Date: Tue, 21 Apr 2026 23:03:56 -0400
X-Gmail-Original-Message-ID: <CAJ-ks9=FKMoczH+Z=GQ7C40T42=zdknYzzHCa8UVFOtq2H69cw@mail.gmail.com>
X-Gm-Features: AQROBzB5S4pUq6MWULcMd0UwUqFuxUwpBS_8Dval67dyf8v48VLrrsf2Rq-d7OI
Message-ID: <CAJ-ks9=FKMoczH+Z=GQ7C40T42=zdknYzzHCa8UVFOtq2H69cw@mail.gmail.com>
Subject: Re: [PATCH net v4 2/2] selftests/bpf: check epoll readiness during
 reuseport migration
To: Zhenzhong Wu <jt26wzz@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com, 
	kuniyu@google.com, davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280295-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamird@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 10522441B4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 7:46=E2=80=AFPM Zhenzhong Wu <jt26wzz@gmail.com> wr=
ote:
>
> Inside migrate_dance(), add epoll checks around shutdown() to
> verify that the target listener is not ready before shutdown()
> and becomes ready immediately after shutdown() triggers migration.
>
> Cover TCP_ESTABLISHED and TCP_SYN_RECV. Exclude TCP_NEW_SYN_RECV
> as it depends on later handshake completion.
>
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
> ---
>  .../bpf/prog_tests/migrate_reuseport.c        | 49 ++++++++++++++++---
>  1 file changed, 42 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c b=
/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
> index 653b0a20f..c62907732 100644
> --- a/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
> +++ b/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
> @@ -7,24 +7,29 @@
>   *   3. call listen() for 1 server socket. (migration target)
>   *   4. update a map to migrate all child sockets
>   *        to the last server socket (migrate_map[cookie] =3D 4)
> - *   5. call shutdown() for first 4 server sockets
> + *   5. for TCP_ESTABLISHED and TCP_SYN_RECV cases, verify via epoll
> + *        that the last server socket is not ready before migration.
> + *   6. call shutdown() for first 4 server sockets
>   *        and migrate the requests in the accept queue
>   *        to the last server socket.
> - *   6. call listen() for the second server socket.
> - *   7. call shutdown() for the last server
> + *   7. for TCP_ESTABLISHED and TCP_SYN_RECV cases, verify via epoll
> + *        that the last server socket is ready after migration.
> + *   8. call listen() for the second server socket.
> + *   9. call shutdown() for the last server
>   *        and migrate the requests in the accept queue
>   *        to the second server socket.
> - *   8. call listen() for the last server.
> - *   9. call shutdown() for the second server
> + *  10. call listen() for the last server.
> + *  11. call shutdown() for the second server
>   *        and migrate the requests in the accept queue
>   *        to the last server socket.
> - *  10. call accept() for the last server socket.
> + *  12. call accept() for the last server socket.
>   *
>   * Author: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
>   */
>
>  #include <bpf/bpf.h>
>  #include <bpf/libbpf.h>
> +#include <sys/epoll.h>
>
>  #include "test_progs.h"
>  #include "test_migrate_reuseport.skel.h"
> @@ -350,21 +355,51 @@ static int update_maps(struct migrate_reuseport_tes=
t_case *test_case,
>
>  static int migrate_dance(struct migrate_reuseport_test_case *test_case)
>  {
> +       struct epoll_event ev =3D {
> +               .events =3D EPOLLIN,
> +       };
> +       int epoll =3D -1, nfds;
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
> +                              "epoll_ctl"))
> +                       goto close_epoll;
> +
> +               nfds =3D epoll_wait(epoll, &ev, 1, 0);
> +               if (!ASSERT_EQ(nfds, 0, "epoll_wait 1"))
> +                       goto close_epoll;
> +       }
> +
>         /* Migrate TCP_ESTABLISHED and TCP_SYN_RECV requests
>          * to the last listener based on eBPF.
>          */
>         for (i =3D 0; i < MIGRATED_TO; i++) {
>                 err =3D shutdown(test_case->servers[i], SHUT_RDWR);
>                 if (!ASSERT_OK(err, "shutdown"))
> -                       return -1;
> +                       goto close_epoll;
>         }
>
>         /* No dance for TCP_NEW_SYN_RECV to migrate based on eBPF */
>         if (test_case->state =3D=3D BPF_TCP_NEW_SYN_RECV)
>                 return 0;
>
> +       nfds =3D epoll_wait(epoll, &ev, 1, 0);
> +       if (!ASSERT_EQ(nfds, 1, "epoll_wait 2")) {
> +close_epoll:
> +               if (epoll >=3D 0)
> +                       close(epoll);
> +               return -1;
> +       }

I think you can avoid this goto using `__attribute__((cleanup(...))`:

  static void close_fd(int *fd)
  {
        if (*fd >=3D 0)
                close(*fd);
  }

  #define __close_fd __attribute__((cleanup(close_fd)))

then in the test:

__close_fd int epoll =3D -1;

there's an example of this in
tools/testing/selftests/bpf/prog_tests/socket_helpers.h.

