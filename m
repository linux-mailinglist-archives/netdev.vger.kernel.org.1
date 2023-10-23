Return-Path: <netdev+bounces-43341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351117D2986
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 07:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27BB61C20869
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 05:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410D24C77;
	Mon, 23 Oct 2023 05:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YLYvH7mw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8014C67
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 05:02:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2126BD6
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 22:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698037339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=VYWewINA58ufsweAbU1fUSU48ieD3onMLop08pEtwvU=;
	b=YLYvH7mwQZa3vlqNv8F44T1TBrq3pq+hONJicoCQlmM9nHnFj2RYKFhADPAwMG6slpa+pc
	KKiWNGrASS4dwENbxigdKKiLkckx6ciu8NLpXM28S89DGZYj/na/s6sLVkjLJkorC33iuh
	2ZrntvHkhI84OIG+7aoTrtuVlusvjbQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-RlFLWtM_NbC0c4QJtp2JcQ-1; Mon, 23 Oct 2023 01:02:16 -0400
X-MC-Unique: RlFLWtM_NbC0c4QJtp2JcQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-402cd372b8bso20503105e9.2
        for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 22:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698037335; x=1698642135;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VYWewINA58ufsweAbU1fUSU48ieD3onMLop08pEtwvU=;
        b=uA1XZw7/4CuqucNhmzXE6hXdUBLc4/ktRMIUxF93wC03XzIL5/koPdPu2hLLscoI90
         ReJZ5/JioT1TTrshDXdth7xKzfVd1yMNSqA2CcC9GbFtax6IuRSTMsjtj0MlNOMTexXT
         lVIDYojqpd/qpiihYWxf2ep2m5MBHGkEIbe4QGlSNLGwpbxYIS3K121B1IYFD62m5sA/
         s0xwSPW+V7IvlY/YmG/RDRhoYMO3LXnjRtMQjrpBObmtkadq4994qXScYpXV246D5yLu
         XzwaBwsUGIT3rDLTAzJ22wS6/tWburTwA0vx4iEXu/KiAZroz8J5QiFP6M71R+AzpisL
         tDrw==
X-Gm-Message-State: AOJu0YyqdxGZgTam5S1a+p8VRaAYQd4j+BundUuNxV13yMt7DeG7Mw29
	C3N5bHfz7mqiU17Z8c8p+w5PP6+tO3o3DVC3BJ2KOzMKX4+gpvbtCL9eFoJWI4E2/i+9Dfp789w
	39PJKzSS18p7MeCbV
X-Received: by 2002:a05:600c:188a:b0:406:7021:7d8 with SMTP id x10-20020a05600c188a00b00406702107d8mr6243017wmp.20.1698037335655;
        Sun, 22 Oct 2023 22:02:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEE93zO060dPvm0mbGcpCvz5k2sh+CIGfA4Q3Qp53GzxNdWjPayH2r0nxenrW1QoZUESLwnA==
X-Received: by 2002:a05:600c:188a:b0:406:7021:7d8 with SMTP id x10-20020a05600c188a00b00406702107d8mr6242988wmp.20.1698037335303;
        Sun, 22 Oct 2023 22:02:15 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:e88f:2c2c:db43:583d:d30e])
        by smtp.gmail.com with ESMTPSA id 1-20020a05600c028100b004077219aed5sm13079549wmk.6.2023.10.22.22.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 22:02:14 -0700 (PDT)
Date: Mon, 23 Oct 2023 01:02:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	arei.gonglei@huawei.com, catalin.marinas@arm.com,
	dtatulea@nvidia.com, eric.auger@redhat.com, gshan@redhat.com,
	jasowang@redhat.com, liming.wu@jaguarmicro.com, mheyne@amazon.de,
	mst@redhat.com, pasic@linux.ibm.com, pizhenwei@bytedance.com,
	shawn.shao@jaguarmicro.com, xuanzhuo@linux.alibaba.com,
	zhenyzha@redhat.com
Subject: [GIT PULL] virtio: last minute fixes
Message-ID: <20231023010207-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent

The following changes since commit 58720809f52779dc0f08e53e54b014209d13eebb:

  Linux 6.6-rc6 (2023-10-15 13:34:39 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 061b39fdfe7fd98946e67637213bcbb10a318cca:

  virtio_pci: fix the common cfg map size (2023-10-18 11:30:12 -0400)

----------------------------------------------------------------
virtio: last minute fixes

a collection of small fixes that look like worth having in
this release.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Dragos Tatulea (2):
      vdpa/mlx5: Fix double release of debugfs entry
      vdpa/mlx5: Fix firmware error on creation of 1k VQs

Eric Auger (1):
      vhost: Allow null msg.size on VHOST_IOTLB_INVALIDATE

Gavin Shan (1):
      virtio_balloon: Fix endless deflation and inflation on arm64

Liming Wu (1):
      tools/virtio: Add dma sync api for virtio test

Maximilian Heyne (1):
      virtio-mmio: fix memory leak of vm_dev

Shawn.Shao (1):
      vdpa_sim_blk: Fix the potential leak of mgmt_dev

Xuan Zhuo (1):
      virtio_pci: fix the common cfg map size

zhenwei pi (1):
      virtio-crypto: handle config changed by work queue

 drivers/crypto/virtio/virtio_crypto_common.h |  3 ++
 drivers/crypto/virtio/virtio_crypto_core.c   | 14 +++++-
 drivers/vdpa/mlx5/net/debug.c                |  5 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c            | 70 ++++++++++++++++++++++------
 drivers/vdpa/mlx5/net/mlx5_vnet.h            | 11 ++++-
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c         |  5 +-
 drivers/vhost/vhost.c                        |  4 +-
 drivers/virtio/virtio_balloon.c              |  6 ++-
 drivers/virtio/virtio_mmio.c                 | 19 ++++++--
 drivers/virtio/virtio_pci_modern_dev.c       |  2 +-
 tools/virtio/linux/dma-mapping.h             | 12 +++++
 11 files changed, 121 insertions(+), 30 deletions(-)


