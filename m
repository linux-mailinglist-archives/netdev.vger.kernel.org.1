Return-Path: <netdev+bounces-57307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25922812D50
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 11:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E9B21C20C70
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 10:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E043C47E;
	Thu, 14 Dec 2023 10:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D3MNTQ1j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A8B10F
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 02:49:04 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5caf61210e3so89216387b3.0
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 02:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702550944; x=1703155744; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P4rk7fOlE/5t34JPVYYSlTrusTE6NRgCgMfVqXu5CeA=;
        b=D3MNTQ1jdPbMLAOv3q6U8IvoPXcNQK21mbRMtmQV2V893RrC0UuA1Ywv3ZeorZnnjx
         eiC+a1AHez6WZbpnU8o4CIBaUPhk3qDf8Yq2ChjY0iWW2+eEd87JikPRXQFpV687T86b
         5jl2XurbiHW+QRfVFbo75EqbFUeFaMxCxpRNu/zkTgOF4jnwCGTJVw4mitEE0/Nw75CW
         jNfMVWtFJTqCc0aAlxeuZS/PoOi4KmDcgSpIgTAv20JpTrfx7+peRyWLcFsjO6YB77e0
         EM/B+OFMmbVtuwcicWh268N3Oqt6swE9L8gM/NPr3cITchajhcZBcBLZxVEiL4l3sBTn
         TI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702550944; x=1703155744;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P4rk7fOlE/5t34JPVYYSlTrusTE6NRgCgMfVqXu5CeA=;
        b=cIKPJ9v5cvddJwgnCgdCc5GKVJvVIpeWkdkxmy72ndnkkWREcGxzbIbl4GUHp/S/G0
         n1ioUdbLo9+WNXyeN7uGsryAnvF6dK4DVG0oDwe7SW8luQD81JtcyrvQrVEwhWRE/3qK
         4gpihvNvG6M8FjSVlAd8Jf80wQf3w6kEKdzyjiKvOyDmInWSdyCsYAT/SmtS+rQb6k0m
         kBCPI4qAuK5qK+SnHiqg6/ugL+8WAyurow6fljAVLcbiGjSit4PHnz8kds+YLfzQ56oX
         U6eYrwKYSskDYwgqhS8SsEuaFnjlOofjWS9iKWV5xGqnePC3FKRPJQc2kJeK28Es1cTz
         XHZw==
X-Gm-Message-State: AOJu0YwGbBq5YJHS4EQRd6twpuFDqmvcuZzbKkHYsfRf5ONM9sqZsjr9
	XhGa223mExivD0KC+bqwisIzWEuUpd8kCQ==
X-Google-Smtp-Source: AGHT+IFP2dMULVDFUlxReXIC64DbOjVSvHrTzJkkWCNLwh+4bXyW4BdOLLDsDtpmAnMX0HtayJZKmyTK40bt0Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:3506:b0:5d9:447a:43e8 with SMTP
 id fq6-20020a05690c350600b005d9447a43e8mr112644ywb.5.1702550944085; Thu, 14
 Dec 2023 02:49:04 -0800 (PST)
Date: Thu, 14 Dec 2023 10:48:58 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231214104901.1318423-1-edumazet@google.com>
Subject: [PATCH net-next 0/3] net: optmem_max changes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Chao Wu <wwchao@google.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

optmem_max default value is too small for tx zerocopy workloads.

First patch increases default from 20KB to 128 KB,
which is the value we have used for seven years.

Second patch makes optmem_max sysctl per netns.

Last patch tweaks two tests accordingly.

Eric Dumazet (3):
  net: increase optmem_max default value
  net: Namespace-ify sysctl_optmem_max
  selftests/net: optmem_max became per netns

 Documentation/admin-guide/sysctl/net.rst          |  5 ++++-
 include/net/netns/core.h                          |  1 +
 include/net/sock.h                                |  1 -
 net/core/bpf_sk_storage.c                         |  3 ++-
 net/core/filter.c                                 | 12 +++++++-----
 net/core/net_namespace.c                          |  4 ++++
 net/core/sock.c                                   |  8 ++------
 net/core/sysctl_net_core.c                        | 15 ++++++++-------
 net/ipv4/ip_sockglue.c                            |  6 +++---
 net/ipv6/ipv6_sockglue.c                          |  4 ++--
 .../testing/selftests/net/io_uring_zerocopy_tx.sh |  9 ++++-----
 tools/testing/selftests/net/msg_zerocopy.sh       |  9 ++++-----
 12 files changed, 41 insertions(+), 36 deletions(-)

-- 
2.43.0.472.g3155946c3a-goog


