Return-Path: <netdev+bounces-45085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886097DAD94
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 19:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7144B20CE2
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 18:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9E3101FF;
	Sun, 29 Oct 2023 18:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MIJV4KF/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1E5101F6
	for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 18:00:22 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AA5B6
	for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 11:00:19 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so5900a12.1
        for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 11:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698602418; x=1699207218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=482JqFOCZJXsR7YDf+i4ExLqqy3uVi8ZcfTRWfqy2eI=;
        b=MIJV4KF/D6ducjRKB7LZnkx84RarJa3MZXUGWMxkyKYaCLZKz7HBIp74DOV4aG3DHQ
         p0zR9GfrPN2+juRrIbg/wtiS7XZ07lmF8kDBMW46rLpfrxwmWgv1PrLs/hDErBO48cxs
         egJt1ANW4tGekmT94oa6I/MF/vlkIkqFR6vqu8u1RBzqz0JZvka4ilnaEI6zuWbwmaLx
         j8LdkusvecfJmitphOkpNCxfLPtPYdA4E//iBAXSG7LCAGmOuNASMeDittTamCDhLl9A
         u9bjMdDQNo5wgH19JZxK5h32yjH4eU4VY2aQQcyTzdWOehbA4I2hMDGiJZ/X6+eGlOSi
         Rh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698602418; x=1699207218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=482JqFOCZJXsR7YDf+i4ExLqqy3uVi8ZcfTRWfqy2eI=;
        b=g359ufJbflxKpDqDMXjC0FRkHKxangMa8tHBZjykWZ0uveVuuTqMNa+FapMrxsKrf3
         evFdfajZ2468SPGrZQPSdwOi8SAc+zC5JGb3akN3oI5nkJx0G7EWIaE9u++BiZr3NE+y
         0NvaR209AlelhkN94gZkNpVqvSSmGV+MqP0SCZ4n/jHYXNaztzIi2s1wsb3bcTM+/LHF
         PpzNBuyB8XmVoRHN8wePIufVV5ZL61fqazPDBq5Tg2RTlqlDLhPyT6Nd8dcqWkuyawsl
         NltgGYRfLndIo4zeaOSEMnvmUl+4nCOvm/EJ6dDyeXucye0Q7wyogKpcez3jV2zXyTqu
         teSA==
X-Gm-Message-State: AOJu0YwAZ15hw6HLgM4V2QFOyyyUGY3ME6ZTFQz/ITtD+VV0pF21WJ3k
	v8LwV0AyB0xpm74rflmeCw5xGXglEqTrtfzCimny/Q==
X-Google-Smtp-Source: AGHT+IGELW6X60QP6gMIxf9l2rNayckFAtxeBkgpyHRyRdzoeI3GZkw6iH8Vry/wQk27OsiVAaJ79W5CqI050GCN92Y=
X-Received: by 2002:a05:6402:529a:b0:542:ee28:71c7 with SMTP id
 en26-20020a056402529a00b00542ee2871c7mr35155edb.1.1698602418085; Sun, 29 Oct
 2023 11:00:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231029075244.2612089-4-lixiaoyan@google.com> <202310292036.So7PkmBh-lkp@intel.com>
In-Reply-To: <202310292036.So7PkmBh-lkp@intel.com>
From: Coco Li <lixiaoyan@google.com>
Date: Sun, 29 Oct 2023 11:00:06 -0700
Message-ID: <CADjXwjhdOW3sNSFTZEF45C33w3=N57U0ACbrapotR4Pf048new@mail.gmail.com>
Subject: Re: [PATCH v5 net-next 3/5] netns-ipv4: reorganize netns_ipv4 fast
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

Sorry about this, I will fix it soon.

On Sun, Oct 29, 2023 at 5:55=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Coco,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on net-next/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Coco-Li/Documentat=
ions-Analyze-heavily-used-Networking-related-structs/20231029-172902
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20231029075244.2612089-4-lixiaoy=
an%40google.com
> patch subject: [PATCH v5 net-next 3/5] netns-ipv4: reorganize netns_ipv4 =
fast path variables
> config: um-allnoconfig (https://download.01.org/0day-ci/archive/20231029/=
202310292036.So7PkmBh-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git =
4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20231029/202310292036.So7PkmBh-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310292036.So7PkmBh-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    In file included from net/core/net_namespace.c:5:
>    In file included from include/linux/rtnetlink.h:7:
>    In file included from include/linux/netdevice.h:38:
>    In file included from include/net/net_namespace.h:43:
>    In file included from include/linux/skbuff.h:17:
>    In file included from include/linux/bvec.h:10:
>    In file included from include/linux/highmem.h:12:
>    In file included from include/linux/hardirq.h:11:
>    In file included from arch/um/include/asm/hardirq.h:5:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:13:
>    In file included from arch/um/include/asm/io.h:24:
>    include/asm-generic/io.h:547:31: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      547 |         val =3D __raw_readb(PCI_IOBASE + addr);
>          |                           ~~~~~~~~~~ ^
>    include/asm-generic/io.h:560:61: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      560 |         val =3D __le16_to_cpu((__le16 __force)__raw_readw(PCI_=
IOBASE + addr));
>          |                                                         ~~~~~~=
~~~~ ^
>    include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded fro=
m macro '__le16_to_cpu'
>       37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
>          |                                                   ^
>    In file included from net/core/net_namespace.c:5:
>    In file included from include/linux/rtnetlink.h:7:
>    In file included from include/linux/netdevice.h:38:
>    In file included from include/net/net_namespace.h:43:
>    In file included from include/linux/skbuff.h:17:
>    In file included from include/linux/bvec.h:10:
>    In file included from include/linux/highmem.h:12:
>    In file included from include/linux/hardirq.h:11:
>    In file included from arch/um/include/asm/hardirq.h:5:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:13:
>    In file included from arch/um/include/asm/io.h:24:
>    include/asm-generic/io.h:573:61: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      573 |         val =3D __le32_to_cpu((__le32 __force)__raw_readl(PCI_=
IOBASE + addr));
>          |                                                         ~~~~~~=
~~~~ ^
>    include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded fro=
m macro '__le32_to_cpu'
>       35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
>          |                                                   ^
>    In file included from net/core/net_namespace.c:5:
>    In file included from include/linux/rtnetlink.h:7:
>    In file included from include/linux/netdevice.h:38:
>    In file included from include/net/net_namespace.h:43:
>    In file included from include/linux/skbuff.h:17:
>    In file included from include/linux/bvec.h:10:
>    In file included from include/linux/highmem.h:12:
>    In file included from include/linux/hardirq.h:11:
>    In file included from arch/um/include/asm/hardirq.h:5:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:13:
>    In file included from arch/um/include/asm/io.h:24:
>    include/asm-generic/io.h:584:33: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      584 |         __raw_writeb(value, PCI_IOBASE + addr);
>          |                             ~~~~~~~~~~ ^
>    include/asm-generic/io.h:594:59: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBA=
SE + addr);
>          |                                                       ~~~~~~~~=
~~ ^
>    include/asm-generic/io.h:604:59: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBA=
SE + addr);
>          |                                                       ~~~~~~~~=
~~ ^
>    include/asm-generic/io.h:692:20: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      692 |         readsb(PCI_IOBASE + addr, buffer, count);
>          |                ~~~~~~~~~~ ^
>    include/asm-generic/io.h:700:20: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      700 |         readsw(PCI_IOBASE + addr, buffer, count);
>          |                ~~~~~~~~~~ ^
>    include/asm-generic/io.h:708:20: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      708 |         readsl(PCI_IOBASE + addr, buffer, count);
>          |                ~~~~~~~~~~ ^
>    include/asm-generic/io.h:717:21: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      717 |         writesb(PCI_IOBASE + addr, buffer, count);
>          |                 ~~~~~~~~~~ ^
>    include/asm-generic/io.h:726:21: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      726 |         writesw(PCI_IOBASE + addr, buffer, count);
>          |                 ~~~~~~~~~~ ^
>    include/asm-generic/io.h:735:21: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      735 |         writesl(PCI_IOBASE + addr, buffer, count);
>          |                 ~~~~~~~~~~ ^
> >> net/core/net_namespace.c:1127:2: error: expected expression
>     1127 |         / TXRX readonly hotpath cache lines */
>          |         ^
> >> net/core/net_namespace.c:1127:4: error: use of undeclared identifier '=
TXRX'
>     1127 |         / TXRX readonly hotpath cache lines */
>          |           ^
>    12 warnings and 2 errors generated.
>
>
> vim +1127 net/core/net_namespace.c
>
>   1101
>   1102  static void __init netns_ipv4_struct_check(void)
>   1103  {
>   1104          /* TX readonly hotpath cache lines */
>   1105          CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ip=
v4_read_tx,
>   1106                                        sysctl_tcp_early_retrans);
>   1107          CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ip=
v4_read_tx,
>   1108                                        sysctl_tcp_tso_win_divisor)=
;
>   1109          CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ip=
v4_read_tx,
>   1110                                        sysctl_tcp_tso_rtt_log);
>   1111          CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ip=
v4_read_tx,
>   1112                                        sysctl_tcp_autocorking);
>   1113          CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ip=
v4_read_tx,
>   1114                                        sysctl_tcp_min_snd_mss);
>   1115          CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ip=
v4_read_tx,
>   1116                                        sysctl_tcp_notsent_lowat);
>   1117          CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ip=
v4_read_tx,
>   1118                                        sysctl_tcp_limit_output_byt=
es);
>   1119          CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ip=
v4_read_tx,
>   1120                                        sysctl_tcp_min_rtt_wlen);
>   1121          CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ip=
v4_read_tx,
>   1122                                        sysctl_tcp_wmem);
>   1123          CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ip=
v4_read_tx,
>   1124                                        sysctl_ip_fwd_use_pmtu);
>   1125          CACHELINE_ASSERT_GROUP_SIZE(struct netns_ipv4, netns_ipv4=
_read_tx, 33);
>   1126
> > 1127          / TXRX readonly hotpath cache lines */
>   1128          CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ip=
v4_read_txrx,
>   1129                                        sysctl_tcp_moderate_rcvbuf)=
;
>   1130          CACHELINE_ASSERT_GROUP_SIZE(struct netns_ipv4, netns_ipv4=
_read_txrx, 1);
>   1131
>   1132          /* RX readonly hotpath cache line */
>   1133          CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ip=
v4_read_rx,
>   1134                                        sysctl_ip_early_demux);
>   1135          CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ip=
v4_read_rx,
>   1136                                        sysctl_tcp_early_demux);
>   1137          CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ip=
v4_read_rx,
>   1138                                        sysctl_tcp_reordering);
>   1139          CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ip=
v4_read_rx,
>   1140                                        sysctl_tcp_rmem);
>   1141          CACHELINE_ASSERT_GROUP_SIZE(struct netns_ipv4, netns_ipv4=
_read_rx, 18);
>   1142  }
>   1143
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

