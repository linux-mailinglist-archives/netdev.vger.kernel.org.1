Return-Path: <netdev+bounces-41761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E187CBDD6
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 10:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0BB1C20BF7
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 08:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B963D387;
	Tue, 17 Oct 2023 08:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B88B3D3AB
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 08:37:33 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0252FE8
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 01:37:31 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 566C5207B3;
	Tue, 17 Oct 2023 10:37:29 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DmfMMl6wHtHY; Tue, 17 Oct 2023 10:37:28 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 4406620764;
	Tue, 17 Oct 2023 10:37:28 +0200 (CEST)
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout1.secunet.com (Postfix) with ESMTP id 2311E80004A;
	Tue, 17 Oct 2023 10:37:27 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 10:37:26 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 17 Oct
 2023 10:37:26 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 6384B3180B49; Tue, 17 Oct 2023 10:37:26 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/7] pull request (net): ipsec 2023-10-17
Date: Tue, 17 Oct 2023 10:37:16 +0200
Message-ID: <20231017083723.1364940-1-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

1) Fix a slab-use-after-free in xfrm_policy_inexact_list_reinsert.
   From Dong Chenchen.

2) Fix data-races in the xfrm interfaces dev->stats fields.
   From Eric Dumazet.

3) Fix a data-race in xfrm_gen_index.
   From Eric Dumazet.

4) Fix an inet6_dev refcount underflow.
   From Zhang Changzhong.

5) Check the return value of pskb_trim in esp_remove_trailer
   for esp4 and esp6. From Ma Ke.

6) Fix a data-race in xfrm_lookup_with_ifid.
   From Eric Dumazet.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit d3287e4038ca4f81e02067ab72d087af7224c68b:

  Revert "net: macsec: preserve ingress frame ordering" (2023-09-05 10:56:55 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git tags/ipsec-2023-10-17

for you to fetch changes up to de5724ca38fd5e442bae9c1fab31942b6544012d:

  xfrm: fix a data-race in xfrm_lookup_with_ifid() (2023-10-13 07:57:27 +0200)

----------------------------------------------------------------
ipsec-2023-10-17

----------------------------------------------------------------
Dong Chenchen (1):
      net: xfrm: skip policies marked as dead while reinserting policies

Eric Dumazet (3):
      xfrm: interface: use DEV_STATS_INC()
      xfrm: fix a data-race in xfrm_gen_index()
      xfrm: fix a data-race in xfrm_lookup_with_ifid()

Ma Ke (2):
      net: ipv6: fix return value check in esp_remove_trailer
      net: ipv4: fix return value check in esp_remove_trailer

Zhang Changzhong (1):
      xfrm6: fix inet6_dev refcount underflow problem

 include/net/netns/xfrm.h       |  1 +
 net/ipv4/esp4.c                |  4 +++-
 net/ipv6/esp6.c                |  4 +++-
 net/ipv6/xfrm6_policy.c        |  4 ++--
 net/xfrm/xfrm_interface_core.c | 22 ++++++++++------------
 net/xfrm/xfrm_policy.c         | 27 ++++++++++++++++-----------
 6 files changed, 35 insertions(+), 27 deletions(-)

