Return-Path: <netdev+bounces-45823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC267DFCBB
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 23:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EB901F228BC
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 22:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C30D224D4;
	Thu,  2 Nov 2023 22:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o51An1aU"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B5722336
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 22:58:45 +0000 (UTC)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD10C192
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 15:58:39 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1cc0e3a2b6eso12744605ad.3
        for <netdev@vger.kernel.org>; Thu, 02 Nov 2023 15:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698965919; x=1699570719; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pvgC0n67+SaKrpknUpTi3e4V3Zr9x1DSc6RHJj2rLeU=;
        b=o51An1aU3XG9eLbck1OGX1D4h+v7DUbVWUTMYR03y/4R0mKhR5l3K9kLbdlgRjUyqR
         lgUnxQVBranGOkUX+4e4w10FKwz6vwCsamyKE7And5NjACJUwtzPwrMwfg6W8ylGdqMW
         laBCoptht1HTVR37mIe41BzEl8fF6fhNyzzIz2eh7H9Bx/XmY9+qIuCGpGhY0iugGTaA
         2uOVop4SYJRaEmiolu+zsKghmei4+aaWQaaFlMWV4kk76wzDTnq0ofoSPTQNRYmW/lP1
         Awja7ij5RbVXm21CpFDcUW5NEx19EtpxjESNotnYqjR4Le2ckP+ZGKJQFRIIMcMqolHn
         X11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698965919; x=1699570719;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pvgC0n67+SaKrpknUpTi3e4V3Zr9x1DSc6RHJj2rLeU=;
        b=rzTpKOoqeKe7IvgM23fJt/Ho/ronDdtxXpP1p89ljX94drpH3JHoofLgk3EG7m7QdO
         xkzOofBKXvMVXjMNjxc3bEpTH/WSYYncf8SJPEGCHS5OwrTX7OBl8fHO4eDN+Z3PkFyN
         Y/c5cdeFHMsu6lfMLTRFVenwnHvGM7fml3Ou27uALGxTca7QYLK+oEoPq8u+GvGaKQSj
         ZNgnmwfuGLXFzffyU01f9OydOnV81VOIYTRCUvDfWeU9SShsnHBxTzDLadce++3LrrPP
         EmlGvgYqt+NPeWNzE18JWtuUsEshj/iv5R6Ni8O3czKs6inU2PJnwW/Pq+AaXSohS5MH
         zIdA==
X-Gm-Message-State: AOJu0YzB4rsmnpE6rErOJjAaQbDAChS4cdW4+7ic5C2NRnIBRCvM17gQ
	HuV/P0aq17QM08h8QuEYm4IpZSI=
X-Google-Smtp-Source: AGHT+IFLAX7VLkbV2FW2BHfg8/WdYJLEGpUL6ZY1SvlhlqkWOHjLg0Mk8U/BW2bYTX5RE5xmHjWhGWo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:903:238f:b0:1cc:3857:2516 with SMTP id
 v15-20020a170903238f00b001cc38572516mr242963plh.7.1698965919098; Thu, 02 Nov
 2023 15:58:39 -0700 (PDT)
Date: Thu,  2 Nov 2023 15:58:24 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231102225837.1141915-1-sdf@google.com>
Subject: [PATCH bpf-next v5 00/13] xsk: TX metadata
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

This series implements initial TX metadata (offloads) for AF_XDP.
See patch #2 for the main implementation and mlx5/stmmac ones for the
example on how to consume the metadata on the device side.

Starting with two types of offloads:
- request TX timestamp (and write it back into the metadata area)
- request TX checksum offload

Changes since v4:
- remove 'render-max: true' from spec (Jakub)
- move xsk_tx_metadata_ops into include/net/xdp_sock.h (Jakub)
- christmas tree in netdev_nl_dev_fill (Jakub)
- fix > vs >= when dumping masks in samples (Jakub)
- switch to 8-byte alignment for tx metadata length (Jakub)
- spelling fixes in the doc (Magnus)
- deny metadata length >= 256 (Magnus)
- validate metadata flags and deny unknown ones (Jakub)
- move XDP_TX_METADATA_CHECKSUM_SW into umem config flag (Jakub)
- don't print timestamps twice in xdp_hw_metadata (Song)
- rename anonymous xsk_tx_metadata member into request (Alexei)
- add comment to xsk_tx_metadata (Alexei)

I've separated new bits that need a closer review into separate patches:
- xsk_tx_metadata flags validation:
  - xsk: Validate xsk_tx_metadata flags
- new umem flag for sw tx csum calculation (instead of per-packet flag)
  - xsk: Add option to calculate TX checksum in SW

v4: https://lore.kernel.org/bpf/20231019174944.3376335-1-sdf@google.com/

Performance (mlx5):

I've implemented a small xskgen tool to try to saturate single tx queue:
https://github.com/fomichev/xskgen/tree/master

Here are the performance numbers with some analysis.

1. Baseline. Running with commit eb62e6aef940 ("Merge branch 'bpf:
Support bpf_get_func_ip helper in uprobes'"), nothing from this series:

- with 1400 bytes of payload: 98 gbps, 8 mpps
./xskgen -s 1400 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
sent 10000000 packets 116960000000 bits, took 1.189130 sec, 98.357623 gbps 8.409509 mpps

- with 200 bytes of payload: 49 gbps, 23 mpps
./xskgen -s 200 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
sent 10000064 packets 20960134144 bits, took 0.422235 sec, 49.640921 gbps 23.683645 mpps

2. Adding single commit that supports reserving tx_metadata_len
   changes nothing numbers-wise.

- baseline for 1400
./xskgen -s 1400 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
sent 10000000 packets 116960000000 bits, took 1.189247 sec, 98.347946 gbps 8.408682 mpps

- baseline for 200
./xskgen -s 200 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
sent 10000000 packets 20960000000 bits, took 0.421248 sec, 49.756913 gbps 23.738985 mpps

3. Adding -M flag causes xskgen to reserve the metadata and fill it, but
   doesn't set XDP_TX_METADATA descriptor option.

- new baseline for 1400 (with only filling the metadata)
./xskgen -M -s 1400 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
sent 10000000 packets 116960000000 bits, took 1.188767 sec, 98.387657 gbps 8.412077 mpps

- new baseline for 200 (with only filling the metadata)
./xskgen -M -s 200 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
sent 10000000 packets 20960000000 bits, took 0.410213 sec, 51.095407 gbps 24.377579 mpps
(the numbers go sligtly up here, not really sure why, maybe some cache-related
side-effects?

4. Next, I'm running the same test but with the commit that adds actual
   general infra to parse XDP_TX_METADATA (but no driver support).
   Essentially applying "xsk: add TX timestamp and TX checksum offload support"
   from this series. Numbers are the same.

- fill metadata for 1400
./xskgen -M -s 1400 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
sent 10000000 packets 116960000000 bits, took 1.188430 sec, 98.415557 gbps 8.414463 mpps

- fill metadata for 200
./xskgen -M -s 200 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
sent 10000000 packets 20960000000 bits, took 0.411559 sec, 50.928299 gbps 24.297853 mpps

- request metadata for 1400
./xskgen -m -s 1400 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
sent 10000000 packets 116960000000 bits, took 1.188723 sec, 98.391299 gbps 8.412389 mpps

- request metadata for 200
./xskgen -m -s 200 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
sent 10000064 packets 20960134144 bits, took 0.411240 sec, 50.968131 gbps 24.316856 mpps

5. Now, for the most interesting part, I'm adding mlx5 driver support.
   The mpps for 200 bytes case goes down from 23 mpps to 19 mpps, but
   _only_ when I enable the metadata. This looks like a side effect
   of me pushing extra metadata pointer via mlx5e_xdpi_fifo_push.
   Hence, this part is wrapped into 'if (xp_tx_metadata_enabled)'
   to not affect the existing non-metadata use-cases. Since this is not
   regressing existing workloads, I'm not spending any time trying to
   optimize it more (and leaving it up to mlx owners to purse if
   they see any good way to do it).

- same baseline
./xskgen -s 1400 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
sent 10000000 packets 116960000000 bits, took 1.189434 sec, 98.332484 gbps 8.407360 mpps

./xskgen -s 200 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
sent 10000128 packets 20960268288 bits, took 0.425254 sec, 49.288821 gbps 23.515659 mpps

- fill metadata for 1400
./xskgen -M -s 1400 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
sent 10000000 packets 116960000000 bits, took 1.189528 sec, 98.324714 gbps 8.406696 mpps

- fill metadata for 200
./xskgen -M -s 200 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
sent 10000128 packets 20960268288 bits, took 0.519085 sec, 40.379260 gbps 19.264914 mpps

- request metadata for 1400
./xskgen -m -s 1400 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
sent 10000000 packets 116960000000 bits, took 1.189329 sec, 98.341165 gbps 8.408102 mpps

- request metadata for 200
./xskgen -m -s 200 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
sent 10000128 packets 20960268288 bits, took 0.519929 sec, 40.313713 gbps 19.233642 mpps

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

Song Yoong Siang (1):
  net: stmmac: Add Tx HWTS support to XDP ZC

Stanislav Fomichev (12):
  xsk: Support tx_metadata_len
  xsk: Add TX timestamp and TX checksum offload support
  tools: ynl: Print xsk-features from the sample
  net/mlx5e: Implement AF_XDP TX timestamp and checksum offload
  xsk: Document tx_metadata_len layout
  xsk: Validate xsk_tx_metadata flags
  xsk: Add option to calculate TX checksum in SW
  selftests/xsk: Support tx_metadata_len
  selftests/bpf: Add csum helpers
  selftests/bpf: Add TX side to xdp_metadata
  selftests/bpf: Convert xdp_hw_metadata to XDP_USE_NEED_WAKEUP
  selftests/bpf: Add TX side to xdp_hw_metadata

 Documentation/netlink/specs/netdev.yaml       |  19 +-
 Documentation/networking/index.rst            |   1 +
 Documentation/networking/xsk-tx-metadata.rst  |  79 ++++++
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   4 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  72 +++++-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.h  |  11 +-
 .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   |  17 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  12 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  64 ++++-
 include/linux/netdevice.h                     |   2 +
 include/linux/skbuff.h                        |  14 +-
 include/net/xdp_sock.h                        | 111 +++++++++
 include/net/xdp_sock_drv.h                    |  34 +++
 include/net/xsk_buff_pool.h                   |   8 +
 include/uapi/linux/if_xdp.h                   |  47 +++-
 include/uapi/linux/netdev.h                   |  16 ++
 net/core/netdev-genl.c                        |  13 +-
 net/xdp/xdp_umem.c                            |  11 +-
 net/xdp/xsk.c                                 |  56 ++++-
 net/xdp/xsk_buff_pool.c                       |   2 +
 net/xdp/xsk_queue.h                           |  19 +-
 tools/include/uapi/linux/if_xdp.h             |  61 ++++-
 tools/include/uapi/linux/netdev.h             |  16 ++
 tools/net/ynl/generated/netdev-user.c         |  19 ++
 tools/net/ynl/generated/netdev-user.h         |   3 +
 tools/net/ynl/samples/netdev.c                |  10 +-
 tools/testing/selftests/bpf/network_helpers.h |  43 ++++
 .../selftests/bpf/prog_tests/xdp_metadata.c   |  33 ++-
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 235 ++++++++++++++++--
 tools/testing/selftests/bpf/xsk.c             |   3 +
 tools/testing/selftests/bpf/xsk.h             |   1 +
 32 files changed, 967 insertions(+), 70 deletions(-)
 create mode 100644 Documentation/networking/xsk-tx-metadata.rst

-- 
2.42.0.869.gea05f2083d-goog


