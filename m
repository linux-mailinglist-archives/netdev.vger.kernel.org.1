Return-Path: <netdev+bounces-123033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A01A963801
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 03:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69F9E1C21F71
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 01:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E924D1BC41;
	Thu, 29 Aug 2024 01:54:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D6A134B1;
	Thu, 29 Aug 2024 01:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724896447; cv=none; b=bc6F63GMuExJY/CrCRm4oG24/vyilHDlznnX2VBA1GyC4VXRtVh1av1CJdutXT5PAk2TdezMw2uGItNv53K/DIuf5Kho2dBLPV947Oe3+Te7uVZxLsmRGv21RinSVk02QVT81RsxfPgOf4bNF0WQDaLiumMk4uF7t185saBR+BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724896447; c=relaxed/simple;
	bh=MlrD/nYIUG5TqB8ZODlAENXKUOq+QGkYEWx6XBLlAY0=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZckRu34RaA40NG838CgqPpbIYxlnlqPS+0ySfkUZXCau7vDWzkqVyiC00Y4GMsQMxCOUBDni7t2tvPu2xHl7VKt0YfBlh596dMCzmXOF0irVpgPP59vbIcXuooDXvDMp0dUTz8xpZmh2GKputE8H3Tzdy9EHri3bKvJ0l7FFPPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WvPTB1pdjz2DbZ9;
	Thu, 29 Aug 2024 09:53:50 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 5E38D140203;
	Thu, 29 Aug 2024 09:54:02 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 Aug 2024 09:54:01 +0800
Message-ID: <6c7d1538-5a94-466a-bd4b-022b5570b287@huawei.com>
Date: Thu, 29 Aug 2024 09:54:00 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<andrew@lunn.ch>, <jdamato@fastly.com>, <horms@kernel.org>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 net-next 04/11] net: hibmcge: Add interrupt supported
 in this module
To: Jakub Kicinski <kuba@kernel.org>
References: <20240827131455.2919051-1-shaojijie@huawei.com>
 <20240827131455.2919051-5-shaojijie@huawei.com>
 <20240828183536.130df0fa@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20240828183536.130df0fa@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/8/29 9:35, Jakub Kicinski wrote:
> On Tue, 27 Aug 2024 21:14:48 +0800 Jijie Shao wrote:
>> +	ret = pci_alloc_irq_vectors(priv->pdev, HBG_VECTOR_NUM, HBG_VECTOR_NUM,
>> +				    PCI_IRQ_MSI | PCI_IRQ_MSIX);
> These are not devm_ -managed, don't you have to free them?
> On remove and errors during probe?
>
Jonathan Cameron told me:
	I have used pcim_enable(),  so, the irq vectors become device managed.
Look for where those paths call pci_setup_msi_context() / pcim_setup_msi_release()

So there should be no need to free the vectors on remove()

	Thanks，
	Jijie Shao


