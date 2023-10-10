Return-Path: <netdev+bounces-39610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B57387C017F
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 18:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D93C21C20BAB
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 16:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C175C18639;
	Tue, 10 Oct 2023 16:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lWo1zDng"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45F927476
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 16:21:58 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD3B99
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 09:21:55 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-534694a9f26so34439a12.1
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 09:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696954914; x=1697559714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEGm7qVSPoQ783MQC3jOqu4K4SnlMNqyLavDj4DNhao=;
        b=lWo1zDngYWkKC/eC0E3u+z9nTVI0Ujbft7pBobRRyi7X7nwqqJg+/iPf7ILGNOW5Ha
         qkFCtlF7pOYzDmMZKq36WtCrDqn/LCLCTuuzVPc8whWhsy/G4kz4WgzAptuF/kA07LRO
         f+w4IArpiEbrOFFNz6A5VpbMeM12petxwdpXNK7w2mzGgRk1sotLrnIKg4sm6qBrTwKC
         +QRRHPj62jtNMlOKfFnE+y28CDqfIz2VgLvRnWjnlBcwjMHwkSkKjj/AGbS4sl4TfIg1
         RPk7gRqDuhM2qOhEP7Rv51mCB8TG9qYGpJf0qck69CoiVNiGSw7t66v5ga2YpqV/EpgT
         VkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696954914; x=1697559714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UEGm7qVSPoQ783MQC3jOqu4K4SnlMNqyLavDj4DNhao=;
        b=heXKlcpPlya2v+lfEuogiAC3zLml0rv9rZ/sGD3whbcNjKtr25vn/bse4V8jicrMK8
         ceK8hRXlpzY2hdSNVXB9UNtium3y2vrYTh1WQg2lL0xdOYfvyiXnEHb0uXYVO2fbqbce
         nBNunMkaM2zfxUnkDz0oaGBFUcPqp+nlfLKZmfJEISLlPtBYoRMCtGVRTxWdXB/rso6B
         lbIX3Pgo136JPfj/YHzu2bGWMbkV5DKKQyxDeUt6/ocyhAM/eOE5XausIiGRSiNHiuW/
         5gh+bzdfRY6Q1m1k2PAujrMxdNGqQvGuxnq8I6f31mloVWBvMiGdYnWjlZ2mqhHskVhN
         h3Ww==
X-Gm-Message-State: AOJu0YwDQJiITCaOUoUvMMEwd0lZmhwJJlbm5RnfNX0PpW/DsrcAVwB3
	UMSTEee47OeJ8dxfZP3tiSBGT/SaLXYZaSVJlT5CoZ2dLuLzXMIyMYBTmg==
X-Google-Smtp-Source: AGHT+IF2J+I6H1JzE4nnsVOOU74MCmCRrdA2wHzthHZPFjqVA4lZbI97Hhddch485MaIEKqwCcmzPufKwfNiDZgmJk4=
X-Received: by 2002:a50:9b17:0:b0:53d:a40e:bed1 with SMTP id
 o23-20020a509b17000000b0053da40ebed1mr92012edi.3.1696954913992; Tue, 10 Oct
 2023 09:21:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1d0e4528ab057a246fd8c60b91cffd34f277b957.1696848602.git.pabeni@redhat.com>
In-Reply-To: <1d0e4528ab057a246fd8c60b91cffd34f277b957.1696848602.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Oct 2023 18:21:39 +0200
Message-ID: <CANn89iKOZ89xhAsgXyygENOfRzXPhbFn4_PNdA3LUL0a5EYktA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: allow again tcp_disconnect() when threads are waiting
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Ayush Sawal <ayush.sawal@chelsio.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>, 
	mptcp@lists.linux.dev, Boris Pismenny <borisp@nvidia.com>, Tom Deseyn <tdeseyn@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 9, 2023 at 4:37=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> As reported by Tom, .NET and applications build on top of it rely
> on connect(AF_UNSPEC) to async cancel pending I/O operations on TCP
> socket.
>
> The blamed commit below caused a regression, as such cancellation
> can now fail.
>
> As suggested by Eric, this change addresses the problem explicitly
> causing blocking I/O operation to terminate immediately (with an error)
> when a concurrent disconnect() is executed.
>
> Instead of tracking the number of threads blocked on a given socket,
> track the number of disconnect() issued on such socket. If such counter
> changes after a blocking operation releasing and re-acquiring the socket
> lock, error out the current operation.
>
> Fixes: 4faeee0cf8a5 ("tcp: deny tcp_disconnect() when threads are waiting=
")
> Reported-by: Tom Deseyn <tdeseyn@redhat.com>
> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1886305
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  .../chelsio/inline_crypto/chtls/chtls_io.c    | 35 +++++++++++++++----
>  include/net/sock.h                            | 10 +++---
>  net/core/stream.c                             | 12 ++++---
>  net/ipv4/af_inet.c                            |  8 +++--
>  net/ipv4/inet_connection_sock.c               |  1 -
>  net/ipv4/tcp.c                                | 17 ++++-----
>  net/ipv4/tcp_bpf.c                            |  4 +++
>  net/mptcp/protocol.c                          |  8 +----
>  net/tls/tls_main.c                            | 10 ++++--
>  net/tls/tls_sw.c                              | 19 ++++++----
>  10 files changed, 79 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c =
b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
> index 5fc64e47568a..caa1eaed190d 100644
> --- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
> +++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
> @@ -911,7 +911,7 @@ static int csk_wait_memory(struct chtls_dev *cdev,
>                            struct sock *sk, long *timeo_p)
>  {
>         DEFINE_WAIT_FUNC(wait, woken_wake_function);
> -       int err =3D 0;
> +       int ret, err =3D 0;
>         long current_timeo;
>         long vm_wait =3D 0;
>         bool noblock;
> @@ -942,10 +942,13 @@ static int csk_wait_memory(struct chtls_dev *cdev,
>
>                 set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
>                 sk->sk_write_pending++;
> -               sk_wait_event(sk, &current_timeo, sk->sk_err ||
> -                             (sk->sk_shutdown & SEND_SHUTDOWN) ||
> -                             (csk_mem_free(cdev, sk) && !vm_wait), &wait=
);
> +               ret =3D sk_wait_event(sk, &current_timeo, sk->sk_err ||
> +                                   (sk->sk_shutdown & SEND_SHUTDOWN) ||
> +                                   (csk_mem_free(cdev, sk) && !vm_wait),
> +                                   &wait);
>                 sk->sk_write_pending--;
> +               if (ret < 0)
> +                       goto do_error;
>
>                 if (vm_wait) {
>                         vm_wait -=3D current_timeo;
> @@ -1348,6 +1351,7 @@ static int chtls_pt_recvmsg(struct sock *sk, struct=
 msghdr *msg, size_t len,
>         int copied =3D 0;
>         int target;
>         long timeo;
> +       int ret;
>
>         buffers_freed =3D 0;
>
> @@ -1423,7 +1427,11 @@ static int chtls_pt_recvmsg(struct sock *sk, struc=
t msghdr *msg, size_t len,
>                 if (copied >=3D target)
>                         break;
>                 chtls_cleanup_rbuf(sk, copied);
> -               sk_wait_data(sk, &timeo, NULL);
> +               ret =3D sk_wait_data(sk, &timeo, NULL);
> +               if (ret < 0) {
> +                       copied =3D copied ? : ret;
> +                       goto unlock;
> +               }
>                 continue;
>  found_ok_skb:
>                 if (!skb->len) {
> @@ -1518,6 +1526,8 @@ static int chtls_pt_recvmsg(struct sock *sk, struct=
 msghdr *msg, size_t len,
>
>         if (buffers_freed)
>                 chtls_cleanup_rbuf(sk, copied);
> +
> +unlock:
>         release_sock(sk);
>         return copied;
>  }
> @@ -1534,6 +1544,7 @@ static int peekmsg(struct sock *sk, struct msghdr *=
msg,
>         int copied =3D 0;
>         size_t avail;          /* amount of available data in current skb=
 */
>         long timeo;
> +       int ret;
>
>         lock_sock(sk);
>         timeo =3D sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
> @@ -1585,7 +1596,11 @@ static int peekmsg(struct sock *sk, struct msghdr =
*msg,
>                         release_sock(sk);
>                         lock_sock(sk);
>                 } else {
> -                       sk_wait_data(sk, &timeo, NULL);
> +                       ret =3D sk_wait_data(sk, &timeo, NULL);
> +                       if (ret < 0) {
> +                               copied =3D ret;

   if (!copied)
      copied =3D ret;

> +                               break;
> +                       }
>                 }
>
>                 if (unlikely(peek_seq !=3D tp->copied_seq)) {
> @@ -1656,6 +1671,7 @@ int chtls_recvmsg(struct sock *sk, struct msghdr *m=
sg, size_t len,
>         int copied =3D 0;
>         long timeo;
>         int target;             /* Read at least this many bytes */
> +       int ret;
>
>         buffers_freed =3D 0;
>
> @@ -1747,7 +1763,11 @@ int chtls_recvmsg(struct sock *sk, struct msghdr *=
msg, size_t len,
>                 if (copied >=3D target)
>                         break;
>                 chtls_cleanup_rbuf(sk, copied);
> -               sk_wait_data(sk, &timeo, NULL);
> +               ret =3D sk_wait_data(sk, &timeo, NULL);
> +               if (ret < 0) {
> +                       copied =3D copied ? : ret;
> +                       goto unlock;
> +               }
>                 continue;
>
>  found_ok_skb:
> @@ -1816,6 +1836,7 @@ int chtls_recvmsg(struct sock *sk, struct msghdr *m=
sg, size_t len,
>         if (buffers_freed)
>                 chtls_cleanup_rbuf(sk, copied);
>
> +unlock:
>         release_sock(sk);
>         return copied;
>  }
> diff --git a/include/net/sock.h b/include/net/sock.h
> index b770261fbdaf..92f7ea62a915 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -336,7 +336,7 @@ struct sk_filter;
>    *    @sk_cgrp_data: cgroup data for this cgroup
>    *    @sk_memcg: this socket's memory cgroup association
>    *    @sk_write_pending: a write to stream socket waits to start
> -  *    @sk_wait_pending: number of threads blocked on this socket
> +  *    @sk_disconnects: number of disconnect operations performed on thi=
s sock
>    *    @sk_state_change: callback to indicate change in the state of the=
 sock
>    *    @sk_data_ready: callback to indicate there is data to be processe=
d
>    *    @sk_write_space: callback to indicate there is bf sending space a=
vailable
> @@ -429,7 +429,7 @@ struct sock {
>         unsigned int            sk_napi_id;
>  #endif
>         int                     sk_rcvbuf;
> -       int                     sk_wait_pending;
> +       int                     sk_disconnects;
>
>         struct sk_filter __rcu  *sk_filter;
>         union {
> @@ -1189,8 +1189,7 @@ static inline void sock_rps_reset_rxhash(struct soc=
k *sk)
>  }
>
>  #define sk_wait_event(__sk, __timeo, __condition, __wait)              \
> -       ({      int __rc;                                               \
> -               __sk->sk_wait_pending++;                                \
> +       ({      int __rc, __dis =3D __sk->sk_disconnects;                =
 \
>                 release_sock(__sk);                                     \
>                 __rc =3D __condition;                                    =
 \
>                 if (!__rc) {                                            \
> @@ -1200,8 +1199,7 @@ static inline void sock_rps_reset_rxhash(struct soc=
k *sk)
>                 }                                                       \
>                 sched_annotate_sleep();                                 \
>                 lock_sock(__sk);                                        \
> -               __sk->sk_wait_pending--;                                \
> -               __rc =3D __condition;                                    =
 \
> +               __rc =3D __dis =3D=3D __sk->sk_disconnects ? __condition =
: -EPIPE; \
>                 __rc;                                                   \
>         })
>
> diff --git a/net/core/stream.c b/net/core/stream.c
> index f5c4e47df165..96fbcb9bbb30 100644
> --- a/net/core/stream.c
> +++ b/net/core/stream.c
> @@ -117,7 +117,7 @@ EXPORT_SYMBOL(sk_stream_wait_close);
>   */
>  int sk_stream_wait_memory(struct sock *sk, long *timeo_p)
>  {
> -       int err =3D 0;
> +       int ret, err =3D 0;
>         long vm_wait =3D 0;
>         long current_timeo =3D *timeo_p;
>         DEFINE_WAIT_FUNC(wait, woken_wake_function);
> @@ -142,11 +142,13 @@ int sk_stream_wait_memory(struct sock *sk, long *ti=
meo_p)
>
>                 set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
>                 sk->sk_write_pending++;
> -               sk_wait_event(sk, &current_timeo, READ_ONCE(sk->sk_err) |=
|
> -                                                 (READ_ONCE(sk->sk_shutd=
own) & SEND_SHUTDOWN) ||
> -                                                 (sk_stream_memory_free(=
sk) &&
> -                                                 !vm_wait), &wait);
> +               ret =3D sk_wait_event(sk, &current_timeo, READ_ONCE(sk->s=
k_err) ||
> +                                   (READ_ONCE(sk->sk_shutdown) & SEND_SH=
UTDOWN) ||
> +                                   (sk_stream_memory_free(sk) && !vm_wai=
t),
> +                                   &wait);
>                 sk->sk_write_pending--;
> +               if (ret < 0)
> +                       goto do_error;
>
>                 if (vm_wait) {
>                         vm_wait -=3D current_timeo;
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index 3d2e30e20473..a7aa082f9a4c 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -597,7 +597,6 @@ static long inet_wait_for_connect(struct sock *sk, lo=
ng timeo, int writebias)
>
>         add_wait_queue(sk_sleep(sk), &wait);
>         sk->sk_write_pending +=3D writebias;
> -       sk->sk_wait_pending++;


>
>         /* Basic assumption: if someone sets sk->sk_err, he _must_
>          * change state of the socket from TCP_SYN_*.
> @@ -613,7 +612,6 @@ static long inet_wait_for_connect(struct sock *sk, lo=
ng timeo, int writebias)
>         }
>         remove_wait_queue(sk_sleep(sk), &wait);
>         sk->sk_write_pending -=3D writebias;
> -       sk->sk_wait_pending--;
>         return timeo;
>  }
>
> @@ -696,6 +694,7 @@ int __inet_stream_connect(struct socket *sock, struct=
 sockaddr *uaddr,
>                 int writebias =3D (sk->sk_protocol =3D=3D IPPROTO_TCP) &&
>                                 tcp_sk(sk)->fastopen_req &&
>                                 tcp_sk(sk)->fastopen_req->data ? 1 : 0;
> +               int dis =3D sk->sk_disconnects;
>
>                 /* Error code is set above */
>                 if (!timeo || !inet_wait_for_connect(sk, timeo, writebias=
))
> @@ -704,6 +703,11 @@ int __inet_stream_connect(struct socket *sock, struc=
t sockaddr *uaddr,
>                 err =3D sock_intr_errno(timeo);
>                 if (signal_pending(current))
>                         goto out;
> +
> +               if (dis !=3D sk->sk_disconnects) {
> +                       err =3D -EPIPE;
> +                       goto out;
> +               }
>         }
>
>         /* Connection was closed by RST, timeout, ICMP error
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_s=
ock.c
> index aeebe8816689..394a498c2823 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -1145,7 +1145,6 @@ struct sock *inet_csk_clone_lock(const struct sock =
*sk,
>         if (newsk) {
>                 struct inet_connection_sock *newicsk =3D inet_csk(newsk);
>
> -               newsk->sk_wait_pending =3D 0;
>                 inet_sk_set_state(newsk, TCP_SYN_RECV);
>                 newicsk->icsk_bind_hash =3D NULL;
>                 newicsk->icsk_bind2_hash =3D NULL;
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 3f66cdeef7de..368f0d16c817 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -831,7 +831,9 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *=
ppos,
>                          */
>                         if (!skb_queue_empty(&sk->sk_receive_queue))
>                                 break;
> -                       sk_wait_data(sk, &timeo, NULL);
> +                       ret =3D sk_wait_data(sk, &timeo, NULL);
> +                       if (ret < 0)
> +                               break;
>                         if (signal_pending(current)) {
>                                 ret =3D sock_intr_errno(timeo);
>                                 break;
> @@ -2442,7 +2444,11 @@ static int tcp_recvmsg_locked(struct sock *sk, str=
uct msghdr *msg, size_t len,
>                         __sk_flush_backlog(sk);
>                 } else {
>                         tcp_cleanup_rbuf(sk, copied);
> -                       sk_wait_data(sk, &timeo, last);
> +                       err =3D sk_wait_data(sk, &timeo, last);
> +                       if (err < 0) {
> +                               err =3D copied ? : err;
> +                               goto out;
> +                       }
>                 }
>
>                 if ((flags & MSG_PEEK) &&
> @@ -2966,12 +2972,6 @@ int tcp_disconnect(struct sock *sk, int flags)
>         int old_state =3D sk->sk_state;
>         u32 seq;
>
> -       /* Deny disconnect if other threads are blocked in sk_wait_event(=
)
> -        * or inet_wait_for_connect().
> -        */
> -       if (sk->sk_wait_pending)
> -               return -EBUSY;
> -
>         if (old_state !=3D TCP_CLOSE)
>                 tcp_set_state(sk, TCP_CLOSE);
>
> @@ -3092,6 +3092,7 @@ int tcp_disconnect(struct sock *sk, int flags)
>                 sk->sk_frag.offset =3D 0;
>         }
>         sk_error_report(sk);
> +       sk->sk_disconnects++;

Should we perform this generically, from the caller ?

>         return 0;
>  }
>  EXPORT_SYMBOL(tcp_disconnect);
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index 327268203001..ba2e92188124 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -307,6 +307,8 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>                 }
>
>                 data =3D tcp_msg_wait_data(sk, psock, timeo);
> +               if (data < 0)
> +                       return data;
>                 if (data && !sk_psock_queue_empty(psock))
>                         goto msg_bytes_ready;
>                 copied =3D -EAGAIN;
> @@ -351,6 +353,8 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len,
>
>                 timeo =3D sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
>                 data =3D tcp_msg_wait_data(sk, psock, timeo);
> +               if (data < 0)
> +                       return data;
>                 if (data) {
>                         if (!sk_psock_queue_empty(psock))
>                                 goto msg_bytes_ready;
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index e252539b1e19..22dd27cce4e6 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3098,12 +3098,6 @@ static int mptcp_disconnect(struct sock *sk, int f=
lags)
>  {
>         struct mptcp_sock *msk =3D mptcp_sk(sk);
>
> -       /* Deny disconnect if other threads are blocked in sk_wait_event(=
)
> -        * or inet_wait_for_connect().
> -        */
> -       if (sk->sk_wait_pending)
> -               return -EBUSY;
> -
>         /* We are on the fastopen error path. We can't call straight into=
 the
>          * subflows cleanup code due to lock nesting (we are already unde=
r
>          * msk->firstsocket lock).
> @@ -3144,6 +3138,7 @@ static int mptcp_disconnect(struct sock *sk, int fl=
ags)
>
>         WRITE_ONCE(sk->sk_shutdown, 0);
>         sk_error_report(sk);
> +       sk->sk_disconnects++;

This would avoid touching all protocols ;)

>         return 0;
>  }
>

Thanks !

