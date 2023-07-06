Return-Path: <netdev+bounces-15930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBE574A7B1
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 01:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46B74280F54
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 23:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52783174C3;
	Thu,  6 Jul 2023 23:26:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4440C168A5
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 23:26:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3B31BD2;
	Thu,  6 Jul 2023 16:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=bDdj2ImLWq3orRh5mZ0i6CkrMO5thDbEKJP5vNXEszQ=; b=XOsOwJYXZVQ33w6XPomj04Renh
	yQFciK3I0zE9Zpzkq3abJrhB3iswgOvCHPxvjEYm27D9reaX9t91tKrcQRzF3ZEIg3mauARWtTTAq
	mkDRH/+DHf7c/IQjBIpMU4PFnWC9fZf/Mk4YhC1PQFDfKPMfiEuFAFgfkEk5RJRjPiB+/vzjoackT
	XUOGbqWSIFLQ12Va6M8GH4/uO7EvdbsNRrkafyM8Gy0Ocy6f6sDkMdBgAAnpJEndbyuC8i6sdMtKm
	oesPnV5GC8cZptTn4JM6aXCMsystUzju5zYlp/j7FmgU2bYHuhRANZ4BtXwvBvgDrM42R/4mR1FSe
	7OmlOTMw==;
Received: from [2601:1c2:980:9ec0::2764]
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qHYMh-002xMC-1W;
	Thu, 06 Jul 2023 23:26:23 +0000
Message-ID: <d785aec5-10b5-cc75-904c-cafdc194a8f0@infradead.org>
Date: Thu, 6 Jul 2023 16:26:22 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH virtio] pds_vdpa: protect Makefile from unconfigured
 debugfs
Content-Language: en-US
To: Shannon Nelson <shannon.nelson@amd.com>, jasowang@redhat.com,
 mst@redhat.com, virtualization@lists.linux-foundation.org,
 brett.creeley@amd.com
Cc: netdev@vger.kernel.org, drivers@pensando.io, sfr@canb.auug.org.au,
 linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230706231718.54198-1-shannon.nelson@amd.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230706231718.54198-1-shannon.nelson@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/6/23 16:17, Shannon Nelson wrote:
> debugfs.h protects itself from an undefined DEBUG_FS, so it is
> not necessary to check it in the driver code or the Makefile.
> The driver code had been updated for this, but the Makefile had
> missed the update.
> 
> Link: https://lore.kernel.org/linux-next/fec68c3c-8249-7af4-5390-0495386a76f9@infradead.org/
> Fixes: a16291b5bcbb ("pds_vdpa: Add new vDPA driver for AMD/Pensando DSC")
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  drivers/vdpa/pds/Makefile | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/vdpa/pds/Makefile b/drivers/vdpa/pds/Makefile
> index 2e22418e3ab3..c2d314d4614d 100644
> --- a/drivers/vdpa/pds/Makefile
> +++ b/drivers/vdpa/pds/Makefile
> @@ -5,6 +5,5 @@ obj-$(CONFIG_PDS_VDPA) := pds_vdpa.o
>  
>  pds_vdpa-y := aux_drv.o \
>  	      cmds.o \
> +	      debugfs.o \
>  	      vdpa_dev.o
> -
> -pds_vdpa-$(CONFIG_DEBUG_FS) += debugfs.o

-- 
~Randy

