Return-Path: <netdev+bounces-34380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5247A3F8E
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 05:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DA521C20902
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 03:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1157D1389;
	Mon, 18 Sep 2023 03:04:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A294136C
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 03:04:46 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48112123
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 20:04:44 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9a9d82d73f9so490468066b.3
        for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 20:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695006283; x=1695611083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtmlNlNGdtcbUqyAkol7IL8wZ3jbuVMuO8O21MgKuds=;
        b=XtnvYMkdepe++ZxL4l8UJ1QIYts0ytOCYUezZawZaAyi5OoWoyFjh7/do+uLXS9+xL
         3eQMcxvWW+48xU6f0tz8mP7VPwngqv9JccInGmqt52VL7//u4zXDlL/v0xFqHQHiHgIO
         C5ra5kQM5qEp+TaN/Qov2SKiid9nxQOtDoJgw49DShVxc9l8zsYewLK+TKQYiJjKZKEM
         HdXdQy3V/00mH2cr8+KDVgGr/u2ryu3bJfpwIScizLX1yQ09/3qPByXsq0Ty7l9A25M7
         menxbaaCLlnhVVaC952+1j5TZ/xcCIFoeUl0WWS5zxmV2ocEmQAA2Fmyv+4aIvlclZf9
         AO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695006283; x=1695611083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CtmlNlNGdtcbUqyAkol7IL8wZ3jbuVMuO8O21MgKuds=;
        b=QZYNYNC01wUtqe3rpTDVYzApJ7DbVhbWuxonRTsjYyQwVqu0AV0GRMO4H6ZKZIHnZy
         w0kAGwA/ol6jbj2wro9bTMNrBPscDLoe0k2bdFDX4GmvjzqiEZsYAxJJPpHFglg9O+0H
         HPZ7DhuBNYNIFXLLgLSrgz/5vxwRT+WEBBnoiUcnlnh9LeCsdMMs08ifjfAaG1/pHDGC
         gFhlFaUJ6DMJSg/flX4fNAwB7QPrenlAQUs28Qv5S0bHW7BBkWMKgbJOMx41LJZPaLoh
         bQGwh5BUSuXA0pqllWMX3a5eYboR6leLvQUq3B0s9yfT0bBOUvMTBZtASvJcMa5S9X5M
         oeLw==
X-Gm-Message-State: AOJu0Yyf2DMcrXXIJvIcmWWlHyE6yba43zRG8e5LatVncQiVM8s3TRlO
	PAZx48pUpSze9yAdFcyMK2YhycWGwdCH0nOIX54aVA==
X-Google-Smtp-Source: AGHT+IEJLqGfYnIBhjSBr9B2Pz/X+4xKw2bIUqgN27XvUjnji+q/CYg6PfkUSTQIK1yR4c4eEqs/hjLXgljD84RAbYg=
X-Received: by 2002:a17:906:32cf:b0:9a2:86a:f9b7 with SMTP id
 k15-20020a17090632cf00b009a2086af9b7mr5916571ejk.59.1695006282582; Sun, 17
 Sep 2023 20:04:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918025021.4078252-1-jrife@google.com>
In-Reply-To: <20230918025021.4078252-1-jrife@google.com>
From: Jordan Rife <jrife@google.com>
Date: Sun, 17 Sep 2023 20:04:31 -0700
Message-ID: <CADKFtnR-tkqQn6217X0Losb5ePFbhJ7B7a+hF24rqYkeHUMm1g@mail.gmail.com>
Subject: Re: [PATCH net v2 1/3] net: replace calls to sock->ops->connect()
 with kernel_connect()
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org
Cc: dborkman@kernel.org, willemdebruijn.kernel@gmail.com, 
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com, 
	christoph.boehmwalder@linbit.com, axboe@kernel.dk, chengyou@linux.alibaba.com, 
	kaishen@linux.alibaba.com, jgg@ziepe.ca, leon@kernel.org, bmt@zurich.ibm.com, 
	ccaulfie@redhat.com, teigland@redhat.com, mark@fasheh.com, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, sfrench@samba.org, pc@manguebit.com, 
	lsahlber@redhat.com, sprasad@microsoft.com, tom@talpey.com, ericvh@kernel.org, 
	lucho@ionkov.net, asmadeus@codewreck.org, linux_oss@crudebyte.com, 
	idryomov@gmail.com, xiubli@redhat.com, jlayton@kernel.org, horms@verge.net.au, 
	ja@ssi.bg, pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de, 
	santosh.shilimkar@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

CC subsystem maintainers:

- DRBD
- BLOCK LAYER:
- INFINIBAND SUBSYSTEM:
- SOFT-IWARP DRIVER:
- DISTRIBUTED LOCK MANAGER (DLM):
- ORACLE CLUSTER FILESYSTEM 2 (OCFS2):
- COMMON INTERNET FILE SYSTEM CLIENT (CIFS and SMB3):
- 9P FILE SYSTEM:
- CEPH COMMON CODE (LIBCEPH):
- IPVS:
- NETFILTER:
- RDS - RELIABLE DATAGRAM SOCKETS:

On Sun, Sep 17, 2023 at 7:50=E2=80=AFPM Jordan Rife <jrife@google.com> wrot=
e:
>
> commit 0bdf399342c5 ("net: Avoid address overwrite in kernel_connect")
> ensured that kernel_connect() will not overwrite the address parameter
> in cases where BPF connect hooks perform an address rewrite. This change
> replaces all direct calls to sock->ops->connect() with kernel_connect()
> to make these call safe.
>
> This patch also introduces a sanity check to kernel_connect() to ensure
> that the addr_length does not exceed the size of sockaddr_storage before
> performing the address copy.
>
> Link: https://lore.kernel.org/netdev/20230912013332.2048422-1-jrife@googl=
e.com/
>
> Signed-off-by: Jordan Rife <jrife@google.com>
> ---
> v1->v2: Split up original patch into patch series. Insulate calls with
>         kernel_connect() instead of pushing address copy deeper into
>         sock->ops->connect().
>
>  drivers/block/drbd/drbd_receiver.c     |  2 +-
>  drivers/infiniband/hw/erdma/erdma_cm.c |  2 +-
>  drivers/infiniband/sw/siw/siw_cm.c     |  2 +-
>  fs/dlm/lowcomms.c                      |  6 +++---
>  fs/ocfs2/cluster/tcp.c                 |  8 ++++----
>  fs/smb/client/connect.c                |  4 ++--
>  net/9p/trans_fd.c                      | 10 +++++-----
>  net/ceph/messenger.c                   |  4 ++--
>  net/netfilter/ipvs/ip_vs_sync.c        |  4 ++--
>  net/rds/tcp_connect.c                  |  2 +-
>  net/socket.c                           |  3 +++
>  11 files changed, 25 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd=
_receiver.c
> index 0c9f54197768d..9b2660e990a98 100644
> --- a/drivers/block/drbd/drbd_receiver.c
> +++ b/drivers/block/drbd/drbd_receiver.c
> @@ -646,7 +646,7 @@ static struct socket *drbd_try_connect(struct drbd_co=
nnection *connection)
>          * stay C_WF_CONNECTION, don't go Disconnecting! */
>         disconnect_on_error =3D 0;
>         what =3D "connect";
> -       err =3D sock->ops->connect(sock, (struct sockaddr *) &peer_in6, p=
eer_addr_len, 0);
> +       err =3D kernel_connect(sock, (struct sockaddr *)&peer_in6, peer_a=
ddr_len, 0);
>
>  out:
>         if (err < 0) {
> diff --git a/drivers/infiniband/hw/erdma/erdma_cm.c b/drivers/infiniband/=
hw/erdma/erdma_cm.c
> index 771059a8eb7d7..e2b89e7bbe2b8 100644
> --- a/drivers/infiniband/hw/erdma/erdma_cm.c
> +++ b/drivers/infiniband/hw/erdma/erdma_cm.c
> @@ -993,7 +993,7 @@ static int kernel_bindconnect(struct socket *s, struc=
t sockaddr *laddr,
>         ret =3D s->ops->bind(s, laddr, laddrlen);
>         if (ret)
>                 return ret;
> -       ret =3D s->ops->connect(s, raddr, raddrlen, flags);
> +       ret =3D kernel_connect(s, raddr, raddrlen, flags);
>         return ret < 0 ? ret : 0;
>  }
>
> diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/s=
iw/siw_cm.c
> index a2605178f4eda..05624f424153e 100644
> --- a/drivers/infiniband/sw/siw/siw_cm.c
> +++ b/drivers/infiniband/sw/siw/siw_cm.c
> @@ -1328,7 +1328,7 @@ static int kernel_bindconnect(struct socket *s, str=
uct sockaddr *laddr,
>         if (rv < 0)
>                 return rv;
>
> -       rv =3D s->ops->connect(s, raddr, size, flags);
> +       rv =3D kernel_connect(s, raddr, size, flags);
>
>         return rv < 0 ? rv : 0;
>  }
> diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
> index f7bc22e74db27..1cf796b97eb65 100644
> --- a/fs/dlm/lowcomms.c
> +++ b/fs/dlm/lowcomms.c
> @@ -1818,7 +1818,7 @@ static int dlm_tcp_bind(struct socket *sock)
>  static int dlm_tcp_connect(struct connection *con, struct socket *sock,
>                            struct sockaddr *addr, int addr_len)
>  {
> -       return sock->ops->connect(sock, addr, addr_len, O_NONBLOCK);
> +       return kernel_connect(sock, addr, addr_len, O_NONBLOCK);
>  }
>
>  static int dlm_tcp_listen_validate(void)
> @@ -1876,12 +1876,12 @@ static int dlm_sctp_connect(struct connection *co=
n, struct socket *sock,
>         int ret;
>
>         /*
> -        * Make sock->ops->connect() function return in specified time,
> +        * Make kernel_connect() function return in specified time,
>          * since O_NONBLOCK argument in connect() function does not work =
here,
>          * then, we should restore the default value of this attribute.
>          */
>         sock_set_sndtimeo(sock->sk, 5);
> -       ret =3D sock->ops->connect(sock, addr, addr_len, 0);
> +       ret =3D kernel_connect(sock, addr, addr_len, 0);
>         sock_set_sndtimeo(sock->sk, 0);
>         return ret;
>  }
> diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
> index 960080753d3bd..ead7c287ff373 100644
> --- a/fs/ocfs2/cluster/tcp.c
> +++ b/fs/ocfs2/cluster/tcp.c
> @@ -1636,10 +1636,10 @@ static void o2net_start_connect(struct work_struc=
t *work)
>         remoteaddr.sin_addr.s_addr =3D node->nd_ipv4_address;
>         remoteaddr.sin_port =3D node->nd_ipv4_port;
>
> -       ret =3D sc->sc_sock->ops->connect(sc->sc_sock,
> -                                       (struct sockaddr *)&remoteaddr,
> -                                       sizeof(remoteaddr),
> -                                       O_NONBLOCK);
> +       ret =3D kernel_connect(sc->sc_sock,
> +                            (struct sockaddr *)&remoteaddr,
> +                            sizeof(remoteaddr),
> +                            O_NONBLOCK);
>         if (ret =3D=3D -EINPROGRESS)
>                 ret =3D 0;
>
> diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
> index 687754791bf0a..b7764cd57e035 100644
> --- a/fs/smb/client/connect.c
> +++ b/fs/smb/client/connect.c
> @@ -3042,8 +3042,8 @@ generic_ip_connect(struct TCP_Server_Info *server)
>                  socket->sk->sk_sndbuf,
>                  socket->sk->sk_rcvbuf, socket->sk->sk_rcvtimeo);
>
> -       rc =3D socket->ops->connect(socket, saddr, slen,
> -                                 server->noblockcnt ? O_NONBLOCK : 0);
> +       rc =3D kernel_connect(socket, saddr, slen,
> +                           server->noblockcnt ? O_NONBLOCK : 0);
>         /*
>          * When mounting SMB root file systems, we do not want to block i=
n
>          * connect. Otherwise bail out and then let cifs_reconnect() perf=
orm
> diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
> index c4015f30f9fa7..225ee8b6d4c5b 100644
> --- a/net/9p/trans_fd.c
> +++ b/net/9p/trans_fd.c
> @@ -1019,9 +1019,9 @@ p9_fd_create_tcp(struct p9_client *client, const ch=
ar *addr, char *args)
>                 }
>         }
>
> -       err =3D READ_ONCE(csocket->ops)->connect(csocket,
> -                                   (struct sockaddr *)&sin_server,
> -                                   sizeof(struct sockaddr_in), 0);
> +       err =3D kernel_connect(csocket,
> +                            (struct sockaddr *)&sin_server,
> +                            sizeof(struct sockaddr_in), 0);
>         if (err < 0) {
>                 pr_err("%s (%d): problem connecting socket to %s\n",
>                        __func__, task_pid_nr(current), addr);
> @@ -1060,8 +1060,8 @@ p9_fd_create_unix(struct p9_client *client, const c=
har *addr, char *args)
>
>                 return err;
>         }
> -       err =3D READ_ONCE(csocket->ops)->connect(csocket, (struct sockadd=
r *)&sun_server,
> -                       sizeof(struct sockaddr_un) - 1, 0);
> +       err =3D kernel_connect(csocket, (struct sockaddr *)&sun_server,
> +                            sizeof(struct sockaddr_un) - 1, 0);
>         if (err < 0) {
>                 pr_err("%s (%d): problem connecting socket: %s: %d\n",
>                        __func__, task_pid_nr(current), addr, err);
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 10a41cd9c5235..3c8b78d9c4d1c 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -459,8 +459,8 @@ int ceph_tcp_connect(struct ceph_connection *con)
>         set_sock_callbacks(sock, con);
>
>         con_sock_state_connecting(con);
> -       ret =3D sock->ops->connect(sock, (struct sockaddr *)&ss, sizeof(s=
s),
> -                                O_NONBLOCK);
> +       ret =3D kernel_connect(sock, (struct sockaddr *)&ss, sizeof(ss),
> +                            O_NONBLOCK);
>         if (ret =3D=3D -EINPROGRESS) {
>                 dout("connect %s EINPROGRESS sk_state =3D %u\n",
>                      ceph_pr_addr(&con->peer_addr),
> diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_s=
ync.c
> index da5af28ff57b5..6e4ed1e11a3b7 100644
> --- a/net/netfilter/ipvs/ip_vs_sync.c
> +++ b/net/netfilter/ipvs/ip_vs_sync.c
> @@ -1505,8 +1505,8 @@ static int make_send_sock(struct netns_ipvs *ipvs, =
int id,
>         }
>
>         get_mcast_sockaddr(&mcast_addr, &salen, &ipvs->mcfg, id);
> -       result =3D sock->ops->connect(sock, (struct sockaddr *) &mcast_ad=
dr,
> -                                   salen, 0);
> +       result =3D kernel_connect(sock, (struct sockaddr *)&mcast_addr,
> +                               salen, 0);
>         if (result < 0) {
>                 pr_err("Error connecting to the multicast addr\n");
>                 goto error;
> diff --git a/net/rds/tcp_connect.c b/net/rds/tcp_connect.c
> index f0c477c5d1db4..d788c6d28986f 100644
> --- a/net/rds/tcp_connect.c
> +++ b/net/rds/tcp_connect.c
> @@ -173,7 +173,7 @@ int rds_tcp_conn_path_connect(struct rds_conn_path *c=
p)
>          * own the socket
>          */
>         rds_tcp_set_callbacks(sock, cp);
> -       ret =3D sock->ops->connect(sock, addr, addrlen, O_NONBLOCK);
> +       ret =3D kernel_connect(sock, addr, addrlen, O_NONBLOCK);
>
>         rdsdebug("connect to address %pI6c returned %d\n", &conn->c_faddr=
, ret);
>         if (ret =3D=3D -EINPROGRESS)
> diff --git a/net/socket.c b/net/socket.c
> index c8b08b32f097e..b2e3700d035a6 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -3572,6 +3572,9 @@ int kernel_connect(struct socket *sock, struct sock=
addr *addr, int addrlen,
>  {
>         struct sockaddr_storage address;
>
> +       if (addrlen > sizeof(address))
> +               return -EINVAL;
> +
>         memcpy(&address, addr, addrlen);
>
>         return READ_ONCE(sock->ops)->connect(sock, (struct sockaddr *)&ad=
dress,
> --
> 2.42.0.459.ge4e396fd5e-goog
>

