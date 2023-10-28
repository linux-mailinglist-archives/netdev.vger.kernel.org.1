Return-Path: <netdev+bounces-44977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 229E37DA5E5
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 10:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0C90B212D3
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 08:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C382A9471;
	Sat, 28 Oct 2023 08:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A0079DC
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 08:43:36 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262EC11F
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 01:43:35 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id E837A2085F;
	Sat, 28 Oct 2023 10:43:33 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hqG4AoAmxOSk; Sat, 28 Oct 2023 10:43:33 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 830DF2083F;
	Sat, 28 Oct 2023 10:43:32 +0200 (CEST)
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 77EDA80004A;
	Sat, 28 Oct 2023 10:43:32 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sat, 28 Oct 2023 10:43:32 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Sat, 28 Oct
 2023 10:43:31 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 2D5F73182B50; Sat, 28 Oct 2023 10:43:31 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/10] pull request (net-next): ipsec-next 2023-10-28
Date: Sat, 28 Oct 2023 10:43:18 +0200
Message-ID: <20231028084328.3119236-1-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

1) Remove unused function declarations of xfrm4_extract_input and
   xfrm6_extract_input. From Yue Haibing.

2) Annotate struct xfrm_sec_ctx with __counted_by.
   From Kees Cook.

3) Support GRO decapsulation for ESP in UDP encapsulation.
   From Antony Antony et all.

4) Replace the xfrm session decode with flow dissector.
   From Florian Westphal.

5) Fix a use after free in __xfrm6_udp_encap_rcv.

6) Fix the layer 4 flowi decoding.
   From Florian Westphal.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit 3a69ab875233734bc434402379100272cd70bde2:

  Merge branch 'ionic-better-tx-sg=handling' (2023-09-20 10:52:31 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git tags/ipsec-next-2023-10-28

for you to fetch changes up to eefed7662ff223f70ba8b1af07f1a096a5ece588:

  xfrm: policy: fix layer 4 flowi decoding (2023-10-27 10:12:09 +0200)

----------------------------------------------------------------
ipsec-next-2023-10-28

----------------------------------------------------------------
Florian Westphal (4):
      xfrm: pass struct net to xfrm_decode_session wrappers
      xfrm: move mark and oif flowi decode into common code
      xfrm: policy: replace session decode with flow dissector
      xfrm: policy: fix layer 4 flowi decoding

Kees Cook (1):
      xfrm: Annotate struct xfrm_sec_ctx with __counted_by

Steffen Klassert (6):
      xfrm: Use the XFRM_GRO to indicate a GRO call on input
      xfrm: Support GRO for IPv4 ESP in UDP encapsulation
      xfrm: Support GRO for IPv6 ESP in UDP encapsulation
      Merge  branch 'xfrm: Support GRO decapsulation for ESP in UDP encapsulation'
      Merge branch 'xfrm: policy: replace session decode with flow dissector'
      xfrm Fix use after free in __xfrm6_udp_encap_rcv.

Yue Haibing (1):
      xfrm: Remove unused function declarations

 include/net/gro.h              |   2 +-
 include/net/ipv6_stubs.h       |   3 +
 include/net/xfrm.h             |  18 +--
 include/uapi/linux/xfrm.h      |   3 +-
 net/ipv4/esp4_offload.c        |   6 +-
 net/ipv4/icmp.c                |   2 +-
 net/ipv4/ip_vti.c              |   4 +-
 net/ipv4/netfilter.c           |   2 +-
 net/ipv4/udp.c                 |  16 +++
 net/ipv4/xfrm4_input.c         |  95 ++++++++++---
 net/ipv6/af_inet6.c            |   1 +
 net/ipv6/esp6_offload.c        |  10 +-
 net/ipv6/icmp.c                |   2 +-
 net/ipv6/ip6_vti.c             |   4 +-
 net/ipv6/netfilter.c           |   2 +-
 net/ipv6/xfrm6_input.c         | 103 +++++++++++---
 net/netfilter/nf_nat_proto.c   |   2 +-
 net/xfrm/xfrm_input.c          |   6 +-
 net/xfrm/xfrm_interface_core.c |   4 +-
 net/xfrm/xfrm_policy.c         | 299 +++++++++++++++++------------------------
 20 files changed, 343 insertions(+), 241 deletions(-)

