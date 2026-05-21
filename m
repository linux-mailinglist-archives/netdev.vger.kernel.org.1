Return-Path: <netdev+bounces-290345-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DYrEgbmDmopDAYAu9opvQ
	(envelope-from <netdev+bounces-290345-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:01:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9C15A3B58
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC63530D8643
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 10:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EC83A1688;
	Thu, 21 May 2026 10:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="WXMZyTGY"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F62037B402;
	Thu, 21 May 2026 10:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779359941; cv=none; b=LkRp00uFpuEDMm68jAx8nSWtQybbrsNMe90PBPTF8lO4za0DVoFkIqvqXGiJiShbRF0OqgAG+BzjqAYHxZRC+1MiFX5/ZviR7mHHWeqS1ylIvTmZVH18ULG6SRuerBKJecT7JiokK9iLRksNYwBDiOaQt3RrV9AESIanUlQXH0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779359941; c=relaxed/simple;
	bh=/9/OZLIaJNpoLv+Ab0S1dgpd06WYFOit18dZsmNiFHs=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PKQuLU0ilnINtgqwAPTqghL7RHCN74e7OtUcw6P3Fot4DwQIHJzkI/xDv7iUAkuz/BdC7y4Mqhy3kOlrGFKcHxXuLfJmzA1dh8G2SZLCZgdlc6VfkgFeNqjfcYe+2Zb9BbphFMXzP6ugFEKERf8Vnu+J4P2fN9ll1bskD9E49Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=WXMZyTGY; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=/9/OZLIaJNpoLv+Ab0S1dgpd06WYFOit18dZsmNiFHs=;
	b=WXMZyTGY68AQeR5lOM8Vmx4eJCnKUclz+fRk5aOlwmoCtt9sMZeoio3/LPK7rVxwDBe32Cmft
	FXQzWezBEQSuW3w8nG/sz91IvI7XdYK2+k+2ViNkRrPCY+VNU4aKG69ux80Q0+Usl7peDSsQV8k
	cRu8zFeHCIZCcRrt+N5yy+w=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gLl7F54bqzKm5G;
	Thu, 21 May 2026 18:31:05 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 2CB9440561;
	Thu, 21 May 2026 18:38:50 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 21 May 2026 18:38:49 +0800
Message-ID: <1dd58308-6c4c-4449-9c82-f9abfb4fc6ba@huawei.com>
Date: Thu, 21 May 2026 18:38:48 +0800
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
Subject: Re: [PATCH net-next 4/6] net: hns3: support IP and tunnel VNI
 dissectors for tc flow
To: Jakub Kicinski <kuba@kernel.org>
References: <20260518093526.1109595-1-shaojijie@huawei.com>
 <20260518093526.1109595-5-shaojijie@huawei.com>
 <20260519184839.4501f720@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20260519184839.4501f720@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk100013.china.huawei.com (7.202.194.61)
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290345-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[huawei.com:query timed out];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huawei.com:mid,huawei.com:dkim]
X-Rspamd-Queue-Id: 4B9C15A3B58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


on 2026/5/20 9:48, Jakub Kicinski wrote:
> On Mon, 18 May 2026 17:35:24 +0800 Jijie Shao wrote:
>> Currently, the driver does not support FLOW_DISSECTOR_KEY_IP and
>> FLOW_DISSECTOR_KEY_ENC_KEYID. But the hardware supports
>> ip_tos (FLOW_DISSECTOR_KEY_IP) and
>> outer_tun_vni (FLOW_DISSECTOR_KEY_ENC_KEYID).
>>
>> This patch adds support for FLOW_DISSECTOR_KEY_IP and
>> FLOW_DISSECTOR_KEY_ENC_KEYID.
>>
>> Additionally, since tc flow cannot effectively support
>> l2_user_def, l3_user_def, and l4_user_def,
>> this patch explicitly sets them to not be used.
> drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c:5771:37: warning: restricted __le32 degrades to integer
> drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c:5773:37: warning: restricted __le32 degrades to integer
> drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c:7369:31: warning: restricted __be32 degrades to integer


Thank you for the reminder.
I noticed that when I compiled it myself before, there was an issue with the sparse version being unavailable,
which I hadn't noticed earlier.

After I upgrade sparse from 0.6.4 to 0.6.5-rc1, I will fix these warnings and resend these patches.
Reminder: https://www.kernel.org/pub/software/devel/sparse/dist/ does not collect the latest version.

Thanks,
Jijie Shao



