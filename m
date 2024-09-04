Return-Path: <netdev+bounces-124776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B6496ADF6
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 03:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7271828602F
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 01:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5611D8479;
	Wed,  4 Sep 2024 01:34:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7A16FB0;
	Wed,  4 Sep 2024 01:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725413692; cv=none; b=pf7EFxoeSSReZRXsylwraf30ocwsaKzodL5u0aR0eoK79/ju7JemZ4PZ3amNSchDs10vEerzkz8i12uQaunA8s1CKXSMt1VgVTOnHtHGQV0UVCaWCA7Xgk8rclX0apUo2GfyKMPuMsUncq2ilSiDukagWMgbAXvgCThHMoKyI1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725413692; c=relaxed/simple;
	bh=/yxz+pWqjJQREexM5ADMn9Lt93zR1fHFhywmxz3jKfU=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hVijrrLbHtBJEkcN9fY/OXZuJ/irBV/TGnoBnRZakwilAWd12idCB1muXclu/Ap7WEonsJmxGLnX3z5rd+Q6bwTWNlhClozRvm85bvQYcX3uUuqj/+w17n4/9E8QrMaVK+wRHX4CtHQyZoXeOKMakn+05DocDwERntAG8XYVRWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wz4lL4zDwzyR7Q;
	Wed,  4 Sep 2024 09:33:50 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id D44DF180105;
	Wed,  4 Sep 2024 09:34:47 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 09:34:46 +0800
Message-ID: <a86835c6-24d8-4f04-979e-a77d35776467@huawei.com>
Date: Wed, 4 Sep 2024 09:34:45 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, Paolo Abeni <pabeni@redhat.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <shenjian15@huawei.com>,
	<wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<sudongming1@huawei.com>, <xujunsheng@huawei.com>, <shiyongbang@huawei.com>,
	<libaihan@huawei.com>, <andrew@lunn.ch>, <jdamato@fastly.com>,
	<horms@kernel.org>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V6 net-next 03/11] net: hibmcge: Add mdio and hardware
 configuration supported in this module
To: Jakub Kicinski <kuba@kernel.org>
References: <20240830121604.2250904-1-shaojijie@huawei.com>
 <20240830121604.2250904-4-shaojijie@huawei.com>
 <0ff20687-74de-4e63-90f4-57cf06795990@redhat.com>
 <0341f08c-fe8b-4f9c-961e-9b773d67d7bf@huawei.com>
 <20240903104407.31a7cde6@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20240903104407.31a7cde6@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/9/4 1:44, Jakub Kicinski wrote:
> On Tue, 3 Sep 2024 20:13:58 +0800 Jijie Shao wrote:
>>>> +{
>>>> +    struct hbg_priv *priv = netdev_priv(netdev);
>>>> +    struct phy_device *phydev = priv->mac.phydev;
>>> Minor nit: please respect the reverse x-mas tree order
>> Here, I need to get the *priv first, so I'm not following the reverse x-mas tree order here.
>> I respect the reverse x-mas tree order everywhere else.
> In this case you should move the init into the body of the function.

ok， Thanks! Jijie Shao


