Return-Path: <netdev+bounces-204490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91867AFAD51
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 09:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E77A716681D
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 07:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C229D27B4E8;
	Mon,  7 Jul 2025 07:39:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.62.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE111E5B88;
	Mon,  7 Jul 2025 07:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.62.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751873977; cv=none; b=EgSyf15KDSfYIelH+g/zV/sc3cV9N3bFFoMlXxmSrtMYOEcOizQ09shACfBVhP5fPLCeJBdELqpqvUvqIrDYD2NM4D6273sDAQLZKm0H1S+6BauWjW1EXTFl5qGtAv6Wr9KfDZ2Oh8Z2AQqqE3kzQNCfLHsb4Wm+UK8+FWPOBMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751873977; c=relaxed/simple;
	bh=itVQ6V0Mr9OovVSe2MWKuCPuJjDkX6YRyGMqSSgLTOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fa19oG0O1RVJcZi227x1Vbdo/dw/RmKyLFEyDK6p3N0gg7SPBCAD8mGkM8xaRnrtqA5DarqoFwML9vyn6u/ZFr7YJzFmXFmMLqrXFrSh5oUEtyeE/NhOLKmQd19MqNYxd7nkm6oCFspFTbCEqYQeqSF+C2/9lrvCXxq05Up6r9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=114.132.62.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz7t1751873865tf5aee820
X-QQ-Originating-IP: mJw/heq6b2Ta6GtlIIN+F3vmI3qSS3RNqcxng9NIU/M=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 07 Jul 2025 15:37:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3322818785866076011
Date: Mon, 7 Jul 2025 15:37:43 +0800
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
Message-ID: <CB185D75E8EDC84A+20250707073743.GA164527@nic-Precision-5820-Tower>
References: <20250703014859.210110-1-dong100@mucse.com>
 <20250703014859.210110-5-dong100@mucse.com>
 <57497e14-3f9a-4da8-9892-ed794aadbf47@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57497e14-3f9a-4da8-9892-ed794aadbf47@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Nc4Sv39/e83Wv/xSPCBI764BfkQBkT4hm9ezADdd7z/A2YTleb4RHIdg
	X6CL3Xr8IsxwzEwNlqkt+2PM/L7tdj7omGDntaKG4PGMcYtYGAdxolutctGPTY4cDgbwjto
	uN1cYczd8CIiri6UCfAdXOxjtggxEfnoHW0KJgPpbPmAEo2jwkNXNC7kvMOGUP8tyZ8xdVy
	AOO8WFGJof2vSX+Msy/OcsP4F7dbaT0CMUOffiPgH0OzaHn2JusoWh/bH0JdGsxhvxiBCiz
	Z1y+Bgtp/Zio9ppkib3X3iageHfK+etYLMwDdPnO2AY4pIIoc1hEd+sG8EldLT6H7swlnr8
	mltF1PmFD5RCjVXFPc0yuzuRPBCeCUMdkL94jtFr0hYpZi3N+JLHpJq78OBelnJaRdBo8cP
	tw7OgQaSv4HvrjqgzTPTh0mBlfGoBcgpKd93ItcbgXlFM/HrrNfFhu/6tgIz2caykgH0Wzx
	7YUjx/0GSy73zNM8mBAROngRplUKDPLaG7PT3K10uPdOuh10s2C7J8EqT6uv8X7zLQWjtwB
	a/3aRBTXhNKOhWANHug3puXbTyMDEi/+KCWSfl01IV7w1xWyX0c3j+0wa77IIEBSSD2BhfT
	yHJ8KO4yelDhwb9SRas6pf/nS6M5mG6Ktpnb9Pm+8EMVxFi7RygSgD12SIkuseGFTYeLC0y
	S/FpN5AwRlVoMY49IvMzerRc5x0Gm5ofdFMEsBu1lRF+5dg4pHt9vltW8zNTHuqGnWGSAHm
	8aqCT/obbwKJvEvW4uzh6Ivwx4AErVu/FV+hzxpA0z9AgNtOrXGFfET3l6OOknTrtdh2X8P
	0dF6JWn004Mz3jWydAomGKzY1ynVBdIp4eVjN303P+Tc+g8lXASgQRT5hA0tWSTFrIj52Sv
	mymuDIrHW6pUPKbfc0uBodRH2fNszFzdpLYwfMfqToff/HoGUcrCSOAv20u2VxT3AaHrF7A
	xSqmTwEp8D/2Sc6cgwE0cOOyaXcId2TUMmnEbETRszNoAnoGv/TlB8XSB
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

On Fri, Jul 04, 2025 at 08:25:12PM +0200, Andrew Lunn wrote:
> > +/**
> > + * mucse_fw_send_cmd_wait - Send cmd req and wait for response
> > + * @hw: Pointer to the HW structure
> > + * @req: Pointer to the cmd req structure
> > + * @reply: Pointer to the fw reply structure
> > + *
> > + * mucse_fw_send_cmd_wait sends req to pf-cm3 mailbox and wait
> > + * reply from fw.
> > + *
> > + * Returns 0 on success, negative on failure
> > + **/
> > +static int mucse_fw_send_cmd_wait(struct mucse_hw *hw,
> > +				  struct mbx_fw_cmd_req *req,
> > +				  struct mbx_fw_cmd_reply *reply)
> > +{
> > +	int err;
> > +	int retry_cnt = 3;
> > +
> > +	if (!hw || !req || !reply || !hw->mbx.ops.read_posted)
> 
> Can this happen?
> 
> If this is not supposed to happen, it is better the driver opps, so
> you get a stack trace and find where the driver is broken.
> 
Yes, it is not supposed to happen. So, you means I should remove this
check in order to get opps when this condition happen?
> > +		return -EINVAL;
> > +
> > +	/* if pcie off, nothing todo */
> > +	if (pci_channel_offline(hw->pdev))
> > +		return -EIO;
> 
> What can cause it to go offline? Is this to do with PCIe hotplug?
> 
Yes, I try to get a PCIe hotplug condition by 'pci_channel_offline'.
If that happens, driver should never do bar-read/bar-write, so return
here.
> > +
> > +	if (mutex_lock_interruptible(&hw->mbx.lock))
> > +		return -EAGAIN;
> 
> mutex_lock_interruptable() returns -EINTR, which is what you should
> return, not -EAGAIN.
> 
Got it, I should return '-EINTR' here.
> > +
> > +	err = hw->mbx.ops.write_posted(hw, (u32 *)req,
> > +				       L_WD(req->datalen + MBX_REQ_HDR_LEN),
> > +				       MBX_FW);
> > +	if (err) {
> > +		mutex_unlock(&hw->mbx.lock);
> > +		return err;
> > +	}
> > +
> > +retry:
> > +	retry_cnt--;
> > +	if (retry_cnt < 0)
> > +		return -EIO;
> > +
> > +	err = hw->mbx.ops.read_posted(hw, (u32 *)reply,
> > +				      L_WD(sizeof(*reply)),
> > +				      MBX_FW);
> > +	if (err) {
> > +		mutex_unlock(&hw->mbx.lock);
> > +		return err;
> > +	}
> > +
> > +	if (reply->opcode != req->opcode)
> > +		goto retry;
> > +
> > +	mutex_unlock(&hw->mbx.lock);
> > +
> > +	if (reply->error_code)
> > +		return -reply->error_code;
> 
> The mbox is using linux error codes? 
> 
It is used only between driver and fw, yay be just samply like this: 
0     -- no error
not 0 -- error
So, it is not using linux error codes.
> > +#define FLAGS_DD BIT(0) /* driver clear 0, FW must set 1 */
> > +/* driver clear 0, FW must set only if it reporting an error */
> > +#define FLAGS_ERR BIT(2)
> > +
> > +/* req is little endian. bigendian should be conserened */
> > +struct mbx_fw_cmd_req {
> > +	u16 flags; /* 0-1 */
> > +	u16 opcode; /* 2-3 enum GENERIC_CMD */
> > +	u16 datalen; /* 4-5 */
> > +	u16 ret_value; /* 6-7 */
> 
> If this is little endian, please use __le16, __le32 etc, so that the
> static analysers will tell you if you are missing cpu_to_le32 etc.
> 
> 	Andrew
> 
Got it, I will fix it.

Thanks for your feedback.

