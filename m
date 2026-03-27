Return-Path: <netdev+bounces-272373-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eInLAHEQxmnwFwUAu9opvQ
	(envelope-from <netdev+bounces-272373-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 06:06:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D76833F354
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 06:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31564301F9C8
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 05:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3E8324B27;
	Fri, 27 Mar 2026 05:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="3AJZLbex"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F392D8DCF;
	Fri, 27 Mar 2026 05:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774588010; cv=none; b=A4mi42+zcCxl4qBYi5+z7dXBVWuA7luEK/JbrODmvN4jgCJ3vAsUoKtRo5hV3Fmm5IbA/4KV0tFGOEsR3WiWRJRIpkGRNx7/L+hlx+uy/PEM2OSfAhMNjw4+UBqnMpOiMl1zv3iNqOsk5pV+JU247d4n13YX0F9oNdSR9K6Zts4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774588010; c=relaxed/simple;
	bh=mur6AlO1n0RiVhNvnz/HueTDTfHu2GrGcv9mA55TKow=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Oab2JB2+tQ3B1O8qJR/CXGrAfiwx1+jQZOASWJpC1wNRU9n1hNxIDBji1dL4P2wtbqVbxyoQRyJbVJ+kPntsOyXRIy6+TxGZ4GIzXFFBS2z+eHi5ux3C8jUiScV2mxi8atCQRvmSi/LX+KKbUkqTVpJgc3gyurcjpUE7LsgVEmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=3AJZLbex; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=VBZMpzSgUOv4cJtrWYNW7JwvJefPtoBU3kRrhiFPMkE=;
	b=3AJZLbexEiFbdTH6N4OcFuV2LwV2qsCUF9mSDzbhQPVxT7S+5CPrb0Uf6bsliWRDbUI5xA8gT
	F/YTLGYt15B6z2mfXnqXn0l8gpgMyV1R1sRVR9KekIL8vB39qu7R7S3aW+V8uUXN6FevvKtgwD5
	QIc93FYIDnIEM6+2XOi3yDg=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fhpPr095ZzpStd;
	Fri, 27 Mar 2026 13:01:04 +0800 (CST)
Received: from kwepemj500018.china.huawei.com (unknown [7.202.194.48])
	by mail.maildlp.com (Postfix) with ESMTPS id 08C9A2025F;
	Fri, 27 Mar 2026 13:06:43 +0800 (CST)
Received: from [10.174.178.79] (10.174.178.79) by
 kwepemj500018.china.huawei.com (7.202.194.48) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 27 Mar 2026 13:06:41 +0800
Message-ID: <e5aa3bb6-34e5-49de-b07a-47c8bac32420@huawei.com>
Date: Fri, 27 Mar 2026 13:06:41 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/3] gve: skip error logging for retryable
 AdminQ commands
To: Jordan Rhee <jordanrhee@google.com>
CC: Harshitha Ramamurthy <hramamurthy@google.com>, <joshwash@google.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <richardcochran@gmail.com>,
	<willemb@google.com>, <nktgrg@google.com>, <jfraker@google.com>,
	<ziweixiao@google.com>, <maolson@google.com>, <thostet@google.com>,
	<jefrogers@google.com>, <alok.a.tiwari@oracle.com>, <yyd@google.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<weiyongjun1@huawei.com>
References: <20260326224527.1044097-1-hramamurthy@google.com>
 <20260326224527.1044097-2-hramamurthy@google.com>
 <d5312a24-68d5-49e3-9787-9a01c8606d9a@huawei.com>
 <CA+mzVtsXm1M4G_qiuEZ4A_ttJk4NL-DP-Ceo=nFPWRNUSn6RBQ@mail.gmail.com>
From: Li Xiasong <lixiasong1@huawei.com>
In-Reply-To: <CA+mzVtsXm1M4G_qiuEZ4A_ttJk4NL-DP-Ceo=nFPWRNUSn6RBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemj500018.china.huawei.com (7.202.194.48)
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272373-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,vger.kernel.org,huawei.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lixiasong1@huawei.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:dkim,huawei.com:email,huawei.com:mid]
X-Rspamd-Queue-Id: 7D76833F354
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi, Jordan

On 3/27/2026 11:56 AM, Jordan Rhee wrote:
> Hi Li, thank you very much for the review. The intent is only to skip
> logging for *retryable* commands that return -EAGAIN. If a
> non-retryable command fails, we do want to log, even if it returns
> -EAGAIN.
> Jordan
>

Thanks for the explanation! I totally misread the condition - I confused
opcode with err because they both start with GVE_ADMINQ_.

The || makes perfect sense now. Sorry for the noise!

Best regards,
Li Xiasong

> 
> On Thu, Mar 26, 2026 at 7:28 PM Li Xiasong <lixiasong1@huawei.com> wrote:
>>
>> Hi,
>>
>> On 3/27/2026 6:45 AM, Harshitha Ramamurthy wrote:
>>> From: Jordan Rhee <jordanrhee@google.com>
>>>
>>> AdminQ commands may return -EAGAIN under certain transient conditions.
>>> These commands are intended to be retried by the driver, so logging
>>> a formal error to the system log is misleading and creates
>>> unnecessary noise.
>>>
>>> Modify the logging logic to skip the error message when the result
>>> is -EAGAIN.
>>>
>>> Reviewed-by: Joshua Washington <joshwash@google.com>
>>> Signed-off-by: Jordan Rhee <jordanrhee@google.com>
>>> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
>>> ---
>>>  drivers/net/ethernet/google/gve/gve_adminq.c | 26 +++++++++++++++-----
>>>  1 file changed, 20 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
>>> index 08587bf40ed4..c7834614c5f0 100644
>>> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
>>> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
>>> @@ -416,11 +416,6 @@ static bool gve_adminq_wait_for_cmd(struct gve_priv *priv, u32 prod_cnt)
>>>
>>>  static int gve_adminq_parse_err(struct gve_priv *priv, u32 status)
>>>  {
>>> -     if (status != GVE_ADMINQ_COMMAND_PASSED &&
>>> -         status != GVE_ADMINQ_COMMAND_UNSET) {
>>> -             dev_err(&priv->pdev->dev, "AQ command failed with status %d\n", status);
>>> -             priv->adminq_cmd_fail++;
>>> -     }
>>>       switch (status) {
>>>       case GVE_ADMINQ_COMMAND_PASSED:
>>>               return 0;
>>> @@ -455,6 +450,16 @@ static int gve_adminq_parse_err(struct gve_priv *priv, u32 status)
>>>       }
>>>  }
>>>
>>> +static bool gve_adminq_is_retryable(enum gve_adminq_opcodes opcode)
>>> +{
>>> +     switch (opcode) {
>>> +     case GVE_ADMINQ_REPORT_NIC_TIMESTAMP:
>>> +             return true;
>>> +     default:
>>> +             return false;
>>> +     }
>>> +}
>>> +
>>>  /* Flushes all AQ commands currently queued and waits for them to complete.
>>>   * If there are failures, it will return the first error.
>>>   */
>>> @@ -482,9 +487,18 @@ static int gve_adminq_kick_and_wait(struct gve_priv *priv)
>>>               cmd = &priv->adminq[i & priv->adminq_mask];
>>>               status = be32_to_cpu(READ_ONCE(cmd->status));
>>>               err = gve_adminq_parse_err(priv, status);
>>> -             if (err)
>>> +             if (err) {
>>> +                     enum gve_adminq_opcodes opcode =
>>> +                             be32_to_cpu(READ_ONCE(cmd->opcode));
>>> +                     priv->adminq_cmd_fail++;
>>> +                     if (!gve_adminq_is_retryable(opcode) || err != -EAGAIN)
>>
>> In gve_adminq_kick_and_wait(), the condition is:
>>
>>         if (!gve_adminq_is_retryable(opcode) || err != -EAGAIN)
>>                 dev_err_ratelimited(...);
>>
>> Based on the commit log, the goal is to skip logging when the result is
>> -EAGAIN for transient conditions. However, when gve_adminq_is_retryable()
>> returns false (e.g., GVE_ADMINQ_COMMAND_ERROR_ABORTED), even if err is
>> -EAGAIN, the condition evaluates to true and the error would still be logged.
>>
>> Would it be more appropriate to use && instead of || here?
>>
>>         if (!gve_adminq_is_retryable(opcode) && err != -EAGAIN)
>>
>> I may be missing something, so please let me know if I've misunderstood.
>>
>>> +                             dev_err_ratelimited(&priv->pdev->dev,
>>> +                                                 "AQ command %d failed with status %d\n",
>>> +                                                 opcode, status);
>>> +
>>>                       // Return the first error if we failed.
>>>                       return err;
>>> +             }
>>>       }
>>>
>>>       return 0;
>>
>> Best regards,
>> Li Xiasong

