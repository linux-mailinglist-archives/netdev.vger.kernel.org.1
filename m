Return-Path: <netdev+bounces-93698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAA88BCCEC
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 13:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1F8C2817DF
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 11:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54280143738;
	Mon,  6 May 2024 11:39:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13246EB51;
	Mon,  6 May 2024 11:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714995559; cv=none; b=FaUvmhJE4w8Xq/lnm0eFLEN0iF4yYglJKRJtz4dgNyhfEQ+tk+SsEKURyHY96adr2QZd406vcqekuuY00p2df0DQAeycwxxBerPKEE+cyq4xpB3727HL/FG7uzVkdswhbIkU3sD2EkZobJa5yLI0FKr+X2DstMnVsgD43YDyNxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714995559; c=relaxed/simple;
	bh=FZGGdKQ/lgfW27r0KhDZZdtOmV6Nq5yH7l+nCt+HMHA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eTDTJjz20lbXAPOhGqcHeEmL9EneP6TROvU90IEUa4/Hytozpf9Ort+Gw9AgQzMQPYMQemt++sdHguutDfF2KJ8BXJeGI8Kh13FJaGH21MsSZd5MRxnABL3krSNI8npVpFioEfecAGOhb4C3kGgJleJVG3Dd2x70mGEklN4UrOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 446Bd0aC52263399, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 446Bd0aC52263399
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 May 2024 19:39:00 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 19:39:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 19:39:00 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 6 May 2024 19:39:00 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: kernel test robot <lkp@intel.com>, "kuba@kernel.org" <kuba@kernel.org>
CC: "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "andrew@lunn.ch"
	<andrew@lunn.ch>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        Ping-Ke Shih
	<pkshih@realtek.com>,
        Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v17 12/13] realtek: Update the Makefile and Kconfig in the realtek folder
Thread-Topic: [PATCH net-next v17 12/13] realtek: Update the Makefile and
 Kconfig in the realtek folder
Thread-Index: AQHanHJwtQlHSOPjc0iBIoHkieL8ZLGG2wqAgAM+1GA=
Date: Mon, 6 May 2024 11:39:00 +0000
Message-ID: <261fdf3adbe84127890e6d551ce0d407@realtek.com>
References: <20240502091847.65181-13-justinlai0215@realtek.com>
 <202405050111.thv4v0Bl-lkp@intel.com>
In-Reply-To: <202405050111.thv4v0Bl-lkp@intel.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

The problem this time seems to be caused by me not doing a rebase.
I will modify the reviewer's suggestions in the next version and re-upload
the next version after rebase.

> Hi Justin,
>=20
> kernel test robot noticed the following build errors:
>=20
> [auto build test ERROR on horms-ipvs/master] [cannot apply to net-next/ma=
in
> linus/master v6.9-rc6 next-20240503] [If your patch is applied to the wro=
ng git
> tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:
> https://github.com/intel-lab-lkp/linux/commits/Justin-Lai/rtase-Add-pci-t=
able-s
> upported-in-this-module/20240502-172835
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/horms/ipvs.git ma=
ster
> patch link:
> https://lore.kernel.org/r/20240502091847.65181-13-justinlai0215%40realtek=
.c
> om
> patch subject: [PATCH net-next v17 12/13] realtek: Update the Makefile an=
d
> Kconfig in the realtek folder
> config: s390-allmodconfig
> (https://download.01.org/0day-ci/archive/20240505/202405050111.thv4v0Bl-l
> kp@intel.com/config)
> compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project
> 37ae4ad0eef338776c7e2cffb3896153d43dcd90)
> reproduce (this is a W=3D1 build):
> (https://download.01.org/0day-ci/archive/20240505/202405050111.thv4v0Bl-l
> kp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes:
> | https://lore.kernel.org/oe-kbuild-all/202405050111.thv4v0Bl-lkp@intel.
> | com/
>=20
> All errors (new ones prefixed by >>):
>=20
>    In file included from drivers/net/ethernet/realtek/rtase/rtase_main.c:=
47:
>    In file included from include/linux/dma-mapping.h:7:
>    In file included from include/linux/device.h:32:
>    In file included from include/linux/device/driver.h:21:
>    In file included from include/linux/module.h:19:
>    In file included from include/linux/elf.h:6:
>    In file included from arch/s390/include/asm/elf.h:173:
>    In file included from arch/s390/include/asm/mmu_context.h:11:
>    In file included from arch/s390/include/asm/pgalloc.h:18:
>    In file included from include/linux/mm.h:1970:
>    include/linux/vmstat.h:502:43: warning: arithmetic between different
> enumeration types ('enum zone_stat_item' and 'enum numa_stat_item')
> [-Wenum-enum-conversion]
>      502 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      503 |                            item];
>          |                            ~~~~
>    include/linux/vmstat.h:509:43: warning: arithmetic between different
> enumeration types ('enum zone_stat_item' and 'enum numa_stat_item')
> [-Wenum-enum-conversion]
>      509 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      510 |                            NR_VM_NUMA_EVENT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/vmstat.h:516:36: warning: arithmetic between different
> enumeration types ('enum node_stat_item' and 'enum lru_list')
> [-Wenum-enum-conversion]
>      516 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip
> "nr_"
>          |                               ~~~~~~~~~~~ ^ ~~~
>    include/linux/vmstat.h:521:43: warning: arithmetic between different
> enumeration types ('enum zone_stat_item' and 'enum numa_stat_item')
> [-Wenum-enum-conversion]
>      521 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      522 |                            NR_VM_NUMA_EVENT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/vmstat.h:530:43: warning: arithmetic between different
> enumeration types ('enum zone_stat_item' and 'enum numa_stat_item')
> [-Wenum-enum-conversion]
>      530 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      531 |                            NR_VM_NUMA_EVENT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~~
>    In file included from drivers/net/ethernet/realtek/rtase/rtase_main.c:=
47:
>    In file included from include/linux/dma-mapping.h:10:
>    In file included from include/linux/scatterlist.h:9:
>    In file included from arch/s390/include/asm/io.h:75:
>    include/asm-generic/io.h:547:31: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      547 |         val =3D __raw_readb(PCI_IOBASE + addr);
>          |                           ~~~~~~~~~~ ^
>    include/asm-generic/io.h:560:61: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      560 |         val =3D __le16_to_cpu((__le16
> __force)__raw_readw(PCI_IOBASE + addr));
>          |
> ~~~~~~~~~~ ^
>    include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from
> macro '__le16_to_cpu'
>       37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
>          |
> ^
>    include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
>      102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
>          |
> ^
>    In file included from drivers/net/ethernet/realtek/rtase/rtase_main.c:=
47:
>    In file included from include/linux/dma-mapping.h:10:
>    In file included from include/linux/scatterlist.h:9:
>    In file included from arch/s390/include/asm/io.h:75:
>    include/asm-generic/io.h:573:61: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      573 |         val =3D __le32_to_cpu((__le32
> __force)__raw_readl(PCI_IOBASE + addr));
>          |
> ~~~~~~~~~~ ^
>    include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from
> macro '__le32_to_cpu'
>       35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
>          |
> ^
>    include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
>      115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
>          |
> ^
>    In file included from drivers/net/ethernet/realtek/rtase/rtase_main.c:=
47:
>    In file included from include/linux/dma-mapping.h:10:
>    In file included from include/linux/scatterlist.h:9:
>    In file included from arch/s390/include/asm/io.h:75:
>    include/asm-generic/io.h:584:33: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      584 |         __raw_writeb(value, PCI_IOBASE + addr);
>          |                             ~~~~~~~~~~ ^
>    include/asm-generic/io.h:594:59: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      594 |         __raw_writew((u16 __force)cpu_to_le16(value),
> PCI_IOBASE + addr);
>          |
> ~~~~~~~~~~ ^
>    include/asm-generic/io.h:604:59: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      604 |         __raw_writel((u32 __force)cpu_to_le32(value),
> PCI_IOBASE + addr);
>          |
> ~~~~~~~~~~ ^
>    include/asm-generic/io.h:692:20: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      692 |         readsb(PCI_IOBASE + addr, buffer, count);
>          |                ~~~~~~~~~~ ^
>    include/asm-generic/io.h:700:20: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      700 |         readsw(PCI_IOBASE + addr, buffer, count);
>          |                ~~~~~~~~~~ ^
>    include/asm-generic/io.h:708:20: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      708 |         readsl(PCI_IOBASE + addr, buffer, count);
>          |                ~~~~~~~~~~ ^
>    include/asm-generic/io.h:717:21: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      717 |         writesb(PCI_IOBASE + addr, buffer, count);
>          |                 ~~~~~~~~~~ ^
>    include/asm-generic/io.h:726:21: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      726 |         writesw(PCI_IOBASE + addr, buffer, count);
>          |                 ~~~~~~~~~~ ^
>    include/asm-generic/io.h:735:21: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      735 |         writesl(PCI_IOBASE + addr, buffer, count);
>          |                 ~~~~~~~~~~ ^
> >> drivers/net/ethernet/realtek/rtase/rtase_main.c:67:10: fatal error:
> >> 'net/netdev_queues.h' file not found
>       67 | #include <net/netdev_queues.h>
>          |          ^~~~~~~~~~~~~~~~~~~~~
>    17 warnings and 1 error generated.
>=20
>=20
> vim +67 drivers/net/ethernet/realtek/rtase/rtase_main.c
>=20
> 6c114677e472d0 Justin Lai 2024-05-02 @67  #include
> <net/netdev_queues.h>
> 6c114677e472d0 Justin Lai 2024-05-02  68  #include
> <net/page_pool/helpers.h>
> 6c114677e472d0 Justin Lai 2024-05-02  69  #include <net/pkt_cls.h>
> 6c114677e472d0 Justin Lai 2024-05-02  70
>=20
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

