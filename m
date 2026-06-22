Return-Path: <netdev+bounces-301121-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +lFmM+k1OWpaogcAu9opvQ
	(envelope-from <netdev+bounces-301121-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 15:17:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2740A6AFBB8
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 15:17:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=oYvvp46q;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301121-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301121-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 772A83008A75
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 13:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2BE3B14B5;
	Mon, 22 Jun 2026 13:11:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7CD2DC78C;
	Mon, 22 Jun 2026 13:11:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782133878; cv=none; b=VYD1MeT6/LBVwZJbqbJDDtDj9SGyAFYsiFCtTN7THYhXXP6RFjI+gIM2Szyy9ej4u7/Y0HYLNzk4KGR0Uc0uBSSDeg6kuU+dcjyGWiFfz5e+vKEAISCRyDQUVrvn4cetBtvbCx1RrNJcxNE2HZ5KLO0SnkTf2lnmm4hAMJHxb9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782133878; c=relaxed/simple;
	bh=yO3caAyi4S8eGw5/PloG6r+/w21Exf8biz+9wTWqlAA=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qYeSa4ZgLEAvCLNlXwBUye//X/t7XOMEz3zfawQkfF/kaxoXcGuhELfv9bf4E+TfjHXBfYfMaTI6o+89gav9MgflIzny9utpPQyeB82c89o8iUxyWOE2k4+AFls9Dq97xSpI2Jytqdm+O+YEtGnVmfSL1zimIx+l4KFAspiGGoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=oYvvp46q; arc=none smtp.client-ip=113.46.200.224
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=eVfel96FTk2W3+UWJY9+QBd0QfGBeLxK7SJQgiKSUik=;
	b=oYvvp46qx6+RSbqcE7FcIbNHc3K66EMDOJHsKNaZvC9bAZTb4IoJvCLX6BDOZdUzNxN64GpKi
	ttGNM09anTUBaU58pF+lU8mOUg1yhgdZFsAjibRSbiP6QyuX70EviGq73CQaAluRBgqrmsg6kDt
	/aBoR6/8izrbGMLF6723omI=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gkSym3dJlz1cyTd;
	Mon, 22 Jun 2026 21:02:08 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 38ADB40563;
	Mon, 22 Jun 2026 21:11:11 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 22 Jun 2026 21:11:10 +0800
Message-ID: <17c623e2-9c7b-4e0a-a0ce-99c77dd0465e@huawei.com>
Date: Mon, 22 Jun 2026 21:11:09 +0800
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
Subject: Re: [PATCH net 4/5] net: hns3: differentiate autoneg default values
 between copper and fiber
To: Simon Horman <horms@kernel.org>
References: <20260617112721.75186-5-shaojijie@huawei.com>
 <20260618153450.909964-1-horms@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20260618153450.909964-1-horms@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-301121-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:shaojijie@huawei.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:shenjian15@huawei.com,m:liuyonglong@huawei.com,m:chenhao418@huawei.com,m:huangdonghua3@h-partners.com,m:yangshuaisong@h-partners.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:horms@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,sashiko.dev:url,huawei.com:dkim,huawei.com:mid,huawei.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2740A6AFBB8


on 2026/6/18 23:34, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> net: hns3: differentiate autoneg default values between copper and fiber
>
> This commit addresses a link loss issue during driver initialization on
> optical ports connected to forced-mode remote switches. It modifies
> hclge_init_ae_dev to set autonegotiation based on media type. Copper ports
> retain the AUTONEG_ENABLE default, while optical ports inherit the firmware
> pre-configured autoneg setting.
>
>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
>> @@ -11916,6 +11916,9 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
>>   	if (ret)
>>   		goto err_ptp_uninit;
>>   
>> +	if (hdev->hw.mac.media_type != HNAE3_MEDIA_TYPE_COPPER)
>> +		hdev->hw.mac.req_autoneg = hdev->hw.mac.autoneg;
>> +
> [Severity: High]
> Does this apply the wrong speed when autonegotiation is disabled on fiber
> ports?
>
> During driver initialization, hclge_update_port_info() dynamically probes
> the SFP module and updates mac->speed, but does not update mac->req_speed,
> which retains its statically configured default capability.
>
> When hdev->hw.mac.autoneg is 0 (forced-mode), req_autoneg becomes 0, and
> then hclge_set_autoneg_speed_dup() uses req_speed:
>
> drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c:hclge_set_autoneg_speed_dup() {
> ...
>      if (!hdev->hw.mac.req_autoneg) {
>          ret = hclge_cfg_mac_speed_dup_hw(hdev, hdev->hw.mac.req_speed,
> ...
> }
>
> Could this override the dynamically probed SFP speed with the static default
> speed?

[Reject] This is initializing the path. mac->speed has been parsed in hclge_configure()
          and an initial value has been assigned to req_speed.

>
> [Severity: High]
> Does this unconditionally disable autonegotiation for V1 optical hardware?
>
> Looking at hclge_update_port_info(), it only queries SFP information via
> hclge_get_sfp_info() for V2 hardware. For V1 hardware, it falls back to
> hclge_get_sfp_speed(), which leaves mac->autoneg uninitialized (0):
>
> drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c:hclge_update_port_info() {
> ...
>      if (hdev->ae_dev->dev_version >= HNAE3_DEVICE_VERSION_V2) {
>          speed = mac->speed;
>          ret = hclge_get_sfp_info(hdev, mac);
>      } else {
>          speed = HCLGE_MAC_SPEED_UNKNOWN;
>          ret = hclge_get_sfp_speed(hdev, &speed);
>      }
> ...
> }
>
> If mac->autoneg is left as 0, wouldn't req_autoneg unconditionally be set
> to 0 here, overriding the speed and breaking connectivity for V1 devices?

[Reject] No, this process is the same as before the modification.
        Before the modification, mac->autoneg was not actively assigned a value (it was initialized to 0 by default).

Thanks,
Jijie Shao



