Return-Path: <netdev+bounces-141590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 673609BBA64
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 17:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2320228294F
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 16:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9491C07E4;
	Mon,  4 Nov 2024 16:34:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6212C2BB04;
	Mon,  4 Nov 2024 16:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730738094; cv=none; b=J0f+ywshyuXRjtbDyRcJhfo8PMHTziezQsOi6AFZ54pKD39tva4tRcopxt/5czH0H8doqznoge+E+/dbHhsQ5mbp/3iemZKL8hjci9NlZIy2Pfb87f48ZMEtPkGt6XexxK6SKWpjFJXbMGP+vDaRxzMlesm4JsASxxUB2a7dhvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730738094; c=relaxed/simple;
	bh=25nxMzWGtlbTbJ7CT9GkI9kb4ArWbWqnFz0FDhbVfdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j2My0+sTKntTDoxEVcObIu8e59zkQeThmwNrgYCq2aN6rsnZMwa7mOg6b2gS2g7hyV8qzvhh1hLJVWG41p1/so0VktnAAzuSxU3jhzEjmiqbgjAdKHjkX1N1wIgRvdY24XYCFhM7jW6KZhJirbA1vkGEchZLY86W0W5x6RZWYs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C7F6FEC;
	Mon,  4 Nov 2024 08:35:20 -0800 (PST)
Received: from [10.57.88.110] (unknown [10.57.88.110])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41B4E3F66E;
	Mon,  4 Nov 2024 08:34:48 -0800 (PST)
Message-ID: <29d5918e-cfe2-4b36-b0f1-a1379075dd05@arm.com>
Date: Mon, 4 Nov 2024 16:34:46 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [net-next] net: hns3: add IOMMU_SUPPORT dependency
To: Salil Mehta <salil.mehta@huawei.com>, Arnd Bergmann <arnd@kernel.org>,
 "shenjian (K)" <shenjian15@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
 Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 shaojijie <shaojijie@huawei.com>, wangpeiyang <wangpeiyang1@huawei.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20241104082129.3142694-1-arnd@kernel.org>
 <069c9838-b781-4012-934a-d2626fa78212@arm.com>
 <96df804b6d9d467391fda27d90b5227c@huawei.com>
 <a94f95bd661c4978bb843c8a1af73818@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <a94f95bd661c4978bb843c8a1af73818@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-11-04 10:50 am, Salil Mehta wrote:
>>   From: Salil Mehta <salil.mehta@huawei.com>
>>   Sent: Monday, November 4, 2024 10:41 AM
>>   To: Robin Murphy <robin.murphy@arm.com>; Arnd Bergmann
>>   <arnd@kernel.org>; shenjian (K) <shenjian15@huawei.com>
>>   
>>   HI Robin,
>>   
>>   >  From: Robin Murphy <robin.murphy@arm.com>
>>   >  Sent: Monday, November 4, 2024 10:29 AM
>>   >  To: Arnd Bergmann <arnd@kernel.org>; shenjian (K)
>>   > <shenjian15@huawei.com>; Salil Mehta <salil.mehta@huawei.com>
>>   >  Cc: Arnd Bergmann <arnd@arndb.de>; Will Deacon <will@kernel.org>;
>>   > Joerg Roedel <jroedel@suse.de>; iommu@lists.linux.dev; Andrew Lunn
>>   > <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>;
>>   Eric
>>   > Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>;
>>   > Paolo Abeni <pabeni@redhat.com>; shaojijie <shaojijie@huawei.com>;
>>   > wangpeiyang <wangpeiyang1@huawei.com>; netdev@vger.kernel.org;
>>   > linux-kernel@vger.kernel.org
>>   >  Subject: Re: [PATCH] [net-next] net: hns3: add IOMMU_SUPPORT
>>   > dependency
>>   >
>>   >  On 2024-11-04 8:21 am, Arnd Bergmann wrote:
>>   >  > From: Arnd Bergmann <arnd@arndb.de>  >  > The hns3 driver started
>>   > filling iommu_iotlb_gather structures itself,  > which requires
>>   > CONFIG_IOMMU_SUPPORT is enabled:
>>   >  >
>>   >  > drivers/net/ethernet/hisilicon/hns3/hns3_enet.c: In function
>>   >  'hns3_dma_map_sync':
>>   >  > drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:395:14: error:
>>   > 'struct  iommu_iotlb_gather' has no member named 'start'
>>   >  >    395 |  iotlb_gather.start = iova;
>>   >  >        |              ^
>>   >  > drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:396:14: error:
>>   > 'struct  iommu_iotlb_gather' has no member named 'end'
>>   >  >    396 |  iotlb_gather.end = iova + granule - 1;
>>   >  >        |              ^
>>   >  > drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:397:14: error:
>>   > 'struct  iommu_iotlb_gather' has no member named 'pgsize'
>>   >  >    397 |  iotlb_gather.pgsize = granule;
>>   >  >        |              ^
>>   >  >
>>   >  > Add a Kconfig dependency to make it build in random configurations.
>>   >  >
>>   >  > Cc: Will Deacon <will@kernel.org>
>>   >  > Cc: Joerg Roedel <jroedel@suse.de>
>>   >  > Cc: Robin Murphy <robin.murphy@arm.com>  > Cc:
>>   > iommu@lists.linux.dev  > Fixes: f2c14899caba ("net: hns3: add sync
>>   > command to sync io-pgtable")  > Signed-off-by: Arnd Bergmann
>>   > <arnd@arndb.de>  > ---  > I noticed that no other driver does this, so
>>   > it would be good to have  > a confirmation from the iommu maintainers
>>   > that this is how the  > interface and the dependency is intended to be
>>   > used.
>>   >
>>   >  WTF is that patch doing!? No, random device drivers should absolutely
>>   > not  be poking into IOMMU driver internals, this is egregiously wrong
>>   > and the  correct action is to drop it entirely.
>>   
>>   
>>   Absolutely agree with it. Sorry I haven't been in touch for quite some time.
>>   Let me catch the whole story.  Feel free to drop this patch.
> 
> 
> Just to make it clear I meant the culprit patch:
> https://lore.kernel.org/netdev/20241025092938.2912958-3-shaojijie@huawei.com/

Right, if the HIP09 SMMU has a bug which requires an 
iommu_domain_ops::iotlb_sync_map workaround, then the SMMU driver should 
detect the HIP09 SMMU and implement that workaround for it. HNS3 trying 
to reach in to the SMMU driver's data and open-code iotlb_sync_map on 
its behalf is just as plain illogical as it is unacceptable.

Thanks,
Robin.

