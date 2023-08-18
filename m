Return-Path: <netdev+bounces-28946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 284B678133C
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 21:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53B1B28249F
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 19:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037511BB21;
	Fri, 18 Aug 2023 19:10:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21AC198A8
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 19:10:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id C70C0421B;
	Fri, 18 Aug 2023 12:10:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0405DD75;
	Fri, 18 Aug 2023 12:11:08 -0700 (PDT)
Received: from [10.57.91.158] (unknown [10.57.91.158])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFD243F762;
	Fri, 18 Aug 2023 12:10:19 -0700 (PDT)
Message-ID: <ba1e0b29-52e0-2fc0-2eb9-475735febacf@arm.com>
Date: Fri, 18 Aug 2023 20:10:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v11 4/6] iommu/s390: Force ISM devices to use
 IOMMU_DOMAIN_DMA
Content-Language: en-GB
To: Niklas Schnelle <schnelle@linux.ibm.com>, Joerg Roedel <joro@8bytes.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Will Deacon <will@kernel.org>,
 Wenjia Zhang <wenjia@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Gerd Bayer <gbayer@linux.ibm.com>, Julian Ruess <julianr@linux.ibm.com>,
 Pierre Morel <pmorel@linux.ibm.com>, Alexandra Winter
 <wintera@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Yong Wu <yong.wu@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Thierry Reding <thierry.reding@gmail.com>, Krishna Reddy
 <vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20230717-dma_iommu-v11-0-a7a0b83c355c@linux.ibm.com>
 <20230717-dma_iommu-v11-4-a7a0b83c355c@linux.ibm.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230717-dma_iommu-v11-4-a7a0b83c355c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-07-17 12:00, Niklas Schnelle wrote:
> ISM devices are virtual PCI devices used for cross-LPAR communication.
> Unlike real PCI devices ISM devices do not use the hardware IOMMU but
> inspects IOMMU translation tables directly on IOTLB flush (s390 RPCIT
> instruction).
> 
> While ISM devices keep their DMA allocations static and only very rarely
> DMA unmap at all, For each IOTLB flush that occurs after unmap the ISM
> devices will inspect the area of the IOVA space indicated by the flush.
> This means that for the global IOTLB flushes used by the flush queue
> mechanism the entire IOVA space would be inspected. In principle this
> would be fine, albeit potentially unnecessarily slow, it turns out
> however that ISM devices are sensitive to seeing IOVA addresses that are
> currently in use in the IOVA range being flushed. Seeing such in-use
> IOVA addresses will cause the ISM device to enter an error state and
> become unusable.
> 
> Fix this by forcing IOMMU_DOMAIN_DMA to be used for ISM devices. This
> makes sure IOTLB flushes only cover IOVAs that have been unmapped and
> also restricts the range of the IOTLB flush potentially reducing latency
> spikes.

Would it not be simpler to return false for IOMMU_CAP_DEFERRED_FLUSH for 
these devices?

Cheers,
Robin.

> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>   drivers/iommu/s390-iommu.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index f6d6c60e5634..020cc538e4c4 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -710,6 +710,15 @@ struct zpci_iommu_ctrs *zpci_get_iommu_ctrs(struct zpci_dev *zdev)
>   	return &zdev->s390_domain->ctrs;
>   }
>   
> +static int s390_iommu_def_domain_type(struct device *dev)
> +{
> +	struct zpci_dev *zdev = to_zpci_dev(dev);
> +
> +	if (zdev->pft == PCI_FUNC_TYPE_ISM)
> +		return IOMMU_DOMAIN_DMA;
> +	return 0;
> +}
> +
>   int zpci_init_iommu(struct zpci_dev *zdev)
>   {
>   	u64 aperture_size;
> @@ -789,6 +798,7 @@ static const struct iommu_ops s390_iommu_ops = {
>   	.probe_device = s390_iommu_probe_device,
>   	.probe_finalize = s390_iommu_probe_finalize,
>   	.release_device = s390_iommu_release_device,
> +	.def_domain_type = s390_iommu_def_domain_type,
>   	.device_group = generic_device_group,
>   	.pgsize_bitmap = SZ_4K,
>   	.get_resv_regions = s390_iommu_get_resv_regions,
> 

