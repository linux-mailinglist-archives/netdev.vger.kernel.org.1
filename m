Return-Path: <netdev+bounces-219793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 339A1B4301F
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 04:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBE067B6049
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 02:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7551FF5F9;
	Thu,  4 Sep 2025 02:58:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C23B134A8;
	Thu,  4 Sep 2025 02:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756954703; cv=none; b=IywcqbwG+EEo2Co3jJ9z4heA9h4i2AnHKuvhZmT7BeuqX3dAveCKoL4j1p0i5GfCmiFikWBkWaeBub9RgXMDrLQDULAsx6B59rPe2ZVpf9CPOWcIh7G7WCURzljT39uqQ31HUENe9aUCClWHkO64IwITF+iiUR4w8ITXmJ8SLZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756954703; c=relaxed/simple;
	bh=FUEkYJc6NdbKu1rKgI3c9qCXQ7OfRng1lSOl3N8E6qI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uN6f55H5UZfFnQ9EHHIwNXhupsPYn8tTWNCTzuFTo2gJjLylUhIyOj94keMaDcGYN048L+NODrpsFzltQWy1/UrFumzas82QBDXIuLsJ1lnzTHeGpMbvsCY6zuqUleFLjXFFjes0ME2MWk0nW6nIUmUL2C0osb2uLL6uXkcYfCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz12t1756954674te0fcd5a6
X-QQ-Originating-IP: PSxW2zZi0XfpxwxiMjuQj95SLM6jCK8N+GfEA2KUwtk=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 04 Sep 2025 10:57:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6255393548708386954
Date: Thu, 4 Sep 2025 10:57:52 +0800
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
Subject: Re: [PATCH net-next v10 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <79CDF6C59BAFF4D1+20250904025752.GC1015062@nic-Precision-5820-Tower>
References: <20250903025430.864836-1-dong100@mucse.com>
 <20250903025430.864836-5-dong100@mucse.com>
 <19ca3e80-97f7-428a-bf09-f713706fd6ab@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19ca3e80-97f7-428a-bf09-f713706fd6ab@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Mh6c5BvFpJVghEK39H3amGAj505Q9pOyjCdm5g3fsQc60UDuei5rskL1
	87C+hh55KluMs46iNz+Drj3THzdiqg3OANI8DCPenvB+cmEW0UsUhaQq1NSC6jN1Z3AdDAF
	feoW7yuKK5XpPQXBmVVyQ18yzIrahPQRT4E09W0E/ew3EKQhHtbPUHfb29HEoRAKQYpIuU+
	djykYAyZnk/6zyD5UnUWWmTtiHBvT0ZFyxVTqQQiDUAz6UnJ4HJtdoBExaI4XEq731P+HGQ
	YgQukfISiJT7C8+VR6QeFAk1P5NcxEE9/HccxVBkKG7yPE7WM1zGtWxopYqL/XOYwLCuSJl
	713WEv074MQ1RJjTLsYEp/d/x8LBwHtyLU7BLzrlnMRivzAcMO7rjuTfLCmKzj35SwLK5qM
	aInTPyPT5y0wmRziv/7mEHPtb/FXiAquhmXNYbLuT+bLCLBlLS5M2Ltsf2GcjMUoHbtYJcN
	cN2CaFpD6NB3bcl7vUJ/8qD8VlGdj8k3gNvSPX8wGgfBVDnEJUMI7PZsHgOQ9gdQ5cZLJ/h
	Q2QXdMbKw1WKbXARsF+7rq04XSJljd7mv2dl/ZIKKWr2W77NOkHTgNSNQkYazLDc4IrP6Hq
	93V/0x25obspdSVx4ZrBl8WTsETleJbOk6ZBZYUNFnYfZEFfd9Nnz1WZ6EfIifOf+q9BZUe
	aoHeVIz9Ky1EfQ0Mdkui+OVAKPiSh8OOKQUPLO2pVIYqZcATHvIC4dtm43Hjwv1b0Y6eDqx
	FyMRSALs2jjWVym4grJtNyP69f+9fRUmTLEF2FqyTfphr8JZLBvO4g1ixQfrn9kUrkkmr6f
	nB/nA6Y0dKEG2bWpuCtvnHxlnxFH9y8d+WiFE7jRfCXXkupYgXeCHSb8SQrZi8XyJ/e+nkm
	xHxx7agjfCjmDTvWM7FwDJ2MUHuVancjRmdfLW1X7xzB02Dwz7Tq7S1wCeEaBqqiRJJ6d6l
	lOEFrN8nQuCwNwTPaAj/e3LdRcz6wK4DGvHU4acCnHpYQFVPrZDbiWm1jzeqKwx24J381Uq
	4G6B1j45JoLEDxBHPyZRbojZbz5Y1QTPNQtLm6diuZYc7BcBkVllfRAlOWkU2pj3+5qXYj1
	PDTf5BqIGZpGtKFIcYy2CAJ/0bZN/UasQb3nkG9TZAd
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

On Thu, Sep 04, 2025 at 12:45:43AM +0200, Andrew Lunn wrote:
> > +/**
> > + * mucse_mbx_powerup - Echo fw to powerup
> > + * @hw: pointer to the HW structure
> > + * @is_powerup: true for powerup, false for powerdown
> > + *
> > + * mucse_mbx_powerup echo fw to change working frequency
> > + * to normal after received true, and reduce working frequency
> > + * if false.
> > + *
> > + * Return: 0 on success, negative errno on failure
> > + **/
> > +int mucse_mbx_powerup(struct mucse_hw *hw, bool is_powerup)
> > +{
> > +	struct mbx_fw_cmd_req req = {};
> > +	int len;
> > +	int err;
> > +
> > +	build_powerup(&req, is_powerup);
> > +	len = le16_to_cpu(req.datalen);
> > +	mutex_lock(&hw->mbx.lock);
> > +
> > +	if (is_powerup) {
> > +		err = mucse_write_posted_mbx(hw, (u32 *)&req,
> > +					     len);
> > +	} else {
> > +		err = mucse_write_mbx_pf(hw, (u32 *)&req,
> > +					 len);
> > +	}
> 
> It looks odd that this is asymmetric. Why is a different low level
> function used between power up and power down?
> 
> > +int mucse_mbx_reset_hw(struct mucse_hw *hw)
> > +{
> > +	struct mbx_fw_cmd_reply reply = {};
> > +	struct mbx_fw_cmd_req req = {};
> > +
> > +	build_reset_hw_req(&req);
> > +	return mucse_fw_send_cmd_wait(hw, &req, &reply);
> > +}
> 
> And this uses a third low level API different to power up and power
> down?
> 
> 	Andrew
> 

There are 3 APIs, they has some different ....
1. mucse_write_mbx_pf just sends mbx.
/**
 * mucse_write_mbx_pf - Place a message in the mailbox
 * @hw: pointer to the HW structure
 * @msg: the message buffer
 * @size: length of buffer
 *
 */

2. mucse_write_posted_mbx sends mbx and wait fw read out.
/**
 * mucse_write_posted_mbx - Write a message to the mailbox, wait for ack
 * @hw: pointer to the HW structure
 * @msg: the message buffer
 * @size: length of buffer
 */
powerdown is called when driver is removed, nothing to do with fw later,
no need to wait fw's ack.
Of course, it can use mucse_write_posted_mbx to wait when
powerdown if you want me to do it?

3. mucse_fw_send_cmd_wait sends mbx, wait fw read out, and wait for
response.
/**
 * mucse_fw_send_cmd_wait - Send cmd req and wait for response
 * @hw: pointer to the HW structure
 * @req: pointer to the cmd req structure
 * @reply: pointer to the fw reply structure
 */

 Thanks for feedback.


