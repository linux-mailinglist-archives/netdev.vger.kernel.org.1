Return-Path: <netdev+bounces-136148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0BB9A08D3
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 13:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07381C238E1
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 11:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63553207A1A;
	Wed, 16 Oct 2024 11:53:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33273207A1C;
	Wed, 16 Oct 2024 11:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729079639; cv=none; b=AOssE6MUGqhBbE+PASsunK7OQ6xRdYhW33s+4ZxQusz4Fb3UIwn9FBA9tH86F3CCZ71UFAEAuvfgsZwuBNIf9J0WZ5HOazm7mU1mVy7QVocyevRsjF7e8qAY2l7S9p22PCslyRQOGMkquRv1+uREV9kCgHb6eqBQHu7OdirQbFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729079639; c=relaxed/simple;
	bh=+ynl3Q5aOSW4C80BXIUh3QcV82aTaEqoZgyDyW/VpA0=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=igQdO493zogytQfRoSruj6iSvmtaZv7SA59eaLD3VXVMT2Rg5QOJFxWFRMW7eSAF+F5lGQHhAdMK8aQRDZvuD7j6CGm6uclkZ5PFkQNG9bALjxtYf2fvgIiPNEDlq2eEx+PtDkEfefGllsz5zz1aDTVKQ88PQuUNzKvJrlCtdfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XT8Tz43Tsz1spkT;
	Wed, 16 Oct 2024 19:52:39 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 6A3ED1A016C;
	Wed, 16 Oct 2024 19:53:54 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 19:53:53 +0800
Message-ID: <b9f4958b-ecd6-4a44-afd7-b39b21053630@huawei.com>
Date: Wed, 16 Oct 2024 19:53:52 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <shenjian15@huawei.com>, <salil.mehta@huawei.com>,
	<liuyonglong@huawei.com>, <wangpeiyang1@huawei.com>, <lanhao@huawei.com>,
	<chenhao418@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 2/9] net: hns3: add sync command to sync io-pgtable
To: Jakub Kicinski <kuba@kernel.org>
References: <20241011094521.3008298-1-shaojijie@huawei.com>
 <20241011094521.3008298-3-shaojijie@huawei.com>
 <20241015181933.3e7afbe3@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20241015181933.3e7afbe3@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/10/16 9:19, Jakub Kicinski wrote:
> On Fri, 11 Oct 2024 17:45:14 +0800 Jijie Shao wrote:
>> To avoid errors in pgtable prefectch, add a sync command to sync
>> io-pagtable.
> I've never seen net drivers call iommu_iotlb functions.
> Could you provide more context on what this is doing and
> why such unusual handling is necessary?

Follow the reply of the previous patch.

In the case of large traffic, the TX bounce buffer may be used up.
At this point, we go to mapping/unmapping on TX path again.
So we added the sync command in driver to avoid hardware issue.

Thanks
Jijie Shao



