Return-Path: <netdev+bounces-28561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DDE77FD46
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 19:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B04602820D3
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 17:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A00171D5;
	Thu, 17 Aug 2023 17:53:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3697914AA6
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 17:53:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AA72711
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 10:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692294792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RXsr/7Nm6yDmyxBqQjD5zYHfE7mun3vBFRDXX4HEKy4=;
	b=VDb8I0FtjHgjcOgrliTgJhRUV4nnmRApAMi7Z6nmJgw6GWsHAgo6cBlf9hkVkcvqf3naog
	E9hSsw5Xx+mR1q95lTnhgyk4HdGOYwy59pLLOYNBAG23xfOIG/GjpEf4uJChfvoHW+BMpy
	nUI4iYcaxyUKTggaquo/a/9r9LJreTY=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-Kb6y_xEhPlexMDyVOLouIQ-1; Thu, 17 Aug 2023 13:53:10 -0400
X-MC-Unique: Kb6y_xEhPlexMDyVOLouIQ-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-786ca3e9160so4912939f.1
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 10:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692294790; x=1692899590;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RXsr/7Nm6yDmyxBqQjD5zYHfE7mun3vBFRDXX4HEKy4=;
        b=clUQkcQ78Jz/2NuahGn7jI1u04H50yASEMpLGW7GegRtqazpgq9BXkb3HQFt253inq
         PE/I4zVPJ6kXy0hnx5foLeeTItA0lCH+BNTFAgKyXutc6nF+WjAIfCppLQ50bAErhwLX
         hikA0JVaAZJUktss9NHdSOTXe6CSf+PRPwyV2RIsCSkto3W3aBdOLDZW/OlH0R+Dd9Ru
         TiZ+j/cDR7IWBuBKQfs8/B4Fr74azSe6h8ff6UQUg4d5z+s2j7JdY0DQWRcrOmJldJU8
         /Yc1OMmR6BScuPcd6K68LbRa5nTkg+TqGwMVF7ZcnXWSxhGf1p4WhMf4zpYUM7i4d3Ge
         m9Mw==
X-Gm-Message-State: AOJu0YxBHiEjCKm+rCIGb9uESrJwyggQg3c2+vmMGmPb6ioZw25P2/Va
	lCVEA+J8VaFOIyGmwjkog7bsO0zJEhYdCp03KkX1jmstmxgDB5KIwvWwr5AN8wob8BmsFctcTcz
	wB1asWYfSLbu87dhj
X-Received: by 2002:a05:6602:3894:b0:791:8d6a:9965 with SMTP id br20-20020a056602389400b007918d6a9965mr4637131iob.6.1692294789993;
        Thu, 17 Aug 2023 10:53:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3PmHS9aLJrLXIzU4pLZcZl3Cc0gPRyuYSEyYEWcrYUUQNLcZJ1qcDouv3xaQ01y+uaqHUVQ==
X-Received: by 2002:a05:6602:3894:b0:791:8d6a:9965 with SMTP id br20-20020a056602389400b007918d6a9965mr4637117iob.6.1692294789765;
        Thu, 17 Aug 2023 10:53:09 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id gn20-20020a0566382c1400b0042baffe832fsm5230209jab.101.2023.08.17.10.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 10:53:09 -0700 (PDT)
Date: Thu, 17 Aug 2023 11:53:07 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Brett Creeley <brett.creeley@amd.com>
Cc: <kvm@vger.kernel.org>, <netdev@vger.kernel.org>, <jgg@nvidia.com>,
 <yishaih@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
 <kevin.tian@intel.com>, <horms@kernel.org>, <shannon.nelson@amd.com>
Subject: Re: [PATCH v14 vfio 0/8] pds-vfio-pci driver
Message-ID: <20230817115307.2d8a6bf4.alex.williamson@redhat.com>
In-Reply-To: <20230807205755.29579-1-brett.creeley@amd.com>
References: <20230807205755.29579-1-brett.creeley@amd.com>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 7 Aug 2023 13:57:47 -0700
Brett Creeley <brett.creeley@amd.com> wrote:
> Brett Creeley (8):
>   vfio: Commonize combine_ranges for use in other VFIO drivers
>   vfio/pds: Initial support for pds VFIO driver
>   pds_core: Require callers of register/unregister to pass PF drvdata
>   vfio/pds: register with the pds_core PF
>   vfio/pds: Add VFIO live migration support
>   vfio/pds: Add support for dirty page tracking
>   vfio/pds: Add support for firmware recovery
>   vfio/pds: Add Kconfig and documentation
> 
>  .../ethernet/amd/pds_vfio_pci.rst             |  79 +++
>  .../device_drivers/ethernet/index.rst         |   1 +
>  MAINTAINERS                                   |   7 +
>  drivers/net/ethernet/amd/pds_core/auxbus.c    |  20 +-
>  drivers/vfio/pci/Kconfig                      |   2 +
>  drivers/vfio/pci/Makefile                     |   2 +
>  drivers/vfio/pci/mlx5/cmd.c                   |  48 +-
>  drivers/vfio/pci/pds/Kconfig                  |  19 +
>  drivers/vfio/pci/pds/Makefile                 |  11 +
>  drivers/vfio/pci/pds/cmds.c                   | 509 ++++++++++++++++
>  drivers/vfio/pci/pds/cmds.h                   |  25 +
>  drivers/vfio/pci/pds/dirty.c                  | 564 ++++++++++++++++++
>  drivers/vfio/pci/pds/dirty.h                  |  39 ++
>  drivers/vfio/pci/pds/lm.c                     | 434 ++++++++++++++
>  drivers/vfio/pci/pds/lm.h                     |  41 ++
>  drivers/vfio/pci/pds/pci_drv.c                | 209 +++++++
>  drivers/vfio/pci/pds/pci_drv.h                |   9 +
>  drivers/vfio/pci/pds/vfio_dev.c               | 227 +++++++
>  drivers/vfio/pci/pds/vfio_dev.h               |  39 ++
>  drivers/vfio/vfio_main.c                      |  47 ++
>  include/linux/pds/pds_adminq.h                | 375 ++++++++++++
>  include/linux/pds/pds_common.h                |   9 +-
>  include/linux/vfio.h                          |   3 +
>  23 files changed, 2654 insertions(+), 65 deletions(-)
>  create mode 100644 Documentation/networking/device_drivers/ethernet/amd/pds_vfio_pci.rst
>  create mode 100644 drivers/vfio/pci/pds/Kconfig
>  create mode 100644 drivers/vfio/pci/pds/Makefile
>  create mode 100644 drivers/vfio/pci/pds/cmds.c
>  create mode 100644 drivers/vfio/pci/pds/cmds.h
>  create mode 100644 drivers/vfio/pci/pds/dirty.c
>  create mode 100644 drivers/vfio/pci/pds/dirty.h
>  create mode 100644 drivers/vfio/pci/pds/lm.c
>  create mode 100644 drivers/vfio/pci/pds/lm.h
>  create mode 100644 drivers/vfio/pci/pds/pci_drv.c
>  create mode 100644 drivers/vfio/pci/pds/pci_drv.h
>  create mode 100644 drivers/vfio/pci/pds/vfio_dev.c
>  create mode 100644 drivers/vfio/pci/pds/vfio_dev.h
> 

Applied to vfio next branch for v6.6.  Thanks!

Alex


