Return-Path: <netdev+bounces-216265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF336B32D67
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 05:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9D681B21E38
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 03:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4823F1A239A;
	Sun, 24 Aug 2025 03:46:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3993FF1;
	Sun, 24 Aug 2025 03:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756007216; cv=none; b=tdzBcsamlTcZKQ0tXwA1IhxWZyhyDTHPPRWD1UB3PolJLFvHg9bxjcLZzr9JOT8JegNWacfyOjSpgv8m9zGqzKvwrnMHV8mkn6evH3Zk9pAyyBWt6pSjFllTru51wNxpyB1367gDGZv07wo4004k6c/BPQPGy+G/1G+PC/NoJ3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756007216; c=relaxed/simple;
	bh=7NsPVMCHW3b1Vx15r4yqFlAmzigDPRtxfr7zQWHon4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rt2fDL9bZsaVnhGOxUe+6kMFwINdY1wIAONG2SYbDNL+b9LZyL1ljXmQZJqSoO46b2Znl980vvKDilLvVJ9MT0Fp6yzE2//7V7NSuFuk/pZntqe9XfaHVc41QFdyozWluWFJFAwgvMJ3ugaCwgUSr+8mWBj7XJtqs4aGI19MIUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz1t1756007191t87afa447
X-QQ-Originating-IP: /b8F4qOljSL63w5YWiSnO2EBsVqZrdgslmlJy0HvWsc=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 24 Aug 2025 11:46:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7436797028166713783
Date: Sun, 24 Aug 2025 11:46:29 +0800
From: Yibo Dong <dong100@mucse.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
	gustavoars@kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v7 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <54BB0DB525AEF5A4+20250824034629.GA2000422@nic-Precision-5820-Tower>
References: <20250822023453.1910972-1-dong100@mucse.com>
 <20250822023453.1910972-5-dong100@mucse.com>
 <29475ad1-125a-4b20-bff3-0a61b347985e@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29475ad1-125a-4b20-bff3-0a61b347985e@linux.dev>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Of2cEohDBRJBH64LpPw2uMtTV8uIswhxUwG9uC4k2NVVJrtA76Vw9ASO
	7XWSuVP169u/9LAZ6m93zcSo4oBb/o/IOJ1OXIpPV7JlRwwyIixkv/zw5Acfj1qtnjiK4iC
	foHJGn55c/YEwllWmM5OOXWXTyvX155EAZfDUdfyFb98LmphFtTCLit4xVytryjTAIg0wdl
	Uuhb2VH/1EEQ03vszhLS0LuTcakyN8ARTUIpUbdgR0Im9Gi2VjeaXswmJLcJ6J37i7xjdL8
	woU2dQgUZ0wtvHTB4Hh808ciEv417kVJjLubBNklibO0hWrCSOxUE3bvCyJs9lGo7AB0Qdh
	RBfwQJHY2mhSW9UksEJHsP6evwAc6A2Azt3S2cNsBLZLNvYehC7ydVcAWeTQoFibgoHaMAB
	nVQ5lDY/vBvfdNhVK2BIQSthBpDwgwA9tPAOdY0sMoVPPu9EqVrGpNWrMD7hOjW5pjK7XI8
	6vineOtZS6omOkNsyUmlmt2LZeUW/Ay5FDTbfvU+4bfsgSGlX3l2ozPOyBp82LBuQWFv4w7
	SsfXp7/uwipWCFlWQLKq+tt+I8YEdE0liEq1jlyvBxx3KzCmP442fYx+BuBbJPmuPMCRYYE
	3Dv2FQD1EPVAf/FsaxZMynaJYr5uufukXF4j0LXTT5ycYLOsfMoMjm6hYIBgLsbh4TQrcxi
	+ULm+Y5z/kHcjIye0DY51D3HyvYwbC0Jko6Dmna9/9dy3JDVVvGDkdqOT5t9+KijHLEiJin
	12v4StUuA39Q0YKjdilUwlY1Ky1lLWDCnLOTKoV07Sf5Gp8/wZD3VEBLK4zx8qKpUtVXAN4
	f19C7PGXy6KdTFPcuh3gIwKqgaI6Oh1EmLC5xt4w+kWQTdWDUWRkEyn1c5cWlJFjDK8wBe2
	Vgxwu4nk2BPirZCDnuGjgGsv88xwxjOGILdt3s1iORgrYRdzFFG+vIBmt9k/Og/Z+ps3vGY
	lQ9CGqkHUM22kMZqeMlF1yljIyhHS/jKxj/IKzGKY724UOqCPW6qM7DKpmr+TpwRkmLIpIU
	VJFcA+DnLFLa4YQSJDWVg2vJUKh0nPKjl3k9ZeQw==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Sat, Aug 23, 2025 at 04:02:29PM +0100, Vadim Fedorenko wrote:
> On 22/08/2025 03:34, Dong Yibo wrote:
> > Initialize basic mbx_fw ops, such as get_capability, reset phy
> > and so on.
> > 
> > Signed-off-by: Dong Yibo <dong100@mucse.com>
> 
> [...]
> 
> > +/**
> > + * mucse_mbx_fw_post_req - Posts a mbx req to firmware and wait reply
> > + * @hw: pointer to the HW structure
> > + * @req: pointer to the cmd req structure
> > + * @cookie: pointer to the req cookie
> > + *
> > + * mucse_mbx_fw_post_req posts a mbx req to firmware and wait for the
> > + * reply. cookie->wait will be set in irq handler.
> > + *
> > + * @return: 0 on success, negative on failure
> > + **/
> > +static int mucse_mbx_fw_post_req(struct mucse_hw *hw,
> > +				 struct mbx_fw_cmd_req *req,
> > +				 struct mbx_req_cookie *cookie)
> > +{
> > +	int len = le16_to_cpu(req->datalen);
> > +	int err;
> > +
> > +	cookie->errcode = 0;
> > +	cookie->done = 0;
> > +	init_waitqueue_head(&cookie->wait);
> > +	err = mutex_lock_interruptible(&hw->mbx.lock);
> > +	if (err)
> > +		return err;
> > +	err = mucse_write_mbx_pf(hw, (u32 *)req, len);
> > +	if (err)
> > +		goto out;
> > +	/* if write succeeds, we must wait for firmware response or
> > +	 * timeout to avoid using the already freed cookie->wait
> > +	 */
> > +	err = wait_event_timeout(cookie->wait,
> > +				 cookie->done == 1,
> > +				 cookie->timeout_jiffies);
> > +
> > +	if (!err)
> > +		err = -ETIMEDOUT;
> > +	else
> > +		err = 0;
> > +	if (!err && cookie->errcode)
> > +		err = cookie->errcode;
> 
> can cookie->errcode be non 0 if FW times out?
> 

cookie is alloced by kzalloc, if fw timeout, nochange for it.
So cookie->errcode is 0 if FW times out.

> 
> looks like this can be simplified to
> 
> if(!wait_event_timeout())
>   err = -ETIMEDOUT
> else
>   err = cookie->errcode
> 

Got it, I will update it.

> > +out:
> > +	mutex_unlock(&hw->mbx.lock);
> > +	return err;
> > +}
> > +
> > +/**
> > + * build_ifinsmod - build req with insmod opcode
> > + * @req: pointer to the cmd req structure
> > + * @status: true for insmod, false for rmmod
> 
> naming is misleading here, I believe.. no strong feeling, but
> is_insmod might be better
> 

I see, I will fix it.

> > + **/
> > +static void build_ifinsmod(struct mbx_fw_cmd_req *req,
> > +			   int status)
> > +{
> > +	req->flags = 0;
> > +	req->opcode = cpu_to_le16(DRIVER_INSMOD);
> > +	req->datalen = cpu_to_le16(sizeof(req->ifinsmod) +
> > +				   MBX_REQ_HDR_LEN);
> > +	req->cookie = NULL;
> > +	req->reply_lo = 0;
> > +	req->reply_hi = 0;
> > +#define FIXED_VERSION 0xFFFFFFFF
> > +	req->ifinsmod.version = cpu_to_le32(FIXED_VERSION);
> > +	req->ifinsmod.status = cpu_to_le32(status);
> > +}
> > +
> > +/**
> > + * mucse_mbx_ifinsmod - Echo driver insmod status to hw
> > + * @hw: pointer to the HW structure
> > + * @status: true for insmod, false for rmmod
> 
> here as well
> 

Got it.

> > + *
> > + * @return: 0 on success, negative on failure
> > + **/
> > +int mucse_mbx_ifinsmod(struct mucse_hw *hw, int status)
> > +{
> > +	struct mbx_fw_cmd_req req = {};
> > +	int len;
> > +	int err;
> > +
> > +	build_ifinsmod(&req, status);
> > +	len = le16_to_cpu(req.datalen);
> > +	err = mutex_lock_interruptible(&hw->mbx.lock);
> > +	if (err)
> > +		return err;
> > +
> > +	if (status) {
> > +		err = mucse_write_posted_mbx(hw, (u32 *)&req,
> > +					     len);
> > +	} else {
> > +		err = mucse_write_mbx_pf(hw, (u32 *)&req,
> > +					 len);
> > +	}
> > +
> > +	mutex_unlock(&hw->mbx.lock);
> > +	return err;
> > +}
> 

Thanks for your feedback.


