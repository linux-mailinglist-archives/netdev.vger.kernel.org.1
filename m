Return-Path: <netdev+bounces-301125-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MjpnIi43OWrVogcAu9opvQ
	(envelope-from <netdev+bounces-301125-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 15:22:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C366AFCC5
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 15:22:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=NGVDYNAv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301125-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-301125-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 14BD83042F92
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 13:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68693B3C1A;
	Mon, 22 Jun 2026 13:19:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44373B38AB;
	Mon, 22 Jun 2026 13:19:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782134350; cv=none; b=bUGGEp12zmdaPAyvXmUuK94/TXF97ZjC6AQk4/+7YM2s4DtM/v9yMQn57Z2SrDwRooSlW1veZ+R2lUsSJzra2yTT2uDmFFCEdtQmm/TvSf+aSYlHdT5Y7G8lTZlrxEpyjkESBj2C86rjiGQBLDsMzZ8GJP6+M0b0Y4BTQmhvxQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782134350; c=relaxed/simple;
	bh=3pdB/XjgkHFTOkJ4kEf12AXoLA8BDeHnIt7V7LSeqII=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lrKDkBFSTQXMzoe9kOYHRa+ExmZFI7YldbBt4zCerD7mOod8YQLn3KOjpaP4npTOSEQmFzTU3rC0XdDZXhrbyaJepO/JZXCssnMokZhX0LhrE8DIATALPiLJ7KksOx0AHaTd/f2GRNY4z15xeA/WyXnA0CSjWFd3zEiw7Kck0Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=NGVDYNAv; arc=none smtp.client-ip=113.46.200.219
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=DgTTBt07eGD/Kr481VkJQGBWHcQK1BL3dAGRvwCjcXY=;
	b=NGVDYNAvUlYQ7z7+uIni2nbk10Kst3lDg4siakF3Uj6l+PSGQYJ20iMMKBjaiwrDPcPsUeN8g
	GBHwA8/NprW6BXgqivWsrWDcAJ6JmLunM+U5HPmDzGtEUUc0uhmb3RgJKMfLPHj5J/qA4llz/GX
	TRS8xizRilMNZ1BZMOXOfG8=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gkT8w0by7z1prLJ;
	Mon, 22 Jun 2026 21:10:56 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 88F7D40538;
	Mon, 22 Jun 2026 21:19:00 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 22 Jun 2026 21:18:59 +0800
Message-ID: <9a5822f6-40bd-47b9-9683-7fffb8154faf@huawei.com>
Date: Mon, 22 Jun 2026 21:18:59 +0800
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
Subject: Re: [PATCH net 2/5] net: hns3: refactor MAC autoneg and speed
 configuration
To: Simon Horman <horms@kernel.org>
References: <20260617112721.75186-3-shaojijie@huawei.com>
 <20260618153419.909913-1-horms@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20260618153419.909913-1-horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemo500018.china.huawei.com (7.202.195.199)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:shaojijie@huawei.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:shenjian15@huawei.com,m:liuyonglong@huawei.com,m:chenhao418@huawei.com,m:huangdonghua3@h-partners.com,m:yangshuaisong@h-partners.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:horms@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301125-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E6C366AFCC5


on 2026/6/18 23:34, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> net: hns3: refactor MAC autoneg and speed configuration
>
> This refactor extracts the MAC autoneg and speed/duplex/lane configuration
> out of hclge_mac_init() into a new helper hclge_set_autoneg_speed_dup(),
> and invokes it from both hclge_init_ae_dev() and hclge_reset_ae_dev().
>
>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
>> index 5a00797d9252..2c74675b149f 100644
>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
>> @@ -2957,20 +2957,6 @@ static int hclge_mac_init(struct hclge_dev *hdev)
>>   	if (!test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state))
>>   		hdev->hw.mac.duplex = HCLGE_MAC_FULL;
>>   
>> -	if (hdev->hw.mac.support_autoneg) {
>> -		ret = hclge_set_autoneg_en(hdev, hdev->hw.mac.autoneg);
>> -		if (ret)
>> -			return ret;
>> -	}
>> -
>> -	if (!hdev->hw.mac.autoneg) {
>> -		ret = hclge_cfg_mac_speed_dup_hw(hdev, hdev->hw.mac.req_speed,
>> -						 hdev->hw.mac.req_duplex,
>> -						 hdev->hw.mac.lane_num);
>> -		if (ret)
>> -			return ret;
>> -	}
>> -
>>   	mac->link = 0;
> [ ... ]
>
>> @@ -11901,6 +11908,13 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
>>   	if (ret)
>>   		goto err_ptp_uninit;
>>   
>> +	ret = hclge_set_autoneg_speed_dup(hdev);
>> +	if (ret) {
>> +		dev_err(&pdev->dev,
>> +			"failed to set autoneg speed duplex, ret = %d\n", ret);
>> +		goto err_ptp_uninit;
>> +	}
>> +
> [High]
>
> Has the relocation of the autoneg/speed configuration in hclge_init_ae_dev()
> been considered against the surrounding init order?
>
> Previously the equivalent calls ran inside hclge_mac_init() before
> hclge_update_port_info(). After this patch the helper runs after
> hclge_update_port_info(), and hclge_update_port_info() ->
> hclge_get_sfp_info() unconditionally overwrites hdev->hw.mac.autoneg,
> hdev->hw.mac.support_autoneg and hdev->hw.mac.lane_num from firmware
> whenever resp->speed_ability is non-zero.
>
> The new helper then feeds the firmware-supplied lane_num back through:
>
>      if (!hdev->hw.mac.autoneg) {
>          ret = hclge_cfg_mac_speed_dup_hw(hdev, hdev->hw.mac.req_speed,
>                                           hdev->hw.mac.req_duplex,
>                                           hdev->hw.mac.lane_num);
>
> On a non-copper port where firmware reports forced mode (autoneg=0) and a
> stale lane_num inherited from a previous link lifecycle (for example
> lane_num=4 from a prior 100G state), the (req_speed, lane_num) pair given
> to hclge_cfg_mac_speed_dup_hw() can be inconsistent (for example 25G with
> 4 lanes), and firmware rejects it with -EINVAL, which propagates back to
> hclge_init_ae_dev() and unwinds via err_ptp_uninit, failing the entire
> probe.
>
> The follow-up commit a7e52c16ecbf "net: hns3: fix init failure caused by
> lane_num contamination" later in this series fixes this by introducing a
> separate req_lane_num=0 and passing that to hclge_cfg_mac_speed_dup_hw()
> instead of mac.lane_num. Should the fix be folded into this patch so the
> series does not introduce a probe-failure regression at this point and
> then repair it?

[Accepted] This issue has been fixed in the patch "net: hns3: Fix initialization failure caused by lane_num pollution."
		It is recommended that I merge that patch with the current patch. Sure.

>
> [Medium]
>
> After this change, the last write to MAC speed/duplex on the init path is
> hclge_cfg_mac_speed_dup_hw() inside the new helper, which programs
> hardware but does not update the cached hdev->hw.mac.speed and
> hdev->hw.mac.duplex. Previously the last writer was
> hclge_cfg_mac_speed_dup() inside hclge_update_port_info(), which updates
> both hardware and the cached fields.
>
> When req_speed differs from the firmware-reported mac.speed (which can
> happen if the active SFP speed differs from cfg.default_speed parsed in
> hclge_configure()), is hardware left programmed with req_speed while
> mac.speed retains the firmware-reported value, leaving the cache out of
> sync with the actual hardware configuration until the periodic service
> task refreshes mac.speed?

[Reject] Yes, Therefore, this issue is not a valid question.

>
>> @@ -12231,6 +12245,13 @@ static int hclge_reset_ae_dev(struct hnae3_ae_dev *ae_dev)
>>   		return ret;
>>   	}
>>   
>> +	ret = hclge_set_autoneg_speed_dup(hdev);
>> +	if (ret) {
>> +		dev_err(&pdev->dev,
>> +			"failed to set autoneg speed duplex, ret = %d\n", ret);
>> +		return ret;
>> +	}
>> +
>>   	ret = hclge_tp_port_init(hdev);
>>   	if (ret) {
>>   		dev_err(&pdev->dev, "failed to init tp port, ret = %d\n",
> [Low]
>
> Could the commit message be tightened to match the resulting code?
>
> The message says the helper "will also be invoked during the hardware
> reset recovery path to re-apply link settings without repeating
> unnecessary buffer or MTU initializations." However hclge_reset_ae_dev()
> still calls hclge_mac_init() immediately before hclge_set_autoneg_speed_dup(),
> and hclge_mac_init() still performs hclge_set_mac_mtu(),
> hclge_set_default_loopback() and hclge_buffer_alloc(), so the avoidance
> of MTU/buffer re-initialization described in the changelog is not
> realized here.
>
> The commit message is also framed as a pure readability/cyclomatic-
> complexity refactor, but the autoneg/speed configuration is not just
> extracted: in hclge_init_ae_dev() it is moved to a materially later
> point (after hclge_update_port_info(), TSO, GRO, VLAN, TM, RSS, FD and
> PTP setup), versus the original code where it was the very first
> hardware-touching step inside hclge_mac_init(). The reset path keeps the
> original relative ordering (helper runs immediately after
> hclge_mac_init()), so the init and reset paths are now asymmetric in
> placement, and the rationale for the late placement on the init path is
> not stated.

[Accepted] ok


