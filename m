Return-Path: <netdev+bounces-205311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F79AFE2B4
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 10:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D75285827BF
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 08:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B10276025;
	Wed,  9 Jul 2025 08:32:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD46275AFC;
	Wed,  9 Jul 2025 08:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752049966; cv=none; b=GXLzf/zxf3K70f+zZ7dTdlAIHFzLBGWhIu7obniVSUOExZvILUiWf6NMxHVspgt0DaT38qlqSMSeHvzEkpevqyWjg9lYLyTOk5c91ZhQzf6uMFOsTFrv62fVj3HkTBatDu+sFiKOzqbBRbKBsDbz1PNThvfD81B/j8IWxxuFNKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752049966; c=relaxed/simple;
	bh=yPTX1mfCfSOGzONvK4Vx0d8zpBFFfBySlSbCFdQlT3k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q3LuOMkLo2K6bpH5wEmXv/SsXtKZ8YcJUa12yjVzButXQsMnfYyuOiQm49GygK8syXRKNe57XpMMtTxMiZghGDM2qEr4svXWwXDwzi9XDxU+DEYfEqf3UGf90EU3Hn8U7iXRqd8TcnqtWWfzDSYdbrLwCrz90NtBVX4uQAOzmWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bcWML1CdbzWfwP;
	Wed,  9 Jul 2025 16:28:14 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id E0BEE180B64;
	Wed,  9 Jul 2025 16:32:39 +0800 (CST)
Received: from DESKTOP-F6Q6J7K.china.huawei.com (10.174.175.220) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 9 Jul 2025 16:32:38 +0800
From: Fan Gong <gongfan1@huawei.com>
To: <vadim.fedorenko@linux.dev>
CC: <andrew+netdev@lunn.ch>, <christophe.jaillet@wanadoo.fr>,
	<corbet@lwn.net>, <davem@davemloft.net>, <edumazet@google.com>,
	<gongfan1@huawei.com>, <guoxin09@huawei.com>, <gur.stavi@huawei.com>,
	<helgaas@kernel.org>, <horms@kernel.org>, <jdamato@fastly.com>,
	<kuba@kernel.org>, <lee@trager.us>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luosifu@huawei.com>,
	<meny.yossefi@huawei.com>, <mpe@ellerman.id.au>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <przemyslaw.kitszel@intel.com>,
	<shenchenyang1@hisilicon.com>, <shijing34@huawei.com>, <sumang@marvell.com>,
	<wulike1@huawei.com>, <zhoushuai28@huawei.com>, <zhuyikai1@h-partners.com>
Subject: Re: [PATCH net-next v07 7/8] hinic3: Mailbox management interfaces
Date: Wed, 9 Jul 2025 16:32:33 +0800
Message-ID: <20250709083233.27344-1-gongfan1@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <54087858-3917-40db-891e-3656269a3a54@linux.dev>
References: <54087858-3917-40db-891e-3656269a3a54@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100013.china.huawei.com (7.202.181.12)

Thanks for your reviewing.

> > +static int send_mbox_msg(struct hinic3_mbox *mbox, u8 mod, u16 cmd,
> > +			 const void *msg, u32 msg_len, u16 dst_func,
> > +			 enum mbox_msg_direction_type direction,
> > +			 enum mbox_msg_ack_type ack_type,
> > +			 struct mbox_msg_info *msg_info)
> > +{
> > +	enum mbox_msg_data_type data_type = MBOX_MSG_DATA_INLINE;
> > +	struct hinic3_hwdev *hwdev = mbox->hwdev;
> > +	struct mbox_dma_msg dma_msg;
> > +	u32 seg_len = MBOX_SEG_LEN;
> > +	u64 header = 0;
> > +	u32 seq_id = 0;
> > +	u16 rsp_aeq_id;
> > +	u8 *msg_seg;
> > +	int err = 0;
> > +	u32 left;
> > +
> > +	if (hwdev->hwif->attr.num_aeqs > MBOX_MSG_AEQ_FOR_MBOX)
> > +		rsp_aeq_id = MBOX_MSG_AEQ_FOR_MBOX;
> > +	else
> > +		rsp_aeq_id = 0;
> > +
> > +	mutex_lock(&mbox->msg_send_lock);
>
> this function is always called under mbox->mbox_send_lock, why do you
> need another mutex? From the experience, a double-locking schema usually
> brings more troubles than benefits...

In the current patch, send_mbox_msg is only used in mbox sending process.
But send_mbox_msg will be used in other functions like mbox response in the
future patch, so msg_send_lock is necessary to cover the remaining scenes.

> >   int hinic3_send_mbox_to_mgmt(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
> >   			     const struct mgmt_msg_params *msg_params)
> >   {
> > -	/* Completed by later submission due to LoC limit. */
> > -	return -EFAULT;
> > +	struct hinic3_mbox *mbox = hwdev->mbox;
> > +	struct mbox_msg_info msg_info = {};
> > +	struct hinic3_msg_desc *msg_desc;
> > +	int err;
> > +
> > +	/* expect response message */
> > +	msg_desc = get_mbox_msg_desc(mbox, MBOX_MSG_RESP, MBOX_MGMT_FUNC_ID);
> > +	mutex_lock(&mbox->mbox_send_lock);
> > +	msg_info.msg_id = (msg_info.msg_id + 1) & 0xF;
>
> msg_id is constant 1 here as msg_info is initialized to all zeroes a
> couple of lines above. It looks like a mistake to me and
> mbox->send_msg_id should be used instead.

This is our mistake. We will fix this error in the next version's patch.

