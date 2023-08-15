Return-Path: <netdev+bounces-27648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 999E477CAC7
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 11:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8AFC1C20C7B
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 09:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A33107B2;
	Tue, 15 Aug 2023 09:53:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB218107A8
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 09:53:21 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F0610F
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 02:53:20 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 062872083F;
	Tue, 15 Aug 2023 11:53:19 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3yeLE_kk--QT; Tue, 15 Aug 2023 11:53:17 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 7B58C2085B;
	Tue, 15 Aug 2023 11:53:15 +0200 (CEST)
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 6CF5F80004A;
	Tue, 15 Aug 2023 11:53:15 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 11:53:15 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 11:53:14 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 440643182ADE; Tue, 15 Aug 2023 11:53:14 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/11] pull request (net): ipsec 2023-08-15
Date: Tue, 15 Aug 2023 11:52:59 +0200
Message-ID: <20230815095310.3310160-1-steffen.klassert@secunet.com>
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
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

1) Fix a slab-out-of-bounds read in xfrm_address_filter.
   From Lin Ma.

2) Fix the pfkey sadb_x_filter validation.
   From Lin Ma.

3) Use the correct nla_policy structure for XFRMA_SEC_CTX.
   From Lin Ma.

4) Fix warnings triggerable by bad packets in the encap functions.
   From Herbert Xu.

5) Fix some slab-use-after-free in decode_session6.
   From Zhengchao Shao.

6) Fix a possible NULL piointer dereference in xfrm_update_ae_params.
   Lin Ma.

7) Add a forgotten nla_policy for XFRMA_MTIMER_THRESH.
   From Lin Ma.

8) Don't leak offloaded policies.
   From Leon Romanovsky.

9) Delete also the offloading part of an acquire state.
   From Leon Romanovsky.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit 3a8a670eeeaa40d87bd38a587438952741980c18:

  Merge tag 'net-next-6.5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2023-06-28 16:43:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git tags/ipsec-2023-08-15

for you to fetch changes up to f3ec2b5d879ef5bbcb24678914641343cb6399a2:

  xfrm: don't skip free of empty state in acquire policy (2023-08-01 12:04:43 +0200)

----------------------------------------------------------------
ipsec-2023-08-15

----------------------------------------------------------------
Herbert Xu (1):
      xfrm: Silence warnings triggerable by bad packets

Leon Romanovsky (2):
      xfrm: delete offloaded policy
      xfrm: don't skip free of empty state in acquire policy

Lin Ma (5):
      net: xfrm: Fix xfrm_address_filter OOB read
      net: af_key: fix sadb_x_filter validation
      net: xfrm: Amend XFRMA_SEC_CTX nla_policy structure
      xfrm: add NULL check in xfrm_update_ae_params
      xfrm: add forgotten nla_policy for XFRMA_MTIMER_THRESH

Zhengchao Shao (3):
      xfrm: fix slab-use-after-free in decode_session6
      ip6_vti: fix slab-use-after-free in decode_session6
      ip_vti: fix potential slab-use-after-free in decode_session6

 include/net/xfrm.h             |  1 +
 net/ipv4/ip_vti.c              |  4 ++--
 net/ipv6/ip6_vti.c             |  4 ++--
 net/key/af_key.c               |  4 ++--
 net/xfrm/xfrm_compat.c         |  2 +-
 net/xfrm/xfrm_input.c          | 22 +++++++++-------------
 net/xfrm/xfrm_interface_core.c |  4 ++--
 net/xfrm/xfrm_state.c          |  8 ++------
 net/xfrm/xfrm_user.c           | 15 +++++++++++++--
 9 files changed, 34 insertions(+), 30 deletions(-)

