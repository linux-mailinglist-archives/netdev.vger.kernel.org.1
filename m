Return-Path: <netdev+bounces-27200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD40077AECA
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 01:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8033F1C2099F
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 23:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E48946E;
	Sun, 13 Aug 2023 23:08:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065338F72
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 23:08:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6E9E8
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 16:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691968094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AUa1QX/mJ1ef9VxwUsegnOGKLjQxThmW1L4mbjRAl5o=;
	b=gAYdFQ/TBCNWCbrOzuFmK2+Vz4ns4QeDYNYSoIHdEwWzBOUq9I1ppLu/Z3O6oLAPjrto7B
	oHPUhRcWo4mL6witR4/r+lAwnuI8zK51jSqK8Stw9KfPN1Rjzej6wJU39mdveEHbMk8jOK
	IU4moGJmi2AdtzCng0wkUDhNr+AQj0A=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-BoMIYiDnN5a1O8DIVq6tGw-1; Sun, 13 Aug 2023 19:08:12 -0400
X-MC-Unique: BoMIYiDnN5a1O8DIVq6tGw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b9bf49342dso36612521fa.1
        for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 16:08:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691968091; x=1692572891;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUa1QX/mJ1ef9VxwUsegnOGKLjQxThmW1L4mbjRAl5o=;
        b=H/4ki4bzRXIZ3dIDKmiCmeUXyO540SVb1apVC3fDAlU2qpv+9XIyAsQY0wqCOXMuO8
         4PgZ19LgAKeMdGPT6J9mNw2DD4wl7tlW9Or2zi527D9ozFhH9ejiBYBBwtJLgV50IGw/
         8Dw//0FdfNKOErnSysPX2UTti+VIqGlPUuuLNcjxy9wMjctw7k7L9K8ePbFPY1mOVrRT
         c+hTVXtxSzsFfWNpXJIIeSkegMZm4UYqkX5e0wQvPm0OeAEUPV02nbjS0WqQ7yHSkt3b
         PKVVTArRDH3mREOQY37qHR40BVCfmqtZxH9eEHTkokSZBs0BbWm1NEvq+A5pwSi8MBT6
         VdnQ==
X-Gm-Message-State: AOJu0Yxp4ahpY1MDZrGfiuMzWqu7E+vHoCdOIbWJ9iwCjN5DwY6NP4pY
	rex9fjsZLdzhzhusiKHIvu+4+QyoQ8h9+gZ+ti9yc12Ozr9/J9TY/AgRl2dgV1FMINH9hbmSVBx
	cuU53XusFNkH+CnYt
X-Received: by 2002:a2e:8503:0:b0:2b7:1005:931b with SMTP id j3-20020a2e8503000000b002b71005931bmr5573400lji.0.1691968090805;
        Sun, 13 Aug 2023 16:08:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfB6KQC44UtzTvTIQLTU6WSArsFvqwFM/tL9oeOdLXdw+TuyKztZH0mu5DyTnZ3c9/bKtQHw==
X-Received: by 2002:a2e:8503:0:b0:2b7:1005:931b with SMTP id j3-20020a2e8503000000b002b71005931bmr5573379lji.0.1691968090444;
        Sun, 13 Aug 2023 16:08:10 -0700 (PDT)
Received: from redhat.com ([2.55.42.146])
        by smtp.gmail.com with ESMTPSA id jo19-20020a170906f6d300b0099bcd1fa5b0sm5002759ejb.192.2023.08.13.16.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 16:08:09 -0700 (PDT)
Date: Sun, 13 Aug 2023 19:08:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	allen.hubbe@amd.com, andrew@daynix.com, david@redhat.com,
	dtatulea@nvidia.com, eperezma@redhat.com, feliu@nvidia.com,
	gal@nvidia.com, jasowang@redhat.com, leiyang@redhat.com,
	linma@zju.edu.cn, maxime.coquelin@redhat.com,
	michael.christie@oracle.com, mst@redhat.com, rdunlap@infradead.org,
	sgarzare@redhat.com, shannon.nelson@amd.com, stable@vger.kernel.org,
	stable@vger.kernelorg, stefanha@redhat.com,
	wsa+renesas@sang-engineering.com, xieyongji@bytedance.com,
	yin31149@gmail.com
Subject: [GIT PULL] virtio: bugfixes
Message-ID: <20230813190803-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

All small, fairly safe changes.

The following changes since commit 52a93d39b17dc7eb98b6aa3edb93943248e03b2f:

  Linux 6.5-rc5 (2023-08-06 15:07:51 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to f55484fd7be923b740e8e1fc304070ba53675cb4:

  virtio-mem: check if the config changed before fake offlining memory (2023-08-10 15:51:46 -0400)

----------------------------------------------------------------
virtio: bugfixes

just a bunch of bugfixes all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Allen Hubbe (2):
      pds_vdpa: reset to vdpa specified mac
      pds_vdpa: alloc irq vectors on DRIVER_OK

David Hildenbrand (4):
      virtio-mem: remove unsafe unplug in Big Block Mode (BBM)
      virtio-mem: convert most offline_and_remove_memory() errors to -EBUSY
      virtio-mem: keep retrying on offline_and_remove_memory() errors in Sub Block Mode (SBM)
      virtio-mem: check if the config changed before fake offlining memory

Dragos Tatulea (4):
      vdpa: Enable strict validation for netlinks ops
      vdpa/mlx5: Correct default number of queues when MQ is on
      vdpa/mlx5: Fix mr->initialized semantics
      vdpa/mlx5: Fix crash on shutdown for when no ndev exists

Eugenio Pérez (1):
      vdpa/mlx5: Delete control vq iotlb in destroy_mr only when necessary

Feng Liu (1):
      virtio-pci: Fix legacy device flag setting error in probe

Gal Pressman (1):
      virtio-vdpa: Fix cpumask memory leak in virtio_vdpa_find_vqs()

Hawkins Jiawei (1):
      virtio-net: Zero max_tx_vq field for VIRTIO_NET_CTRL_MQ_HASH_CONFIG case

Lin Ma (3):
      vdpa: Add features attr to vdpa_nl_policy for nlattr length check
      vdpa: Add queue index attr to vdpa_nl_policy for nlattr length check
      vdpa: Add max vqp attr to vdpa_nl_policy for nlattr length check

Maxime Coquelin (1):
      vduse: Use proper spinlock for IRQ injection

Mike Christie (3):
      vhost-scsi: Fix alignment handling with windows
      vhost-scsi: Rename vhost_scsi_iov_to_sgl
      MAINTAINERS: add vhost-scsi entry and myself as a co-maintainer

Shannon Nelson (4):
      pds_vdpa: protect Makefile from unconfigured debugfs
      pds_vdpa: always allow offering VIRTIO_NET_F_MAC
      pds_vdpa: clean and reset vqs entries
      pds_vdpa: fix up debugfs feature bit printing

Wolfram Sang (1):
      virtio-mmio: don't break lifecycle of vm_dev

 MAINTAINERS                        |  11 ++-
 drivers/net/virtio_net.c           |   2 +-
 drivers/vdpa/mlx5/core/mlx5_vdpa.h |   2 +
 drivers/vdpa/mlx5/core/mr.c        | 105 +++++++++++++++------
 drivers/vdpa/mlx5/net/mlx5_vnet.c  |  26 +++---
 drivers/vdpa/pds/Makefile          |   3 +-
 drivers/vdpa/pds/debugfs.c         |  15 ++-
 drivers/vdpa/pds/vdpa_dev.c        | 176 ++++++++++++++++++++++++----------
 drivers/vdpa/pds/vdpa_dev.h        |   5 +-
 drivers/vdpa/vdpa.c                |   9 +-
 drivers/vdpa/vdpa_user/vduse_dev.c |   8 +-
 drivers/vhost/scsi.c               | 187 ++++++++++++++++++++++++++++++++-----
 drivers/virtio/virtio_mem.c        | 168 ++++++++++++++++++++++-----------
 drivers/virtio/virtio_mmio.c       |   5 +-
 drivers/virtio/virtio_pci_common.c |   2 -
 drivers/virtio/virtio_pci_legacy.c |   1 +
 drivers/virtio/virtio_vdpa.c       |   2 +
 17 files changed, 519 insertions(+), 208 deletions(-)


