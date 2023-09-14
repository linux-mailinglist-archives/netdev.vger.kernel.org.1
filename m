Return-Path: <netdev+bounces-33968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E9A7A0F94
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 23:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507C01C20FC0
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 21:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632BC27719;
	Thu, 14 Sep 2023 21:05:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3FF2770D
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 21:05:13 +0000 (UTC)
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83AB269D
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 14:05:12 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-26f3fce5b45so1288640a91.3
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 14:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694725512; x=1695330312; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=13spL0Rm0ZGXcXIcH5DSZIzgePO9nUsV+W7OjRfRCTw=;
        b=KIW40EqV07LjXhWHNJ7GT5Pm23OAhbWNRkT995qYJK2ghvs+2Ul5eCUyrLNfLX2AWu
         U9l7VBTR/1cZRHbwY6eHOEdRBp2iYczncQHe+Z4NzJ5PrprUeP+o7ZtrlPzTWDqb22ZS
         /Z/jEDSQwz7i4Nzbz21cbmvrBpn4tiNXkwOJdTDsKrqN6mqRexFOvcfVEcdFuzjKeUOF
         OuJBPg0KU4YoahUZawArjZ42L33rIMSppNCFToSjKJEptealzvorsTCD/BIuVzONTz14
         5YSevuiYfAd8EMxqfoyHNc7wCh6dfKiysgl70do7U3UScTzc+NTiIHt6l4OfKAiSf1oW
         LhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694725512; x=1695330312;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=13spL0Rm0ZGXcXIcH5DSZIzgePO9nUsV+W7OjRfRCTw=;
        b=uMAm772bgNVisxB2C1/JYov3xuBQt7J5Nm8s8HebfAxcK2kfIA/feoiZ3zti+CBbyJ
         UcNv7gN0Hggfu6wBjTpkOWEqyUzbahRkiGo4ubI88X06Ru+WsD9OGnSx0xyQUbM9xYjz
         jX/bEJeJG8S0qxRlqygdiLKwUH+BiIOu+GeX2NZ2gcaNvfslWwkFEhbo63KalCouw2ok
         hXs2WFqIZewc7Uxfr3w8zCNagaW3Yxb02gTkqy9HDKOmLVMThr0Pwlnt89meG0GbExCA
         mX+wTxcbrm0zw5mUjYiXaJDYhAFpWhiIn0B3lrSzV9i3J7qz6sD0+CkOgQ4rbNkjXsK4
         QAFA==
X-Gm-Message-State: AOJu0YwYcexH+ia3z//EcRYcBQGRx5VKWrQqITQ+kx2OR7ykk4TVI78K
	RkPnglo5GioyM0r4p7+di/E8P/8=
X-Google-Smtp-Source: AGHT+IEMN2hG9dtM5YRRKewCpdKoIKPR7ONPikbZ6FD/09kibOLr5RACjhIMih7flqe4lTNsti13Q60=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:df8a:b0:271:df39:2332 with SMTP id
 p10-20020a17090adf8a00b00271df392332mr165599pjv.9.1694725512346; Thu, 14 Sep
 2023 14:05:12 -0700 (PDT)
Date: Thu, 14 Sep 2023 14:04:52 -0700
In-Reply-To: <20230914210452.2588884-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230914210452.2588884-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230914210452.2588884-10-sdf@google.com>
Subject: [PATCH bpf-next v2 9/9] xsk: document tx_metadata_len layout
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
 Documentation/networking/xsk-tx-metadata.rst | 77 ++++++++++++++++++++
 2 files changed, 78 insertions(+)
 create mode 100644 Documentation/networking/xsk-tx-metadata.rst

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 5b75c3f7a137..9b2accb48df7 100644
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
index 000000000000..b7289f06745c
--- /dev/null
+++ b/Documentation/networking/xsk-tx-metadata.rst
@@ -0,0 +1,77 @@
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
+- ``XDP_TX_METADATA_TIMESTAMP``: requests the device to put transmission
+  timestamp into ``tx_timestamp`` field of ``union xsk_tx_metadata``.
+- ``XDP_TX_METADATA_CHECKSUM``: requests the device to calculate L4
+  checksum. ``csum_start`` specifies byte offset of there the checksumming
+  should start and ``csum_offset`` specifies byte offset where the
+  device should store the computed checksum.
+- ``XDP_TX_METADATA_CHECKSUM_SW``: requests checksum calculation to
+  be done in software; this mode works only in ``XSK_COPY`` mode and
+  is mostly intended for testing. Do not enable this option, it
+  will negatively affect performance.
+
+Besides the flags above, in order to trigger the offloads, the first
+packet's ``struct xdp_desc`` descriptor should set ``XDP_TX_METADATA``
+bit in the ``options`` field. Also not that in a multi-buffer packet
+only the first chunk should carry the metadata.
+
+Querying Device Capabilities
+============================
+
+Every devices exports its offloads capabilities via netlink netdev family.
+Refer to ``xsk-flags`` features bitmask in
+``Documentation/netlink/specs/netdev.yaml``.
+
+- ``tx-timestamp``: device supports ``XDP_TX_METADATA_TIMESTAMP``
+- ``tx-checksum``: device supports ``XDP_TX_METADATA_CHECKSUM``
+
+Note that every devices supports ``XDP_TX_METADATA_CHECKSUM_SW`` when
+running in ``XSK_COPY`` mode.
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
2.42.0.459.ge4e396fd5e-goog


