Return-Path: <netdev+bounces-166273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3018A354D4
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 03:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A93AA169CA3
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 02:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2DC13C9C4;
	Fri, 14 Feb 2025 02:39:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D281519AB;
	Fri, 14 Feb 2025 02:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739500756; cv=none; b=oINcZkNy9rQeReUZo8av2L4qPmppx4ejtPv8MpwS8ebMJnnKzIry5obTduVrtTfy+439eYyRyrfE4aeDasokzPvfPmU23mmGNkP/jMp3aAEBpjIzbUA8JltrkARI9qZeosNVFDh2K28/4/u3lm/S4NIycOj9Wtfu3OUeECVYOxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739500756; c=relaxed/simple;
	bh=ggqllBKY0hZPDPykZ9eDSe4dSq6P5GCFoSX8bpONkyQ=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HD1lqdSJCD/eqUleBtsxWGY5cA9fo6oKstlWy3hT/zHlnB1NErZIWVTCGxz9uH8C+hML1cJ73cqosp7GKzMVTBcEoZLKhFE5ov9jSegz7+jQNKqEy2nyw3xGkdzcvdp4qgxBDXKszl/9X4GxPGvqZIHCb5wa6pV4bfjGytxhL54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4YvGNK5P6Mz1W5kg;
	Fri, 14 Feb 2025 10:34:41 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id E02B3140121;
	Fri, 14 Feb 2025 10:39:10 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 14 Feb 2025 10:39:09 +0800
Message-ID: <1d82f748-2173-4e24-9f4c-e2dd71c02c44@huawei.com>
Date: Fri, 14 Feb 2025 10:39:09 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 5/7] net: hibmcge: Add mac link exception
 handling feature in this module
To: Andrew Lunn <andrew@lunn.ch>
References: <20250213035529.2402283-1-shaojijie@huawei.com>
 <20250213035529.2402283-6-shaojijie@huawei.com>
 <dc22a252-2889-4b20-b72c-5e4d44d24f88@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <dc22a252-2889-4b20-b72c-5e4d44d24f88@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/2/14 4:05, Andrew Lunn wrote:
>> +int hbg_reset_phy(struct hbg_priv *priv)
>> +{
>> +	struct phy_device *phydev = priv->mac.phydev;
>> +
>> +	if (phydev->drv->soft_reset)
>> +		return phydev->drv->soft_reset(phydev);
>> +
>> +	return genphy_soft_reset(phydev);
>> +}
> A MAC driver should not be doing a soft reset on a PHY. For some
> devices, this clears out all the settings. I would suggest you use
> phy_stop(), phy_start() which are functions a MAC driver is allowed to
> use.
>
> 	Andrew

Well, I think your advice is helpful.

It is also a good practice to restart the PHY, which also triggers link relinking.

Thank you. I'll test this method.

Thanks,
Jijie Shao


