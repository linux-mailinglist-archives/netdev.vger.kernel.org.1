Return-Path: <netdev+bounces-226565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D9DBA2293
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 03:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8C3560BAF
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 01:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAB51B0F23;
	Fri, 26 Sep 2025 01:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aIEcFJA+"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4161C8FE
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 01:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758851267; cv=none; b=u0PprB7kNNhF+YN+/p04k4tUhHvFD0CPm5ivg9153sJQ+cnzeDPoXid4hgsnsrwceokgsiju5RzU2QF1XhR5rxu7eJOi0YZ4jxSnhgnXLNrHzbNqHZ9sSD8FVUZQFBmh6ym63shhj2Po6ObNDLGQfg9Ei9J2xIL77RhUWRCq76o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758851267; c=relaxed/simple;
	bh=eb3EjpdsO0wqOo8mhKESER/AlPjlnfbw5rXpvwIHXK0=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=q3qLo5HGXELAnPjkaUJfcQTfPNjhkVusrmBx6ouDl754zmCjbuyzt/d3dhYSI0vl2mVOwUrQmLjLAHRVVcuR28Z7R3keIpsv22EOi5kY8OnJ0tWgqxbmai9puTjNxNuY5k2OITJ13htXv2H09l1spP9gWjFNoy9mN8c+Rj1eQT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aIEcFJA+; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758851258; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=hnDxy+SwzTwKePs5FzI8wX8P14bZmEkMehiY7FnGunU=;
	b=aIEcFJA+gR8t70qSzKYMyU/dzKvz9Y3wtJonF8xFE1CG6BbvF22gn9pl/sHJJMooB4jB1tRGsIT2cLXu15iM5cSzeWrAJoHBkKzWw7LUP3/1DjStcbWPnN+ybDLq1nKijV0A9j9xEw8ugraBypNLPf2R0lm8vqZQhRuARGSbZIs=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WopxSKk_1758851256 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 26 Sep 2025 09:47:37 +0800
Message-ID: <1758851195.7480097-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v3] eea: Add basic driver framework for Alibaba Elastic Ethernet Adaptor
Date: Fri, 26 Sep 2025 09:46:35 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Cc: netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Vivian Wang <wangruikang@iscas.ac.cn>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Dust Li <dust.li@linux.alibaba.com>
References: <20250919014856.20267-1-xuanzhuo@linux.alibaba.com>
 <CAH-L+nM3ahD+s_vRq7s_cKQstgsksXmk8bkAprm8CRRk20oYCQ@mail.gmail.com>
In-Reply-To: <CAH-L+nM3ahD+s_vRq7s_cKQstgsksXmk8bkAprm8CRRk20oYCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Thank you for your review. Most of the issues will be addressed in the next=
 version.

On Thu, 25 Sep 2025 13:36:49 +0530, Kalesh Anakkur Purayil <kalesh-anakkur.=
purayil@broadcom.com> wrote:
> On Fri, Sep 19, 2025 at 7:19=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > Add a driver framework for EEA that will be available in the future.
> >
> > This driver is currently quite minimal, implementing only fundamental
> > core functionalities. Key features include: I/O queue management via
> > adminq, basic PCI-layer operations, and essential RX/TX data
> > communication capabilities. It also supports the creation,
> > initialization, and management of network devices (netdev). Furthermore,
> > the ring structures for both I/O queues and adminq have been abstracted
> > into a simple, unified, and reusable library implementation,
> > facilitating future extension and maintenance.
> >
> > This commit is indeed quite large, but further splitting it would not be
> > meaningful. Historically, many similar drivers have been introduced with
> > commits of similar size and scope, so we chose not to invest excessive
> > effort into finer-grained splitting.
> >
> > Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> > Reviewed-by: Philo Lu <lulie@linux.alibaba.com>
> > Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >
> > v3: Thanks for the comments from Paolo Abenchi
> > v2: Thanks for the comments from Simon Horman and Andrew Lunn
> > v1: Thanks for the comments from Simon Horman and Andrew Lunn
> >
> >  MAINTAINERS                                   |   8 +
> >  drivers/net/ethernet/Kconfig                  |   1 +
> >  drivers/net/ethernet/Makefile                 |   1 +
> >  drivers/net/ethernet/alibaba/Kconfig          |  29 +
> >  drivers/net/ethernet/alibaba/Makefile         |   5 +
> >  drivers/net/ethernet/alibaba/eea/Makefile     |   9 +
> >  drivers/net/ethernet/alibaba/eea/eea_adminq.c | 452 ++++++++++
> >  drivers/net/ethernet/alibaba/eea/eea_adminq.h |  70 ++
> >  drivers/net/ethernet/alibaba/eea/eea_desc.h   | 155 ++++
> >  .../net/ethernet/alibaba/eea/eea_ethtool.c    | 310 +++++++
> >  .../net/ethernet/alibaba/eea/eea_ethtool.h    |  51 ++
> >  drivers/net/ethernet/alibaba/eea/eea_net.c    | 575 +++++++++++++
> >  drivers/net/ethernet/alibaba/eea/eea_net.h    | 196 +++++
> >  drivers/net/ethernet/alibaba/eea/eea_pci.c    | 574 +++++++++++++
> >  drivers/net/ethernet/alibaba/eea/eea_pci.h    |  67 ++
> >  drivers/net/ethernet/alibaba/eea/eea_ring.c   | 267 ++++++
> >  drivers/net/ethernet/alibaba/eea/eea_ring.h   |  89 ++
> >  drivers/net/ethernet/alibaba/eea/eea_rx.c     | 784 ++++++++++++++++++
> >  drivers/net/ethernet/alibaba/eea/eea_tx.c     | 405 +++++++++
> >  19 files changed, 4048 insertions(+)
> >  create mode 100644 drivers/net/ethernet/alibaba/Kconfig
> >  create mode 100644 drivers/net/ethernet/alibaba/Makefile
> >  create mode 100644 drivers/net/ethernet/alibaba/eea/Makefile
> >  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_adminq.c
> >  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_adminq.h
> >  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_desc.h
> >  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ethtool.c
> >  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ethtool.h
> >  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_net.c
> >  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_net.h
> >  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_pci.c
> >  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_pci.h
> >  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ring.c
> >  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ring.h
> >  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_rx.c
> >  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_tx.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index a8a770714101..9ffc6a753842 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -789,6 +789,14 @@ S: Maintained
> >  F:     Documentation/i2c/busses/i2c-ali1563.rst
> >  F:     drivers/i2c/busses/i2c-ali1563.c
> >
> > +ALIBABA ELASTIC ETHERNET ADAPTOR DRIVER
> > +M:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > +M:     Wen Gu <guwen@linux.alibaba.com>
> > +R:     Philo Lu <lulie@linux.alibaba.com>
> > +L:     netdev@vger.kernel.org
> > +S:     Supported
> > +F:     drivers/net/ethernet/alibaba/eea
> > +
> >  ALIBABA ELASTIC RDMA DRIVER
> >  M:     Cheng Xu <chengyou@linux.alibaba.com>
> >  M:     Kai Shen <kaishen@linux.alibaba.com>
> > diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
> > index aead145dd91d..307c68a4fd53 100644
> > --- a/drivers/net/ethernet/Kconfig
> > +++ b/drivers/net/ethernet/Kconfig
> > @@ -22,6 +22,7 @@ source "drivers/net/ethernet/aeroflex/Kconfig"
> >  source "drivers/net/ethernet/agere/Kconfig"
> >  source "drivers/net/ethernet/airoha/Kconfig"
> >  source "drivers/net/ethernet/alacritech/Kconfig"
> > +source "drivers/net/ethernet/alibaba/Kconfig"
> >  source "drivers/net/ethernet/allwinner/Kconfig"
> >  source "drivers/net/ethernet/alteon/Kconfig"
> >  source "drivers/net/ethernet/altera/Kconfig"
> > diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makef=
ile
> > index 998dd628b202..358d88613cf4 100644
> > --- a/drivers/net/ethernet/Makefile
> > +++ b/drivers/net/ethernet/Makefile
> > @@ -12,6 +12,7 @@ obj-$(CONFIG_NET_VENDOR_ADI) +=3D adi/
> >  obj-$(CONFIG_NET_VENDOR_AGERE) +=3D agere/
> >  obj-$(CONFIG_NET_VENDOR_AIROHA) +=3D airoha/
> >  obj-$(CONFIG_NET_VENDOR_ALACRITECH) +=3D alacritech/
> > +obj-$(CONFIG_NET_VENDOR_ALIBABA) +=3D alibaba/
> >  obj-$(CONFIG_NET_VENDOR_ALLWINNER) +=3D allwinner/
> >  obj-$(CONFIG_NET_VENDOR_ALTEON) +=3D alteon/
> >  obj-$(CONFIG_ALTERA_TSE) +=3D altera/
> > diff --git a/drivers/net/ethernet/alibaba/Kconfig b/drivers/net/etherne=
t/alibaba/Kconfig
> > new file mode 100644
> > index 000000000000..4040666ce129
> > --- /dev/null
> > +++ b/drivers/net/ethernet/alibaba/Kconfig
> > @@ -0,0 +1,29 @@
> > +#
> > +# Alibaba network device configuration
> > +#
> > +
> > +config NET_VENDOR_ALIBABA
> > +       bool "Alibaba Devices"
> > +       default y
> > +       help
> > +         If you have a network (Ethernet) device belonging to this cla=
ss, say Y.
> > +
> > +         Note that the answer to this question doesn't directly affect=
 the
> > +         kernel: saying N will just cause the configurator to skip all
> > +         the questions about Alibaba devices. If you say Y, you will b=
e asked
> > +         for your specific device in the following questions.
> > +
> > +if NET_VENDOR_ALIBABA
> > +
> > +config EEA
> > +       tristate "Alibaba Elastic Ethernet Adaptor support"
> > +       depends on PCI_MSI
> > +       depends on 64BIT
> > +       select PAGE_POOL
> > +       default m
> > +       help
> > +         This driver supports Alibaba Elastic Ethernet Adaptor"
> > +
> > +         To compile this driver as a module, choose M here.
> > +
> > +endif #NET_VENDOR_ALIBABA
> > diff --git a/drivers/net/ethernet/alibaba/Makefile b/drivers/net/ethern=
et/alibaba/Makefile
> > new file mode 100644
> > index 000000000000..7980525cb086
> > --- /dev/null
> > +++ b/drivers/net/ethernet/alibaba/Makefile
> > @@ -0,0 +1,5 @@
> > +#
> > +# Makefile for the Alibaba network device drivers.
> > +#
> > +
> > +obj-$(CONFIG_EEA) +=3D eea/
> > diff --git a/drivers/net/ethernet/alibaba/eea/Makefile b/drivers/net/et=
hernet/alibaba/eea/Makefile
> > new file mode 100644
> > index 000000000000..bf2dad05e09a
> > --- /dev/null
> > +++ b/drivers/net/ethernet/alibaba/eea/Makefile
> > @@ -0,0 +1,9 @@
> > +
> > +obj-$(CONFIG_EEA) +=3D eea.o
> > +eea-objs :=3D eea_ring.o \
> > +       eea_net.o \
> > +       eea_pci.o \
> > +       eea_adminq.o \
> > +       eea_ethtool.o \
> > +       eea_tx.o \
> > +       eea_rx.o
> > diff --git a/drivers/net/ethernet/alibaba/eea/eea_adminq.c b/drivers/ne=
t/ethernet/alibaba/eea/eea_adminq.c
> > new file mode 100644
> > index 000000000000..625dd27bfb5d
> > --- /dev/null
> > +++ b/drivers/net/ethernet/alibaba/eea/eea_adminq.c
> > @@ -0,0 +1,452 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Driver for Alibaba Elastic Ethernet Adaptor.
> > + *
> > + * Copyright (C) 2025 Alibaba Inc.
> > + */
> > +
> > +#include <linux/etherdevice.h>
> > +#include <linux/utsname.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/version.h>
> > +
> > +#include "eea_net.h"
> > +#include "eea_ring.h"
> > +#include "eea_adminq.h"
> > +#include "eea_pci.h"
> > +
> > +#define EEA_AQ_CMD_CFG_QUERY         ((0 << 8) | 0)
> > +
> > +#define EEA_AQ_CMD_QUEUE_CREATE      ((1 << 8) | 0)
> > +#define EEA_AQ_CMD_QUEUE_DESTROY_ALL ((1 << 8) | 1)
> > +#define EEA_AQ_CMD_QUEUE_DESTROY_Q   ((1 << 8) | 2)
> > +
> > +#define EEA_AQ_CMD_HOST_INFO         ((2 << 8) | 0)
> > +
> > +#define EEA_AQ_CMD_DEV_STATUS        ((3 << 8) | 0)
> > +
> > +#define ERING_DESC_F_AQ_PHASE       (BIT(15) | BIT(7))
> > +
> > +struct eea_aq_create {
> > +#define EEA_QUEUE_FLAGS_HW_SPLIT_HDR BIT(0)
> > +#define EEA_QUEUE_FLAGS_SQCQ         BIT(1)
> > +#define EEA_QUEUE_FLAGS_HWTS         BIT(2)
> > +       __le32 flags;
> > +       /* queue index.
> > +        * rx: 0 =3D=3D qidx % 2
> > +        * tx: 1 =3D=3D qidx % 2
> > +        */
> > +       __le16 qidx;
> > +       /* the depth of the queue */
> > +       __le16 depth;
> > +       /*  0: without SPLIT HDR
> > +        *  1: 128B
> > +        *  2: 256B
> > +        *  3: 512B
> > +        */
> > +       u8 hdr_buf_size;
> > +       u8 sq_desc_size;
> > +       u8 cq_desc_size;
> > +       u8 reserve0;
> > +       /* The vector for the irq. rx,tx share the same vector */
> > +       __le16 msix_vector;
> > +       __le16 reserve;
> > +       /* sq ring cfg. */
> > +       __le32 sq_addr_low;
> > +       __le32 sq_addr_high;
> > +       /* cq ring cfg. Just valid when flags include EEA_QUEUE_FLAGS_S=
QCQ. */
> > +       __le32 cq_addr_low;
> > +       __le32 cq_addr_high;
> > +};
> > +
> > +struct aq_queue_drv_status {
> > +       __le16 qidx;
> > +
> > +       __le16 sq_head;
> > +       __le16 cq_head;
> > +       __le16 reserved;
> > +};
> > +
> > +struct eea_aq_host_info_cfg {
> > +#define EEA_OS_DISTRO          0
> > +#define EEA_DRV_TYPE           0
> > +#define EEA_OS_LINUX           1
> > +#define EEA_SPEC_VER_MAJOR     1
> > +#define EEA_SPEC_VER_MINOR     0
> > +       __le16  os_type;        /* Linux, Win.. */
> > +       __le16  os_dist;
> > +       __le16  drv_type;
> > +
> > +       __le16  kern_ver_major;
> > +       __le16  kern_ver_minor;
> > +       __le16  kern_ver_sub_minor;
> > +
> > +       __le16  drv_ver_major;
> > +       __le16  drv_ver_minor;
> > +       __le16  drv_ver_sub_minor;
> > +
> > +       __le16  spec_ver_major;
> > +       __le16  spec_ver_minor;
> > +       __le16  pci_bdf;
> > +       __le32  pci_domain;
> > +
> > +       u8      os_ver_str[64];
> > +       u8      isa_str[64];
> > +};
> > +
> > +struct eea_aq_host_info_rep {
> > +#define EEA_HINFO_MAX_REP_LEN  1024
> > +#define EEA_HINFO_REP_PASS     1
> > +#define EEA_HINFO_REP_REJECT   2
> > +       u8      op_code;
> > +       u8      has_reply;
> > +       u8      reply_str[EEA_HINFO_MAX_REP_LEN];
> > +};
> > +
> > +static struct ering *qid_to_ering(struct eea_net *enet, u32 qid)
> > +{
> > +       struct ering *ering;
> > +
> > +       if (qid % 2 =3D=3D 0)
> > +               ering =3D enet->rx[qid / 2]->ering;
> > +       else
> > +               ering =3D enet->tx[qid / 2].ering;
> > +
> > +       return ering;
> > +}
> > +
> > +#define EEA_AQ_TIMEOUT_US (60 * 1000 * 1000)
> > +
> > +static int eea_adminq_submit(struct eea_net *enet, u16 cmd,
> > +                            dma_addr_t req_addr, dma_addr_t res_addr,
> > +                            u32 req_size, u32 res_size)
> > +{
> > +       struct eea_aq_cdesc *cdesc;
> > +       struct eea_aq_desc *desc;
> > +       int ret;
> > +
> > +       desc =3D ering_aq_alloc_desc(enet->adminq.ring);
> > +
> > +       desc->classid =3D cmd >> 8;
> > +       desc->command =3D cmd & 0xff;
> > +
> > +       desc->data_addr =3D cpu_to_le64(req_addr);
> > +       desc->data_len =3D cpu_to_le32(req_size);
> > +
> > +       desc->reply_addr =3D cpu_to_le64(res_addr);
> > +       desc->reply_len =3D cpu_to_le32(res_size);
> > +
> > +       /* for update flags */
> > +       wmb();
> > +
> > +       desc->flags =3D cpu_to_le16(enet->adminq.phase);
> > +
> > +       ering_sq_commit_desc(enet->adminq.ring);
> > +
> > +       ering_kick(enet->adminq.ring);
> > +
> > +       ++enet->adminq.num;
> > +
> > +       if ((enet->adminq.num % enet->adminq.ring->num) =3D=3D 0)
> > +               enet->adminq.phase ^=3D ERING_DESC_F_AQ_PHASE;
> > +
> > +       ret =3D read_poll_timeout(ering_cq_get_desc, cdesc, cdesc, 0,
> > +                               EEA_AQ_TIMEOUT_US, false, enet->adminq.=
ring);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret =3D le32_to_cpu(cdesc->status);
> > +
> > +       ering_cq_ack_desc(enet->adminq.ring, 1);
> > +
> > +       if (ret)
> > +               netdev_err(enet->netdev,
> > +                          "adminq exec failed. cmd: %d ret %d\n", cmd,=
 ret);
> > +
> > +       return ret;
> > +}
> > +
> > +static int eea_adminq_exec(struct eea_net *enet, u16 cmd,
> > +                          void *req, u32 req_size, void *res, u32 res_=
size)
> > +{
> > +       dma_addr_t req_addr, res_addr;
> > +       struct device *dma;
> > +       int ret;
> > +
> > +       dma =3D enet->edev->dma_dev;
> > +
> > +       req_addr =3D 0;
> > +       res_addr =3D 0;
> > +
> > +       if (req) {
> > +               req_addr =3D dma_map_single(dma, req, req_size, DMA_TO_=
DEVICE);
> > +               if (unlikely(dma_mapping_error(dma, req_addr)))
> > +                       return -ENOMEM;
> > +       }
> > +
> > +       if (res) {
> > +               res_addr =3D dma_map_single(dma, res, res_size, DMA_FRO=
M_DEVICE);
> > +               if (unlikely(dma_mapping_error(dma, res_addr))) {
> > +                       ret =3D -ENOMEM;
> > +                       goto err_map_res;
> > +               }
> > +       }
> > +
> > +       ret =3D eea_adminq_submit(enet, cmd, req_addr, res_addr,
> > +                               req_size, res_size);
> > +
>
> There is no need for this empty line before the if condition check.
> >
> > +       if (res)
> > +               dma_unmap_single(dma, res_addr, res_size, DMA_FROM_DEVI=
CE);
> > +
> > +err_map_res:
> > +       if (req)
> > +               dma_unmap_single(dma, req_addr, req_size, DMA_TO_DEVICE=
);
> > +
> > +       return ret;
> > +}
> > +
> > +void eea_destroy_adminq(struct eea_net *enet)
> > +{
> > +       /* Unactive adminq by device reset. So the device reset should =
be called
> > +        * before this.
> > +        */
> > +       if (enet->adminq.ring) {
> > +               ering_free(enet->adminq.ring);
> > +               enet->adminq.ring =3D NULL;
> > +               enet->adminq.phase =3D 0;
> > +       }
> > +}
> > +
> > +int eea_create_adminq(struct eea_net *enet, u32 qid)
> > +{
> > +       struct ering *ering;
> > +       int err;
> > +
> > +       ering =3D ering_alloc(qid, 64, enet->edev, sizeof(struct eea_aq=
_desc),
> > +                           sizeof(struct eea_aq_desc), "adminq");
> > +       if (!ering)
> > +               return -ENOMEM;
> > +
> > +       err =3D eea_pci_active_aq(ering);
> > +       if (err) {
> > +               ering_free(ering);
> > +               return -EBUSY;
>
> Do not override the error code here
> >
> > +       }
> > +
> > +       enet->adminq.ring =3D ering;
> > +       enet->adminq.phase =3D BIT(7);
> > +       enet->adminq.num =3D 0;
> > +
> > +       /* set device ready to active adminq */
> > +       eea_device_ready(enet->edev);
> > +
> > +       return 0;
> > +}
> > +
> > +int eea_adminq_query_cfg(struct eea_net *enet, struct eea_aq_cfg *cfg)
> > +{
> > +       return eea_adminq_exec(enet, EEA_AQ_CMD_CFG_QUERY, NULL, 0, cfg,
> > +                              sizeof(*cfg));
> > +}
> > +
> > +static void qcfg_fill(struct eea_aq_create *qcfg, struct ering *ering,
> > +                     u32 flags)
> > +{
> > +       qcfg->flags =3D cpu_to_le32(flags);
> > +       qcfg->qidx =3D cpu_to_le16(ering->index);
> > +       qcfg->depth =3D cpu_to_le16(ering->num);
> > +
> > +       qcfg->hdr_buf_size =3D flags & EEA_QUEUE_FLAGS_HW_SPLIT_HDR ? 1=
 : 0;
> > +       qcfg->sq_desc_size =3D ering->sq.desc_size;
> > +       qcfg->cq_desc_size =3D ering->cq.desc_size;
> > +       qcfg->msix_vector =3D cpu_to_le16(ering->msix_vec);
> > +
> > +       qcfg->sq_addr_low =3D cpu_to_le32(ering->sq.dma_addr);
> > +       qcfg->sq_addr_high =3D cpu_to_le32(ering->sq.dma_addr >> 32);
> > +
> > +       qcfg->cq_addr_low =3D cpu_to_le32(ering->cq.dma_addr);
> > +       qcfg->cq_addr_high =3D cpu_to_le32(ering->cq.dma_addr >> 32);
> > +}
> > +
> > +int eea_adminq_create_q(struct eea_net *enet, u32 qidx, u32 num, u32 f=
lags)
> > +{
> > +       struct device *dev =3D enet->edev->dma_dev;
> > +       int i, err, db_size, q_size, qid;
> > +       struct eea_aq_create *q_buf;
> > +       dma_addr_t db_dma, q_dma;
> > +       struct eea_net_cfg *cfg;
> > +       struct ering *ering;
> > +       __le32 *db_buf;
> > +
> > +       err =3D -ENOMEM;
>
> you can initialize "err" in the line above where it is declared
> >
> > +
> > +       cfg =3D &enet->cfg;
> > +
> > +       if (cfg->split_hdr)
> > +               flags |=3D EEA_QUEUE_FLAGS_HW_SPLIT_HDR;
> > +
> > +       flags |=3D EEA_QUEUE_FLAGS_SQCQ;
> > +       flags |=3D EEA_QUEUE_FLAGS_HWTS;
> > +
> > +       db_size =3D sizeof(int) * num;
> > +       q_size =3D sizeof(struct eea_aq_create) * num;
> > +
> > +       db_buf =3D dma_alloc_coherent(dev, db_size, &db_dma, GFP_KERNEL=
);
> > +       if (!db_buf)
> > +               return err;
> > +
> > +       q_buf =3D dma_alloc_coherent(dev, q_size, &q_dma, GFP_KERNEL);
> > +       if (!q_buf)
> > +               goto err_db;
> > +
> > +       qid =3D qidx;
> > +       for (i =3D 0; i < num; i++, qid++)
> > +               qcfg_fill(q_buf + i, qid_to_ering(enet, qid), flags);
> > +
> > +       err =3D eea_adminq_exec(enet, EEA_AQ_CMD_QUEUE_CREATE,
> > +                             q_buf, q_size, db_buf, db_size);
> > +       if (err)
> > +               goto err;
> > +       err =3D 0;
>
> I do not think this assignment is really needed
> >
> > +
> > +       qid =3D qidx;
> > +       for (i =3D 0; i < num; i++, qid++) {
> > +               ering =3D qid_to_ering(enet, qid);
> > +               ering->db =3D eea_pci_db_addr(ering->edev,
> > +                                           le32_to_cpu(db_buf[i]));
> > +       }
> > +
> > +err:
> > +       dma_free_coherent(dev, q_size, q_buf, q_dma);
> > +err_db:
> > +       dma_free_coherent(dev, db_size, db_buf, db_dma);
> > +       return err;
> > +}
> > +
> > +int eea_adminq_destroy_q(struct eea_net *enet, u32 qidx, int num)
> > +{
> > +       struct device *dev =3D enet->edev->dma_dev;
> > +       dma_addr_t dma_addr;
> > +       __le16 *buf;
> > +       u32 size;
> > +       int i;
> > +
> > +       if (qidx =3D=3D 0 && num =3D=3D -1)
> > +               return eea_adminq_exec(enet, EEA_AQ_CMD_QUEUE_DESTROY_A=
LL,
> > +                                      NULL, 0, NULL, 0);
> > +
> > +       size =3D sizeof(__le16) * num;
> > +       buf =3D dma_alloc_coherent(dev, size, &dma_addr, GFP_KERNEL);
> > +       if (!buf)
> > +               return -ENOMEM;
> > +
> > +       for (i =3D 0; i < num; ++i)
> > +               buf[i] =3D cpu_to_le16(qidx++);
> > +
> > +       return eea_adminq_exec(enet, EEA_AQ_CMD_QUEUE_DESTROY_Q,
> > +                              buf, size, NULL, 0);
>
> Don't you need to free buf before returning?
> >
> > +}
> > +
> > +struct aq_dev_status *eea_adminq_dev_status(struct eea_net *enet)
> > +{
> > +       struct aq_queue_drv_status *drv_status;
> > +       struct aq_dev_status *dev_status;
> > +       int err, i, num, size;
> > +       struct ering *ering;
> > +       void *rep, *req;
> > +
> > +       num =3D enet->cfg.tx_ring_num * 2 + 1;
> > +
> > +       req =3D kcalloc(num, sizeof(struct aq_queue_drv_status), GFP_KE=
RNEL);
> > +       if (!req)
> > +               return NULL;
> > +
> > +       size =3D struct_size(dev_status, q_status, num);
> > +
> > +       rep =3D kmalloc(size, GFP_KERNEL);
> > +       if (!rep) {
> > +               kfree(req);
> > +               return NULL;
> > +       }
> > +
> > +       drv_status =3D req;
> > +       for (i =3D 0; i < enet->cfg.rx_ring_num * 2; ++i, ++drv_status)=
 {
> > +               ering =3D qid_to_ering(enet, i);
> > +               drv_status->qidx =3D cpu_to_le16(i);
> > +               drv_status->cq_head =3D cpu_to_le16(ering->cq.head);
> > +               drv_status->sq_head =3D cpu_to_le16(ering->sq.head);
> > +       }
> > +
> > +       drv_status->qidx =3D cpu_to_le16(i);
> > +       drv_status->cq_head =3D cpu_to_le16(enet->adminq.ring->cq.head);
> > +       drv_status->sq_head =3D cpu_to_le16(enet->adminq.ring->sq.head);
> > +
> > +       err =3D eea_adminq_exec(enet, EEA_AQ_CMD_DEV_STATUS,
> > +                             req, num * sizeof(struct aq_queue_drv_sta=
tus),
> > +                             rep, size);
> > +       kfree(req);
> > +       if (err) {
> > +               kfree(rep);
> > +               return NULL;
> > +       }
> > +
> > +       return rep;
> > +}
> > +
> > +int eea_adminq_config_host_info(struct eea_net *enet)
> > +{
> > +       struct device *dev =3D enet->edev->dma_dev;
> > +       struct eea_aq_host_info_cfg *cfg;
> > +       struct eea_aq_host_info_rep *rep;
> > +       int rc =3D -ENOMEM;
> > +
> > +       cfg =3D kzalloc(sizeof(*cfg), GFP_KERNEL);
> > +       if (!cfg)
> > +               return rc;
> > +
> > +       rep =3D kzalloc(sizeof(*rep), GFP_KERNEL);
> > +       if (!rep)
> > +               goto free_cfg;
> > +
> > +       cfg->os_type            =3D cpu_to_le16(EEA_OS_LINUX);
> > +       cfg->os_dist            =3D cpu_to_le16(EEA_OS_DISTRO);
> > +       cfg->drv_type           =3D cpu_to_le16(EEA_DRV_TYPE);
> > +
> > +       cfg->kern_ver_major     =3D cpu_to_le16(LINUX_VERSION_MAJOR);
> > +       cfg->kern_ver_minor     =3D cpu_to_le16(LINUX_VERSION_PATCHLEVE=
L);
> > +       cfg->kern_ver_sub_minor =3D cpu_to_le16(LINUX_VERSION_SUBLEVEL);
> > +
> > +       cfg->drv_ver_major      =3D cpu_to_le16(EEA_VER_MAJOR);
> > +       cfg->drv_ver_minor      =3D cpu_to_le16(EEA_VER_MINOR);
> > +       cfg->drv_ver_sub_minor  =3D cpu_to_le16(EEA_VER_SUB_MINOR);
> > +
> > +       cfg->spec_ver_major     =3D cpu_to_le16(EEA_SPEC_VER_MAJOR);
> > +       cfg->spec_ver_minor     =3D cpu_to_le16(EEA_SPEC_VER_MINOR);
> > +
> > +       cfg->pci_bdf            =3D cpu_to_le16(eea_pci_dev_id(enet->ed=
ev));
> > +       cfg->pci_domain         =3D cpu_to_le32(eea_pci_domain_nr(enet-=
>edev));
> > +
> > +       strscpy(cfg->os_ver_str, utsname()->release, sizeof(cfg->os_ver=
_str));
> > +       strscpy(cfg->isa_str, utsname()->machine, sizeof(cfg->isa_str));
> > +
> > +       rc =3D eea_adminq_exec(enet, EEA_AQ_CMD_HOST_INFO,
> > +                            cfg, sizeof(*cfg), rep, sizeof(*rep));
> > +
> > +       if (!rc) {
> > +               if (rep->op_code =3D=3D EEA_HINFO_REP_REJECT) {
> > +                       dev_err(dev, "Device has refused the initializa=
tion "
> > +                               "due to provided host information\n");
> > +                       rc =3D -ENODEV;
> > +               }
> > +               if (rep->has_reply) {
> > +                       rep->reply_str[EEA_HINFO_MAX_REP_LEN - 1] =3D '=
\0';
> > +                       dev_warn(dev, "Device replied in host_info conf=
ig: %s",
> > +                                rep->reply_str);
> > +               }
> > +       }
> > +
> > +       kfree(rep);
> > +free_cfg:
> > +       kfree(cfg);
> > +       return rc;
> > +}
> > diff --git a/drivers/net/ethernet/alibaba/eea/eea_adminq.h b/drivers/ne=
t/ethernet/alibaba/eea/eea_adminq.h
> > new file mode 100644
> > index 000000000000..cba07263cf77
> > --- /dev/null
> > +++ b/drivers/net/ethernet/alibaba/eea/eea_adminq.h
> > @@ -0,0 +1,70 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * Driver for Alibaba Elastic Ethernet Adaptor.
> > + *
> > + * Copyright (C) 2025 Alibaba Inc.
> > + */
> > +
> > +#include "eea_pci.h"
> > +
> > +#ifndef __EEA_ADMINQ_H__
> > +#define __EEA_ADMINQ_H__
> > +
> > +struct eea_aq_cfg {
> > +       __le32 rx_depth_max;
> > +       __le32 rx_depth_def;
> > +
> > +       __le32 tx_depth_max;
> > +       __le32 tx_depth_def;
> > +
> > +       __le32 max_tso_size;
> > +       __le32 max_tso_segs;
> > +
> > +       u8 mac[ETH_ALEN];
> > +       __le16 status;
> > +
> > +       __le16 mtu;
> > +       __le16 reserved0;
> > +       __le16 reserved1;
> > +       u8 reserved2;
> > +       u8 reserved3;
> > +
> > +       __le16 reserved4;
> > +       __le16 reserved5;
> > +       __le16 reserved6;
> > +};
> > +
> > +struct eea_aq_queue_status {
> > +       __le16 qidx;
> > +#define EEA_QUEUE_STATUS_OK 0
> > +#define EEA_QUEUE_STATUS_NEED_RESET 1
> > +       __le16 status;
> > +};
> > +
> > +struct aq_dev_status {
> > +#define EEA_LINK_DOWN_STATUS  0
> > +#define EEA_LINK_UP_STATUS    1
> > +       __le16 link_status;
> > +       __le16 reserved;
> > +
> > +       struct eea_aq_queue_status q_status[];
> > +};
> > +
> > +struct eea_aq {
> > +       struct ering *ring;
> > +       u32 num;
> > +       u16 phase;
> > +};
> > +
> > +struct eea_net;
> > +
> > +int eea_create_adminq(struct eea_net *enet, u32 qid);
> > +void eea_destroy_adminq(struct eea_net *enet);
> > +
> > +int eea_adminq_query_cfg(struct eea_net *enet, struct eea_aq_cfg *cfg);
> > +
> > +int eea_adminq_create_q(struct eea_net *enet, u32 qidx, u32 num, u32 f=
lags);
> > +int eea_adminq_destroy_q(struct eea_net *enet, u32 qidx, int num);
> > +struct aq_dev_status *eea_adminq_dev_status(struct eea_net *enet);
> > +int eea_adminq_config_host_info(struct eea_net *enet);
> > +#endif
> > diff --git a/drivers/net/ethernet/alibaba/eea/eea_desc.h b/drivers/net/=
ethernet/alibaba/eea/eea_desc.h
> > new file mode 100644
> > index 000000000000..247974dc78ba
> > --- /dev/null
> > +++ b/drivers/net/ethernet/alibaba/eea/eea_desc.h
> > @@ -0,0 +1,155 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * Driver for Alibaba Elastic Ethernet Adaptor.
> > + *
> > + * Copyright (C) 2025 Alibaba Inc.
> > + */
> > +
> > +#ifndef __EEA_DESC_H__
> > +#define __EEA_DESC_H__
> > +
> > +#define EEA_DESC_TS_MASK GENMASK(47, 0)
> > +#define EEA_DESC_TS(desc) (le64_to_cpu((desc)->ts) & EEA_DESC_TS_MASK)
> > +
> > +struct eea_aq_desc {
> > +       __le16 flags;
> > +       __le16 id;
> > +       __le16 reserved;
> > +       u8 classid;
> > +       u8 command;
> > +       __le64 data_addr;
> > +       __le64 reply_addr;
> > +       __le32 data_len;
> > +       __le32 reply_len;
> > +};
> > +
> > +struct eea_aq_cdesc {
> > +       __le16 flags;
> > +       __le16 id;
> > +#define EEA_OK     0
> > +#define EEA_ERR    0xffffffff
> > +       __le32 status;
> > +       __le32 reply_len;
> > +       __le32 reserved1;
> > +
> > +       __le64 reserved2;
> > +       __le64 reserved3;
> > +};
> > +
> > +struct eea_rx_desc {
> > +       __le16 flags;
> > +       __le16 id;
> > +       __le16 len;
> > +       __le16 reserved1;
> > +
> > +       __le64 addr;
> > +
> > +       __le64 hdr_addr;
> > +       __le32 reserved2;
> > +       __le32 reserved3;
> > +};
> > +
> > +#define EEA_RX_CDEC_HDR_LEN_MASK GENMASK(9, 0)
> > +
> > +struct eea_rx_cdesc {
> > +#define EEA_DESC_F_DATA_VALID  BIT(6)
> > +#define EEA_DESC_F_SPLIT_HDR   BIT(5)
> > +       __le16 flags;
> > +       __le16 id;
> > +       __le16 len;
> > +#define EEA_NET_PT_NONE      0
> > +#define EEA_NET_PT_IPv4      1
> > +#define EEA_NET_PT_TCPv4     2
> > +#define EEA_NET_PT_UDPv4     3
> > +#define EEA_NET_PT_IPv6      4
> > +#define EEA_NET_PT_TCPv6     5
> > +#define EEA_NET_PT_UDPv6     6
> > +#define EEA_NET_PT_IPv6_EX   7
> > +#define EEA_NET_PT_TCPv6_EX  8
> > +#define EEA_NET_PT_UDPv6_EX  9
> > +       /* [9:0] is packet type. */
> > +       __le16 type;
> > +
> > +       /* hw timestamp [0:47]: ts */
> > +       __le64 ts;
> > +
> > +       __le32 hash;
> > +
> > +       /* 0-9: hdr_len  split header
> > +        * 10-15: reserved1
> > +        */
> > +       __le16 len_ex;
> > +       __le16 reserved2;
> > +
> > +       __le32 reserved3;
> > +       __le32 reserved4;
> > +};
> > +
> > +#define EEA_TX_GSO_NONE   0
> > +#define EEA_TX_GSO_TCPV4  1
> > +#define EEA_TX_GSO_TCPV6  4
> > +#define EEA_TX_GSO_UDP_L4 5
> > +#define EEA_TX_GSO_ECN    0x80
> > +
> > +struct eea_tx_desc {
> > +#define EEA_DESC_F_DO_CSUM     BIT(6)
> > +       __le16 flags;
> > +       __le16 id;
> > +       __le16 len;
> > +       __le16 reserved1;
> > +
> > +       __le64 addr;
> > +
> > +       __le16 csum_start;
> > +       __le16 csum_offset;
> > +       u8 gso_type;
> > +       u8 reserved2;
> > +       __le16 gso_size;
> > +       __le64 reserved3;
> > +};
> > +
> > +struct eea_tx_cdesc {
> > +       __le16 flags;
> > +       __le16 id;
> > +       __le16 len;
> > +       __le16 reserved1;
> > +
> > +       /* hw timestamp [0:47]: ts */
> > +       __le64 ts;
> > +       __le64 reserved2;
> > +       __le64 reserved3;
> > +};
> > +
> > +struct db {
> > +#define EEA_IDX_PRESENT   BIT(0)
> > +#define EEA_IRQ_MASK      BIT(1)
> > +#define EEA_IRQ_UNMASK    BIT(2)
> > +#define EEA_DIRECT_INLINE BIT(3)
> > +#define EEA_DIRECT_DESC   BIT(4)
> > +       u8 kick_flags;
> > +       u8 reserved;
> > +       __le16 idx;
> > +
> > +       __le16 tx_cq_head;
> > +       __le16 rx_cq_head;
> > +};
> > +
> > +struct db_direct {
> > +       u8 kick_flags;
> > +       u8 reserved;
> > +       __le16 idx;
> > +
> > +       __le16 tx_cq_head;
> > +       __le16 rx_cq_head;
> > +
> > +       u8 desc[24];
> > +};
> > +
> > +static_assert(sizeof(struct eea_rx_desc) =3D=3D 32, "rx desc size does=
 not match");
> > +static_assert(sizeof(struct eea_rx_cdesc) =3D=3D 32,
> > +             "rx cdesc size does not match");
> > +static_assert(sizeof(struct eea_tx_desc) =3D=3D 32, "tx desc size does=
 not match");
> > +static_assert(sizeof(struct eea_tx_cdesc) =3D=3D 32,
> > +             "tx cdesc size does not match");
> > +static_assert(sizeof(struct db_direct) =3D=3D 32, "db direct size does=
 not match");
> > +#endif
> > diff --git a/drivers/net/ethernet/alibaba/eea/eea_ethtool.c b/drivers/n=
et/ethernet/alibaba/eea/eea_ethtool.c
> > new file mode 100644
> > index 000000000000..39fd65929295
> > --- /dev/null
> > +++ b/drivers/net/ethernet/alibaba/eea/eea_ethtool.c
> > @@ -0,0 +1,310 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Driver for Alibaba Elastic Ethernet Adaptor.
> > + *
> > + * Copyright (C) 2025 Alibaba Inc.
> > + */
> > +
> > +#include <linux/ethtool.h>
> > +#include <linux/ethtool_netlink.h>
> > +
> > +#include "eea_adminq.h"
> > +
> > +struct eea_stat_desc {
> > +       char desc[ETH_GSTRING_LEN];
> > +       size_t offset;
> > +};
> > +
> > +#define EEA_TX_STAT(m) {#m, offsetof(struct eea_tx_stats, m)}
> > +#define EEA_RX_STAT(m) {#m, offsetof(struct eea_rx_stats, m)}
> > +
> > +static const struct eea_stat_desc eea_rx_stats_desc[] =3D {
> > +       EEA_RX_STAT(descs),
> > +       EEA_RX_STAT(drops),
> > +       EEA_RX_STAT(kicks),
> > +       EEA_RX_STAT(split_hdr_bytes),
> > +       EEA_RX_STAT(split_hdr_packets),
> > +};
> > +
> > +static const struct eea_stat_desc eea_tx_stats_desc[] =3D {
> > +       EEA_TX_STAT(descs),
> > +       EEA_TX_STAT(drops),
> > +       EEA_TX_STAT(kicks),
> > +       EEA_TX_STAT(timeouts),
> > +};
> > +
> > +#define EEA_TX_STATS_LEN       ARRAY_SIZE(eea_tx_stats_desc)
> > +#define EEA_RX_STATS_LEN       ARRAY_SIZE(eea_rx_stats_desc)
> > +
> > +static void eea_get_drvinfo(struct net_device *netdev,
> > +                           struct ethtool_drvinfo *info)
> > +{
> > +       struct eea_net *enet =3D netdev_priv(netdev);
> > +       struct eea_device *edev =3D enet->edev;
> > +
> > +       strscpy(info->driver,   KBUILD_MODNAME,     sizeof(info->driver=
));
> > +       strscpy(info->bus_info, eea_pci_name(edev), sizeof(info->bus_in=
fo));
> > +}
> > +
> > +static void eea_get_ringparam(struct net_device *netdev,
> > +                             struct ethtool_ringparam *ring,
> > +                             struct kernel_ethtool_ringparam *kernel_r=
ing,
> > +                             struct netlink_ext_ack *extack)
> > +{
> > +       struct eea_net *enet =3D netdev_priv(netdev);
> > +
> > +       ring->rx_max_pending =3D enet->cfg_hw.rx_ring_depth;
> > +       ring->tx_max_pending =3D enet->cfg_hw.tx_ring_depth;
> > +       ring->rx_pending =3D enet->cfg.rx_ring_depth;
> > +       ring->tx_pending =3D enet->cfg.tx_ring_depth;
> > +
> > +       kernel_ring->tcp_data_split =3D enet->cfg.split_hdr ?
> > +                                     ETHTOOL_TCP_DATA_SPLIT_ENABLED :
> > +                                     ETHTOOL_TCP_DATA_SPLIT_DISABLED;
> > +}
> > +
> > +static int eea_set_ringparam(struct net_device *netdev,
> > +                            struct ethtool_ringparam *ring,
> > +                            struct kernel_ethtool_ringparam *kernel_ri=
ng,
> > +                            struct netlink_ext_ack *extack)
> > +{
> > +       struct eea_net *enet =3D netdev_priv(netdev);
> > +       struct eea_net_tmp tmp =3D {};
> > +       bool need_update =3D false;
> > +       struct eea_net_cfg *cfg;
> > +       bool sh;
> > +
> > +       enet_mk_tmp_cfg(enet, &tmp);
> > +
> > +       cfg =3D &tmp.cfg;
> > +
> > +       if (ring->rx_mini_pending || ring->rx_jumbo_pending)
> > +               return -EINVAL;
> > +
> > +       if (ring->rx_pending > enet->cfg_hw.rx_ring_depth)
> > +               return -EINVAL;
> > +
> > +       if (ring->tx_pending > enet->cfg_hw.tx_ring_depth)
> > +               return -EINVAL;
> > +
> > +       if (ring->rx_pending !=3D cfg->rx_ring_depth)
> > +               need_update =3D true;
> > +
> > +       if (ring->tx_pending !=3D cfg->tx_ring_depth)
> > +               need_update =3D true;
> > +
> > +       sh =3D kernel_ring->tcp_data_split =3D=3D ETHTOOL_TCP_DATA_SPLI=
T_ENABLED;
> > +       if (sh !=3D !!(cfg->split_hdr))
> > +               need_update =3D true;
> > +
> > +       if (!need_update)
> > +               return 0;
> > +
> > +       cfg->rx_ring_depth =3D ring->rx_pending;
> > +       cfg->tx_ring_depth =3D ring->tx_pending;
> > +
> > +       cfg->split_hdr =3D sh ? enet->cfg_hw.split_hdr : 0;
> > +
> > +       return eea_reset_hw_resources(enet, &tmp);
> > +}
> > +
> > +static int eea_set_channels(struct net_device *netdev,
> > +                           struct ethtool_channels *channels)
> > +{
> > +       struct eea_net *enet =3D netdev_priv(netdev);
> > +       u16 queue_pairs =3D channels->combined_count;
> > +       struct eea_net_tmp tmp =3D {};
> > +       struct eea_net_cfg *cfg;
> > +
> > +       enet_mk_tmp_cfg(enet, &tmp);
> > +
> > +       cfg =3D &tmp.cfg;
> > +
> > +       if (channels->rx_count || channels->tx_count || channels->other=
_count)
> > +               return -EINVAL;
> > +
> > +       if (queue_pairs > enet->cfg_hw.rx_ring_num || queue_pairs =3D=
=3D 0)
> > +               return -EINVAL;
> > +
> > +       if (queue_pairs =3D=3D enet->cfg.rx_ring_num &&
> > +           queue_pairs =3D=3D enet->cfg.tx_ring_num)
> > +               return 0;
> > +
> > +       cfg->rx_ring_num =3D queue_pairs;
> > +       cfg->tx_ring_num =3D queue_pairs;
> > +
> > +       return eea_reset_hw_resources(enet, &tmp);
> > +}
> > +
> > +static void eea_get_channels(struct net_device *netdev,
> > +                            struct ethtool_channels *channels)
> > +{
> > +       struct eea_net *enet =3D netdev_priv(netdev);
> > +
> > +       channels->combined_count =3D enet->cfg.rx_ring_num;
> > +       channels->max_combined   =3D enet->cfg_hw.rx_ring_num;
> > +       channels->max_other      =3D 0;
> > +       channels->rx_count       =3D 0;
> > +       channels->tx_count       =3D 0;
> > +       channels->other_count    =3D 0;
> > +}
> > +
> > +static void eea_get_strings(struct net_device *netdev, u32 stringset, =
u8 *data)
> > +{
> > +       struct eea_net *enet =3D netdev_priv(netdev);
> > +       u8 *p =3D data;
> > +       u32 i, j;
> > +
> > +       if (stringset !=3D ETH_SS_STATS)
> > +               return;
> > +
> > +       for (i =3D 0; i < enet->cfg.rx_ring_num; i++) {
> > +               for (j =3D 0; j < EEA_RX_STATS_LEN; j++)
> > +                       ethtool_sprintf(&p, "rx%u_%s", i,
> > +                                       eea_rx_stats_desc[j].desc);
> > +       }
> > +
> > +       for (i =3D 0; i < enet->cfg.tx_ring_num; i++) {
> > +               for (j =3D 0; j < EEA_TX_STATS_LEN; j++)
> > +                       ethtool_sprintf(&p, "tx%u_%s", i,
> > +                                       eea_tx_stats_desc[j].desc);
> > +       }
> > +}
> > +
> > +static int eea_get_sset_count(struct net_device *netdev, int sset)
> > +{
> > +       struct eea_net *enet =3D netdev_priv(netdev);
> > +
> > +       if (sset !=3D ETH_SS_STATS)
> > +               return -EOPNOTSUPP;
> > +
> > +       return enet->cfg.rx_ring_num * (EEA_RX_STATS_LEN + EEA_TX_STATS=
_LEN);
> > +}
> > +
> > +static void eea_stats_fill_for_q(struct u64_stats_sync *syncp, u32 num,
> > +                                const struct eea_stat_desc *desc,
> > +                                u64 *data, u32 idx)
> > +{
> > +       void *stats_base =3D (void *)syncp;
> > +       u32 start, i;
> > +
> > +       do {
> > +               start =3D u64_stats_fetch_begin(syncp);
> > +               for (i =3D 0; i < num; i++)
> > +                       data[idx + i] =3D
> > +                               u64_stats_read(stats_base + desc[i].off=
set);
> > +
> > +       } while (u64_stats_fetch_retry(syncp, start));
> > +}
> > +
> > +static void eea_get_ethtool_stats(struct net_device *netdev,
> > +                                 struct ethtool_stats *stats, u64 *dat=
a)
> > +{
> > +       struct eea_net *enet =3D netdev_priv(netdev);
> > +       u32 i, idx =3D 0;
> > +
> > +       for (i =3D 0; i < enet->cfg.rx_ring_num; i++) {
> > +               struct enet_rx *rx =3D enet->rx[i];
> > +
> > +               eea_stats_fill_for_q(&rx->stats.syncp, EEA_RX_STATS_LEN,
> > +                                    eea_rx_stats_desc, data, idx);
> > +
> > +               idx +=3D EEA_RX_STATS_LEN;
> > +       }
> > +
> > +       for (i =3D 0; i < enet->cfg.tx_ring_num; i++) {
> > +               struct enet_tx *tx =3D &enet->tx[i];
> > +
> > +               eea_stats_fill_for_q(&tx->stats.syncp, EEA_TX_STATS_LEN,
> > +                                    eea_tx_stats_desc, data, idx);
> > +
> > +               idx +=3D EEA_TX_STATS_LEN;
> > +       }
> > +}
> > +
> > +void eea_update_rx_stats(struct eea_rx_stats *rx_stats,
> > +                        struct eea_rx_ctx_stats *stats)
> > +{
> > +       u64_stats_update_begin(&rx_stats->syncp);
> > +       u64_stats_add(&rx_stats->descs,             stats->descs);
> > +       u64_stats_add(&rx_stats->packets,           stats->packets);
> > +       u64_stats_add(&rx_stats->bytes,             stats->bytes);
> > +       u64_stats_add(&rx_stats->drops,             stats->drops);
> > +       u64_stats_add(&rx_stats->split_hdr_bytes,   stats->split_hdr_by=
tes);
> > +       u64_stats_add(&rx_stats->split_hdr_packets, stats->split_hdr_pa=
ckets);
> > +       u64_stats_add(&rx_stats->length_errors,     stats->length_error=
s);
> > +       u64_stats_update_end(&rx_stats->syncp);
> > +}
> > +
> > +void eea_stats(struct net_device *netdev, struct rtnl_link_stats64 *to=
t)
> > +{
> > +       struct eea_net *enet =3D netdev_priv(netdev);
> > +       u64 packets, bytes;
> > +       u32 start;
> > +       int i;
> > +
> > +       if (enet->rx) {
> > +               for (i =3D 0; i < enet->cfg.rx_ring_num; i++) {
> > +                       struct enet_rx *rx =3D enet->rx[i];
> > +
> > +                       do {
> > +                               start =3D u64_stats_fetch_begin(&rx->st=
ats.syncp);
> > +                               packets =3D u64_stats_read(&rx->stats.p=
ackets);
> > +                               bytes =3D u64_stats_read(&rx->stats.byt=
es);
> > +                       } while (u64_stats_fetch_retry(&rx->stats.syncp,
> > +                                                      start));
> > +
> > +                       tot->rx_packets +=3D packets;
> > +                       tot->rx_bytes   +=3D bytes;
> > +               }
> > +       }
> > +
> > +       if (enet->tx) {
> > +               for (i =3D 0; i < enet->cfg.tx_ring_num; i++) {
> > +                       struct enet_tx *tx =3D &enet->tx[i];
> > +
> > +                       do {
> > +                               start =3D u64_stats_fetch_begin(&tx->st=
ats.syncp);
> > +                               packets =3D u64_stats_read(&tx->stats.p=
ackets);
> > +                               bytes =3D u64_stats_read(&tx->stats.byt=
es);
> > +                       } while (u64_stats_fetch_retry(&tx->stats.syncp,
> > +                                                      start));
> > +
> > +                       tot->tx_packets +=3D packets;
> > +                       tot->tx_bytes   +=3D bytes;
> > +               }
> > +       }
> > +}
> > +
> > +static int eea_get_link_ksettings(struct net_device *netdev,
> > +                                 struct ethtool_link_ksettings *cmd)
> > +{
> > +       struct eea_net *enet =3D netdev_priv(netdev);
> > +
> > +       cmd->base.speed  =3D enet->speed;
> > +       cmd->base.duplex =3D enet->duplex;
> > +       cmd->base.port   =3D PORT_OTHER;
> > +
> > +       return 0;
> > +}
> > +
> > +static int eea_set_link_ksettings(struct net_device *netdev,
> > +                                 const struct ethtool_link_ksettings *=
cmd)
> > +{
> > +       return -EOPNOTSUPP;
> > +}
> > +
> > +const struct ethtool_ops eea_ethtool_ops =3D {
> > +       .supported_ring_params =3D ETHTOOL_RING_USE_TCP_DATA_SPLIT,
> > +       .get_drvinfo        =3D eea_get_drvinfo,
> > +       .get_link           =3D ethtool_op_get_link,
> > +       .get_ringparam      =3D eea_get_ringparam,
> > +       .set_ringparam      =3D eea_set_ringparam,
> > +       .set_channels       =3D eea_set_channels,
> > +       .get_channels       =3D eea_get_channels,
> > +       .get_strings        =3D eea_get_strings,
> > +       .get_sset_count     =3D eea_get_sset_count,
> > +       .get_ethtool_stats  =3D eea_get_ethtool_stats,
> > +       .get_link_ksettings =3D eea_get_link_ksettings,
> > +       .set_link_ksettings =3D eea_set_link_ksettings,
>
> I think there is no need to set this op when you are not supporting the f=
eature.
> >
> > +};
> > diff --git a/drivers/net/ethernet/alibaba/eea/eea_ethtool.h b/drivers/n=
et/ethernet/alibaba/eea/eea_ethtool.h
> > new file mode 100644
> > index 000000000000..ea1ce00b7b56
> > --- /dev/null
> > +++ b/drivers/net/ethernet/alibaba/eea/eea_ethtool.h
> > @@ -0,0 +1,51 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * Driver for Alibaba Elastic Ethernet Adaptor.
> > + *
> > + * Copyright (C) 2025 Alibaba Inc.
> > + */
> > +
> > +#ifndef __EEA_ETHTOOL_H__
> > +#define __EEA_ETHTOOL_H__
> > +
> > +struct eea_tx_stats {
> > +       struct u64_stats_sync syncp;
> > +       u64_stats_t descs;
> > +       u64_stats_t packets;
> > +       u64_stats_t bytes;
> > +       u64_stats_t drops;
> > +       u64_stats_t kicks;
> > +       u64_stats_t timeouts;
> > +};
> > +
> > +struct eea_rx_ctx_stats {
> > +       u64 descs;
> > +       u64 packets;
> > +       u64 bytes;
> > +       u64 drops;
> > +       u64 split_hdr_bytes;
> > +       u64 split_hdr_packets;
> > +
> > +       u64 length_errors;
> > +};
> > +
> > +struct eea_rx_stats {
> > +       struct u64_stats_sync syncp;
> > +       u64_stats_t descs;
> > +       u64_stats_t packets;
> > +       u64_stats_t bytes;
> > +       u64_stats_t drops;
> > +       u64_stats_t kicks;
> > +       u64_stats_t split_hdr_bytes;
> > +       u64_stats_t split_hdr_packets;
> > +
> > +       u64_stats_t length_errors;
> > +};
> > +
> > +void eea_update_rx_stats(struct eea_rx_stats *rx_stats,
> > +                        struct eea_rx_ctx_stats *stats);
> > +void eea_stats(struct net_device *netdev, struct rtnl_link_stats64 *to=
t);
> > +
> > +extern const struct ethtool_ops eea_ethtool_ops;
> > +
> > +#endif
> > diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.c b/drivers/net/e=
thernet/alibaba/eea/eea_net.c
> > new file mode 100644
> > index 000000000000..7d1666ceb506
> > --- /dev/null
> > +++ b/drivers/net/ethernet/alibaba/eea/eea_net.c
> > @@ -0,0 +1,575 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Driver for Alibaba Elastic Ethernet Adaptor.
> > + *
> > + * Copyright (C) 2025 Alibaba Inc.
> > + */
> > +
> > +#include <linux/netdevice.h>
> > +#include <linux/etherdevice.h>
> > +#include <linux/module.h>
> > +#include <linux/rtnetlink.h>
> > +#include <net/netdev_queues.h>
> > +
> > +#include "eea_ring.h"
> > +#include "eea_net.h"
> > +#include "eea_pci.h"
> > +#include "eea_adminq.h"
> > +
> > +#define EEA_SPLIT_HDR_SIZE 128
> > +
> > +static void enet_bind_new_q_and_cfg(struct eea_net *enet,
> > +                                   struct eea_net_tmp *tmp)
> > +{
> > +       struct enet_rx *rx;
> > +       struct enet_tx *tx;
> > +       int i;
> > +
> > +       enet->cfg =3D tmp->cfg;
> > +
> > +       enet->rx =3D tmp->rx;
> > +       enet->tx =3D tmp->tx;
> > +
> > +       for (i =3D 0; i < tmp->cfg.rx_ring_num; i++) {
> > +               rx =3D tmp->rx[i];
> > +               tx =3D &tmp->tx[i];
> > +
> > +               rx->enet =3D enet;
> > +               tx->enet =3D enet;
> > +       }
> > +}
> > +
> > +void enet_mk_tmp_cfg(struct eea_net *enet, struct eea_net_tmp *tmp)
> > +{
> > +       tmp->netdev =3D enet->netdev;
> > +       tmp->edev =3D enet->edev;
> > +       tmp->cfg =3D enet->cfg;
> > +}
> > +
> > +/* see: eea_alloc_rxtx_q_mem. */
>
> What is this comment?
> >
> > +static void eea_free_rxtx_q_mem(struct eea_net *enet)
> > +{
> > +       struct enet_rx *rx;
> > +       struct enet_tx *tx;
> > +       int i;
> > +
> > +       for (i =3D 0; i < enet->cfg.rx_ring_num; i++) {
> > +               rx =3D enet->rx[i];
> > +               tx =3D &enet->tx[i];
> > +
> > +               eea_free_rx(rx);
> > +               eea_free_tx(tx);
> > +       }
> > +
> > +       /* We called __netif_napi_del(),
> > +        * we need to respect an RCU grace period before freeing enet->=
rx
> > +        */
> > +       synchronize_net();
> > +
> > +       kvfree(enet->rx);
> > +       kvfree(enet->tx);
> > +
> > +       enet->rx =3D NULL;
> > +       enet->tx =3D NULL;
> > +}
> > +
> > +/* alloc tx/rx: struct, ring, meta, pp, napi */
> > +static int eea_alloc_rxtx_q_mem(struct eea_net_tmp *tmp)
> > +{
> > +       struct enet_rx *rx;
> > +       struct enet_tx *tx;
> > +       int err, i;
> > +
> > +       tmp->tx =3D kvcalloc(tmp->cfg.tx_ring_num, sizeof(*tmp->tx), GF=
P_KERNEL);
> > +       if (!tmp->tx)
> > +               goto error_tx;
> > +
> > +       tmp->rx =3D kvcalloc(tmp->cfg.rx_ring_num, sizeof(*tmp->rx), GF=
P_KERNEL);
> > +       if (!tmp->rx)
> > +               goto error_rx;
> > +
> > +       tmp->cfg.rx_sq_desc_size =3D sizeof(struct eea_rx_desc);
> > +       tmp->cfg.rx_cq_desc_size =3D sizeof(struct eea_rx_cdesc);
> > +       tmp->cfg.tx_sq_desc_size =3D sizeof(struct eea_tx_desc);
> > +       tmp->cfg.tx_cq_desc_size =3D sizeof(struct eea_tx_cdesc);
> > +
> > +       tmp->cfg.tx_cq_desc_size /=3D 2;
> > +
> > +       if (!tmp->cfg.split_hdr)
> > +               tmp->cfg.rx_sq_desc_size /=3D 2;
> > +
> > +       for (i =3D 0; i < tmp->cfg.rx_ring_num; i++) {
> > +               rx =3D eea_alloc_rx(tmp, i);
> > +               if (!rx)
> > +                       goto err;
> > +
> > +               tmp->rx[i] =3D rx;
> > +
> > +               tx =3D tmp->tx + i;
> > +               err =3D eea_alloc_tx(tmp, tx, i);
> > +               if (err)
> > +                       goto err;
> > +       }
> > +
> > +       return 0;
> > +
> > +err:
> > +       for (i =3D 0; i < tmp->cfg.rx_ring_num; i++) {
> > +               rx =3D tmp->rx[i];
> > +               tx =3D tmp->tx + i;
> > +
> > +               eea_free_rx(rx);
> > +               eea_free_tx(tx);
> > +       }
> > +
> > +       kvfree(tmp->rx);
> > +
> > +error_rx:
> > +       kvfree(tmp->tx);
> > +
> > +error_tx:
> > +       return -ENOMEM;
> > +}
> > +
> > +static int eea_active_ring_and_irq(struct eea_net *enet)
> > +{
> > +       int err;
> > +
> > +       err =3D eea_adminq_create_q(enet, /* qidx =3D */ 0,
> > +                                 enet->cfg.rx_ring_num +
> > +                                 enet->cfg.tx_ring_num, 0);
> > +       if (err)
> > +               return err;
> > +
> > +       err =3D enet_rxtx_irq_setup(enet, 0, enet->cfg.rx_ring_num);
> > +       if (err) {
> > +               eea_adminq_destroy_q(enet, 0, -1);
> > +               return err;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int eea_unactive_ring_and_irq(struct eea_net *enet)
> > +{
> > +       struct enet_rx *rx;
> > +       int err, i;
> > +
> > +       err =3D eea_adminq_destroy_q(enet, 0, -1);
> > +       if (err)
> > +               netdev_warn(enet->netdev, "unactive rxtx ring failed.\n=
");
> > +
> > +       for (i =3D 0; i < enet->cfg.rx_ring_num; i++) {
> > +               rx =3D enet->rx[i];
> > +               eea_irq_free(rx);
> > +       }
> > +
> > +       return err;
> > +}
> > +
> > +/* stop rx napi, stop tx queue. */
> > +static int eea_stop_rxtx(struct net_device *netdev)
> > +{
> > +       struct eea_net *enet =3D netdev_priv(netdev);
> > +       int i;
> > +
> > +       netif_tx_disable(netdev);
> > +
> > +       for (i =3D 0; i < enet->cfg.rx_ring_num; i++)
> > +               enet_rx_stop(enet->rx[i]);
> > +
> > +       netif_carrier_off(netdev);
> > +
> > +       return 0;
> > +}
> > +
> > +static int eea_start_rxtx(struct net_device *netdev)
> > +{
> > +       struct eea_net *enet =3D netdev_priv(netdev);
> > +       int i, err;
> > +
> > +       err =3D netif_set_real_num_queues(netdev, enet->cfg.tx_ring_num,
> > +                                       enet->cfg.rx_ring_num);
> > +       if (err)
> > +               return err;
> > +
> > +       for (i =3D 0; i < enet->cfg.rx_ring_num; i++)
> > +               enet_rx_start(enet->rx[i]);
> > +
> > +       netif_tx_start_all_queues(netdev);
> > +       netif_carrier_on(netdev);
> > +
> > +       enet->started =3D true;
> > +
> > +       return 0;
> > +}
> > +
> > +static int eea_netdev_stop(struct net_device *netdev)
> > +{
> > +       struct eea_net *enet =3D netdev_priv(netdev);
> > +
> > +       if (!enet->started) {
> > +               netdev_warn(netdev, "eea netdev stop: but dev is not st=
arted.\n");
> > +               return 0;
> > +       }
>
> Is this check really needed?
> >
> > +
> > +       eea_stop_rxtx(netdev);
> > +       eea_unactive_ring_and_irq(enet);
> > +       eea_free_rxtx_q_mem(enet);
> > +
> > +       enet->started =3D false;
> > +
> > +       return 0;
> > +}
> > +
> > +static int eea_netdev_open(struct net_device *netdev)
> > +{
> > +       struct eea_net *enet =3D netdev_priv(netdev);
> > +       struct eea_net_tmp tmp =3D {};
> > +       int err;
> > +
> > +       if (enet->link_err) {
> > +               netdev_err(netdev, "netdev open err, because link error=
: %d\n",
> > +                          enet->link_err);
> > +               return -EBUSY;
> > +       }
> > +
> > +       enet_mk_tmp_cfg(enet, &tmp);
> > +
> > +       err =3D eea_alloc_rxtx_q_mem(&tmp);
> > +       if (err)
> > +               return err;
> > +
> > +       enet_bind_new_q_and_cfg(enet, &tmp);
> > +
> > +       err =3D eea_active_ring_and_irq(enet);
> > +       if (err)
> > +               return err;
> > +
> > +       return eea_start_rxtx(netdev);
> > +}
> > +
> > +/* resources: ring, buffers, irq */
> > +int eea_reset_hw_resources(struct eea_net *enet, struct eea_net_tmp *t=
mp)
> > +{
> > +       struct eea_net_tmp _tmp =3D {};
> > +       int err;
> > +
> > +       if (!tmp) {
> > +               enet_mk_tmp_cfg(enet, &_tmp);
> > +               tmp =3D &_tmp;
> > +       }
> > +
> > +       if (!netif_running(enet->netdev)) {
> > +               enet->cfg =3D tmp->cfg;
> > +               return 0;
> > +       }
> > +
> > +       err =3D eea_alloc_rxtx_q_mem(tmp);
> > +       if (err) {
> > +               netdev_warn(enet->netdev,
> > +                           "eea reset: alloc q failed. stop reset. err=
 %d\n",
> > +                           err);
> > +               return err;
> > +       }
> > +
> > +       eea_netdev_stop(enet->netdev);
> > +
> > +       enet_bind_new_q_and_cfg(enet, tmp);
> > +
> > +       err =3D eea_active_ring_and_irq(enet);
> > +       if (err) {
> > +               netdev_warn(enet->netdev,
> > +                           "eea reset: active new ring and irq failed.=
 err %d\n",
> > +                           err);
> > +               goto err;
> > +       }
> > +
> > +       err =3D eea_start_rxtx(enet->netdev);
> > +       if (err)
> > +               netdev_warn(enet->netdev,
> > +                           "eea reset: start queue failed. err %d\n", =
err);
> > +
> > +err:
> > +
> > +       return err;
> > +}
> > +
> > +int eea_queues_check_and_reset(struct eea_device *edev)
> > +{
> > +       struct aq_dev_status *dstatus __free(kfree) =3D NULL;
> > +       struct eea_aq_queue_status *qstatus;
> > +       struct eea_aq_queue_status *qs;
> > +       u32 need_reset =3D 0;
>
> you can change "need_reset" to a boolean variable
> >
> > +       int num, err, i;
> > +
> > +       num =3D edev->enet->cfg.tx_ring_num * 2 + 1;
> > +
> > +       rtnl_lock();
> > +
> > +       dstatus =3D eea_adminq_dev_status(edev->enet);
> > +       if (!dstatus) {
> > +               netdev_warn(edev->enet->netdev, "query queue status fai=
led.\n");
> > +               rtnl_unlock();
> > +               return -ENOMEM;
> > +       }
> > +
> > +       if (le16_to_cpu(dstatus->link_status) =3D=3D EEA_LINK_DOWN_STAT=
US) {
> > +               eea_netdev_stop(edev->enet->netdev);
> > +               edev->enet->link_err =3D EEA_LINK_ERR_LINK_DOWN;
> > +               netdev_warn(edev->enet->netdev, "device link is down. s=
top device.\n");
> > +               rtnl_unlock();
> > +               return 0;
> > +       }
> > +
> > +       qstatus =3D dstatus->q_status;
> > +
> > +       for (i =3D 0; i < num; ++i) {
> > +               qs =3D &qstatus[i];
> > +
> > +               if (le16_to_cpu(qs->status) =3D=3D EEA_QUEUE_STATUS_NEE=
D_RESET) {
> > +                       netdev_warn(edev->enet->netdev,
> > +                                   "queue status: queue %u needs to re=
set\n",
> > +                                   le16_to_cpu(qs->qidx));
> > +                       ++need_reset;
> > +               }
> > +       }
> > +
> > +       err =3D 0;
>
> you can set "err =3D 0" while declaring it
> >
> > +       if (need_reset)
> > +               err =3D eea_reset_hw_resources(edev->enet, NULL);
> > +
> > +       rtnl_unlock();
> > +       return err;
> > +}
> > +
> > +static void eea_update_cfg(struct eea_net *enet,
> > +                          struct eea_device *edev,
> > +                          struct eea_aq_cfg *hwcfg)
> > +{
> > +       enet->cfg_hw.rx_ring_depth =3D le32_to_cpu(hwcfg->rx_depth_max);
> > +       enet->cfg_hw.tx_ring_depth =3D le32_to_cpu(hwcfg->tx_depth_max);
> > +
> > +       enet->cfg_hw.rx_ring_num =3D edev->rx_num;
> > +       enet->cfg_hw.tx_ring_num =3D edev->tx_num;
> > +
> > +       enet->cfg.rx_ring_depth =3D le32_to_cpu(hwcfg->rx_depth_def);
> > +       enet->cfg.tx_ring_depth =3D le32_to_cpu(hwcfg->tx_depth_def);
> > +
> > +       enet->cfg.rx_ring_num =3D edev->rx_num;
> > +       enet->cfg.tx_ring_num =3D edev->tx_num;
> > +
> > +       enet->cfg_hw.split_hdr =3D EEA_SPLIT_HDR_SIZE;
> > +}
> > +
> > +static int eea_netdev_init_features(struct net_device *netdev,
> > +                                   struct eea_net *enet,
> > +                                   struct eea_device *edev)
> > +{
> > +       struct eea_aq_cfg *cfg __free(kfree) =3D NULL;
> > +       int err;
> > +       u32 mtu;
> >
> > +
> > +       cfg =3D kmalloc(sizeof(*cfg), GFP_KERNEL);
>
> NULL check is missing here
> >
> > +
> > +       err =3D eea_adminq_query_cfg(enet, cfg);
> > +
>
> there is no need of an empty line here
> >
> > +       if (err)
> > +               return err;
> > +
> > +       eea_update_cfg(enet, edev, cfg);
> > +
> > +       netdev->priv_flags |=3D IFF_UNICAST_FLT;
> > +       netdev->priv_flags |=3D IFF_LIVE_ADDR_CHANGE;
> > +
> > +       netdev->hw_features |=3D NETIF_F_HW_CSUM;
> > +       netdev->hw_features |=3D NETIF_F_GRO_HW;
> > +       netdev->hw_features |=3D NETIF_F_SG;
> > +       netdev->hw_features |=3D NETIF_F_TSO;
> > +       netdev->hw_features |=3D NETIF_F_TSO_ECN;
> > +       netdev->hw_features |=3D NETIF_F_TSO6;
> > +       netdev->hw_features |=3D NETIF_F_GSO_UDP_L4;
> > +
> > +       netdev->features |=3D NETIF_F_HIGHDMA;
> > +       netdev->features |=3D NETIF_F_HW_CSUM;
> > +       netdev->features |=3D NETIF_F_SG;
> > +       netdev->features |=3D NETIF_F_GSO_ROBUST;
> > +       netdev->features |=3D netdev->hw_features & NETIF_F_ALL_TSO;
> > +       netdev->features |=3D NETIF_F_RXCSUM;
> > +       netdev->features |=3D NETIF_F_GRO_HW;
> > +
> > +       netdev->vlan_features =3D netdev->features;
> > +
> > +       eth_hw_addr_set(netdev, cfg->mac);
> > +
> > +       enet->speed =3D SPEED_UNKNOWN;
> > +       enet->duplex =3D DUPLEX_UNKNOWN;
> > +
> > +       netdev->min_mtu =3D ETH_MIN_MTU;
> > +
> > +       mtu =3D le16_to_cpu(cfg->mtu);
> > +       if (mtu < netdev->min_mtu) {
> > +               dev_err(edev->dma_dev, "The device gave us an invalid M=
TU. "
> > +                       "Here we can only exit the initialization. %d <=
 %d",
> > +                       mtu, netdev->min_mtu);
> > +               return -EINVAL;
> > +       }
>
> I think you should make this condition check first and return before
> issuing eea_update_cfg() and updating netdev features flag
> >
> > +
> > +       netdev->mtu =3D mtu;
> > +
> > +       /* If jumbo frames are already enabled, then the returned MTU w=
ill be a
> > +        * jumbo MTU, and the driver will automatically enable jumbo fr=
ame
> > +        * support by default.
> > +        */
> > +       netdev->max_mtu =3D mtu;
> > +
> > +       netif_carrier_on(netdev);
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct net_device_ops eea_netdev =3D {
> > +       .ndo_open           =3D eea_netdev_open,
> > +       .ndo_stop           =3D eea_netdev_stop,
> > +       .ndo_start_xmit     =3D eea_tx_xmit,
> > +       .ndo_validate_addr  =3D eth_validate_addr,
> > +       .ndo_get_stats64    =3D eea_stats,
> > +       .ndo_features_check =3D passthru_features_check,
> > +       .ndo_tx_timeout     =3D eea_tx_timeout,
> > +};
> > +
> > +static struct eea_net *eea_netdev_alloc(struct eea_device *edev, u32 p=
airs)
> > +{
> > +       struct net_device *netdev;
> > +       struct eea_net *enet;
> > +
> > +       netdev =3D alloc_etherdev_mq(sizeof(struct eea_net), pairs);
> > +       if (!netdev) {
> > +               dev_err(edev->dma_dev,
> > +                       "alloc_etherdev_mq failed with pairs %d\n", pai=
rs);
> > +               return NULL;
> > +       }
> > +
> > +       netdev->netdev_ops =3D &eea_netdev;
> > +       netdev->ethtool_ops =3D &eea_ethtool_ops;
> > +       SET_NETDEV_DEV(netdev, edev->dma_dev);
> > +
> > +       enet =3D netdev_priv(netdev);
> > +       enet->netdev =3D netdev;
> > +       enet->edev =3D edev;
> > +       edev->enet =3D enet;
> > +
> > +       return enet;
> > +}
> > +
> > +static void eea_update_ts_off(struct eea_device *edev, struct eea_net =
*enet)
> > +{
> > +       u64 ts;
> > +
> > +       ts =3D eea_pci_device_ts(edev);
> > +
> > +       enet->hw_ts_offset =3D ktime_get_real() - ts;
> > +}
> > +
> > +static int eea_net_reprobe(struct eea_device *edev)
> > +{
> > +       struct eea_net *enet =3D edev->enet;
> > +       int err =3D 0;
> > +
> > +       enet->edev =3D edev;
> > +
> > +       if (!enet->adminq.ring) {
> > +               err =3D eea_create_adminq(enet, edev->rx_num + edev->tx=
_num);
> > +               if (err)
> > +                       return err;
> > +       }
> > +
> > +       eea_update_ts_off(edev, enet);
> > +
> > +       if (edev->ha_reset_netdev_running) {
> > +               rtnl_lock();
> > +               enet->link_err =3D 0;
> > +               err =3D eea_netdev_open(enet->netdev);
> > +               rtnl_unlock();
> > +       }
> > +
> > +       return err;
> > +}
> > +
> > +int eea_net_probe(struct eea_device *edev)
> > +{
> > +       struct eea_net *enet;
> > +       int err =3D -ENOMEM;
> > +
> > +       if (edev->ha_reset)
> > +               return eea_net_reprobe(edev);
> > +
> > +       enet =3D eea_netdev_alloc(edev, edev->rx_num);
> > +       if (!enet)
> > +               return -ENOMEM;
> > +
> > +       err =3D eea_create_adminq(enet, edev->rx_num + edev->tx_num);
> > +       if (err)
> > +               goto err_adminq;
> > +
> > +       err =3D eea_adminq_config_host_info(enet);
> > +       if (err)
> > +               goto err_hinfo;
> > +
> > +       err =3D eea_netdev_init_features(enet->netdev, enet, edev);
> > +       if (err)
> > +               goto err_feature;
> > +
> > +       err =3D register_netdev(enet->netdev);
> > +       if (err)
> > +               goto err_ready;
> > +
> > +       eea_update_ts_off(edev, enet);
> > +       netif_carrier_off(enet->netdev);
> > +
> > +       netdev_dbg(enet->netdev, "eea probe success.\n");
> > +
> > +       return 0;
> > +
> > +err_ready:
> > +err_feature:
> > +err_hinfo:
> > +       eea_device_reset(edev);
> > +       eea_destroy_adminq(enet);
> > +
> > +err_adminq:
> > +       free_netdev(enet->netdev);
> > +       return err;
> > +}
> > +
> > +void eea_net_remove(struct eea_device *edev)
> > +{
> > +       struct net_device *netdev;
> > +       struct eea_net *enet;
> > +
> > +       enet =3D edev->enet;
> > +       netdev =3D enet->netdev;
> > +
> > +       if (edev->ha_reset) {
> > +               edev->ha_reset_netdev_running =3D false;
> > +               if (netif_running(enet->netdev)) {
> > +                       rtnl_lock();
> > +                       eea_netdev_stop(enet->netdev);
> > +                       enet->link_err =3D EEA_LINK_ERR_HA_RESET_DEV;
> > +                       enet->edev =3D NULL;
> > +                       rtnl_unlock();
> > +                       edev->ha_reset_netdev_running =3D true;
> > +               }
> > +       } else {
> > +               unregister_netdev(netdev);
> > +               netdev_dbg(enet->netdev, "eea removed.\n");
> > +       }
> > +
> > +       eea_device_reset(edev);
> > +
> > +       /* free adminq */
> > +       eea_destroy_adminq(enet);
> > +
> > +       if (!edev->ha_reset)
> > +               free_netdev(netdev);
> > +}
> > diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.h b/drivers/net/e=
thernet/alibaba/eea/eea_net.h
> > new file mode 100644
> > index 000000000000..74e6a76c1f7f
> > --- /dev/null
> > +++ b/drivers/net/ethernet/alibaba/eea/eea_net.h
> > @@ -0,0 +1,196 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * Driver for Alibaba Elastic Ethernet Adaptor.
> > + *
> > + * Copyright (C) 2025 Alibaba Inc.
> > + */
> > +
> > +#ifndef __EEA_NET_H__
> > +#define __EEA_NET_H__
> > +
> > +#include <linux/netdevice.h>
> > +#include <linux/ethtool.h>
> > +
> > +#include "eea_ring.h"
> > +#include "eea_ethtool.h"
> > +#include "eea_adminq.h"
> > +
> > +#define EEA_VER_MAJOR          1
> > +#define EEA_VER_MINOR          0
> > +#define EEA_VER_SUB_MINOR      0
> > +
> > +struct eea_tx_meta;
> > +
> > +struct eea_reprobe {
> > +       struct eea_net *enet;
> > +       bool running_before_reprobe;
> > +};
> > +
> > +struct enet_tx {
> > +       struct eea_net *enet;
> > +
> > +       struct ering *ering;
> > +
> > +       struct eea_tx_meta *meta;
> > +       struct eea_tx_meta *free;
> > +
> > +       struct device *dma_dev;
> > +
> > +       u32 index;
> > +
> > +       char name[16];
> > +
> > +       struct eea_tx_stats stats;
> > +};
> > +
> > +struct eea_rx_meta {
> > +       struct eea_rx_meta *next;
> > +
> > +       struct page *page;
> > +       dma_addr_t dma;
> > +       u32 offset;
> > +       u32 frags;
> > +
> > +       struct page *hdr_page;
> > +       void *hdr_addr;
> > +       dma_addr_t hdr_dma;
> > +
> > +       u32 id;
> > +
> > +       u32 truesize;
> > +       u32 headroom;
> > +       u32 tailroom;
> > +       u32 room;
> > +
> > +       u32 len;
> > +};
> > +
> > +struct enet_rx_pkt_ctx {
> > +       u16 idx;
> > +
> > +       bool data_valid;
> > +       bool do_drop;
> > +
> > +       struct sk_buff *head_skb;
> > +       struct sk_buff *curr_skb;
> > +};
> > +
> > +struct enet_rx {
> > +       struct eea_net *enet;
> > +
> > +       struct ering *ering;
> > +
> > +       struct eea_rx_meta *meta;
> > +       struct eea_rx_meta *free;
> > +
> > +       struct device *dma_dev;
> > +
> > +       u32 index;
> > +
> > +       u32 flags;
> > +
> > +       u32 headroom;
> > +
> > +       struct napi_struct napi;
> > +
> > +       struct eea_rx_stats stats;
> > +
> > +       u16 irq_n;
> > +
> > +       char name[16];
> > +
> > +       struct enet_rx_pkt_ctx pkt;
> > +
> > +       struct page_pool *pp;
> > +};
> > +
> > +struct eea_net_cfg {
> > +       u32 rx_ring_depth;
> > +       u32 tx_ring_depth;
> > +       u32 rx_ring_num;
> > +       u32 tx_ring_num;
> > +
> > +       u8 rx_sq_desc_size;
> > +       u8 rx_cq_desc_size;
> > +       u8 tx_sq_desc_size;
> > +       u8 tx_cq_desc_size;
> > +
> > +       u32 split_hdr;
> > +
> > +       struct hwtstamp_config ts_cfg;
> > +};
> > +
> > +struct eea_net_tmp {
> > +       struct eea_net_cfg   cfg;
> > +
> > +       struct enet_tx      *tx;
> > +       struct enet_rx     **rx;
> > +
> > +       struct net_device   *netdev;
> > +       struct eea_device   *edev;
> > +};
> > +
> > +enum {
> > +       EEA_LINK_ERR_NONE,
> > +       EEA_LINK_ERR_HA_RESET_DEV,
> > +       EEA_LINK_ERR_LINK_DOWN,
> > +};
> > +
> > +struct eea_net {
> > +       struct eea_device *edev;
> > +       struct net_device *netdev;
> > +
> > +       struct eea_aq adminq;
> > +
> > +       struct enet_tx *tx;
> > +       struct enet_rx **rx;
> > +
> > +       struct eea_net_cfg cfg;
> > +       struct eea_net_cfg cfg_hw;
> > +
> > +       u32 link_err;
> > +
> > +       bool started;
> > +       bool cpu_aff_set;
> > +
> > +       u8 duplex;
> > +       u32 speed;
> > +
> > +       u64 hw_ts_offset;
> > +};
> > +
> > +int eea_tx_resize(struct eea_net *enet, struct enet_tx *tx, u32 ring_n=
um);
> > +
> > +int eea_net_probe(struct eea_device *edev);
> > +void eea_net_remove(struct eea_device *edev);
> > +int eea_net_freeze(struct eea_device *edev);
> > +int eea_net_restore(struct eea_device *edev);
> > +
> > +int eea_reset_hw_resources(struct eea_net *enet, struct eea_net_tmp *t=
mp);
> > +void enet_mk_tmp_cfg(struct eea_net *enet, struct eea_net_tmp *tmp);
> > +int eea_queues_check_and_reset(struct eea_device *edev);
> > +
> > +/* rx apis */
> > +int eea_poll(struct napi_struct *napi, int budget);
> > +
> > +void enet_rx_stop(struct enet_rx *rx);
> > +int enet_rx_start(struct enet_rx *rx);
> > +
> > +void eea_free_rx(struct enet_rx *rx);
> > +struct enet_rx *eea_alloc_rx(struct eea_net_tmp *tmp, u32 idx);
> > +
> > +int eea_irq_free(struct enet_rx *rx);
> > +
> > +int enet_rxtx_irq_setup(struct eea_net *enet, u32 qid, u32 num);
> > +
> > +/* tx apis */
> > +int eea_poll_tx(struct enet_tx *tx, int budget);
> > +void eea_poll_cleantx(struct enet_rx *rx);
> > +netdev_tx_t eea_tx_xmit(struct sk_buff *skb, struct net_device *netdev=
);
> > +
> > +void eea_tx_timeout(struct net_device *netdev, u32 txqueue);
> > +
> > +void eea_free_tx(struct enet_tx *tx);
> > +int eea_alloc_tx(struct eea_net_tmp *tmp, struct enet_tx *tx, u32 idx);
> > +
> > +#endif
> > diff --git a/drivers/net/ethernet/alibaba/eea/eea_pci.c b/drivers/net/e=
thernet/alibaba/eea/eea_pci.c
> > new file mode 100644
> > index 000000000000..df84f9a9c543
> > --- /dev/null
> > +++ b/drivers/net/ethernet/alibaba/eea/eea_pci.c
> > @@ -0,0 +1,574 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Driver for Alibaba Elastic Ethernet Adaptor.
> > + *
> > + * Copyright (C) 2025 Alibaba Inc.
> > + */
> > +
> > +#include <linux/iopoll.h>
> > +#include <linux/io-64-nonatomic-lo-hi.h>
> > +
> > +#include "eea_pci.h"
> > +#include "eea_net.h"
> > +
> > +#define EEA_PCI_DB_OFFSET 4096
> > +
> > +#define EEA_PCI_CAP_RESET_DEVICE 0xFA
> > +#define EEA_PCI_CAP_RESET_FLAG BIT(1)
> > +
> > +struct eea_pci_cfg {
> > +       __le32 reserve0;
> > +       __le32 reserve1;
> > +       __le32 drv_f_idx;
> > +       __le32 drv_f;
> > +
> > +#define EEA_S_OK           BIT(2)
> > +#define EEA_S_FEATURE_DONE BIT(3)
> > +#define EEA_S_FAILED       BIT(7)
> > +       u8   device_status;
> > +       u8   reserved[7];
> > +
> > +       __le32 rx_num_max;
> > +       __le32 tx_num_max;
> > +       __le32 db_blk_size;
> > +
> > +       /* admin queue cfg */
> > +       __le16 aq_size;
> > +       __le16 aq_msix_vector;
> > +       __le32 aq_db_off;
> > +
> > +       __le32 aq_sq_addr;
> > +       __le32 aq_sq_addr_hi;
> > +       __le32 aq_cq_addr;
> > +       __le32 aq_cq_addr_hi;
> > +
> > +       __le64 hw_ts;
> > +};
> > +
> > +struct eea_pci_device {
> > +       struct eea_device edev;
> > +       struct pci_dev *pci_dev;
> > +
> > +       u32 msix_vec_n;
> > +
> > +       void __iomem *reg;
> > +       void __iomem *db_base;
> > +
> > +       struct work_struct ha_handle_work;
> > +       char ha_irq_name[32];
> > +       u8 reset_pos;
> > +};
> > +
> > +#define cfg_pointer(reg, item) \
> > +       ((void __iomem *)((reg) + offsetof(struct eea_pci_cfg, item)))
> > +
> > +#define cfg_write8(reg, item, val) iowrite8(val, cfg_pointer(reg, item=
))
> > +#define cfg_write16(reg, item, val) iowrite16(val, cfg_pointer(reg, it=
em))
> > +#define cfg_write32(reg, item, val) iowrite32(val, cfg_pointer(reg, it=
em))
> > +#define cfg_write64(reg, item, val) iowrite64_lo_hi(val, cfg_pointer(r=
eg, item))
> > +
> > +#define cfg_read8(reg, item) ioread8(cfg_pointer(reg, item))
> > +#define cfg_read32(reg, item) ioread32(cfg_pointer(reg, item))
> > +#define cfg_readq(reg, item) readq(cfg_pointer(reg, item))
> > +
> > +/* Due to circular references, we have to add function definitions her=
e. */
> > +static int __eea_pci_probe(struct pci_dev *pci_dev,
> > +                          struct eea_pci_device *ep_dev);
> > +static void __eea_pci_remove(struct pci_dev *pci_dev, bool flush_ha_wo=
rk);
> > +
> > +const char *eea_pci_name(struct eea_device *edev)
> > +{
> > +       return pci_name(edev->ep_dev->pci_dev);
> > +}
> > +
> > +int eea_pci_domain_nr(struct eea_device *edev)
> > +{
> > +       return pci_domain_nr(edev->ep_dev->pci_dev->bus);
> > +}
> > +
> > +u16 eea_pci_dev_id(struct eea_device *edev)
> > +{
> > +       return pci_dev_id(edev->ep_dev->pci_dev);
> > +}
> > +
> > +static void eea_pci_io_set_status(struct eea_device *edev, u8 status)
> > +{
> > +       struct eea_pci_device *ep_dev =3D edev->ep_dev;
> > +
> > +       cfg_write8(ep_dev->reg, device_status, status);
> > +}
> > +
> > +static u8 eea_pci_io_get_status(struct eea_device *edev)
> > +{
> > +       struct eea_pci_device *ep_dev =3D edev->ep_dev;
> > +
> > +       return cfg_read8(ep_dev->reg, device_status);
> > +}
> > +
> > +static void eea_add_status(struct eea_device *dev, u32 status)
> > +{
> > +       eea_pci_io_set_status(dev, eea_pci_io_get_status(dev) | status);
> > +}
> > +
> > +#define EEA_RESET_TIMEOUT_US (1000 * 1000 * 1000)
> > +
> > +int eea_device_reset(struct eea_device *edev)
> > +{
> > +       struct eea_pci_device *ep_dev =3D edev->ep_dev;
> > +       int i, err;
> > +       u8 val;
> > +
> > +       eea_pci_io_set_status(edev, 0);
> > +
> > +       while (eea_pci_io_get_status(edev))
> > +               msleep(20);
> > +
> > +       err =3D read_poll_timeout(cfg_read8, val, !val, 20, EEA_RESET_T=
IMEOUT_US,
> > +                               false, ep_dev->reg, device_status);
> > +
> > +       if (err)
> > +               return -EBUSY;
> > +
> > +       for (i =3D 0; i < ep_dev->msix_vec_n; ++i)
> > +               synchronize_irq(pci_irq_vector(ep_dev->pci_dev, i));
> > +
> > +       return 0;
> > +}
> > +
> > +void eea_device_ready(struct eea_device *dev)
> > +{
> > +       u8 status =3D eea_pci_io_get_status(dev);
> > +
> > +       WARN_ON(status & EEA_S_OK);
> > +
> > +       eea_pci_io_set_status(dev, status | EEA_S_OK);
> > +}
> > +
> > +static int eea_negotiate(struct eea_device *edev)
> > +{
> > +       struct eea_pci_device *ep_dev;
> > +       u32 status;
> > +
> > +       ep_dev =3D edev->ep_dev;
> > +
> > +       edev->features =3D 0;
> > +
> > +       cfg_write32(ep_dev->reg, drv_f_idx, 0);
> > +       cfg_write32(ep_dev->reg, drv_f, (u32)edev->features);
> > +       cfg_write32(ep_dev->reg, drv_f_idx, 1);
> > +       cfg_write32(ep_dev->reg, drv_f, edev->features >> 32);
> > +
> > +       eea_add_status(edev, EEA_S_FEATURE_DONE);
> > +       status =3D eea_pci_io_get_status(edev);
> > +       if (!(status & EEA_S_FEATURE_DONE))
> > +               return -ENODEV;
> > +
> > +       return 0;
> > +}
> > +
> > +static void eea_pci_release_resource(struct eea_pci_device *ep_dev)
> > +{
> > +       struct pci_dev *pci_dev =3D ep_dev->pci_dev;
> > +
> > +       if (ep_dev->reg) {
> > +               pci_iounmap(pci_dev, ep_dev->reg);
> > +               ep_dev->reg =3D NULL;
> > +       }
> > +
> > +       if (ep_dev->msix_vec_n) {
> > +               ep_dev->msix_vec_n =3D 0;
> > +               pci_free_irq_vectors(ep_dev->pci_dev);
> > +       }
> > +
> > +       pci_release_regions(pci_dev);
> > +       pci_disable_device(pci_dev);
> > +}
> > +
> > +static int eea_pci_setup(struct pci_dev *pci_dev, struct eea_pci_devic=
e *ep_dev)
> > +{
> > +       int err, n;
> > +
> > +       ep_dev->pci_dev =3D pci_dev;
> > +
> > +       /* enable the device */
> > +       err =3D pci_enable_device(pci_dev);
> > +       if (err)
> > +               return err;
> > +
> > +       err =3D pci_request_regions(pci_dev, "EEA");
> > +       if (err) {
> > +               pci_disable_device(pci_dev);
> > +               return err;
> > +       }
> > +
> > +       pci_set_master(pci_dev);
> > +
> > +       err =3D dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(6=
4));
> > +       if (err) {
> > +               dev_warn(&pci_dev->dev, "Failed to enable 64-bit DMA.\n=
");
> > +               goto err;
> > +       }
> > +
> > +       ep_dev->reg =3D pci_iomap(pci_dev, 0, 0);
> > +       if (!ep_dev->reg) {
> > +               dev_err(&pci_dev->dev, "Failed to map pci bar!\n");
> > +               err =3D -ENOMEM;
> > +               goto err;
> > +       }
> > +
> > +       ep_dev->edev.rx_num =3D cfg_read32(ep_dev->reg, rx_num_max);
> > +       ep_dev->edev.tx_num =3D cfg_read32(ep_dev->reg, tx_num_max);
> > +
> > +       /* 2: adminq, error handle*/
> > +       n =3D ep_dev->edev.rx_num + ep_dev->edev.tx_num + 2;
> > +       err =3D pci_alloc_irq_vectors(ep_dev->pci_dev, n, n, PCI_IRQ_MS=
IX);
> > +       if (err < 0)
> > +               goto err;
> > +
> > +       ep_dev->msix_vec_n =3D n;
> > +
> > +       ep_dev->db_base =3D ep_dev->reg + EEA_PCI_DB_OFFSET;
> > +       ep_dev->edev.db_blk_size =3D cfg_read32(ep_dev->reg, db_blk_siz=
e);
> > +
> > +       return 0;
> > +
> > +err:
> > +       eea_pci_release_resource(ep_dev);
> > +       return -ENOMEM;
> > +}
> > +
> > +void __iomem *eea_pci_db_addr(struct eea_device *edev, u32 off)
> > +{
> > +       return edev->ep_dev->db_base + off;
> > +}
> > +
> > +int eea_pci_active_aq(struct ering *ering)
> > +{
> > +       struct eea_pci_device *ep_dev =3D ering->edev->ep_dev;
> > +
> > +       cfg_write16(ep_dev->reg, aq_size, ering->num);
> > +       cfg_write16(ep_dev->reg, aq_msix_vector, ering->msix_vec);
> > +
> > +       cfg_write64(ep_dev->reg, aq_sq_addr, ering->sq.dma_addr);
> > +       cfg_write64(ep_dev->reg, aq_cq_addr, ering->cq.dma_addr);
> > +
> > +       ering->db =3D eea_pci_db_addr(ering->edev,
> > +                                   cfg_read32(ep_dev->reg, aq_db_off));
> > +
> > +       return 0;
> > +}
> > +
> > +void eea_pci_free_irq(struct ering *ering, void *data)
> > +{
> > +       struct eea_pci_device *ep_dev =3D ering->edev->ep_dev;
> > +       int irq;
> > +
> > +       irq =3D pci_irq_vector(ep_dev->pci_dev, ering->msix_vec);
> > +       irq_update_affinity_hint(irq, NULL);
> > +       free_irq(irq, data);
> > +}
> > +
> > +int eea_pci_request_irq(struct ering *ering,
> > +                       irqreturn_t (*callback)(int irq, void *data),
> > +                       void *data)
> > +{
> > +       struct eea_pci_device *ep_dev =3D ering->edev->ep_dev;
> > +       int irq;
> > +
> > +       snprintf(ering->irq_name, sizeof(ering->irq_name), "eea-q%d@%s",
> > +                ering->index / 2, pci_name(ep_dev->pci_dev));
> > +
> > +       irq =3D pci_irq_vector(ep_dev->pci_dev, ering->msix_vec);
> > +
> > +       return request_irq(irq, callback, 0, ering->irq_name, data);
> > +}
> > +
> > +/* ha handle code */
> > +static void eea_ha_handle_work(struct work_struct *work)
> > +{
> > +       struct eea_pci_device *ep_dev;
> > +       struct eea_device *edev;
> > +       struct pci_dev *pci_dev;
> > +       u16 reset;
> > +
> > +       ep_dev =3D container_of(work, struct eea_pci_device, ha_handle_=
work);
> > +       edev =3D &ep_dev->edev;
> > +
> > +       /* Ha interrupt is triggered, so there maybe some error, we may=
 need to
> > +        * reset the device or reset some queues.
> > +        */
> > +       dev_warn(&ep_dev->pci_dev->dev, "recv ha interrupt.\n");
> > +
> > +       if (ep_dev->reset_pos) {
> > +               pci_read_config_word(ep_dev->pci_dev, ep_dev->reset_pos,
> > +                                    &reset);
> > +               /* clear bit */
> > +               pci_write_config_word(ep_dev->pci_dev, ep_dev->reset_po=
s,
> > +                                     0xFFFF);
> > +
> > +               if (reset & EEA_PCI_CAP_RESET_FLAG) {
> > +                       dev_warn(&ep_dev->pci_dev->dev,
> > +                                "recv device reset request.\n");
> > +
> > +                       pci_dev =3D ep_dev->pci_dev;
> > +
> > +                       /* The pci remove callback may hold this lock. =
If the
> > +                        * pci remove callback is called, then we can i=
gnore the
> > +                        * ha interrupt.
> > +                        */
> > +                       if (mutex_trylock(&edev->ha_lock)) {
> > +                               edev->ha_reset =3D true;
> > +
> > +                               __eea_pci_remove(pci_dev, false);
> > +                               __eea_pci_probe(pci_dev, ep_dev);
> > +
> > +                               edev->ha_reset =3D false;
> > +                               mutex_unlock(&edev->ha_lock);
> > +                       } else {
> > +                               dev_warn(&ep_dev->pci_dev->dev,
> > +                                        "ha device reset: trylock fail=
ed.\n");
> > +                       }
> > +                       return;
> > +               }
> > +       }
> > +
> > +       eea_queues_check_and_reset(&ep_dev->edev);
> > +}
> > +
> > +static irqreturn_t eea_pci_ha_handle(int irq, void *data)
> > +{
> > +       struct eea_device *edev =3D data;
> > +
> > +       schedule_work(&edev->ep_dev->ha_handle_work);
> > +
> > +       return IRQ_HANDLED;
> > +}
> > +
> > +static void eea_pci_free_ha_irq(struct eea_device *edev)
> > +{
> > +       struct eea_pci_device *ep_dev =3D edev->ep_dev;
> > +       int irq =3D pci_irq_vector(ep_dev->pci_dev, 0);
> > +
> > +       free_irq(irq, edev);
> > +}
> > +
> > +static int eea_pci_ha_init(struct eea_device *edev, struct pci_dev *pc=
i_dev)
> > +{
> > +       u8 pos, cfg_type_off, type, cfg_drv_off, cfg_dev_off;
> > +       struct eea_pci_device *ep_dev =3D edev->ep_dev;
> > +       int irq;
> > +
> > +       cfg_type_off =3D offsetof(struct eea_pci_cap, cfg_type);
> > +       cfg_drv_off =3D offsetof(struct eea_pci_reset_reg, driver);
> > +       cfg_dev_off =3D offsetof(struct eea_pci_reset_reg, device);
> > +
> > +       for (pos =3D pci_find_capability(pci_dev, PCI_CAP_ID_VNDR);
> > +            pos > 0;
> > +            pos =3D pci_find_next_capability(pci_dev, pos, PCI_CAP_ID_=
VNDR)) {
> > +               pci_read_config_byte(pci_dev, pos + cfg_type_off, &type=
);
> > +
> > +               if (type =3D=3D EEA_PCI_CAP_RESET_DEVICE) {
> > +                       /* notify device, driver support this feature. =
*/
> > +                       pci_write_config_word(pci_dev, pos + cfg_drv_of=
f,
> > +                                             EEA_PCI_CAP_RESET_FLAG);
> > +                       pci_write_config_word(pci_dev, pos + cfg_dev_of=
f,
> > +                                             0xFFFF);
> > +
> > +                       edev->ep_dev->reset_pos =3D pos + cfg_dev_off;
> > +                       goto found;
> > +               }
> > +       }
> > +
> > +       dev_warn(&edev->ep_dev->pci_dev->dev, "Not Found reset cap.\n");
> > +
> > +found:
> > +       snprintf(ep_dev->ha_irq_name, sizeof(ep_dev->ha_irq_name), "eea=
-ha@%s",
> > +                pci_name(ep_dev->pci_dev));
> > +
> > +       irq =3D pci_irq_vector(ep_dev->pci_dev, 0);
> > +
> > +       INIT_WORK(&ep_dev->ha_handle_work, eea_ha_handle_work);
> > +
> > +       return request_irq(irq, eea_pci_ha_handle, 0,
> > +                          ep_dev->ha_irq_name, edev);
> > +}
> > +
> > +/* ha handle end */
> > +
> > +u64 eea_pci_device_ts(struct eea_device *edev)
> > +{
> > +       struct eea_pci_device *ep_dev =3D edev->ep_dev;
> > +
> > +       return cfg_readq(ep_dev->reg, hw_ts);
> > +}
> > +
> > +static int eea_init_device(struct eea_device *edev)
> > +{
> > +       int err;
> > +
> > +       err =3D eea_device_reset(edev);
> > +       if (err)
> > +               return err;
> > +
> > +       eea_pci_io_set_status(edev, BIT(0) | BIT(1));
> > +
> > +       err =3D eea_negotiate(edev);
> > +       if (err)
> > +               goto err;
> > +
> > +       err =3D eea_net_probe(edev);
> > +       if (err)
> > +               goto err;
> > +
> > +       return 0;
> > +err:
> > +       eea_add_status(edev, EEA_S_FAILED);
> > +       return err;
> > +}
> > +
> > +static int __eea_pci_probe(struct pci_dev *pci_dev,
> > +                          struct eea_pci_device *ep_dev)
> > +{
> > +       struct eea_device *edev;
> > +       int err;
> > +
> > +       pci_set_drvdata(pci_dev, ep_dev);
> > +
> > +       edev =3D &ep_dev->edev;
> > +
> > +       err =3D eea_pci_setup(pci_dev, ep_dev);
> > +       if (err)
> > +               goto err_setup;
> > +
> > +       err =3D eea_init_device(&ep_dev->edev);
> > +       if (err)
> > +               goto err_register;
> > +
> > +       err =3D eea_pci_ha_init(edev, pci_dev);
> > +       if (err)
> > +               goto err_error_irq;
> > +
> > +       return 0;
> > +
> > +err_error_irq:
> > +       eea_net_remove(edev);
> > +
> > +err_register:
> > +       eea_pci_release_resource(ep_dev);
> > +
> > +err_setup:
> > +       kfree(ep_dev);
> > +       return err;
> > +}
> > +
> > +static void __eea_pci_remove(struct pci_dev *pci_dev, bool flush_ha_wo=
rk)
> > +{
> > +       struct eea_pci_device *ep_dev =3D pci_get_drvdata(pci_dev);
> > +       struct device *dev =3D get_device(&ep_dev->pci_dev->dev);
> > +       struct eea_device *edev =3D &ep_dev->edev;
> > +
> > +       eea_pci_free_ha_irq(edev);
> > +
> > +       if (flush_ha_work)
> > +               flush_work(&ep_dev->ha_handle_work);
> > +
> > +       eea_net_remove(edev);
> > +
> > +       pci_disable_sriov(pci_dev);
> > +
> > +       eea_pci_release_resource(ep_dev);
> > +
> > +       put_device(dev);
> > +}
> > +
> > +static int eea_pci_probe(struct pci_dev *pci_dev,
> > +                        const struct pci_device_id *id)
> > +{
> > +       struct eea_pci_device *ep_dev;
> > +       struct eea_device *edev;
> > +
> > +       ep_dev =3D kzalloc(sizeof(*ep_dev), GFP_KERNEL);
> > +       if (!ep_dev)
> > +               return -ENOMEM;
> > +
> > +       edev =3D &ep_dev->edev;
> > +
> > +       edev->ep_dev =3D ep_dev;
> > +       edev->dma_dev =3D &pci_dev->dev;
> > +
> > +       ep_dev->pci_dev =3D pci_dev;
> > +
> > +       mutex_init(&edev->ha_lock);
> > +
> > +       return __eea_pci_probe(pci_dev, ep_dev);
> > +}
> > +
> > +static void eea_pci_remove(struct pci_dev *pci_dev)
> > +{
> > +       struct eea_pci_device *ep_dev =3D pci_get_drvdata(pci_dev);
> > +       struct eea_device *edev;
> > +
> > +       edev =3D &ep_dev->edev;
> > +
> > +       mutex_lock(&edev->ha_lock);
> > +       __eea_pci_remove(pci_dev, true);
> > +       mutex_unlock(&edev->ha_lock);
> > +
> > +       kfree(ep_dev);
> > +}
> > +
> > +static int eea_pci_sriov_configure(struct pci_dev *pci_dev, int num_vf=
s)
> > +{
> > +       struct eea_pci_device *ep_dev =3D pci_get_drvdata(pci_dev);
> > +       struct eea_device *edev =3D &ep_dev->edev;
> > +       int ret;
> > +
> > +       if (!(eea_pci_io_get_status(edev) & EEA_S_OK))
> > +               return -EBUSY;
> > +
> > +       if (pci_vfs_assigned(pci_dev))
> > +               return -EPERM;
> > +
> > +       if (num_vfs =3D=3D 0) {
> > +               pci_disable_sriov(pci_dev);
> > +               return 0;
> > +       }
> > +
> > +       ret =3D pci_enable_sriov(pci_dev, num_vfs);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       return num_vfs;
> > +}
> > +
> > +static const struct pci_device_id eea_pci_id_table[] =3D {
> > +       { PCI_DEVICE(PCI_VENDOR_ID_ALIBABA, 0x500B) },
> > +       { 0 }
> > +};
> > +
> > +MODULE_DEVICE_TABLE(pci, eea_pci_id_table);
> > +
> > +static struct pci_driver eea_pci_driver =3D {
> > +       .name            =3D "eea",
> > +       .id_table        =3D eea_pci_id_table,
> > +       .probe           =3D eea_pci_probe,
> > +       .remove          =3D eea_pci_remove,
> > +       .sriov_configure =3D eea_pci_sriov_configure,
> > +};
> > +
> > +static __init int eea_pci_init(void)
> > +{
> > +       return pci_register_driver(&eea_pci_driver);
> > +}
> > +
> > +static __exit void eea_pci_exit(void)
> > +{
> > +       pci_unregister_driver(&eea_pci_driver);
> > +}
> > +
> > +module_init(eea_pci_init);
> > +module_exit(eea_pci_exit);
> > +
> > +MODULE_DESCRIPTION("Driver for Alibaba Elastic Ethernet Adaptor");
> > +MODULE_AUTHOR("Xuan Zhuo <xuanzhuo@linux.alibaba.com>");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/net/ethernet/alibaba/eea/eea_pci.h b/drivers/net/e=
thernet/alibaba/eea/eea_pci.h
> > new file mode 100644
> > index 000000000000..65d53508e1db
> > --- /dev/null
> > +++ b/drivers/net/ethernet/alibaba/eea/eea_pci.h
> > @@ -0,0 +1,67 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * Driver for Alibaba Elastic Ethernet Adaptor.
> > + *
> > + * Copyright (C) 2025 Alibaba Inc.
> > + */
> > +
> > +#ifndef __EEA_PCI_H__
> > +#define __EEA_PCI_H__
> > +
> > +#include <linux/pci.h>
> > +
> > +#include "eea_ring.h"
> > +#include "eea_net.h"
> > +
> > +struct eea_pci_cap {
> > +       __u8 cap_vndr;
> > +       __u8 cap_next;
> > +       __u8 cap_len;
> > +       __u8 cfg_type;
> > +};
> > +
> > +struct eea_pci_reset_reg {
> > +       struct eea_pci_cap cap;
> > +       __le16 driver;
> > +       __le16 device;
> > +};
> > +
> > +struct eea_pci_device;
> > +
> > +struct eea_device {
> > +       struct eea_pci_device *ep_dev;
> > +       struct device         *dma_dev;
> > +       struct eea_net        *enet;
> > +
> > +       u64 features;
> > +
> > +       bool ha_reset;
> > +       bool ha_reset_netdev_running;
> > +
> > +       /* ha lock for the race between ha work and pci remove */
> > +       struct mutex ha_lock;
> > +
> > +       u32 rx_num;
> > +       u32 tx_num;
> > +       u32 db_blk_size;
> > +};
> > +
> > +const char *eea_pci_name(struct eea_device *edev);
> > +int eea_pci_domain_nr(struct eea_device *edev);
> > +u16 eea_pci_dev_id(struct eea_device *edev);
> > +
> > +int eea_device_reset(struct eea_device *dev);
> > +void eea_device_ready(struct eea_device *dev);
> > +
> > +int eea_pci_active_aq(struct ering *ering);
> > +
> > +int eea_pci_request_irq(struct ering *ering,
> > +                       irqreturn_t (*callback)(int irq, void *data),
> > +                       void *data);
> > +void eea_pci_free_irq(struct ering *ering, void *data);
> > +
> > +u64 eea_pci_device_ts(struct eea_device *edev);
> > +
> > +int eea_pci_set_affinity(struct ering *ering, const struct cpumask *cp=
u_mask);
> > +void __iomem *eea_pci_db_addr(struct eea_device *edev, u32 off);
> > +#endif
> > diff --git a/drivers/net/ethernet/alibaba/eea/eea_ring.c b/drivers/net/=
ethernet/alibaba/eea/eea_ring.c
> > new file mode 100644
> > index 000000000000..0f63800c1e3f
> > --- /dev/null
> > +++ b/drivers/net/ethernet/alibaba/eea/eea_ring.c
> > @@ -0,0 +1,267 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Driver for Alibaba Elastic Ethernet Adaptor.
> > + *
> > + * Copyright (C) 2025 Alibaba Inc.
> > + */
> > +
> > +#include "eea_ring.h"
> > +#include "eea_pci.h"
> > +
> > +bool ering_irq_unactive(struct ering *ering)
> > +{
> > +       union {
> > +               u64 data;
> > +               struct db db;
> > +       } val;
> > +
> > +       if (ering->mask =3D=3D EEA_IRQ_MASK)
> > +               return true;
> > +
> > +       ering->mask =3D EEA_IRQ_MASK;
> > +
> > +       val.db.kick_flags =3D EEA_IRQ_MASK;
> > +
> > +       writeq(val.data, (void __iomem *)ering->db);
> > +
> > +       return true;
> > +}
> > +
> > +bool ering_irq_active(struct ering *ering, struct ering *tx_ering)
> > +{
> > +       union {
> > +               u64 data;
> > +               struct db db;
> > +       } val;
> > +
> > +       if (ering->mask =3D=3D EEA_IRQ_UNMASK)
> > +               return true;
> > +
> > +       ering->mask =3D EEA_IRQ_UNMASK;
> > +
> > +       val.db.kick_flags =3D EEA_IRQ_UNMASK;
> > +
> > +       val.db.tx_cq_head =3D cpu_to_le16(tx_ering->cq.hw_idx);
> > +       val.db.rx_cq_head =3D cpu_to_le16(ering->cq.hw_idx);
> > +
> > +       writeq(val.data, ering->db);
> > +
> > +       return true;
> > +}
> > +
> > +void *ering_cq_get_desc(const struct ering *ering)
> > +{
> > +       u8 phase;
> > +       u8 *desc;
> > +
> > +       desc =3D ering->cq.desc + (ering->cq.head << ering->cq.desc_siz=
e_shift);
> > +
> > +       phase =3D *(u8 *)(desc + ering->cq.desc_size - 1);
> > +
> > +       if ((phase & ERING_DESC_F_CQ_PHASE) =3D=3D ering->cq.phase) {
> > +               dma_rmb();
> > +               return desc;
> > +       }
> > +
> > +       return NULL;
> > +}
> > +
> > +/* sq api */
> > +void *ering_sq_alloc_desc(struct ering *ering, u16 id, bool is_last, u=
16 flags)
> > +{
> > +       struct ering_sq *sq =3D &ering->sq;
> > +       struct common_desc *desc;
> > +
> > +       if (!sq->shadow_num) {
> > +               sq->shadow_idx =3D sq->head;
> > +               sq->shadow_id =3D cpu_to_le16(id);
> > +       }
> > +
> > +       if (!is_last)
> > +               flags |=3D ERING_DESC_F_MORE;
> > +
> > +       desc =3D sq->desc + (sq->shadow_idx << sq->desc_size_shift);
> > +
> > +       desc->flags =3D cpu_to_le16(flags);
> > +       desc->id =3D sq->shadow_id;
> > +
> > +       if (unlikely(++sq->shadow_idx >=3D ering->num))
> > +               sq->shadow_idx =3D 0;
> > +
> > +       ++sq->shadow_num;
> > +
> > +       return desc;
> > +}
> > +
> > +void *ering_aq_alloc_desc(struct ering *ering)
> > +{
> > +       struct ering_sq *sq =3D &ering->sq;
> > +       struct common_desc *desc;
> > +
> > +       sq->shadow_idx =3D sq->head;
> > +
> > +       desc =3D sq->desc + (sq->shadow_idx << sq->desc_size_shift);
> > +
> > +       if (unlikely(++sq->shadow_idx >=3D ering->num))
> > +               sq->shadow_idx =3D 0;
> > +
> > +       ++sq->shadow_num;
> > +
> > +       return desc;
> > +}
> > +
> > +void ering_sq_commit_desc(struct ering *ering)
> > +{
> > +       struct ering_sq *sq =3D &ering->sq;
> > +       int num;
> > +
> > +       num =3D sq->shadow_num;
> > +
> > +       ering->num_free -=3D num;
> > +
> > +       sq->head       =3D sq->shadow_idx;
> > +       sq->hw_idx     +=3D num;
> > +       sq->shadow_num =3D 0;
> > +}
> > +
> > +void ering_sq_cancel(struct ering *ering)
> > +{
> > +       ering->sq.shadow_num =3D 0;
> > +}
> > +
> > +/* cq api */
> > +void ering_cq_ack_desc(struct ering *ering, u32 num)
> > +{
> > +       struct ering_cq *cq =3D &ering->cq;
> > +
> > +       cq->head +=3D num;
> > +       cq->hw_idx +=3D num;
> > +
> > +       if (unlikely(cq->head >=3D ering->num)) {
> > +               cq->head -=3D ering->num;
> > +               cq->phase ^=3D ERING_DESC_F_CQ_PHASE;
> > +       }
> > +
> > +       ering->num_free +=3D num;
> > +}
> > +
> > +/* notify */
> > +bool ering_kick(struct ering *ering)
> > +{
> > +       union {
> > +               u64 data;
> > +               struct db db;
> > +       } val;
> > +
> > +       val.db.kick_flags =3D EEA_IDX_PRESENT;
> > +       val.db.idx =3D cpu_to_le16(ering->sq.hw_idx);
> > +
> > +       writeq(val.data, ering->db);
> > +
> > +       return true;
> > +}
> > +
> > +/* ering alloc/free */
> > +static void ering_free_queue(struct eea_device *edev, size_t size,
> > +                            void *queue, dma_addr_t dma_handle)
> > +{
> > +       dma_free_coherent(edev->dma_dev, size, queue, dma_handle);
> > +}
> > +
> > +static void *ering_alloc_queue(struct eea_device *edev, size_t size,
> > +                              dma_addr_t *dma_handle)
> > +{
> > +       gfp_t flags =3D GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO;
> > +
> > +       return dma_alloc_coherent(edev->dma_dev, size, dma_handle, flag=
s);
> > +}
> > +
> > +static int ering_alloc_queues(struct ering *ering, struct eea_device *=
edev,
> > +                             u32 num, u8 sq_desc_size, u8 cq_desc_size)
> > +{
> > +       dma_addr_t addr;
> > +       size_t size;
> > +       void *ring;
> > +
> > +       size =3D num * sq_desc_size;
> > +
> > +       ring =3D ering_alloc_queue(edev, size, &addr);
> > +       if (!ring)
> > +               return -ENOMEM;
> > +
> > +       ering->sq.desc     =3D ring;
> > +       ering->sq.dma_addr =3D addr;
> > +       ering->sq.dma_size =3D size;
> > +       ering->sq.desc_size =3D sq_desc_size;
> > +       ering->sq.desc_size_shift =3D fls(sq_desc_size) - 1;
> > +
> > +       size =3D num * cq_desc_size;
> > +
> > +       ring =3D ering_alloc_queue(edev, size, &addr);
> > +       if (!ring)
> > +               goto err_cq;
> > +
> > +       ering->cq.desc     =3D ring;
> > +       ering->cq.dma_addr =3D addr;
> > +       ering->cq.dma_size =3D size;
> > +       ering->cq.desc_size =3D cq_desc_size;
> > +       ering->cq.desc_size_shift =3D fls(cq_desc_size) - 1;
> > +
> > +       ering->num =3D num;
> > +
> > +       return 0;
> > +
> > +err_cq:
> > +       ering_free_queue(ering->edev, ering->sq.dma_size,
> > +                        ering->sq.desc, ering->sq.dma_addr);
> > +       return -ENOMEM;
> > +}
> > +
> > +static void ering_init(struct ering *ering)
> > +{
> > +       ering->sq.head =3D 0;
> > +       ering->sq.hw_idx =3D 0;
> > +
> > +       ering->cq.head =3D 0;
>
> do you really want to set these to 0 explicitly. ering is allocated with =
kzalloc
> >
> > +       ering->cq.phase =3D ERING_DESC_F_CQ_PHASE;
> > +       ering->num_free =3D ering->num;
> > +       ering->mask =3D 0;
> > +}
> > +
> > +struct ering *ering_alloc(u32 index, u32 num, struct eea_device *edev,
> > +                         u8 sq_desc_size, u8 cq_desc_size,
> > +                         const char *name)
> > +{
> > +       struct ering *ering;
> > +
> > +       ering =3D kzalloc(sizeof(*ering), GFP_KERNEL);
> > +       if (!ering)
> > +               return NULL;
> > +
> > +       ering->edev =3D edev;
> > +       ering->name =3D name;
> > +       ering->index =3D index;
> > +       ering->msix_vec =3D index / 2 + 1; /* vec 0 is for error notify=
. */
> > +
> > +       if (ering_alloc_queues(ering, edev, num, sq_desc_size, cq_desc_=
size))
> > +               goto err_ring;
> > +
> > +       ering_init(ering);
> > +
> > +       return ering;
> > +
> > +err_ring:
> > +       kfree(ering);
> > +       return NULL;
> > +}
> > +
> > +void ering_free(struct ering *ering)
> > +{
> > +       ering_free_queue(ering->edev, ering->cq.dma_size,
> > +                        ering->cq.desc, ering->cq.dma_addr);
> > +
> > +       ering_free_queue(ering->edev, ering->sq.dma_size,
> > +                        ering->sq.desc, ering->sq.dma_addr);
> > +
> > +       kfree(ering);
> > +}
> > diff --git a/drivers/net/ethernet/alibaba/eea/eea_ring.h b/drivers/net/=
ethernet/alibaba/eea/eea_ring.h
> > new file mode 100644
> > index 000000000000..bc63e5bb83f1
> > --- /dev/null
> > +++ b/drivers/net/ethernet/alibaba/eea/eea_ring.h
> > @@ -0,0 +1,89 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * Driver for Alibaba Elastic Ethernet Adaptor.
> > + *
> > + * Copyright (C) 2025 Alibaba Inc.
> > + */
> > +
> > +#ifndef __EEA_RING_H__
> > +#define __EEA_RING_H__
> > +
> > +#include <linux/dma-mapping.h>
> > +#include "eea_desc.h"
> > +
> > +#define ERING_DESC_F_MORE      BIT(0)
> > +#define ERING_DESC_F_CQ_PHASE  BIT(7)
> > +
> > +struct common_desc {
> > +       __le16 flags;
> > +       __le16 id;
> > +};
> > +
> > +struct eea_device;
> > +
> > +struct ering_sq {
> > +       void *desc;
> > +
> > +       u16 head;
> > +       u16 hw_idx;
> > +
> > +       u16 shadow_idx;
> > +       __le16 shadow_id;
> > +       u16 shadow_num;
> > +
> > +       u8 desc_size;
> > +       u8 desc_size_shift;
> > +
> > +       dma_addr_t dma_addr;
> > +       u32 dma_size;
> > +};
> > +
> > +struct ering_cq {
> > +       void *desc;
> > +
> > +       u16 head;
> > +       u16 hw_idx;
> > +
> > +       u8 phase;
> > +       u8 desc_size_shift;
> > +       u8 desc_size;
> > +
> > +       dma_addr_t dma_addr;
> > +       u32 dma_size;
> > +};
> > +
> > +struct ering {
> > +       const char *name;
> > +       struct eea_device *edev;
> > +       u32 index;
> > +       void __iomem *db;
> > +       u16 msix_vec;
> > +
> > +       u8 mask;
> > +
> > +       u32 num;
> > +
> > +       u32 num_free;
> > +
> > +       struct ering_sq sq;
> > +       struct ering_cq cq;
> > +
> > +       char irq_name[32];
> > +};
> > +
> > +struct ering *ering_alloc(u32 index, u32 num, struct eea_device *edev,
> > +                         u8 sq_desc_size, u8 cq_desc_size, const char =
*name);
> > +void ering_free(struct ering *ering);
> > +bool ering_kick(struct ering *ering);
> > +
> > +void *ering_sq_alloc_desc(struct ering *ering, u16 id, bool is_last, u=
16 flags);
> > +void *ering_aq_alloc_desc(struct ering *ering);
> > +void ering_sq_commit_desc(struct ering *ering);
> > +void ering_sq_cancel(struct ering *ering);
> > +
> > +void ering_cq_ack_desc(struct ering *ering, u32 num);
> > +
> > +bool ering_irq_unactive(struct ering *ering);
> > +bool ering_irq_active(struct ering *ering, struct ering *tx_ering);
> > +void *ering_cq_get_desc(const struct ering *ering);
> > +#endif
> > diff --git a/drivers/net/ethernet/alibaba/eea/eea_rx.c b/drivers/net/et=
hernet/alibaba/eea/eea_rx.c
> > new file mode 100644
> > index 000000000000..4a21dfe07b3c
> > --- /dev/null
> > +++ b/drivers/net/ethernet/alibaba/eea/eea_rx.c
> > @@ -0,0 +1,784 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Driver for Alibaba Elastic Ethernet Adaptor.
> > + *
> > + * Copyright (C) 2025 Alibaba Inc.
> > + */
> > +
> > +#include <net/netdev_rx_queue.h>
> > +#include <net/page_pool/helpers.h>
> > +
> > +#include "eea_adminq.h"
> > +#include "eea_ring.h"
> > +#include "eea_net.h"
> > +
> > +/* rx flags */
> > +#define ENET_SETUP_F_NAPI         BIT(0)
> > +#define ENET_SETUP_F_IRQ          BIT(1)
> > +#define ENET_ENABLE_F_NAPI        BIT(2)
> > +
> > +#define EEA_PAGE_FRGAS_NUM 1024
> > +
> > +struct rx_ctx {
> > +       void *buf;
> > +
> > +       u32 len;
> > +       u32 hdr_len;
> > +
> > +       u16 flags;
> > +       bool more;
> > +
> > +       u32 frame_sz;
> > +
> > +       struct eea_rx_meta *meta;
> > +
> > +       struct eea_rx_ctx_stats stats;
> > +};
> > +
> > +static struct eea_rx_meta *eea_rx_meta_get(struct enet_rx *rx)
> > +{
> > +       struct eea_rx_meta *meta;
> > +
> > +       if (!rx->free)
> > +               return NULL;
> > +
> > +       meta =3D rx->free;
> > +       rx->free =3D meta->next;
> > +
> > +       return meta;
> > +}
> > +
> > +static void eea_rx_meta_put(struct enet_rx *rx, struct eea_rx_meta *me=
ta)
> > +{
> > +       meta->next =3D rx->free;
> > +       rx->free =3D meta;
> > +}
> > +
> > +static void eea_free_rx_buffer(struct enet_rx *rx, struct eea_rx_meta =
*meta)
> > +{
> > +       u32 drain_count;
> > +
> > +       drain_count =3D EEA_PAGE_FRGAS_NUM - meta->frags;
> > +
> > +       if (page_pool_unref_page(meta->page, drain_count) =3D=3D 0)
> > +               page_pool_put_unrefed_page(rx->pp, meta->page, -1, true=
);
> > +
> > +       meta->page =3D NULL;
> > +}
> > +
> > +static void meta_align_offset(struct enet_rx *rx, struct eea_rx_meta *=
meta)
> > +{
> > +       int h, b;
> > +
> > +       h =3D rx->headroom;
> > +       b =3D meta->offset + h;
> > +
> > +       b =3D ALIGN(b, 128);
> > +
> > +       meta->offset =3D b - h;
> > +}
> > +
> > +static int eea_alloc_rx_buffer(struct enet_rx *rx, struct eea_rx_meta =
*meta)
> > +{
> > +       struct page *page;
> > +
> > +       if (meta->page)
> > +               return 0;
> > +
> > +       page =3D page_pool_dev_alloc_pages(rx->pp);
> > +       if (!page)
> > +               return -ENOMEM;
> > +
> > +       page_pool_fragment_page(page, EEA_PAGE_FRGAS_NUM);
> > +
> > +       meta->page =3D page;
> > +       meta->dma =3D page_pool_get_dma_addr(page);
> > +       meta->offset =3D 0;
> > +       meta->frags =3D 0;
> > +
> > +       meta_align_offset(rx, meta);
> > +
> > +       return 0;
> > +}
> > +
> > +static void eea_consume_rx_buffer(struct enet_rx *rx, struct eea_rx_me=
ta *meta,
> > +                                 u32 consumed)
> > +{
> > +       int min;
> > +
> > +       meta->offset +=3D consumed;
> > +       ++meta->frags;
> > +
> > +       min =3D SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > +       min +=3D rx->headroom;
> > +       min +=3D ETH_DATA_LEN;
> > +
> > +       meta_align_offset(rx, meta);
> > +
> > +       if (min + meta->offset > PAGE_SIZE)
> > +               eea_free_rx_buffer(rx, meta);
> > +}
> > +
> > +static void eea_free_rx_hdr(struct enet_rx *rx)
> > +{
> > +       struct eea_net *enet =3D rx->enet;
> > +       struct eea_rx_meta *meta;
> > +       int i;
> > +
> > +       for (i =3D 0; i < enet->cfg.rx_ring_depth; ++i) {
> > +               meta =3D &rx->meta[i];
> > +               meta->hdr_addr =3D NULL;
> > +
> > +               if (!meta->hdr_page)
> > +                       continue;
> > +
> > +               dma_unmap_page(enet->edev->dma_dev, meta->hdr_dma,
> > +                              PAGE_SIZE, DMA_FROM_DEVICE);
> > +               put_page(meta->hdr_page);
> > +
> > +               meta->hdr_page =3D NULL;
> > +       }
> > +}
> > +
> > +static int eea_alloc_rx_hdr(struct eea_net_tmp *tmp, struct enet_rx *r=
x)
> > +{
> > +       struct page *hdr_page =3D NULL;
> > +       struct eea_rx_meta *meta;
> > +       u32 offset =3D 0, hdrsize;
> > +       struct device *dmadev;
> > +       dma_addr_t dma;
> > +       int i;
> > +
> > +       dmadev =3D tmp->edev->dma_dev;
> > +       hdrsize =3D tmp->cfg.split_hdr;
> > +
> > +       for (i =3D 0; i < tmp->cfg.rx_ring_depth; ++i) {
> > +               meta =3D &rx->meta[i];
> > +
> > +               if (!hdr_page || offset + hdrsize > PAGE_SIZE) {
> > +                       hdr_page =3D dev_alloc_page();
> > +                       if (!hdr_page)
> > +                               return -ENOMEM;
> > +
> > +                       dma =3D dma_map_page(dmadev, hdr_page, 0, PAGE_=
SIZE,
> > +                                          DMA_FROM_DEVICE);
> > +
> > +                       if (unlikely(dma_mapping_error(dmadev, dma))) {
> > +                               put_page(hdr_page);
> > +                               return -ENOMEM;
> > +                       }
> > +
> > +                       offset =3D 0;
> > +                       meta->hdr_page =3D hdr_page;
> > +                       meta->dma =3D dma;
> > +               }
> > +
> > +               meta->hdr_dma =3D dma + offset;
> > +               meta->hdr_addr =3D page_address(hdr_page) + offset;
> > +               offset +=3D hdrsize;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static void eea_rx_meta_dma_sync_for_cpu(struct enet_rx *rx,
> > +                                        struct eea_rx_meta *meta, u32 =
len)
> > +{
> > +       dma_sync_single_for_cpu(rx->enet->edev->dma_dev,
> > +                               meta->dma + meta->offset + meta->headro=
om,
> > +                               len, DMA_FROM_DEVICE);
> > +}
> > +
> > +static int eea_harden_check_overflow(struct rx_ctx *ctx, struct eea_ne=
t *enet)
> > +{
> > +       if (unlikely(ctx->len > ctx->meta->truesize - ctx->meta->room))=
 {
> > +               pr_debug("%s: rx error: len %u exceeds truesize %u\n",
> > +                        enet->netdev->name, ctx->len,
> > +                        ctx->meta->truesize - ctx->meta->room);
> > +               ++ctx->stats.length_errors;
> > +               return -EINVAL;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int eea_harden_check_size(struct rx_ctx *ctx, struct eea_net *e=
net)
> > +{
> > +       int err;
> > +
> > +       err =3D eea_harden_check_overflow(ctx, enet);
> > +       if (err)
> > +               return err;
> > +
> > +       if (unlikely(ctx->hdr_len + ctx->len < ETH_HLEN)) {
> > +               pr_debug("%s: short packet %u\n", enet->netdev->name, c=
tx->len);
> > +               ++ctx->stats.length_errors;
> > +               return -EINVAL;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static struct sk_buff *eea_build_skb(void *buf, u32 buflen, u32 headro=
om,
> > +                                    u32 len)
> > +{
> > +       struct sk_buff *skb;
> > +
> > +       skb =3D build_skb(buf, buflen);
> > +       if (unlikely(!skb))
> > +               return NULL;
> > +
> > +       skb_reserve(skb, headroom);
> > +       skb_put(skb, len);
> > +
> > +       return skb;
> > +}
> > +
> > +static struct sk_buff *eea_rx_build_split_hdr_skb(struct enet_rx *rx,
> > +                                                 struct rx_ctx *ctx)
> > +{
> > +       struct eea_rx_meta *meta =3D ctx->meta;
> > +       struct sk_buff *skb;
> > +       u32 truesize;
> > +
> > +       dma_sync_single_for_cpu(rx->enet->edev->dma_dev, meta->hdr_dma,
> > +                               ctx->hdr_len, DMA_FROM_DEVICE);
> > +
> > +       skb =3D napi_alloc_skb(&rx->napi, ctx->hdr_len);
> > +       if (unlikely(!skb))
> > +               return NULL;
> > +
> > +       truesize =3D meta->headroom + ctx->len;
> > +
> > +       skb_put_data(skb, ctx->meta->hdr_addr, ctx->hdr_len);
> > +
> > +       if (ctx->len) {
> > +               skb_add_rx_frag(skb, 0, meta->page,
> > +                               meta->offset + meta->headroom,
> > +                               ctx->len, truesize);
> > +
> > +               eea_consume_rx_buffer(rx, meta, truesize);
> > +       }
> > +
> > +       skb_mark_for_recycle(skb);
> > +
> > +       return skb;
> > +}
> > +
> > +static struct sk_buff *eea_rx_build_skb(struct enet_rx *rx, struct rx_=
ctx *ctx)
> > +{
> > +       struct eea_rx_meta *meta =3D ctx->meta;
> > +       u32 len, shinfo_size, truesize;
> > +       struct sk_buff *skb;
> > +       struct page *page;
> > +       void *buf, *pkt;
> > +
> > +       page =3D meta->page;
> > +
> > +       shinfo_size =3D SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > +
> > +       if (!page)
> > +               return NULL;
> > +
> > +       buf =3D page_address(page) + meta->offset;
> > +       pkt =3D buf + meta->headroom;
> > +       len =3D ctx->len;
> > +       truesize =3D meta->headroom + ctx->len + shinfo_size;
> > +
> > +       skb =3D eea_build_skb(buf, truesize, pkt - buf, len);
> > +       if (unlikely(!skb))
> > +               return NULL;
> > +
> > +       eea_consume_rx_buffer(rx, meta, truesize);
> > +       skb_mark_for_recycle(skb);
> > +
> > +       return skb;
> > +}
> > +
> > +static int eea_skb_append_buf(struct enet_rx *rx, struct rx_ctx *ctx)
> > +{
> > +       struct sk_buff *curr_skb =3D rx->pkt.curr_skb;
> > +       struct sk_buff *head_skb =3D rx->pkt.head_skb;
> > +       int num_skb_frags;
> > +       int offset;
> > +
> > +       if (!curr_skb)
> > +               curr_skb =3D head_skb;
> > +
> > +       num_skb_frags =3D skb_shinfo(curr_skb)->nr_frags;
> > +       if (unlikely(num_skb_frags =3D=3D MAX_SKB_FRAGS)) {
> > +               struct sk_buff *nskb =3D alloc_skb(0, GFP_ATOMIC);
> > +
> > +               if (unlikely(!nskb))
> > +                       return -ENOMEM;
> > +
> > +               if (curr_skb =3D=3D head_skb)
> > +                       skb_shinfo(curr_skb)->frag_list =3D nskb;
> > +               else
> > +                       curr_skb->next =3D nskb;
> > +
> > +               curr_skb =3D nskb;
> > +               head_skb->truesize +=3D nskb->truesize;
> > +               num_skb_frags =3D 0;
> > +
> > +               rx->pkt.curr_skb =3D curr_skb;
> > +       }
> > +
> > +       if (curr_skb !=3D head_skb) {
> > +               head_skb->data_len +=3D ctx->len;
> > +               head_skb->len +=3D ctx->len;
> > +               head_skb->truesize +=3D ctx->meta->truesize;
> > +       }
> > +
> > +       offset =3D ctx->meta->offset + ctx->meta->headroom;
> > +
> > +       skb_add_rx_frag(curr_skb, num_skb_frags, ctx->meta->page,
> > +                       offset, ctx->len, ctx->meta->truesize);
> > +
> > +       eea_consume_rx_buffer(rx, ctx->meta, ctx->meta->headroom + ctx-=
>len);
> > +
> > +       return 0;
> > +}
> > +
> > +static int process_remain_buf(struct enet_rx *rx, struct rx_ctx *ctx)
> > +{
> > +       struct eea_net *enet =3D rx->enet;
> > +
> > +       if (eea_harden_check_overflow(ctx, enet))
> > +               goto err;
> > +
> > +       if (eea_skb_append_buf(rx, ctx))
> > +               goto err;
> > +
> > +       return 0;
> > +
> > +err:
> > +       dev_kfree_skb(rx->pkt.head_skb);
> > +       ++ctx->stats.drops;
> > +       rx->pkt.do_drop =3D true;
> > +       rx->pkt.head_skb =3D NULL;
> > +       return 0;
> > +}
> > +
> > +static int process_first_buf(struct enet_rx *rx, struct rx_ctx *ctx)
> > +{
> > +       struct eea_net *enet =3D rx->enet;
> > +       struct sk_buff *skb =3D NULL;
> > +
> > +       if (eea_harden_check_size(ctx, enet))
> > +               goto err;
> > +
> > +       rx->pkt.data_valid =3D ctx->flags & EEA_DESC_F_DATA_VALID;
> > +
> > +       if (ctx->hdr_len)
> > +               skb =3D eea_rx_build_split_hdr_skb(rx, ctx);
> > +       else
> > +               skb =3D eea_rx_build_skb(rx, ctx);
> > +
> > +       if (unlikely(!skb))
> > +               goto err;
> > +
> > +       rx->pkt.head_skb =3D skb;
> > +
> > +       return 0;
> > +
> > +err:
> > +       ++ctx->stats.drops;
> > +       rx->pkt.do_drop =3D true;
> > +       return 0;
> > +}
> > +
> > +static void eea_submit_skb(struct enet_rx *rx, struct sk_buff *skb,
> > +                          struct eea_rx_cdesc *desc)
> > +{
> > +       struct eea_net *enet =3D rx->enet;
> > +
> > +       if (rx->pkt.data_valid)
> > +               skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> > +
> > +       if (enet->cfg.ts_cfg.rx_filter =3D=3D HWTSTAMP_FILTER_ALL)
> > +               skb_hwtstamps(skb)->hwtstamp =3D EEA_DESC_TS(desc) +
> > +                       enet->hw_ts_offset;
> > +
> > +       skb_record_rx_queue(skb, rx->index);
> > +       skb->protocol =3D eth_type_trans(skb, enet->netdev);
> > +
> > +       napi_gro_receive(&rx->napi, skb);
> > +}
> > +
> > +static void eea_rx_desc_to_ctx(struct enet_rx *rx,
> > +                              struct rx_ctx *ctx,
> > +                              struct eea_rx_cdesc *desc)
> > +{
> > +       ctx->meta =3D &rx->meta[le16_to_cpu(desc->id)];
> > +       ctx->len =3D le16_to_cpu(desc->len);
> > +       ctx->flags =3D le16_to_cpu(desc->flags);
> > +
> > +       ctx->hdr_len =3D 0;
> > +       if (ctx->flags & EEA_DESC_F_SPLIT_HDR) {
> > +               ctx->hdr_len =3D le16_to_cpu(desc->len_ex) &
> > +                       EEA_RX_CDEC_HDR_LEN_MASK;
> > +               ctx->stats.split_hdr_bytes +=3D ctx->hdr_len;
> > +               ++ctx->stats.split_hdr_packets;
> > +       }
> > +
> > +       ctx->more =3D ctx->flags & ERING_DESC_F_MORE;
> > +}
> > +
> > +static int eea_cleanrx(struct enet_rx *rx, int budget, struct rx_ctx *=
ctx)
> > +{
> > +       struct eea_rx_cdesc *desc;
> > +       struct eea_rx_meta *meta;
> > +       int packets;
> > +
> > +       for (packets =3D 0; packets < budget; ) {
> > +               desc =3D ering_cq_get_desc(rx->ering);
> > +               if (!desc)
> > +                       break;
> > +
> > +               eea_rx_desc_to_ctx(rx, ctx, desc);
> > +
> > +               meta =3D ctx->meta;
> > +               ctx->buf =3D page_address(meta->page) + meta->offset +
> > +                       meta->headroom;
> > +
> > +               if (unlikely(rx->pkt.do_drop))
> > +                       goto skip;
> > +
> > +               eea_rx_meta_dma_sync_for_cpu(rx, meta, ctx->len);
> > +
> > +               ctx->stats.bytes +=3D ctx->len;
> > +
> > +               if (!rx->pkt.idx)
> > +                       process_first_buf(rx, ctx);
> > +               else
> > +                       process_remain_buf(rx, ctx);
> > +
> > +               ++rx->pkt.idx;
> > +
> > +               if (!ctx->more) {
> > +                       if (likely(rx->pkt.head_skb))
> > +                               eea_submit_skb(rx, rx->pkt.head_skb, de=
sc);
> > +
> > +                       ++packets;
> > +               }
> > +
> > +skip:
> > +               eea_rx_meta_put(rx, meta);
> > +               ering_cq_ack_desc(rx->ering, 1);
> > +               ++ctx->stats.descs;
> > +
> > +               if (!ctx->more)
> > +                       memset(&rx->pkt, 0, sizeof(rx->pkt));
> > +       }
> > +
> > +       ctx->stats.packets =3D packets;
> > +
> > +       return packets;
> > +}
> > +
> > +static bool eea_rx_post(struct eea_net *enet,
> > +                       struct enet_rx *rx, gfp_t gfp)
> > +{
> > +       u32 tailroom, headroom, room, flags, len;
> > +       struct eea_rx_meta *meta;
> > +       struct eea_rx_desc *desc;
> > +       int err =3D 0, num =3D 0;
> > +       dma_addr_t addr;
> > +
> > +       tailroom =3D SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > +       headroom =3D rx->headroom;
> > +       room =3D headroom + tailroom;
> > +
> > +       while (true) {
> > +               meta =3D eea_rx_meta_get(rx);
> > +               if (!meta)
> > +                       break;
> > +
> > +               err =3D eea_alloc_rx_buffer(rx, meta);
> > +               if (err) {
> > +                       eea_rx_meta_put(rx, meta);
> > +                       break;
> > +               }
> > +
> > +               len =3D PAGE_SIZE - meta->offset - room;
> > +               addr =3D meta->dma + meta->offset + headroom;
> > +
> > +               desc =3D ering_sq_alloc_desc(rx->ering, meta->id, true,=
 0);
> > +               desc->addr =3D cpu_to_le64(addr);
> > +               desc->len =3D cpu_to_le16(len);
> > +
> > +               if (meta->hdr_addr)
> > +                       desc->hdr_addr =3D cpu_to_le64(meta->hdr_dma);
> > +
> > +               ering_sq_commit_desc(rx->ering);
> > +
> > +               meta->truesize =3D len + room;
> > +               meta->headroom =3D headroom;
> > +               meta->tailroom =3D tailroom;
> > +               meta->len =3D len;
> > +               ++num;
> > +       }
> > +
> > +       if (num) {
> > +               ering_kick(rx->ering);
> > +
> > +               flags =3D u64_stats_update_begin_irqsave(&rx->stats.syn=
cp);
> > +               u64_stats_inc(&rx->stats.kicks);
> > +               u64_stats_update_end_irqrestore(&rx->stats.syncp, flags=
);
> > +       }
> > +
> > +       /* true means busy, napi should be called again. */
> > +       return !!err;
> > +}
> > +
> > +int eea_poll(struct napi_struct *napi, int budget)
> > +{
> > +       struct enet_rx *rx =3D container_of(napi, struct enet_rx, napi);
> > +       struct enet_tx *tx =3D &rx->enet->tx[rx->index];
> > +       struct eea_net *enet =3D rx->enet;
> > +       struct rx_ctx ctx =3D {};
> > +       bool busy =3D false;
> > +       u32 received;
> > +
> > +       eea_poll_tx(tx, budget);
> > +
> > +       received =3D eea_cleanrx(rx, budget, &ctx);
> > +
> > +       if (rx->ering->num_free > budget)
> > +               busy |=3D eea_rx_post(enet, rx, GFP_ATOMIC);
> > +
> > +       eea_update_rx_stats(&rx->stats, &ctx.stats);
> > +
> > +       busy |=3D received >=3D budget;
> > +
> > +       if (!busy) {
> > +               if (napi_complete_done(napi, received))
> > +                       ering_irq_active(rx->ering, tx->ering);
> > +       }
> > +
> > +       if (busy)
> > +               return budget;
> > +
> > +       return budget - 1;
> > +}
> > +
> > +static void eea_free_rx_buffers(struct enet_rx *rx)
> > +{
> > +       struct eea_rx_meta *meta;
> > +       u32 i;
> > +
> > +       for (i =3D 0; i < rx->enet->cfg.rx_ring_depth; ++i) {
> > +               meta =3D &rx->meta[i];
> > +               if (!meta->page)
> > +                       continue;
> > +
> > +               eea_free_rx_buffer(rx, meta);
> > +       }
> > +}
> > +
> > +static struct page_pool *eea_create_pp(struct enet_rx *rx,
> > +                                      struct eea_net_tmp *tmp, u32 idx)
> > +{
> > +       struct page_pool_params pp_params =3D {0};
> > +
> > +       pp_params.order     =3D 0;
> > +       pp_params.flags     =3D PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
> > +       pp_params.pool_size =3D tmp->cfg.rx_ring_depth;
> > +       pp_params.nid       =3D dev_to_node(tmp->edev->dma_dev);
> > +       pp_params.dev       =3D tmp->edev->dma_dev;
> > +       pp_params.napi      =3D &rx->napi;
> > +       pp_params.netdev    =3D tmp->netdev;
> > +       pp_params.dma_dir   =3D DMA_FROM_DEVICE;
> > +       pp_params.max_len   =3D PAGE_SIZE;
> > +
> > +       return page_pool_create(&pp_params);
> > +}
> > +
> > +static void eea_destroy_page_pool(struct enet_rx *rx)
> > +{
> > +       if (rx->pp)
> > +               page_pool_destroy(rx->pp);
> > +}
> > +
> > +static irqreturn_t irq_handler(int irq, void *data)
> > +{
> > +       struct enet_rx *rx =3D data;
> > +
> > +       rx->irq_n++;
> > +
> > +       napi_schedule_irqoff(&rx->napi);
> > +
> > +       return IRQ_HANDLED;
> > +}
> > +
> > +void enet_rx_stop(struct enet_rx *rx)
> > +{
> > +       if (rx->flags & ENET_ENABLE_F_NAPI) {
> > +               rx->flags &=3D ~ENET_ENABLE_F_NAPI;
> > +               napi_disable(&rx->napi);
> > +       }
> > +}
> > +
> > +int enet_rx_start(struct enet_rx *rx)
> > +{
> > +       napi_enable(&rx->napi);
> > +       rx->flags |=3D ENET_ENABLE_F_NAPI;
> > +
> > +       local_bh_disable();
> > +       napi_schedule(&rx->napi);
> > +       local_bh_enable();
> > +
> > +       return 0;
> > +}
> > +
> > +static int enet_irq_setup_for_q(struct enet_rx *rx)
> > +{
> > +       int err;
> > +
> > +       ering_irq_unactive(rx->ering);
> > +
> > +       err =3D eea_pci_request_irq(rx->ering, irq_handler, rx);
> > +       if (err)
> > +               return err;
> > +
> > +       rx->flags |=3D ENET_SETUP_F_IRQ;
> > +
> > +       return 0;
> > +}
> > +
> > +int eea_irq_free(struct enet_rx *rx)
> > +{
> > +       if (rx->flags & ENET_SETUP_F_IRQ) {
> > +               eea_pci_free_irq(rx->ering, rx);
> > +               rx->flags &=3D ~ENET_SETUP_F_IRQ;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +int enet_rxtx_irq_setup(struct eea_net *enet, u32 qid, u32 num)
> > +{
> > +       struct enet_rx *rx;
> > +       int err, i;
> > +
> > +       for (i =3D 0; i < enet->cfg.rx_ring_num; i++) {
> > +               rx =3D enet->rx[i];
> > +
> > +               err =3D enet_irq_setup_for_q(rx);
> > +               if (err)
> > +                       goto err;
> > +       }
> > +
> > +       return 0;
> > +
> > +err:
> > +       for (i =3D 0; i < enet->cfg.rx_ring_num; i++) {
> > +               rx =3D enet->rx[i];
> > +
> > +               eea_irq_free(rx);
> > +       }
> > +       return err;
> > +}
> > +
> > +void eea_free_rx(struct enet_rx *rx)
> > +{
> > +       if (!rx)
> > +               return;
> > +
> > +       if (rx->ering) {
> > +               ering_free(rx->ering);
> > +               rx->ering =3D NULL;
> > +       }
> > +
> > +       if (rx->meta) {
> > +               eea_free_rx_buffers(rx);
> > +               eea_free_rx_hdr(rx);
> > +               kvfree(rx->meta);
> > +               rx->meta =3D NULL;
> > +       }
> > +
> > +       if (rx->pp) {
> > +               eea_destroy_page_pool(rx);
> > +               rx->pp =3D NULL;
> > +       }
> > +
> > +       if (rx->flags & ENET_SETUP_F_NAPI) {
> > +               rx->flags &=3D ~ENET_SETUP_F_NAPI;
> > +               netif_napi_del(&rx->napi);
> > +       }
> > +
> > +       kfree(rx);
> > +}
> > +
> > +static void eea_rx_meta_init(struct enet_rx *rx, u32 num)
> > +{
> > +       struct eea_rx_meta *meta;
> > +       int i;
> > +
> > +       rx->free =3D NULL;
> > +
> > +       for (i =3D 0; i < num; ++i) {
> > +               meta =3D &rx->meta[i];
> > +               meta->id =3D i;
> > +               meta->next =3D rx->free;
> > +               rx->free =3D meta;
> > +       }
> > +}
> > +
> > +struct enet_rx *eea_alloc_rx(struct eea_net_tmp *tmp, u32 idx)
> > +{
> > +       struct ering *ering;
> > +       struct enet_rx *rx;
> > +       int err;
> > +
> > +       rx =3D kzalloc(sizeof(*rx), GFP_KERNEL);
> > +       if (!rx)
> > +               return rx;
> > +
> > +       rx->index =3D idx;
> > +       sprintf(rx->name, "rx.%u", idx);
> > +
> > +       u64_stats_init(&rx->stats.syncp);
> > +
> > +       /* ering */
> > +       ering =3D ering_alloc(idx * 2, tmp->cfg.rx_ring_depth, tmp->ede=
v,
> > +                           tmp->cfg.rx_sq_desc_size,
> > +                           tmp->cfg.rx_cq_desc_size,
> > +                           rx->name);
> > +       if (!ering)
> > +               goto err;
> > +
> > +       rx->ering =3D ering;
> > +
> > +       rx->dma_dev =3D tmp->edev->dma_dev;
> > +
> > +       /* meta */
> > +       rx->meta =3D kvcalloc(tmp->cfg.rx_ring_depth,
> > +                           sizeof(*rx->meta), GFP_KERNEL);
> > +       if (!rx->meta)
> > +               goto err;
> > +
> > +       eea_rx_meta_init(rx, tmp->cfg.rx_ring_depth);
> > +
> > +       if (tmp->cfg.split_hdr) {
> > +               err =3D eea_alloc_rx_hdr(tmp, rx);
> > +               if (err)
> > +                       goto err;
> > +       }
> > +
> > +       rx->pp =3D eea_create_pp(rx, tmp, idx);
> > +       if (IS_ERR(rx->pp)) {
> > +               err =3D PTR_ERR(rx->pp);
> > +               rx->pp =3D NULL;
> > +               goto err;
> > +       }
> > +
> > +       netif_napi_add(tmp->netdev, &rx->napi, eea_poll);
> > +       rx->flags |=3D ENET_SETUP_F_NAPI;
> > +
> > +       return rx;
> > +err:
> > +       eea_free_rx(rx);
> > +       return NULL;
> > +}
> > diff --git a/drivers/net/ethernet/alibaba/eea/eea_tx.c b/drivers/net/et=
hernet/alibaba/eea/eea_tx.c
> > new file mode 100644
> > index 000000000000..a585b212c640
> > --- /dev/null
> > +++ b/drivers/net/ethernet/alibaba/eea/eea_tx.c
> > @@ -0,0 +1,405 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Driver for Alibaba Elastic Ethernet Adaptor.
> > + *
> > + * Copyright (C) 2025 Alibaba Inc.
> > + */
> > +
> > +#include "eea_ring.h"
> > +#include "eea_pci.h"
> > +#include "eea_net.h"
> > +#include <net/netdev_queues.h>
> > +
> > +struct eea_sq_free_stats {
> > +       u64 packets;
> > +       u64 bytes;
> > +};
> > +
> > +struct eea_tx_meta {
> > +       struct eea_tx_meta *next;
> > +
> > +       u32 id;
> > +
> > +       union {
> > +               struct sk_buff *skb;
> > +               void *data;
> > +       };
> > +
> > +       u32 num;
> > +
> > +       dma_addr_t dma_addr;
> > +       struct eea_tx_desc *desc;
> > +       u16 dma_len;
> > +};
> > +
> > +static struct eea_tx_meta *eea_tx_meta_get(struct enet_tx *tx)
> > +{
> > +       struct eea_tx_meta *meta;
> > +
> > +       if (!tx->free)
> > +               return NULL;
> > +
> > +       meta =3D tx->free;
> > +       tx->free =3D meta->next;
> > +
> > +       return meta;
> > +}
> > +
> > +static void eea_tx_meta_put_and_unmap(struct enet_tx *tx,
> > +                                     struct eea_tx_meta *meta)
> > +{
> > +       struct eea_tx_meta *head;
> > +
> > +       head =3D meta;
> > +
> > +       while (true) {
> > +               dma_unmap_single(tx->dma_dev, meta->dma_addr,
> > +                                meta->dma_len, DMA_TO_DEVICE);
> > +
> > +               meta->data =3D NULL;
> > +
> > +               if (meta->next) {
> > +                       meta =3D meta->next;
> > +                       continue;
> > +               }
> > +
> > +               break;
> > +       }
> > +
> > +       meta->next =3D tx->free;
> > +       tx->free =3D head;
> > +}
> > +
> > +static void eea_meta_free_xmit(struct enet_tx *tx,
> > +                              struct eea_tx_meta *meta,
> > +                              bool in_napi,
> > +                              struct eea_tx_cdesc *desc,
> > +                              struct eea_sq_free_stats *stats)
> > +{
> > +       struct sk_buff *skb =3D meta->skb;
> > +
> > +       if (!skb) {
> > +               netdev_err(tx->enet->netdev,
> > +                          "tx meta.data is null. id %d num: %d\n",
> > +                          meta->id, meta->num);
> > +               return;
> > +       }
> > +
> > +       if (unlikely((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) && d=
esc)) {
> > +               struct skb_shared_hwtstamps ts =3D {};
> > +
> > +               ts.hwtstamp =3D EEA_DESC_TS(desc) + tx->enet->hw_ts_off=
set;
> > +               skb_tstamp_tx(skb, &ts);
> > +       }
> > +
> > +       stats->bytes +=3D meta->skb->len;
> > +       napi_consume_skb(meta->skb, in_napi);
> > +}
> > +
> > +static u32 eea_clean_tx(struct enet_tx *tx)
> > +{
> > +       struct eea_sq_free_stats stats =3D {0};
> > +       struct eea_tx_cdesc *desc;
> > +       struct eea_tx_meta *meta;
> > +
> > +       while ((desc =3D ering_cq_get_desc(tx->ering))) {
> > +               ++stats.packets;
> > +
> > +               meta =3D &tx->meta[le16_to_cpu(desc->id)];
> > +
> > +               eea_meta_free_xmit(tx, meta, true, desc, &stats);
> > +
> > +               ering_cq_ack_desc(tx->ering, meta->num);
> > +               eea_tx_meta_put_and_unmap(tx, meta);
> > +       }
> > +
> > +       if (stats.packets) {
> > +               u64_stats_update_begin(&tx->stats.syncp);
> > +               u64_stats_add(&tx->stats.bytes, stats.bytes);
> > +               u64_stats_add(&tx->stats.packets, stats.packets);
> > +               u64_stats_update_end(&tx->stats.syncp);
> > +       }
> > +
> > +       return stats.packets;
> > +}
> > +
> > +int eea_poll_tx(struct enet_tx *tx, int budget)
> > +{
> > +       struct eea_net *enet =3D tx->enet;
> > +       u32 index =3D tx - enet->tx;
> > +       struct netdev_queue *txq;
> > +       u32 cleaned;
> > +
> > +       txq =3D netdev_get_tx_queue(enet->netdev, index);
> > +
> > +       __netif_tx_lock(txq, raw_smp_processor_id());
> > +
> > +       cleaned =3D eea_clean_tx(tx);
> > +
> > +       if (netif_tx_queue_stopped(txq) && cleaned > 0)
> > +               netif_tx_wake_queue(txq);
> > +
> > +       __netif_tx_unlock(txq);
> > +
> > +       return 0;
> > +}
> > +
> > +static int eea_fill_desc_from_skb(const struct sk_buff *skb,
> > +                                 struct ering *ering,
> > +                                 struct eea_tx_desc *desc)
> > +{
> > +       if (skb_is_gso(skb)) {
> > +               struct skb_shared_info *sinfo =3D skb_shinfo(skb);
> > +
> > +               desc->gso_size =3D cpu_to_le16(sinfo->gso_size);
> > +               if (sinfo->gso_type & SKB_GSO_TCPV4)
> > +                       desc->gso_type =3D EEA_TX_GSO_TCPV4;
> > +
> > +               else if (sinfo->gso_type & SKB_GSO_TCPV6)
> > +                       desc->gso_type =3D EEA_TX_GSO_TCPV6;
> > +
> > +               else if (sinfo->gso_type & SKB_GSO_UDP_L4)
> > +                       desc->gso_type =3D EEA_TX_GSO_UDP_L4;
> > +
> > +               else
> > +                       return -EINVAL;
> > +
> > +               if (sinfo->gso_type & SKB_GSO_TCP_ECN)
> > +                       desc->gso_type |=3D EEA_TX_GSO_ECN;
> > +       } else {
> > +               desc->gso_type =3D EEA_TX_GSO_NONE;
> > +       }
> > +
> > +       if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> > +               desc->csum_start =3D cpu_to_le16(skb_checksum_start_off=
set(skb));
> > +               desc->csum_offset =3D cpu_to_le16(skb->csum_offset);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static struct eea_tx_meta *eea_tx_desc_fill(struct enet_tx *tx, dma_ad=
dr_t addr,
> > +                                           u32 len, bool is_last, void=
 *data,
> > +                                           u16 flags)
> > +{
> > +       struct eea_tx_meta *meta;
> > +       struct eea_tx_desc *desc;
> > +
> > +       meta =3D eea_tx_meta_get(tx);
> > +
> > +       desc =3D ering_sq_alloc_desc(tx->ering, meta->id, is_last, flag=
s);
> > +       desc->addr =3D cpu_to_le64(addr);
> > +       desc->len =3D cpu_to_le16(len);
> > +
> > +       meta->next     =3D NULL;
> > +       meta->dma_len  =3D len;
> > +       meta->dma_addr =3D addr;
> > +       meta->data     =3D data;
> > +       meta->num      =3D 1;
> > +       meta->desc     =3D desc;
> > +
> > +       return meta;
> > +}
> > +
> > +static int eea_tx_add_skb_frag(struct enet_tx *tx,
> > +                              struct eea_tx_meta *head_meta,
> > +                              const skb_frag_t *frag, bool is_last)
> > +{
> > +       u32 len =3D skb_frag_size(frag);
> > +       struct eea_tx_meta *meta;
> > +       dma_addr_t addr;
> > +
> > +       addr =3D skb_frag_dma_map(tx->dma_dev, frag, 0, len, DMA_TO_DEV=
ICE);
> > +       if (unlikely(dma_mapping_error(tx->dma_dev, addr)))
> > +               return -ENOMEM;
> > +
> > +       meta =3D eea_tx_desc_fill(tx, addr, len, is_last, NULL, 0);
> > +
> > +       meta->next =3D head_meta->next;
> > +       head_meta->next =3D meta;
> > +
> > +       return 0;
> > +}
> > +
> > +static int eea_tx_post_skb(struct enet_tx *tx, struct sk_buff *skb)
> > +{
> > +       const struct skb_shared_info *shinfo =3D skb_shinfo(skb);
> > +       u32 hlen =3D skb_headlen(skb);
> > +       struct eea_tx_meta *meta;
> > +       dma_addr_t addr;
> > +       int i, err;
> > +       u16 flags;
> > +
> > +       addr =3D dma_map_single(tx->dma_dev, skb->data, hlen, DMA_TO_DE=
VICE);
> > +       if (unlikely(dma_mapping_error(tx->dma_dev, addr)))
> > +               return -ENOMEM;
> > +
> > +       flags =3D skb->ip_summed =3D=3D CHECKSUM_PARTIAL ? EEA_DESC_F_D=
O_CSUM : 0;
> > +
> > +       meta =3D eea_tx_desc_fill(tx, addr, hlen, !shinfo->nr_frags, sk=
b, flags);
> > +
> > +       if (eea_fill_desc_from_skb(skb, tx->ering, meta->desc))
> > +               goto err;
> > +
> > +       for (i =3D 0; i < shinfo->nr_frags; i++) {
> > +               const skb_frag_t *frag =3D &shinfo->frags[i];
> > +               bool is_last =3D i =3D=3D (shinfo->nr_frags - 1);
> > +
> > +               err =3D eea_tx_add_skb_frag(tx, meta, frag, is_last);
> > +               if (err)
> > +                       goto err;
> > +       }
> > +
> > +       meta->num =3D shinfo->nr_frags + 1;
> > +       ering_sq_commit_desc(tx->ering);
> > +
> > +       u64_stats_update_begin(&tx->stats.syncp);
> > +       u64_stats_add(&tx->stats.descs, meta->num);
> > +       u64_stats_update_end(&tx->stats.syncp);
> > +
> > +       return 0;
> > +
> > +err:
> > +       ering_sq_cancel(tx->ering);
> > +       eea_tx_meta_put_and_unmap(tx, meta);
> > +       return -ENOMEM;
> > +}
> > +
> > +static void eea_tx_kick(struct enet_tx *tx)
> > +{
> > +       ering_kick(tx->ering);
> > +
> > +       u64_stats_update_begin(&tx->stats.syncp);
> > +       u64_stats_inc(&tx->stats.kicks);
> > +       u64_stats_update_end(&tx->stats.syncp);
> > +}
> > +
> > +netdev_tx_t eea_tx_xmit(struct sk_buff *skb, struct net_device *netdev)
> > +{
> > +       const struct skb_shared_info *shinfo =3D skb_shinfo(skb);
> > +       struct eea_net *enet =3D netdev_priv(netdev);
> > +       int qnum =3D skb_get_queue_mapping(skb);
> > +       struct enet_tx *tx =3D &enet->tx[qnum];
> > +       struct netdev_queue *txq;
> > +       int err, n;
> > +
> > +       txq =3D netdev_get_tx_queue(netdev, qnum);
> > +
> > +       n =3D shinfo->nr_frags + 1;
> > +
> > +       if (!netif_txq_maybe_stop(txq, tx->ering->num_free, n, n)) {
> > +               /* maybe the previous skbs was xmitted without kick. */
> > +               eea_tx_kick(tx);
> > +               return NETDEV_TX_BUSY;
> > +       }
> > +
> > +       skb_tx_timestamp(skb);
> > +
> > +       err =3D eea_tx_post_skb(tx, skb);
> > +       if (unlikely(err)) {
> > +               u64_stats_update_begin(&tx->stats.syncp);
> > +               u64_stats_inc(&tx->stats.drops);
> > +               u64_stats_update_end(&tx->stats.syncp);
> > +
> > +               dev_kfree_skb_any(skb);
> > +       }
> > +
> > +       if (!netdev_xmit_more() || netif_xmit_stopped(txq))
> > +               eea_tx_kick(tx);
> > +
> > +       return NETDEV_TX_OK;
> > +}
> > +
> > +static void eea_free_meta(struct enet_tx *tx)
> > +{
> > +       struct eea_sq_free_stats stats;
> > +       struct eea_tx_meta *meta;
> > +       int i;
> > +
> > +       while ((meta =3D eea_tx_meta_get(tx)))
> > +               meta->skb =3D NULL;
> > +
> > +       for (i =3D 0; i < tx->enet->cfg.tx_ring_num; i++) {
> > +               meta =3D &tx->meta[i];
> > +
> > +               if (!meta->skb)
> > +                       continue;
> > +
> > +               eea_meta_free_xmit(tx, meta, false, NULL, &stats);
> > +
> > +               meta->skb =3D NULL;
> > +       }
> > +
> > +       kvfree(tx->meta);
> > +       tx->meta =3D NULL;
> > +}
> > +
> > +void eea_tx_timeout(struct net_device *netdev, unsigned int txqueue)
> > +{
> > +       struct netdev_queue *txq =3D netdev_get_tx_queue(netdev, txqueu=
e);
> > +       struct eea_net *priv =3D netdev_priv(netdev);
> > +       struct enet_tx *tx =3D &priv->tx[txqueue];
> > +
> > +       u64_stats_update_begin(&tx->stats.syncp);
> > +       u64_stats_inc(&tx->stats.timeouts);
> > +       u64_stats_update_end(&tx->stats.syncp);
> > +
> > +       netdev_err(netdev, "TX timeout on queue: %u, tx: %s, ering: 0x%=
x, %u usecs ago\n",
> > +                  txqueue, tx->name, tx->ering->index,
> > +                  jiffies_to_usecs(jiffies - READ_ONCE(txq->trans_star=
t)));
> > +}
> > +
> > +void eea_free_tx(struct enet_tx *tx)
> > +{
> > +       if (!tx)
> > +               return;
> > +
> > +       if (tx->ering) {
> > +               ering_free(tx->ering);
> > +               tx->ering =3D NULL;
> > +       }
> > +
> > +       if (tx->meta)
> > +               eea_free_meta(tx);
> > +}
> > +
> > +int eea_alloc_tx(struct eea_net_tmp *tmp, struct enet_tx *tx, u32 idx)
> > +{
> > +       struct eea_tx_meta *meta;
> > +       struct ering *ering;
> > +       u32 i;
> > +
> > +       u64_stats_init(&tx->stats.syncp);
> > +
> > +       sprintf(tx->name, "tx.%u", idx);
> > +
> > +       ering =3D ering_alloc(idx * 2 + 1, tmp->cfg.tx_ring_depth, tmp-=
>edev,
> > +                           tmp->cfg.tx_sq_desc_size,
> > +                           tmp->cfg.tx_cq_desc_size,
> > +                           tx->name);
> > +       if (!ering)
> > +               goto err;
> > +
> > +       tx->ering =3D ering;
> > +       tx->index =3D idx;
> > +       tx->dma_dev =3D tmp->edev->dma_dev;
> > +
> > +       /* meta */
> > +       tx->meta =3D kvcalloc(tmp->cfg.tx_ring_depth,
> > +                           sizeof(*tx->meta), GFP_KERNEL);
> > +       if (!tx->meta)
> > +               goto err;
> > +
> > +       for (i =3D 0; i < tmp->cfg.tx_ring_depth; ++i) {
> > +               meta =3D &tx->meta[i];
> > +               meta->id =3D i;
> > +               meta->next =3D tx->free;
> > +               tx->free =3D meta;
> > +       }
> > +
> > +       return 0;
> > +
> > +err:
> > +       eea_free_tx(tx);
> > +       return -ENOMEM;
> > +}
> > --
> > 2.32.0.3.g01195cf9f
> >
> >
>
>
> --
> Regards,
> Kalesh AP

