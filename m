Return-Path: <netdev+bounces-262002-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDjAKHopomn/0QQAu9opvQ
	(envelope-from <netdev+bounces-262002-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 00:32:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D84E1BF030
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 00:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 85640304F011
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 23:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE437392820;
	Fri, 27 Feb 2026 23:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="08VCmEAC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905CC2DAFCA;
	Fri, 27 Feb 2026 23:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772235125; cv=none; b=A6sVCNs0CwesNb2VJ+PLam0L+kRkDPzS5iOMExgQfQB1+KtMLMfTrUIuj7d6TLRn32dEKXH4pwGkwuEYj2tjfZvd7YPZj3PbW6hBKlwgLic7OcCaQOdimbwaNoQqifgiAQivA+iUsfja5dNC9R5GEZ5IIRE5CdntyGDLe+b9l4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772235125; c=relaxed/simple;
	bh=MaGol1kof69o1YJevLRfGeO2UUWuOy7xsWuoBWw2IME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrUxF7oN6Z0Orjv0yXexlz0c2yfetOfTF7bw2r77uXVhKUybpWAvres2yXn/KqxAgczAXX4teaX/dLV3iPsenLBlnnJcwnjGJrccCyurkPbPZPsDEUL2H2GsQPo5AVAB0vdDrzB9OjXJPusGPlAVEirznhum+yGc/QJ/MpEZYi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=08VCmEAC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=caq7Ho5oWvA6hVypqld57+GuWYP3480o0c8K6IpvnTc=; b=08VCmEACEgVqQzXk4nqQfkYsP/
	cBMDiVt9VX9MtkcGRSI/Hd2MANersku0+pYd2m3Y4PUrLcnzocy9cYn+eECbZ/h8kehuREAiEYhLI
	mjNHSqyLHb4L4s0v2Vleuvdf61uLyv/9aDhUS+VCCWnRVC0OIXfTdfLrqfcVxiiNUgw0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vw7JH-00987D-IY; Sat, 28 Feb 2026 00:31:51 +0100
Date: Sat, 28 Feb 2026 00:31:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, corbet@lwn.net, kuba@kernel.org,
	linux-doc@vger.kernel.org, lorenzo@kernel.org, pabeni@redhat.com,
	horms@kernel.org, vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com, edumazet@google.com,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 net-next 05/11] net/nebula-matrix: add channel layer
Message-ID: <a3cd8ff5-7545-44a8-96ac-cf7f773df66e@lunn.ch>
References: <20260226073840.3222-1-illusion.wang@nebula-matrix.com>
 <20260226073840.3222-6-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226073840.3222-6-illusion.wang@nebula-matrix.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262002-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D84E1BF030
X-Rspamd-Action: no action

> +	/* wmb */
> +	wmb();

What does the comment tell me which the function name does not?

What would be more interesting in the comment is what is actually
critical to be flushed.

> +static int nbl_chan_kick_tx_ring(struct nbl_channel_mgt *chan_mgt,
> +				 struct nbl_chan_info *chan_info)
> +{
> +	struct nbl_hw_ops *hw_ops = chan_mgt->hw_ops_tbl->ops;
> +	struct nbl_chan_ring *txq = &chan_info->txq;
> +	struct device *dev = chan_mgt->common->dev;
> +	struct nbl_chan_tx_desc *tx_desc;
> +	int i = 0;
> +
> +	/* mb for tx notify */
> +	mb();

This comment is also not so useful. Why is a memory barrier needed
here?

> +	NBL_UPDATE_QUEUE_TAIL_PTR(chan_info, hw_ops, chan_mgt, txq->tail_ptr,
> +				  NBL_MB_TX_QID);
> +
> +	tx_desc = NBL_CHAN_TX_RING_TO_DESC(txq, txq->next_to_clean);
> +
> +	while (!(tx_desc->flags & NBL_CHAN_TX_DESC_USED)) {
> +		udelay(NBL_CHAN_TX_WAIT_US);
> +		i++;
> +
> +		if (!(i % NBL_CHAN_TX_REKICK_WAIT_TIMES))
> +			NBL_UPDATE_QUEUE_TAIL_PTR(chan_info, hw_ops, chan_mgt,
> +						  txq->tail_ptr, NBL_MB_TX_QID);
> +
> +		if (i == NBL_CHAN_TX_WAIT_TIMES) {
> +			dev_err(dev, "chan send message type: %d timeout\n",
> +				tx_desc->msg_type);
> +			return -EAGAIN;

Would -ETIMEDOUT be better here? What does it actually mean? That the
firmware is dead?

> +static int nbl_chan_get_msg_id(struct nbl_chan_info *chan_info,
> +			       union nbl_chan_msg_id *msgid)
> +{
> +	struct nbl_chan_waitqueue_head *wait = NULL;
> +	int valid_loc = chan_info->wait_head_index, i;
> +
> +	for (i = 0; i < NBL_CHAN_QUEUE_LEN; i++) {
> +		wait = &chan_info->wait[valid_loc];
> +
> +		if (wait->status != NBL_MBX_STATUS_WAITING) {
> +			wait->msg_index = NBL_NEXT_ID(wait->msg_index,
> +						      NBL_CHAN_MSG_INDEX_MAX);
> +			msgid->info.index = wait->msg_index;
> +			msgid->info.loc = valid_loc;
> +
> +			valid_loc = NBL_NEXT_ID(valid_loc,
> +						chan_info->num_txq_entries - 1);
> +			chan_info->wait_head_index = valid_loc;
> +			return 0;
> +		}
> +
> +		valid_loc =
> +			NBL_NEXT_ID(valid_loc, chan_info->num_txq_entries - 1);
> +	}
> +
> +	return -ENOSPC;

man 3 errno:

       ENOSPC          No space left on device (POSIX.1-2001).

Seems like something a file system would return. Why would this error
happen?

> +}
> +
> +static int nbl_chan_send_msg(struct nbl_channel_mgt *chan_mgt,
> +			     struct nbl_chan_send_info *chan_send)
> +{
> +	struct nbl_chan_info *chan_info = NBL_CHAN_MGT_TO_MBX(chan_mgt);
> +	struct nbl_common_info *common = chan_mgt->common;
> +	struct nbl_chan_waitqueue_head *wait_head;
> +	union nbl_chan_msg_id msgid = { { 0 } };
> +	struct nbl_chan_tx_param tx_param = { 0 };
> +	int i = NBL_CHAN_TX_WAIT_ACK_TIMES, ret;
> +	struct device *dev = common->dev;
> +
> +	if (test_bit(NBL_CHAN_ABNORMAL, chan_info->state))
> +		return -EFAULT;

       EFAULT          Bad address (POSIX.1-2001).

This is about memory address, unexpected page faults, access outside
of the processes memory space.

> +#define NBL_CHAN_TX_RING_TO_DESC(tx_ring, i) \
> +	(&(((struct nbl_chan_tx_desc *)((tx_ring)->desc))[i]))
> +#define NBL_CHAN_RX_RING_TO_DESC(rx_ring, i) \
> +	(&(((struct nbl_chan_rx_desc *)((rx_ring)->desc))[i]))

Are the casts needed here?

> +struct nbl_chan_tx_desc {
> +	u16 flags;
> +	u16 srcid;
> +	u16 dstid;
> +	u16 data_len;

> +	u16 buf_len;

> +	u64 buf_addr;
> +	u16 msg_type;
> +	u8 data[16];
> +	u16 msgid;
> +	u8 rsv[26];
> +} __packed;

This is a hardware descriptor? It is actually in memory like this,
with the u64 buf_addr badly aligned? What was the hardware engineer
thinking? Just swapping buf_addr and buf_len would of made it a lot
better.

> +struct nbl_chan_rx_desc {
> +	u16 flags;
> +	u32 buf_len;
> +	u16 buf_id;
> +	u64 buf_addr;
> +} __packed;

Similarly badly designed.

> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> @@ -5,8 +5,168 @@
>   */
>  
>  #include "nbl_hw_leonis.h"
> +static inline void nbl_hw_read_mbx_regs(struct nbl_hw_mgt *hw_mgt, u64 reg,
> +					u8 *data, u32 len)
> +{

No inline functions in .c files. Let the compiler decide.

> +static void nbl_hw_rd_regs(struct nbl_hw_mgt *hw_mgt, u64 reg, u8 *data,
> +			   u32 len)
> +{
> +	u32 size = len / 4;
> +	u32 i = 0;
> +
> +	if (len % 4)
> +		return;
> +
> +	spin_lock(&hw_mgt->reg_lock);
> +
> +	for (i = 0; i < size; i++)
> +		*(u32 *)(data + i * sizeof(u32)) =
> +			rd32(hw_mgt->hw_addr, reg + i * sizeof(u32));
> +	spin_unlock(&hw_mgt->reg_lock);
> +}

> +static u32 nbl_hw_get_host_pf_mask(struct nbl_hw_mgt *hw_mgt)
> +{
> +	u32 data;
> +
> +	nbl_hw_rd_regs(hw_mgt, NBL_PCIE_HOST_K_PF_MASK_REG, (u8 *)&data,
> +		       sizeof(data));
> +	return data;

More code with dubious casts. data is a u32, which you cast to u8 for
the call, and nbl_hw_rd_regs() casts it back to u32.


