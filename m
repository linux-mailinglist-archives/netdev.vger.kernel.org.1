Return-Path: <netdev+bounces-208816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C2EB0D3D1
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 09:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C160B3B4E28
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 07:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD24328CF41;
	Tue, 22 Jul 2025 07:39:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0392DC35D
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 07:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169986; cv=none; b=fsQ0v7dIng6wKigcFOEg23mKeG5Wz8k8o3HNs8WXZO4IK3SMxrpLkfr2q+k4rOCTdhBIuBb6axHkHAgOY3PZjqZZKb6ULssRFVdjMu1m23LZ/tpKbVsLJ0eF8k7sEmPeddRTUDqPZ2w/Yhhxs9YpLI4R79Nd4L6tJfLTMkjL1zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169986; c=relaxed/simple;
	bh=KG2CQ8JaSCc5Hudhq30I9SLS6QRzHZa9ufiHeowdwZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMZhp9CjlB2brtEO5z86HKpaI6b4NF4X3TCVT6QVSaaR2DXKZD9uPqDA9p6haO3Mmj64/2QyeoRvFk7An/JAm0j1cqPcrToG77X7rZlkrkP99ZytW6F7XpqBCogxnGPkFetfom93z1TnJTFS6oq8ICAA0AzqCiH34M/PdpYcH9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz13t1753169972t3a0fb5fc
X-QQ-Originating-IP: uodqX2yQWmKmED3vUDH5xzOWcUJxkeNwbDPOqN7iCbY=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Jul 2025 15:39:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13522765026505502154
Date: Tue, 22 Jul 2025 15:39:30 +0800
From: Yibo Dong <dong100@mucse.com>
To: Brett Creeley <bcreeley@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/15] net: rnpgbe: Add basic mbx ops support
Message-ID: <B857D1489497DD88+20250722073930.GE99399@nic-Precision-5820-Tower>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-4-dong100@mucse.com>
 <6a0c5728-64a4-497a-a200-a0571ebe38f1@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a0c5728-64a4-497a-a200-a0571ebe38f1@amd.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NZcrde3zhHkVc4vD6pFJ0MuONmrBRZjLAltbe0gTErPL547gj4jB82sj
	Q8OHFvttXqLLfWUifwqWUmqFqafSvW2kToAWaVGQWIthc54G2QXsU9jFKCIw+c7T1kRCp0c
	y7rNi8y3xEGYEBfhacd3WlgeBWGx0N9ynynmRnH3o4v0IpHvEDHJ4T1RMP6Mi/sJZsRD3nr
	O52hEfxdFU1PGSNVXdvniTdEpsZdY+h+RR/mVJ9na+4tYCFBXUwS230gY03EGbvs6fOHvzW
	EaMrTUt9t3jjxqXPt4tqqK9TfqtSxJyK/+rJ+7TeVM4h7xBWIUbn+8FF8p9ZTF459TAIbmg
	qNTKDe41ESUcArcBmJJ6fC6nuwJQ7pAkG7yNGmFhv6ywEzsM4fxfHsQu9SdSFrrohXx0LoI
	6PvUe+5N54vhkfOBtdFJ2EZN5WH9dFc3nzqEgfZthe8X/iklvb24oWydt/hlOPzJQIn8vRw
	8fWtpqQwoDlfiIoDT4kErlAbFtoO67KtbOTOZ7LwMJY2eqAq1O4fHoK46bFXLlgMqCMm/fN
	98xqf3EAet6B7t+MbI3JQR5ypYlec3NtuEjmafqpZlIWeDxaXKNh71ZmsCukHA1AHno3wWw
	xqeweccD3tHzVXA/ZKusZQIQv2gQrcKjJQgikEfGjiBa82ZwwD7RQpZ1eY+0KM/gdObL9eN
	v4Nd1elW7GdFCNEyNY7Jwy0Zznx4XQQG84xKZLOXxA5GkAfR442eAnChtXw2WRENbBiIDL0
	rhDed5hPsxShR2TMsyj2wpZvtFlOkNV/H/bCmrw2a2JVDytW0CpzKvEd0bZoVDQ6Xoz+Nlf
	GnRcjSAQslPuGS7q4a+8X/R1m3cKxZQFhst1sMbbjCae1bJU2Nhuj9uxf8aPV/ORPkRx+Ch
	Kg/FVTJzIr0aCX29PSsF6bFrUO+KnckCFRVDqbr4L2b6NDYnTtBhuLb0NoblBFeBakRjSnZ
	MZSDjQjDmSsBiGDFIWoRBqsslKqePl5G5cxLunGpGG5p8/gj7dpHR+5UOZPhT44g0AG2lve
	LLPkdZ47UeDCHe9/kJilPnOBtAbwA=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

On Mon, Jul 21, 2025 at 02:54:00PM -0700, Brett Creeley wrote:
> On 7/21/2025 4:32 AM, Dong Yibo wrote:
> > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > 
> > 
> > Initialize basic mbx function.
> > 
> > Signed-off-by: Dong Yibo <dong100@mucse.com>
> > ---
> >   drivers/net/ethernet/mucse/rnpgbe/Makefile    |   5 +-
> >   drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  46 ++
> >   .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |   5 +-
> >   drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   2 +
> >   .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |   1 +
> >   .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 623 ++++++++++++++++++
> >   .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  48 ++
> >   7 files changed, 727 insertions(+), 3 deletions(-)
> >   create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> >   create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
> > 
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/Makefile b/drivers/net/ethernet/mucse/rnpgbe/Makefile
> > index 42c359f459d9..41177103b50c 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/Makefile
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/Makefile
> > @@ -5,5 +5,6 @@
> >   #
> > 
> >   obj-$(CONFIG_MGBE) += rnpgbe.o
> > -rnpgbe-objs := rnpgbe_main.o\
> > -              rnpgbe_chip.o
> > +rnpgbe-objs := rnpgbe_main.o \
> > +              rnpgbe_chip.o \
> > +              rnpgbe_mbx.o
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > index 2ae836fc8951..46e2bb2fe71e 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > @@ -63,9 +63,51 @@ struct mucse_mac_info {
> >          int clk_csr;
> >   };
> > 
> > +struct mucse_hw;
> > +
> > +enum MBX_ID {
> > +       MBX_VF0 = 0,
> > +       MBX_VF1,
> > +       MBX_VF2,
> > +       MBX_VF3,
> > +       MBX_VF4,
> > +       MBX_VF5,
> > +       MBX_VF6,
> > +       MBX_VF7,
> > +       MBX_CM3CPU,
> > +       MBX_FW = MBX_CM3CPU,
> > +       MBX_VFCNT
> > +};
> > +
> > +struct mucse_mbx_operations {
> > +       void (*init_params)(struct mucse_hw *hw);
> > +       int (*read)(struct mucse_hw *hw, u32 *msg,
> > +                   u16 size, enum MBX_ID id);
> > +       int (*write)(struct mucse_hw *hw, u32 *msg,
> > +                    u16 size, enum MBX_ID id);
> > +       int (*read_posted)(struct mucse_hw *hw, u32 *msg,
> > +                          u16 size, enum MBX_ID id);
> > +       int (*write_posted)(struct mucse_hw *hw, u32 *msg,
> > +                           u16 size, enum MBX_ID id);
> > +       int (*check_for_msg)(struct mucse_hw *hw, enum MBX_ID id);
> > +       int (*check_for_ack)(struct mucse_hw *hw, enum MBX_ID id);
> > +       void (*configure)(struct mucse_hw *hw, int num_vec,
> > +                         bool enable);
> > +};
> > +
> > +struct mucse_mbx_stats {
> > +       u32 msgs_tx;
> > +       u32 msgs_rx;
> > +       u32 acks;
> > +       u32 reqs;
> > +       u32 rsts;
> > +};
> > +
> >   #define MAX_VF_NUM (8)
> > 
> >   struct mucse_mbx_info {
> > +       struct mucse_mbx_operations ops;
> > +       struct mucse_mbx_stats stats;
> >          u32 timeout;
> >          u32 usec_delay;
> >          u32 v2p_mailbox;
> > @@ -99,6 +141,8 @@ struct mucse_mbx_info {
> >          int share_size;
> >   };
> > 
> > +#include "rnpgbe_mbx.h"
> > +
> >   struct mucse_hw {
> >          void *back;
> >          u8 pfvfnum;
> > @@ -110,6 +154,8 @@ struct mucse_hw {
> >          u16 vendor_id;
> >          u16 subsystem_device_id;
> >          u16 subsystem_vendor_id;
> > +       int max_vfs;
> > +       int max_vfs_noari;
> >          enum rnpgbe_hw_type hw_type;
> >          struct mucse_dma_info dma;
> >          struct mucse_eth_info eth;
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > index 38c094965db9..b0e5fda632f3 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > @@ -6,6 +6,7 @@
> > 
> >   #include "rnpgbe.h"
> >   #include "rnpgbe_hw.h"
> > +#include "rnpgbe_mbx.h"
> > 
> >   /**
> >    * rnpgbe_get_invariants_n500 - setup for hw info
> > @@ -67,7 +68,7 @@ static void rnpgbe_get_invariants_n500(struct mucse_hw *hw)
> >          mbx->fw_pf_mbox_mask = 0x2e200;
> >          mbx->fw_vf_share_ram = 0x2b000;
> >          mbx->share_size = 512;
> > -
> > +       memcpy(&hw->mbx.ops, &mucse_mbx_ops_generic, sizeof(hw->mbx.ops));
> >          /* setup net feature here */
> >          hw->feature_flags |= M_NET_FEATURE_SG |
> >                               M_NET_FEATURE_TX_CHECKSUM |
> > @@ -83,6 +84,7 @@ static void rnpgbe_get_invariants_n500(struct mucse_hw *hw)
> >                               M_NET_FEATURE_STAG_OFFLOAD;
> >          /* start the default ahz, update later */
> >          hw->usecstocount = 125;
> > +       hw->max_vfs = 7;
> >   }
> > 
> >   /**
> > @@ -117,6 +119,7 @@ static void rnpgbe_get_invariants_n210(struct mucse_hw *hw)
> >          /* update hw feature */
> >          hw->feature_flags |= M_HW_FEATURE_EEE;
> >          hw->usecstocount = 62;
> > +       hw->max_vfs_noari = 7;
> >   }
> > 
> >   const struct rnpgbe_info rnpgbe_n500_info = {
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> > index 2c7372a5e88d..ff7bd9b21550 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> > @@ -14,6 +14,8 @@
> >   #define RNPGBE_RING_BASE (0x1000)
> >   #define RNPGBE_MAC_BASE (0x20000)
> >   #define RNPGBE_ETH_BASE (0x10000)
> > +
> > +#define RNPGBE_DMA_DUMY (0x000c)
> >   /* chip resourse */
> >   #define RNPGBE_MAX_QUEUES (8)
> >   /* multicast control table */
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> > index 08f773199e9b..1e8360cae560 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> > @@ -114,6 +114,7 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
> >          hw->hw_addr = hw_addr;
> >          hw->dma.dma_version = dma_version;
> >          ii->get_invariants(hw);
> > +       hw->mbx.ops.init_params(hw);
> > 
> >          return 0;
> > 
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> > new file mode 100644
> > index 000000000000..56ace3057fea
> > --- /dev/null
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> > @@ -0,0 +1,623 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright(c) 2022 - 2025 Mucse Corporation. */
> > +
> > +#include <linux/pci.h>
> > +#include <linux/errno.h>
> > +#include <linux/delay.h>
> > +#include <linux/iopoll.h>
> > +#include "rnpgbe.h"
> > +#include "rnpgbe_mbx.h"
> > +#include "rnpgbe_hw.h"
> > +
> > +/**
> > + * mucse_read_mbx - Reads a message from the mailbox
> > + * @hw: Pointer to the HW structure
> > + * @msg: The message buffer
> > + * @size: Length of buffer
> > + * @mbx_id: Id of vf/fw to read
> > + *
> > + * @return: 0 on success, negative on failure
> > + **/
> > +int mucse_read_mbx(struct mucse_hw *hw, u32 *msg, u16 size,
> > +                  enum MBX_ID mbx_id)
> > +{
> > +       struct mucse_mbx_info *mbx = &hw->mbx;
> > +
> > +       /* limit read to size of mailbox */
> > +       if (size > mbx->size)
> > +               size = mbx->size;
> 
> This is just min(size, mbx->size). There's no need to open code min().
> 

Got it. I will improve it.

> > +
> > +       if (!mbx->ops.read)
> > +               return -EIO;
> > +
> > +       return mbx->ops.read(hw, msg, size, mbx_id);
> > +}
> > +
> > +/**
> > + * mucse_write_mbx - Write a message to the mailbox
> > + * @hw: Pointer to the HW structure
> > + * @msg: The message buffer
> > + * @size: Length of buffer
> > + * @mbx_id: Id of vf/fw to write
> > + *
> > + * @return: 0 on success, negative on failure
> > + **/
> > +int mucse_write_mbx(struct mucse_hw *hw, u32 *msg, u16 size,
> > +                   enum MBX_ID mbx_id)
> > +{
> > +       struct mucse_mbx_info *mbx = &hw->mbx;
> > +
> > +       if (size > mbx->size)
> > +               return -EINVAL;
> > +
> > +       if (!mbx->ops.write)
> > +               return -EIO;
> > +
> > +       return mbx->ops.write(hw, msg, size, mbx_id);
> > +}
> > +
> > +/**
> > + * mucse_mbx_get_req - Read req from reg
> > + * @hw: Pointer to the HW structure
> > + * @reg: Register to read
> > + *
> > + * @return: the req value
> > + **/
> > +static u16 mucse_mbx_get_req(struct mucse_hw *hw, int reg)
> > +{
> > +       /* force memory barrier */
> > +       mb();
> > +       return ioread32(hw->hw_addr + reg) & GENMASK(15, 0);
> > +}
> > +
> > +/**
> > + * mucse_mbx_get_ack - Read ack from reg
> > + * @hw: Pointer to the HW structure
> > + * @reg: Register to read
> > + *
> > + * @return: the ack value
> > + **/
> > +static u16 mucse_mbx_get_ack(struct mucse_hw *hw, int reg)
> > +{
> > +       /* force memory barrier */
> > +       mb();
> > +       return (mbx_rd32(hw, reg) >> 16);
> > +}
> > +
> > +/**
> > + * mucse_mbx_inc_pf_req - Increase req
> > + * @hw: Pointer to the HW structure
> > + * @mbx_id: Id of vf/fw to read
> > + *
> > + * mucse_mbx_inc_pf_req read pf_req from hw, then write
> > + * new value back after increase
> > + **/
> > +static void mucse_mbx_inc_pf_req(struct mucse_hw *hw,
> > +                                enum MBX_ID mbx_id)
> > +{
> > +       struct mucse_mbx_info *mbx = &hw->mbx;
> > +       u32 reg, v;
> > +       u16 req;
> > +
> > +       reg = (mbx_id == MBX_FW) ? PF2FW_COUNTER(mbx) :
> > +                                  PF2VF_COUNTER(mbx, mbx_id);
> > +       v = mbx_rd32(hw, reg);
> > +       req = (v & GENMASK(15, 0));
> > +       req++;
> > +       v &= GENMASK(31, 16);
> > +       v |= req;
> > +       /* force before write to hw */
> > +       mb();
> > +       mbx_wr32(hw, reg, v);
> > +       /* update stats */
> 
> Nit, but this comment is unnecessary. Same comment for all of the other
> identical comments. They are just repeating "what" you are doing.
> 

Got it, I will try to check other patches. 

> > +       hw->mbx.stats.msgs_tx++;
> > +}
> > +
> > +/**
> > + * mucse_mbx_inc_pf_ack - Increase ack
> > + * @hw: Pointer to the HW structure
> > + * @mbx_id: Id of vf/fw to read
> > + *
> > + * mucse_mbx_inc_pf_ack read pf_ack from hw, then write
> > + * new value back after increase
> > + **/
> > +static void mucse_mbx_inc_pf_ack(struct mucse_hw *hw,
> > +                                enum MBX_ID mbx_id)
> > +{
> > +       struct mucse_mbx_info *mbx = &hw->mbx;
> > +       u32 reg, v;
> > +       u16 ack;
> > +
> > +       reg = (mbx_id == MBX_FW) ? PF2FW_COUNTER(mbx) :
> > +                                  PF2VF_COUNTER(mbx, mbx_id);
> > +       v = mbx_rd32(hw, reg);
> > +       ack = (v >> 16) & GENMASK(15, 0);
> > +       ack++;
> > +       v &= GENMASK(15, 0);
> > +       v |= (ack << 16);
> > +       /* force before write to hw */
> > +       mb();
> > +       mbx_wr32(hw, reg, v);
> > +       /* update stats */
> > +       hw->mbx.stats.msgs_rx++;
> > +}
> > +
> > +/**
> > + * mucse_check_for_msg - Checks to see if vf/fw sent us mail
> > + * @hw: Pointer to the HW structure
> > + * @mbx_id: Id of vf/fw to check
> > + *
> > + * @return: 0 on success, negative on failure
> > + **/
> > +int mucse_check_for_msg(struct mucse_hw *hw, enum MBX_ID mbx_id)
> > +{
> > +       struct mucse_mbx_info *mbx = &hw->mbx;
> > +
> > +       if (!mbx->ops.check_for_msg)
> > +               return -EIO;
> > +
> > +       return mbx->ops.check_for_msg(hw, mbx_id);
> > +}
> > +
> > +/**
> > + * mucse_check_for_ack - Checks to see if vf/fw sent us ACK
> > + * @hw: Pointer to the HW structure
> > + * @mbx_id: Id of vf/fw to check
> > + *
> > + * @return: 0 on success, negative on failure
> > + **/
> > +int mucse_check_for_ack(struct mucse_hw *hw, enum MBX_ID mbx_id)
> > +{
> > +       struct mucse_mbx_info *mbx = &hw->mbx;
> > +
> > +       if (!mbx->ops.check_for_ack)
> > +               return -EIO;
> > +       return mbx->ops.check_for_ack(hw, mbx_id);
> > +}
> > +
> > +/**
> > + * mucse_poll_for_msg - Wait for message notification
> > + * @hw: Pointer to the HW structure
> > + * @mbx_id: Id of vf/fw to poll
> > + *
> > + * @return: 0 on success, negative on failure
> > + **/
> > +static int mucse_poll_for_msg(struct mucse_hw *hw, enum MBX_ID mbx_id)
> > +{
> > +       struct mucse_mbx_info *mbx = &hw->mbx;
> > +       int countdown = mbx->timeout;
> > +       int val;
> > +
> > +       if (!countdown || !mbx->ops.check_for_msg)
> > +               return -EIO;
> > +
> > +       return read_poll_timeout(mbx->ops.check_for_msg,
> > +                                val, val == 0, mbx->usec_delay,
> > +                                countdown * mbx->usec_delay,
> > +                                false, hw, mbx_id);
> > +}
> > +
> > +/**
> > + * mucse_poll_for_ack - Wait for message acknowledgment
> > + * @hw: Pointer to the HW structure
> > + * @mbx_id: Id of vf/fw to poll
> > + *
> > + * @return: 0 if it successfully received a message acknowledgment
> > + **/
> > +static int mucse_poll_for_ack(struct mucse_hw *hw, enum MBX_ID mbx_id)
> > +{
> > +       struct mucse_mbx_info *mbx = &hw->mbx;
> > +       int countdown = mbx->timeout;
> > +       int val;
> > +
> > +       if (!countdown || !mbx->ops.check_for_ack)
> > +               return -EIO;
> > +
> > +       return read_poll_timeout(mbx->ops.check_for_ack,
> > +                                val, val == 0, mbx->usec_delay,
> > +                                countdown * mbx->usec_delay,
> > +                                false, hw, mbx_id);
> > +}
> > +
> > +/**
> > + * mucse_read_posted_mbx - Wait for message notification and receive message
> > + * @hw: Pointer to the HW structure
> > + * @msg: The message buffer
> > + * @size: Length of buffer
> > + * @mbx_id: Id of vf/fw to read
> > + *
> > + * @return: 0 if it successfully received a message notification and
> > + * copied it into the receive buffer.
> > + **/
> > +static int mucse_read_posted_mbx(struct mucse_hw *hw, u32 *msg, u16 size,
> > +                                enum MBX_ID mbx_id)
> > +{
> > +       struct mucse_mbx_info *mbx = &hw->mbx;
> > +       int ret_val;
> > +
> > +       if (!mbx->ops.read)
> > +               return -EIO;
> > +
> > +       ret_val = mucse_poll_for_msg(hw, mbx_id);
> > +
> > +       /* if ack received read message, otherwise we timed out */
> > +       if (!ret_val)
> > +               ret_val = mbx->ops.read(hw, msg, size, mbx_id);
> > +
> > +       return ret_val;
> 
> IMO a more typical flow would be the following:
> 
> ret_val = mucse_poll_for_msg();
> if (ret_val)
> 	return ret_val;
> 
> return mbx->ops.read();
> 

Got it, I will improve it.

> > +}
> > +
> > +/**
> > + * mucse_write_posted_mbx - Write a message to the mailbox, wait for ack
> > + * @hw: Pointer to the HW structure
> > + * @msg: The message buffer
> > + * @size: Length of buffer
> > + * @mbx_id: Id of vf/fw to write
> > + *
> > + * @return: 0 if it successfully copied message into the buffer and
> > + * received an ack to that message within delay * timeout period
> > + **/
> > +static int mucse_write_posted_mbx(struct mucse_hw *hw, u32 *msg, u16 size,
> > +                                 enum MBX_ID mbx_id)
> > +{
> > +       struct mucse_mbx_info *mbx = &hw->mbx;
> > +       int ret_val;
> > +
> > +       /* exit if either we can't write or there isn't a defined timeout */
> > +       if (!mbx->ops.write || !mbx->timeout)
> > +               return -EIO;
> > +
> > +       /* send msg and hold buffer lock */
> > +       ret_val = mbx->ops.write(hw, msg, size, mbx_id);
> > +
> > +       /* if msg sent wait until we receive an ack */
> > +       if (!ret_val)
> > +               ret_val = mucse_poll_for_ack(hw, mbx_id);
> > +
> > +       return ret_val;
> 
> 
> IMO a more typical flow would be the following:
> 
> ret_val = mbx->ops.write();
> if (ret_val)
> 	return ret_val;
> 
> return mucse_poll_for_ack();
> 

Got it, I will improve it.

> > +}
> > +
> > +/**
> > + * mucse_check_for_msg_pf - checks to see if the vf/fw has sent mail
> > + * @hw: Pointer to the HW structure
> > + * @mbx_id: Id of vf/fw to check
> > + *
> > + * @return: 0 if the vf/fw has set the Status bit or else
> > + * -EIO
> > + **/
> > +static int mucse_check_for_msg_pf(struct mucse_hw *hw,
> > +                                 enum MBX_ID mbx_id)
> > +{
> > +       struct mucse_mbx_info *mbx = &hw->mbx;
> > +       u16 hw_req_count = 0;
> > +       int ret_val = -EIO;
> > +
> > +       if (mbx_id == MBX_FW) {
> > +               hw_req_count = mucse_mbx_get_req(hw, FW2PF_COUNTER(mbx));
> > +               /* reg in hw should avoid 0 check */
> 
> This comment explains "what" you are doing/preventing, but if the comment is
> necessary it should explain "why" it's being done.
> 

Got it, maybe like this?
Some chip's register FW2PF_COUNTER(mbx) is reset to 0 when rc send reset mbx
command. This causes 'hw_req_count != hw->mbx.fw_req' be true before fw really
reply. Driver must wait fw reset done reply before using chip.

> > +               if (mbx->mbx_feature & MBX_FEATURE_NO_ZERO) {
> > +                       if (hw_req_count != 0 &&
> > +                           hw_req_count != hw->mbx.fw_req) {
> > +                               ret_val = 0;
> > +                               hw->mbx.stats.reqs++;
> > +                       }
> > +               } else {
> > +                       if (hw_req_count != hw->mbx.fw_req) {
> > +                               ret_val = 0;
> > +                               hw->mbx.stats.reqs++;
> > +                       }
> > +               }
> > +       } else {
> > +               if (mucse_mbx_get_req(hw, VF2PF_COUNTER(mbx, mbx_id)) !=
> > +                   hw->mbx.vf_req[mbx_id]) {
> > +                       ret_val = 0;
> > +                       hw->mbx.stats.reqs++;
> > +               }
> > +       }
> > +
> > +       return ret_val;
> 
> Nit, but ret_val isn't really needed in this function. You can just return 0
> in all of the places where you set ret_val to 0. If you get here you can
> "return -EIO".
> 

Got it, I will improve it.

> > +}
> > +
> > +/**
> > + * mucse_check_for_ack_pf - checks to see if the VF has ACKed
> > + * @hw: Pointer to the HW structure
> > + * @mbx_id: Id of vf/fw to check
> > + *
> > + * @return: 0 if the vf/fw has set the Status bit or else
> > + * -EIO
> > + **/
> > +static int mucse_check_for_ack_pf(struct mucse_hw *hw, enum MBX_ID mbx_id)
> > +{
> > +       struct mucse_mbx_info *mbx = &hw->mbx;
> > +       int ret_val = -EIO;
> > +       u16 hw_fw_ack;
> > +
> > +       if (mbx_id == MBX_FW) {
> > +               hw_fw_ack = mucse_mbx_get_ack(hw, FW2PF_COUNTER(mbx));
> > +               if (hw_fw_ack != 0 &&
> > +                   hw_fw_ack != hw->mbx.fw_ack) {
> > +                       ret_val = 0;
> > +                       hw->mbx.stats.acks++;
> > +               }
> > +       } else {
> > +               if (mucse_mbx_get_ack(hw, VF2PF_COUNTER(mbx, mbx_id)) !=
> > +                   hw->mbx.vf_ack[mbx_id]) {
> > +                       ret_val = 0;
> > +                       hw->mbx.stats.acks++;
> > +               }
> > +       }
> > +
> > +       return ret_val;
> 
> Ditto on ret_val being unnecessary.
> 

Got it, I will improve it.

> > +}
> > +
> > +/**
> > + * mucse_obtain_mbx_lock_pf - obtain mailbox lock
> > + * @hw: pointer to the HW structure
> > + * @mbx_id: Id of vf/fw to obtain
> > + *
> > + * This function maybe used in an irq handler.
> 
> 
> Nit, s/maybe/may be/
> 

Got it, I will fix it.

> > + *
> > + * @return: 0 if we obtained the mailbox lock
> > + **/
> > +static int mucse_obtain_mbx_lock_pf(struct mucse_hw *hw, enum MBX_ID mbx_id)
> > +{
> > +       struct mucse_mbx_info *mbx = &hw->mbx;
> > +       int try_cnt = 5000, ret;
> > +       u32 reg;
> > +
> > +       reg = (mbx_id == MBX_FW) ? PF2FW_MBOX_CTRL(mbx) :
> > +                                  PF2VF_MBOX_CTRL(mbx, mbx_id);
> > +       while (try_cnt-- > 0) {
> > +               /* Take ownership of the buffer */
> > +               mbx_wr32(hw, reg, MBOX_PF_HOLD);
> > +               /* force write back before check */
> > +               wmb();
> > +               if (mbx_rd32(hw, reg) & MBOX_PF_HOLD)
> > +                       return 0;
> > +               udelay(100);
> > +       }
> > +       return ret;
> 
> Just as Andrew said, this is uninitialized. I don't think ret is needed at
> all in this function.
> 
> Please think about whether local variables are needed or not in the rest of
> the patches.
> 
> In this case you return 0 right away on success and can return -ETIMEDOUT
> (or whatever is appropriate) on failure.
> 

Yes, you are right. I will check rest of the patches.

> > +}
> > +
> > +/**
> > + * mucse_write_mbx_pf - Places a message in the mailbox
> > + * @hw: pointer to the HW structure
> > + * @msg: The message buffer
> > + * @size: Length of buffer
> > + * @mbx_id: Id of vf/fw to write
> > + *
> > + * This function maybe used in an irq handler.
> > + *
> > + * @return: 0 if it successfully copied message into the buffer
> > + **/
> > +static int mucse_write_mbx_pf(struct mucse_hw *hw, u32 *msg, u16 size,
> > +                             enum MBX_ID mbx_id)
> > +{
> > +       struct mucse_mbx_info *mbx = &hw->mbx;
> > +       u32 data_reg, ctrl_reg;
> > +       int ret_val = 0;
> > +       u16 i;
> > +
> > +       data_reg = (mbx_id == MBX_FW) ? FW_PF_SHM_DATA(mbx) :
> > +                                       PF_VF_SHM_DATA(mbx, mbx_id);
> > +       ctrl_reg = (mbx_id == MBX_FW) ? PF2FW_MBOX_CTRL(mbx) :
> > +                                       PF2VF_MBOX_CTRL(mbx, mbx_id);
> > +       if (size > MUCSE_VFMAILBOX_SIZE)
> > +               return -EINVAL;
> > +
> > +       /* lock the mailbox to prevent pf/vf/fw race condition */
> > +       ret_val = mucse_obtain_mbx_lock_pf(hw, mbx_id);
> > +       if (ret_val)
> > +               goto out_no_write;
> 
> Just return directly here. No need for a goto.
> 

Got it, I will improve it.

> > +
> > +       /* copy the caller specified message to the mailbox memory buffer */
> > +       for (i = 0; i < size; i++)
> > +               mbx_wr32(hw, data_reg + i * 4, msg[i]);
> > +
> > +       /* flush msg and acks as we are overwriting the message buffer */
> > +       if (mbx_id == MBX_FW) {
> > +               hw->mbx.fw_ack = mucse_mbx_get_ack(hw, FW2PF_COUNTER(mbx));
> > +       } else {
> > +               hw->mbx.vf_ack[mbx_id] =
> > +                       mucse_mbx_get_ack(hw, VF2PF_COUNTER(mbx, mbx_id));
> > +       }
> > +       mucse_mbx_inc_pf_req(hw, mbx_id);
> > +
> > +       /* Interrupt VF/FW to tell it a message
> > +        * has been sent and release buffer
> > +        */
> > +       if (mbx->mbx_feature & MBX_FEATURE_WRITE_DELAY)
> > +               udelay(300);
> 
> This delay seems arbitrary. How do you know 300us is sufficient?
> 

Yes, it is sufficient. But there is no explicit condition for it...
It is used to avoid timing issue in chip bus.
'Delay some time before write MBOX_CTRL_REQ reg' is required by chip
designer.

> > +       mbx_wr32(hw, ctrl_reg, MBOX_CTRL_REQ);
> > +
> > +out_no_write:
> 
> This label isn't required, unless it's used in a future patch. If that's the
> case introduce it in the future patch.
> 

Got it, I will improve it.

> > +       return ret_val;
> > +}
> > +
> > +/**
> > + * mucse_read_mbx_pf - Read a message from the mailbox
> > + * @hw: pointer to the HW structure
> > + * @msg: The message buffer
> > + * @size: Length of buffer
> > + * @mbx_id: Id of vf/fw to read
> > + *
> > + * This function copies a message from the mailbox buffer to the caller's
> > + * memory buffer.  The presumption is that the caller knows that there was
> > + * a message due to a vf/fw request so no polling for message is needed.
> > + *
> > + * @return: 0 on success, negative on failure
> > + **/
> > +static int mucse_read_mbx_pf(struct mucse_hw *hw, u32 *msg, u16 size,
> > +                            enum MBX_ID mbx_id)
> > +{
> > +       struct mucse_mbx_info *mbx = &hw->mbx;
> > +       u32 data_reg, ctrl_reg;
> > +       int ret_val;
> > +       u32 i;
> > +
> > +       data_reg = (mbx_id == MBX_FW) ? FW_PF_SHM_DATA(mbx) :
> > +                                       PF_VF_SHM_DATA(mbx, mbx_id);
> > +       ctrl_reg = (mbx_id == MBX_FW) ? PF2FW_MBOX_CTRL(mbx) :
> > +                                       PF2VF_MBOX_CTRL(mbx, mbx_id);
> > +
> > +       if (size > MUCSE_VFMAILBOX_SIZE)
> > +               return -EINVAL;
> > +       /* lock the mailbox to prevent pf/vf race condition */
> > +       ret_val = mucse_obtain_mbx_lock_pf(hw, mbx_id);
> > +       if (ret_val)
> > +               goto out_no_read;
> > +
> > +       /* we need this */
> 
> This comment doesn't seem useful at all. Why do you need this comment?
> 

Yes, as Andrew pointed out, I should check 'mb()' here.

> > +       mb();
> > +       /* copy the message from the mailbox memory buffer */
> > +       for (i = 0; i < size; i++)
> > +               msg[i] = mbx_rd32(hw, data_reg + 4 * i);
> > +       mbx_wr32(hw, data_reg, 0);
> > +
> > +       /* update req */
> > +       if (mbx_id == MBX_FW) {
> > +               hw->mbx.fw_req = mucse_mbx_get_req(hw, FW2PF_COUNTER(mbx));
> > +       } else {
> > +               hw->mbx.vf_req[mbx_id] =
> > +                       mucse_mbx_get_req(hw, VF2PF_COUNTER(mbx, mbx_id));
> > +       }
> > +       /* Acknowledge receipt and release mailbox, then we're done */
> > +       mucse_mbx_inc_pf_ack(hw, mbx_id);
> > +       /* free ownership of the buffer */
> > +       mbx_wr32(hw, ctrl_reg, 0);
> > +
> > +out_no_read:
> > +       return ret_val;
> > +}
> > +
> > +/**
> > + * mucse_mbx_reset - reset mbx info, sync info from regs
> > + * @hw: Pointer to the HW structure
> > + *
> > + * This function reset all mbx variables to default.
> > + **/
> > +static void mucse_mbx_reset(struct mucse_hw *hw)
> > +{
> > +       struct mucse_mbx_info *mbx = &hw->mbx;
> > +       int idx, v;
> > +
> > +       for (idx = 0; idx < hw->max_vfs; idx++) {
> > +               v = mbx_rd32(hw, VF2PF_COUNTER(mbx, idx));
> > +               hw->mbx.vf_req[idx] = v & GENMASK(15, 0);
> > +               hw->mbx.vf_ack[idx] = (v >> 16) & GENMASK(15, 0);
> > +               mbx_wr32(hw, PF2VF_MBOX_CTRL(mbx, idx), 0);
> > +       }
> > +       v = mbx_rd32(hw, FW2PF_COUNTER(mbx));
> > +       hw->mbx.fw_req = v & GENMASK(15, 0);
> > +       hw->mbx.fw_ack = (v >> 16) & GENMASK(15, 0);
> > +
> > +       mbx_wr32(hw, PF2FW_MBOX_CTRL(mbx), 0);
> > +
> > +       if (PF_VF_MBOX_MASK_LO(mbx))
> > +               mbx_wr32(hw, PF_VF_MBOX_MASK_LO(mbx), 0);
> > +       if (PF_VF_MBOX_MASK_HI(mbx))
> > +               mbx_wr32(hw, PF_VF_MBOX_MASK_HI(mbx), 0);
> > +
> > +       mbx_wr32(hw, FW_PF_MBOX_MASK(mbx), GENMASK(31, 16));
> > +}
> > +
> > +/**
> > + * mucse_mbx_configure_pf - configure mbx to use nr_vec interrupt
> > + * @hw: Pointer to the HW structure
> > + * @nr_vec: Vector number for mbx
> > + * @enable: TRUE for enable, FALSE for disable
> > + *
> > + * This function configure mbx to use interrupt nr_vec.
> > + **/
> > +static void mucse_mbx_configure_pf(struct mucse_hw *hw, int nr_vec,
> > +                                  bool enable)
> > +{
> > +       struct mucse_mbx_info *mbx = &hw->mbx;
> > +       int idx = 0;
> 
> Nit, you don't need to initialize idx. It's always initialized before it's
> used.
> 

Got it, I will improve it.

> > +       u32 v;
> > +
> > +       if (enable) {
> > +               for (idx = 0; idx < hw->max_vfs; idx++) {
> > +                       v = mbx_rd32(hw, VF2PF_COUNTER(mbx, idx));
> > +                       hw->mbx.vf_req[idx] = v & GENMASK(15, 0);
> > +                       hw->mbx.vf_ack[idx] = (v >> 16) & GENMASK(15, 0);
> > +
> > +                       mbx_wr32(hw, PF2VF_MBOX_CTRL(mbx, idx), 0);
> > +               }
> > +               v = mbx_rd32(hw, FW2PF_COUNTER(mbx));
> > +               hw->mbx.fw_req = v & GENMASK(15, 0);
> > +               hw->mbx.fw_ack = (v >> 16) & GENMASK(15, 0);
> > +               mbx_wr32(hw, PF2FW_MBOX_CTRL(mbx), 0);
> > +
> > +               for (idx = 0; idx < hw->max_vfs; idx++) {
> > +                       /* vf to pf req interrupt */
> > +                       mbx_wr32(hw, VF2PF_MBOX_VEC(mbx, idx),
> > +                                nr_vec);
> > +               }
> > +
> > +               if (PF_VF_MBOX_MASK_LO(mbx))
> > +                       mbx_wr32(hw, PF_VF_MBOX_MASK_LO(mbx), 0);
> > +               /* allow vf to vectors */
> > +
> > +               if (PF_VF_MBOX_MASK_HI(mbx))
> > +                       mbx_wr32(hw, PF_VF_MBOX_MASK_HI(mbx), 0);
> > +               /* enable irq */
> > +               /* bind fw mbx to irq */
> > +               mbx_wr32(hw, FW2PF_MBOX_VEC(mbx), nr_vec);
> > +               /* allow CM3FW to PF MBX IRQ */
> > +               mbx_wr32(hw, FW_PF_MBOX_MASK(mbx), GENMASK(31, 16));
> > +       } else {
> > +               if (PF_VF_MBOX_MASK_LO(mbx))
> > +                       mbx_wr32(hw, PF_VF_MBOX_MASK_LO(mbx),
> > +                                GENMASK(31, 0));
> > +               /* disable irq */
> > +               if (PF_VF_MBOX_MASK_HI(mbx))
> > +                       mbx_wr32(hw, PF_VF_MBOX_MASK_HI(mbx),
> > +                                GENMASK(31, 0));
> > +
> > +               /* disable CM3FW to PF MBX IRQ */
> > +               mbx_wr32(hw, FW_PF_MBOX_MASK(mbx), 0xfffffffe);
> > +
> > +               /* reset vf->pf status/ctrl */
> > +               for (idx = 0; idx < hw->max_vfs; idx++)
> > +                       mbx_wr32(hw, PF2VF_MBOX_CTRL(mbx, idx), 0);
> > +               /* reset pf->cm3 ctrl */
> > +               mbx_wr32(hw, PF2FW_MBOX_CTRL(mbx), 0);
> > +               /* used to sync link status */
> > +               mbx_wr32(hw, RNPGBE_DMA_DUMY, 0);
> > +       }
> > +}
> > +
> > +/**
> > + * mucse_init_mbx_params_pf - set initial values for pf mailbox
> > + * @hw: pointer to the HW structure
> > + *
> > + * Initializes the hw->mbx struct to correct values for pf mailbox
> > + */
> > +static void mucse_init_mbx_params_pf(struct mucse_hw *hw)
> > +{
> > +       struct mucse_mbx_info *mbx = &hw->mbx;
> > +
> > +       mbx->usec_delay = 100;
> > +       mbx->timeout = (4 * 1000 * 1000) / mbx->usec_delay;
> > +       mbx->stats.msgs_tx = 0;
> > +       mbx->stats.msgs_rx = 0;
> > +       mbx->stats.reqs = 0;
> > +       mbx->stats.acks = 0;
> > +       mbx->stats.rsts = 0;
> > +       mbx->size = MUCSE_VFMAILBOX_SIZE;
> > +
> > +       mutex_init(&mbx->lock);
> > +       mucse_mbx_reset(hw);
> > +}
> > +
> > +struct mucse_mbx_operations mucse_mbx_ops_generic = {
> > +       .init_params = mucse_init_mbx_params_pf,
> > +       .read = mucse_read_mbx_pf,
> > +       .write = mucse_write_mbx_pf,
> > +       .read_posted = mucse_read_posted_mbx,
> > +       .write_posted = mucse_write_posted_mbx,
> > +       .check_for_msg = mucse_check_for_msg_pf,
> > +       .check_for_ack = mucse_check_for_ack_pf,
> > +       .configure = mucse_mbx_configure_pf,
> > +};
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
> > new file mode 100644
> > index 000000000000..0b4183e53e61
> > --- /dev/null
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
> > @@ -0,0 +1,48 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/* Copyright(c) 2020 - 2025 Mucse Corporation. */
> > +
> > +#ifndef _RNPGBE_MBX_H
> > +#define _RNPGBE_MBX_H
> > +
> > +#include "rnpgbe.h"
> > +
> > +/* 14 words */
> > +#define MUCSE_VFMAILBOX_SIZE 14
> 
> Instead of the comment and the name, wouldn't it make more sense to
> incorporate "words" into the define? Something like:
> 
> #define MUCSE_VFMAILBOX_WORDS 14
> 
> 

Got it, I will improve it.

> > +/* ================ PF <--> VF mailbox ================ */
> > +#define SHARE_MEM_BYTES 64
> > +static inline u32 PF_VF_SHM(struct mucse_mbx_info *mbx, int vf)
> > +{
> > +       return mbx->pf_vf_shm_base + mbx->mbx_mem_size * vf;
> > +}
> > +
> > +#define PF2VF_COUNTER(mbx, vf) (PF_VF_SHM(mbx, vf) + 0)
> > +#define VF2PF_COUNTER(mbx, vf) (PF_VF_SHM(mbx, vf) + 4)
> > +#define PF_VF_SHM_DATA(mbx, vf) (PF_VF_SHM(mbx, vf) + 8)
> > +#define VF2PF_MBOX_VEC(mbx, vf) ((mbx)->vf2pf_mbox_vec_base + 4 * (vf))
> > +#define PF2VF_MBOX_CTRL(mbx, vf) ((mbx)->pf2vf_mbox_ctrl_base + 4 * (vf))
> > +#define PF_VF_MBOX_MASK_LO(mbx) ((mbx)->pf_vf_mbox_mask_lo)
> > +#define PF_VF_MBOX_MASK_HI(mbx) ((mbx)->pf_vf_mbox_mask_hi)
> > +/* ================ PF <--> FW mailbox ================ */
> > +#define FW_PF_SHM(mbx) ((mbx)->fw_pf_shm_base)
> > +#define FW2PF_COUNTER(mbx) (FW_PF_SHM(mbx) + 0)
> > +#define PF2FW_COUNTER(mbx) (FW_PF_SHM(mbx) + 4)
> > +#define FW_PF_SHM_DATA(mbx) (FW_PF_SHM(mbx) + 8)
> > +#define FW2PF_MBOX_VEC(mbx) ((mbx)->fw2pf_mbox_vec)
> > +#define PF2FW_MBOX_CTRL(mbx) ((mbx)->pf2fw_mbox_ctrl)
> > +#define FW_PF_MBOX_MASK(mbx) ((mbx)->fw_pf_mbox_mask)
> > +#define MBOX_CTRL_REQ BIT(0) /* WO */
> > +#define MBOX_PF_HOLD (BIT(3)) /* VF:RO, PF:WR */
> > +#define MBOX_IRQ_EN 0
> > +#define MBOX_IRQ_DISABLE 1
> > +#define mbx_rd32(hw, reg) m_rd_reg((hw)->hw_addr + (reg))
> > +#define mbx_wr32(hw, reg, val) m_wr_reg((hw)->hw_addr + (reg), (val))
> > +
> > +extern struct mucse_mbx_operations mucse_mbx_ops_generic;
> > +
> > +int mucse_read_mbx(struct mucse_hw *hw, u32 *msg, u16 size,
> > +                  enum MBX_ID mbx_id);
> > +int mucse_write_mbx(struct mucse_hw *hw, u32 *msg, u16 size,
> > +                   enum MBX_ID mbx_id);
> > +int mucse_check_for_msg(struct mucse_hw *hw, enum MBX_ID mbx_id);
> > +int mucse_check_for_ack(struct mucse_hw *hw, enum MBX_ID mbx_id);
> > +#endif /* _RNPGBE_MBX_H */
> > --
> > 2.25.1
> > 
> > 
> 
> 

