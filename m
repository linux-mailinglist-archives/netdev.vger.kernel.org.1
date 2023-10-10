Return-Path: <netdev+bounces-39517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E16857BF938
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 13:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D32D1C20D4B
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 11:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5F3182BE;
	Tue, 10 Oct 2023 11:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NcU20npk"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE900FBFC
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 11:08:35 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4A4B4
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 04:08:32 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bff776fe0bso71362541fa.0
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 04:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696936110; x=1697540910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+oD5VR/l2G/mJM+GS2eXN6Q/216i6/Lo0wRQz4mDD4w=;
        b=NcU20npktTplg3WYGMI4LzcbqwH2USnDqQKGemaRiDn/yd0OgrUijaZRmIQLejVidk
         EcjHbPI5Da/l0uDRej0zmMB53sqZAnRf2aFZWEMBv4BImOjaRe4KCKHkBPUVBw5rURZ3
         0km3DuDhwCpaWCCdwXVN4L8S8JNzxU1lpTeYflytmL3qpBzv8H+7WgCnQGBxlde4ebUX
         9xKLIy7VYmIFHpQZ/MSpwLS/tXQtrkf5ODKVHVTF1xPmoxCiKnRKpXk849ibMgd/Q2U8
         J2huMrP+nTF3a2LUt8wkjBMUUOJRnFFrerceBpFaAj+SS9/5T4hvkFx9GQ6Ka78eT/Yf
         eeiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696936110; x=1697540910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+oD5VR/l2G/mJM+GS2eXN6Q/216i6/Lo0wRQz4mDD4w=;
        b=JjBXu8csud+9kpxLQJGkDKobNLHxuv+rmvfZaL5jgOoexwyRtyzOFQu9O5bCPrTiNT
         13p71twSjBhfzljyQ5CTb9bb1wpbUHxofy7cV3coKrbBcpvIFLpt8VLdO7jsCrmpN3v2
         MMnmSBoYF2/LXwh29t4ULqy5+5O/NdRNq6ehq/p9Cd/OHg7OY2lBHxINqFxE2FjYrqGO
         C2J9yNqS9R2gowZWfM/cAPWCs82JvdxbStaQ65cSAYG7Mk/BTqyZGppq2D47/zHIrI3E
         NWsT52FV1Y754/olnRbg/hvpnh1vKHM1TWp2sYq0jqFxw/9gNHTIJqKJOhR50AoBEweM
         Hj3Q==
X-Gm-Message-State: AOJu0YzW3F8Moq96gM25Y8PeBGsBKp7yZSArfurhtBbxcIEgCNL1uzp+
	VdW2RwuovSVb8w9EkP9MGecF1U14Vq5KrHs+09o=
X-Google-Smtp-Source: AGHT+IG8FtAGMLBu9Ka+9oxeJ/bEol0Ll2S0gNhy9T3XWCA3N8ogJ5oeVBYln/ME5zkEfeysXzClrg==
X-Received: by 2002:a05:6512:130b:b0:502:ffdf:b098 with SMTP id x11-20020a056512130b00b00502ffdfb098mr19592886lfu.6.1696936110226;
        Tue, 10 Oct 2023 04:08:30 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id r19-20020a056402035300b00522828d438csm7556345edw.7.2023.10.10.04.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 04:08:29 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	johannes@sipsolutions.net
Subject: [patch net-next 00/10] devlink: finish conversion to generated split_ops
Date: Tue, 10 Oct 2023 13:08:19 +0200
Message-ID: <20231010110828.200709-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

This patchset converts the remaining genetlink commands to generated
split_ops and removes the existing small_ops arrays entirely
alongside with shared netlink attribute policy.

Patches #1-#6 are just small preparations and small fixes on multiple
              places. Note that couple of patches contain the "Fixes"
	      tag but no need to put them into -net tree.
Patch #7 is a simple rename preparation
Patch #8 is the main one in this set and adds actual definitions of cmds
         in to yaml file.
Patches #9-#10 finalize the change removing bits that are no longer in
               use.

Jiri Pirko (10):
  genetlink: don't merge dumpit split op for different cmds into single
    iter
  tools: ynl-gen: introduce support for bitfield32 attribute type
  netlink: specs: devlink: remove reload-action from devlink-get cmd
    reply
  netlink: specs: devlink: make dont-validate single line
  netlink: specs: devlink: fix reply command values
  devlink: make devlink_flash_overwrite enum named one
  devlink: rename netlink callback to be aligned with the generated ones
  netlink: specs: devlink: add the remaining command to generate
    complete split_ops
  devlink: remove duplicated netlink callback prototypes
  devlink: remove netlink small_ops

 Documentation/netlink/genetlink-c.yaml      |    2 +-
 Documentation/netlink/genetlink-legacy.yaml |    4 +-
 Documentation/netlink/genetlink.yaml        |    2 +-
 Documentation/netlink/specs/devlink.yaml    | 1607 +++++-
 include/uapi/linux/devlink.h                |    2 +-
 net/devlink/dev.c                           |   10 +-
 net/devlink/devl_internal.h                 |   64 -
 net/devlink/dpipe.c                         |   14 +-
 net/devlink/health.c                        |   24 +-
 net/devlink/linecard.c                      |    3 +-
 net/devlink/netlink.c                       |  328 +-
 net/devlink/netlink_gen.c                   |  757 ++-
 net/devlink/netlink_gen.h                   |   64 +-
 net/devlink/param.c                         |   14 +-
 net/devlink/port.c                          |   11 +-
 net/devlink/rate.c                          |    6 +-
 net/devlink/region.c                        |    8 +-
 net/devlink/resource.c                      |    4 +-
 net/devlink/sb.c                            |   17 +-
 net/devlink/trap.c                          |    9 +-
 net/netlink/genetlink.c                     |    4 +-
 tools/net/ynl/generated/devlink-user.c      | 4920 ++++++++++++++++---
 tools/net/ynl/generated/devlink-user.h      | 4192 ++++++++++++++--
 tools/net/ynl/generated/ethtool-user.h      |    1 +
 tools/net/ynl/generated/fou-user.h          |    1 +
 tools/net/ynl/generated/handshake-user.h    |    1 +
 tools/net/ynl/generated/netdev-user.h       |    1 +
 tools/net/ynl/lib/ynl.c                     |    6 +
 tools/net/ynl/lib/ynl.h                     |    1 +
 tools/net/ynl/ynl-gen-c.py                  |   31 +
 30 files changed, 10491 insertions(+), 1617 deletions(-)

-- 
2.41.0


