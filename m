Return-Path: <netdev+bounces-292665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GY2LecmGGqZeQgAu9opvQ
	(envelope-from <netdev+bounces-292665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 13:28:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8944D5F14AD
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 13:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3944B306E510
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858BB3E1CEF;
	Thu, 28 May 2026 11:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="6PFAGr9Z"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6443A6B9A;
	Thu, 28 May 2026 11:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779967482; cv=none; b=tCW2LIW3OHhwI/FnE82ZVw8XQXuXc1Gbb2PdwI6q+/xPs0vqfFBgUpas+kvPrxiN4UKoxV5stOj9fUdFOJutL8IpTA7LCt8xwjS3f2vYmd4kC5eQ0YL9SB/nR3aERCMdqfCieZbO2D3A2kYW2Ktoqko2igr//x+XgCkD1ABhO1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779967482; c=relaxed/simple;
	bh=yuXBG/B9gH/1hIvH3jfdDXKNUZNx8b4035p1tc2Shck=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QgCp3r2gbtXhz4v6EHUjc3oUjtfyyCQub1Nj/MQFPm/F7UlICE11YbktPeMyBgYBZ7nva5Gp8UY3FDL/F+6WsqURUSFzBqef0BlCtWgzPAoza12yWrfX2gpThaVk7FJTg5VWNd1KvZzG0vEG/pM+VmsJqzmS2H2kgRtn6EUG+vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=6PFAGr9Z; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=4Mkq1/rL0bJ/xE6E013a9NXOcOz/DNiuxFDv3q8yMrk=;
	b=6PFAGr9Z9XyXnvAgv/4YwIVvjSDGQtgACjlAZxaRAqB1VHD0SA9Ytx8SIDyVb7XAeTqIwg0wV
	gzx/CtH6wDn0wlH6JC6g4mzMrU+Rcqk+AcNlZ9wMLBjFOHuVHD8U7tshPbZieKye9zPqbD93qMc
	B/5/ZgRYQ+b7FxwNKUC5rZ0=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gR3pg4chmzRhQm;
	Thu, 28 May 2026 19:16:43 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 996804056A;
	Thu, 28 May 2026 19:24:29 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 28 May 2026 19:24:28 +0800
Message-ID: <83f34836-c848-469a-9c1c-7f28bf3035fc@huawei.com>
Date: Thu, 28 May 2026 19:24:28 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <shenjian15@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 net-next 0/6] net: hns3: enhance tc flow offload
 support
To: Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
References: <20260523105449.661848-1-shaojijie@huawei.com>
 <20260527095930.GI2256768@horms.kernel.org>
 <c6dc79ef-5f6e-4c97-97da-fa50eb1d1370@huawei.com>
 <b0b0ac82-bcbf-4aef-bf6f-7340f9517fc6@redhat.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <b0b0ac82-bcbf-4aef-bf6f-7340f9517fc6@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk100013.china.huawei.com (7.202.194.61)
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292665-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:url,sashiko.dev:url,huawei.com:mid,huawei.com:dkim]
X-Rspamd-Queue-Id: 8944D5F14AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


on 2026/5/28 17:06, Paolo Abeni wrote:
> On 5/27/26 3:12 PM, Jijie Shao wrote:
>> on 2026/5/27 17:59, Simon Horman wrote:
>>> On Sat, May 23, 2026 at 06:54:43PM +0800, Jijie Shao wrote:
>>>> This patchset enhances the tc flow offload support for hns3 driver:
>>>>
>>>> - Patch 1: Refactor hclge_add_cls_flower() to support more actions
>>>> - Patch 2: Improve unused_tuple parameter setting for separate src/dst configuration
>>>> - Patch 3: Add support for HCLGE_FD_ACTION_SELECT_QUEUE and HCLGE_FD_ACTION_DROP_PACKET actions
>>>> - Patch 4: Add support for FLOW_DISSECTOR_KEY_IP and FLOW_DISSECTOR_KEY_ENC_KEYID dissectors
>>>> - Patch 5: Add debugfs support for dumping FD rules
>>>> - Patch 6: Move FD code to a separate file (hclge_fd.c) for better code organization
>>>>
>>>> ---
>>>> ChangeLog:
>>>> v1 -> v2:
>>>>     - Fixed warnings similar to "warning: restricted __le32 degrades to integer",
>>>>       pointed out by Jakub
>>>>     - Fixed warnings related to
>>>>       "warning: diagnostic behavior may be improved by adding the 'format(printf, 5, 7)'",
>>>>       pointed out by Jakub
>>>>     v1: https://lore.kernel.org/all/20260518093526.1109595-1-shaojijie@huawei.com/
>>> Hi Juijie,
>>>
>>> There are AI-generated reviews of this patch-set available at
>>> https://netdev-ai.bots.linux.dev/ and https://sashiko.dev/
>> Hi,
>>
>> I'm sorry, I don't understand how to use https://netdev-ai.bots.linux.dev/, it seems to require an API Token?
>> I find it difficult to locate my own patch-set in Recent Reviews.
> The nipa sashiko instance has the same web UI as sashiko.dev. The full
> URL for the former is:
>
> https://netdev-ai.bots.linux.dev/sashiko/
>
> You can lookup your series by the cover letter title or you can use the
> direct link including the msg id for the cover:
>
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260523105449.661848-1-shaojijie%40huawei.com

Thanks,

It appears that the two URLs mentioned by Simon Horman are the results of the one AI-generated reviews.


>
>> Regarding https://sashiko.dev/, I checked and some of the issues are pre-existing issues,
>> not caused by the new features added in this patch-set.
>>
>> Some others are related to the solution, which is the same as the ethtool -U  already supported by the driver.
>> I suggest keeping it consistent with ethtool -U for now.
> I'm not sure which comment do you refer above.
>
> This one:
>
> ---
>> +		if (is_zero_ether_addr(match.key->dst))
>> +			rule->unused_tuple |= BIT(INNER_DST_MAC);
>> +		if (is_zero_ether_addr(match.key->src))
>> +			rule->unused_tuple |= BIT(INNER_SRC_MAC);
> Should the "is this tuple unused" decision be driven by the mask
> rather than the key?
> A tc-flower rule that explicitly matches an all-zero address, for
> example:
>      tc filter add ... flower dst_mac 00:00:00:00:00:00 ...
>      tc filter add ... flower src_ip 0.0.0.0 ...
>      tc filter add ... flower src_ip :: ...
> produces match.key->{src,dst} == 0 with match.mask->{src,dst} set to
> all-ones. With the new checks above, those rules now have
> INNER_{SRC,DST}_MAC / INNER_{SRC,DST}_IP added to rule->unused_tuple
> even though the user asked to match exactly that address.
> Downstream, hclge_fd_convert_tuple() short-circuits on unused_tuple:
>      if (rule->unused_tuple & BIT(tuple_bit))
>          return true;
> so the tuple is not programmed into the TCAM key and the field is
> effectively wildcarded in hardware, with no -EINVAL or extack returned
> to the user.
> Real-world patterns that rely on all-zero addresses include DHCPv4
> DISCOVER (src 0.0.0.0), IPv6 DAD/NUD probes and DHCPv6 (src ::), and
> deliberate matches on the all-zero MAC.
> ---
>
> and similar later ones look real/relevant to me, and IMHO should be
> addressed.

Yes, I saw this issue. There is similar logic in the existing function hclge_fd_check_ether_tuple():

static int hclge_fd_check_ether_tuple(struct ethhdr *spec, u32 *unused_tuple)
{
	if (!spec || !unused_tuple)
		return -EINVAL;

	*unused_tuple |= BIT(INNER_SRC_IP) | BIT(INNER_DST_IP) |
		BIT(INNER_SRC_PORT) | BIT(INNER_DST_PORT) |
		BIT(INNER_IP_TOS) | BIT(INNER_IP_PROTO);

	if (is_zero_ether_addr(spec->h_source))
		*unused_tuple |= BIT(INNER_SRC_MAC);

	if (is_zero_ether_addr(spec->h_dest))
		*unused_tuple |= BIT(INNER_DST_MAC);

	if (!spec->h_proto)
		*unused_tuple |= BIT(INNER_ETH_TYPE);

	return 0;
}

This looks like a common problem for hns3. My original idea was to send a separate bugfix later to fix all the all-zero MAC or IP addresses.
The current tc flow implementation logic is consistent with ethtool -U.

Alternatively, I can first fix the tc flow issue in v4, and then submit a bugfix later to fix the potential issues in ethtool -U.

Thanks,
Jijie Shao.





