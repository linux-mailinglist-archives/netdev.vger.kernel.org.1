Return-Path: <netdev+bounces-219797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B0CB43064
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 05:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D225E7D3C
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 03:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B65284662;
	Thu,  4 Sep 2025 03:20:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB8F273D73;
	Thu,  4 Sep 2025 03:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.67.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756956034; cv=none; b=c+48kquWB58XSXMYUbaGFE8S1a3qzWDkR5Hpr25nuP3Yy3FTXp2p+OibgN0XbFNwl/ckBHOzcfgTGcVMh/PgaMWOry1pmNqOQ3IxIVzpa55HRUoQWVwDhE9DA2CM6ugn/B1y68wLarlpy87KyO2l+5g2NacCEOGDzEg6vgTYd88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756956034; c=relaxed/simple;
	bh=k+aTpliApoWbNw80nqK+2WXMpPb/AU2t+0D2obcRy40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAzhB44T3xLxkPNZv93ziG2Ot6rOcZyvmv1guhd3ehglwR1PmUiga3qWIFhdw58Z4APoPNH6vrogq9WiLTILUJzM4JDGrVO7qPY3q0Pe7B/HMQHEhlqAzwJXUMTncTdiWNB9q/sm2LuWMGBkbVV1BkeZDgeQk8fHEbsI3w+iJzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=114.132.67.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz9t1756955990t16e8e88c
X-QQ-Originating-IP: 8TNuYgW+VG8Zav27jjPAJi9wGht8itHh76lwNL/5PH4=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 04 Sep 2025 11:19:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17764772269566909231
Date: Thu, 4 Sep 2025 11:19:48 +0800
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
Message-ID: <AF92025D9CBFCF3B+20250904031948.GA1022066@nic-Precision-5820-Tower>
References: <20250903025430.864836-1-dong100@mucse.com>
 <20250903025430.864836-4-dong100@mucse.com>
 <659df824-7509-4ffe-949b-187d7d44f69f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <659df824-7509-4ffe-949b-187d7d44f69f@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MzAknNW/75Qpi25mUnpd6SuzQ1Wghw2pmbOFR3Rxa4Rqeyi2AA43xKs7
	L5gYarYCmzImJhg+VxGjDerX/MlGqy7LpsVR/9jXsggZ32GFQzIlewm9cqe8VtKA0PWHfxa
	Smno5taMN9iaFAnTlU8QXSze6+6SMImSS3V9zVNBqCdgEYwT82V1NKFvTROk+Zli/oMQcff
	gvdm2wn78JAZP0CmzKW/TW621i6uvOCrSYx2aupKVQYdirun1bglNbwRngtLmEYVEF1H3zM
	i4UaBs7dH4Ln2tm0M6DxL9wYLigFzP2owZSNe8y6Cq/7S9Y9TacDuAk4m5TGjsIQaiWODYO
	pSy+pinGiN3v4pMS7MlbhfwAJkT5Nlm6JFRJF9357VLQpKpZjLOrRRxvA5Vrui8idyQddX1
	HkyPwpjt9iTIMwkMgj5Sfljw+I0uLbry4sZlaYwqGymbSqD3OF+24MRxhV2FY19KX2NAZ41
	tXAVWMl/PzzRhYP0+0H1SG2pCMvPghJqC9x/fLNcHdyv0PsqvHOztMyAwvpGRQlN0jkKUbo
	vmv0mxNqyv/mWVKNRikQ45HD644QtkasV8gHi6qutd4YJcIzuiwgeHBARC3kShUdZr6U4Ll
	lDDqZb9ba49PGzdzfQysNv3A96Au6jgjT+9BDUgBIBLLsIBY16UcHcQyerq2oQx0izPritL
	KyAJGwrW0SiFjjUVzS4uxoKVmiuhfqXQHOFYksa0e/CTcm/XiFhJBnkLdZMiV/OV0hIw/EP
	/LAh+i+FlYgpbsdZlXT07ryaxyO38ulSoa/oY+RuDGSIiK6M+yCCHumBv0COJFNFZ0pbc4a
	74ZQ11xoe5PA3KzA+C0NcpFJc23W4qHApeeKmLFN7gOoCWgcFeFXFYWv2ob7pS0mjb3sC4+
	P+nfJ3XRoIDSZ3iuxEmZrZEiKE1sIXZiH78F8d0nFrL+RTzdlWfdQqCbfaJOF6cDCuQ2cNs
	3XHlBPGE4mS7VgV6VonzpSJ0s9Xv/BpJPzPGOAER6bvCqsdoUbTQASMr7i/RrggW4vt7AKR
	xVZsTgnTCEkdRKnG7tLFwPdLqSbl84L8NVmV+rYmvEg6M1JMAUtHv8M8V0kirz+BrCcJCNu
	JlSe9ScPck39l0Rcr2LLjt0rnDmhLAWww==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

On Thu, Sep 04, 2025 at 12:24:17AM +0200, Andrew Lunn wrote:
> >  struct mucse_mbx_info {
> > +	struct mucse_mbx_stats stats;
> > +	u32 timeout;
> > +	u32 usec_delay;
> > +	u16 size;
> > +	u16 fw_req;
> > +	u16 fw_ack;
> > +	/* lock for only one use mbx */
> > +	struct mutex lock;
> >  	/* fw <--> pf mbx */
> >  	u32 fw_pf_shm_base;
> >  	u32 pf2fw_mbox_ctrl;
> 
> > +/**
> > + * mucse_obtain_mbx_lock_pf - Obtain mailbox lock
> > + * @hw: pointer to the HW structure
> > + *
> > + * This function maybe used in an irq handler.
> > + *
> > + * Return: 0 if we obtained the mailbox lock or else -EIO
> > + **/
> > +static int mucse_obtain_mbx_lock_pf(struct mucse_hw *hw)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +	int try_cnt = 5000;
> > +	u32 reg;
> > +
> > +	reg = PF2FW_MBOX_CTRL(mbx);
> > +	while (try_cnt-- > 0) {
> > +		mbx_ctrl_wr32(mbx, reg, MBOX_PF_HOLD);
> > +		/* force write back before check */
> > +		wmb();
> > +		if (mbx_ctrl_rd32(mbx, reg) & MBOX_PF_HOLD)
> > +			return 0;
> > +		udelay(100);
> > +	}
> > +	return -EIO;
> > +}
> 
> If there is a function which obtains a lock, there is normally a
> function which releases a lock. But i don't see it.
> 

The lock is relased when send MBOX_CTRL_REQ in mucse_write_mbx_pf:

mbx_ctrl_wr32(mbx, ctrl_reg, MBOX_CTRL_REQ);

Set MBOX_PF_HOLD(bit3) to hold the lock, clear bit3 to release, and set
MBOX_CTRL_REQ(bit0) to send the req. req and lock are different bits in
one register. So we send the req along with releasing lock (set bit0 and
clear bit3).
Maybe I should add comment like this?

/* send the req along with releasing the lock */
mbx_ctrl_wr32(mbx, ctrl_reg, MBOX_CTRL_REQ);

> > +void mucse_init_mbx_params_pf(struct mucse_hw *hw)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +
> > +	mbx->usec_delay = 100;
> > +	mbx->timeout = (4 * USEC_PER_SEC) / mbx->usec_delay;
> > +	mbx->stats.msgs_tx = 0;
> > +	mbx->stats.msgs_rx = 0;
> > +	mbx->stats.reqs = 0;
> > +	mbx->stats.acks = 0;
> > +	mbx->size = MUCSE_MAILBOX_BYTES;
> > +	mutex_init(&mbx->lock);
> 
> And this mutex never seems to be used anywhere. What is it supposed to
> be protecting?
> 

mbx->lock is used in patch5, to ensure that only one uses mbx.
I will move it to patch5.

>     Andrew
> 
> ---
> pw-bot: cr
> 

Thanks for your feedback.


