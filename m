Return-Path: <netdev+bounces-205421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF8FAFE9DC
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 15:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC452642AA8
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 13:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33F9287252;
	Wed,  9 Jul 2025 13:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DK8d9ZQe"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5B81C1F13
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 13:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752066938; cv=none; b=VTJnFINwgcoKI2H50hkRcfFLS+MF2eiqdgnZmRMvnpw5cuHdvu2DU4LaQJpfhPEOMpn8y5J02kz1p2DDjn2ck7FmfL/BDX9J2c9JaxMaUl9Ub/gko0zH0YyHolSQQVkhJRGXrtVv2f30klTt3/pPSXtLvEm8wW+tstwWt82UuFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752066938; c=relaxed/simple;
	bh=YZYdhPz2GfdB32EO3U5noEq78q492csxWC6VeMboGyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lW1uqh3e2qtytMlyHh7usPStFaBNFNawg5osd7kjRbubeVRa7tOKQDnrXvSbuKyn93f6XMgAYKGDtPRyKUACNXNEhEoLXZaDED0Ygie1+Ltzxd6OYN2ivbcmKYTIGToKTcgkYTl5NtBKE4hBEDW8ylhpjYO2mryrfg6nnoHQiCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DK8d9ZQe; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b6b78ea8-4235-4fd5-ab19-133bc04e4188@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752066932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2frUebfYQu94FfAIDHz25jvoP9Zvayn0Ie7/y9CtSQk=;
	b=DK8d9ZQerU+9oBelg/HoXu1ip/VKCzpxd0zBSg6TgiWDOr6Sop9WcZarxdHMydHDDBBrrX
	xuUlCCLWVOUMoCSVecta5hje9R+PEQAlcGO+JQw6jdsg+HbyBCdBCllxqr3b1N/TNzWc9s
	7zY0semditybCAgxh2ZO28SRs2U+dnY=
Date: Wed, 9 Jul 2025 14:15:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v07 7/8] hinic3: Mailbox management interfaces
To: Fan Gong <gongfan1@huawei.com>
Cc: andrew+netdev@lunn.ch, christophe.jaillet@wanadoo.fr, corbet@lwn.net,
 davem@davemloft.net, edumazet@google.com, guoxin09@huawei.com,
 gur.stavi@huawei.com, helgaas@kernel.org, horms@kernel.org,
 jdamato@fastly.com, kuba@kernel.org, lee@trager.us,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, luosifu@huawei.com,
 meny.yossefi@huawei.com, mpe@ellerman.id.au, netdev@vger.kernel.org,
 pabeni@redhat.com, przemyslaw.kitszel@intel.com,
 shenchenyang1@hisilicon.com, shijing34@huawei.com, sumang@marvell.com,
 wulike1@huawei.com, zhoushuai28@huawei.com, zhuyikai1@h-partners.com
References: <54087858-3917-40db-891e-3656269a3a54@linux.dev>
 <20250709083233.27344-1-gongfan1@huawei.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250709083233.27344-1-gongfan1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 09/07/2025 09:32, Fan Gong wrote:
> Thanks for your reviewing.
> 
>>> +static int send_mbox_msg(struct hinic3_mbox *mbox, u8 mod, u16 cmd,
>>> +			 const void *msg, u32 msg_len, u16 dst_func,
>>> +			 enum mbox_msg_direction_type direction,
>>> +			 enum mbox_msg_ack_type ack_type,
>>> +			 struct mbox_msg_info *msg_info)
>>> +{
>>> +	enum mbox_msg_data_type data_type = MBOX_MSG_DATA_INLINE;
>>> +	struct hinic3_hwdev *hwdev = mbox->hwdev;
>>> +	struct mbox_dma_msg dma_msg;
>>> +	u32 seg_len = MBOX_SEG_LEN;
>>> +	u64 header = 0;
>>> +	u32 seq_id = 0;
>>> +	u16 rsp_aeq_id;
>>> +	u8 *msg_seg;
>>> +	int err = 0;
>>> +	u32 left;
>>> +
>>> +	if (hwdev->hwif->attr.num_aeqs > MBOX_MSG_AEQ_FOR_MBOX)
>>> +		rsp_aeq_id = MBOX_MSG_AEQ_FOR_MBOX;
>>> +	else
>>> +		rsp_aeq_id = 0;
>>> +
>>> +	mutex_lock(&mbox->msg_send_lock);
>>
>> this function is always called under mbox->mbox_send_lock, why do you
>> need another mutex? From the experience, a double-locking schema usually
>> brings more troubles than benefits...
> 
> In the current patch, send_mbox_msg is only used in mbox sending process.
> But send_mbox_msg will be used in other functions like mbox response in the
> future patch, so msg_send_lock is necessary to cover the remaining scenes.

I would still suggest you to implement it with one locking primitive as
it will be safer and easier to maintain in the future

> 
>>>    int hinic3_send_mbox_to_mgmt(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
>>>    			     const struct mgmt_msg_params *msg_params)
>>>    {
>>> -	/* Completed by later submission due to LoC limit. */
>>> -	return -EFAULT;
>>> +	struct hinic3_mbox *mbox = hwdev->mbox;
>>> +	struct mbox_msg_info msg_info = {};
>>> +	struct hinic3_msg_desc *msg_desc;
>>> +	int err;
>>> +
>>> +	/* expect response message */
>>> +	msg_desc = get_mbox_msg_desc(mbox, MBOX_MSG_RESP, MBOX_MGMT_FUNC_ID);
>>> +	mutex_lock(&mbox->mbox_send_lock);
>>> +	msg_info.msg_id = (msg_info.msg_id + 1) & 0xF;
>>
>> msg_id is constant 1 here as msg_info is initialized to all zeroes a
>> couple of lines above. It looks like a mistake to me and
>> mbox->send_msg_id should be used instead.
> 
> This is our mistake. We will fix this error in the next version's patch.


