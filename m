Return-Path: <netdev+bounces-265483-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wO9vIcOtrmkSHwIAu9opvQ
	(envelope-from <netdev+bounces-265483-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 12:23:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 014CF237DFC
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 12:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 490FA30902E8
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 11:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF6B37C0FE;
	Mon,  9 Mar 2026 11:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Oru6S4l4"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D153352C22;
	Mon,  9 Mar 2026 11:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773055104; cv=none; b=ae0TW4SEMMFnQWxSjqhxMTTaP+UE5O+jUJNhl7s7Z9l7wck3uctrBU4FJFx6ZK7l/3jm1o2fHWBEOqro3SjvsRF9E4ZHQjwTaQfpAcGYlW+MMbjx/1nanvGsTZw6uIV0AD5Hkc+nq6UwVdySBFm6xS3yY7oTtP0ZK7HquISdyNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773055104; c=relaxed/simple;
	bh=n5UlwxmMeYfIU0Vd6l8rlLL17BMj+86T/MaEHpPU7gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mOpBoBsCT8QEmdMSk3/ITj0h0G6wYqkU26KiuJNCKsSpoppPg7GWbT0769I+gcjH/Ybwisae9NazTOtCbYHEeEDkoBm4avMHI+ixXv2wf5sM4x+TVxPm0p5I21QT50dzRW1Fr1gFJFhCzYNkcBE+xDNDcsatoHMYgRSZwGtqLSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Oru6S4l4; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Vcn9sXKUQjTbx8US5qzXWB2GYmzPdG2jA4kyqPRT4W4=;
	b=Oru6S4l43cTV335z03g06bLfT+l/1tCwZrkDlibmTAMjmN0Cq/kzg+8K7O/ws9hCSN3AS6usL
	4aXtWB7xNhq9+p4wasUWHZB69EDzeXTejWzsnGdA+HQBntHspndXIo8CzTguck8lgE+tsN+cMEn
	LSrAhBZSnhrzL+nh6VLDR9U=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fTvWV1GTlzpSwC;
	Mon,  9 Mar 2026 19:13:10 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 68F1740561;
	Mon,  9 Mar 2026 19:18:18 +0800 (CST)
Received: from kwepemq200017.china.huawei.com (7.202.195.228) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 9 Mar 2026 19:18:18 +0800
Received: from [10.67.109.91] (10.67.109.91) by kwepemq200017.china.huawei.com
 (7.202.195.228) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Mar
 2026 19:18:17 +0800
Message-ID: <83b7b096-987c-4fdd-a8d2-a5758a537347@huawei.com>
Date: Mon, 9 Mar 2026 19:18:16 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] dpaa2-switch: Add depend on FSL_DPAA2_ETH to
 FSL_DPAA2_SWITCH
To: Ioana Ciornei <ioana.ciornei@nxp.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260303013814.338989-1-caixinchen1@huawei.com>
 <gjtjhvka6azuahiga6o5a4dgg2gm7dae3io5fbvjjmbovgxrfr@pqgfhzon6tbb>
Content-Language: en-US
From: Cai Xinchen <caixinchen1@huawei.com>
In-Reply-To: <gjtjhvka6azuahiga6o5a4dgg2gm7dae3io5fbvjjmbovgxrfr@pqgfhzon6tbb>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemq200017.china.huawei.com (7.202.195.228)
X-Rspamd-Queue-Id: 014CF237DFC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265483-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[caixinchen1@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.978];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Yes, it is better solution. I will send v2. Thank you.

On 3/4/2026 6:23 PM, Ioana Ciornei wrote:
> On Tue, Mar 03, 2026 at 01:38:14AM +0000, Cai Xinchen wrote:
>> When CONFIG_FSL_DPAA2_ETH=n, dpaa2 cannot be compiled. Thus Add
>> depend on FSL_DPAA2_ETH to FSL_DPAA2_SWITCH in Kconfig
> There is no code dependency between the dpaa2-switch driver and the
> dpaa2-eth one, just a compile time one dictated by how
> freescale/Makefile includes the dpaa2/ folder.
>
> How about we always include the folder and let dpaa2/Makefile handle
> what objects to include depending on the individual Kconfig options?
> Something like the diff below:
>
> --- a/drivers/net/ethernet/freescale/Makefile
> +++ b/drivers/net/ethernet/freescale/Makefile
> @@ -22,6 +22,5 @@ ucc_geth_driver-objs := ucc_geth.o ucc_geth_ethtool.o
>   obj-$(CONFIG_FSL_FMAN) += fman/
>   obj-$(CONFIG_FSL_DPAA_ETH) += dpaa/
>
> -obj-$(CONFIG_FSL_DPAA2_ETH) += dpaa2/
> -
> +obj-y += dpaa2/
>   obj-y += enetc/
>
> And I just realised that commit 84cba72956fd ("dpaa2-switch: integrate
> the MAC endpoint support") included dpaa2-mac.o in the driver switch
> objects but didn't amend the Kconfig to specify that PCS_LYNX, PHYLINK
> and FSL_XGMAC_MDIO should be selected. Could you please also fix that as
> a separate patch? Otherwise, I can take care of it.
>
> Thanks!

