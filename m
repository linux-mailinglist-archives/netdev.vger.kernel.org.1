Return-Path: <netdev+bounces-25603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEB4774E3D
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 00:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2692D1C20FAF
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 22:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF1019897;
	Tue,  8 Aug 2023 22:27:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3309414F91
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 22:27:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB28DD
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691533641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LS2hQB9R/gfYolj4n3pgnprtQV1NYx7Ai3v+Uc3CcP4=;
	b=Kuk0aGjR7iKEX1yhHO/Er9Ph5lUdFVdgflhzwS9ysMXmMyr6U3hwPuI4rKaOl0xskvtu3q
	C/iWlT3vjsrAT7kZ1KRf6v1WJQG3BGqSDbZ3KtubS3BDXgf4wkJRQolXM/HY2XptT+HcOJ
	Ft3+J6kNbEI2sa4CT0zKtRgNJjtjxlo=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-R6xH-p9NN9S_pPYSMJcjQg-1; Tue, 08 Aug 2023 18:27:20 -0400
X-MC-Unique: R6xH-p9NN9S_pPYSMJcjQg-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-77e41268d40so556885439f.3
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 15:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691533639; x=1692138439;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LS2hQB9R/gfYolj4n3pgnprtQV1NYx7Ai3v+Uc3CcP4=;
        b=UWUk7be7nBGjEFNfuwMxgSWoKvvaCulu2kWuu2OHtOHTKzkdXK90uAyGMd/EkXzOy3
         zkIw8niRgTGTOm1FmvZeFvcRUTX2vMoERYQpKietjUwHzu8ULEVGk/GsPA09WJrjog8j
         VOCNgeVEe8Iuc8JyAjyFUL5vI7xXP7g/EFbTvGIaVI3ef0o/hcQtkrsb59OI796/4Uc6
         RBxcz/Rgh/YZxmmQGZC6/GeH7WAdoQ7FkUcOQfE6Z9SZsZtLyCfOSnrh4zmUz1boD2Ee
         DT6NoZ2ejrbZszwW/99ql23ePqRT1ymlnX7l83qaiQq54skmaVw+5JT/5FWFayePdcE7
         c7uA==
X-Gm-Message-State: AOJu0Yy9mkDuGr5MZxgOKEtgqEJ3YfDlNNOQ2kxJ4TNxGwBQHHTvyquw
	bOArrdyE4R/yS0S4i2OciwCRGV59vo0Ahq0xN3GmJhfBmveUCAVl4TQmGhsTlAYGq2F22nTSrs2
	cug2wtTm4X2h4A412
X-Received: by 2002:a6b:4001:0:b0:790:fef5:cfb9 with SMTP id k1-20020a6b4001000000b00790fef5cfb9mr923532ioa.17.1691533639430;
        Tue, 08 Aug 2023 15:27:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlOuiai4O8jd3irmxcEONHOFmltNRIOgEgClBNjaAYXusMuIQ+KwHAmDtmBejNjjdLlJLpTw==
X-Received: by 2002:a6b:4001:0:b0:790:fef5:cfb9 with SMTP id k1-20020a6b4001000000b00790fef5cfb9mr923513ioa.17.1691533639189;
        Tue, 08 Aug 2023 15:27:19 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id f6-20020a02b786000000b0042b91ec7e31sm3465234jam.3.2023.08.08.15.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 15:27:18 -0700 (PDT)
Date: Tue, 8 Aug 2023 16:27:18 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Brett Creeley <brett.creeley@amd.com>
Cc: <kvm@vger.kernel.org>, <netdev@vger.kernel.org>, <jgg@nvidia.com>,
 <yishaih@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
 <kevin.tian@intel.com>, <horms@kernel.org>, <shannon.nelson@amd.com>
Subject: Re: [PATCH v14 vfio 6/8] vfio/pds: Add support for dirty page
 tracking
Message-ID: <20230808162718.2151e175.alex.williamson@redhat.com>
In-Reply-To: <20230807205755.29579-7-brett.creeley@amd.com>
References: <20230807205755.29579-1-brett.creeley@amd.com>
	<20230807205755.29579-7-brett.creeley@amd.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 7 Aug 2023 13:57:53 -0700
Brett Creeley <brett.creeley@amd.com> wrote:
...
> +static int pds_vfio_dirty_enable(struct pds_vfio_pci_device *pds_vfio,
> +				 struct rb_root_cached *ranges, u32 nnodes,
> +				 u64 *page_size)
> +{
> +	struct pci_dev *pdev = pds_vfio->vfio_coredev.pdev;
> +	struct device *pdsc_dev = &pci_physfn(pdev)->dev;
> +	struct pds_vfio_dirty *dirty = &pds_vfio->dirty;
> +	u64 region_start, region_size, region_page_size;
> +	struct pds_lm_dirty_region_info *region_info;
> +	struct interval_tree_node *node = NULL;
> +	u8 max_regions = 0, num_regions;
> +	dma_addr_t regions_dma = 0;
> +	u32 num_ranges = nnodes;
> +	u32 page_count;
> +	u16 len;
> +	int err;
> +
> +	dev_dbg(&pdev->dev, "vf%u: Start dirty page tracking\n",
> +		pds_vfio->vf_id);
> +
> +	if (pds_vfio_dirty_is_enabled(pds_vfio))
> +		return -EINVAL;
> +
> +	/* find if dirty tracking is disabled, i.e. num_regions == 0 */
> +	err = pds_vfio_dirty_status_cmd(pds_vfio, 0, &max_regions,
> +					&num_regions);
> +	if (err < 0) {
> +		dev_err(&pdev->dev, "Failed to get dirty status, err %pe\n",
> +			ERR_PTR(err));
> +		return err;
> +	} else if (num_regions) {
> +		dev_err(&pdev->dev,
> +			"Dirty tracking already enabled for %d regions\n",
> +			num_regions);
> +		return -EEXIST;
> +	} else if (!max_regions) {
> +		dev_err(&pdev->dev,
> +			"Device doesn't support dirty tracking, max_regions %d\n",
> +			max_regions);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	/*
> +	 * Only support 1 region for now. If there are any large gaps in the
> +	 * VM's address regions, then this would be a waste of memory as we are
> +	 * generating 2 bitmaps (ack/seq) from the min address to the max
> +	 * address of the VM's address regions. In the future, if we support
> +	 * more than one region in the device/driver we can split the bitmaps
> +	 * on the largest address region gaps. We can do this split up to the
> +	 * max_regions times returned from the dirty_status command.
> +	 */

Isn't this a pretty unfortunately limitation given QEMU makes a 1TB
hole on AMD hosts?  Or maybe I misunderstand.

https://gitlab.com/qemu-project/qemu/-/commit/8504f129450b909c88e199ca44facd35d38ba4de

Thanks,
Alex


