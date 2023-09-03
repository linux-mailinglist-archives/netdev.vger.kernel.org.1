Return-Path: <netdev+bounces-31854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D4F790EDD
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 00:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8BCE280F48
	for <lists+netdev@lfdr.de>; Sun,  3 Sep 2023 22:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D98BA45;
	Sun,  3 Sep 2023 22:13:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07532BA42
	for <netdev@vger.kernel.org>; Sun,  3 Sep 2023 22:13:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54A4F4
	for <netdev@vger.kernel.org>; Sun,  3 Sep 2023 15:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693779226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VjL9JGcLByfgPaZswLky26tlQQfEuGeRmQ8TWkF1Et8=;
	b=HbDxDHKD1MmabWjRGAoJpB15cqrCRVg6fNJChly9hPLTdLhcF6DTnHJZsrKY2HRu3j3FGl
	CaY6UJICcaAXDJ2WBiJ0Ec+VguPPPM4K6l7/fvAyl793UaOPyfZb/ZWQhPS4Vdc7zDCaN9
	jX7v/P88pUAwbixXGeDOAYBPhlHocns=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-kH_-3RNHNZKu4qLAzSL56w-1; Sun, 03 Sep 2023 18:13:45 -0400
X-MC-Unique: kH_-3RNHNZKu4qLAzSL56w-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2bbc1d8011dso7685021fa.1
        for <netdev@vger.kernel.org>; Sun, 03 Sep 2023 15:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693779223; x=1694384023;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjL9JGcLByfgPaZswLky26tlQQfEuGeRmQ8TWkF1Et8=;
        b=JSa7Ng8HmdPEDTNM56EUmIcmfHrnDYlKjqMN/uAfQ448cwAKn/3yBuPOGWAn5/fyi/
         B6WM9f4U6IElQeDbaph+ASSPzOwxf6Rqo9/SrweIjroCZedUwfKNPA+ZftP4awHH8J0y
         8HDoxaprfFO4Sp9eceJjPmnprhVhgZJYJ/6GGfgMN+E0wJ0+hLvtVqj12Nv5Et3EdJzl
         ioPXq09bYBedZCk1nL2YiAPnjB6EJEKs8lC28atzcic5awbz3HHYWJC18CUfm01rvmib
         3UUB7uOSbur/a7wQhk5z4DOKLr6N9KD2fu41mdJaUvrVEltlN8NY8134KM7vo170qAvz
         tU6Q==
X-Gm-Message-State: AOJu0YyQDbvviLOsdL+oOHNIsrL3qAgwgVqioct/kBn+eb6sWgHiQ3DV
	SSuEg2GyprN3Ku4Yjz5ns2W7qNUHGYw2ay+hzFrbEfn6zKDAvTVZcyrm8QqsxyN2A6d6XDs+rFV
	EKkCgnpqNXfkBfCXg
X-Received: by 2002:a2e:b70d:0:b0:2bd:133c:58ff with SMTP id j13-20020a2eb70d000000b002bd133c58ffmr5371565ljo.48.1693779223760;
        Sun, 03 Sep 2023 15:13:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt5eq/oqAhbyqYfgrqKLbNZZyl3X0ZXzNnLt/MouQMoz3QQr7CiE/cjPIeQZ0ta3ELUrf4kA==
X-Received: by 2002:a2e:b70d:0:b0:2bd:133c:58ff with SMTP id j13-20020a2eb70d000000b002bd133c58ffmr5371549ljo.48.1693779223406;
        Sun, 03 Sep 2023 15:13:43 -0700 (PDT)
Received: from redhat.com ([2.52.1.236])
        by smtp.gmail.com with ESMTPSA id gf20-20020a170906e21400b0099ce23c57e6sm5257536ejb.224.2023.09.03.15.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 15:13:42 -0700 (PDT)
Date: Sun, 3 Sep 2023 18:13:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
	shannon.nelson@amd.com, xuanzhuo@linux.alibaba.com,
	yuanyaogoog@chromium.org, yuehaibing@huawei.com
Subject: [GIT PULL] virtio: features
Message-ID: <20230903181338-mutt-send-email-mst@kernel.org>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The following changes since commit 2dde18cd1d8fac735875f2e4987f11817cc0bc2c:

  Linux 6.5 (2023-08-27 14:49:51 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 1acfe2c1225899eab5ab724c91b7e1eb2881b9ab:

  virtio_ring: fix avail_wrap_counter in virtqueue_add_packed (2023-09-03 18:10:24 -0400)

----------------------------------------------------------------
virtio: features

a small pull request this time around, mostly because the
vduse network got postponed to next relase so we can be sure
we got the security store right.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Eugenio Pérez (4):
      vdpa: add VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK flag
      vdpa: accept VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK backend feature
      vdpa: add get_backend_features vdpa operation
      vdpa_sim: offer VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK

Jason Wang (1):
      virtio_vdpa: build affinity masks conditionally

Xuan Zhuo (12):
      virtio_ring: check use_dma_api before unmap desc for indirect
      virtio_ring: put mapping error check in vring_map_one_sg
      virtio_ring: introduce virtqueue_set_dma_premapped()
      virtio_ring: support add premapped buf
      virtio_ring: introduce virtqueue_dma_dev()
      virtio_ring: skip unmap for premapped
      virtio_ring: correct the expression of the description of virtqueue_resize()
      virtio_ring: separate the logic of reset/enable from virtqueue_resize
      virtio_ring: introduce virtqueue_reset()
      virtio_ring: introduce dma map api for virtqueue
      virtio_ring: introduce dma sync api for virtqueue
      virtio_net: merge dma operations when filling mergeable buffers

Yuan Yao (1):
      virtio_ring: fix avail_wrap_counter in virtqueue_add_packed

Yue Haibing (1):
      vdpa/mlx5: Remove unused function declarations

 drivers/net/virtio_net.c           | 230 ++++++++++++++++++---
 drivers/vdpa/mlx5/core/mlx5_vdpa.h |   3 -
 drivers/vdpa/vdpa_sim/vdpa_sim.c   |   8 +
 drivers/vhost/vdpa.c               |  15 +-
 drivers/virtio/virtio_ring.c       | 412 ++++++++++++++++++++++++++++++++-----
 drivers/virtio/virtio_vdpa.c       |  17 +-
 include/linux/vdpa.h               |   4 +
 include/linux/virtio.h             |  22 ++
 include/uapi/linux/vhost_types.h   |   4 +
 9 files changed, 625 insertions(+), 90 deletions(-)


