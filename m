Return-Path: <netdev+bounces-280274-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBRlDI0B6GlJEAIAu9opvQ
	(envelope-from <netdev+bounces-280274-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 01:00:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E980440605
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 01:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92B74305AE33
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 22:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B085379ED6;
	Tue, 21 Apr 2026 22:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kJnEIdXO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AC63502B8
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 22:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776812392; cv=pass; b=SmzbpRzWnd3eD8Uaeb6NnQvqcftyKTGKpw+U6BOo2OSvAPiPsBzyODCQ0/ksfpZQW/eZgboHaMeFWGiEnYuURvV8F3HJ24Hg2GXE5IICQE9SBFnohTiDYfe/DUalvEJ4d7YBiMy0ahoWOojrZRQhItnK6GjR/A72FKqqxDkeYaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776812392; c=relaxed/simple;
	bh=a3Prwcdh8j9+3CtUCjVP05sQvOvEc9TKH7JXC6xKWl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DNvZyGd6hCQMwQ3d01T2aIOX81k3Kv2JT3xi6rpyht0uuGabs2gEdJGws6FgjyiwHmAx2IUqZyyHwkBuljOplWIn/BMFBX/cB7urMFUchxyz4kW4WxeACc0ux9r6QFRKlQq9ctlt+VZfLmHFB98J3iwsJeQFIsBg7cidQw2x7CI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kJnEIdXO; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c565476d7so11123984c88.1
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 15:59:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776812391; cv=none;
        d=google.com; s=arc-20240605;
        b=OH/Q97yPZh0s0chq6WqG75y2kGEFXvu3oFRle/k0avt99NK5V0AWX2kLdZxDe+Pco+
         CkObrKXUWa3CrwhTm0boClrCCL+KRZPv2EAjdMHtXrCG1mHc3xGXSyG4qAZVum09qQB4
         Nt9ql2ZfmfkktK+7V2yz6D25xSYyDGsjU0DllpdIyLpL9r8x8i3VeHCtLYN47kspmMYh
         TsSdEp14ZiSrmCsh/zCy+6ZRVZahO86SyNEvFguDazfwVwtrTXTu4u+qPABgp69gTuSL
         cALnW8x+93nDTntEybbjVhmL3P5UOcMiAe9d6ssfLl38kBbWEkszJx1cCtHlXyHsiT6/
         B3gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EUyujIAApUVAkDEH0uSDEg04wL17CBrnWRgJpkrkKwA=;
        fh=rg9FwRUfVQKqIEL/mhJkRo8b+mJGVFVDJ3GHRqjafJY=;
        b=lqc3bO9B0CRmWuMuNfaO1y7XdWV/blQ0f1GPP3Qruyv4Hk8j4xEc8Bx0X9+KfDpZ9T
         EjwCEUIIU8VpjFw9sUQvF83ZOcAAukM99xMCIRs8I1BYEUMJqJn0Dg/MQjBTnLZmTGkZ
         kEB4ZMX0KRwdyp5c+e+G8uv3T69LM30n/ct4cGw8Bjd/RTBNUL49qltsihlxN2TBdAV1
         L3AcQa1Wg4FHvyDvK183ziklgFcbfBXvMbDD3kPrNSn+vG7OvwL4iJ94aXO4WZr7bzgJ
         wqIYIxjP54s4YCE0PYsiL7v7QAXX5E6xNekKeeNHGGpzeBCW+f1+lA8AJnwt/yTqpo8e
         9OsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776812391; x=1777417191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUyujIAApUVAkDEH0uSDEg04wL17CBrnWRgJpkrkKwA=;
        b=kJnEIdXOSNh5El6j8Cqf8cZQDH0EsSIFvXhpT1bMNNqRKxB73DY+SOpdx33agney4Q
         qbxoyNQ+YyyZcBloPQN2hF2nzIqGMEVRqnD3jU5VaqYIolVbKrtYj4ILdfy1sgqxanTz
         mX91nn/T6xuR7hD2PLwpr4qxKm5TpEZyFZ8LuTnezZBy/AWm4ASgMfSNDBoU1sZw+t+k
         lR3MqLoT4OwFn2fCd3qnH4kxQiGx9+BfbRng0oiknMFjiJ3NATFyd1K496VpVMp4W0a0
         eIpB2UHFW+sjPdMmsIEwNa+NeMtj8Vkh3ZllKJ7ChtjxM0XK5F1EyeRr4X3m72rJQVp5
         O1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776812391; x=1777417191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EUyujIAApUVAkDEH0uSDEg04wL17CBrnWRgJpkrkKwA=;
        b=sA5p5yV7Q2dZfKU/fZp1YSa7/CPROqmDYRhs74bbg91IzriWj/++klU0WYx5bd7b5H
         1GiPWx30pGcBpnnYgqv8yDAnSc2OxQOGUmUX5jAhj+9Z/V3JzN43GqAdDp9XbMhGC8/h
         94FoO4ns7g31sojMCVBoq2bm9fcpoXmhyjrMLH5SnTTD5UGzGfCjMnFAz55YQD3U64Hi
         tD8CFA4QZv5xa66caLJFmc1/D0rxKu/iF5KPAXulvgKLyZxuMWcDtfLZRwzGfKtFZnsD
         j+LK5p1MhQcYu2TD5YRuHiBRp3UGsqshAYG/7G9xvZV4P9GQSURp7SxYBtB0IPAriKPM
         Yh4g==
X-Gm-Message-State: AOJu0YyOiyq4aOUg0aeYaZdN8qi3Ee2SU77s0PspS9MCKq6TdRPN7Vf/
	379wO/j7UjG7b80bTN8jLAjqO0KakY31YT72uhGQ7cUocDVSOkZWQHGeAWPHRpXVW20uWKdKx6n
	jWBUFpz+/MLlSKNp0plBbfoMvwsxPdi8YpZp3VLws
X-Gm-Gg: AeBDietLrmXxdpl4w+SNlmf0HXU91DMds9R3ZIswPCvFGP1bm7DMN0paBGSAr/VnVpt
	U/0t0WfFkgl5Ri6YsyW7x1FVyl5jlzHzQbHurZzyvKeCkoXgwQJ7B1F8rG/UtbJWT09hdHIVv7g
	lpkbmNv7kPP2VbYn/ebF1LFzqrFpLZ1bfpjedzwxz4WGwcf2sM+iKUuBiskkL0kHuPCsW6Sj4DD
	mxJRFWh8mIOxzNq+vjHVnmOQxsjH4lW3JLlBGlz58Jg1Fz7dQS+NMeYIWFA+oWk/sSz9lpL9cVX
	Vk0UVlWsw/nkMPxIZisRd+SlC4fc8ln+BtMB0zOZD9Xj46w1s19GyQqrYJhzkFRNvVUsO6CaBwN
	90IUXD5/iT4mV/HO5w4PTyPDM0GqP2JiQJ44zkAHQSdTBRg/zV0wupuvG5TvlN0C35Ht1YYBL5A
	==
X-Received: by 2002:a05:7022:60c:b0:12a:713b:8958 with SMTP id
 a92af1059eb24-12c73f7596bmr10068832c88.10.1776812390229; Tue, 21 Apr 2026
 15:59:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421123106.142299-1-jt26wzz@gmail.com> <20260421123106.142299-3-jt26wzz@gmail.com>
In-Reply-To: <20260421123106.142299-3-jt26wzz@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 21 Apr 2026 15:59:39 -0700
X-Gm-Features: AQROBzD2IEw4ypAL697CZLXFoPfbIAflmemsvJ5os_4y8LuiwAgFAJA40Z9E2X0
Message-ID: <CAAVpQUDv28sNCYdo6oH25FNKnddZibwrmxMUf4GqgS4fRA8+og@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] selftests/bpf: check epoll readiness during
 reuseport migration
To: Zhenzhong Wu <jt26wzz@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, shuah@kernel.org, tamird@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280274-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.co.jp:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9E980440605
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 5:31=E2=80=AFAM Zhenzhong Wu <jt26wzz@gmail.com> wr=
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
> Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
> ---
>  .../bpf/prog_tests/migrate_reuseport.c        | 46 ++++++++++++++++---
>  1 file changed, 40 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c b=
/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
> index 653b0a20f..6180a79a7 100644
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
> @@ -350,8 +355,28 @@ static int update_maps(struct migrate_reuseport_test=
_case *test_case,
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

Sorry I forgot to update return -1 to goto close_epoll
when shutdown() fails.

Otherwise looks good.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>


> @@ -365,6 +390,15 @@ static int migrate_dance(struct migrate_reuseport_te=
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
> --
> 2.43.0
>

