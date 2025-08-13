Return-Path: <netdev+bounces-213248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C13B243D4
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 10:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E503188500B
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 08:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4922023C51C;
	Wed, 13 Aug 2025 08:12:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8262E2E9EDF
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 08:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755072739; cv=none; b=a445nCsPw70ElKm0VhW9VNNNKuJv/hRtyjzi9HuG5Wibi4Sw8PIBeVxGt7gkmNdtYqAjGrleDX8yhQFFafIfchd0H4j5cVD8GjdmkcTiBb3r+mvzCMCR18g3I/khFntsb7l8iJ7i4ES7I5/GaIPf3UZBQGCejmsF9HR986LEqdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755072739; c=relaxed/simple;
	bh=6+7jJZ3HhTmLYJo9sruLtdjHZVI54SZ6HNZmAF5DWM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcL+7FRbsV/F4prLjUZqSETp/Fwq8iK6/Lc+GK8lyeQtoAOp0cFdDJkKdYd2pdhCbkDPfSVS52S2iYvSnwMF3rIXb/7+Mf99Jqbte+N6cIII6JP17ru8MklZxxXGELa8VGin4xcc7mKLnI1sr0g8v5XFL4MO6tnBg9ohCZRW7Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz4t1755072724t6817de95
X-QQ-Originating-IP: +icP6DoFFNymN8R74c7afLzyc/7lvOHbSeRS8oPVEgw=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 13 Aug 2025 16:12:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1664480856713457679
Date: Wed, 13 Aug 2025 16:12:02 +0800
From: Yibo Dong <dong100@mucse.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <211A876E5960B039+20250813081202.GB965498@nic-Precision-5820-Tower>
References: <20250812093937.882045-1-dong100@mucse.com>
 <20250812093937.882045-5-dong100@mucse.com>
 <eafb8874-a7a3-4028-a4ad-d71fc5689813@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eafb8874-a7a3-4028-a4ad-d71fc5689813@linux.dev>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OZsapEVPoiO6ZsKYGvtf16jwxA8tVhOn/XupV1AfyJGYveGNw+gA9jTT
	nCGLk8TwfQjAXFFasTsgs4hC0nbOAtHjQB9BreHQW+ptVTH6hfz0M1jbYx19UbIp7UmCYe9
	u83TJEECD6zYycFfKzpNVu2nM5C6ROf3nrmnP/pvkeDlkUuBvqUf7KTL9z6lvbxsoXBwCOS
	f2/4Xnwh6JslFWL/SXu35O7192wqJTmNe2mVkWE9isba5OYF/fSHah5NLsmonpEXYUt6CSs
	tMa2N6dPCo0y7Y35l5C+EO2rlOF+8+le0t+DeB37uptt5nMtdIox/5FmZvWIENA+fHdE+o/
	WxvTUt8JYb30L9X68EAaekXLoK0C4RGGOeb5cd6ZUNuzMHZgMddtZCLuSe6ejSMVwHl8LPx
	rEhtSY2t5SxGLWfvDiDvDiph2PomfeTQbNcONDZNIbWC1tWM8mRFONJA3vHkCm+q2fzWaf1
	jB4tMexFZ6dZQ4pGKSt/SQVMcNtGaATRb75c3XyzpbKfdbFSspyvEtDPQ2zv56HfwpdiYPA
	kfbvI/GqIgrbwAJIQJ5H8NyjCPsO/Wm/tQwJPFO5O58cc1YUx4UJh4IfkHxxzNZKRI7GWoH
	CcbgwmsBnjuoTl19uboVMPN+6RsvztQwiPnvPQi8HUXfJkcZxuWoMCnN4JUc8JPWbyIt0FE
	23AMEziftTmX5UQPvw5T1aa5bMSqHJ9oaMY8BuA1QUNC6UQiWn4VCPqOQPSlhRZokhe8D5H
	N4YqlGkT7+xfoYD5JfO7U8K1iQ1EoEem9Lg5qVu51oivO60E18q2eqqhY5DdveVFZsqp2Hr
	EBzxISrrcW79bx/xeVHxROjSjNTfwl25Nq/7LD8arhcexpD4VjQFdIKBN82WYfPO3ms5Irv
	M76DHoBZAmNcdmDC6cxs2uxZ3y6JXgqSG8WCVkm2DR/DG+QizodvSgKzGoZknTsr5pLiASR
	beQoqtBcKPQU23pytCCgmgLPW8w1ep8hOOCf4nvdAQnU8mW5LFTIXGpstGxW+SF4EGSTMwG
	WWweqktEj/iQDsB1N7mIwzEbqMapYP4cTDMCuXaA==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On Tue, Aug 12, 2025 at 05:14:15PM +0100, Vadim Fedorenko wrote:
> On 12/08/2025 10:39, Dong Yibo wrote:
> > Initialize basic mbx_fw ops, such as get_capability, reset phy
> > and so on.
> > 
> > Signed-off-by: Dong Yibo <dong100@mucse.com>
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
> > +	if (err) {> +		mutex_unlock(&hw->mbx.lock);
> > +		return err;
> > +	}
> 
> it might look a bit cleaner if you add error label and have unlock code
> once in the end of the function...
> 

Ok, I will try to update this.

> > +	do {
> > +		err = hw->mbx.ops->read_posted(hw, (u32 *)reply,
> > +					       L_WD(sizeof(*reply)));
> > +		if (err) {
> > +			mutex_unlock(&hw->mbx.lock);
> > +			return err;
> > +		}
> > +	} while (--retry_cnt >= 0 && reply->opcode != req->opcode);
> > +	mutex_unlock(&hw->mbx.lock);
> > +	if (retry_cnt < 0 || reply->error_code)
> > +		return -EIO;
> > +	return 0;
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
> > +	struct mbx_fw_cmd_reply reply;
> > +	struct mbx_fw_cmd_req req;
> > +	int err;
> > +
> > +	memset(&req, 0, sizeof(req));
> > +	memset(&reply, 0, sizeof(reply));
> 
> probably
> 
> 	struct mbx_fw_cmd_reply reply = {};
> 	struct mbx_fw_cmd_req req = {};
> 
> will look better. in the other functions as well..
> 
> 
> 

Got it, I will update it.

Thanks for your feedback.


