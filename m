Return-Path: <netdev+bounces-158556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 407FBA12771
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 16:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63795162641
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 15:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61994144304;
	Wed, 15 Jan 2025 15:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/8ApA+w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E30B1514F6
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736954995; cv=none; b=RrlI8nfReagWZlvwwT6k5vridD0tbi9yVkxCiQMglp0KhrzRuTKtVLDloMU3Za9ykNh2joVFKT/udnydPyE8Bcbi7YC95fWyYzZBCJ6q1Ls69HWwY/hSLVsyxY8heW2GAjW6koSVKihBxH731k0lNOloXOJh+G3AvnfAMdx+5oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736954995; c=relaxed/simple;
	bh=dvCKF1yfIjbcxWxfj+dDO8xQmJ6jPPh6U/Msz3gPCQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2ihz8Wzz83l/Z+zSHLx/tJUXoi9wB99OTyi/Ni3sb+xqr3/tY1OP1jz6aKt8P7DM1uHBnBkds3+0oIQdBmAx+GqEG6F9k7X4PPJlcYkJIKpdXsIms1lzCP8RW/3m4fKoeHT/qeNdIDQya4d1JQjwHfIPyK91tZbsKj0dQROmWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/8ApA+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3D2C4AF09;
	Wed, 15 Jan 2025 15:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736954994;
	bh=dvCKF1yfIjbcxWxfj+dDO8xQmJ6jPPh6U/Msz3gPCQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i/8ApA+w7Yx+7j1h+/280+106TnwjiHidjw7YGvnRQGhFfQsAps6Pndj8xKpL3MzW
	 Zk4RwAGqyWrgwZ4MKpV0WeArzfvfwIMvY4+IXxRxyfg6hvbBfWMoqITcFrYxLnYIkA
	 TRvq8AKb9s0AEeGjmJ8qDVsTBsEdoCgM84A6KiBWWHNDPzaG2GojTRhYFk4ItL8Qsb
	 6S2Pebw+6f1NkqskttaJkxswfleb+Vz8DlTpsf2TJwBhpF91ySVDwTKLZvosUmQVsF
	 TsKki9zco4z2PSpaeawDZni7TVdJUqAsBdVOSRIHyzqz+XQn4ENEyliPHrrGYzPBi3
	 Qpes9q32zY1XQ==
Date: Wed, 15 Jan 2025 15:29:50 +0000
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	netdev@vger.kernel.org, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v3 1/2] net: txgbe: Add basic support for new
 AML devices
Message-ID: <20250115152950.GO5497@kernel.org>
References: <20250115102408.2225055-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115102408.2225055-1-jiawenwu@trustnetic.com>

On Wed, Jan 15, 2025 at 06:24:07PM +0800, Jiawen Wu wrote:
> There is a new 40/25/10 Gigabit Ethernet device.
> 
> To support basic functions, PHYLINK is temporarily skipped as it is
> intended to implement these configurations in the firmware. And the
> associated link IRQ is also skipped.
> 
> And Implement the new SW-FW interaction interface, which use 64 Byte
> message buffer.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

...

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c

...

> +static bool wx_poll_fw_reply(struct wx *wx, u32 *buffer,
> +			     struct wx_hic_hdr *recv_hdr, u8 send_cmd)
> +{
> +	u32 dword_len = sizeof(struct wx_hic_hdr) >> 2;
> +	u32 i;
> +
> +	/* read hdr */
> +	for (i = 0; i < dword_len; i++) {
> +		buffer[i] = rd32a(wx, WX_FW2SW_MBOX, i);
> +		le32_to_cpus(&buffer[i]);
> +	}
> +
> +	/* check hdr */
> +	recv_hdr = (struct wx_hic_hdr *)buffer;
> +	if (recv_hdr->cmd == send_cmd &&
> +	    recv_hdr->index == wx->swfw_index)
> +		return true;

Hi Jiawen Wu,

Maybe I am misreading this but, given the way that recv_hdr is
passed to this function, it seems that the same result would
he achieved if recv_hdr was a local variable...

> +
> +	return false;
> +}
> +
> +static int wx_host_interface_command_r(struct wx *wx, u32 *buffer,
> +				       u32 length, u32 timeout, bool return_data)
> +{
> +	struct wx_hic_hdr *send_hdr = (struct wx_hic_hdr *)buffer;
> +	u32 hdr_size = sizeof(struct wx_hic_hdr);
> +	struct wx_hic_hdr *recv_hdr;
> +	bool busy, reply;
> +	u32 dword_len;
> +	u16 buf_len;
> +	int err = 0;
> +	u8 send_cmd;
> +	u32 i;
> +
> +	/* wait to get lock */
> +	might_sleep();
> +	err = read_poll_timeout(test_and_set_bit, busy, !busy, 1000, timeout * 1000,
> +				false, WX_STATE_SWFW_BUSY, wx->state);
> +	if (err)
> +		return err;
> +
> +	/* index to unique seq id for each mbox message */
> +	send_hdr->index = wx->swfw_index;
> +	send_cmd = send_hdr->cmd;
> +
> +	dword_len = length >> 2;
> +	/* write data to SW-FW mbox array */
> +	for (i = 0; i < dword_len; i++) {
> +		wr32a(wx, WX_SW2FW_MBOX, i, (__force u32)cpu_to_le32(buffer[i]));
> +		/* write flush */
> +		rd32a(wx, WX_SW2FW_MBOX, i);
> +	}
> +
> +	/* generate interrupt to notify FW */
> +	wr32m(wx, WX_SW2FW_MBOX_CMD, WX_SW2FW_MBOX_CMD_VLD, 0);
> +	wr32m(wx, WX_SW2FW_MBOX_CMD, WX_SW2FW_MBOX_CMD_VLD, WX_SW2FW_MBOX_CMD_VLD);
> +
> +	/* polling reply from FW */
> +	err = read_poll_timeout(wx_poll_fw_reply, reply, reply, 1000, 50000,
> +				true, wx, buffer, recv_hdr, send_cmd);
> +	if (err) {
> +		wx_err(wx, "Polling from FW messages timeout, cmd: 0x%x, index: %d\n",
> +		       send_cmd, wx->swfw_index);
> +		goto rel_out;
> +	}
> +
> +	/* expect no reply from FW then return */
> +	if (!return_data)
> +		goto rel_out;
> +
> +	/* If there is any thing in data position pull it in */
> +	buf_len = recv_hdr->buf_len;

... and most likely related, recv_hdr appears to be uninitialised here.

This part is flagged by W=1 builds with clang-19, and my Smatch.

> +	if (buf_len == 0)
> +		goto rel_out;
> +
> +	if (length < buf_len + hdr_size) {
> +		wx_err(wx, "Buffer not large enough for reply message.\n");
> +		err = -EFAULT;
> +		goto rel_out;
> +	}
> +
> +	/* Calculate length in DWORDs, add 3 for odd lengths */
> +	dword_len = (buf_len + 3) >> 2;
> +	for (i = hdr_size >> 2; i <= dword_len; i++) {
> +		buffer[i] = rd32a(wx, WX_FW2SW_MBOX, i);
> +		le32_to_cpus(&buffer[i]);
> +	}
> +
> +rel_out:
> +	/* index++, index replace wx_hic_hdr.checksum */
> +	if (send_hdr->index == WX_HIC_HDR_INDEX_MAX)
> +		wx->swfw_index = 0;
> +	else
> +		wx->swfw_index = send_hdr->index + 1;
> +
> +	clear_bit(WX_STATE_SWFW_BUSY, wx->state);
> +	return err;
> +}

...

