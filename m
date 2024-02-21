Return-Path: <netdev+bounces-73774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F48685E4DD
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 18:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16A841F23DF3
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 17:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B5583CDB;
	Wed, 21 Feb 2024 17:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6mqhk0E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14007BB00
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 17:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708537590; cv=none; b=atBUvu8xQp+1mIaOGotkkM/pfkLO/hq/2muU+zzjHLQJQU3u4isfdrzRVos9VtWbYShFnWx3aGyD2yjBCTCM4MdzVPv1zIMQV/pwHk7F76xgryzcgVUY6y6Pt07wS3d/cUZRh5aet8zXdOK0U8l2hadX4M4P2Bpzl7ND4ySNJ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708537590; c=relaxed/simple;
	bh=08b+Vo67o6SmoB7++Gm/1GoSVDkHKmrdybkawQNPv0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=D49qoUoD2OPvczaRsuH8rCXGLJ0ag4Xtk1exgqti5uPXsC/rV1rsDgQs29ifySHAW6z1mm0TKk/QC43uX4sCyA7RRvmvtV9hWHY/FetNg8azvxNsF0RQ6Ht0KE3oVP6nDyhzyWJDQq+fu8wDT3h6a/8Z3we11Kki117pxYVbst8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6mqhk0E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42776C433A6;
	Wed, 21 Feb 2024 17:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708537589;
	bh=08b+Vo67o6SmoB7++Gm/1GoSVDkHKmrdybkawQNPv0M=;
	h=From:Date:Subject:To:Cc:From;
	b=W6mqhk0E2fqFmRDkv4SmKqDnsrWdQ+XnKNmevMhJRmDJt2s4lvSb9gACGDSAbkCXQ
	 zqZZrspFK5rxlaBl7UTx9UVRpykou5gnm5pZMuP/Zs7dpseZSm7S3uHaHaudZw/Jy7
	 V/6G9M93ErOgPrPtn+WN/HTLGlGshqYZbR/ss0wWjBW4WhdP2jZWdKwU3ta+itH7tK
	 xIIwv+wM+cCW9H3n9vLWjGISZOeXGsnuVs2RwYUB7zb30TDd+CPb1IUjU+ZIbAFRtf
	 IMvBxx4JHoN0HQY5hUGLn47JWkgP03elIhfa+05rrcp5JNWTbzcsb8V4oUodOrBQOO
	 XPspKgseABGqw==
From: Simon Horman <horms@kernel.org>
Date: Wed, 21 Feb 2024 17:46:21 +0000
Subject: [PATCH net-next] ps3/gelic: minor Kernel Doc corrections
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-ps3-gelic-kdoc-v1-1-7629216d1340@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOw21mUC/x3MQQqAIBBA0avErBuoKci6SrQwnWwoLDQikO6et
 HyL/xNEDsIRhiJB4FuiHD6jLgswq/aOUWw2UEVtRVTjGRt0vIvBzR4GiZRVSve6m1vI0Rl4kec
 fjuD5Qs/PBdP7fiwThxJqAAAA
To: Geoff Levand <geoff@infradead.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, netdev@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org
X-Mailer: b4 0.12.3

* Update the Kernel Doc for gelic_descr_set_tx_cmdstat()
  and gelic_net_setup_netdev() so that documented name
  and the actual name of the function match.

* Move define of GELIC_ALIGN() so that it is no longer
  between gelic_alloc_card_net() and it's Kernel Doc.

* Document netdev parameter of gelic_alloc_card_net()
  in a way consistent to the documentation of other netdev parameters
  in this file.

Addresses the following warnings flagged by ./scripts/kernel-doc -none:

  .../ps3_gelic_net.c:711: warning: expecting prototype for gelic_net_set_txdescr_cmdstat(). Prototype was for gelic_descr_set_tx_cmdstat() instead
  .../ps3_gelic_net.c:1474: warning: expecting prototype for gelic_ether_setup_netdev(). Prototype was for gelic_net_setup_netdev() instead
  .../ps3_gelic_net.c:1528: warning: expecting prototype for gelic_alloc_card_net(). Prototype was for GELIC_ALIGN() instead
  .../ps3_gelic_net.c:1531: warning: Function parameter or struct member 'netdev' not described in 'gelic_alloc_card_net'

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/toshiba/ps3_gelic_net.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.c b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
index d5b75af163d3..12b96ca66877 100644
--- a/drivers/net/ethernet/toshiba/ps3_gelic_net.c
+++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
@@ -698,7 +698,7 @@ gelic_card_get_next_tx_descr(struct gelic_card *card)
 }
 
 /**
- * gelic_net_set_txdescr_cmdstat - sets the tx descriptor command field
+ * gelic_descr_set_tx_cmdstat - sets the tx descriptor command field
  * @descr: descriptor structure to fill out
  * @skb: packet to consider
  *
@@ -1461,7 +1461,7 @@ static void gelic_ether_setup_netdev_ops(struct net_device *netdev,
 }
 
 /**
- * gelic_ether_setup_netdev - initialization of net_device
+ * gelic_net_setup_netdev - initialization of net_device
  * @netdev: net_device structure
  * @card: card structure
  *
@@ -1518,14 +1518,16 @@ int gelic_net_setup_netdev(struct net_device *netdev, struct gelic_card *card)
 	return 0;
 }
 
+#define GELIC_ALIGN (32)
+
 /**
  * gelic_alloc_card_net - allocates net_device and card structure
+ * @netdev: interface device structure
  *
  * returns the card structure or NULL in case of errors
  *
  * the card and net_device structures are linked to each other
  */
-#define GELIC_ALIGN (32)
 static struct gelic_card *gelic_alloc_card_net(struct net_device **netdev)
 {
 	struct gelic_card *card;


