Return-Path: <netdev+bounces-291140-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QH44NpB4EmqszwYAu9opvQ
	(envelope-from <netdev+bounces-291140-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 06:03:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3535C155C
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 06:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2378D300D952
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 04:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7332C29DB6C;
	Sun, 24 May 2026 04:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KWUjpMVM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B422F238171
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 04:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779595396; cv=pass; b=lBS0Y36nAdFaVqgFZijA++zsgbVlXrspnqe7TjvMekmvKfWUGnibm0r6N9wFdB3dfS21L5XLI1f3F8MaqZgP6bOFjKmnWpcsrJyfQTycFeSO5D+ksA2LwhX1fm7kOWu3nGNNDqdbyCyYNWtHGaN+eRK/5sqOT7G5Q34vYpvdIok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779595396; c=relaxed/simple;
	bh=UK6MqR13SkmVeNHAVhpbyuwZEqU27LqGTv2pP1kGcwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dc9+veXl6yxt7HVQ65hngkQ0qz+oXO+mfvWhWZErXbuuZVgC7ndaKVk5WGVwrIkFgs6GhD3u88HMUlte7vk7mVmhjyxsZLUbmIk1TPTUw8EO9ZG1MvqRfYtBPjXaJnsoEKxkQjoTCIjQO1wcILQCYCCJpgfpBhhw3q6EsW9ZsjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KWUjpMVM; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1353c2f35cfso2196702c88.1
        for <netdev@vger.kernel.org>; Sat, 23 May 2026 21:03:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779595393; cv=none;
        d=google.com; s=arc-20240605;
        b=XUXeafOltwF7CQ8UXAhMei6j+mNZEZJzqbo3qIB+iNGgK56QCd2iNfktREuADTPWVZ
         2FHp6rCYdvgo9PYUbPw8r4owkLGUk+VZTrHP1RTU5cls9WjxuDAV+a2ISPvr15mycGvj
         9t0QSM7A2aNiDGn7M8PvdUJHu51qQSYKaYUvq5F9oqDc/ty/rCztJhGQJOtGBgbwKHY+
         DDuQ4CG+lparclImjFYRp6jL6DIFXsmDoUdIEEP79ENnmKznITAlUdWpEbpTh1MS316w
         vPoCU5VkUdHAn323aFncE3tsqJoM3RpABKWZfWUn++vb7LO52MiNrL9odZx4uYbRmtvH
         WHxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pWhZ7WvslVBCIrg7rQU2VQHwQRiE5+pLZxvQ9Rg/MVk=;
        fh=GZEo2CYA7sSyeTPld83iRD6vJps8fGTKGmNqHiFyhS8=;
        b=LQBavwiXaFbdPAM5yYJ28IQhnGTctoF89Lxyz2M4A9VUyCqNdhf2aQ+Ml+vECQiEv7
         70NFdapZijUdsI6lc8Qq1cNSoA1VUscEP3N8+6K1noYnnCc/HbFMEz9zATTLE762yzeX
         L7MilHFfg4LpP5PeiHgx9gsFcW5wNGF+xDjPVyzb9EYs5Bu+fuJHihYScv4BbY2UNkrL
         Eghj5eTyFRUW/gLK0hUDktSC0NFL/UFVclZ64sc64Gmq6Ifjl9gQo0HB2vylll/9u9vS
         38B/2y9QQsn2sV7Q+EtqaKrFWgcd/243MSVCGGraf7BtUsRfteNbffKMI43PQXtMgc6O
         E++Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779595393; x=1780200193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWhZ7WvslVBCIrg7rQU2VQHwQRiE5+pLZxvQ9Rg/MVk=;
        b=KWUjpMVMKmwLsVDu8/oOhgIEhoqhnaj3VWTd2KmIoZz1a2IXf1sDy35S/+88gsjgg6
         2uNSLXNEl/s5muzDRSNxOzYilgM1UUDfNSVNnqQWrpGMduAOEVqSjC9zll0sB2Zdaylx
         XnPmK4HChDmKzieYCB2tO80q2FHxMlHJ1JRGzmRzO0sWQMNr2moPnj9fUatOBoZq+/z4
         HSQWavJDuEo/zIC0MC/ojbsoz1MobLa8ggBypcyUeu/3UaGMoOcxPgthf37EyVFoib8A
         a/3odHKhMFfjy7fM1iOCmNhpMy/5zNvIiaZ3k0/wiGEMc/uzIslCn5qkzerHO6G0ie8u
         Bm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779595393; x=1780200193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pWhZ7WvslVBCIrg7rQU2VQHwQRiE5+pLZxvQ9Rg/MVk=;
        b=Tp5EpWqlKQ2aBpYCO5XuwFL8ymObRKLfLPevJDR/nl1TudohB5yno9EsvmdoFSUbVv
         0cXMAIxwjOXoVtd/fdlSuKNZIJH1wWy7MfuDDO2qdDFyR7qrUR5Hh0NwGIesZQ3WJIgX
         mll+eW4Y04YrM/oNtQAs9ESaPcoP1ndJcBSCAlaGq9MGaDQPmD6KR7iWtI2da8nc2Wjl
         PNoel7MZCEktmUTtuKgIWKSWiH/EzUV7oiu6dSn2ZqcA+TQMMdi3kmwEsglAZCGbxQeT
         k0FVCPT/wuYen6/r5DcEcvdiv2bxcojB6tTSJvr7ubvipWkrIwr7gJaDzWX8ytbmuk9z
         bWtg==
X-Forwarded-Encrypted: i=1; AFNElJ8pk6O7RhVCINHJOloyregDh3NKJtiU2QaRPUfGd3loUz0L2O6mylag6XLp7lXKT8HFNVvJ8/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz1SimceJk7tFOkvauO6faMrKwVikOkZnTFqlv7M2mbGCO1Gh1
	ea+4KLAopC7RCXcA/qzii+VPI3NoO1mOHLIhMhb+bUAGjZSQxsXrOdapNqGAzvnBS9NCduJbylH
	oYfq+i9b3sR2ZfrI44m7BKFy/KZa89urxBK8X+S/O
X-Gm-Gg: Acq92OGZLYQjb/M2LggBdABTfjiG8M2Jh1xm/Y8NcPUwx7RUrXc7TFy9OCrsbekaz09
	Ps/y+v1ZsspVpaeJgAoCa/btqCHBy9duG84YADqJDi5O9YNvZRfQ2jGIdUjkDk2akWCP7VVLDUf
	H7YWIlV/WBLPJp7PjmWNmihhvaV4zI3Viw4NoxrXfagYlkiw/kxFQ1/DNfOencUtMV7T/pJ7lNH
	45pYIxmanIpIg6hbas9PRAJUo0aNq3HsI83BoUWzXv8a1QvfpjIiG8ezQcbXWB7rhp815Z6MjQg
	0gES3ZLsnL9BNJy1CsYxLC2BH/dZ1IsCpUVVyM17qzTdD7KCfUQLILrWdC8nbKdx54dOauK7zy5
	oEYhj5p+LUDXVf5pEgll0vMoGJUGoZW1ojAZM6xNwJNjL17fbh71u9Q0UAXHiGNQ=
X-Received: by 2002:a05:7022:699b:b0:132:d182:3dd6 with SMTP id
 a92af1059eb24-1365f91f913mr4048606c88.16.1779595392068; Sat, 23 May 2026
 21:03:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523083001.2911931-12-kuniyu@google.com> <9f7f313051e697158ce96e5d9cc5c49bae934655e982d10f58230dfd5b5c1084@mail.kernel.org>
In-Reply-To: <9f7f313051e697158ce96e5d9cc5c49bae934655e982d10f58230dfd5b5c1084@mail.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 23 May 2026 21:03:00 -0700
X-Gm-Features: AVHnY4L7xop31Ge6-JC1JxJ6HABZ9qVVsdLZDfxPzzi3TYfd4RegrKRm4lmeG50
Message-ID: <CAAVpQUC5Z+NFC5RTvAeqmHBExQa7jaTiEtdCBSLMJepO0neNMg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 11/11] selftest: bpf: Add test for BPF_SOCK_OPS_RCVQ_CB.
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, sdf@fomichev.me, 
	edumazet@google.com, ncardwell@google.com, willemb@google.com, 
	ukyab@berkeley.edu, kuni1840@gmail.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org,meta.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-291140-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[20]
X-Rspamd-Queue-Id: 7C3535C155C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 23, 2026 at 2:20=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/s=
elftests/bpf/bpf_kfuncs.h
> > --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
> > +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
> > @@ -64,6 +64,10 @@
> >  extern int bpf_sk_assign_tcp_reqsk(struct __sk_buff *skb, struct sock =
*sk,
> >                                  struct bpf_tcp_req_attrs *attrs, int a=
ttrs__sz) __ksym;
> >
> > +struct bpf_sock_ops_kern;
> > +extern int bpf_sock_ops_tcp_set_rcvlowat(struct bpf_sock_ops_kern *sko=
ps_kern,
> > +                                      int rcvlowat) __ksym;
> > +
> >  void *bpf_cast_to_kern_ctx(void *) __ksym;
> >
> >  extern void *bpf_rdonly_cast(const void *obj, __u32 btf_id) __ksym __w=
eak;
>
> [ ... ]
>
> > diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tool=
s/testing/selftests/bpf/progs/bpf_tracing_net.h
> > --- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
> > +++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
> > @@ -74,6 +74,8 @@ #define ETH_P_IPV6          0x86DD
> >
> >  #define NEXTHDR_TCP          6
> >
> > +#define TCPHDR_FIN           0x01
> > +
> >  #define TCPOPT_NOP           1
> >  #define TCPOPT_EOL           0
> >  #define TCPOPT_MSS           2
>
> [ ... ]
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c b/t=
ools/testing/selftests/bpf/prog_tests/tcp_autolowat.c
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c
> > @@ -0,0 +1,350 @@
>
> [ ... ]
>
> > +             .event =3D {
> > +                     { .type =3D RPC_EVENT_AUTOLOWAT,  .val =3D 1},
> > +                     /* The first descriptor is partial. */
> > +                     {.type =3D RPC_EVENT_SEND,        .len =3D 1},
> > +                     {.type =3D RPC_EVENT_EPOLL,       .nfds =3D 0},
> > +                     {.type =3D RPC_EVENT_RCVLOWAT,    .rcvlowat =3D R=
PC_DESC_SIZE},
> > +                     /* The first descriptor is available. */
> > +                     {.type =3D RPC_EVENT_SEND,        .len =3D RPC_DE=
SC_SIZE - 1},
> > +                     {.type =3D RPC_EVENT_EPOLL,       .nfds =3D 0},
> > +                     {.type =3D RPC_EVENT_RCVLOWAT,    .rcvlowat =3D R=
PC_DESC_SIZE + 150 + 100},
> > +                     /* The first header is ready. */
> > +                     {.type =3D RPC_EVENT_SEND,        .len =3D 100},
> > +                     {.type =3D RPC_EVENT_EPOLL,       .nfds =3D 0},
> > +                     {.type =3D RPC_EVENT_RCVLOWAT,    .rcvlowat =3D R=
PC_DESC_SIZE + 150 + 100},
> > +                     /* skb has the first payload and 1 byte of the ne=
xt descriptor. */
> > +                     {.type =3D RPC_EVENT_SEND,        .len =3D 150 + =
1},
> > +                     {.type =3D RPC_EVENT_EPOLL,       .nfds =3D 1},
> > +                     {.type =3D RPC_EVENT_RCVLOWAT,    .rcvlowat =3D R=
PC_DESC_SIZE + 150 + 100},
> > +                     /* After reading the first RPC message, SO_RCVLOW=
AT should be RPC_DESC_SIZE. */
> > +                     {.type =3D RPC_EVENT_RECV,        .len =3D RPC_DE=
SC_SIZE + 150 + 100},
> > +                     {.type =3D RPC_EVENT_EPOLL,       .nfds =3D 0},
> > +                     {.type =3D RPC_EVENT_RCVLOWAT,    .rcvlowat =3D R=
PC_DESC_SIZE},
>
> Does calling recv() actually trigger the BPF program to update SO_RCVLOWA=
T?
>
> Since the kernel only invokes BPF_SOCK_OPS_RCVQ_CB when a new skb is adde=
d
> to the receive queue, and not when data is dequeued via recv(),

Again, this is wrong.



> the BPF
> program doesn't seem to run here.
>
> Could this cause the test to fail unconditionally because sk_rcvlowat
> retains its previous value?
>
> Reference: https://lore.kernel.org/bpf/20260522083527.D40D51F000E9@smtp.k=
ernel.org/
> Reviewer: sashiko-bot@kernel.org (Fri, 22 May 2026 08:35:27 +0000)
>
> [ ... ]
>
> > +static void tcp_autolowat_run_rpc_test(struct tcp_autolowat_test_cb *c=
b,
> > +                                    struct rpc_test_case *test_case)
> > +{
> > +     struct rpc_event *event =3D test_case->event;
> > +     char *ptr =3D test_case->data;
> > +     struct epoll_event ev;
> > +     socklen_t optlen;
> > +     int err, optval;
> > +     char buf[4096];
> > +
> > +     if (tcp_autolowat_build_data(test_case))
> > +             return;
> > +
> > +     while (1) {
> > +             switch (event->type) {
> > +             case RPC_EVENT_END:
> > +                     return;
> > +             case RPC_EVENT_AUTOLOWAT:
> > +                     err =3D setsockopt(cb->child, SOL_BPF, BPF_TCP_AU=
TOLOWAT,
> > +                                      &event->val, sizeof(event->val))=
;
> > +                     if (!ASSERT_OK(err, "setsockopt"))
> > +                             return;
> > +                     break;
> > +             case RPC_EVENT_SEND:
> > +                     err =3D send(cb->client, ptr, event->len, 0);
> > +                     if (!ASSERT_EQ(err, event->len, "send"))
> > +                             return;
> > +
> > +                     ptr +=3D event->len;
> > +                     break;
>
> Could this lead to race conditions causing flaky tests?

No, it's over loopback.

>
> The test calls send() to transmit data and immediately executes the next
> event. Because network transmission over the loopback interface involves
> asynchronous softirq processing, send() might return before the packet is
> fully processed by the receiving socket.
>
> If the next event is RPC_EVENT_EPOLL with a timeout of 0, could
> epoll_wait() prematurely return 0? Similarly, for RPC_EVENT_RCVLOWAT,
> could getsockopt() read a stale sk_rcvlowat value before the TCP stack an=
d
> BPF program have finished processing the packet?
>
> Reference: https://lore.kernel.org/bpf/20260522083527.D40D51F000E9@smtp.k=
ernel.org/
> Reviewer: sashiko-bot@kernel.org (Fri, 22 May 2026 08:35:27 +0000)
>
> [ ... ]
>
> > diff --git a/tools/testing/selftests/bpf/progs/tcp_autolowat.c b/tools/=
testing/selftests/bpf/progs/tcp_autolowat.c
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/tcp_autolowat.c
> > @@ -0,0 +1,326 @@
>
> [ ... ]
>
> > +static int tcp_parse_descriptor(struct bpf_sock_ops *skops,
> > +                             struct tcp_autolowat_cb *cb,
> > +                             u32 seq, u32 end_seq)
> > +{
> > +     struct rpc_descriptor *rpc_desc;
> > +     u32 rpc_copied_seq;
> > +     u64 copy_len; /* u32 should work, but not for no_alu32 :/ */
> > +     u64 rpc_len;
> > +     int err;
> > +
> > +     rpc_copied_seq =3D cb->rpc_desc_seq + cb->rpc_desc_buff_len;
> > +
> > +     if (before(cb->rpc_desc_seq + RPC_DESC_SIZE, end_seq))
> > +             copy_len =3D RPC_DESC_SIZE - cb->rpc_desc_buff_len;
> > +     else
> > +             copy_len =3D end_seq - rpc_copied_seq;
> > +
> > +     /* Since LLVM commit 324e27e8bad83ca23a3cd276d7e2e729b1b0b8c7,
> > +      * clang omits the "copy_len =3D=3D 0" check below, which is nece=
ssary
> > +      * to satisfy the BPF verifier's range check for bpf_skb_load_byt=
es().
> > +      */
>
> This isn't a bug, but multi-line comments in the BPF subsystem are
> expected to have the opening '/*' on its own line:
>
>         /*
>          * Since LLVM commit ...
>          * ...
>          */
>
> Reference: https://lore.kernel.org/bpf/20260522083527.D40D51F000E9@smtp.k=
ernel.org/
> Reviewer: sashiko-bot@kernel.org (Fri, 22 May 2026 08:35:27 +0000)
>
> [ ... ]
>
> > +static void tcp_set_autolowat(struct bpf_sock_ops_kern *skops_kern,
> > +                           struct tcp_autolowat_cb *cb,
> > +                           struct tcp_sock *tp)
> > +{
> > +     /* To handle wraparound. */
> > +     u32 val =3D 0;
> > +
> > +     LOG("Setting rcvlowat: tp->copied_seq: %u, rpc_desc_seq: %u, rpc_=
end_seq: %u, rpc_desc_buff_len: %u",
> > +         TP_SEQ(copied_seq), CB_SEQ(rpc_desc_seq), CB_SEQ(rpc_end_seq)=
, cb->rpc_desc_buff_len);
> > +
> > +     if (before(tp->copied_seq, cb->rpc_desc_seq))
> > +             val =3D cb->rpc_desc_seq - tp->copied_seq;
> > +     else if (cb->rpc_desc_buff_len !=3D RPC_DESC_SIZE)
> > +             val =3D RPC_DESC_SIZE;
> > +     else
> > +             val =3D cb->rpc_end_seq - tp->copied_seq;
>
> Does this code incorrectly set SO_RCVLOWAT to the total combined size of
> all unread frames when multiple RPC frames are received in a single skb?
>
> If multiple complete frames arrive in the same skb, the parsing loop in
> tcp_do_autolowat() parses all of them and advances cb->rpc_desc_seq to th=
e
> end of the last parsed frame. This sets:
>
> val =3D cb->rpc_desc_seq - tp->copied_seq
>
> which evaluates to the length of all unread frames combined.
>
> If an application sequentially reads one frame at a time, tp->copied_seq
> advances and the queue size decreases, but sk_rcvlowat is not updated
> because BPF_SOCK_OPS_RCVQ_CB only fires on packet enqueue.

This comment is based on the wrong assumption too :/


>
> The remaining queue size will then be strictly less than sk_rcvlowat,
> causing epoll_wait to block and trapping the remaining fully-received
> frames in the receive queue.
>
> Could this hang applications that rely on epoll to read one message at a
> time?
>
> Reference: https://lore.kernel.org/bpf/20260522083527.D40D51F000E9@smtp.k=
ernel.org/
> Reviewer: sashiko-bot@kernel.org (Fri, 22 May 2026 08:35:27 +0000)
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/263285=
41814

