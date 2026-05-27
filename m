Return-Path: <netdev+bounces-292297-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JS5eEjfvFmpwxgcAu9opvQ
	(envelope-from <netdev+bounces-292297-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:18:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A90845E4C6E
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B39453000501
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 13:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBA63F6601;
	Wed, 27 May 2026 13:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="VYK9aZFg"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820C43F58D8;
	Wed, 27 May 2026 13:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779887534; cv=none; b=iKVbY2sRD/t3fs0jmF73r6JXyF2yKansmebQZOaJmVZMOrGH5YFOutcXsibJpZkUYIQrjAIr09qz7OFbp2pOw/jsUYzdxKbNzzw9Cfu+z7BHIllNXtHYglNCt/feQIPLYEmWSrU1McRN/KSgp89DH8scfcNllZj3z0D/VdOK0l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779887534; c=relaxed/simple;
	bh=JMu4lmKH2onn3EqXwAM7YDaOOjPzuaC1EXCMSr27nbQ=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hMuccnzPaNom9X9D7ntvrX/mzuUZeCbjSBD3ZER4sOKsscJ6+ieZ5uC0gCspqVUi3kXOwmINTgiDKNU5r0zZpBUy3hfqNQHnmHDDjehwHKGNSYSRbwykMbv/onMCGAR1GlPyyFYQT2APvOrs3kdcSpneEsUJHOLW1KGuwrJewmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=VYK9aZFg; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=hDzoBGpDQYlcdcSRn6SaJg0BSJtIdvt0iOlgF2Qd13Q=;
	b=VYK9aZFgt36uwIRQEXvWGgNl/U53N8KCYNADgoSPQjdS9m++gMOo3lLztBlCdPhOU7a3EGiNV
	BP/AkukHl+C81OIDNeiz3Uw8bvvN2tk/Iz4qO+dzhBYcDawmUvMl4d7dTgJv5n/6BiSi55xLO6n
	OTOvPJCCXdYKyzxf6nXYXcU=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gQVDz5V49z12LCc;
	Wed, 27 May 2026 21:04:03 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 67B014048F;
	Wed, 27 May 2026 21:12:03 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 27 May 2026 21:12:02 +0800
Message-ID: <c6dc79ef-5f6e-4c97-97da-fa50eb1d1370@huawei.com>
Date: Wed, 27 May 2026 21:12:01 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<shenjian15@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 net-next 0/6] net: hns3: enhance tc flow offload
 support
To: Simon Horman <horms@kernel.org>
References: <20260523105449.661848-1-shaojijie@huawei.com>
 <20260527095930.GI2256768@horms.kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20260527095930.GI2256768@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk100013.china.huawei.com (7.202.194.61)
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292297-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A90845E4C6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


on 2026/5/27 17:59, Simon Horman wrote:
> On Sat, May 23, 2026 at 06:54:43PM +0800, Jijie Shao wrote:
>> This patchset enhances the tc flow offload support for hns3 driver:
>>
>> - Patch 1: Refactor hclge_add_cls_flower() to support more actions
>> - Patch 2: Improve unused_tuple parameter setting for separate src/dst configuration
>> - Patch 3: Add support for HCLGE_FD_ACTION_SELECT_QUEUE and HCLGE_FD_ACTION_DROP_PACKET actions
>> - Patch 4: Add support for FLOW_DISSECTOR_KEY_IP and FLOW_DISSECTOR_KEY_ENC_KEYID dissectors
>> - Patch 5: Add debugfs support for dumping FD rules
>> - Patch 6: Move FD code to a separate file (hclge_fd.c) for better code organization
>>
>> ---
>> ChangeLog:
>> v1 -> v2:
>>    - Fixed warnings similar to "warning: restricted __le32 degrades to integer",
>>      pointed out by Jakub
>>    - Fixed warnings related to
>>      "warning: diagnostic behavior may be improved by adding the 'format(printf, 5, 7)'",
>>      pointed out by Jakub
>>    v1: https://lore.kernel.org/all/20260518093526.1109595-1-shaojijie@huawei.com/
> Hi Juijie,
>
> There are AI-generated reviews of this patch-set available at
> https://netdev-ai.bots.linux.dev/ and https://sashiko.dev/

Hi,

I'm sorry, I don't understand how to use https://netdev-ai.bots.linux.dev/, it seems to require an API Token?
I find it difficult to locate my own patch-set in Recent Reviews.


Regarding https://sashiko.dev/, I checked and some of the issues are pre-existing issues,
not caused by the new features added in this patch-set.

Some others are related to the solution, which is the same as the ethtool -U  already supported by the driver.
I suggest keeping it consistent with ethtool -U for now.
I will also check later whether modifications are needed. If the suggestion is reasonable,
I will send a separate patch to fix the code for both tc flow and ethtool -U.

For the remaining issues related to debugfs, I suggest they can be rejected.

Thanks,
Jijie Shao


