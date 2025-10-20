Return-Path: <netdev+bounces-230809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1750BEFCD8
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 10:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 999E43E665A
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 08:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45632E1F13;
	Mon, 20 Oct 2025 08:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="iH7nvxte"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1252E7F07
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 08:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760947646; cv=none; b=DMdK/Iahn70OzuFPd+VEnHN1Y5sWZ6VeXG1aijkngbtpUxYJAf/A/yZUj5+Qm7cAWlD/MjbMBZELcCJUvtpCo+Bab7H6CcD9VVSBaLzWkfJvk5vVEIeJZ86iC5IOVjU0iIgdR2BkIhfg9yshNxKWD8paMK9BXizXA+epIIM0Fm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760947646; c=relaxed/simple;
	bh=HuVNbez7OBN1WEPR+rZHmppb5potr/5m76iiPfQWXQU=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=djUuvqIVTLtfDwLtjqo3uNY/+XkmKr9zY2ldI2JZCdbmr4VYG0hv0DNrJGGUrC4WeOeUJwVT21AVzhBO42wYU0Vc9YUu/mezinF7YK/HzaYHHQ09E2FtN1b7nBxyAfQOICL9mX9wrpZ16Po0Fb8CFErJm8F70Q4E0woWyXNSOdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=iH7nvxte; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=6tnpgyCKryi6ByCC+dWtrCnPXhQDTMOYtYgcRDsV9xY=;
	b=iH7nvxteOEAqnHWv1O8KlQuB3MQWTYyIkY3xacc+jnxqpIQvSmyR5KBkXTXL+sMl597Euusfb
	S7e4KgG5ZSokxpSBlSw4IM7ecpVKUPSk9vvmJvff/XU8+/75EjjkY7aM0FbNh2qkuUtDyfy/GGm
	TyqWCqivImN7KQj5/jQyqIg=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4cqp1C6qB9zRhRF;
	Mon, 20 Oct 2025 16:06:55 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F6011402DA;
	Mon, 20 Oct 2025 16:07:19 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Oct 2025 16:07:18 +0800
Message-ID: <e932d815-5c06-4fd8-a766-72581b1865f0@huawei.com>
Date: Mon, 20 Oct 2025 16:07:18 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: hibmcge: select FIXED_PHY
To: Heiner Kallweit <hkallweit1@gmail.com>, Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, David
 Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
References: <c4fc061f-b6d5-418b-a0dc-6b238cdbedce@gmail.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <c4fc061f-b6d5-418b-a0dc-6b238cdbedce@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/10/20 14:54, Heiner Kallweit wrote:
> hibmcge uses fixed_phy_register() et al, but doesn't cater for the case
> that hibmcge is built-in and fixed_phy is a module. To solve this

hibmcge can also be set as a module.(CONFIG_HIBMCGE=m)

> select FIXED_PHY.

Thanks,
Reviewed-by: Jijie Shao <shaojijie@huawei.com>

>
> Note: This could also be treated as a fix, but as no problems are known,
> treat it as an improvement.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>   drivers/net/ethernet/hisilicon/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/ethernet/hisilicon/Kconfig b/drivers/net/ethernet/hisilicon/Kconfig
> index 65302c41b..38875c196 100644
> --- a/drivers/net/ethernet/hisilicon/Kconfig
> +++ b/drivers/net/ethernet/hisilicon/Kconfig
> @@ -148,6 +148,7 @@ config HIBMCGE
>   	tristate "Hisilicon BMC Gigabit Ethernet Device Support"
>   	depends on PCI && PCI_MSI
>   	select PHYLIB
> +	select FIXED_PHY
>   	select MOTORCOMM_PHY
>   	select REALTEK_PHY
>   	help

