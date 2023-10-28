Return-Path: <netdev+bounces-44953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 221D27DA4A7
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 03:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1E471C2103A
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 01:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA19644;
	Sat, 28 Oct 2023 01:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MY/3kcBJ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AE1635
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 01:33:30 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8C9128
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 18:33:27 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507a5edc2ebso736e87.1
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 18:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698456806; x=1699061606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hD4Dx5ozzdMmNAD8U6HhXvW4gubOIekO+rBJvGbrFzs=;
        b=MY/3kcBJDzewinXTXJaEppLLYyUHk6W+m9mVXxk+dNZUhNGQdUwXaEaWe927S6Nk77
         +rhXqBqC4xECQ7nMdImm42fTH1A3wWOZ7QqeO/ICO/T+RtQEQBMWjcASG1+HAzrTaFg8
         9hPN3RGVKccO2ozGkJUvTGaQP9c9o31g/oBzPCM+SqehQ+KTs9fb+nfTnGCipX3DNBHW
         JCMAJUG6OwyBobDDIzdOzCjfb+SeNenq45WlM96OWtYRdhNCCYVOMjK0PjhT6BGhUx1j
         rp5NqkWzU+w9hZDhjS4f9kuK5RNBH2hOTiClpCcb2FNmIxKebK8dwS8hzp+DKMbr3eld
         TdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698456806; x=1699061606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hD4Dx5ozzdMmNAD8U6HhXvW4gubOIekO+rBJvGbrFzs=;
        b=QVAbZKMaUt5qZSvijfR+Ud7fRxLeMYr/bVXOKkNXgHYWut8D7+aY3yOTvbXdn9bALh
         iuhNOu8SFCKapGqLTD8ret7JjEFXnnhMir0usxIcp7YJhA7CRJNPJE9XTx4wFC6cRMYS
         jGGzALLEV7+As/sUmbRQPdqzHosGa/Ms8iWv2ZO16D82f4fmclYTXKAa5/EjbourPmDg
         hKw1mb7ybhOcwQCHRvoDbmmxpTAiskRRvjHMW3K9ZF97+WCZ26R8w+g+zss3lk0k8wBP
         EelbcFzh6mZukUUERHCgyxo+7WtrWzCEHPUz3qI8ZqcfRFf/H/8Kfn46KWteyIeYTaFw
         vDQw==
X-Gm-Message-State: AOJu0Yz1OFrLp8AM78FDlgSMSpGY8Pmvclvth6q9FQuHmqQGRlFUmkYX
	oNkEd5UBsUjIOwdhLsO9cXKRuofd+rw9rm4jbKcatQ==
X-Google-Smtp-Source: AGHT+IGFc8Lp1Fkm06WRyvQcr6x7kq6Ty+qhn4xfIQQR1NLcIlRR8tM+PpKFuxucX3+C8/DRCpdMCW5DYDmXkqbydoA=
X-Received: by 2002:a05:6512:3613:b0:501:a2b9:6046 with SMTP id
 f19-20020a056512361300b00501a2b96046mr18964lfs.7.1698456805660; Fri, 27 Oct
 2023 18:33:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026081959.3477034-1-lixiaoyan@google.com>
 <20231026081959.3477034-6-lixiaoyan@google.com> <CANn89i+YDiE0y=5BmHP2Hzc+ekGVRmajGfCvQDQhft8+cBRoNw@mail.gmail.com>
In-Reply-To: <CANn89i+YDiE0y=5BmHP2Hzc+ekGVRmajGfCvQDQhft8+cBRoNw@mail.gmail.com>
From: Coco Li <lixiaoyan@google.com>
Date: Fri, 27 Oct 2023 18:33:14 -0700
Message-ID: <CADjXwjjDNgsP67HuFtDFV_WjsgWqZu1zkyw2PyDcyE6Bp=+Jow@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 5/6] net-device: reorganize net_device fast
 path variables
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Mubashir Adnan Qureshi <mubashirq@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, 
	Wei Wang <weiwan@google.com>, Pradeep Nemavat <pnemavat@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 2:42=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Oct 26, 2023 at 10:20=E2=80=AFAM Coco Li <lixiaoyan@google.com> w=
rote:
> >
> > Reorganize fast path variables on tx-txrx-rx order
> > Fastpath variables end after npinfo.
> >
> > Below data generated with pahole on x86 architecture.
> >
> > Fast path variables span cache lines before change: 12
> > Fast path variables span cache lines after change: 4
> >
> > Signed-off-by: Coco Li <lixiaoyan@google.com>
> > Suggested-by: Eric Dumazet <edumazet@google.com>
> > Reviewed-by: David Ahern <dsahern@kernel.org>
> > ---
> >  include/linux/netdevice.h | 113 ++++++++++++++++++++------------------
> >  net/core/dev.c            |  51 +++++++++++++++++
> >  2 files changed, 111 insertions(+), 53 deletions(-)
> >
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index b8bf669212cce..26c4d57451bf0 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -2076,6 +2076,66 @@ enum netdev_ml_priv_type {
> >   */
> >
> >  struct net_device {
> > +       /* Cacheline organization can be found documented in
> > +        * Documentation/networking/net_cachelines/net_device.rst.
> > +        * Please update the document when adding new fields.
> > +        */
> > +
> > +       /* TX read-mostly hotpath */
> > +       __cacheline_group_begin(net_device_read);
>
> This should be net_device_write ? Or perhaps simply tx ?
>
>
> > +       unsigned long long      priv_flags;
> > +       const struct net_device_ops *netdev_ops;
> > +       const struct header_ops *header_ops;
> > +       struct netdev_queue     *_tx;
> > +       unsigned int            real_num_tx_queues;
> > +       unsigned int            gso_max_size;
> > +       unsigned int            gso_ipv4_max_size;
> > +       u16                     gso_max_segs;
> > +       s16                     num_tc;
> > +       /* Note : dev->mtu is often read without holding a lock.
> > +        * Writers usually hold RTNL.
> > +        * It is recommended to use READ_ONCE() to annotate the reads,
> > +        * and to use WRITE_ONCE() to annotate the writes.
> > +        */
> > +       unsigned int            mtu;
> > +       unsigned short          needed_headroom;
> > +       struct netdev_tc_txq    tc_to_txq[TC_MAX_QUEUE];
> > +#ifdef CONFIG_XPS
> > +       struct xps_dev_maps __rcu *xps_maps[XPS_MAPS_MAX];
> > +#endif
> > +#ifdef CONFIG_NETFILTER_EGRESS
> > +       struct nf_hook_entries __rcu *nf_hooks_egress;
> > +#endif
> > +#ifdef CONFIG_NET_XGRESS
> > +       struct bpf_mprog_entry __rcu *tcx_egress;
> > +#endif
> > +
>  __cacheline_group_end(tx);
>
>  __cacheline_group_begin(txrx);
>
>
> > +       /* TXRX read-mostly hotpath */
> > +       unsigned int            flags;
> > +       unsigned short          hard_header_len;
> > +       netdev_features_t       features;
> > +       struct inet6_dev __rcu  *ip6_ptr;
> > +
>
>  __cacheline_group_end(txrx);
>
>  __cacheline_group_begin(rx);
>
> > +       /* RX read-mostly hotpath */
> > +       struct list_head        ptype_specific;
> > +       int                     ifindex;
> > +       unsigned int            real_num_rx_queues;
> > +       struct netdev_rx_queue  *_rx;
> > +       unsigned long           gro_flush_timeout;
> > +       int                     napi_defer_hard_irqs;
> > +       unsigned int            gro_max_size;
> > +       unsigned int            gro_ipv4_max_size;
> > +       rx_handler_func_t __rcu *rx_handler;
> > +       void __rcu              *rx_handler_data;
> > +       possible_net_t                  nd_net;
> > +#ifdef CONFIG_NETPOLL
> > +       struct netpoll_info __rcu       *npinfo;
> > +#endif
> > +#ifdef CONFIG_NET_XGRESS
> > +       struct bpf_mprog_entry __rcu *tcx_ingress;
> > +#endif
> > +       __cacheline_group_end(net_device_read);
> > +
> >         char                    name[IFNAMSIZ];
> >         struct netdev_name_node *name_node;
> >         struct dev_ifalias      __rcu *ifalias;
> > @@ -2100,7 +2160,6 @@ struct net_device {
> >         struct list_head        unreg_list;
> >         struct list_head        close_list;
> >         struct list_head        ptype_all;
> > -       struct list_head        ptype_specific;
> >
> >         struct {
> >                 struct list_head upper;
> > @@ -2108,25 +2167,12 @@ struct net_device {
> >         } adj_list;
> >
> >         /* Read-mostly cache-line for fast-path access */
> > -       unsigned int            flags;
> >         xdp_features_t          xdp_features;
> > -       unsigned long long      priv_flags;
> > -       const struct net_device_ops *netdev_ops;
> >         const struct xdp_metadata_ops *xdp_metadata_ops;
> > -       int                     ifindex;
> >         unsigned short          gflags;
> > -       unsigned short          hard_header_len;
> >
> > -       /* Note : dev->mtu is often read without holding a lock.
> > -        * Writers usually hold RTNL.
> > -        * It is recommended to use READ_ONCE() to annotate the reads,
> > -        * and to use WRITE_ONCE() to annotate the writes.
> > -        */
> > -       unsigned int            mtu;
> > -       unsigned short          needed_headroom;
> >         unsigned short          needed_tailroom;
> >
> > -       netdev_features_t       features;
> >         netdev_features_t       hw_features;
> >         netdev_features_t       wanted_features;
> >         netdev_features_t       vlan_features;
> > @@ -2170,8 +2216,6 @@ struct net_device {
> >         const struct tlsdev_ops *tlsdev_ops;
> >  #endif
> >
> > -       const struct header_ops *header_ops;
> > -
> >         unsigned char           operstate;
> >         unsigned char           link_mode;
> >
> > @@ -2212,9 +2256,7 @@ struct net_device {
> >
> >
> >         /* Protocol-specific pointers */
> > -
> >         struct in_device __rcu  *ip_ptr;
> > -       struct inet6_dev __rcu  *ip6_ptr;
> >  #if IS_ENABLED(CONFIG_VLAN_8021Q)
> >         struct vlan_info __rcu  *vlan_info;
> >  #endif
> > @@ -2249,26 +2291,14 @@ struct net_device {
> >         /* Interface address info used in eth_type_trans() */
> >         const unsigned char     *dev_addr;
> >
> > -       struct netdev_rx_queue  *_rx;
> >         unsigned int            num_rx_queues;
> > -       unsigned int            real_num_rx_queues;
> > -
> >         struct bpf_prog __rcu   *xdp_prog;
> > -       unsigned long           gro_flush_timeout;
> > -       int                     napi_defer_hard_irqs;
> >  #define GRO_LEGACY_MAX_SIZE    65536u
> >  /* TCP minimal MSS is 8 (TCP_MIN_GSO_SIZE),
> >   * and shinfo->gso_segs is a 16bit field.
> >   */
> >  #define GRO_MAX_SIZE           (8 * 65535u)
> > -       unsigned int            gro_max_size;
> > -       unsigned int            gro_ipv4_max_size;
> >         unsigned int            xdp_zc_max_segs;
> > -       rx_handler_func_t __rcu *rx_handler;
> > -       void __rcu              *rx_handler_data;
> > -#ifdef CONFIG_NET_XGRESS
> > -       struct bpf_mprog_entry __rcu *tcx_ingress;
> > -#endif
> >         struct netdev_queue __rcu *ingress_queue;
> >  #ifdef CONFIG_NETFILTER_INGRESS
> >         struct nf_hook_entries __rcu *nf_hooks_ingress;
> > @@ -2283,25 +2313,13 @@ struct net_device {
> >  /*
> >   * Cache lines mostly used on transmit path
> >   */
> > -       struct netdev_queue     *_tx ____cacheline_aligned_in_smp;
> >         unsigned int            num_tx_queues;
> > -       unsigned int            real_num_tx_queues;
> >         struct Qdisc __rcu      *qdisc;
> >         unsigned int            tx_queue_len;
> >         spinlock_t              tx_global_lock;
> >
> >         struct xdp_dev_bulk_queue __percpu *xdp_bulkq;
> >
> > -#ifdef CONFIG_XPS
> > -       struct xps_dev_maps __rcu *xps_maps[XPS_MAPS_MAX];
> > -#endif
> > -#ifdef CONFIG_NET_XGRESS
> > -       struct bpf_mprog_entry __rcu *tcx_egress;
> > -#endif
> > -#ifdef CONFIG_NETFILTER_EGRESS
> > -       struct nf_hook_entries __rcu *nf_hooks_egress;
> > -#endif
> > -
> >  #ifdef CONFIG_NET_SCHED
> >         DECLARE_HASHTABLE       (qdisc_hash, 4);
> >  #endif
> > @@ -2340,12 +2358,6 @@ struct net_device {
> >         bool needs_free_netdev;
> >         void (*priv_destructor)(struct net_device *dev);
> >
> > -#ifdef CONFIG_NETPOLL
> > -       struct netpoll_info __rcu       *npinfo;
> > -#endif
> > -
> > -       possible_net_t                  nd_net;
> > -
> >         /* mid-layer private */
> >         void                            *ml_priv;
> >         enum netdev_ml_priv_type        ml_priv_type;
> > @@ -2379,20 +2391,15 @@ struct net_device {
> >   */
> >  #define GSO_MAX_SIZE           (8 * GSO_MAX_SEGS)
> >
> > -       unsigned int            gso_max_size;
> >  #define TSO_LEGACY_MAX_SIZE    65536
> >  #define TSO_MAX_SIZE           UINT_MAX
> >         unsigned int            tso_max_size;
> > -       u16                     gso_max_segs;
> >  #define TSO_MAX_SEGS           U16_MAX
> >         u16                     tso_max_segs;
> > -       unsigned int            gso_ipv4_max_size;
> >
> >  #ifdef CONFIG_DCB
> >         const struct dcbnl_rtnl_ops *dcbnl_ops;
> >  #endif
> > -       s16                     num_tc;
> > -       struct netdev_tc_txq    tc_to_txq[TC_MAX_QUEUE];
> >         u8                      prio_tc_map[TC_BITMASK + 1];
> >
> >  #if IS_ENABLED(CONFIG_FCOE)
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index a37a932a3e145..ca7e653e6c348 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -11511,6 +11511,55 @@ static struct pernet_operations __net_initdata=
 default_device_ops =3D {
> >         .exit_batch =3D default_device_exit_batch,
> >  };
> >
> > +static void __init net_dev_struct_check(void)
> > +{
> > +       /* TX read-mostly hotpath */
>
> Of course, change net_device_read to either rx, txrx, or tx, depending
> of each field purpose/location.

The group names need to be unique, hence the verbosity. I will update
the patch series with more detailed cache line group separations.
Thank you!
>
> > +       CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_rea=
d, priv_flags);
> > +       CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_rea=
d, netdev_ops);
> > +       CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_rea=
d, header_ops);
> > +       CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_rea=
d, _tx);
> > +       CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_rea=
d, real_num_tx_queues);
> > +       CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_rea=
d, gso_max_size);
> > +       CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_rea=
d, gso_ipv4_max_size);
> > +       CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_rea=
d, gso_max_segs);
> > +       CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_rea=
d, num_tc);
> > +       CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_rea=
d, mtu);
> > +       CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_rea=
d, needed_headroom);
> > +       CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_rea=
d, tc_to_txq);
> > +#ifdef CONFIG_XPS
> > +       CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_rea=
d, xps_maps);
> > +#endif
> > +#ifdef CONFIG_NETFILTER_EGRESS
> > +       CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_rea=
d, nf_hooks_egress);
> > +#endif
> > +#ifdef CONFIG_NET_XGRESS
> > +       CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_rea=
d, tcx_egress);
> > +#endif
> > +       /* TXRX read-mostly hotpath */
> > +       CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_rea=
d, flags);
> > +       CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_rea=
d, hard_header_len);
> > +       CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_rea=
d, features);
> > +       CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_rea=
d, ip6_ptr);
> > +       /* RX read-mostly hotpath */
> > +       CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_rea=
d, ptype_specific);
> > +       CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_rea=
d, ifindex);
> > +       CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_rea=
d, real_num_rx_queues);
> > +       CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_rea=
d, _rx);
> > +       CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_rea=
d, gro_flush_timeout);
> > +       CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_rea=
d, napi_defer_hard_irqs);
> > +       CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_rea=
d, gro_max_size);
> > +       CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_rea=
d, gro_ipv4_max_size);
> > +       CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_rea=
d, rx_handler);
> > +       CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_rea=
d, rx_handler_data);
> > +       CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_rea=
d, nd_net);
> > +#ifdef CONFIG_NETPOLL
> > +       CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_rea=
d, npinfo);
> > +#endif
> > +#ifdef CONFIG_NET_XGRESS
> > +       CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_rea=
d, tcx_ingress);
> > +#endif
> > +}
> > +
> >  /*
> >   *     Initialize the DEV module. At boot time this walks the device l=
ist and
> >   *     unhooks any devices that fail to initialise (normally hardware =
not
> > @@ -11528,6 +11577,8 @@ static int __init net_dev_init(void)
> >
> >         BUG_ON(!dev_boot_phase);
> >
> > +       net_dev_struct_check();
> > +
> >         if (dev_proc_init())
> >                 goto out;
> >
> > --
> > 2.42.0.758.gaed0368e0e-goog
> >

