Return-Path: <netdev+bounces-48781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 277087EF7FD
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 20:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E9F21F237BE
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 19:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0377E43AB2;
	Fri, 17 Nov 2023 19:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2rurv2ek"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FD0D6A
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 11:44:57 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40837124e1cso11145e9.0
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 11:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700250295; x=1700855095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uH82KyLyY0MGpQ1oskhisGiR92JnjPKjPD6wdaivO9M=;
        b=2rurv2ekgrhN4Bz5BRv+qBdVHnAmbWbm6Du3aS7FZVXoAYI3LDjPIff03iLtbSR3kS
         FN6lV3vq867KrHu1nPfeUNYt0Qhp9UJwQ5nrxbkNwyIvlgmNfiT4zJf/r8V92ifKIhDP
         p9Y7ZuMEQMnWdFs3as3mprAfCL9loJxn78qLPEIMjC1mdxvwLlco5f4/65xMyUxIMysC
         8vYJMVxxeHciviBsw0zAZGpLcqucdzOilYBj1eitvMdBKTs58PNZPgl87i6GVpx9et16
         B9Nr/NbdVuII0T90c83sA5rg5Lxq17D+WE6vFdZLPgC8crmluMqZhT+Bv2OE0aUWhwUL
         8oXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700250295; x=1700855095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uH82KyLyY0MGpQ1oskhisGiR92JnjPKjPD6wdaivO9M=;
        b=g2F40EB52Y6m12dPTRDerPuFJ3bJuRifciXv5qtJibXGusbmRkZue+DcuM16BlQYuH
         B4YyLLtQyAcKoHceVBaYRy1weI1W3tFvYG4qVHEVUyEOSNUbKq45Y2Yri+Tmckblx/gX
         ksN08w5Y652p7vXSUua6LCi83+jJbUfPco+qJbFWTFlfYAX+uXwg8/Afty7zrFU3LPSi
         zUKGRwAA1JCZa+NQWihyeAd29NF7fWOFvMQ3iCPbU7udKDHkQjEnILWmbSUojU1cXSc1
         QrMwxe7DOad/rcfy12R45Cn2JNx5yr4RfnQ8wobKyvv1j4uRn7RZs3ss9rLHB36Lo2+Q
         UqqA==
X-Gm-Message-State: AOJu0YzDBNOIUpsGIQ38HXp+iBQm/j/VPXfcexSjp1LyBAVNMLX9ha0x
	U5f1wcNE6AHZD08AFU6Rg/BuJawT9OS+gykG59mjDw==
X-Google-Smtp-Source: AGHT+IF7KOIGm8pgTMbbQoxb87rgd/7FRl+zIWO3sJM649IAWg1afr67XhaZMxxm651cUYUmizQTsTO4FwpluIj5Hhg=
X-Received: by 2002:a1c:7504:0:b0:404:74f8:f47c with SMTP id
 o4-20020a1c7504000000b0040474f8f47cmr35527wmc.5.1700250295208; Fri, 17 Nov
 2023 11:44:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231113233301.1020992-5-lixiaoyan@google.com> <202311162002.m26ObVLU-lkp@intel.com>
In-Reply-To: <202311162002.m26ObVLU-lkp@intel.com>
From: Coco Li <lixiaoyan@google.com>
Date: Fri, 17 Nov 2023 11:44:41 -0800
Message-ID: <CADjXwjjPrhDF3hfPWKrXxCkJjwBJDfumFkAvCPg2gvOBme2sTA@mail.gmail.com>
Subject: Re: [PATCH v7 net-next 4/5] net-device: reorganize net_device fast
 path variables
To: kernel test robot <lkp@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>, 
	David Ahern <dsahern@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org, 
	Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>, 
	Pradeep Nemavat <pnemavat@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Spending some time setting up a clang17 compatible environment, will
update soon.


On Thu, Nov 16, 2023 at 4:40=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Coco,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on net-next/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Coco-Li/Documentat=
ions-Analyze-heavily-used-Networking-related-structs/20231114-073648
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20231113233301.1020992-5-lixiaoy=
an%40google.com
> patch subject: [PATCH v7 net-next 4/5] net-device: reorganize net_device =
fast path variables
> config: powerpc-mpc8313_rdb_defconfig (https://download.01.org/0day-ci/ar=
chive/20231116/202311162002.m26ObVLU-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git =
4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20231116/202311162002.m26ObVLU-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311162002.m26ObVLU-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    net/core/dev.c:4079:1: warning: unused function 'sch_handle_ingress' [=
-Wunused-function]
>     4079 | sch_handle_ingress(struct sk_buff *skb, struct packet_type **p=
t_prev, int *ret,
>          | ^
>    net/core/dev.c:4086:1: warning: unused function 'sch_handle_egress' [-=
Wunused-function]
>     4086 | sch_handle_egress(struct sk_buff *skb, int *ret, struct net_de=
vice *dev)
>          | ^
>    net/core/dev.c:5296:19: warning: unused function 'nf_ingress' [-Wunuse=
d-function]
>     5296 | static inline int nf_ingress(struct sk_buff *skb, struct packe=
t_type **pt_prev,
>          |                   ^
> >> net/core/dev.c:11547:2: error: call to '__compiletime_assert_971' decl=
ared with 'error' attribute: BUILD_BUG_ON failed: offsetof(struct net_devic=
e, __cacheline_group_end__net_device_read_txrx) - offsetofend(struct net_de=
vice, __cacheline_group_begin__net_device_read_txrx) > 24
>     11547 |         CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_de=
vice_read_txrx, 24);
>           |         ^
>    include/linux/cache.h:108:2: note: expanded from macro 'CACHELINE_ASSE=
RT_GROUP_SIZE'
>      108 |         BUILD_BUG_ON(offsetof(TYPE, __cacheline_group_end__##G=
ROUP) - \
>          |         ^
>    include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_O=
N'
>       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #c=
ondition)
>          |         ^
>    include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_=
ON_MSG'
>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond)=
, msg)
>          |                                     ^
>    note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=
=3D0 to see all)
>    include/linux/compiler_types.h:423:2: note: expanded from macro '_comp=
iletime_assert'
>      423 |         __compiletime_assert(condition, msg, prefix, suffix)
>          |         ^
>    include/linux/compiler_types.h:416:4: note: expanded from macro '__com=
piletime_assert'
>      416 |                         prefix ## suffix();                   =
          \
>          |                         ^
>    <scratch space>:11:1: note: expanded from here
>       11 | __compiletime_assert_971
>          | ^
>    3 warnings and 1 error generated.
>
>
> vim +11547 net/core/dev.c
>
>  11515
>  11516  static void __init net_dev_struct_check(void)
>  11517  {
>  11518          /* TX read-mostly hotpath */
>  11519          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_devi=
ce_read_tx, priv_flags);
>  11520          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_devi=
ce_read_tx, netdev_ops);
>  11521          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_devi=
ce_read_tx, header_ops);
>  11522          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_devi=
ce_read_tx, _tx);
>  11523          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_devi=
ce_read_tx, real_num_tx_queues);
>  11524          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_devi=
ce_read_tx, gso_max_size);
>  11525          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_devi=
ce_read_tx, gso_ipv4_max_size);
>  11526          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_devi=
ce_read_tx, gso_max_segs);
>  11527          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_devi=
ce_read_tx, num_tc);
>  11528          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_devi=
ce_read_tx, mtu);
>  11529          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_devi=
ce_read_tx, needed_headroom);
>  11530          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_devi=
ce_read_tx, tc_to_txq);
>  11531  #ifdef CONFIG_XPS
>  11532          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_devi=
ce_read_tx, xps_maps);
>  11533  #endif
>  11534  #ifdef CONFIG_NETFILTER_EGRESS
>  11535          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_devi=
ce_read_tx, nf_hooks_egress);
>  11536  #endif
>  11537  #ifdef CONFIG_NET_XGRESS
>  11538          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_devi=
ce_read_tx, tcx_egress);
>  11539  #endif
>  11540          CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device=
_read_tx, 152);
>  11541
>  11542          /* TXRX read-mostly hotpath */
>  11543          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_devi=
ce_read_txrx, flags);
>  11544          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_devi=
ce_read_txrx, hard_header_len);
>  11545          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_devi=
ce_read_txrx, features);
>  11546          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_devi=
ce_read_txrx, ip6_ptr);
>  11547          CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device=
_read_txrx, 24);
>  11548
>  11549          /* RX read-mostly hotpath */
>  11550          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_devi=
ce_read_rx, ptype_specific);
>  11551          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_devi=
ce_read_rx, ifindex);
>  11552          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_devi=
ce_read_rx, real_num_rx_queues);
>  11553          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_devi=
ce_read_rx, _rx);
>  11554          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_devi=
ce_read_rx, gro_flush_timeout);
>  11555          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_devi=
ce_read_rx, napi_defer_hard_irqs);
>  11556          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_devi=
ce_read_rx, gro_max_size);
>  11557          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_devi=
ce_read_rx, gro_ipv4_max_size);
>  11558          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_devi=
ce_read_rx, rx_handler);
>  11559          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_devi=
ce_read_rx, rx_handler_data);
>  11560          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_devi=
ce_read_rx, nd_net);
>  11561  #ifdef CONFIG_NETPOLL
>  11562          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_devi=
ce_read_rx, npinfo);
>  11563  #endif
>  11564  #ifdef CONFIG_NET_XGRESS
>  11565          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_devi=
ce_read_rx, tcx_ingress);
>  11566  #endif
>  11567          CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device=
_read_rx, 96);
>  11568  }
>  11569
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

