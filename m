Return-Path: <netdev+bounces-178938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55302A7999C
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 03:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0917D3B35CE
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 01:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24A17D3F4;
	Thu,  3 Apr 2025 01:22:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A795CBA42;
	Thu,  3 Apr 2025 01:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743643367; cv=none; b=soxwlnXCMTPXWDMi6CWrAC+sAgYUueqECfeAVUxxn80s3daJ3zJjua3+hHQ1i6pIG1b8krDB7polPBFvaHQhi1BxrdMo9U554dOoAEasszvM8WxBmPet+bQT1qePMZZ3JDhSBCVLDW2ub+aRxL52ymMfdpKRkR4ZwlrJ6drvQ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743643367; c=relaxed/simple;
	bh=ZaRFeTDI8y5EzpT4O56/SvLj7eJGOdqWo5wVkXuzcPY=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=btLBBMeo8EZTSv6uYNyYMVjGrBhrJ9yug+1aA8qKrlguJ7tIQDOfyJBMu3W+PUMoPvdbD+/ZUUbxgXmSC3xmtn4fNilG3sN+sMoMJL3mv8V87OxEavoXPFe92v0fR12v44zc7E9UM0Q2ibdlQoX+CaCu8jLkvSttuqziBAitydE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZSkPX4hCTz2RTZP;
	Thu,  3 Apr 2025 09:17:52 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id C0A51140144;
	Thu,  3 Apr 2025 09:22:41 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 3 Apr 2025 09:22:40 +0800
Message-ID: <b1b63a84-e043-414e-b1af-c2d6e5855b08@huawei.com>
Date: Thu, 3 Apr 2025 09:22:40 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<shenjian15@huawei.com>, <wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 2/3] net: hns3: fix spelling mistake "reg_um" ->
 "reg_num"
To: Simon Horman <horms@kernel.org>
References: <20250402121001.663431-1-shaojijie@huawei.com>
 <20250402121001.663431-3-shaojijie@huawei.com>
 <20250402135902.GQ214849@horms.kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20250402135902.GQ214849@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/4/2 21:59, Simon Horman wrote:
> On Wed, Apr 02, 2025 at 08:10:00PM +0800, Jijie Shao wrote:
>> From: Hao Lan <lanhao@huawei.com>
>>
>> There are spelling mistakes in hclgevf_get_regs. Fix them.
>>
>> Signed-off-by: Hao Lan <lanhao@huawei.com>
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> Hi,
>
> I agree this is a nice change. But I would lean to it being a clean-up
> and thus material for net-next (when it reopens) rather than a (bug) fix
> for net.

ok, Thanks!

Jijie Shao

>
> ...
>

