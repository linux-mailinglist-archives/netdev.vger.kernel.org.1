Return-Path: <netdev+bounces-208820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFBCB0D417
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 10:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBB5318947E8
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 08:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA712BE045;
	Tue, 22 Jul 2025 08:04:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C78E28B3FA
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 08:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753171476; cv=none; b=gLlNIxT4+1jFARZ4osyPrZjHPIhlQg06T1c5A/bLEzbB++u8WHhuXIL7lW8iWZ5YNDmN9ao28lHMrkVvl2jkQbHAksNcsPRP5smHOxpQckHz6h6/ytCXow3hex3UbsVP/30Dtgm9G5gU8RYW4mes5M6sQRA3DTfsIXcJBo7r4l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753171476; c=relaxed/simple;
	bh=H6to3FL9Ff6ob2kDnglLQP1rzBtoBx4hDMuiFF8r3RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEcz/y78UWG7o1CXhtqO4QCTpN2QRsB695JZ07bD7z53JFHPRgkDpdyyw87vO7tXCctvlFToCT30RHjfT3MPbVgPLUJcpgQHUFGzekuKRNB1a1gYqUr3IZWBgQQ+715z9yTlKnrclazq+FrA7Kr/C2GJTeKn0D2rm5wad3uYQQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz6t1753171463t370f633c
X-QQ-Originating-IP: J38gCE92tjZN+DgYxRcXEF4XxVgmrbU9GcVwjqMOjiI=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Jul 2025 16:04:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2168941637106180486
Date: Tue, 22 Jul 2025 16:04:20 +0800
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
Subject: Re: [PATCH v2 04/15] net: rnpgbe: Add get_capability mbx_fw ops
 support
Message-ID: <906F5B328E0763D4+20250722080420.GF99399@nic-Precision-5820-Tower>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-5-dong100@mucse.com>
 <c3760a7f-3aea-4ea6-a2f8-f9326d73afc5@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3760a7f-3aea-4ea6-a2f8-f9326d73afc5@amd.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Mz+RlbbNhZMPCiFU17DNGa9fHCxPKBQ9xp2AO2JkwTIuw4p8aWFePPsI
	0bjyjCsWQYjHmZS+1G9iARLsuxQWbXRNZMeRNZ5s7bNp+3qjWpRLbxKhcZVN+MGlxnCZf/z
	eNfcHeZyQYcMNtM07n5XWGYn/rZB3309bpx50OKvHygWvrkQ+hFn9EbZakAEeZKZRV8pLk6
	d+LI2KsJZBUvGvN8rcvbJEkjrX6jn4JBq+yzK33tFozIcvwUhGW3GHWJrk992Y5Bo/p6HbE
	9+UQna8w0BqTyRMhvvQIZVARO0EAcqfwuWbHWIH02nDDNPZ4T0grUX+HwV6c6huHFeMN7bw
	cYtYF6cjehu59jQHeJsBrIEzfZOLKFzUGF4XnHOcvZt/qvARC6TL5RulEYkxXDFejeD/sn9
	oukwXvHy3IQ5hiGuieGJCZK2JJ75Ea+sPgCbVue1r4++O6Z92QlaKGeSFMl3lOanO9/EIiN
	q5MbcfQm7Z5s2zBmEurpXfZTG55ketFs0Ee/sB+SKl1g+2ffkd3Weklhx0VQ2PpxeKR2UV3
	q+HCo1WpyD9rxOjpQoTpDxxUp5Rpcde+61QRHBRGigc2HLE621JOvRBib+vl/o3a09rULg8
	xYp+wuok5ueDp5geDg8yZu1LNWQABigXajUrHcXjDVSTgpRZWaf1g1STHsnAVE0oklQn7e9
	OA5r+5FuL5R5eBIqe63Frm4V8eS74relftd3ljMHl+/wr6zZUV35TmN+f4Fru0rsf8OEEHl
	H3RjfCr3ploIqWCoruLDPjRx0fWvZiOK1f1kUHkJBuyPhkNgs5HiQ/LvQcGjyMsr6QK+ckQ
	gMUZlu3owZE8T+mI84iSJY/rArxJPn0JXN4Y3JfmGIg1QAnyPOrv09Qu01Kbpre4nMtHfJq
	BN/lm2RVI1zvjBOPzz/hkqfhq296Re2Sr0RqyrGyMRJCaqvhnvte0k0XOddHgu2Aul33HKH
	AJpRqrNOFyN5n6MLRbYdWG9DhxnhYg+QTqNRORDRBLe4MMgGvyCo0uDN5
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

On Mon, Jul 21, 2025 at 03:08:22PM -0700, Brett Creeley wrote:
> On 7/21/2025 4:32 AM, Dong Yibo wrote:
> > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > 
> > 
> > Initialize get hw capability from mbx_fw ops.
> > 
> > Signed-off-by: Dong Yibo <dong100@mucse.com>
> > ---
> >   drivers/net/ethernet/mucse/rnpgbe/Makefile    |   3 +-
> >   drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |   8 +
> >   .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |   8 +
> >   .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 140 +++++
> >   .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h | 568 ++++++++++++++++++
> >   5 files changed, 726 insertions(+), 1 deletion(-)
> >   create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> >   create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
> > 
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/Makefile b/drivers/net/ethernet/mucse/rnpgbe/Makefile
> > index 41177103b50c..fd455cb111a9 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/Makefile
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/Makefile
> > @@ -7,4 +7,5 @@
> >   obj-$(CONFIG_MGBE) += rnpgbe.o
> >   rnpgbe-objs := rnpgbe_main.o \
> >                 rnpgbe_chip.o \
> > -              rnpgbe_mbx.o
> > +              rnpgbe_mbx.o \
> > +              rnpgbe_mbx_fw.o
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > index 46e2bb2fe71e..4514bc1223c1 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > @@ -154,6 +154,14 @@ struct mucse_hw {
> >          u16 vendor_id;
> >          u16 subsystem_device_id;
> >          u16 subsystem_vendor_id;
> > +       u32 wol;
> > +       u32 wol_en;
> > +       u32 fw_version;
> > +       u32 axi_mhz;
> > +       u32 bd_uid;
> > +       int ncsi_en;
> > +       int force_en;
> > +       int force_cap;
> >          int max_vfs;
> >          int max_vfs_noari;
> >          enum rnpgbe_hw_type hw_type;
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> > index 1e8360cae560..aeb560145c47 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> > @@ -9,6 +9,7 @@
> >   #include <linux/etherdevice.h>
> > 
> >   #include "rnpgbe.h"
> > +#include "rnpgbe_mbx_fw.h"
> > 
> >   char rnpgbe_driver_name[] = "rnpgbe";
> >   static const struct rnpgbe_info *rnpgbe_info_tbl[] = {
> > @@ -116,6 +117,13 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
> >          ii->get_invariants(hw);
> >          hw->mbx.ops.init_params(hw);
> > 
> > +       err = mucse_mbx_get_capability(hw);
> > +       if (err) {
> > +               dev_err(&pdev->dev,
> > +                       "mucse_mbx_get_capability failed!\n");
> > +               goto err_free_net;
> > +       }
> 
> Do you want to know what the "err" value was? Should that be included in the
> error message?
> 

Yes, i waant it, I should add err in the dev_err. Thank you for your suggestion.

> > +
> >          return 0;
> > 
> >   err_free_net:
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> > new file mode 100644
> > index 000000000000..1674229fcd43
> > --- /dev/null
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> > @@ -0,0 +1,140 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright(c) 2020 - 2025 Mucse Corporation. */
> > +
> > +#include <linux/pci.h>
> > +
> > +#include "rnpgbe_mbx_fw.h"
> > +
> > +/**
> > + * mucse_fw_send_cmd_wait - Send cmd req and wait for response
> > + * @hw: Pointer to the HW structure
> > + * @req: Pointer to the cmd req structure
> > + * @reply: Pointer to the fw reply structure
> > + *
> > + * mucse_fw_send_cmd_wait sends req to pf-fw mailbox and wait
> > + * reply from fw.
> > + *
> > + * @return: 0 on success, negative on failure
> > + **/
> > +static int mucse_fw_send_cmd_wait(struct mucse_hw *hw,
> > +                                 struct mbx_fw_cmd_req *req,
> > +                                 struct mbx_fw_cmd_reply *reply)
> > +{
> > +       int len = le32_to_cpu(req->datalen) + MBX_REQ_HDR_LEN;
> > +       int retry_cnt = 3;
> > +       int err;
> > +
> > +       err = mutex_lock_interruptible(&hw->mbx.lock);
> > +       if (err)
> > +               return err;
> > +
> > +       err = hw->mbx.ops.write_posted(hw, (u32 *)req,
> > +                                      L_WD(len),
> > +                                      MBX_FW);
> > +       if (err) {
> > +               mutex_unlock(&hw->mbx.lock);
> > +               return err;
> > +       }
> > +
> > +retry:
> > +       retry_cnt--;
> > +       if (retry_cnt < 0)
> > +               return -EIO;
> 
> You aren't releasing the lock here, was that intentional?  Also, would
> -ETIMEDOUT make more sense?
> 

Yes, I missed releasing the lock. I will fix it.
-ETIMEDOUT is more sense, I will improve it.

> > +
> > +       err = hw->mbx.ops.read_posted(hw, (u32 *)reply,
> > +                                     L_WD(sizeof(*reply)),
> > +                                     MBX_FW);
> > +       if (err) {
> > +               mutex_unlock(&hw->mbx.lock);
> > +               return err;
> > +       }
> > +
> > +       if (reply->opcode != req->opcode)
> > +               goto retry;
> 
> It seems like this block could be achieved with some sort of loop condition
> instead of a goto retry. Something like:
> 
> do {
> } while (--retry_cnt >= 0 && reply->opcode != req->opcode);
> 
> mutex_unlock();
> 
> if (retry_cnt < 0)
> 	return -ETIMEDOUT;
> 
> if (reply->error_code)
> 	return -EIO;
> 
> return 0;

Got it, I will improve it.

> > +
> > +       mutex_unlock(&hw->mbx.lock);
> > +
> > +       if (reply->error_code)
> > +               return -EIO;
> 
> Do you want to lose the "error_code" here?
> 

reply->erro_code is not linux error code.
It is used only between fw and driver:
0     -- no err
not 0 -- err
So, I turn it into a linux/POSIX error here.

> > +
> > +       return 0;
> > +}
> > +
> > +/**
> > + * mucse_fw_get_capability - Get hw abilities from fw
> > + * @hw: Pointer to the HW structure
> > + * @abil: Pointer to the hw_abilities structure
> > + *
> > + * mucse_fw_get_capability tries to get hw abilities from
> > + * hw.
> > + *
> > + * @return: 0 on success, negative on failure
> > + **/
> > +static int mucse_fw_get_capability(struct mucse_hw *hw,
> > +                                  struct hw_abilities *abil)
> > +{
> > +       struct mbx_fw_cmd_reply reply;
> > +       struct mbx_fw_cmd_req req;
> > +       int err = 0;
> 
> Nit, you don't need to initialize this because it will always be set when
> calling mucse_fw_send_cmd_wait().
> 

Got it, I will improve it.

> > +
> > +       memset(&req, 0, sizeof(req));
> > +       memset(&reply, 0, sizeof(reply));
> > +       build_phy_abalities_req(&req, &req);
> > +       err = mucse_fw_send_cmd_wait(hw, &req, &reply);
> > +       if (err == 0)
> 
> Nit, but typically just "if (!err)" is used.
> 

Got it, I will improve it.

> > +               memcpy(abil, &reply.hw_abilities, sizeof(*abil));
> > +
> > +       return err;
> > +}
> > +
> > +/**
> > + * mucse_mbx_get_capability - Get hw abilities from fw
> > + * @hw: Pointer to the HW structure
> > + *
> > + * mucse_mbx_get_capability tries to some capabities from
> > + * hw. Many retrys will do if it is failed.
> > + *
> > + * @return: 0 on success, negative on failure
> > + **/
> > +int mucse_mbx_get_capability(struct mucse_hw *hw)
> > +{
> > +       struct hw_abilities ability;
> > +       int try_cnt = 3;
> > +       int err = 0;
> 
> Don't initialize err as it's always set before being used. Please look
> through all your patches and apply this same comment/thought process before
> reposting.
> 

Got it, I will check it for the reset of patches in the next version.

> > +
> > +       memset(&ability, 0, sizeof(ability));
> > +
> > +       while (try_cnt--) {
> > +               err = mucse_fw_get_capability(hw, &ability);
> > +               if (err == 0) {
> 
> Typically the following is done to reduce indentation.
> 
> while (condition) {
> 	err = func();
>         if (err)
> 		continue;
> 
> 	/* handle non-err case */
>         return 0;
> }
> 
> return err;

Got it, I will fix it.

> > +                       u16 nic_mode = le16_to_cpu(ability.nic_mode);
> > +                       u32 wol = le32_to_cpu(ability.wol_status);
> > +
> > +                       hw->ncsi_en = (nic_mode & 0x4) ? 1 : 0;
> > +                       hw->pfvfnum = le16_to_cpu(ability.pfnum);
> > +                       hw->fw_version = le32_to_cpu(ability.fw_version);
> > +                       hw->axi_mhz = le32_to_cpu(ability.axi_mhz);
> > +                       hw->bd_uid = le32_to_cpu(ability.bd_uid);
> > +
> > +                       if (hw->fw_version >= 0x0001012C) {
> > +                               /* this version can get wol_en from hw */
> > +                               hw->wol = wol & 0xff;
> > +                               hw->wol_en = wol & 0x100;
> > +                       } else {
> > +                               /* other version only pf0 or ncsi can wol */
> > +                               hw->wol = wol & 0xff;
> > +                               if (hw->ncsi_en || !hw->pfvfnum)
> > +                                       hw->wol_en = 1;
> > +                       }
> > +                       /* 0.1.5.0 can get force status from fw */
> > +                       if (hw->fw_version >= 0x00010500) {
> > +                               ability_update_host_endian(&ability);
> > +                               hw->force_en = ability.e_host.force_down_en;
> > +                               hw->force_cap = 1;
> > +                       }
> > +                       return 0;
> > +               }
> > +       }
> > +
> > +       return err;
> > +}
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
> > new file mode 100644
> > index 000000000000..a24c5d4e0075
> > --- /dev/null
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
> > @@ -0,0 +1,568 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/* Copyright(c) 2020 - 2025 Mucse Corporation. */
> > +
> > +#ifndef _RNPGBE_MBX_FW_H
> > +#define _RNPGBE_MBX_FW_H
> > +
> > +#include <linux/types.h>
> > +#include <linux/errno.h>
> > +#include <linux/wait.h>
> > +
> > +#include "rnpgbe.h"
> > +
> > +#define MBX_REQ_HDR_LEN 24
> > +#define L_WD(x) ((x) / 4)
> > +
> > +struct mbx_fw_cmd_reply;
> > +typedef void (*cookie_cb)(struct mbx_fw_cmd_reply *reply, void *priv);
> > +
> > +struct mbx_req_cookie {
> > +       int magic;
> > +#define COOKIE_MAGIC 0xCE
> > +       cookie_cb cb;
> > +       int timeout_jiffes;
> > +       int errcode;
> > +       wait_queue_head_t wait;
> > +       int done;
> > +       int priv_len;
> > +       char priv[];
> > +};
> > +
> > +enum MUCSE_FW_CMD {
> > +       GET_VERSION = 0x0001,
> > +       READ_REG = 0xFF03,
> > +       WRITE_REG = 0xFF04,
> > +       MODIFY_REG = 0xFF07,
> > +       IFUP_DOWN = 0x0800,
> > +       SEND_TO_PF = 0x0801,
> > +       SEND_TO_VF = 0x0802,
> > +       DRIVER_INSMOD = 0x0803,
> > +       SYSTEM_SUSPUSE = 0x0804,
> > +       SYSTEM_FORCE = 0x0805,
> > +       GET_PHY_ABALITY = 0x0601,
> > +       GET_MAC_ADDRES = 0x0602,
> > +       RESET_PHY = 0x0603,
> > +       LED_SET = 0x0604,
> > +       GET_LINK_STATUS = 0x0607,
> > +       LINK_STATUS_EVENT = 0x0608,
> > +       SET_LANE_FUN = 0x0609,
> > +       GET_LANE_STATUS = 0x0610,
> > +       SFP_SPEED_CHANGED_EVENT = 0x0611,
> > +       SET_EVENT_MASK = 0x0613,
> > +       SET_LOOPBACK_MODE = 0x0618,
> > +       SET_PHY_REG = 0x0628,
> > +       GET_PHY_REG = 0x0629,
> > +       PHY_LINK_SET = 0x0630,
> > +       GET_PHY_STATISTICS = 0x0631,
> > +       PHY_PAUSE_SET = 0x0632,
> > +       PHY_PAUSE_GET = 0x0633,
> > +       PHY_EEE_SET = 0x0636,
> > +       PHY_EEE_GET = 0x0637,
> > +       SFP_MODULE_READ = 0x0900,
> > +       SFP_MODULE_WRITE = 0x0901,
> > +       FW_UPDATE = 0x0700,
> > +       FW_MAINTAIN = 0x0701,
> > +       FW_UPDATE_GBE = 0x0702,
> > +       WOL_EN = 0x0910,
> > +       GET_DUMP = 0x0a00,
> > +       SET_DUMP = 0x0a10,
> > +       GET_TEMP = 0x0a11,
> > +       SET_WOL = 0x0a12,
> > +       SET_TEST_MODE = 0x0a13,
> > +       SHOW_TX_STAMP = 0x0a14,
> > +       LLDP_TX_CTRL = 0x0a15,
> > +};
> > +
> > +struct hw_abilities {
> > +       u8 link_stat;
> > +       u8 lane_mask;
> > +       __le32 speed;
> > +       __le16 phy_type;
> > +       __le16 nic_mode;
> > +       __le16 pfnum;
> > +       __le32 fw_version;
> > +       __le32 axi_mhz;
> > +       union {
> > +               u8 port_id[4];
> > +               __le32 port_ids;
> > +       };
> > +       __le32 bd_uid;
> > +       __le32 phy_id;
> > +       __le32 wol_status;
> > +       union {
> > +               __le32 ext_ability;
> > +               struct {
> > +                       __le32 valid : 1; /* 0 */
> > +                       __le32 wol_en : 1; /* 1 */
> > +                       __le32 pci_preset_runtime_en : 1; /* 2 */
> > +                       __le32 smbus_en : 1; /* 3 */
> > +                       __le32 ncsi_en : 1; /* 4 */
> > +                       __le32 rpu_en : 1; /* 5 */
> > +                       __le32 v2 : 1; /* 6 */
> > +                       __le32 pxe_en : 1; /* 7 */
> > +                       __le32 mctp_en : 1; /* 8 */
> > +                       __le32 yt8614 : 1; /* 9 */
> > +                       __le32 pci_ext_reset : 1; /* 10 */
> > +                       __le32 rpu_availble : 1; /* 11 */
> > +                       __le32 fw_lldp_ability : 1; /* 12 */
> > +                       __le32 lldp_enabled : 1; /* 13 */
> > +                       __le32 only_1g : 1; /* 14 */
> > +                       __le32 force_down_en: 1; /* 15 */
> > +               } e;
> > +               struct {
> > +                       u32 valid : 1; /* 0 */
> > +                       u32 wol_en : 1; /* 1 */
> > +                       u32 pci_preset_runtime_en : 1; /* 2 */
> > +                       u32 smbus_en : 1; /* 3 */
> > +                       u32 ncsi_en : 1; /* 4 */
> > +                       u32 rpu_en : 1; /* 5 */
> > +                       u32 v2 : 1; /* 6 */
> > +                       u32 pxe_en : 1; /* 7 */
> > +                       u32 mctp_en : 1; /* 8 */
> > +                       u32 yt8614 : 1; /* 9 */
> > +                       u32 pci_ext_reset : 1; /* 10 */
> > +                       u32 rpu_availble : 1; /* 11 */
> > +                       u32 fw_lldp_ability : 1; /* 12 */
> > +                       u32 lldp_enabled : 1; /* 13 */
> > +                       u32 only_1g : 1; /* 14 */
> > +                       u32 force_down_en: 1; /* 15 */
> > +               } e_host;
> 
> Do the /* <bit_#> */ comments provide any value here?
> 

Got it. I should remove no value comments like this.

> > +       };
> > +} __packed;
> > +
> > +static inline void ability_update_host_endian(struct hw_abilities *abi)
> > +{
> > +       u32 host_val = le32_to_cpu(abi->ext_ability);
> > +
> > +       abi->e_host = *(typeof(abi->e_host) *)&host_val;
> > +}
> > +
> > +struct phy_pause_data {
> > +       u32 pause_mode;
> > +};
> > +
> > +struct lane_stat_data {
> > +       u8 nr_lane;
> > +       u8 pci_gen : 4;
> > +       u8 pci_lanes : 4;
> > +       u8 pma_type;
> > +       u8 phy_type;
> > +       __le16 linkup : 1;
> > +       __le16 duplex : 1;
> > +       __le16 autoneg : 1;
> > +       __le16 fec : 1;
> > +       __le16 an : 1;
> > +       __le16 link_traing : 1;
> > +       __le16 media_availble : 1;
> > +       __le16 is_sgmii : 1;
> > +       __le16 link_fault : 4;
> > +#define LINK_LINK_FAULT BIT(0)
> > +#define LINK_TX_FAULT BIT(1)
> > +#define LINK_RX_FAULT BIT(2)
> > +#define LINK_REMOTE_FAULT BIT(3)
> > +       __le16 is_backplane : 1;
> > +       __le16 tp_mdx : 2;
> > +       union {
> > +               u8 phy_addr;
> > +               struct {
> > +                       u8 mod_abs : 1;
> > +                       u8 fault : 1;
> > +                       u8 tx_dis : 1;
> > +                       u8 los : 1;
> > +               } sfp;
> > +       };
> > +       u8 sfp_connector;
> > +       __le32 speed;
> > +       __le32 si_main;
> > +       __le32 si_pre;
> > +       __le32 si_post;
> > +       __le32 si_tx_boost;
> > +       __le32 supported_link;
> > +       __le32 phy_id;
> > +       __le32 advertised_link;
> > +} __packed;
> > +
> > +struct yt_phy_statistics {
> > +       __le32 pkg_ib_valid; /* rx crc good and length 64-1518 */
> > +       __le32 pkg_ib_os_good; /* rx crc good and length >1518 */
> > +       __le32 pkg_ib_us_good; /* rx crc good and length <64 */
> > +       __le16 pkg_ib_err; /* rx crc wrong and length 64-1518 */
> > +       __le16 pkg_ib_os_bad; /* rx crc wrong and length >1518 */
> > +       __le16 pkg_ib_frag; /* rx crc wrong and length <64 */
> > +       __le16 pkg_ib_nosfd; /* rx sfd missed */
> > +       __le32 pkg_ob_valid; /* tx crc good and length 64-1518 */
> > +       __le32 pkg_ob_os_good; /* tx crc good and length >1518 */
> > +       __le32 pkg_ob_us_good; /* tx crc good and length <64 */
> > +       __le16 pkg_ob_err; /* tx crc wrong and length 64-1518 */
> > +       __le16 pkg_ob_os_bad; /* tx crc wrong and length >1518 */
> > +       __le16 pkg_ob_frag; /* tx crc wrong and length <64 */
> > +       __le16 pkg_ob_nosfd; /* tx sfd missed */
> > +} __packed;
> > +
> > +struct phy_statistics {
> > +       union {
> > +               struct yt_phy_statistics yt;
> > +       };
> > +} __packed;
> > +
> > +struct port_stat {
> > +       u8 phyid;
> > +       u8 duplex : 1;
> > +       u8 autoneg : 1;
> > +       u8 fec : 1;
> > +       __le16 speed;
> > +       union {
> > +               __le16 stat;
> > +               struct {
> > +                       __le16 pause : 4;
> > +                       __le16 local_eee : 3;
> > +                       __le16 partner_eee : 3;
> > +                       __le16 tp_mdx : 2;
> > +                       __le16 lldp_status : 1;
> > +                       __le16 revs : 3;
> > +               } v;
> > +               struct {
> > +                       u16 pause : 4;
> > +                       u16 local_eee : 3;
> > +                       u16 partner_eee : 3;
> > +                       u16 tp_mdx : 2;
> > +                       u16 lldp_status : 1;
> > +                       u16 revs : 3;
> > +               } v_host;
> > +       };
> > +} __packed;
> > +
> > +#define FLAGS_DD BIT(0) /* driver clear 0, FW must set 1 */
> > +/* driver clear 0, FW must set only if it reporting an error */
> > +#define FLAGS_ERR BIT(2)
> > +
> > +/* req is little endian. bigendian should be conserened */
> 
> Some typos here. Please fix.
> 

Got it, I will fix them.

> > +struct mbx_fw_cmd_req {
> > +       __le16 flags; /* 0-1 */
> > +       __le16 opcode; /* 2-3 enum GENERIC_CMD */
> > +       __le16 datalen; /* 4-5 */
> > +       __le16 ret_value; /* 6-7 */
> > +       union {
> > +               struct {
> > +                       __le32 cookie_lo; /* 8-11 */
> > +                       __le32 cookie_hi; /* 12-15 */
> > +               };
> > +
> > +               void *cookie;
> > +       };
> > +       __le32 reply_lo; /* 16-19 5dw */
> > +       __le32 reply_hi; /* 20-23 */
> > +       union {
> > +               u8 data[32];
> > +               struct {
> > +                       __le32 addr;
> > +                       __le32 bytes;
> > +               } r_reg;
> > +
> > +               struct {
> > +                       __le32 addr;
> > +                       __le32 bytes;
> > +                       __le32 data[4];
> > +               } w_reg;
> > +
> > +               struct {
> > +                       __le32 lanes;
> > +               } ptp;
> > +
> > +               struct {
> > +                       __le32 lane;
> > +                       __le32 up;
> > +               } ifup;
> > +
> > +               struct {
> > +                       __le32 sec;
> > +                       __le32 nanosec;
> > +
> > +               } tstamps;
> > +
> > +               struct {
> > +                       __le32 lane;
> > +                       __le32 status;
> > +               } ifinsmod;
> > +
> > +               struct {
> > +                       __le32 lane;
> > +                       __le32 status;
> > +               } ifforce;
> > +
> > +               struct {
> > +                       __le32 lane;
> > +                       __le32 status;
> > +               } ifsuspuse;
> > +
> > +               struct {
> > +                       __le32 nr_lane;
> > +               } get_lane_st;
> > +
> > +               struct {
> > +                       __le32 nr_lane;
> > +                       __le32 func;
> > +#define LANE_FUN_AN 0
> > +#define LANE_FUN_LINK_TRAING 1
> > +#define LANE_FUN_FEC 2
> > +#define LANE_FUN_SI 3
> > +#define LANE_FUN_SFP_TX_DISABLE 4
> > +#define LANE_FUN_PCI_LANE 5
> > +#define LANE_FUN_PRBS 6
> > +#define LANE_FUN_SPEED_CHANGE 7
> > +                       __le32 value0;
> > +                       __le32 value1;
> > +                       __le32 value2;
> > +                       __le32 value3;
> > +               } set_lane_fun;
> > +
> > +               struct {
> > +                       __le32 flag;
> > +                       __le32 nr_lane;
> > +               } set_dump;
> > +
> > +               struct {
> > +                       __le32 lane;
> > +                       __le32 enable;
> > +               } wol;
> > +
> > +               struct {
> > +                       __le32 lane;
> > +                       __le32 mode;
> > +               } gephy_test;
> > +
> > +               struct {
> > +                       __le32 lane;
> > +                       __le32 op;
> > +                       __le32 enable;
> > +                       __le32 inteval;
> > +               } lldp_tx;
> > +
> > +               struct {
> > +                       __le32 bytes;
> > +                       __le32 nr_lane;
> > +                       __le32 bin_offset;
> > +                       __le32 no_use;
> > +               } get_dump;
> > +
> > +               struct {
> > +                       __le32 nr_lane;
> > +                       __le32 value;
> > +#define LED_IDENTIFY_INACTIVE 0
> > +#define LED_IDENTIFY_ACTIVE 1
> > +#define LED_IDENTIFY_ON 2
> > +#define LED_IDENTIFY_OFF 3
> > +               } led_set;
> > +
> > +               struct {
> > +                       __le32 addr;
> > +                       __le32 data;
> > +                       __le32 mask;
> > +               } modify_reg;
> > +
> > +               struct {
> > +                       __le32 adv_speed_mask;
> > +                       __le32 autoneg;
> > +                       __le32 speed;
> > +                       __le32 duplex;
> > +                       __le32 nr_lane;
> > +                       __le32 tp_mdix_ctrl;
> > +               } phy_link_set;
> > +
> > +               struct {
> > +                       __le32 pause_mode;
> > +                       __le32 nr_lane;
> > +               } phy_pause_set;
> > +
> > +               struct {
> > +                       __le32 pause_mode;
> > +                       __le32 nr_lane;
> > +               } phy_pause_get;
> > +
> > +               struct {
> > +                       __le32 local_eee;
> > +                       __le32 tx_lpi_timer;
> > +                       __le32 nr_lane;
> > +               } phy_eee_set;
> > +
> > +               struct {
> > +                       __le32 nr_lane;
> > +                       __le32 sfp_adr; /* 0xa0 or 0xa2 */
> > +                       __le32 reg;
> > +                       __le32 cnt;
> > +               } sfp_read;
> > +
> > +               struct {
> > +                       __le32 nr_lane;
> > +                       __le32 sfp_adr; /* 0xa0 or 0xa2 */
> > +                       __le32 reg;
> > +                       __le32 val;
> > +               } sfp_write;
> > +
> > +               struct {
> > +                       __le32 nr_lane; /* 0-3 */
> > +               } get_linkstat;
> > +
> > +               struct {
> > +                       __le16 changed_lanes;
> > +                       __le16 lane_status;
> > +                       __le32 port_st_magic;
> > +#define SPEED_VALID_MAGIC 0xa4a6a8a9
> > +                       struct port_stat st[4];
> > +               } link_stat; /* FW->RC */
> > +
> > +               struct {
> > +                       __le16 enable_stat;
> > +                       __le16 event_mask;
> > +               } stat_event_mask;
> > +
> > +               struct {
> > +                       __le32 cmd;
> > +                       __le32 arg0;
> > +                       __le32 req_bytes;
> > +                       __le32 reply_bytes;
> > +                       __le32 ddr_lo;
> > +                       __le32 ddr_hi;
> > +               } maintain;
> > +
> > +               struct { /* set phy register */
> > +                       u8 phy_interface;
> > +                       union {
> > +                               u8 page_num;
> > +                               u8 external_phy_addr;
> > +                       };
> > +                       __le32 phy_reg_addr;
> > +                       __le32 phy_w_data;
> > +                       __le32 reg_addr;
> > +                       __le32 w_data;
> > +                       /* 1 = ignore page_num, use last QSFP */
> > +                       u8 recall_qsfp_page : 1;
> > +                       /* page value */
> > +                       /* 0 = use page_num for QSFP */
> > +                       u8 nr_lane;
> > +               } set_phy_reg;
> > +
> > +               struct {
> > +                       __le32 lane_mask;
> > +                       __le32 pfvf_num;
> > +               } get_mac_addr;
> > +
> > +               struct {
> > +                       u8 phy_interface;
> > +                       union {
> > +                               u8 page_num;
> > +                               u8 external_phy_addr;
> > +                       };
> > +                       __le32 phy_reg_addr;
> > +                       u8 nr_lane;
> > +               } get_phy_reg;
> > +
> > +               struct {
> > +                       __le32 nr_lane;
> > +               } phy_statistics;
> > +
> > +               struct {
> > +                       u8 paration;
> > +                       __le32 bytes;
> > +                       __le32 bin_phy_lo;
> > +                       __le32 bin_phy_hi;
> > +               } fw_update;
> > +       };
> > +} __packed;
> > +
> > +#define EEE_1000BT BIT(2)
> > +#define EEE_100BT BIT(1)
> > +
> > +struct rnpgbe_eee_cap {
> > +       __le32 local_capability;
> > +       __le32 local_eee;
> > +       __le32 partner_eee;
> > +};
> > +
> > +/* firmware -> driver */
> > +struct mbx_fw_cmd_reply {
> > +       /* fw must set: DD, CMP, Error(if error), copy value */
> > +       __le16 flags;
> > +       /* from command: LB,RD,VFC,BUF,SI,EI,FE */
> > +       __le16 opcode; /* 2-3: copy from req */
> > +       __le16 error_code; /* 4-5: 0 if no error */
> > +       __le16 datalen; /* 6-7: */
> > +       union {
> > +               struct {
> > +                       __le32 cookie_lo; /* 8-11: */
> > +                       __le32 cookie_hi; /* 12-15: */
> > +               };
> > +               void *cookie;
> > +       };
> > +       /* ===== data ==== [16-64] */
> > +       union {
> > +               u8 data[40];
> > +
> > +               struct version {
> > +                       __le32 major;
> > +                       __le32 sub;
> > +                       __le32 modify;
> > +               } version;
> > +
> > +               struct {
> > +                       __le32 value[4];
> > +               } r_reg;
> > +
> > +               struct {
> > +                       __le32 new_value;
> > +               } modify_reg;
> > +
> > +               struct get_temp {
> > +                       __le32 temp;
> > +                       __le32 volatage;
> > +               } get_temp;
> > +
> > +               struct {
> > +#define MBX_SFP_READ_MAX_CNT 32
> > +                       u8 value[MBX_SFP_READ_MAX_CNT];
> > +               } sfp_read;
> > +
> > +               struct mac_addr {
> > +                       __le32 lanes;
> > +                       struct _addr {
> > +                               /*
> > +                                * for macaddr:01:02:03:04:05:06
> > +                                * mac-hi=0x01020304 mac-lo=0x05060000
> > +                                */
> > +                               u8 mac[8];
> > +                       } addrs[4];
> > +               } mac_addr;
> > +
> > +               struct get_dump_reply {
> > +                       __le32 flags;
> > +                       __le32 version;
> > +                       __le32 bytes;
> > +                       __le32 data[4];
> > +               } get_dump;
> > +
> > +               struct get_lldp_reply {
> > +                       __le32 value;
> > +                       __le32 inteval;
> > +               } get_lldp;
> > +
> > +               struct rnpgbe_eee_cap phy_eee_abilities;
> > +               struct lane_stat_data lanestat;
> > +               struct hw_abilities hw_abilities;
> > +               struct phy_statistics phy_statistics;
> > +       };
> > +} __packed;
> > +
> > +static inline void build_phy_abalities_req(struct mbx_fw_cmd_req *req,
> > +                                          void *cookie)
> > +{
> > +       req->flags = 0;
> > +       req->opcode = cpu_to_le32(GET_PHY_ABALITY);
> > +       req->datalen = 0;
> > +       req->reply_lo = 0;
> > +       req->reply_hi = 0;
> > +       req->cookie = cookie;
> > +}
> > +
> > +int mucse_mbx_get_capability(struct mucse_hw *hw);
> > +
> > +#endif /* _RNPGBE_MBX_FW_H */
> > --
> > 2.25.1
> > 
> > 
> 
> 

Thanks for your feedback.


