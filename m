Return-Path: <netdev+bounces-233081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0656CC0BEA0
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 07:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EA084EE5A0
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 06:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267AE2D9EF4;
	Mon, 27 Oct 2025 06:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Nm9kZX4b"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD2627FD62;
	Mon, 27 Oct 2025 06:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761545491; cv=none; b=UxQK84/omkfyLqCYB/MlgDMwFeXmbY0khfiWTIo/TDwr6txMYyiEhM5LyeGPE3eMsZLCKczpXdHN970w61e4kfLMqo9tNW3dWkrhOIJAvo59KgX5q3x0WupK9Wi4TCuoDsLjBZRvjcy1TNGkcyVwePxr70ex7dOHZpeeLFvOd2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761545491; c=relaxed/simple;
	bh=cntqfXxT1Qhp0sdDSsUHNzX5CNHB9d1v+Yy+uTCRo0A=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fA5+3ceQNZIje0YS7jzyewWRiw94T/MapxoF5Ysr7SCuMcCz2Jxd7MsmlRokyPTQFj027moG8BKPJ96lfpHPXSsoXB1l2sGvkALRj6CDgnzt11XTMcAPL8afsEKyv5lrb+6Bi2wPNMaOlXEj7HhnyJ0So+Z6hJ4/6nbb0ribGLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Nm9kZX4b; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=TMUs/ucMAf7vLbvKotDBlLyJQtlAH147syuwMq7y3ZQ=;
	b=Nm9kZX4boUFlHbQFVz+q4+50Fcei0K87KrG98tqWw1PKB7+dAQLahRQuEZJ1LMGnviHbYzPIe
	0PipPWdmFborBSf0f8VgogXuK/xV+fWkAQnM/6zstUnr4IQvNiZhnaYoRMk/hLU/SHqVUAKoLgg
	rSzEe4HwBA4LSr0MEZTqCKA=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4cw35z0GPBz12LDD;
	Mon, 27 Oct 2025 14:10:47 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 712DF18007F;
	Mon, 27 Oct 2025 14:11:25 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 27 Oct 2025 14:11:24 +0800
Message-ID: <80fb8bee-20bf-4eea-9719-045e85f8f181@huawei.com>
Date: Mon, 27 Oct 2025 14:11:23 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: phy: motorcomm: Add support for PHY LEDs on YT8531
To: Tianling Shen <cnsztl@gmail.com>, Frank Sae <Frank.Sae@motor-comm.com>,
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell
 King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
References: <20251026133652.1288732-1-cnsztl@gmail.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20251026133652.1288732-1-cnsztl@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/10/26 21:36, Tianling Shen wrote:
> The LED registers on YT8531 are exactly same as YT8521, so simply
> reuse yt8521_led_hw_* functions.
>
> Tested on OrangePi R1 Plus LTS and Zero3.
>
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>

Reviewed-by: Jijie Shao<shaojijie@huawei.com>

> ---
>   drivers/net/phy/motorcomm.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
> index a3593e663059..89b5b19a9bd2 100644
> --- a/drivers/net/phy/motorcomm.c
> +++ b/drivers/net/phy/motorcomm.c
> @@ -3048,6 +3048,9 @@ static struct phy_driver motorcomm_phy_drvs[] = {
>   		.get_wol	= ytphy_get_wol,
>   		.set_wol	= yt8531_set_wol,
>   		.link_change_notify = yt8531_link_change_notify,
> +		.led_hw_is_supported = yt8521_led_hw_is_supported,
> +		.led_hw_control_set = yt8521_led_hw_control_set,
> +		.led_hw_control_get = yt8521_led_hw_control_get,
>   	},
>   	{
>   		PHY_ID_MATCH_EXACT(PHY_ID_YT8531S),

