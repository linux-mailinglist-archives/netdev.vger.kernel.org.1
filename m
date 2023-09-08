Return-Path: <netdev+bounces-32681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 954BD79928B
	for <lists+netdev@lfdr.de>; Sat,  9 Sep 2023 00:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68E81C20CB2
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 22:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4524A6FB2;
	Fri,  8 Sep 2023 22:58:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357271C16
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 22:58:10 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F361FEA
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 15:58:09 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7e857a3fd5so2657870276.3
        for <netdev@vger.kernel.org>; Fri, 08 Sep 2023 15:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694213889; x=1694818689; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5vtcfBbKqQeR2NL5yHx5os/nTJeJCveHJ565EoPZims=;
        b=Op07wZPKXWLvFXqiLGX3vPkssp1KYBORTx7PNclJjJ8410ctBbszBJmQKZv1VL+rV5
         mQWZTfWtXhnp40/rMLT8nRdkYtp42fl3H74+eP3VolfN5eb5vrInlJOor/KNWUz6tqO6
         Nm8Y6AofN8Vjw01OgcRX2ncUzj7TPxbIfSJ6jccLHZTjgwJ3g8EhKYhGjaWDVLu3qwnV
         7I1thDqqStESEKdAQV7Ouc8iejmtkc6MZpRMi3gFqB01Cp2gAByNPbdQPYvvlXtTQVpS
         RQrz1JsQRFfayvhFyI7N38NK808l2+y+7I5mVfgP6j+Z1K4CnlbrfYTXImf7RnzIdDal
         CMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694213889; x=1694818689;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5vtcfBbKqQeR2NL5yHx5os/nTJeJCveHJ565EoPZims=;
        b=qcloH+QyY/1pVFCWKShmEAe9GdSJdRPPz7E76xv41FL5KK2tOsOUrKavkftkl5y2LG
         WSl/iPKcGhTfsaD4/tpYL4PK2/HjeBOZ7wQhkm+8NbRAT1HOZpUmJf+F5w9tJ73pTsCg
         o7/tlKtPnYKGtyEnu42c69afIGP43UG7iL1aGF7/YApIEgzIiyApfFzxsWBAfXpxfi3y
         WC2rYBSgCDPoetzX+fOEHtR2G/MGwpQ2x3E/sl16bxKVBPk3GIKWOznE5PU0Wk+jVHD0
         85ucMayHXRHqsDN4Y6QjP7qaGE+Nd+RsFJklSLzJyBCZeZKASA9RDlf5TuE0+DnR8h8f
         70zQ==
X-Gm-Message-State: AOJu0YxLoBsT9Hqh2Y32KJ+QTx3a9VC3QVLsawZKgWsIGSO5fRAV18cs
	VV1ThcFgaAwdUcXAbJtHK7rP97o=
X-Google-Smtp-Source: AGHT+IFMr8kDef6fP6VHllz0ktFC++4PEzH4rR9MyQ8wKQ7UYoHbD8BrZzjuJnnWPWrDSN0AbAuzrDU=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:adc3:0:b0:d01:60ec:d0e with SMTP id
 d3-20020a25adc3000000b00d0160ec0d0emr91876ybe.9.1694213888955; Fri, 08 Sep
 2023 15:58:08 -0700 (PDT)
Date: Fri,  8 Sep 2023 15:58:04 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230908225807.1780455-1-sdf@google.com>
Subject: [PATCH bpf-next 0/3] bpf: expose information about netdev
 xdp-metadata kfunc support
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Extend netdev netlink family to expose the bitmask with the
kfuncs that the device implements. The source of truth is the
device's xdp_metadata_ops. There is some amount of auto-generated
netlink boilerplate; the change itself is super minimal.

Cc: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>

Stanislav Fomichev (3):
  bpf: make it easier to add new metadata kfunc
  bpf: expose information about supported xdp metadata kfunc
  tools: ynl: extend netdev sample to dump xdp-rx-metadata-features

 Documentation/netlink/specs/netdev.yaml      | 21 ++++++++++++++++++++
 Documentation/networking/xdp-rx-metadata.rst |  7 +++++++
 include/net/xdp.h                            | 19 ++++++++++++++----
 include/uapi/linux/netdev.h                  | 16 +++++++++++++++
 kernel/bpf/offload.c                         |  9 +++++----
 net/core/netdev-genl.c                       | 12 ++++++++++-
 net/core/xdp.c                               |  4 ++--
 tools/include/uapi/linux/netdev.h            | 16 +++++++++++++++
 tools/net/ynl/generated/netdev-user.c        | 19 ++++++++++++++++++
 tools/net/ynl/generated/netdev-user.h        |  3 +++
 tools/net/ynl/samples/Makefile               |  2 +-
 tools/net/ynl/samples/netdev.c               |  8 +++++++-
 12 files changed, 123 insertions(+), 13 deletions(-)

-- 
2.42.0.283.g2d96d420d3-goog


