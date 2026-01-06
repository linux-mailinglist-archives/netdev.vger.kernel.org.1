Return-Path: <netdev+bounces-247264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18687CF65A6
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 02:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91F4C30A21A8
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 01:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8F1241663;
	Tue,  6 Jan 2026 01:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIYKfFvy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E7722D9F7;
	Tue,  6 Jan 2026 01:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767663558; cv=none; b=qCNrXW5YXdz1tH673TKXT5RIdbxWApkyHaPimTUZHjoyXMGsO36qiMTX9YoDVCMLVySpJTsB0W8tjmHjHf8QM/fgWazM00ONDfz5ow+OvcNRO5V3F0ll+Ct9TjSo5uiSPekvtrYqKbRCa0C7HoOYaMWjhSJqMjaIipI74jXljvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767663558; c=relaxed/simple;
	bh=3rD0CaluPazcHZWSFdv+vflPa3RNg2ADvJLAn1+keb8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JGsRnWUZJKmfVZvVZb0pOHSvsck+ZQH9BthCOQbaB9ZZ6rahJTMCBkFEEuF7tE15JfKkC7XXQ9XVjTL1GwbFrybvn5WSuSlOjESV+3WrT6/ommeo++qkZsBNmdHUsj0jlKgeASqQq0LuxdGFJG416PDTaHUvxL6NGGLZGc9c5Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tIYKfFvy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7526BC116D0;
	Tue,  6 Jan 2026 01:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767663558;
	bh=3rD0CaluPazcHZWSFdv+vflPa3RNg2ADvJLAn1+keb8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tIYKfFvyQxs7VQSqpYYkbOJy3Ns8fBgt0NjP7WKQslYsUS+RvjxHI6YVTud/deoZZ
	 m+aUgwhiNgG2KJfvwKyLzL+Ax0nfFO0aytM+DZIvP01zh+ERFHh8Sj4W3UzJByD8uP
	 slQNe/hUD/OzXUKswSYMcMGXtlr58kWEs57KtUhPz2mPxwkCqLU32N/qzRUJhApo3N
	 iHtOZ+ulCSWTBPhHmm1MVIRrQcEZoU7gv1R0dKRtJHQL+Jswo9EBgs2HstOLIYwYrf
	 Dp7TImnWsVCZL0AZ01+jY47kKCPqZUBvJHrlL0CePKhs5eHFjDbaUqUpaed4swcqqH
	 VDivy/DLkVFRA==
Date: Mon, 5 Jan 2026 17:39:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, <netdev@vger.kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Markus Elfring <Markus.Elfring@web.de>, Pavan
 Chebbi <pavan.chebbi@broadcom.com>, ALOK TIWARI <alok.a.tiwari@oracle.com>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
 <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Shen Chenyang
 <shenchenyang1@hisilicon.com>, Zhou Shuai <zhoushuai28@huawei.com>, Wu Like
 <wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>, Luo Yang
 <luoyang82@h-partners.com>
Subject: Re: [PATCH net-next v08 1/9] hinic3: Add PF framework
Message-ID: <20260105173916.4a0b29bc@kernel.org>
In-Reply-To: <c1644bd9246a2cb6c2bbac87747ef6dd224bb2ae.1767495881.git.zhuyikai1@h-partners.com>
References: <cover.1767495881.git.zhuyikai1@h-partners.com>
	<c1644bd9246a2cb6c2bbac87747ef6dd224bb2ae.1767495881.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

AI code review points out the following.
Please address or add a relevant comment explaining why the code 
is fine.

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
> index cf67e26acece..1cb0d88911a2 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
> @@ -82,10 +82,19 @@ static struct hinic3_msg_desc *get_mbox_msg_desc(struct hinic3_mbox *mbox,
>  						 enum mbox_msg_direction_type dir,
>  						 u16 src_func_id)
>  {
> +	struct hinic3_hwdev *hwdev = mbox->hwdev;
>  	struct hinic3_msg_channel *msg_ch;
>
> -	msg_ch = (src_func_id == MBOX_MGMT_FUNC_ID) ?
> -		&mbox->mgmt_msg : mbox->func_msg;
> +	if (src_func_id == MBOX_MGMT_FUNC_ID) {
> +		msg_ch = &mbox->mgmt_msg;
> +	} else if (HINIC3_IS_VF(hwdev)) {
> +		/* message from pf */
> +		msg_ch = mbox->func_msg;
> +		if (src_func_id != hinic3_pf_id_of_vf(hwdev) || !msg_ch)
> +			return NULL;
> +	} else {
> +		return NULL;
> +	}

Can this return NULL for PF when src_func_id is not MBOX_MGMT_FUNC_ID?

Looking at hinic3_mbox_func_aeqe_handler(), the caller of get_mbox_msg_desc():

    msg_desc = get_mbox_msg_desc(mbox, dir, src_func_id);
    recv_mbox_handler(mbox, header, msg_desc);

The return value is passed directly to recv_mbox_handler() without a
NULL check. Inside recv_mbox_handler():

    if (!mbox_segment_valid(mbox, msg_desc, mbox_header)) {
        msg_desc->seq_id = MBOX_SEQ_ID_MAX_VAL;

And mbox_segment_valid() dereferences msg_desc unconditionally:

    msg_desc->seq_id = seq_id;

If a PF receives a mailbox message from any source other than management
(for example, from a VF), get_mbox_msg_desc() returns NULL, and then
mbox_segment_valid() will dereference the NULL pointer causing a kernel
crash.

Should hinic3_mbox_func_aeqe_handler() check for NULL before calling
recv_mbox_handler()?

