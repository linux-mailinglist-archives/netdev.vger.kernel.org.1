Return-Path: <netdev+bounces-302774-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Gu4PEpC2QmpMAAoAu9opvQ
	(envelope-from <netdev+bounces-302774-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:16:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D71C06DDF53
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:16:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=r3ngRI7J;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302774-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302774-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C62C30330B7
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 18:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395F337D13D;
	Mon, 29 Jun 2026 18:13:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FAD2C2360
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 18:13:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782756791; cv=pass; b=RGZjDSHvoo6Hytqm5Zx+4b5BMoRIcU4In0xLUf202zg1vgQEoj07qUnTqVPBVmnlRkNqIwQ8VwQ1PKTzsafp4zQrSmT3Kkj71deevolXb0EAAZdC4Gwzd2JaySrkcWY5RRRPfJ+QiPjWOahukRHeU6NKu6khc45kiVzzz2EYX1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782756791; c=relaxed/simple;
	bh=YsBJ5rLzCHNROrpoUXAG2+olo/jg6vCTJlr1rdi8LKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fq/mM93Xxi8AWYPgUWbSeQus/jPo/N9nyXsD6s+C0LrNJKIbhx/ZEMjFJQJMJhVl1KO4LfEHRjwlBEftjCff2ibVsfdEWxjY1ZlQzgx+dqW04LGM7x1lwvUkMEYFwIYGMRUSb2rwcpyQoLeKijpJ+iQVSjXAiq1SEF18d0KQWP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r3ngRI7J; arc=pass smtp.client-ip=209.85.128.174
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-80bab6cf5ebso32471267b3.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:13:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782756787; cv=none;
        d=google.com; s=arc-20260327;
        b=st15asnxmlAuSTIwiQNiuUcaJzR82URhmAhiTTwrQZvx4lC8qvW1UQFKhdxz7d4zsH
         yX+BOBDA0OX75ok6XQridsoux9GCgIDaQ+OZRJWNwNiosbt3+WUFs1kg7xtfvE6xpAnm
         UT5jEQrjU1aZ9o/0YF6rDD9om5+zXpKupkgyRfpyq3WCxv8cZUZgcdzaZPyvvsX/c7AO
         FPXzUVFFqm4u+F4wttUeb3g2tt9AuCqM50bEn69zC4cJzYPI499HnkxRRleXPdxLXjmH
         GjuzlnL4YFF1XMvdBrwrt1QlZFPeMboqJ2VLqmEWvjk5JuxPTb6Xn3a2dkmG7KcmLLSV
         Tfpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SmmYAil1f9hLMNCPLSvS+Czx4YqCWUlhWfkBPgyh9NY=;
        fh=OgPBJaXhftMvyZttB6eJXVX1+yvHNVY7Zt4b71AcTTk=;
        b=QF5C8apB/GFZWoPE4EfAAqH9AuBf/4U9uEa0xDLDqpdjoOgTRmSWKulfaGR1ZrfJ+m
         OJLBW48fiZOdYGwImmpCIFwQIClPSSE0oXY4NzMkepvScyiiZi9WJrtKHH3/RevjOKBF
         iX/qCt37/3VhqsF8iz+8C/1y0spvrxgsrwCSKB+E12u2l+AF2jmk5enxJTeOmMAQ2eKG
         2jDEs2pV6PXK22M18qfwcfw8hwyzWR8Iv8RryfOtKshEzDbgmvXOxH0rZYoW4CVnsugc
         0NT+S01zJcewsqxkyU+D2gElIP/o5DT/FxrmSim/yPyvUAi/Ewn0HZdKix0gCsQtjt+V
         pSHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782756787; x=1783361587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmmYAil1f9hLMNCPLSvS+Czx4YqCWUlhWfkBPgyh9NY=;
        b=r3ngRI7Jw9a9T4fPzceGvzHGZRZZq6wE0N8XjsH5UPH5hLeo0brp789qCVWuxAnoS0
         gS3TMV/Cw6nuiR1WzZM/2N31gOX/7iUcSOu5g7v0WcTy6bmtuy5mq0DGSCWwRtreNS7X
         TysAfKHcBqNz1ud1PETZI/DUHiAb+js5G5s7xqEjK3LjYFhDoDHzJ+BGJRFBY9CPuzsz
         eGj6HqkRitxTwvykDsc694jyWxXtSsaHYkKS6F+X2098lujKa0HRsxnJOTfFr9g0IOoX
         ptSWKhC+6uoAzRb3d06nLra+bLdT7lRdQnRzvqxGNOOH5dYygTcgBJZFoExKIir97Gjx
         KS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782756787; x=1783361587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SmmYAil1f9hLMNCPLSvS+Czx4YqCWUlhWfkBPgyh9NY=;
        b=IbBudAs2o/PmiFV4xiIf1tLv43fwpBTQXglMzI6SErqg7E415d1doAfgDLBaAVTNIl
         HDPpeLTy8Aha4hjorVlpSyH6P677CD9qTY6kXP3E4uy6cXzdcGYSU+x/7eoW2/FnrwG1
         qxVplt4yhjdYontVcxtdefSpWlKsy1XuPeUsUD7JnicTYvEaUGI+CRf0ktiOHMhOHdLW
         MJrWa+UiK/A9SG1FIJfU9RCiSu5YtO8hpu+kgOV4VRq3JcADdtaCXk2L5b1tPQWXH1GH
         1w8VJeqboBZLJwN9BFS6++qenudNwnqtk1CATWvqXkbCwQB+7vnlc5a64W4N2dm8mkoO
         IAVQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrvw6tH8Mxfok5CUPZL/u+6nTsqMZ2u+vYnGMR+WWAwE6JXxq1yAtbdQWLOPwgkhRDHVy9aUQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn4fMcFfprYuaPSUJIkq04tZFITWLSaB8XINuTHD5ok4/lpbXQ
	w6rtKK994aw4a8AdUXydvMyCkyvmPlK+V3zzM+w2OKMxEoiOg8ZIBmLYx2z+Rjf+094LNMJ1VNf
	hQSxtPDs0QR5U2hOupTmb9oIiai9V2pQ=
X-Gm-Gg: AfdE7ckGSPneti3JTiJgwlJhR2+UEmj2DSiCVRsqYQfe8rYHgRKH6AY1Wp9Px/io7XK
	K6IYSgBd8Mz0OoyVPD++re1RUftYyUTn+KSGbdFhoUOSF2GqPixR+xIlI6xB1nEj6UWFzOgydkG
	axjkWssx6RcM4IaMuM8YuW5s1rnvgz8DwbgvDkMQPxqIIt7f4HPeg0tQ6eecmLe7N9axx2tuPMo
	WymYBkKBX7n76SNZa6wfAHh4HuCWsa3+gPRouSxS6FCeIoaLFei3GMh3cQJngqKdpXiyCZjoVeB
	Bg/1AGiEOczN
X-Received: by 2002:a05:690c:dcd:b0:80b:1616:5c0e with SMTP id
 00721157ae682-810e984a566mr3240827b3.20.1782756787534; Mon, 29 Jun 2026
 11:13:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629125637.384923-1-layus.on@gmail.com>
In-Reply-To: <20260629125637.384923-1-layus.on@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 29 Jun 2026 11:12:54 -0700
X-Gm-Features: AVVi8CdW3Ek5fAOq0hw_26M9hi49cDbrZRotwx5VJpI7hZNDTSnWdF5fckFOukc
Message-ID: <CAMB2axM=utfi11L1e2-yMgCiSEZ=QrZAPrcFLwk44hNqyT1qJQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Mask socket type flags in mptcpify prog
To: "Guillaume @layus Maudoux" <layus.on@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:layus.on@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:matttbe@kernel.org,m:martineau@kernel.org,m:geliang@kernel.org,m:shuah@kernel.org,m:bpf@vger.kernel.org,m:mptcp@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:layuson@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-302774-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,vger.kernel.org,lists.linux.dev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D71C06DDF53

On Mon, Jun 29, 2026 at 6:19=E2=80=AFAM Guillaume @layus Maudoux
<layus.on@gmail.com> wrote:
>
> The mptcpify BPF prog hooks update_socket_protocol() to rewrite
> eligible TCP socket() calls to IPPROTO_MPTCP. It only does so when the
> socket type is exactly SOCK_STREAM:
>
>         type =3D=3D SOCK_STREAM
>
> The problem is that update_socket_protocol() in __sys_socket() is
> called on the raw type argument as passed from userspace, before
> __sys_socket_create() strips the flag bits with
> "type &=3D SOCK_TYPE_MASK". The type argument may therefore carry
> SOCK_CLOEXEC and/or SOCK_NONBLOCK in its upper bits, and the equality
> check above then fails.
>
> As a result, any socket created with e.g.
> socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0) -- which is what common
> libraries do by default -- is silently left as plain TCP instead of
> being upgraded to MPTCP. This was observed in practice with curl,
> whose connections were not upgraded to MPTCP despite the prog being
> attached.
>
> The impact reaches beyond the test, because mptcpify.c is referenced
> as example code for users who want to transparently enable MPTCP. The
> same mistake is therefore likely to be copied into real deployments,
> where it fails the same way and is hard to diagnose.
>
> The fix is to mask off the flag bits before comparing, mirroring what
> the socket core does:
>
>         (type & SOCK_TYPE_MASK) =3D=3D SOCK_STREAM
>
> Since SOCK_TYPE_MASK is not exposed through vmlinux.h, define it in
> bpf_tracing_net.h.
>
> To exercise the regression directly, extend the mptcpify test to also
> create the server socket with SOCK_CLOEXEC and SOCK_NONBLOCK set.
> Routing a flagged type through start_server() then revealed a second
> instance of the same pattern: start_server_addr() compared the type
> against SOCK_STREAM for equality to decide whether to set SO_REUSEADDR
> and call listen(), and so would skip listening for a flagged type.
> Mask the type there as well. As SOCK_TYPE_MASK is not exposed by
> glibc's <sys/socket.h> either, define it in network_helpers.h,
> mirroring prog_tests/socket_helpers.h.
>
> Fixes: ddba122428a7 ("selftests/bpf: Add mptcpify test")
> Signed-off-by: Guillaume @layus Maudoux <layus.on@gmail.com>

Hello,

You will need to use your real name in the SOB. At least "@" caused
some problems when I downloaded the patch.

Please also include "bpf-next" in your subject prefix so that the CI
can properly test it.

> ---
>  tools/testing/selftests/bpf/network_helpers.c |  4 ++--
>  tools/testing/selftests/bpf/network_helpers.h |  5 +++++
>  .../testing/selftests/bpf/prog_tests/mptcp.c  | 20 +++++++++++++++----
>  .../selftests/bpf/progs/bpf_tracing_net.h     |  3 +++
>  tools/testing/selftests/bpf/progs/mptcpify.c  |  2 +-
>  5 files changed, 27 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testin=
g/selftests/bpf/network_helpers.c
> index b82f572641b7..db935a9d9fc1 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -111,7 +111,7 @@ int start_server_addr(int type, const struct sockaddr=
_storage *addr, socklen_t a
>         if (settimeo(fd, opts->timeout_ms))
>                 goto error_close;
>
> -       if (type =3D=3D SOCK_STREAM &&
> +       if ((type & SOCK_TYPE_MASK) =3D=3D SOCK_STREAM &&
>             setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &on, sizeof(on))) {
>                 log_err("Failed to enable SO_REUSEADDR");
>                 goto error_close;
> @@ -128,7 +128,7 @@ int start_server_addr(int type, const struct sockaddr=
_storage *addr, socklen_t a
>                 goto error_close;
>         }
>
> -       if (type =3D=3D SOCK_STREAM) {
> +       if ((type & SOCK_TYPE_MASK) =3D=3D SOCK_STREAM) {
>                 if (listen(fd, opts->backlog ? MAX(opts->backlog, 0) : 1)=
 < 0) {
>                         log_err("Failed to listed on socket");
>                         goto error_close;
> diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testin=
g/selftests/bpf/network_helpers.h
> index 79a010c88e11..75133119c04a 100644
> --- a/tools/testing/selftests/bpf/network_helpers.h
> +++ b/tools/testing/selftests/bpf/network_helpers.h
> @@ -25,6 +25,11 @@ typedef __u16 __sum16;
>  #define VIP_NUM 5
>  #define MAGIC_BYTES 123
>
> +/* include/linux/net.h */
> +#ifndef SOCK_TYPE_MASK
> +#define SOCK_TYPE_MASK 0xf
> +#endif
> +
>  struct network_helper_opts {
>         int timeout_ms;
>         int proto;
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testi=
ng/selftests/bpf/prog_tests/mptcp.c
> index 8fade8bdc451..faa001ea84ab 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -264,7 +264,7 @@ static int verify_mptcpify(int server_fd, int client_=
fd)
>         return err;
>  }
>
> -static int run_mptcpify(int cgroup_fd)
> +static int run_mptcpify(int cgroup_fd, int type)
>  {
>         int server_fd, client_fd, err =3D 0;
>         struct mptcpify *mptcpify_skel;
> @@ -280,7 +280,7 @@ static int run_mptcpify(int cgroup_fd)
>                 goto out;
>
>         /* without MPTCP */
> -       server_fd =3D start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
> +       server_fd =3D start_server(AF_INET, type, NULL, 0, 0);
>         if (!ASSERT_GE(server_fd, 0, "start_server")) {
>                 err =3D -EIO;
>                 goto out;
> @@ -307,7 +307,18 @@ static int run_mptcpify(int cgroup_fd)
>  static void test_mptcpify(void)
>  {
>         struct netns_obj *netns =3D NULL;
> -       int cgroup_fd;
> +       int cgroup_fd, i;
> +       int types[] =3D {
> +               SOCK_STREAM,
> +               /* userspace sets these flags together with the type, and=
 the
> +                * BPF prog must still upgrade the socket to MPTCP. See
> +                * update_socket_protocol() in net/socket.c, which runs b=
efore
> +                * the type is masked with SOCK_TYPE_MASK.
> +                */
> +               SOCK_STREAM | SOCK_CLOEXEC,
> +               SOCK_STREAM | SOCK_NONBLOCK,
> +               SOCK_STREAM | SOCK_CLOEXEC | SOCK_NONBLOCK,
> +       };
>
>         cgroup_fd =3D test__join_cgroup("/mptcpify");
>         if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
> @@ -317,7 +328,8 @@ static void test_mptcpify(void)
>         if (!ASSERT_OK_PTR(netns, "netns_new"))
>                 goto fail;
>
> -       ASSERT_OK(run_mptcpify(cgroup_fd), "run_mptcpify");
> +       for (i =3D 0; i < ARRAY_SIZE(types); i++)
> +               ASSERT_OK(run_mptcpify(cgroup_fd, types[i]), "run_mptcpif=
y");

nit: testing all four type combinations adds little value here. I'd
drop array+loop and keep two. For example:

  ASSERT_OK(run_mptcpify(cgroup_fd, SOCK_STREAM), "run_mptcpify");
  ASSERT_OK(run_mptcpify(cgroup_fd, SOCK_STREAM | SOCK_CLOEXEC),
"run_mptcpify_cloexec");

>
>  fail:
>         netns_free(netns);
> diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tools/=
testing/selftests/bpf/progs/bpf_tracing_net.h
> index d8dacef37c16..c4b438854565 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
> @@ -8,6 +8,9 @@
>  #define AF_INET                        2
>  #define AF_INET6               10
>
> +/* include/linux/net.h */
> +#define SOCK_TYPE_MASK         0xf
> +
>  #define SOL_SOCKET             1
>  #define SO_REUSEADDR           2
>  #define SO_SNDBUF              7
> diff --git a/tools/testing/selftests/bpf/progs/mptcpify.c b/tools/testing=
/selftests/bpf/progs/mptcpify.c
> index cbdc730c3a47..e3f8cb54dbe9 100644
> --- a/tools/testing/selftests/bpf/progs/mptcpify.c
> +++ b/tools/testing/selftests/bpf/progs/mptcpify.c
> @@ -15,7 +15,7 @@ int BPF_PROG(mptcpify, int family, int type, int protoc=
ol)
>                 return protocol;
>
>         if ((family =3D=3D AF_INET || family =3D=3D AF_INET6) &&
> -           type =3D=3D SOCK_STREAM &&
> +           (type & SOCK_TYPE_MASK) =3D=3D SOCK_STREAM &&
>             (!protocol || protocol =3D=3D IPPROTO_TCP)) {
>                 return IPPROTO_MPTCP;
>         }
> --
> 2.54.0
>
>

