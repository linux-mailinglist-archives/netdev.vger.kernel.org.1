Return-Path: <netdev+bounces-16116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FB474B711
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 21:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0A1B281862
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 19:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D2F174C4;
	Fri,  7 Jul 2023 19:30:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7F6171C3
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 19:30:22 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B052D43
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 12:30:08 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5704e551e8bso27109707b3.3
        for <netdev@vger.kernel.org>; Fri, 07 Jul 2023 12:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688758208; x=1691350208;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uptpMQC653oKJSTn2JeNLG9ySVYyYlQNrajcSogK5Tw=;
        b=L2jGngrZH8yD9Z4Mr+a2wd3U9H5EwVkTx/MoxYSPpo90pGRAHtEhDXA4W6c+NwGzCN
         IY19kGhh5xvMgQ2sYsQj9Eb1DDbb9MkrgtdvuVuP9y4c2x1YSMpVdgIP9eKe0EY1ycHJ
         RMNlo3DCyk2JST70Ri3XQZjSWrDGL5rJgWk7a8cva8TsR90KxHwcSl6Y8IQt16087mFB
         IKST+6+Tr1m7RGgJb1f3ZqEIx4QFkpP3dTDE5iBU1clo8WgHSvJEuWPq5eroV47uz93n
         iA2pshuVwkGmoOGR+7ysG3GiIGc8t0nwDSNVz8jkMoHgAI9wfb5id+VVhfN+xu9xHwQh
         4kUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688758208; x=1691350208;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uptpMQC653oKJSTn2JeNLG9ySVYyYlQNrajcSogK5Tw=;
        b=AgEfQpDnqqTy+VzrxTKMciPXM5sTZSPQ8RU++fUMyJRytkQ2t1ch5qk5Zm+Q00KHIK
         39IWsZBjEYQGr1n/UDhWK69/m9hEPu3geUBRwFjN4Ee2vpac/mVF0GUw0tytBGnjjwrx
         6GjazxNcAG8oGyQYwRUPnKG2SfXqYJSbhFiZifPr5eCdhgVAPVYIJLD9gaJOSNHi/bOr
         13T8FQFc7aMv56eAFNDG1Xqym33lmR9uXFGipDszKxYDaJvVxM6I82VS+gxGlmlLS+zO
         nT2NdD7zGu3K2kpnE8nzk+n/Rv18PvrQX6xtka1g1KcQGn4DAg3GbObFtkyiVtivZRKW
         CK2g==
X-Gm-Message-State: ABy/qLYz1ALC5Rk5LLgoNK4DOyAazJe5pHx3jDFImGgioLmBVCVVwiqG
	vthF7MLGdh2kNRTHDYlPRsBssG0=
X-Google-Smtp-Source: APBJJlGdpjnRN24Ysb+zvybB++DuYFIwJguLszCLPsbWVapW6jAwXwCepnp+aIT6PvjDSYFrw0zFKzM=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:e409:0:b0:56d:5d2:1bb1 with SMTP id
 r9-20020a81e409000000b0056d05d21bb1mr41797ywl.2.1688758207783; Fri, 07 Jul
 2023 12:30:07 -0700 (PDT)
Date: Fri,  7 Jul 2023 12:29:52 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230707193006.1309662-1-sdf@google.com>
Subject: [RFC bpf-next v3 00/14] bpf: Netdev TX metadata
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, netdev@vger.kernel.org, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--- Changes since RFC v2 ---

- Separate skb & xdp path
  - XSK is still weird in mlx5 driver; I have to create xdp_frame on
    the stack for af_xdp
- Add TX checksum kfunc
  - In a separate patch for now to show extensibility
  - Same API as we have in skb world
- mlx5 patches with tx timestamp/checksum support
  - xdp_hw_metadata is extended with appropriate bits
    - report sw completion timestamp as well

v2: https://lore.kernel.org/bpf/CAKH8qBvnNCY=eFh4pMRZqBs88JBd66sVD+Yt8mGyQJOAtq7jrA@mail.gmail.com/T/#m6e45f78b11ac10f724a9472359c44f1a38a679cb

--- Use cases ---

The goal of this series is to add two new standard-ish places
in the transmit path:

1. Right before the packet is transmitted (with access to TX
   descriptors)
2. Right after the packet is actually transmitted and we've received the
   completion (again, with access to TX completion descriptors)

Accessing TX descriptors unlocks the following use-cases:

- Setting device hints at TX: XDP/AF_XDP might use these new hooks to
use device offloads. The existing case implements TX timestamp.
- Observability: global per-netdev hooks can be used for tracing
the packets and exploring completion descriptors for all sorts of
device errors.

Accessing TX descriptors also means that the hooks have to be called
from the drivers.

The hooks are a light-weight alternative to XDP at egress and currently
don't provide any packet modification abilities. However, eventually,
can expose new kfuncs to operate on the packet (or, rather, the actual
descriptors; for performance sake).

--- UAPI ---

The hooks are implemented in a HID-BPF style. Meaning they don't
expose any UAPI and are implemented as tracing programs that call
a bunch of kfuncs. The attach/detach operation happen via regular
global fentry points. Network namespace and ifindex are exposed
to allow filtering out particular netdev.

--- skb vs xdp ---

The hooks operate on a new light-weight devtx_ctx which contains:
- sinfo (frags)
- netdev

skb and xdp_frame hook points are separate; skb and xdp_frame are
passed directly into the hook where appropriate.

--- TODO ---

Things that I'm planning to do for the non-RFC series:
- have some real device support to verify xdp_hw_metadata works
  - performance numbers with/without feature enabled (Toke)
- add has_timestamp flag to af_xdp tx_desc (Toke & Jesper)
- freplace
- explore dynptr (Toke)
- Documentation/networking/xdp-rx-metadata.rst - like documentation

Stanislav Fomichev (14):
  bpf: Rename some xdp-metadata functions into dev-bound
  bpf: Make it easier to add new metadata kfunc
  xsk: Support XDP_TX_METADATA_LEN
  bpf: Implement devtx hook points
  bpf: Implement devtx timestamp kfunc
  net: veth: Implement devtx timestamp kfuncs
  bpf: Introduce tx checksum devtx kfuncs
  net: veth: Implement devtx tx checksum
  net/mlx5e: Implement devtx kfuncs
  selftests/xsk: Support XDP_TX_METADATA_LEN
  selftests/bpf: Add helper to query current netns cookie
  selftests/bpf: Add csum helpers
  selftests/bpf: Extend xdp_metadata with devtx kfuncs
  selftests/bpf: Extend xdp_hw_metadata with devtx kfuncs

 MAINTAINERS                                   |   2 +
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |  15 +
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  | 155 +++++++++-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.h  |   4 +-
 .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   |  10 +
 .../net/ethernet/mellanox/mlx5/core/en_tx.c   |  24 ++
 .../net/ethernet/mellanox/mlx5/core/main.c    |  15 +-
 drivers/net/veth.c                            | 126 +++++++-
 include/linux/netdevice.h                     |   6 +
 include/net/devtx.h                           |  66 +++++
 include/net/offload.h                         |  45 +++
 include/net/xdp.h                             |  18 +-
 include/net/xdp_sock.h                        |   1 +
 include/net/xsk_buff_pool.h                   |   1 +
 include/uapi/linux/if_xdp.h                   |   1 +
 kernel/bpf/offload.c                          |  52 +++-
 kernel/bpf/verifier.c                         |   4 +-
 net/core/Makefile                             |   1 +
 net/core/dev.c                                |   1 +
 net/core/devtx.c                              | 168 +++++++++++
 net/core/xdp.c                                |  20 +-
 net/xdp/xsk.c                                 |  35 ++-
 net/xdp/xsk_buff_pool.c                       |   1 +
 net/xdp/xsk_queue.h                           |   7 +-
 tools/testing/selftests/bpf/network_helpers.c |  21 ++
 tools/testing/selftests/bpf/network_helpers.h |  44 +++
 .../selftests/bpf/prog_tests/xdp_metadata.c   |  64 ++++-
 .../selftests/bpf/progs/xdp_hw_metadata.c     | 173 +++++++++++
 .../selftests/bpf/progs/xdp_metadata.c        | 141 +++++++++
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 269 +++++++++++++++++-
 tools/testing/selftests/bpf/xdp_metadata.h    |  16 ++
 tools/testing/selftests/bpf/xsk.c             |  17 ++
 tools/testing/selftests/bpf/xsk.h             |   1 +
 33 files changed, 1451 insertions(+), 73 deletions(-)
 create mode 100644 include/net/devtx.h
 create mode 100644 include/net/offload.h
 create mode 100644 net/core/devtx.c

-- 
2.41.0.255.g8b1d071c50-goog


