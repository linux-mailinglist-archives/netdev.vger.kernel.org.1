Return-Path: <netdev+bounces-158778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAE0A13379
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 07:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F763166E84
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 06:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A746D19DF9A;
	Thu, 16 Jan 2025 06:58:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFF3156F3C
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 06:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737010731; cv=none; b=M1GXlzZR3sgcE/OyOfEvcdIvsJSZW6260YSbgrILCASs+Xz15kINGuI1J0ZpNNxS3AgxRqfe/kxA/IAbZ9ScYQG+vNNqps6QdYCw4kXIrHfC6/H3nFjD+t80jFp5IXRBdviC9wkeqVPLkIdZBnWxfueHCqjPMlU57o6asnXhx64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737010731; c=relaxed/simple;
	bh=+YRDea7Ii9PrFZNOygXnjaoHOhSy1VpS/WnsZtT32sg=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=NtBsbtENyyY4SahhwdYOfmmVJxHJKfNI5ko29QVsmgrhTLy8w0LxXSV4deyg82f81s42x0mW0qbSwYRQtf7M4gf5jzIb+R2JCnm+jvLQwpUgeA+N3xHP7bIpyorEeL5ak/HoyfAWnx8GPEfwHJQKMvLJIx5WJWeENRdlaRD2OKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas5t1737010622t324t38536
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.24.187.167])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 3979780559288719152
To: "'Simon Horman'" <horms@kernel.org>
Cc: <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<linux@armlinux.org.uk>,
	<netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>
References: <20250115102408.2225055-1-jiawenwu@trustnetic.com> <20250115152950.GO5497@kernel.org>
In-Reply-To: <20250115152950.GO5497@kernel.org>
Subject: RE: [PATCH net-next v3 1/2] net: txgbe: Add basic support for new AML devices
Date: Thu, 16 Jan 2025 14:57:01 +0800
Message-ID: <067201db67e3$d7e88aa0$87b99fe0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQJm9lagLf8/PoRds90UQkL38VDXjQG0eFMisfQ2flA=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NzOHSugmTg7X2k+6OIgFKwyQnxva2YbiAFKOVn3c6HIbJ+ZeyE8lfwFS
	n82vzsZV36S/tzD9Bm+MO6Q4glQ1WA4XXw4nH4LG8EeG6fsNkh+msSrf3J60M215NKgxpsY
	lB17ngDsWXlfAbS2+gByzmp3yPSxVhCX/MMwKxoCXWOb1BcAduq60XmVzrOFpmLda45vFui
	kmF+FVCXFySJS0ly4sFLOyo1CASBMeWZZJmRN5rWHFuXO9m7qcJHo4TXAi2ftmdcsL14lFs
	2dBI0bDxOT/8zHvq47qwexNXQD0WL78kAg7hOPrZT6wvqN2lIc/GNFd3K8sbBtQcYAiNBr3
	xnORro+KPSBdospJXc8XvtVhnx9sF4cqE+3ZvTJ+xUEpqD1NHtuaoLsU4WDc3AEiPnC9pmU
	ra7BP8ajjCeSvX119UnoLE94Ri5DNJ73cYFslgbDPWMLbaBSlfBL1TbcWzLSDdUBQkyR10i
	iIiNXkFjep71j3ZzYKuyzqAk9N8sXyffPgyLA/y+A0aKNdLD4fuI2D0sAVrQwyhY7vZT1//
	Q8rohOQaonb1BY6yi9N9+aqny3GYjUIZzdWXwfulmzazIzKO6LyepFs7lHchKtZUlxmd7vQ
	C0qJd9OpIbdVGOOjkgiwTXB1/aDgJhHAE+ON3rCwYRb4OsD70InSUKEDQRJpgMtWM/hI9jt
	lI+aVdewJX8/kjjrMQeH8HHY/J95Q7OR06IaNdlge++3W/1PrGqWknH+9LoC+LeKU+70vAC
	AiaO9sMNYI7YWhAppNMDKdb6wyOXyTf/QBpxVgslDAEa+LvK/4xEzqyKfOtGKPaCxnIsCqX
	NBaiztzL20NFyMKpHgAOvBUP6RIjTqIJzwf8SMwX9WXqK//CJyokoMq88ZE/lK/azeDCLY0
	TddNCb4AH0HMOGfqpF3OWOpd/beMYHLZTYqm6WWdSafJYdSIiwlUJkGAfPehW0LrwaHTL7Y
	eiGiUaeFuo3S1bcxKg1oULxaKIHl9zqIk3CFm29X34OjYf9zJ9dVAotcYjmIMxv+812fBOE
	ZO2Zd69g==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Wed, Jan 15, 2025 11:30 PM, Simon Horman wrote:
> On Wed, Jan 15, 2025 at 06:24:07PM +0800, Jiawen Wu wrote:
> > There is a new 40/25/10 Gigabit Ethernet device.
> >
> > To support basic functions, PHYLINK is temporarily skipped as it is
> > intended to implement these configurations in the firmware. And the
> > associated link IRQ is also skipped.
> >
> > And Implement the new SW-FW interaction interface, which use 64 Byte
> > message buffer.
> >
> > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> 
> ...
> 
> > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> 
> ...
> 
> > +static bool wx_poll_fw_reply(struct wx *wx, u32 *buffer,
> > +			     struct wx_hic_hdr *recv_hdr, u8 send_cmd)
> > +{
> > +	u32 dword_len = sizeof(struct wx_hic_hdr) >> 2;
> > +	u32 i;
> > +
> > +	/* read hdr */
> > +	for (i = 0; i < dword_len; i++) {
> > +		buffer[i] = rd32a(wx, WX_FW2SW_MBOX, i);
> > +		le32_to_cpus(&buffer[i]);
> > +	}
> > +
> > +	/* check hdr */
> > +	recv_hdr = (struct wx_hic_hdr *)buffer;
> > +	if (recv_hdr->cmd == send_cmd &&
> > +	    recv_hdr->index == wx->swfw_index)
> > +		return true;
> 
> Hi Jiawen Wu,
> 
> Maybe I am misreading this but, given the way that recv_hdr is
> passed to this function, it seems that the same result would
> he achieved if recv_hdr was a local variable...

Oooh, you are right, I'm too careless.

> 
> > +
> > +	return false;
> > +}
> > +
> > +static int wx_host_interface_command_r(struct wx *wx, u32 *buffer,
> > +				       u32 length, u32 timeout, bool return_data)
> > +{
> > +	struct wx_hic_hdr *send_hdr = (struct wx_hic_hdr *)buffer;
> > +	u32 hdr_size = sizeof(struct wx_hic_hdr);
> > +	struct wx_hic_hdr *recv_hdr;
> > +	bool busy, reply;
> > +	u32 dword_len;
> > +	u16 buf_len;
> > +	int err = 0;
> > +	u8 send_cmd;
> > +	u32 i;
> > +
> > +	/* wait to get lock */
> > +	might_sleep();
> > +	err = read_poll_timeout(test_and_set_bit, busy, !busy, 1000, timeout * 1000,
> > +				false, WX_STATE_SWFW_BUSY, wx->state);
> > +	if (err)
> > +		return err;
> > +
> > +	/* index to unique seq id for each mbox message */
> > +	send_hdr->index = wx->swfw_index;
> > +	send_cmd = send_hdr->cmd;
> > +
> > +	dword_len = length >> 2;
> > +	/* write data to SW-FW mbox array */
> > +	for (i = 0; i < dword_len; i++) {
> > +		wr32a(wx, WX_SW2FW_MBOX, i, (__force u32)cpu_to_le32(buffer[i]));
> > +		/* write flush */
> > +		rd32a(wx, WX_SW2FW_MBOX, i);
> > +	}
> > +
> > +	/* generate interrupt to notify FW */
> > +	wr32m(wx, WX_SW2FW_MBOX_CMD, WX_SW2FW_MBOX_CMD_VLD, 0);
> > +	wr32m(wx, WX_SW2FW_MBOX_CMD, WX_SW2FW_MBOX_CMD_VLD, WX_SW2FW_MBOX_CMD_VLD);
> > +
> > +	/* polling reply from FW */
> > +	err = read_poll_timeout(wx_poll_fw_reply, reply, reply, 1000, 50000,
> > +				true, wx, buffer, recv_hdr, send_cmd);
> > +	if (err) {
> > +		wx_err(wx, "Polling from FW messages timeout, cmd: 0x%x, index: %d\n",
> > +		       send_cmd, wx->swfw_index);
> > +		goto rel_out;
> > +	}
> > +
> > +	/* expect no reply from FW then return */
> > +	if (!return_data)
> > +		goto rel_out;
> > +
> > +	/* If there is any thing in data position pull it in */
> > +	buf_len = recv_hdr->buf_len;
> 
> ... and most likely related, recv_hdr appears to be uninitialised here.
> 
> This part is flagged by W=1 builds with clang-19, and my Smatch.
> 
> > +	if (buf_len == 0)
> > +		goto rel_out;
> > +
> > +	if (length < buf_len + hdr_size) {
> > +		wx_err(wx, "Buffer not large enough for reply message.\n");
> > +		err = -EFAULT;
> > +		goto rel_out;
> > +	}
> > +
> > +	/* Calculate length in DWORDs, add 3 for odd lengths */
> > +	dword_len = (buf_len + 3) >> 2;
> > +	for (i = hdr_size >> 2; i <= dword_len; i++) {
> > +		buffer[i] = rd32a(wx, WX_FW2SW_MBOX, i);
> > +		le32_to_cpus(&buffer[i]);
> > +	}
> > +
> > +rel_out:
> > +	/* index++, index replace wx_hic_hdr.checksum */
> > +	if (send_hdr->index == WX_HIC_HDR_INDEX_MAX)
> > +		wx->swfw_index = 0;
> > +	else
> > +		wx->swfw_index = send_hdr->index + 1;
> > +
> > +	clear_bit(WX_STATE_SWFW_BUSY, wx->state);
> > +	return err;
> > +}
> 
> ...
> 


