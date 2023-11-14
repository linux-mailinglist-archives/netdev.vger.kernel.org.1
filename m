Return-Path: <netdev+bounces-47831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EFA7EB7C1
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 21:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4572C28138B
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 20:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC5C35F0B;
	Tue, 14 Nov 2023 20:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GiJElAs0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469BD26AF3
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 20:24:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011E4F5
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 12:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699993490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AMPhiKJAbm8zeR4hjWFuhSxhTnmbxSsETxgcPx+yeuk=;
	b=GiJElAs004ekM/yexPC3t3iwltqsVCVLV0xfUH5aXZlkYjC8Ocid1BrWTYBY7vT3KdpCg4
	FZWzsCZmxxBvLGjTOneDQAQjE5cmPm4R6Am1puEGd6Ff5mnwxJCpQyX61Y+HkSPziq7FPJ
	P76yDKxO/R0coPv9xtM6XB+/MjQhnEk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-2S2C9qRcNqKRut9g4sxKSA-1; Tue, 14 Nov 2023 15:24:48 -0500
X-MC-Unique: 2S2C9qRcNqKRut9g4sxKSA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-408534c3ec7so39437365e9.1
        for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 12:24:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699993482; x=1700598282;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AMPhiKJAbm8zeR4hjWFuhSxhTnmbxSsETxgcPx+yeuk=;
        b=F39sEGO8DkhJb8m6Iv7Qwg62O5Zfsv9VHVe5XHBNmmbtx7aNm9iSnePCTf34ozMhRU
         D9q9jf5FGOKzwkjzqOpItpeMV+D8D3GC1jIaJngegGjxYjfalH16LuvtpmOVLsBI4k3n
         SJxn+XDV4yGtBAjFcqjqjUjzQjEstTz+iG35oOv4bO6mJfQIy7MaiwkLsO6zRvRsXczh
         81VNgOAROpcQpnthLxSONrPDwlwMm2lQgfg6KQ9jq7evzVfA2AdBjHWaWyPoWDqvXtQa
         BKSLaCgNTgXp4i/XUHTHt+VNYVaR1DGRUeviUFjtIeSiDiBD2+8UkeRRzW+87vMPWYkO
         WyZA==
X-Gm-Message-State: AOJu0YwF0PViDswCh9VDu1UpgyAA0Pgq1kPKgNukE8LXWnETbbpPfQfB
	z1GHidAp6cAym8mBk/OtUertSXS9O9AwhDUpHtaoxSJrjcqoeaJberXSs2lFIjqS5M/GfIrH7Ie
	6xIPUmn3FhHd7emUl
X-Received: by 2002:a05:600c:3b15:b0:40a:49c1:94d9 with SMTP id m21-20020a05600c3b1500b0040a49c194d9mr8706186wms.27.1699993482667;
        Tue, 14 Nov 2023 12:24:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8mSpIgY64wNwqmPqSR229VYTqr3lkVUkbVTKDvrSUJWsccUbrWwL5VGr9Xp2Iyf3uhHqJvg==
X-Received: by 2002:a05:600c:3b15:b0:40a:49c1:94d9 with SMTP id m21-20020a05600c3b1500b0040a49c194d9mr8706157wms.27.1699993482303;
        Tue, 14 Nov 2023 12:24:42 -0800 (PST)
Received: from redhat.com ([2a02:14f:17a:44fb:a682:dfbc:c3ae:7cff])
        by smtp.gmail.com with ESMTPSA id az19-20020a05600c601300b0040849ce7116sm18662069wmb.43.2023.11.14.12.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 12:24:41 -0800 (PST)
Date: Tue, 14 Nov 2023 15:24:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	alistair.francis@wdc.com, bjorn@rivosinc.com, cleger@rivosinc.com,
	dan.carpenter@linaro.org, eperezma@redhat.com, jakub@cloudflare.com,
	jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com
Subject: [GIT PULL] vhost,virtio,vdpa,firmware: bugfixes
Message-ID: <20231114152436-mutt-send-email-mst@kernel.org>
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

The following changes since commit 86f6c224c97911b4392cb7b402e6a4ed323a449e:

  vdpa_sim: implement .reset_map support (2023-11-01 09:20:00 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to e07754e0a1ea2d63fb29574253d1fd7405607343:

  vhost-vdpa: fix use after free in vhost_vdpa_probe() (2023-11-01 09:31:16 -0400)

----------------------------------------------------------------
vhost,virtio,vdpa,firmware: bugfixes

bugfixes all over the place

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Björn Töpel (1):
      riscv, qemu_fw_cfg: Add support for RISC-V architecture

Dan Carpenter (1):
      vhost-vdpa: fix use after free in vhost_vdpa_probe()

Jakub Sitnicki (1):
      virtio_pci: Switch away from deprecated irq_set_affinity_hint

Michael S. Tsirkin (1):
      virtio_pci: move structure to a header

Stefano Garzarella (1):
      vdpa_sim_blk: allocate the buffer zeroed

 drivers/firmware/Kconfig               |  2 +-
 drivers/firmware/qemu_fw_cfg.c         |  2 +-
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c   |  4 ++--
 drivers/vhost/vdpa.c                   |  1 -
 drivers/virtio/virtio_pci_common.c     |  6 +++---
 drivers/virtio/virtio_pci_modern_dev.c |  7 ++++---
 include/linux/virtio_pci_modern.h      |  7 -------
 include/uapi/linux/virtio_pci.h        | 11 +++++++++++
 8 files changed, 22 insertions(+), 18 deletions(-)


