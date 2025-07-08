Return-Path: <netdev+bounces-204770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EA4AFC06B
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 04:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EADF426754
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 02:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BC91B4236;
	Tue,  8 Jul 2025 02:03:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65754BA45;
	Tue,  8 Jul 2025 02:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751940194; cv=none; b=VyP3vUZZpgLSFsbDgYrPdFD74m++0gy5VDS4hq0NeRMSMYC1wuVTN+tSMLO6V2LUsoynvPlbxuet7w8QlzppiQmQN9MB8/hUPWw2h5vKx9nmkZRDdzpgOCY+6Q7zwS+okfAiG1rnqNk/ibCLVfryHbkuPm/MvaPyAGXvTPlA+WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751940194; c=relaxed/simple;
	bh=r0EMgNVX/z4zYUNMe5TgvPCak9pLBC1m6P6hzEd8k4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GpUmrLAZmRBPTBUIRl/SecvQ5mmCoStmZkZNXRu215GyKgQtsuEUlEr1AX5bKxahEqYHUUGTFqw+dwYGUXUoDYs0LeriI37XuJV57Umc+Zi8TU4OTS5tX3NVOQ4z4GUYyzaf/lelzZ4Ap8mbK2gBtGkEmzuwE94k4oXgh1KExyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz2t1751940112t5c4f092b
X-QQ-Originating-IP: 4LFULpdcet4DuWtuH/L0yUVh01li1CK9FUyGaDibKB4=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 08 Jul 2025 10:01:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16836911135302735176
Date: Tue, 8 Jul 2025 10:01:50 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	andrew+netdev@lunn.ch, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/15] net: rnpgbe: Add get_capability mbx_fw ops support
Message-ID: <60002AD49B3F6BD5+20250708020150.GB216877@nic-Precision-5820-Tower>
References: <20250703014859.210110-1-dong100@mucse.com>
 <20250703014859.210110-5-dong100@mucse.com>
 <57497e14-3f9a-4da8-9892-ed794aadbf47@lunn.ch>
 <CB185D75E8EDC84A+20250707073743.GA164527@nic-Precision-5820-Tower>
 <e0610a11-18fa-42f6-9925-f15dac20643c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0610a11-18fa-42f6-9925-f15dac20643c@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N7WV2vBY6Wtphb9XuLP7+3+zApZBH6zKOpSypbxywONFcdLATU9Lwtk0
	ybxSgIymt7lTOVNozas7HfajECDtpWCUhUDmoKhrTaYpl2HZArImGhcZFrlNJbj7qBM5ztD
	qpYP+ux27xbs7jzbt87bOMaAuqadmOKsoLDXDEBrrQwianiCpenPQHbdKTXgGy6+BPcz0C/
	/DUBb2+cIV0BqT1CCHqb49Q4BdoV9EYAkWBR6TisxiRUU02MFcEl2rsg32aZVKmoQ4gg5Vj
	u92naVYNi5B02xJT1qG0pO6lw2FOhmYJZqcHikKFSxi8COM8xcPSHIxIIZxTG4BOcq0xVnY
	DGFwH3eilzhM9KHsdGkgOrvZnlPDy8gpgSsYLJCXQAl/knrCjjy50d8XKEXuKyaHRjyDBQr
	4pVAs/YoEAIfBoqECuXTJZpY7fpCME8ANV+XwPzaCxRbWgRyJqURzL+MI379HsBo3MpcBLj
	FR2Jv7cqQWULfmFED6Fn6swGwr6dSZveZcLX6rUM5MLXdcu4x30hLoVjhYdk0b6TmaJE4EQ
	bw+X//rM6+Qb8G1eRemBdGCk4appvaog3hgLaz3eIH2i9ivqvSGhY/uNRHcUCwA10QrMw1h
	6k46pmBsEwp8NSGPmZyPgArU/YMzlVYVYfGXsK+q88sDL0wVw93RS6ceu6QiKnJDBVwMRQG
	74abC6gM3dSNU2GmVYPWsC+qIUhrVjm1Kbwyi6x+8hRK5pVWblKYhYbPy85HQajaIYs9ps5
	g3hMYIUP0v6QHJO/UaKFpL4VwobXEOk1TxjCltghUSs7WFJ8Ex3CJJ49cV5jQnd9UDo5yJg
	WLhTMG51A5ZU7izHVtTS1M/gIfcTVPcU9nn31RsmFOjj6Eecq3rrJo/pbuC11+oaNwqLiqI
	EFM1oXWy1toPqhwOed6WGyOtKV/eve0wDSE6TmxHksJBYL9n0ZVuy+m7xOQQCSe3r4ggIVe
	d61QgSnMYGhRLqgT6qCaFA6r/mAGTQZeuSCaB3oJXRWfqL983gWydhLQ/AmVUiIkxtQ+MlZ
	v95HyL3w==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On Mon, Jul 07, 2025 at 02:09:23PM +0200, Andrew Lunn wrote:
> On Mon, Jul 07, 2025 at 03:37:43PM +0800, Yibo Dong wrote:
> > On Fri, Jul 04, 2025 at 08:25:12PM +0200, Andrew Lunn wrote:
> > > > +/**
> > > > + * mucse_fw_send_cmd_wait - Send cmd req and wait for response
> > > > + * @hw: Pointer to the HW structure
> > > > + * @req: Pointer to the cmd req structure
> > > > + * @reply: Pointer to the fw reply structure
> > > > + *
> > > > + * mucse_fw_send_cmd_wait sends req to pf-cm3 mailbox and wait
> > > > + * reply from fw.
> > > > + *
> > > > + * Returns 0 on success, negative on failure
> > > > + **/
> > > > +static int mucse_fw_send_cmd_wait(struct mucse_hw *hw,
> > > > +				  struct mbx_fw_cmd_req *req,
> > > > +				  struct mbx_fw_cmd_reply *reply)
> > > > +{
> > > > +	int err;
> > > > +	int retry_cnt = 3;
> > > > +
> > > > +	if (!hw || !req || !reply || !hw->mbx.ops.read_posted)
> > > 
> > > Can this happen?
> > > 
> > > If this is not supposed to happen, it is better the driver opps, so
> > > you get a stack trace and find where the driver is broken.
> > > 
> > Yes, it is not supposed to happen. So, you means I should remove this
> > check in order to get opps when this condition happen?
> 
> You should remove all defensive code. Let is explode with an Opps, so
> you can find your bugs.
> 

Got it.

> > > > +		return -EINVAL;
> > > > +
> > > > +	/* if pcie off, nothing todo */
> > > > +	if (pci_channel_offline(hw->pdev))
> > > > +		return -EIO;
> > > 
> > > What can cause it to go offline? Is this to do with PCIe hotplug?
> > > 
> > Yes, I try to get a PCIe hotplug condition by 'pci_channel_offline'.
> > If that happens, driver should never do bar-read/bar-write, so return
> > here.
> 
> I don't know PCI hotplug too well, but i assume the driver core will
> call the .release function. Can this function be called as part of
> release? What actually happens on the PCI bus when you try to access a
> device which no longer exists?
> 

This function maybe called as part of release:
->release
-->unregister_netdev
--->ndo_stop
---->this function
Based on what I have come across, some devices return 0xffffffff, while 
others maybe hang when try to access a device which no longer
exists.

> How have you tested this? Do you have the ability to do a hot{un}plug?
> 

I tested hot{un}plug with an ocp-card before.
But I think all the codes related to pcie hot{un}plug should be in a
separate patch, I should move it to that patch.

> > > > +	if (mutex_lock_interruptible(&hw->mbx.lock))
> > > > +		return -EAGAIN;
> > > 
> > > mutex_lock_interruptable() returns -EINTR, which is what you should
> > > return, not -EAGAIN.
> > > 
> > Got it, I should return '-EINTR' here.
> 
> No, you should return whatever mutex_lock_interruptable()
> returns. Whenever you call a function which returns an error code, you
> should pass that error code up the call stack. Never replace one error
> code with another.
> 

Ok, I see.

> > > > +	if (reply->error_code)
> > > > +		return -reply->error_code;
> > > 
> > > The mbox is using linux error codes? 
> > > 
> > It is used only between driver and fw, yay be just samply like this: 
> > 0     -- no error
> > not 0 -- error
> > So, it is not using linux error codes.
> 
> Your functions should always use linux/POSIX error codes. So if your
> firmware says an error has happened, turn it into a linux/POSIX error
> code. EINVAL, TIMEDOUT, EIO, whatever makes the most sense.
> 
> 	Andrew
> 

Got it, I will turn it into a linux/POSIX error code.

Thanks for your feedback.

