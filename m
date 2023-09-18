Return-Path: <netdev+bounces-34381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C40FD7A3F9C
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 05:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 779652814A9
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 03:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6486215C0;
	Mon, 18 Sep 2023 03:11:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEEB15A8
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 03:11:28 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A52ED
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 20:11:24 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-530196c780dso4474678a12.1
        for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 20:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695006683; x=1695611483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9xXA4/MiyXBdOAxpoDrdHfzl9KflbCD7w+4HXa2PiI=;
        b=qc0QBM5xfN2M39+6C7/e1McM4AANIyR0uGrqWGgZk7SJlOJOTvB8FUzu1O/pYw07lx
         EozHQWbKLvnTzN8Q188Cz6TfMBhahU7jZl896CHbcW2d6b51HLvT3v9Z68Opcp3+rL8N
         EV9J5E2KqHmHPnAXTXx8agPIg7O7ALBJTrqwQ5+2vpGy3tAbUgVF388VLGNrdxsSTGll
         M7MPh8LMyUxvv2C/KMZc0GUDwUpRH+dPuKVA6QlSgZ+Z2jtBU4BPiJ47uGQowqicw7J/
         88/eDxDRrEA1ANhhaWTvSi/Dmu1NfPmseE3hlYh5vY2m3HWNOiWoCgJcNmdKUcsf72sx
         8dEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695006683; x=1695611483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9xXA4/MiyXBdOAxpoDrdHfzl9KflbCD7w+4HXa2PiI=;
        b=UIvai+3qoIulSFlMlkhfpu8DiZI5WIiGJ7493Z8ahTNfVikBcw4gLoNF0fbqC2RU75
         Cak8TK2oS3lMuo/1E/E5Ty39UKi5e5gArbmHFqcrSo9W8GnNOAWWZWs3Fidf2aKnoSBf
         NH/q8iZJSp48L86Dbx8depET61LtHiKJHP1uNteKF1sfsqvqkI5MN2B8Kk8mA3fJX+kR
         SJnGaClNnG7WwucWXIyEmU7frsdyuFr/AO1eOnVMyix0nyFfVzw1k1nyPZh+haZz2ABv
         6XlEno5raMmJ0ALGc6ozEc6DnjzZ500ypTDm8PeyHyhQgeB6K4VxZc3glO4e1/XUrujb
         KavA==
X-Gm-Message-State: AOJu0YzQAQR60s3IRiRKWT/4wQwrshJbQ7u3lV4tllpW9nvCtxXhOD60
	nQD/p6eATM3H6rPtquBxHjAoYXBkxt7iWD9trpGo9A==
X-Google-Smtp-Source: AGHT+IFjL+iiFbHdO3d/W3p7KZsU2LLoHR5YK3d0TmKfIf3DLhhjvOnRUWaiH8iaJFaiCuRgftD2X5YRr7C+37kCFJA=
X-Received: by 2002:a17:906:23f1:b0:9ad:e18a:734 with SMTP id
 j17-20020a17090623f100b009ade18a0734mr5302755ejg.26.1695006683148; Sun, 17
 Sep 2023 20:11:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918025021.4078252-1-jrife@google.com> <20230918025021.4078252-3-jrife@google.com>
In-Reply-To: <20230918025021.4078252-3-jrife@google.com>
From: Jordan Rife <jrife@google.com>
Date: Sun, 17 Sep 2023 20:11:11 -0700
Message-ID: <CADKFtnQ4Z3r98n7cGmwW4noXTyKjJcRGH3AqEMfZj7jFq--C8g@mail.gmail.com>
Subject: Re: [PATCH net v2 3/3] net: prevent address rewrite in kernel_bind()
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org
Cc: dborkman@kernel.org, willemdebruijn.kernel@gmail.com, 
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com, 
	christoph.boehmwalder@linbit.com, axboe@kernel.dk, airlied@redhat.com, 
	chengyou@linux.alibaba.com, kaishen@linux.alibaba.com, jgg@ziepe.ca, 
	leon@kernel.org, bmt@zurich.ibm.com, isdn@linux-pingi.de, ccaulfie@redhat.com, 
	teigland@redhat.com, mark@fasheh.com, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, sfrench@samba.org, pc@manguebit.com, 
	lsahlber@redhat.com, sprasad@microsoft.com, tom@talpey.com, 
	horms@verge.net.au, ja@ssi.bg, pablo@netfilter.org, kadlec@netfilter.org, 
	fw@strlen.de, santosh.shilimkar@oracle.com
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

- DRBD DRIVER
- BLOCK LAYER
- AGPGART DRIVER
- ALIBABA ELASTIC RDMA DRIVER
- INFINIBAND SUBSYSTEM
- SOFT-IWARP DRIVER (siw)
- ISDN/mISDN SUBSYSTEM
- DISTRIBUTED LOCK MANAGER (DLM)
- ORACLE CLUSTER FILESYSTEM 2 (OCFS2)
- COMMON INTERNET FILE SYSTEM CLIENT (CIFS and SMB3)
- IPVS
- NETFILTER
- RDS - RELIABLE DATAGRAM SOCKETS

On Sun, Sep 17, 2023 at 7:50=E2=80=AFPM Jordan Rife <jrife@google.com> wrot=
e:
>
> Similar to the change in commit 0bdf399342c5("net: Avoid address
> overwrite in kernel_connect"), BPF hooks run on bind may rewrite the
> address passed to kernel_bind(). This change
>
> 1) Makes a copy of the bind address in kernel_bind() to insulate
>    callers.
> 2) Replaces direct calls to sock->ops->bind() with kernel_bind()
>
> Link: https://lore.kernel.org/netdev/20230912013332.2048422-1-jrife@googl=
e.com/
>
> Signed-off-by: Jordan Rife <jrife@google.com>
> ---
> v1->v2: Split up original patch into patch series. Insulate
>         sock->ops->bind() calls with kernel_bind().
>
>  drivers/block/drbd/drbd_receiver.c     |  4 ++--
>  drivers/char/agp/alpha-agp.c           |  2 +-
>  drivers/infiniband/hw/erdma/erdma_cm.c |  6 +++---
>  drivers/infiniband/sw/siw/siw_cm.c     | 10 +++++-----
>  drivers/isdn/mISDN/l1oip_core.c        |  4 ++--
>  fs/dlm/lowcomms.c                      |  7 +++----
>  fs/ocfs2/cluster/tcp.c                 |  6 +++---
>  fs/smb/client/connect.c                |  6 +++---
>  net/netfilter/ipvs/ip_vs_sync.c        |  4 ++--
>  net/rds/tcp_connect.c                  |  2 +-
>  net/rds/tcp_listen.c                   |  2 +-
>  net/socket.c                           |  7 +++++++
>  12 files changed, 33 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd=
_receiver.c
> index 9b2660e990a98..752759ed22b8c 100644
> --- a/drivers/block/drbd/drbd_receiver.c
> +++ b/drivers/block/drbd/drbd_receiver.c
> @@ -638,7 +638,7 @@ static struct socket *drbd_try_connect(struct drbd_co=
nnection *connection)
>         *  a free one dynamically.
>         */
>         what =3D "bind before connect";
> -       err =3D sock->ops->bind(sock, (struct sockaddr *) &src_in6, my_ad=
dr_len);
> +       err =3D kernel_bind(sock, (struct sockaddr *)&src_in6, my_addr_le=
n);
>         if (err < 0)
>                 goto out;
>
> @@ -725,7 +725,7 @@ static int prepare_listen_socket(struct drbd_connecti=
on *connection, struct acce
>         drbd_setbufsize(s_listen, sndbuf_size, rcvbuf_size);
>
>         what =3D "bind before listen";
> -       err =3D s_listen->ops->bind(s_listen, (struct sockaddr *)&my_addr=
, my_addr_len);
> +       err =3D kernel_bind(s_listen, (struct sockaddr *)&my_addr, my_add=
r_len);
>         if (err < 0)
>                 goto out;
>
> diff --git a/drivers/char/agp/alpha-agp.c b/drivers/char/agp/alpha-agp.c
> index c9bf2c2198418..f251fedfb4840 100644
> --- a/drivers/char/agp/alpha-agp.c
> +++ b/drivers/char/agp/alpha-agp.c
> @@ -96,7 +96,7 @@ static int alpha_core_agp_insert_memory(struct agp_memo=
ry *mem, off_t pg_start,
>         if ((pg_start + mem->page_count) > num_entries)
>                 return -EINVAL;
>
> -       status =3D agp->ops->bind(agp, pg_start, mem);
> +       status =3D kernel_bind(agp, pg_start, mem);
>         mb();
>         alpha_core_agp_tlbflush(mem);
>
> diff --git a/drivers/infiniband/hw/erdma/erdma_cm.c b/drivers/infiniband/=
hw/erdma/erdma_cm.c
> index e2b89e7bbe2b8..674702d159c29 100644
> --- a/drivers/infiniband/hw/erdma/erdma_cm.c
> +++ b/drivers/infiniband/hw/erdma/erdma_cm.c
> @@ -990,7 +990,7 @@ static int kernel_bindconnect(struct socket *s, struc=
t sockaddr *laddr,
>         int ret;
>
>         sock_set_reuseaddr(s->sk);
> -       ret =3D s->ops->bind(s, laddr, laddrlen);
> +       ret =3D kernel_bind(s, laddr, laddrlen);
>         if (ret)
>                 return ret;
>         ret =3D kernel_connect(s, raddr, raddrlen, flags);
> @@ -1309,8 +1309,8 @@ int erdma_create_listen(struct iw_cm_id *id, int ba=
cklog)
>         if (ipv4_is_zeronet(laddr->sin_addr.s_addr))
>                 s->sk->sk_bound_dev_if =3D dev->netdev->ifindex;
>
> -       ret =3D s->ops->bind(s, (struct sockaddr *)laddr,
> -                          sizeof(struct sockaddr_in));
> +       ret =3D kernel_bind(s, (struct sockaddr *)laddr,
> +                         sizeof(struct sockaddr_in));
>         if (ret)
>                 goto error;
>
> diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/s=
iw/siw_cm.c
> index 05624f424153e..d05e0eeee9244 100644
> --- a/drivers/infiniband/sw/siw/siw_cm.c
> +++ b/drivers/infiniband/sw/siw/siw_cm.c
> @@ -1324,7 +1324,7 @@ static int kernel_bindconnect(struct socket *s, str=
uct sockaddr *laddr,
>                         return rv;
>         }
>
> -       rv =3D s->ops->bind(s, laddr, size);
> +       rv =3D kernel_bind(s, laddr, size);
>         if (rv < 0)
>                 return rv;
>
> @@ -1793,8 +1793,8 @@ int siw_create_listen(struct iw_cm_id *id, int back=
log)
>                 if (ipv4_is_zeronet(laddr->sin_addr.s_addr))
>                         s->sk->sk_bound_dev_if =3D sdev->netdev->ifindex;
>
> -               rv =3D s->ops->bind(s, (struct sockaddr *)laddr,
> -                                 sizeof(struct sockaddr_in));
> +               rv =3D kernel_bind(s, (struct sockaddr *)laddr,
> +                                sizeof(struct sockaddr_in));
>         } else {
>                 struct sockaddr_in6 *laddr =3D &to_sockaddr_in6(id->local=
_addr);
>
> @@ -1811,8 +1811,8 @@ int siw_create_listen(struct iw_cm_id *id, int back=
log)
>                 if (ipv6_addr_any(&laddr->sin6_addr))
>                         s->sk->sk_bound_dev_if =3D sdev->netdev->ifindex;
>
> -               rv =3D s->ops->bind(s, (struct sockaddr *)laddr,
> -                                 sizeof(struct sockaddr_in6));
> +               rv =3D kernel_bind(s, (struct sockaddr *)laddr,
> +                                sizeof(struct sockaddr_in6));
>         }
>         if (rv) {
>                 siw_dbg(id->device, "socket bind error: %d\n", rv);
> diff --git a/drivers/isdn/mISDN/l1oip_core.c b/drivers/isdn/mISDN/l1oip_c=
ore.c
> index f010b35a05313..681147e1fc843 100644
> --- a/drivers/isdn/mISDN/l1oip_core.c
> +++ b/drivers/isdn/mISDN/l1oip_core.c
> @@ -675,8 +675,8 @@ l1oip_socket_thread(void *data)
>         hc->sin_remote.sin_port =3D htons((unsigned short)hc->remoteport)=
;
>
>         /* bind to incoming port */
> -       if (socket->ops->bind(socket, (struct sockaddr *)&hc->sin_local,
> -                             sizeof(hc->sin_local))) {
> +       if (kernel_bind(socket, (struct sockaddr *)&hc->sin_local,
> +                       sizeof(hc->sin_local))) {
>                 printk(KERN_ERR "%s: Failed to bind socket to port %d.\n"=
,
>                        __func__, hc->localport);
>                 ret =3D -EINVAL;
> diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
> index 1cf796b97eb65..73ab179833fbd 100644
> --- a/fs/dlm/lowcomms.c
> +++ b/fs/dlm/lowcomms.c
> @@ -1805,8 +1805,7 @@ static int dlm_tcp_bind(struct socket *sock)
>         memcpy(&src_addr, &dlm_local_addr[0], sizeof(src_addr));
>         make_sockaddr(&src_addr, 0, &addr_len);
>
> -       result =3D sock->ops->bind(sock, (struct sockaddr *)&src_addr,
> -                                addr_len);
> +       result =3D kernel_bind(sock, (struct sockaddr *)&src_addr, addr_l=
en);
>         if (result < 0) {
>                 /* This *may* not indicate a critical error */
>                 log_print("could not bind for connect: %d", result);
> @@ -1850,8 +1849,8 @@ static int dlm_tcp_listen_bind(struct socket *sock)
>
>         /* Bind to our port */
>         make_sockaddr(&dlm_local_addr[0], dlm_config.ci_tcp_port, &addr_l=
en);
> -       return sock->ops->bind(sock, (struct sockaddr *)&dlm_local_addr[0=
],
> -                              addr_len);
> +       return kernel_bind(sock, (struct sockaddr *)&dlm_local_addr[0],
> +                          addr_len);
>  }
>
>  static const struct dlm_proto_ops dlm_tcp_ops =3D {
> diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
> index ead7c287ff373..3a4a7a521476d 100644
> --- a/fs/ocfs2/cluster/tcp.c
> +++ b/fs/ocfs2/cluster/tcp.c
> @@ -1614,8 +1614,8 @@ static void o2net_start_connect(struct work_struct =
*work)
>         myaddr.sin_addr.s_addr =3D mynode->nd_ipv4_address;
>         myaddr.sin_port =3D htons(0); /* any port */
>
> -       ret =3D sock->ops->bind(sock, (struct sockaddr *)&myaddr,
> -                             sizeof(myaddr));
> +       ret =3D kernel_bind(sock, (struct sockaddr *)&myaddr,
> +                         sizeof(myaddr));
>         if (ret) {
>                 mlog(ML_ERROR, "bind failed with %d at address %pI4\n",
>                      ret, &mynode->nd_ipv4_address);
> @@ -1998,7 +1998,7 @@ static int o2net_open_listening_sock(__be32 addr, _=
_be16 port)
>         INIT_WORK(&o2net_listen_work, o2net_accept_many);
>
>         sock->sk->sk_reuse =3D SK_CAN_REUSE;
> -       ret =3D sock->ops->bind(sock, (struct sockaddr *)&sin, sizeof(sin=
));
> +       ret =3D kernel_bind(sock, (struct sockaddr *)&sin, sizeof(sin));
>         if (ret < 0) {
>                 printk(KERN_ERR "o2net: Error %d while binding socket at =
"
>                        "%pI4:%u\n", ret, &addr, ntohs(port));
> diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
> index b7764cd57e035..6dcc1cd41b8c5 100644
> --- a/fs/smb/client/connect.c
> +++ b/fs/smb/client/connect.c
> @@ -2891,9 +2891,9 @@ bind_socket(struct TCP_Server_Info *server)
>         if (server->srcaddr.ss_family !=3D AF_UNSPEC) {
>                 /* Bind to the specified local IP address */
>                 struct socket *socket =3D server->ssocket;
> -               rc =3D socket->ops->bind(socket,
> -                                      (struct sockaddr *) &server->srcad=
dr,
> -                                      sizeof(server->srcaddr));
> +               rc =3D kernel_bind(socket,
> +                                (struct sockaddr *)&server->srcaddr,
> +                                sizeof(server->srcaddr));
>                 if (rc < 0) {
>                         struct sockaddr_in *saddr4;
>                         struct sockaddr_in6 *saddr6;
> diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_s=
ync.c
> index 6e4ed1e11a3b7..4174076c66fa7 100644
> --- a/net/netfilter/ipvs/ip_vs_sync.c
> +++ b/net/netfilter/ipvs/ip_vs_sync.c
> @@ -1439,7 +1439,7 @@ static int bind_mcastif_addr(struct socket *sock, s=
truct net_device *dev)
>         sin.sin_addr.s_addr  =3D addr;
>         sin.sin_port         =3D 0;
>
> -       return sock->ops->bind(sock, (struct sockaddr*)&sin, sizeof(sin))=
;
> +       return kernel_bind(sock, (struct sockaddr *)&sin, sizeof(sin));
>  }
>
>  static void get_mcast_sockaddr(union ipvs_sockaddr *sa, int *salen,
> @@ -1546,7 +1546,7 @@ static int make_receive_sock(struct netns_ipvs *ipv=
s, int id,
>
>         get_mcast_sockaddr(&mcast_addr, &salen, &ipvs->bcfg, id);
>         sock->sk->sk_bound_dev_if =3D dev->ifindex;
> -       result =3D sock->ops->bind(sock, (struct sockaddr *)&mcast_addr, =
salen);
> +       result =3D kernel_bind(sock, (struct sockaddr *)&mcast_addr, sale=
n);
>         if (result < 0) {
>                 pr_err("Error binding to the multicast addr\n");
>                 goto error;
> diff --git a/net/rds/tcp_connect.c b/net/rds/tcp_connect.c
> index d788c6d28986f..a0046e99d6df7 100644
> --- a/net/rds/tcp_connect.c
> +++ b/net/rds/tcp_connect.c
> @@ -145,7 +145,7 @@ int rds_tcp_conn_path_connect(struct rds_conn_path *c=
p)
>                 addrlen =3D sizeof(sin);
>         }
>
> -       ret =3D sock->ops->bind(sock, addr, addrlen);
> +       ret =3D kernel_bind(sock, addr, addrlen);
>         if (ret) {
>                 rdsdebug("bind failed with %d at address %pI6c\n",
>                          ret, &conn->c_laddr);
> diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
> index 014fa24418c12..53b3535a1e4a8 100644
> --- a/net/rds/tcp_listen.c
> +++ b/net/rds/tcp_listen.c
> @@ -306,7 +306,7 @@ struct socket *rds_tcp_listen_init(struct net *net, b=
ool isv6)
>                 addr_len =3D sizeof(*sin);
>         }
>
> -       ret =3D sock->ops->bind(sock, (struct sockaddr *)&ss, addr_len);
> +       ret =3D kernel_bind(sock, (struct sockaddr *)&ss, addr_len);
>         if (ret < 0) {
>                 rdsdebug("could not bind %s listener socket: %d\n",
>                          isv6 ? "IPv6" : "IPv4", ret);
> diff --git a/net/socket.c b/net/socket.c
> index b0189b773d130..426e2c72bb3c6 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -3519,6 +3519,13 @@ static long compat_sock_ioctl(struct file *file, u=
nsigned int cmd,
>
>  int kernel_bind(struct socket *sock, struct sockaddr *addr, int addrlen)
>  {
> +       struct sockaddr_storage address;
> +
> +       if (addrlen > sizeof(address))
> +               return -EINVAL;
> +
> +       memcpy(&address, addr, addrlen);
> +
>         return READ_ONCE(sock->ops)->bind(sock, addr, addrlen);
>  }
>  EXPORT_SYMBOL(kernel_bind);
> --
> 2.42.0.459.ge4e396fd5e-goog
>

