Return-Path: <netdev+bounces-220186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3859BB44B2C
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 03:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 004CB1C8349F
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 01:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6251D90DD;
	Fri,  5 Sep 2025 01:17:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746A7175BF;
	Fri,  5 Sep 2025 01:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757035039; cv=none; b=DUhtbJU9S+CzGDI9pHh2PPLdirn5D91Gzp1hOtSHAMccKy7yYaFAvKCHwND2Q5spqcYUMd3DydU6e1PyHZLbwCymd9TZw/3uewJo+WYfn/P94T4pa6tEhLJkPuLUevvoQjKeELm/wAljEPM4TiNd7VIRoKcGXdqRVDk320DFwmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757035039; c=relaxed/simple;
	bh=+wCBLkddcwyeCzPBMQjiuSKkCrej7JNqV4TB0tDCD8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M++ZtILacjplnieY9HElrHx844UK6QSvIo1cG9y//HBgvdI20QUyDb6hu8Va8FGY8qzu1rw5C7FnO5/K5N6Ms2gHh8VqD5vGjwb4t/+HXXjviOHe2TUWl0I2s8Ogn+TgOmRnvz75Cm2eWBug9MSO4XAz7MIBFtwlEemoj2EXVhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz9t1757035000t39e8f3c3
X-QQ-Originating-IP: i4FX2pE7QvtBsnrO5X+wZgq5nyVzqV1BI164afJORGE=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 05 Sep 2025 09:16:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4385893563284536436
Date: Fri, 5 Sep 2025 09:16:37 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
	gustavoars@kernel.org, rdunlap@infradead.org,
	vadim.fedorenko@linux.dev, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v10 3/5] net: rnpgbe: Add basic mbx ops support
Message-ID: <C825CC85444ED85D+20250905011637.GA1091337@nic-Precision-5820-Tower>
References: <20250903025430.864836-1-dong100@mucse.com>
 <20250903025430.864836-4-dong100@mucse.com>
 <659df824-7509-4ffe-949b-187d7d44f69f@lunn.ch>
 <AF92025D9CBFCF3B+20250904031948.GA1022066@nic-Precision-5820-Tower>
 <908e4c95-81cb-4a95-9235-2d2c8c80d80c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <908e4c95-81cb-4a95-9235-2d2c8c80d80c@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OTaQrRjuGKLtJntBA4+B0Z7GyNwxtC973GzQYFbB+xOGXegwkUgKzwAk
	j1KjRWBVZ4JR1V1cRnlSS1QRo0VZuJnxQ1NdzO9z5FMBm3vJDYYwCRUu24V/S0rL26OLPuc
	NahRy9h4ckWXnJ5EQ7P3pHwi75qzdyJ58Mnr55GLeyxm9gJCqt/xw3WFLvElv04zFQP+EAx
	xe16sNCjVEERU9CwhpIM5nhb/C27ceDxooqobGC6hjDtJXpaYf3s24/yfGQoYdFWvtNZ2ar
	Ox1+gawdYb441iFJ2PoxAg3E9+sh/WnGqQ+fNTNz0r8ih+LrgENjsErpvIbwD2nsjMkrKLO
	grJG06Xk+kCnIdVYcLnf17JjwUAnaTgx89bp7KIiMtv8xBuZIUsFntm6qEQZL4xhGQt9Hck
	JZAMUTw/0Nm5LfJTI3PiWkihUzTTH1WoWONRoictTX95ao/7Czgh4KGOXk6wA/NQCL06NgF
	ZzsRScyquz+9RSjUZRvKsXRYlXSjZrvYzf54RyA9AHPC+N+7/GMFe515XaDBSLP/KQ8fNr2
	3GGHhoaJ0k8KfxdNRF1GZPF39FDq2aBLcxenQ+AnEgeRbndLIbhBywGy7YAXdqBIOcuehkd
	yq4TWFgDggA6F0d+Clhi0KMPwtcH7wX8+sdcGXHJ/E4sY0G5hZ7cEygmtd4uIJ8N5JG9Lt8
	jgHcICv5Fh8x6mJ2oX0iOad6nRDJoTYY6YgVksmh+DFb/NW1pvejBsaH/CQ2kY6sb7p20XK
	3tiGe6jWT7MbyZJjZlfSoKn0zStrrthe1juf+Rg4JZNS6y/U9ZHKED7HV5JZb8Vf9wzCjIb
	EP42RfcSGptYiRinIR2H0MgzD9ZwU+zqOt55J7YDuW4DPlCVZbhECVkF7csETNSSBexfE5c
	X2YqGgTYt20o5F0mYc+iIqYeBCqbLEjAxz+kdXqXSr3IFcbOQ7anOVXML+kb1TRdroNSPdg
	wCcqiT2SvkUOB0blrVlj9aJJHiUq4tk1m8jL3P5k3kRbyK5XGvnDDMNBJcqllQrhP4rxZsh
	I9x3oB2qkUQXd/FV1lfUff/j7wB0I+UUnGVGJKRA==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

On Thu, Sep 04, 2025 at 02:05:57PM +0200, Andrew Lunn wrote:
> On Thu, Sep 04, 2025 at 11:19:48AM +0800, Yibo Dong wrote:
> > On Thu, Sep 04, 2025 at 12:24:17AM +0200, Andrew Lunn wrote:
> > > >  struct mucse_mbx_info {
> > > > +	struct mucse_mbx_stats stats;
> > > > +	u32 timeout;
> > > > +	u32 usec_delay;
> > > > +	u16 size;
> > > > +	u16 fw_req;
> > > > +	u16 fw_ack;
> > > > +	/* lock for only one use mbx */
> > > > +	struct mutex lock;
> > > >  	/* fw <--> pf mbx */
> > > >  	u32 fw_pf_shm_base;
> > > >  	u32 pf2fw_mbox_ctrl;
> > > 
> > > > +/**
> > > > + * mucse_obtain_mbx_lock_pf - Obtain mailbox lock
> > > > + * @hw: pointer to the HW structure
> > > > + *
> > > > + * This function maybe used in an irq handler.
> > > > + *
> > > > + * Return: 0 if we obtained the mailbox lock or else -EIO
> > > > + **/
> > > > +static int mucse_obtain_mbx_lock_pf(struct mucse_hw *hw)
> > > > +{
> > > > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > > > +	int try_cnt = 5000;
> > > > +	u32 reg;
> > > > +
> > > > +	reg = PF2FW_MBOX_CTRL(mbx);
> > > > +	while (try_cnt-- > 0) {
> > > > +		mbx_ctrl_wr32(mbx, reg, MBOX_PF_HOLD);
> > > > +		/* force write back before check */
> > > > +		wmb();
> > > > +		if (mbx_ctrl_rd32(mbx, reg) & MBOX_PF_HOLD)
> > > > +			return 0;
> > > > +		udelay(100);
> > > > +	}
> > > > +	return -EIO;
> > > > +}
> > > 
> > > If there is a function which obtains a lock, there is normally a
> > > function which releases a lock. But i don't see it.
> > > 
> > 
> > The lock is relased when send MBOX_CTRL_REQ in mucse_write_mbx_pf:
> > 
> > mbx_ctrl_wr32(mbx, ctrl_reg, MBOX_CTRL_REQ);
> > 
> > Set MBOX_PF_HOLD(bit3) to hold the lock, clear bit3 to release, and set
> > MBOX_CTRL_REQ(bit0) to send the req. req and lock are different bits in
> > one register. So we send the req along with releasing lock (set bit0 and
> > clear bit3).
> > Maybe I should add comment like this?
> > 
> > /* send the req along with releasing the lock */
> > mbx_ctrl_wr32(mbx, ctrl_reg, MBOX_CTRL_REQ);
> 
> As i said, functions like this come in pairs. obtain/release,
> lock/unlock. When reading code, you want to be able to see both of the
> pair in a function, to know the unlock is not missing. The kernel even
> has tools which will validate all paths through a function releasing
> locks. Often error paths get this wrong.
> 
> So please make this a function, give it a name which makes it obvious
> it is the opposite of mucse_obtain_mbx_lock_pf().
> 
> 	Andrew
> 

Got it, I will update this.

Thanks for your feedback.


