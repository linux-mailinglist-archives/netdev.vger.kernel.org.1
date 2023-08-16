Return-Path: <netdev+bounces-28154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6520977E697
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 18:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B7C11C21159
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 16:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B1F1095F;
	Wed, 16 Aug 2023 16:40:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9B32F52
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 16:40:07 +0000 (UTC)
X-Greylist: delayed 401 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Aug 2023 09:40:03 PDT
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2A3E4C
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 09:40:03 -0700 (PDT)
Received: from kero.packetmixer.de (p200300fa272a67000Bb2D6Dcaf57D46e.dip0.t-ipconnect.de [IPv6:2003:fa:272a:6700:bb2:d6dc:af57:d46e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 81DBFFB5C2;
	Wed, 16 Aug 2023 18:40:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1692204001; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:references; bh=I+eNQQSjj0fLqG+BSXaidpJmTR8Z/e+0zb1hTzjHxqM=;
	b=Ymb+qXUCe/EpQCfCzLD60gxk9l9FBltIJdqEG1j0Q7+8r41cyUJPTn3jZJY0PJ5dAVApB3
	bN7++gO+szqeYk4bJdDJosSebRarW4W/pxH4OpoEH4qgv+u7dxfqmSJOuu4CNicI+CkIMQ
	SKiZuMmzTCUjJf6byAAw0iP9DBtoNv5pgH/c9ql2KxOJDqk8MPhftvPjZX+8Lh2zpMmRj7
	wEJpoiVh1mbjaiyeNdOx0+oZOCfmIxtEcGjT0eF7T8jut+soaOu3gmbBPCBvwCeUm2qXzN
	ps2/1l7FhpyKdL1p+vl+BKnu091kyTvoLEXw/Ie7poQ50RbALiOSdCrd3D3GHA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/7] pull request for net-next: batman-adv 2023-08-16
Date: Wed, 16 Aug 2023 18:39:53 +0200
Message-Id: <20230816164000.190884-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
	d=simonwunderlich.de; s=09092022; t=1692204001;
	h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:references; bh=I+eNQQSjj0fLqG+BSXaidpJmTR8Z/e+0zb1hTzjHxqM=;
	b=ps4xuiNxZY+wGGy9p0uQd6t0RuOKMyhua+3vMXc4VzB86bpFX5TUENVufo7xXNirc1L78E
	119FDLiEBG/bWOaoBZ4RF2PkNMatZMuZayOuNlr2yEyxMwZTQi9YRgu+tFX8HQXRBn6BW0
	29yMN+kY91PPg3ID2YLx+1bNd8n2e7rTgxT4fo7rxkJT7GqCRq/UV8SWbWkDAFnuU0elYQ
	T8VcLRfDRQGlyHPBh1+fww9Goo4dJYL22K0pOaYFu0gm8fIzoZOLsM9biohLtHn/S3Ig4F
	7xEDF5nMkWxIrP8RLFwd/dSNYbWoGUGPPy419cLNfyWMPBRIeiW0Jz0buzLmrA==
ARC-Seal: i=1; s=09092022; d=simonwunderlich.de; t=1692204001; a=rsa-sha256;
	cv=none;
	b=P+7j+XEL5cTgQM5CkLn64UVNnipyBjxTxAaZMIZ38zsY32s9vxmXonkM9sleXcYdVDRWxBJN3y8TfH9wCgkwdG2vvIHqLvhZHCYNeMwfElc4auPh8wLXYnE987dGLsMpSC+jMAMxRp9PvZ9KAA4pw2B2vyX3r7GeeoBvMZWVHwWLXnybVB6l5CZlYo1HLya33/37DnQ/fRxsuy5mexsZyUvTbvTE9JUzlS1v0nRpLECAQeniu2ARo5yyRqrj10rXkIjXSow/IjhT8+jkSU48qQB1LDfcekojUxgavxblLVqaaaWPS8phd/71tQChJYxT3tlEAFn+q+gLBlu7M2X10A==
ARC-Authentication-Results: i=1;
	mail.simonwunderlich.de;
	auth=pass smtp.auth=sw@simonwunderlich.de smtp.mailfrom=sw@simonwunderlich.de
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Jakub, hi David,

here is a cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-pullrequest-20230816

for you to fetch changes up to 6f96d46f9a1ad1c02589b598c56ea881094129d8:

  batman-adv: Drop per algo GW section class code (2023-08-14 18:01:21 +0200)

----------------------------------------------------------------
This cleanup patchset includes the following patches:

 - bump version strings, by Simon Wunderlich

 - Remove unused declarations, by Yue Haibing

 - Clean up MTU handling, by Sven Eckelmann (2 patches)

 - Clean up/remove (obsolete) functions, by Sven Eckelmann (3 patches)

----------------------------------------------------------------
Simon Wunderlich (1):
      batman-adv: Start new development cycle

Sven Eckelmann (5):
      batman-adv: Avoid magic value for minimum MTU
      batman-adv: Check hardif MTU against runtime MTU
      batman-adv: Drop unused function batadv_gw_bandwidth_set
      batman-adv: Keep batadv_netlink_notify_* static
      batman-adv: Drop per algo GW section class code

YueHaibing (1):
      batman-adv: Remove unused declarations

 net/batman-adv/bat_iv_ogm.c     |   1 +
 net/batman-adv/bat_v.c          |  23 +-----
 net/batman-adv/gateway_common.c | 162 +---------------------------------------
 net/batman-adv/gateway_common.h |   7 --
 net/batman-adv/hard-interface.c |  20 +++--
 net/batman-adv/main.h           |   2 +-
 net/batman-adv/netlink.c        |  15 ++--
 net/batman-adv/netlink.h        |   6 --
 net/batman-adv/routing.h        |   4 -
 net/batman-adv/soft-interface.c |   2 +-
 net/batman-adv/types.h          |   7 +-
 11 files changed, 28 insertions(+), 221 deletions(-)

