Return-Path: <netdev+bounces-217015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDCEB370AF
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 18:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BA8E1B22038
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 16:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E6E2D238A;
	Tue, 26 Aug 2025 16:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xRXx8x08"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730E62C2343;
	Tue, 26 Aug 2025 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756226585; cv=none; b=L1R0TCKOysUolnt9zRe0vGNEQ0j0nY0ZfG1dvHw/ybn4Prjm5F/+tjyqhRdRj7M9dqUU2qo+XKT/PPOiF4hTf97GstAYL2Y7QJcvOD6SBxXPhyjguYJD6Al7valhGMTrI0M7VSqIj/b1hgigaLtarYbKORzW4UJHcRezCiDkYgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756226585; c=relaxed/simple;
	bh=X8bX4wqEcG5t8zkKm77FY2KpCA9tiNOlzUzYFahmvEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PLPdC7Nz6OwFFpFI5EsfrcMPKXDC6MLNxq0T3KC+rfYXylDmWbzteS3hzRC7zS3+bL7q1cCM0nBsmOqLm+jC1xJ2/yxZMHIeYP55vfXraH5cShUFtZaHkMmVRH2F7pQeKqiG9J+SaX/NWZJ+/N7d4JRbvOlfC5a1Q8dLeMIP+xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xRXx8x08; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cf5d9158-4833-4355-8e4d-0894411d0d46@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756226570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oNfkM1W8WaLCBU2U7GOyvpqxcWGzOkoKctUH1gJKV1o=;
	b=xRXx8x08no8uaEDO9RKzLskCzkj+jB3RwdecNrEvYto75HJcNfWnsedNL/nnHumQIqCqXA
	U/TkaeHKHd8wsbcOafRfH6C++R2dpVYapKVLlI+X5qvL//Lcva8aF/hSE6Gt+sDZWT2OWP
	+rphjf0B8i5JTbzQ0xE9drRCQj4SUjg=
Date: Tue, 26 Aug 2025 17:42:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v01 08/12] hinic3: Queue pair context
 initialization
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
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <cover.1756195078.git.zhuyikai1@h-partners.com>
 <fc3dd2c0d29c54332169bc5a2e5be4e4eac77b07.1756195078.git.zhuyikai1@h-partners.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <fc3dd2c0d29c54332169bc5a2e5be4e4eac77b07.1756195078.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 26/08/2025 10:05, Fan Gong wrote:
> Initialize queue pair context of hardware interaction.
> 
> Co-developed-by: Xin Guo <guoxin09@huawei.com>
> Signed-off-by: Xin Guo <guoxin09@huawei.com>
> Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>
> ---

a bit of styling nits, but as you still have to do another version it
would be great to fix.

[...]

> +static int init_sq_ctxts(struct hinic3_nic_dev *nic_dev)
> +{
> +	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
> +	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
> +	struct hinic3_sq_ctxt_block *sq_ctxt_block;
> +	u16 q_id, curr_id, max_ctxts, i;
> +	struct hinic3_sq_ctxt *sq_ctxt;
> +	struct hinic3_cmd_buf *cmd_buf;
> +	struct hinic3_io_queue *sq;
> +	__le64 out_param;
> +	int err = 0;
> +
> +	cmd_buf = hinic3_alloc_cmd_buf(hwdev);
> +	if (!cmd_buf) {
> +		dev_err(hwdev->dev, "Failed to allocate cmd buf\n");
> +		return -ENOMEM;
> +	}
> +
> +	q_id = 0;
> +	while (q_id < nic_io->num_qps) {
> +		sq_ctxt_block = cmd_buf->buf;
> +		sq_ctxt = sq_ctxt_block->sq_ctxt;
> +
> +		max_ctxts = (nic_io->num_qps - q_id) > HINIC3_Q_CTXT_MAX ?
> +			     HINIC3_Q_CTXT_MAX : (nic_io->num_qps - q_id);
> +
> +		hinic3_qp_prepare_cmdq_header(&sq_ctxt_block->cmdq_hdr,
> +					      HINIC3_QP_CTXT_TYPE_SQ, max_ctxts,
> +					      q_id);
> +
> +		for (i = 0; i < max_ctxts; i++) {
> +			curr_id = q_id + i;
> +			sq = &nic_io->sq[curr_id];
> +			hinic3_sq_prepare_ctxt(sq, curr_id, &sq_ctxt[i]);
> +		}
> +
> +		hinic3_cmdq_buf_swab32(sq_ctxt_block, sizeof(*sq_ctxt_block));
> +
> +		cmd_buf->size = cpu_to_le16(SQ_CTXT_SIZE(max_ctxts));
> +		err = hinic3_cmdq_direct_resp(hwdev, MGMT_MOD_L2NIC,
> +					      L2NIC_UCODE_CMD_MODIFY_QUEUE_CTX,
> +					      cmd_buf, &out_param);
> +		if (err || out_param != 0) {

no need for "!= 0" ...

> +			dev_err(hwdev->dev, "Failed to set SQ ctxts, err: %d, out_param: 0x%llx\n",
> +				err, out_param);
> +			err = -EFAULT;
> +			break;
> +		}
> +
> +		q_id += max_ctxts;
> +	}
> +
> +	hinic3_free_cmd_buf(hwdev, cmd_buf);
> +
> +	return err;
> +}
> +
> +static int init_rq_ctxts(struct hinic3_nic_dev *nic_dev)
> +{
> +	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
> +	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
> +	struct hinic3_rq_ctxt_block *rq_ctxt_block;
> +	u16 q_id, curr_id, max_ctxts, i;
> +	struct hinic3_rq_ctxt *rq_ctxt;
> +	struct hinic3_cmd_buf *cmd_buf;
> +	struct hinic3_io_queue *rq;
> +	__le64 out_param;
> +	int err = 0;
> +
> +	cmd_buf = hinic3_alloc_cmd_buf(hwdev);
> +	if (!cmd_buf) {
> +		dev_err(hwdev->dev, "Failed to allocate cmd buf\n");
> +		return -ENOMEM;
> +	}
> +
> +	q_id = 0;
> +	while (q_id < nic_io->num_qps) {
> +		rq_ctxt_block = cmd_buf->buf;
> +		rq_ctxt = rq_ctxt_block->rq_ctxt;
> +
> +		max_ctxts = (nic_io->num_qps - q_id) > HINIC3_Q_CTXT_MAX ?
> +				HINIC3_Q_CTXT_MAX : (nic_io->num_qps - q_id);
> +
> +		hinic3_qp_prepare_cmdq_header(&rq_ctxt_block->cmdq_hdr,
> +					      HINIC3_QP_CTXT_TYPE_RQ, max_ctxts,
> +					      q_id);
> +
> +		for (i = 0; i < max_ctxts; i++) {
> +			curr_id = q_id + i;
> +			rq = &nic_io->rq[curr_id];
> +			hinic3_rq_prepare_ctxt(rq, &rq_ctxt[i]);
> +		}
> +
> +		hinic3_cmdq_buf_swab32(rq_ctxt_block, sizeof(*rq_ctxt_block));
> +
> +		cmd_buf->size = cpu_to_le16(RQ_CTXT_SIZE(max_ctxts));
> +
> +		err = hinic3_cmdq_direct_resp(hwdev, MGMT_MOD_L2NIC,
> +					      L2NIC_UCODE_CMD_MODIFY_QUEUE_CTX,
> +					      cmd_buf, &out_param);
> +		if (err || out_param != 0) {

... here as well

> +			dev_err(hwdev->dev, "Failed to set RQ ctxts, err: %d, out_param: 0x%llx\n",
> +				err, out_param);
> +			err = -EFAULT;
> +			break;
> +		}
> +
> +		q_id += max_ctxts;
> +	}
> +
> +	hinic3_free_cmd_buf(hwdev, cmd_buf);
> +
> +	return err;
> +}

[...]

> +static int clean_queue_offload_ctxt(struct hinic3_nic_dev *nic_dev,
> +				    enum hinic3_qp_ctxt_type ctxt_type)
> +{
> +	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
> +	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
> +	struct hinic3_clean_queue_ctxt *ctxt_block;
> +	struct hinic3_cmd_buf *cmd_buf;
> +	__le64 out_param;
> +	int err;
> +
> +	cmd_buf = hinic3_alloc_cmd_buf(hwdev);
> +	if (!cmd_buf) {
> +		dev_err(hwdev->dev, "Failed to allocate cmd buf\n");
> +		return -ENOMEM;
> +	}
> +
> +	ctxt_block = cmd_buf->buf;
> +	ctxt_block->cmdq_hdr.num_queues = cpu_to_le16(nic_io->max_qps);
> +	ctxt_block->cmdq_hdr.queue_type = cpu_to_le16(ctxt_type);
> +	ctxt_block->cmdq_hdr.start_qid = 0;
> +	ctxt_block->cmdq_hdr.rsvd = 0;
> +	ctxt_block->rsvd = 0;
> +
> +	hinic3_cmdq_buf_swab32(ctxt_block, sizeof(*ctxt_block));
> +
> +	cmd_buf->size = cpu_to_le16(sizeof(*ctxt_block));
> +
> +	err = hinic3_cmdq_direct_resp(hwdev, MGMT_MOD_L2NIC,
> +				      L2NIC_UCODE_CMD_CLEAN_QUEUE_CTX,
> +				      cmd_buf, &out_param);
> +	if ((err) || (out_param)) {

no need for extra parenthesis

> +		dev_err(hwdev->dev, "Failed to clean queue offload ctxts, err: %d,out_param: 0x%llx\n",
> +			err, out_param);
> +
> +		err = -EFAULT;
> +	}
> +
> +	hinic3_free_cmd_buf(hwdev, cmd_buf);


