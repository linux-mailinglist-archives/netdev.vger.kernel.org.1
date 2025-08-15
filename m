Return-Path: <netdev+bounces-213931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1184B275EA
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 04:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998541CC830F
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 02:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078722C0F63;
	Fri, 15 Aug 2025 02:29:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34FC2BFC70;
	Fri, 15 Aug 2025 02:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224984; cv=none; b=QtXUY5zWIJD3IyD1IkfI7Z/zIEADCXSJRaof+haMfSXohWRIPo2h2wiSM1WCPOfwvmApO3JdZ9GkSx3lCC3peOeGagF7xMddt7QEokVTn/kJ9H9hMUAi8RDnve8mrb1APJtzze39dTJMUOJ8f+tjui815loho+DQHmdqmTOQS8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224984; c=relaxed/simple;
	bh=oTwHpvBn7rRBE05Lhy4Welan6z37EI/3shtPNKhD5P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kR1fLIImWn1jCUawNAeQNM3kTmYuY4Rhfn8RkHdQHj413uXyW60iYiiojBhOYgJfgbCwWe9cyF4RM+A5pT2fZrnlwdWfmyN3VAxN6Q5ZWfqCAxHHt+9BlvZJQSUVrlBMOFSYjTeuWg/mVUzYSwX1BWHFeB3rGKe2xjAWSk8TF4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz17t1755224914t57364eb7
X-QQ-Originating-IP: pDdm8tMuwOvreDyYR2nYI91BlNcEEzd/DnQrXhmpqE4=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 15 Aug 2025 10:28:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10377373078801611813
Date: Fri, 15 Aug 2025 10:28:31 +0800
From: Yibo Dong <dong100@mucse.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, lee@trager.us, gongfan1@huawei.com,
	lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/5] net: rnpgbe: Add register_netdev
Message-ID: <3D47BB8C932EF2F5+20250815022831.GA1137415@nic-Precision-5820-Tower>
References: <20250814073855.1060601-1-dong100@mucse.com>
 <20250814073855.1060601-6-dong100@mucse.com>
 <dd6ece66-ae4b-424a-aa09-872ac15e1549@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd6ece66-ae4b-424a-aa09-872ac15e1549@ti.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OY7kNFRo2XI4RDa6UkZ4bz7nvYikmRRRSO1EQTcA/42sfVRl0vmmstWs
	IF3pH1zV6/lJUr6h67z2jFA0LS6nNpcDx0DgW65+l/84VYejkG0pg8Y63AYeznlO2RvUCR4
	B31Pka5uYI69vKYqajU8VdeJW7/pPA5jeY+PFr2VtwWRqtoYzB8vr26awHuOhywoWqhYy4s
	ufnpWKM/j2EuP80wAJhHWby/4vi1GnDZ3Fj8b6JZ0zT+Sh0WFsVSrWtuzCE0PmSb0jiIhBm
	R+CwW+SgrKKhPutqJYn64C3Qf2DzOveZX8bL9Zg1uLDr5KoA8OLTA4FldE82YAJoS3Ndzu4
	PSVY7zyCK447gAsdbxnno4uhq/8lmvUu4I8d0m0wZ7Bg7sYPfH7hBQFHb24egP7KvjcjTlc
	NzltwwKB9qPZw70mIsAE5EVGNECkI75GJR+lLV80uzO4Dr8bQIQIQbNrcwAerW0U+ghl35m
	IDPxQtGVimBYIxBBuyyb2jksoVwzWjCnAeNL/Ol70V4U4k9gHFmACbglRAWcBnHcLMp17sk
	aYZkvxa/vDXg4LwF3DyvOXDkH5c2tkPe/z2omuFvrRq33pT37mYsDhPNH3rfx6cEv4rATxw
	2n785gRXJwxCs2aBwY5plmReGv9ukMzFj8RwkTr3eLw+gOaxxVWapCYmT3mxEaxWXZPcF7N
	mnPbwGXR65MvSH3RaSJVs4Y7b1cyexY0J8suGwvT889NkWFRcVJEKyNBj70XgpMJ5pvrye9
	gdFrcP9OPYgB7SX8z1NoOSY2bLy60PuUjEHQYHO4ZAobqgCxzTxA//mVWYdEVZd7A+CcHVU
	9I4LYqoLiIANyPcmOE27HMiCZCY0Ci4GPg1WYphOzmzJXP7EqaurYRG1nK8d3QLZ/4mUjan
	WR+w5YYOYarH3O83F4wb7fI05TrxhAorKX9hwpJZ9Qi7JiSO3KntJHArRHXyqHQ4/4iT3g1
	j3yhnl23D0rvZu7Ik5AAGYzMpnK9yCJwOe1x9yNMZ0bx44sJS0Wd8+ByzxB6FV+Ih/E6N3o
	OlABTQYOta9ieMTBCVms3ytUc/3IWP5r/lNIq7KBmOUwD9gXsyF9MN9eea+Aw=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

On Thu, Aug 14, 2025 at 05:44:51PM +0530, MD Danish Anwar wrote:
> On 14/08/25 1:08 pm, Dong Yibo wrote:
> > Initialize get mac from hw, register the netdev.
> > 
> > Signed-off-by: Dong Yibo <dong100@mucse.com>
> > ---
> >  drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    | 18 +++++
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 73 ++++++++++++++++++
> >  drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  1 +
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 75 +++++++++++++++++++
> >  4 files changed, 167 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > index 7ab1cbb432f6..7e51a8871b71 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > @@ -6,6 +6,7 @@
> >  
> >  #include <linux/types.h>
> >  #include <linux/mutex.h>
> > +#include <linux/netdevice.h>
> >  
> >  extern const struct rnpgbe_info rnpgbe_n500_info;
> >  extern const struct rnpgbe_info rnpgbe_n210_info;
> > @@ -82,6 +83,15 @@ struct mucse_mbx_info {
> >  	u32 fw2pf_mbox_vec;
> >  };
> >  
> > +struct mucse_hw_operations {
> > +	int (*reset_hw)(struct mucse_hw *hw);
> > +	void (*driver_status)(struct mucse_hw *hw, bool enable, int mode);
> > +};
> > +
> > +enum {
> > +	mucse_driver_insmod,
> > +};
> > +
> >  struct mucse_hw {
> >  	u8 pfvfnum;
> >  	void __iomem *hw_addr;
> > @@ -91,12 +101,17 @@ struct mucse_hw {
> >  	u32 axi_mhz;
> >  	u32 bd_uid;
> >  	enum rnpgbe_hw_type hw_type;
> > +	const struct mucse_hw_operations *ops;
> >  	struct mucse_dma_info dma;
> >  	struct mucse_eth_info eth;
> >  	struct mucse_mac_info mac;
> >  	struct mucse_mbx_info mbx;
> > +	u32 flags;
> > +#define M_FLAGS_INIT_MAC_ADDRESS BIT(0)
> >  	u32 driver_version;
> >  	u16 usecstocount;
> > +	int lane;
> > +	u8 perm_addr[ETH_ALEN];
> >  };
> >  
> >  struct mucse {
> > @@ -117,4 +132,7 @@ struct rnpgbe_info {
> >  #define PCI_DEVICE_ID_N500_DUAL_PORT 0x8318
> >  #define PCI_DEVICE_ID_N210 0x8208
> >  #define PCI_DEVICE_ID_N210L 0x820a
> > +
> > +#define dma_wr32(dma, reg, val) writel((val), (dma)->dma_base_addr + (reg))
> > +#define dma_rd32(dma, reg) readl((dma)->dma_base_addr + (reg))
> 
> These macros could collide with other definitions. Consider prefixing
> them with the driver name (rnpgbe_dma_wr32).
> 
> I don't see these macros getting used anywhere in this series. They
> should be introduced when they are used.
> 

dma_wr32 is used in rnpgbe_reset_hw_ops (rnpgbe_chip.c). I rename it to
rnpgbe_dma_wr32.
dma_rd32 is not used, I will remove it.


