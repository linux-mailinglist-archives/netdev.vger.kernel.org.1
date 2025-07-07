Return-Path: <netdev+bounces-204588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E1EAFB469
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 15:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D05A1635A7
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 13:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C23293C7B;
	Mon,  7 Jul 2025 13:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="URHRFRPu"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03192289803
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 13:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751894584; cv=none; b=S95okR381OoZpgZFQRFdAjbF9jsnhp1sg7Hb6ajbNBcE3wQa8eUpEFDc/8Wu4a/usbHadqx+rEFFYQIsPS//R+/CjrmI0UX+j8Ot2+VOvFVyFiYNLSHp4XHg561RTxp31PzTTbGcGpytg2nVY5w/blQWFde8whm5MxG4dpX+k2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751894584; c=relaxed/simple;
	bh=zd8JbV2RNlRJLLfNXdpeTPDdWR0osE7w57dvkUwzfgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hfuk4j5RPtKaZ1CyHAcwidWyRBgNoRruy5intgnz9zXT7ZZ6piBfRKhFKxiW88YKrc87LQshAPIkzU22rLTpGcTtpPDoIii/wEFYhkAw+yjinX+avcTqMxZFeAV9X4TeewIyOW3y7zR0jb1QQ6E5rvddtWGA6gb3rM/6NsSgcP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=URHRFRPu; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <54087858-3917-40db-891e-3656269a3a54@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751894569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ysXG9/iF2Ouw6gs1UX80PzIpQAbzrdyBsBmos0IXt1M=;
	b=URHRFRPuhaHHuhX0RPGP4FH8BKlVZSlzyWLemLEm9/0STpsZh2nVIA1uYG7PJvG2mpUdJN
	JTGlHDKqagN6I3BYQwCMZjw8aAZPA3mrlRuCgu9HigKLTKXG00IvicBdBnCkKJp5yoJahS
	6eFs0E8245WSxQfrbwHrqcYs78CbA/k=
Date: Mon, 7 Jul 2025 14:22:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v07 7/8] hinic3: Mailbox management interfaces
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Bjorn Helgaas <helgaas@kernel.org>, luosifu <luosifu@huawei.com>,
 Xin Guo <guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>,
 Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
 Shi Jing <shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>,
 Gur Stavi <gur.stavi@huawei.com>, Lee Trager <lee@trager.us>,
 Michael Ellerman <mpe@ellerman.id.au>, Suman Ghosh <sumang@marvell.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Joe Damato <jdamato@fastly.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <cover.1751597094.git.zhuyikai1@h-partners.com>
 <858fee983fa1a889c85f9150983e28ec44a65738.1751597094.git.zhuyikai1@h-partners.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <858fee983fa1a889c85f9150983e28ec44a65738.1751597094.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 04/07/2025 07:22, Fan Gong wrote:
> Add mailbox management interfaces initialization.
> It enables mailbox to communicate with event queues from HW.
> 
> Co-developed-by: Xin Guo <guoxin09@huawei.com>
> Signed-off-by: Xin Guo <guoxin09@huawei.com>
> Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>
> ---
>   .../net/ethernet/huawei/hinic3/hinic3_mbox.c  | 440 +++++++++++++++++-
>   .../net/ethernet/huawei/hinic3/hinic3_mbox.h  |  22 +
>   .../huawei/hinic3/hinic3_queue_common.h       |   1 +
>   3 files changed, 461 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
> index 2967bc29408f..56485acd670a 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
> @@ -9,6 +9,23 @@
>   #include "hinic3_hwif.h"
>   #include "hinic3_mbox.h"
>   
> +#define MBOX_INT_DST_AEQN_MASK        GENMASK(11, 10)
> +#define MBOX_INT_SRC_RESP_AEQN_MASK   GENMASK(13, 12)
> +#define MBOX_INT_STAT_DMA_MASK        GENMASK(19, 14)
> +/* TX size, expressed in 4 bytes units */
> +#define MBOX_INT_TX_SIZE_MASK         GENMASK(24, 20)
> +/* SO_RO == strong order, relaxed order */
> +#define MBOX_INT_STAT_DMA_SO_RO_MASK  GENMASK(26, 25)
> +#define MBOX_INT_WB_EN_MASK           BIT(28)
> +#define MBOX_INT_SET(val, field)  \
> +	FIELD_PREP(MBOX_INT_##field##_MASK, val)
> +
> +#define MBOX_CTRL_TRIGGER_AEQE_MASK   BIT(0)
> +#define MBOX_CTRL_TX_STATUS_MASK      BIT(1)
> +#define MBOX_CTRL_DST_FUNC_MASK       GENMASK(28, 16)
> +#define MBOX_CTRL_SET(val, field)  \
> +	FIELD_PREP(MBOX_CTRL_##field##_MASK, val)
> +
>   #define MBOX_MSG_POLLING_TIMEOUT_MS  8000 // send msg seg timeout
>   #define MBOX_COMP_POLLING_TIMEOUT_MS 40000 // response
>   
> @@ -25,6 +42,20 @@
>   #define MBOX_LAST_SEG_MAX_LEN  \
>   	(MBOX_MAX_BUF_SZ - MBOX_SEQ_ID_MAX_VAL * MBOX_SEG_LEN)
>   
> +/* mbox write back status is 16B, only first 4B is used */
> +#define MBOX_WB_STATUS_ERRCODE_MASK      0xFFFF
> +#define MBOX_WB_STATUS_MASK              0xFF
> +#define MBOX_WB_ERROR_CODE_MASK          0xFF00
> +#define MBOX_WB_STATUS_FINISHED_SUCCESS  0xFF
> +#define MBOX_WB_STATUS_NOT_FINISHED      0x00
> +
> +#define MBOX_STATUS_FINISHED(wb)  \
> +	(((wb) & MBOX_WB_STATUS_MASK) != MBOX_WB_STATUS_NOT_FINISHED)
> +#define MBOX_STATUS_SUCCESS(wb)  \
> +	(((wb) & MBOX_WB_STATUS_MASK) == MBOX_WB_STATUS_FINISHED_SUCCESS)
> +#define MBOX_STATUS_ERRCODE(wb)  \
> +	((wb) & MBOX_WB_ERROR_CODE_MASK)
> +
>   #define MBOX_DMA_MSG_QUEUE_DEPTH    32
>   #define MBOX_BODY_FROM_HDR(header)  ((u8 *)(header) + MBOX_HEADER_SZ)
>   #define MBOX_AREA(hwif)  \
> @@ -411,9 +442,414 @@ void hinic3_free_mbox(struct hinic3_hwdev *hwdev)
>   	kfree(mbox);
>   }
>   
> +#define MBOX_DMA_MSG_INIT_XOR_VAL    0x5a5a5a5a
> +#define MBOX_XOR_DATA_ALIGN          4
> +static u32 mbox_dma_msg_xor(u32 *data, u32 msg_len)
> +{
> +	u32 xor = MBOX_DMA_MSG_INIT_XOR_VAL;
> +	u32 dw_len = msg_len / sizeof(u32);
> +	u32 i;
> +
> +	for (i = 0; i < dw_len; i++)
> +		xor ^= data[i];
> +
> +	return xor;
> +}
> +
> +#define MBOX_MQ_ID_MASK(mq, idx)  ((idx) & ((mq)->depth - 1))
> +
> +static bool is_msg_queue_full(struct mbox_dma_queue *mq)
> +{
> +	return (MBOX_MQ_ID_MASK(mq, (mq)->prod_idx + 1) ==
> +		MBOX_MQ_ID_MASK(mq, (mq)->cons_idx));
> +}
> +
> +static int mbox_prepare_dma_entry(struct hinic3_mbox *mbox,
> +				  struct mbox_dma_queue *mq,
> +				  struct mbox_dma_msg *dma_msg,
> +				  const void *msg, u32 msg_len)
> +{
> +	u64 dma_addr, offset;
> +	void *dma_vaddr;
> +
> +	if (is_msg_queue_full(mq)) {
> +		dev_err(mbox->hwdev->dev, "Mbox sync message queue is busy, pi: %u, ci: %u\n",
> +			mq->prod_idx, MBOX_MQ_ID_MASK(mq, mq->cons_idx));
> +		return -EBUSY;
> +	}
> +
> +	/* copy data to DMA buffer */
> +	offset = mq->prod_idx * MBOX_MAX_BUF_SZ;
> +	dma_vaddr = (u8 *)mq->dma_buf_vaddr + offset;
> +	memcpy(dma_vaddr, msg, msg_len);
> +	dma_addr = mq->dma_buf_paddr + offset;
> +	dma_msg->dma_addr_high = upper_32_bits(dma_addr);
> +	dma_msg->dma_addr_low = lower_32_bits(dma_addr);
> +	dma_msg->msg_len = msg_len;
> +	/* The firmware obtains message based on 4B alignment. */
> +	dma_msg->xor = mbox_dma_msg_xor(dma_vaddr,
> +					ALIGN(msg_len, MBOX_XOR_DATA_ALIGN));
> +	mq->prod_idx++;
> +	mq->prod_idx = MBOX_MQ_ID_MASK(mq, mq->prod_idx);
> +
> +	return 0;
> +}
> +
> +static int mbox_prepare_dma_msg(struct hinic3_mbox *mbox,
> +				enum mbox_msg_ack_type ack_type,
> +				struct mbox_dma_msg *dma_msg, const void *msg,
> +				u32 msg_len)
> +{
> +	struct mbox_dma_queue *mq;
> +	u32 val;
> +
> +	val = hinic3_hwif_read_reg(mbox->hwdev->hwif, MBOX_MQ_CI_OFFSET);
> +	if (ack_type == MBOX_MSG_ACK) {
> +		mq = &mbox->sync_msg_queue;
> +		mq->cons_idx = MBOX_MQ_CI_GET(val, SYNC);
> +	} else {
> +		mq = &mbox->async_msg_queue;
> +		mq->cons_idx = MBOX_MQ_CI_GET(val, ASYNC);
> +	}
> +
> +	return mbox_prepare_dma_entry(mbox, mq, dma_msg, msg, msg_len);
> +}
> +
> +static void clear_mbox_status(struct hinic3_send_mbox *mbox)
> +{
> +	__be64 *wb_status = mbox->wb_vaddr;
> +
> +	*wb_status = 0;
> +	/* clear mailbox write back status */
> +	wmb();
> +}
> +
> +static void mbox_dword_write(const void *src, void __iomem *dst, u32 count)
> +{
> +	u32 __iomem *dst32 = dst;
> +	const u32 *src32 = src;
> +	u32 i;
> +
> +	/* Data written to mbox is arranged in structs with little endian fields
> +	 * but when written to HW every dword (32bits) should be swapped since
> +	 * the HW will swap it again. This is a mandatory swap regardless of the
> +	 * CPU endianness.
> +	 */
> +	for (i = 0; i < count; i++)
> +		__raw_writel(swab32(src32[i]), dst32 + i);
> +}
> +
> +static void mbox_copy_header(struct hinic3_hwdev *hwdev,
> +			     struct hinic3_send_mbox *mbox, u64 *header)
> +{
> +	mbox_dword_write(header, mbox->data, MBOX_HEADER_SZ / sizeof(u32));
> +}
> +
> +static void mbox_copy_send_data(struct hinic3_hwdev *hwdev,
> +				struct hinic3_send_mbox *mbox, void *seg,
> +				u32 seg_len)
> +{
> +	u32 __iomem *dst = (u32 __iomem *)(mbox->data + MBOX_HEADER_SZ);
> +	u32 count, leftover, last_dword;
> +	const u32 *src = seg;
> +
> +	count = seg_len / sizeof(u32);
> +	leftover = seg_len % sizeof(u32);
> +	if (count > 0)
> +		mbox_dword_write(src, dst, count);
> +
> +	if (leftover > 0) {
> +		last_dword = 0;
> +		memcpy(&last_dword, src + count, leftover);
> +		mbox_dword_write(&last_dword, dst + count, 1);
> +	}
> +}
> +
> +static void write_mbox_msg_attr(struct hinic3_mbox *mbox,
> +				u16 dst_func, u16 dst_aeqn, u32 seg_len)
> +{
> +	struct hinic3_hwif *hwif = mbox->hwdev->hwif;
> +	u32 mbox_int, mbox_ctrl, tx_size;
> +
> +	tx_size = ALIGN(seg_len + MBOX_HEADER_SZ, MBOX_SEG_LEN_ALIGN) >> 2;
> +
> +	mbox_int = MBOX_INT_SET(dst_aeqn, DST_AEQN) |
> +		   MBOX_INT_SET(0, STAT_DMA) |
> +		   MBOX_INT_SET(tx_size, TX_SIZE) |
> +		   MBOX_INT_SET(0, STAT_DMA_SO_RO) |
> +		   MBOX_INT_SET(1, WB_EN);
> +
> +	mbox_ctrl = MBOX_CTRL_SET(1, TX_STATUS) |
> +		    MBOX_CTRL_SET(0, TRIGGER_AEQE) |
> +		    MBOX_CTRL_SET(dst_func, DST_FUNC);
> +
> +	hinic3_hwif_write_reg(hwif, HINIC3_FUNC_CSR_MAILBOX_INT_OFF, mbox_int);
> +	hinic3_hwif_write_reg(hwif, HINIC3_FUNC_CSR_MAILBOX_CONTROL_OFF,
> +			      mbox_ctrl);
> +}
> +
> +static u16 get_mbox_status(const struct hinic3_send_mbox *mbox)
> +{
> +	__be64 *wb_status = mbox->wb_vaddr;
> +	u64 wb_val;
> +
> +	wb_val = be64_to_cpu(*wb_status);
> +	/* verify reading before check */
> +	rmb();
> +
> +	return wb_val & MBOX_WB_STATUS_ERRCODE_MASK;
> +}
> +
> +static enum hinic3_wait_return check_mbox_wb_status(void *priv_data)
> +{
> +	struct hinic3_mbox *mbox = priv_data;
> +	u16 wb_status;
> +
> +	wb_status = get_mbox_status(&mbox->send_mbox);
> +
> +	return MBOX_STATUS_FINISHED(wb_status) ?
> +	       HINIC3_WAIT_PROCESS_CPL : HINIC3_WAIT_PROCESS_WAITING;
> +}
> +
> +static int send_mbox_seg(struct hinic3_mbox *mbox, u64 header,
> +			 u16 dst_func, void *seg, u32 seg_len, void *msg_info)
> +{
> +	struct hinic3_send_mbox *send_mbox = &mbox->send_mbox;
> +	struct hinic3_hwdev *hwdev = mbox->hwdev;
> +	u8 num_aeqs = hwdev->hwif->attr.num_aeqs;
> +	enum mbox_msg_direction_type dir;
> +	u16 dst_aeqn, wb_status, errcode;
> +	int err;
> +
> +	/* mbox to mgmt cpu, hardware doesn't care about dst aeq id */
> +	if (num_aeqs > MBOX_MSG_AEQ_FOR_MBOX) {
> +		dir = MBOX_MSG_HEADER_GET(header, DIRECTION);
> +		dst_aeqn = (dir == MBOX_MSG_SEND) ?
> +			   MBOX_MSG_AEQ_FOR_EVENT : MBOX_MSG_AEQ_FOR_MBOX;
> +	} else {
> +		dst_aeqn = 0;
> +	}
> +
> +	clear_mbox_status(send_mbox);
> +	mbox_copy_header(hwdev, send_mbox, &header);
> +	mbox_copy_send_data(hwdev, send_mbox, seg, seg_len);
> +	write_mbox_msg_attr(mbox, dst_func, dst_aeqn, seg_len);
> +
> +	err = hinic3_wait_for_timeout(mbox, check_mbox_wb_status,
> +				      MBOX_MSG_POLLING_TIMEOUT_MS,
> +				      USEC_PER_MSEC);
> +	wb_status = get_mbox_status(send_mbox);
> +	if (err) {
> +		dev_err(hwdev->dev, "Send mailbox segment timeout, wb status: 0x%x\n",
> +			wb_status);
> +		return err;
> +	}
> +
> +	if (!MBOX_STATUS_SUCCESS(wb_status)) {
> +		dev_err(hwdev->dev,
> +			"Send mailbox segment to function %u error, wb status: 0x%x\n",
> +			dst_func, wb_status);
> +		errcode = MBOX_STATUS_ERRCODE(wb_status);
> +		return errcode ? errcode : -EFAULT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int send_mbox_msg(struct hinic3_mbox *mbox, u8 mod, u16 cmd,
> +			 const void *msg, u32 msg_len, u16 dst_func,
> +			 enum mbox_msg_direction_type direction,
> +			 enum mbox_msg_ack_type ack_type,
> +			 struct mbox_msg_info *msg_info)
> +{
> +	enum mbox_msg_data_type data_type = MBOX_MSG_DATA_INLINE;
> +	struct hinic3_hwdev *hwdev = mbox->hwdev;
> +	struct mbox_dma_msg dma_msg;
> +	u32 seg_len = MBOX_SEG_LEN;
> +	u64 header = 0;
> +	u32 seq_id = 0;
> +	u16 rsp_aeq_id;
> +	u8 *msg_seg;
> +	int err = 0;
> +	u32 left;
> +
> +	if (hwdev->hwif->attr.num_aeqs > MBOX_MSG_AEQ_FOR_MBOX)
> +		rsp_aeq_id = MBOX_MSG_AEQ_FOR_MBOX;
> +	else
> +		rsp_aeq_id = 0;
> +
> +	mutex_lock(&mbox->msg_send_lock);

this function is always called under mbox->mbox_send_lock, why do you
need another mutex? From the experience, a double-locking schema usually
brings more troubles than benefits...

> +
> +	if (dst_func == MBOX_MGMT_FUNC_ID &&
> +	    !(hwdev->features[0] & MBOX_COMM_F_MBOX_SEGMENT)) {
> +		err = mbox_prepare_dma_msg(mbox, ack_type, &dma_msg,
> +					   msg, msg_len);
> +		if (err)
> +			goto err_send;
> +
> +		msg = &dma_msg;
> +		msg_len = sizeof(dma_msg);
> +		data_type = MBOX_MSG_DATA_DMA;
> +	}
> +
> +	msg_seg = (u8 *)msg;
> +	left = msg_len;
> +
> +	header = MBOX_MSG_HEADER_SET(msg_len, MSG_LEN) |
> +		 MBOX_MSG_HEADER_SET(mod, MODULE) |
> +		 MBOX_MSG_HEADER_SET(seg_len, SEG_LEN) |
> +		 MBOX_MSG_HEADER_SET(ack_type, NO_ACK) |
> +		 MBOX_MSG_HEADER_SET(data_type, DATA_TYPE) |
> +		 MBOX_MSG_HEADER_SET(MBOX_SEQ_ID_START_VAL, SEQID) |
> +		 MBOX_MSG_HEADER_SET(direction, DIRECTION) |
> +		 MBOX_MSG_HEADER_SET(cmd, CMD) |
> +		 MBOX_MSG_HEADER_SET(msg_info->msg_id, MSG_ID) |
> +		 MBOX_MSG_HEADER_SET(rsp_aeq_id, AEQ_ID) |
> +		 MBOX_MSG_HEADER_SET(MBOX_MSG_FROM_MBOX, SOURCE) |
> +		 MBOX_MSG_HEADER_SET(!!msg_info->status, STATUS);
> +
> +	while (!(MBOX_MSG_HEADER_GET(header, LAST))) {
> +		if (left <= MBOX_SEG_LEN) {
> +			header &= ~MBOX_MSG_HEADER_SEG_LEN_MASK;
> +			header |= MBOX_MSG_HEADER_SET(left, SEG_LEN) |
> +				  MBOX_MSG_HEADER_SET(1, LAST);
> +			seg_len = left;
> +		}
> +
> +		err = send_mbox_seg(mbox, header, dst_func, msg_seg,
> +				    seg_len, msg_info);
> +		if (err) {
> +			dev_err(hwdev->dev, "Failed to send mbox seg, seq_id=0x%llx\n",
> +				MBOX_MSG_HEADER_GET(header, SEQID));
> +			goto err_send;
> +		}
> +
> +		left -= MBOX_SEG_LEN;
> +		msg_seg += MBOX_SEG_LEN;
> +		seq_id++;
> +		header &= ~MBOX_MSG_HEADER_SEG_LEN_MASK;
> +		header |= MBOX_MSG_HEADER_SET(seq_id, SEQID);
> +	}
> +
> +err_send:
> +	mutex_unlock(&mbox->msg_send_lock);
> +
> +	return err;
> +}
> +
> +static void set_mbox_to_func_event(struct hinic3_mbox *mbox,
> +				   enum mbox_event_state event_flag)
> +{
> +	spin_lock(&mbox->mbox_lock);
> +	mbox->event_flag = event_flag;
> +	spin_unlock(&mbox->mbox_lock);
> +}
> +
> +static enum hinic3_wait_return check_mbox_msg_finish(void *priv_data)
> +{
> +	struct hinic3_mbox *mbox = priv_data;
> +
> +	return (mbox->event_flag == MBOX_EVENT_SUCCESS) ?
> +		HINIC3_WAIT_PROCESS_CPL : HINIC3_WAIT_PROCESS_WAITING;
> +}
> +
> +static int wait_mbox_msg_completion(struct hinic3_mbox *mbox,
> +				    u32 timeout)
> +{
> +	u32 wait_time;
> +	int err;
> +
> +	wait_time = (timeout != 0) ? timeout : MBOX_COMP_POLLING_TIMEOUT_MS;
> +	err = hinic3_wait_for_timeout(mbox, check_mbox_msg_finish,
> +				      wait_time, USEC_PER_MSEC);
> +	if (err) {
> +		set_mbox_to_func_event(mbox, MBOX_EVENT_TIMEOUT);
> +		return err;
> +	}
> +	set_mbox_to_func_event(mbox, MBOX_EVENT_END);
> +
> +	return 0;
> +}
> +
>   int hinic3_send_mbox_to_mgmt(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
>   			     const struct mgmt_msg_params *msg_params)
>   {
> -	/* Completed by later submission due to LoC limit. */
> -	return -EFAULT;
> +	struct hinic3_mbox *mbox = hwdev->mbox;
> +	struct mbox_msg_info msg_info = {};
> +	struct hinic3_msg_desc *msg_desc;
> +	int err;
> +
> +	/* expect response message */
> +	msg_desc = get_mbox_msg_desc(mbox, MBOX_MSG_RESP, MBOX_MGMT_FUNC_ID);
> +	mutex_lock(&mbox->mbox_send_lock);
> +	msg_info.msg_id = (msg_info.msg_id + 1) & 0xF;

msg_id is constant 1 here as msg_info is initialized to all zeroes a
couple of lines above. It looks like a mistake to me and
mbox->send_msg_id should be used instead.

> +	mbox->send_msg_id = msg_info.msg_id;
> +	set_mbox_to_func_event(mbox, MBOX_EVENT_START);
> +
> +	err = send_mbox_msg(mbox, mod, cmd, msg_params->buf_in,
> +			    msg_params->in_size, MBOX_MGMT_FUNC_ID,
> +			    MBOX_MSG_SEND, MBOX_MSG_ACK, &msg_info);
> +	if (err) {
> +		dev_err(hwdev->dev, "Send mailbox mod %u, cmd %u failed, msg_id: %u, err: %d\n",
> +			mod, cmd, msg_info.msg_id, err);
> +		set_mbox_to_func_event(mbox, MBOX_EVENT_FAIL);
> +		goto err_send;
> +	}
> +
> +	if (wait_mbox_msg_completion(mbox, msg_params->timeout_ms)) {
> +		dev_err(hwdev->dev,
> +			"Send mbox msg timeout, msg_id: %u\n", msg_info.msg_id);
> +		err = -ETIMEDOUT;
> +		goto err_send;
> +	}
> +
> +	if (mod != msg_desc->mod || cmd != msg_desc->cmd) {
> +		dev_err(hwdev->dev,
> +			"Invalid response mbox message, mod: 0x%x, cmd: 0x%x, expect mod: 0x%x, cmd: 0x%x\n",
> +			msg_desc->mod, msg_desc->cmd, mod, cmd);
> +		err = -EFAULT;
> +		goto err_send;
> +	}
> +
> +	if (msg_desc->msg_info.status) {
> +		err = msg_desc->msg_info.status;
> +		goto err_send;
> +	}
> +
> +	if (msg_params->buf_out) {
> +		if (msg_desc->msg_len != msg_params->expected_out_size) {
> +			dev_err(hwdev->dev,
> +				"Invalid response mbox message length: %u for mod %d cmd %u, expected length: %u\n",
> +				msg_desc->msg_len, mod, cmd,
> +				msg_params->expected_out_size);
> +			err = -EFAULT;
> +			goto err_send;
> +		}
> +
> +		memcpy(msg_params->buf_out, msg_desc->msg, msg_desc->msg_len);
> +	}
> +
> +err_send:
> +	mutex_unlock(&mbox->mbox_send_lock);
> +
> +	return err;
> +}
> +
> +int hinic3_send_mbox_to_mgmt_no_ack(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
> +				    const struct mgmt_msg_params *msg_params)
> +{
> +	struct hinic3_mbox *mbox = hwdev->mbox;
> +	struct mbox_msg_info msg_info = {};
> +	int err;
> +
> +	mutex_lock(&mbox->mbox_send_lock);
> +	err = send_mbox_msg(mbox, mod, cmd, msg_params->buf_in,
> +			    msg_params->in_size, MBOX_MGMT_FUNC_ID,
> +			    MBOX_MSG_SEND, MBOX_MSG_NO_ACK, &msg_info);
> +	if (err)
> +		dev_err(hwdev->dev, "Send mailbox no ack failed\n");
> +
> +	mutex_unlock(&mbox->mbox_send_lock);
> +
> +	return err;
>   }
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h
> index 730795b66a86..2435df31d9e5 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h
> @@ -38,6 +38,26 @@ enum mbox_msg_direction_type {
>   	MBOX_MSG_RESP = 1,
>   };
>   
> +/* Indicates if mbox message expects a response (ack) or not */
> +enum mbox_msg_ack_type {
> +	MBOX_MSG_ACK    = 0,
> +	MBOX_MSG_NO_ACK = 1,
> +};
> +
> +enum mbox_msg_data_type {
> +	MBOX_MSG_DATA_INLINE = 0,
> +	MBOX_MSG_DATA_DMA    = 1,
> +};
> +
> +enum mbox_msg_src_type {
> +	MBOX_MSG_FROM_MBOX = 1,
> +};
> +
> +enum mbox_msg_aeq_type {
> +	MBOX_MSG_AEQ_FOR_EVENT = 0,
> +	MBOX_MSG_AEQ_FOR_MBOX  = 1,
> +};
> +
>   #define HINIC3_MBOX_WQ_NAME  "hinic3_mbox"
>   
>   struct mbox_msg_info {
> @@ -116,5 +136,7 @@ void hinic3_free_mbox(struct hinic3_hwdev *hwdev);
>   
>   int hinic3_send_mbox_to_mgmt(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
>   			     const struct mgmt_msg_params *msg_params);
> +int hinic3_send_mbox_to_mgmt_no_ack(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
> +				    const struct mgmt_msg_params *msg_params);
>   
>   #endif
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_queue_common.h b/drivers/net/ethernet/huawei/hinic3/hinic3_queue_common.h
> index ec4cae0a0929..2bf7a70251bb 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_queue_common.h
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_queue_common.h
> @@ -48,6 +48,7 @@ static inline void *get_q_element(const struct hinic3_queue_pages *qpages,
>   		*remaining_in_page = elem_per_pg - elem_idx;
>   	ofs = elem_idx << qpages->elem_size_shift;
>   	page = qpages->pages + page_idx;
> +
>   	return (char *)page->align_vaddr + ofs;
>   }
>   


