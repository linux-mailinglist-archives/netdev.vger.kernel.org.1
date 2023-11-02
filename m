Return-Path: <netdev+bounces-45825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88AB7DFCC1
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 23:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06AE5B21430
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 22:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579412233A;
	Thu,  2 Nov 2023 22:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AGmGFi4d"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FD3225A1
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 22:58:52 +0000 (UTC)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428F4133
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 15:58:50 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1cc5ef7e815so11807815ad.3
        for <netdev@vger.kernel.org>; Thu, 02 Nov 2023 15:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698965930; x=1699570730; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HxShEwzn2SwGeh/fxMP8q3kc87+t2JtKbOUp4FoNDAk=;
        b=AGmGFi4d/yKsspPXCF0T6zVS8eEc6pCR3ZgirkgHNiVzXHmVO/hRtdj0jgMGmXy87C
         QlojbcraG5/z6axNc+Zz4bxDHCT7U/NAU3+GS7iI4nszsWuAXRvHv1wxkL1gy5FDnHbZ
         Xhr1GqWwAMS/62qXHXEWsrAcaJlLaO4kECjQUIbP46jdGeucXWIUs3iUOB0/1029mKNr
         mZEIlNYOsz+1VI/8QuEh0P1tcM9YhetlzD9I4grNehWO0GqDmz7N7RuqlxBLq3uIbOFs
         2l/+h8xO3q2aSCxYBPxsmQ74HwXUT2xEGInz2N0s5TODxq1Unz58N/VXY43ouNAOmp5/
         bqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698965930; x=1699570730;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HxShEwzn2SwGeh/fxMP8q3kc87+t2JtKbOUp4FoNDAk=;
        b=SmUgjjK8GPFVbwIqexaZXyekqUIkcdGXTQH9YiitnLrDy0XjUaxhLbnsMryFuBKu8o
         e6XtUoegoIsEHS1X5S1Xk9kfQfNQHcxJrGZ8rhyMfUFQCUpJeLIhi1bChKevl6ksbTTv
         2TXrT8fJMvUTLGodMGsuumGlSJXjdHjto+5vuBEtwHaa1R1wtIxv/47AVZidWUYx//sL
         3KTHeu4zlatyw1pWgNL6FHVNAeUWiNQKRsH5oiD+SNH4CNSRShyB8Gp8SFZXR4UU8DqX
         KQUQhcd93GIok3Ytqd29d2Yf+llTsqD/dLB3joNB2D49/LcwZpaZJi74khKQfXY5eP5q
         9fsg==
X-Gm-Message-State: AOJu0YxNYDB7eAVk4Iv1uDsysSneyNJcWiyodD6UIBlnRGGw0IPOg26Z
	DLFofEWyhgKXC2LqQe/IzEjnETc=
X-Google-Smtp-Source: AGHT+IFHksWobVq1DgklW4mDeMreDlgWsTTNqA/kCtQ42AoUqzv4G7g6ZHTYaGfKWIPjKCcaSl6uF+I=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:d48c:b0:1cc:2f2a:7d33 with SMTP id
 c12-20020a170902d48c00b001cc2f2a7d33mr319925plg.2.1698965929763; Thu, 02 Nov
 2023 15:58:49 -0700 (PDT)
Date: Thu,  2 Nov 2023 15:58:30 -0700
In-Reply-To: <20231102225837.1141915-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231102225837.1141915-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231102225837.1141915-7-sdf@google.com>
Subject: [PATCH bpf-next v5 06/13] xsk: Document tx_metadata_len layout
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, yoong.siang.song@intel.com, netdev@vger.kernel.org, 
	xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"

- how to use
- how to query features
- pointers to the examples

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 Documentation/networking/index.rst           |  1 +
 Documentation/networking/xsk-tx-metadata.rst | 70 ++++++++++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 Documentation/networking/xsk-tx-metadata.rst

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 683eb42309cc..a297a894b366 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -123,6 +123,7 @@ Refer to :ref:`netdev-FAQ` for a guide on netdev development process specifics.
    xfrm_sync
    xfrm_sysctl
    xdp-rx-metadata
+   xsk-tx-metadata
 
 .. only::  subproject and html
 
diff --git a/Documentation/networking/xsk-tx-metadata.rst b/Documentation/networking/xsk-tx-metadata.rst
new file mode 100644
index 000000000000..4f376560b23f
--- /dev/null
+++ b/Documentation/networking/xsk-tx-metadata.rst
@@ -0,0 +1,70 @@
+==================
+AF_XDP TX Metadata
+==================
+
+This document describes how to enable offloads when transmitting packets
+via :doc:`af_xdp`. Refer to :doc:`xdp-rx-metadata` on how to access similar
+metadata on the receive side.
+
+General Design
+==============
+
+The headroom for the metadata is reserved via ``tx_metadata_len`` in
+``struct xdp_umem_reg``. The metadata length is therefore the same for
+every socket that shares the same umem. The metadata layout is a fixed UAPI,
+refer to ``union xsk_tx_metadata`` in ``include/uapi/linux/if_xdp.h``.
+Thus, generally, the ``tx_metadata_len`` field above should contain
+``sizeof(union xsk_tx_metadata)``.
+
+The headroom and the metadata itself should be located right before
+``xdp_desc->addr`` in the umem frame. Within a frame, the metadata
+layout is as follows::
+
+           tx_metadata_len
+     /                         \
+    +-----------------+---------+----------------------------+
+    | xsk_tx_metadata | padding |          payload           |
+    +-----------------+---------+----------------------------+
+                                ^
+                                |
+                          xdp_desc->addr
+
+An AF_XDP application can request headrooms larger than ``sizeof(struct
+xsk_tx_metadata)``. The kernel will ignore the padding (and will still
+use ``xdp_desc->addr - tx_metadata_len`` to locate
+the ``xsk_tx_metadata``). For the frames that shouldn't carry
+any metadata (i.e., the ones that don't have ``XDP_TX_METADATA`` option),
+the metadata area is ignored by the kernel as well.
+
+The flags field enables the particular offload:
+
+- ``XDP_TXMD_FLAGS_TIMESTAMP``: requests the device to put transmission
+  timestamp into ``tx_timestamp`` field of ``union xsk_tx_metadata``.
+- ``XDP_TXMD_FLAGS_CHECKSUM``: requests the device to calculate L4
+  checksum. ``csum_start`` specifies byte offset of where the checksumming
+  should start and ``csum_offset`` specifies byte offset where the
+  device should store the computed checksum.
+
+Besides the flags above, in order to trigger the offloads, the first
+packet's ``struct xdp_desc`` descriptor should set ``XDP_TX_METADATA``
+bit in the ``options`` field. Also note that in a multi-buffer packet
+only the first chunk should carry the metadata.
+
+Querying Device Capabilities
+============================
+
+Every devices exports its offloads capabilities via netlink netdev family.
+Refer to ``xsk-flags`` features bitmask in
+``Documentation/netlink/specs/netdev.yaml``.
+
+- ``tx-timestamp``: device supports ``XDP_TXMD_FLAGS_TIMESTAMP``
+- ``tx-checksum``: device supports ``XDP_TXMD_FLAGS_CHECKSUM``
+
+See ``tools/net/ynl/samples/netdev.c`` on how to query this information.
+
+Example
+=======
+
+See ``tools/testing/selftests/bpf/xdp_hw_metadata.c`` for an example
+program that handles TX metadata. Also see https://github.com/fomichev/xskgen
+for a more bare-bones example.
-- 
2.42.0.869.gea05f2083d-goog


