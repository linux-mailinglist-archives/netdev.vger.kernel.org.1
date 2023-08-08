Return-Path: <netdev+bounces-25602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F77774E3C
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 00:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B63572818E3
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 22:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7B619896;
	Tue,  8 Aug 2023 22:27:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF298171D8
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 22:27:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAF0FD
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691533628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hS39YmSrQH272Sq7YFizIeVa2aB1z7GDjNayvnX9oro=;
	b=Pokd+aSBN8JpCV4OF48quK/9VhvFUsofHvAYj5uSlSM7O1+VO+sB8hBxzN60hBoGqZrBBU
	aOHmjkL67xjdzCkEHzvW4jiiXfQ5g60/Z5H9m2HzRE4qWzqP+//oIn7Qeyd5wMxb1mtNlb
	fOrj1zjFpvM5l8h6uozUdZ4pvz60bPQ=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-GgNuxXRaNtqDFTOmKs7LwQ-1; Tue, 08 Aug 2023 18:27:07 -0400
X-MC-Unique: GgNuxXRaNtqDFTOmKs7LwQ-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-34670b3089dso2219695ab.1
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 15:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691533626; x=1692138426;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hS39YmSrQH272Sq7YFizIeVa2aB1z7GDjNayvnX9oro=;
        b=NoYkKrmUp5fzMahT0zTUjg3VFznxsCFs4z0MpyD6HosuItOx7jSCze+qznf3ZA6fdF
         L61ZtVIJD8ts5wbn3YnrHQTLUnpSPaUIMa9opI+iNG7YMuit7HUuixKB0xfaUotQtmTU
         +c8PF/ro3f7cw5NENmZONoTwoV5K7FBSRYA1nJskz8kIoMddRypaPEJx24kpPWD0lmSy
         DzrCSw2C5qgmfgiF7GM6KNdNpLJ7TqVmbphwZUDl4Bs2Ml4XO/44SuBLv41XvPHG2r5p
         uCOqse58FJMPyVqJcWlOjFH79Hgic9wvNuFH7OKl3zccTkoV1BthzChB2p3BZ7Bq2csl
         xBZw==
X-Gm-Message-State: AOJu0YxpffaQaKfU+xhsHWZacX0JPYyR0JfZfZd5lMHtPyDHWKiCaz9e
	HUcSTjpxmE8QIyNy4qGemSD05AURk7LVPGWeTAaAnoaRgIOKWG0bi7GzZaxBo2ONrb7Ss81manB
	6ZKcjE2v6cfIowP5o4uu1kZUM
X-Received: by 2002:a05:6e02:1d86:b0:343:ef5e:8286 with SMTP id h6-20020a056e021d8600b00343ef5e8286mr13234044ila.7.1691533626678;
        Tue, 08 Aug 2023 15:27:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMm9KfjjWw52fsFiv8nxxh7g73FJ1lmfP3fvwhxeCO7jsmGfkp4Lznxrqr6JPvoS6MznPNpA==
X-Received: by 2002:a05:6e02:1d86:b0:343:ef5e:8286 with SMTP id h6-20020a056e021d8600b00343ef5e8286mr13234032ila.7.1691533626459;
        Tue, 08 Aug 2023 15:27:06 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id t15-20020a92d14f000000b00348730b48a1sm3697864ilg.43.2023.08.08.15.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 15:27:05 -0700 (PDT)
Date: Tue, 8 Aug 2023 16:27:04 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Brett Creeley <brett.creeley@amd.com>
Cc: <kvm@vger.kernel.org>, <netdev@vger.kernel.org>, <jgg@nvidia.com>,
 <yishaih@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
 <kevin.tian@intel.com>, <horms@kernel.org>, <shannon.nelson@amd.com>
Subject: Re: [PATCH v14 vfio 5/8] vfio/pds: Add VFIO live migration support
Message-ID: <20230808162704.7f5d4889.alex.williamson@redhat.com>
In-Reply-To: <20230807205755.29579-6-brett.creeley@amd.com>
References: <20230807205755.29579-1-brett.creeley@amd.com>
	<20230807205755.29579-6-brett.creeley@amd.com>
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
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 7 Aug 2023 13:57:52 -0700
Brett Creeley <brett.creeley@amd.com> wrote:
...
> +static int
> +pds_vfio_suspend_wait_device_cmd(struct pds_vfio_pci_device *pds_vfio)
> +{
> +	union pds_core_adminq_cmd cmd = {
> +		.lm_suspend_status = {
> +			.opcode = PDS_LM_CMD_SUSPEND_STATUS,
> +			.vf_id = cpu_to_le16(pds_vfio->vf_id),
> +		},
> +	};
> +	struct device *dev = pds_vfio_to_dev(pds_vfio);
> +	union pds_core_adminq_comp comp = {};
> +	unsigned long time_limit;
> +	unsigned long time_start;
> +	unsigned long time_done;
> +	int err;
> +
> +	time_start = jiffies;
> +	time_limit = time_start + HZ * SUSPEND_TIMEOUT_S;
> +	do {
> +		err = pds_vfio_client_adminq_cmd(pds_vfio, &cmd, &comp, true);
> +		if (err != -EAGAIN)
> +			break;
> +
> +		msleep(SUSPEND_CHECK_INTERVAL_MS);
> +	} while (time_before(jiffies, time_limit));
> +
> +	time_done = jiffies;
> +	dev_dbg(dev, "%s: vf%u: Suspend comp received in %d msecs\n", __func__,
> +		pds_vfio->vf_id, jiffies_to_msecs(time_done - time_start));
> +
> +	/* Check the results */
> +	if (time_after_eq(time_done, time_limit)) {
> +		dev_err(dev, "%s: vf%u: Suspend comp timeout\n", __func__,
> +			pds_vfio->vf_id);
> +		err = -ETIMEDOUT;

If the command completes successfully but exceeds the time limit
this turns a success into a failure.  Is that desired?  Thanks,

Alex


