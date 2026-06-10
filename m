Return-Path: <netdev+bounces-297424-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 37+nMyHhKGpjLQMAu9opvQ
	(envelope-from <netdev+bounces-297424-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 05:59:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1526665AF8
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 05:59:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=WdqRy6u3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297424-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297424-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9F4E301A7F2
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D05333A9CF;
	Wed, 10 Jun 2026 03:59:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E7B335564;
	Wed, 10 Jun 2026 03:59:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781063965; cv=none; b=pGj8BKCocBqZqgVCWsIh7dg5DdaKl/AuFDb77ixB4OptnMTYQCXihKOdkOu0M+1QQNsjro8CIxW966N/bJ40Rc43IczL38i+f+nRSr4kjf0JAoOkQn3aQLgh1MoNDsQlv/2Z3Uhc5Vbqy4vbcqi4f8i5YhDFYLpRKS7qUF80DHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781063965; c=relaxed/simple;
	bh=Dmz51v9w6Ls2qgeHfUsFwqv3UPHz5aq1fWSp+qLL6U4=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fK5mKrb42AfrDnD7WjlhzcS7WVcsR+79ceBIJnDg7hi7Ab3DM+YS8dMIJJakDhaU95LBjFw83lrkIS3KKb2noMECCvWRNd4SacPPyYwuaYwhdJEJWGUBKBRJxSC6i+e8gg4z7b+ljrpt4ECSZ7rt5j6aRuG/yDdbvYGBizczb7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=WdqRy6u3; arc=none smtp.client-ip=113.46.200.226
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=vYpQI444eCT/9B22GAgj2lgiHR0IYTAf7MYHj36rmus=;
	b=WdqRy6u30ZS5bvwebbt/9rDNWY3F2bH/h6ymCM7qN0VMuN7+BzXq0x6UIOg9uQwTnJOKIDQQR
	ri8dhrNz4xWiYeX4gkFqAcIo4FWPgVHpmtYDBH6L1ULq8vH2acrMvXFzfG4QqYlji0Ik8WSPhEC
	eOjx0DL/l4BdfmRC0YRaCwA=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gZsJn5mRhzKm4w;
	Wed, 10 Jun 2026 11:51:21 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 5AEFC40571;
	Wed, 10 Jun 2026 11:59:18 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 10 Jun 2026 11:59:17 +0800
Message-ID: <479aefe2-cca3-4868-9796-97c17b4436f5@huawei.com>
Date: Wed, 10 Jun 2026 11:59:17 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shenjian15@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 net-next 3/6] net: hns3: support two more actions for
 tc flow
To: Jakub Kicinski <kuba@kernel.org>
References: <20260602133337.2216918-1-shaojijie@huawei.com>
 <20260602133337.2216918-4-shaojijie@huawei.com>
 <20260605174021.7d4c6ec4@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20260605174021.7d4c6ec4@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk100013.china.huawei.com (7.202.194.61)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-297424-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:shaojijie@huawei.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:shenjian15@huawei.com,m:liuyonglong@huawei.com,m:chenhao418@huawei.com,m:huangdonghua3@h-partners.com,m:yangshuaisong@h-partners.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kuba@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D1526665AF8


on 2026/6/6 8:40, Jakub Kicinski wrote:
> On Tue, 2 Jun 2026 21:33:34 +0800 Jijie Shao wrote:
>> Currently, the driver supports only one action:HCLGE_FD_ACTION_SELECT_TC.
>>
>> This patch adds support for HCLGE_FD_ACTION_SELECT_QUEUE and
>> HCLGE_FD_ACTION_DROP_PACKET.
>>
>> A rule can have only one action. Therefore, the driver intercepts rules
>> that have multiple actions or no action.
>>
>> Note: The driver considers cls_flower->classid as an action:
>> HCLGE_FD_ACTION_SELECT_TC.
>>
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>> ---
>>   .../hisilicon/hns3/hns3pf/hclge_main.c        | 59 ++++++++++++++++---
>>   1 file changed, 52 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
>> index 5e1f76513622..aa85abda2909 100644
>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
>> @@ -7344,18 +7344,45 @@ static int hclge_get_tc_flower_action(struct hclge_dev *hdev,
>>   				      struct flow_cls_offload *cls_flower,
>>   				      struct hclge_fd_rule *rule)
>>   {
>> +	struct flow_rule *flow = flow_cls_offload_flow_rule(cls_flower);
>>   	struct hnae3_handle *handle = &hdev->vport[0].nic;
>> +	struct flow_action *action = &flow->action;
>> +	struct flow_action_entry *act;
>>   	int tc;
>>   
>> -	tc = tc_classid_to_hwtc(handle->netdev, cls_flower->classid);
>> -	if (tc < 0 || tc > hdev->tc_max) {
>> -		dev_err(&hdev->pdev->dev, "invalid traffic class: %d\n", tc);
>> -		return -EINVAL;
>> +	if (!flow_action_has_entries(&flow->action)) {
>> +		tc = tc_classid_to_hwtc(handle->netdev, cls_flower->classid);
>> +		if (tc < 0 || tc > hdev->tc_max) {
>> +			dev_err(&hdev->pdev->dev,
>> +				"invalid traffic class: %d\n", tc);
>> +			return -EINVAL;
>> +		}
>> +
>> +		rule->action = HCLGE_FD_ACTION_SELECT_TC;
>> +		rule->cls_flower.tc = tc;
>> +		return 0;
>>   	}
>>   
>> -	rule->action = HCLGE_FD_ACTION_SELECT_TC;
>> -	rule->cls_flower.tc = tc;
>> -	return 0;
>> +	act = &action->entries[0];
>> +	switch (act->id) {
>> +	case FLOW_ACTION_RX_QUEUE_MAPPING:
>> +		if (act->rx_queue >= handle->kinfo.num_tqps) {
>> +			dev_err(&hdev->pdev->dev,
>> +				"queue id (%u) should be less than %u\n",
>> +				act->rx_queue, handle->kinfo.num_tqps);
>> +			return -EINVAL;
>> +		}
>> +
>> +		rule->queue_id = act->rx_queue;
>> +		rule->action = HCLGE_FD_ACTION_SELECT_QUEUE;
>> +		return 0;
>> +	case FLOW_ACTION_DROP:
>> +		rule->action = HCLGE_FD_ACTION_DROP_PACKET;
>> +		return 0;
>> +	default:
>> +		dev_err(&hdev->pdev->dev, "unsupported action(%d)\n", act->id);
>> +		return -EOPNOTSUPP;
>> +	}
>>   }
>>   
>>   static int hclge_parse_cls_flower(struct hclge_dev *hdev,
>> @@ -7412,6 +7439,24 @@ static int hclge_check_cls_flower(struct hclge_dev *hdev,
>>   		return -EOPNOTSUPP;
>>   	}
>>   
>> +	/* driver will parses classid into an action */
>> +	if (cls_flower->classid && flow_action_has_entries(&flow->action)) {
>> +		dev_err(&hdev->pdev->dev,
>> +			"please not set classid and action together\n");
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	if (!flow_action_has_entries(&flow->action) && !cls_flower->classid) {
>> +		dev_err(&hdev->pdev->dev, "please set action or classid\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (flow_action_has_entries(&flow->action) &&
>> +	    !flow_offload_has_one_action(&flow->action)) {
>> +		dev_err(&hdev->pdev->dev, "unsupported multiple actions\n");
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>>   	return 0;
> Please use struct flow_cls_offload::common:extack and
> NL_SET_ERR_MSG_MOD() to return these to the caller instead of dumping
> them into the system logs.

Okay, I will modify all the error logs under hclge_add_cls_flower() to NL_SET_ERR_MSG_MOD().

Thanks,
Jijie Shao


