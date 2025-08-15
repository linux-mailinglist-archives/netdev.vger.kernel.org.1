Return-Path: <netdev+bounces-213987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED71B2794D
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 08:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033D55A719B
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 06:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154472BE65D;
	Fri, 15 Aug 2025 06:37:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEC1227581
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 06:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755239837; cv=none; b=F/68bsBf5shn1tW2vvOmMAjwsfFKckwW24tax/df53j5YpsrkLy2/MTuX1Nx6iNx2wN7gmCVdh49yA8WAVDjBIfz/fbj2jRBXBEGhASFim31z701fQ+vndh2eIQOcIBYDvLXuFSX3JcFmyXkfZbTCoIbBbnuAs2FmJHyiXXa6L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755239837; c=relaxed/simple;
	bh=OcUIEGP5JZHbmx+eJwa2JEAcTaGD5r9WofCSLd01LS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLxn5nLmGz49BJbWR5emNjZk9tkwsvTmo3fYxw9UTlvU2feHzVIEqzNN9gPtGL4jni3B7YEAFaxOowVi2uI++IuiSNJOHHFj4/+0WSAeYCujTKTHg1CoqVZrt5fQvcWrWRxkpsGV9JMF7ZRXOUsCY8y+XUBusceU1qkvVhuo2zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz9t1755239818t95974af1
X-QQ-Originating-IP: Xz02paZz0XrOCFh68IMTXGqO/MHmiqMrvwmI8qYoZQU=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 15 Aug 2025 14:36:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5358240259395925756
Date: Fri, 15 Aug 2025 14:36:56 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <3A381A779EB97B74+20250815063656.GA1148411@nic-Precision-5820-Tower>
References: <20250814073855.1060601-1-dong100@mucse.com>
 <20250814073855.1060601-5-dong100@mucse.com>
 <eebc7ed8-f6c5-4095-b33e-251411f26f0a@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eebc7ed8-f6c5-4095-b33e-251411f26f0a@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NF/avWz1IO0+JeBuX9jMpEKCwhEij5F4Gaabhqlb6NH+HDWt4HOdhV+f
	OVpqMxRLJRx40V4bsppkAV6EGkCqLWQC4o6MEbVFOE2Ujk0DVSp7WoriHcrUGf1fIP6w0lG
	3sVOPSxHoOUvvAPnLhFhuSVgD98qlA1USmg33Jxyq4vloE0Gh6r7hrvsucyPatHkM218kCR
	N28t75ISTPWQeH/vSTP/EqjqTP68WYsX3SmWLk4/i83rwlueUGsZ3FUaPjjCW/O2I79uiMX
	/BJ0tjthXSLSAqgotHSdr4u0pO7Turxerm15do9M0T6X2wl7A1ZJsa29OcAfzY0x12eVgK2
	sgnlRGuYCCHZxLhM57V9AAFdk8RqAAfCnVbV/uOXG+tru11m/SH56lgFP+75v1ohz/ju+Mj
	oNAlt3wNKkKEha9hu+TvW7kugvD77JONRSGHSiU1OXogPJIE9nFr4+EWaHPWX+YfWxqrHY2
	k8L5AZKZQJvWpFD1WoqAigOIvxcAd30Xrf64MkI4HswnPpGo4BCEchmJdDCkWbyWQxlv/s7
	o82ofAxSWPNhI1beVAgcVpYJtZ9HhE4pzHK67kUkOF45Aon6Gb9pWoSlzFHte21nit9MpXB
	d7vgceNqpBbQ3gfmA+I4qcWCcEMDmaSyn45uFA7/4gUs/mDYfZZAz+p3rGfDXwNMrki0SoR
	dP43SF2m6x+5LC5T/VJF5TOlyjIrAgaoI2Vt8geOcCVpYMs78V3WXyX75mCMeZlhmTXTRJr
	JEFCkzJdKITXpFhlNDAS1vepBePTUUTsUPILojMzx1kOj/+rK6ZZa+y6LGC9mKhxUC++S94
	F1bIv90a2VL46AsaYKKfjcfSJqzLqQ01KBOQ497fs35K5wSNW33zvU1hNqiqD/8rHqI5Cnz
	0KpY3TPdpOyy0lMa4UT+MyFOLJQbtEGlkBbuCSTOsYKkuBCv75FwkgRh9ydfeF5vmEheDRn
	SywFqx82UvjvaHzN/SIH1zbwrpKGoxiuPxUSNzK9FOGPUFDax36ZJXY0nBskoZc7xPC6KuW
	5qPntHYlrU5VgktCiyjDiynR4IgodNEmqG1gCTQJFuDCQnuFjJREc/qoqPdXqw/4Zk3jhtX
	Q==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

On Fri, Aug 15, 2025 at 05:27:51AM +0200, Andrew Lunn wrote:
> >  struct mucse_hw {
> > +	u8 pfvfnum;
> >  	void __iomem *hw_addr;
> >  	void __iomem *ring_msix_base;
> >  	struct pci_dev *pdev;
> > +	u32 fw_version;
> > +	u32 axi_mhz;
> > +	u32 bd_uid;
> >  	enum rnpgbe_hw_type hw_type;
> >  	struct mucse_dma_info dma;
> >  	struct mucse_eth_info eth;
> 
> Think about alignment of these structures. The compiler is going to
> put in padding after the u8 phvfnum. The 3 pointers are all the same
> size, no padding. The u32 probably go straight after the pointers. The
> enum it might represent as a single byte, so there is will be padding
> before dma. So consider moving the u8 next to the enum.
> 
> pahole(1) will tell you what the compiler really did, but you will
> find more experienced engineers try to minimise padding, or
> deliberately group hot items on a cache line, and document that.
> 

Got it, I will update this.

> > +static int mucse_fw_send_cmd_wait(struct mucse_hw *hw,
> > +				  struct mbx_fw_cmd_req *req,
> > +				  struct mbx_fw_cmd_reply *reply)
> > +{
> > +	int len = le16_to_cpu(req->datalen) + MBX_REQ_HDR_LEN;
> > +	int retry_cnt = 3;
> > +	int err;
> > +
> > +	err = mutex_lock_interruptible(&hw->mbx.lock);
> > +	if (err)
> > +		return err;
> > +	err = hw->mbx.ops->write_posted(hw, (u32 *)req,
> > +					L_WD(len));
> 
> This L_WD macro is not nice. It seems like a place bugs will be
> introduced, forgetting to call it here. Why not have write_posted()
> take bytes, and have the lowest layer convert to 32 bit words.
> 
> It also seems odd you are adding MBX_REQ_HDR_LEN here but not that
> actual header. Why not increase the length at the point the header is
> actually added? Keep stuff logically together.
> 

Ok, I will have write_posted() take bytes like you suggestion, and try
to improve len here.

> > +	if (err)
> > +		goto quit;
> > +	do {
> > +		err = hw->mbx.ops->read_posted(hw, (u32 *)reply,
> > +					       L_WD(sizeof(*reply)));
> > +		if (err)
> > +			goto quit;
> > +	} while (--retry_cnt >= 0 && reply->opcode != req->opcode);
> > +quit:
> 
> Maybe add some documentation about what is actually going on here. I
> assume you are trying to get the driver and firmware into sync after
> one or other has crashed, burned, and rebooted. You need to flush out
> old replies. You allow up to three old replies to be in the queue, and
> then give up. Since you don't retry the write, you don't expect writes
> to be lost?
> 
> 

write_posted return 0 only after fw acked it, so no need to write.
It is a sync mechanism, tries to get the correct response opcode.

Maybe comment link this?
/* write_posted return 0 means fw has received request, wait for
 * the expect opcode reply with 'retry_cnt' times.
 */

> > +	mutex_unlock(&hw->mbx.lock);
> > +	if (!err && retry_cnt < 0)
> > +		return -ETIMEDOUT;
> > +	if (!err && reply->error_code)
> > +		return -EIO;
> > +	return err;
> > +}
> > +
> > +/**
> > + * mucse_fw_get_capability - Get hw abilities from fw
> > + * @hw: pointer to the HW structure
> > + * @abil: pointer to the hw_abilities structure
> > + *
> > + * mucse_fw_get_capability tries to get hw abilities from
> > + * hw.
> > + *
> > + * @return: 0 on success, negative on failure
> > + **/
> > +static int mucse_fw_get_capability(struct mucse_hw *hw,
> > +				   struct hw_abilities *abil)
> > +{
> > +	struct mbx_fw_cmd_reply reply = {};
> > +	struct mbx_fw_cmd_req req = {};
> > +	int err;
> > +
> > +	build_phy_abilities_req(&req, &req);
> 
> Passing the same parameter twice? Is that correct? It looks very odd.
> 

Got it, I will fix it.

> > +/**
> > + * mbx_cookie_zalloc - Alloc a cookie structure
> > + * @priv_len: private length for this cookie
> > + *
> > + * @return: cookie structure on success
> > + **/
> > +static struct mbx_req_cookie *mbx_cookie_zalloc(int priv_len)
> > +{
> > +	struct mbx_req_cookie *cookie;
> > +
> > +	cookie = kzalloc(struct_size(cookie, priv, priv_len), GFP_KERNEL);
> > +	if (cookie) {
> > +		cookie->timeout_jiffes = 30 * HZ;
> > +		cookie->magic = COOKIE_MAGIC;
> > +		cookie->priv_len = priv_len;
> > +	}
> > +	return cookie;
> 
> > +struct mbx_req_cookie {
> > +	int magic;
> > +#define COOKIE_MAGIC 0xCE
> > +	cookie_cb cb;
> > +	int timeout_jiffes;
> > +	int errcode;
> > +	wait_queue_head_t wait;
> > +	int done;
> > +	int priv_len;
> > +	char priv[];
> > +};
> 
> 
> Using struct_size() makes me think this is supposed to be a flexible
> array? I've never used them myself, but shouldn't be some markup so
> the compiler knows priv_len is the len of priv?
> 

Maybe link this?
struct mbx_req_cookie {
....
	int priv_len;
	char priv[] __counted_by(priv_len);
}

> > +static int mucse_mbx_fw_post_req(struct mucse_hw *hw,
> > +				 struct mbx_fw_cmd_req *req,
> > +				 struct mbx_req_cookie *cookie)
> > +{
> > +	int len = le16_to_cpu(req->datalen) + MBX_REQ_HDR_LEN;
> > +	int err;
> > +
> > +	cookie->errcode = 0;
> > +	cookie->done = 0;
> > +	init_waitqueue_head(&cookie->wait);
> > +	err = mutex_lock_interruptible(&hw->mbx.lock);
> > +	if (err)
> > +		return err;
> > +	err = mucse_write_mbx(hw, (u32 *)req,
> > +			      L_WD(len));
> > +	if (err) {
> > +		mutex_unlock(&hw->mbx.lock);
> 
> Please try to put the unlock at the end of the function, with a goto
> on error.
> 

Got it, I will fix it.

> > +		return err;
> > +	}
> > +	do {
> > +		err = wait_event_interruptible_timeout(cookie->wait,
> > +						       cookie->done == 1,
> > +						       cookie->timeout_jiffes);
> > +	} while (err == -ERESTARTSYS);
> 
> This needs a comment, because i don't understand it.
> 
> 

wait_event_interruptible_timeout return -ERESTARTSYS if it was interrupted
by a signal, which will cause misjudgement about cookie->done is timeout. 
In this case, just wait for timeout.
Maybe comment link this?
/* If it was interrupted by a signal (-ERESTARTSYS), it is not true timeout,
 * just wait again.
 */

> > +	mutex_unlock(&hw->mbx.lock);
> > +	if (!err)
> > +		err = -ETIME;
> 
> I _think_ ETIMEDOUT would be more normal.
> 

Got it, I will update it. 

> > +	else
> > +		err = 0;
> > +	if (!err && cookie->errcode)
> > +		err = cookie->errcode;
> > +
> > +	return err;
> > +}
> > +int mucse_fw_get_macaddr(struct mucse_hw *hw, int pfvfnum,
> > +			 u8 *mac_addr,
> > +			 int lane)
> > +{
> > +	struct mbx_fw_cmd_reply reply = {};
> > +	struct mbx_fw_cmd_req req = {};
> > +	int err;
> > +
> > +	build_get_macaddress_req(&req, 1 << lane, pfvfnum, &req);
> > +	err = mucse_fw_send_cmd_wait(hw, &req, &reply);
> > +	if (err)
> > +		return err;
> > +
> > +	if ((1 << lane) & le32_to_cpu(reply.mac_addr.lanes))
> 
> BIT(). And normally the & would be the other way around.
> 

Maybe changed link this?
...
if (le32_to_cpu(reply.mac_addr.ports) & BIT(lane))
...

> What exactly is a lane here? Normally we would think of a lane is
> -KR4, 4 SERDES lanes making one port. But the MAC address is a
> property of the port, not the lane within a port.
> 

lane is the valid bit in 'reply.mac_addr.ports'.
Maybe change it to 'port', that is more appropriate.

> > +		memcpy(mac_addr, reply.mac_addr.addrs[lane].mac, 6);
> 
> There is a macro for 6, please use it.
> 

Got it, I will use ETH_ALEN.

> > +struct hw_abilities {
> > +	u8 link_stat;
> > +	u8 lane_mask;
> > +	__le32 speed;
> > +	__le16 phy_type;
> > +	__le16 nic_mode;
> > +	__le16 pfnum;
> 
> Another example of a bad structure layout. It would of been much
> better to put the two u8 after speed.
> 
> > +} __packed;
> 
> And because this is packed, and badly aligned, you are forcing the
> compiler to do a lot more work accessing these members.
> 

Yes, It is bad. But FW use this define, I can only follow the define...
Maybe I can add comment here?
/* Must follow FW define here */ 

> > +
> > +static inline void ability_update_host_endian(struct hw_abilities *abi)
> > +{
> > +	u32 host_val = le32_to_cpu(abi->ext_ability);
> > +
> > +	abi->e_host = *(typeof(abi->e_host) *)&host_val;
> > +}
> 
> Please add a comment what this is doing, it is not obvious.
> 
> 

Maybe link this?
/* Converts the little-endian ext_ability field to host byte order,
 * then copies the value into the e_host field by reinterpreting the
 * memory as the type of e_host (likely a bitfield or structure that
 * represents the extended abilities in a host-friendly format).
 */

> > +
> > +#define FLAGS_DD BIT(0)
> > +#define FLAGS_ERR BIT(2)
> > +
> > +/* Request is in little-endian format. Big-endian systems should be considered */
> 
> So the code now sparse clean? If it is, you can probably remove this
> comment.
> 

Yes, sparse clean. I will remove this.

> > +static inline void build_phy_abilities_req(struct mbx_fw_cmd_req *req,
> > +					   void *cookie)
> > +{
> > +	req->flags = 0;
> > +	req->opcode = cpu_to_le16(GET_PHY_ABALITY);
> > +	req->datalen = 0;
> > +	req->reply_lo = 0;
> > +	req->reply_hi = 0;
> > +	req->cookie = cookie;
> > +}
> > +
> > +static inline void build_ifinsmod(struct mbx_fw_cmd_req *req,
> > +				  unsigned int lane,
> > +				  int status)
> > +{
> > +	req->flags = 0;
> > +	req->opcode = cpu_to_le16(DRIVER_INSMOD);
> > +	req->datalen = cpu_to_le16(sizeof(req->ifinsmod));
> > +	req->cookie = NULL;
> > +	req->reply_lo = 0;
> > +	req->reply_hi = 0;
> > +	req->ifinsmod.lane = cpu_to_le32(lane);
> > +	req->ifinsmod.status = cpu_to_le32(status);
> > +}
> > +
> > +static inline void build_reset_phy_req(struct mbx_fw_cmd_req *req,
> > +				       void *cookie)
> > +{
> > +	req->flags = 0;
> > +	req->opcode = cpu_to_le16(RESET_PHY);
> > +	req->datalen = 0;
> > +	req->reply_lo = 0;
> > +	req->reply_hi = 0;
> > +	req->cookie = cookie;
> > +}
> > +
> > +static inline void build_get_macaddress_req(struct mbx_fw_cmd_req *req,
> > +					    int lane_mask, int pfvfnum,
> > +					    void *cookie)
> > +{
> > +	req->flags = 0;
> > +	req->opcode = cpu_to_le16(GET_MAC_ADDRES);
> > +	req->datalen = cpu_to_le16(sizeof(req->get_mac_addr));
> > +	req->cookie = cookie;
> > +	req->reply_lo = 0;
> > +	req->reply_hi = 0;
> > +	req->get_mac_addr.lane_mask = cpu_to_le32(lane_mask);
> > +	req->get_mac_addr.pfvf_num = cpu_to_le32(pfvfnum);
> > +}
> 
> These are rather large for inline functions in a header. Please move
> them into a .c file.
> 
> 	Andrew
> 

Got it. I will update it.

Thanks for your feedback.


