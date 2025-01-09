Return-Path: <netdev+bounces-156585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 445E3A071C3
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 10:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3986F167A3F
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 09:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F00215762;
	Thu,  9 Jan 2025 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="VhUL7sxF"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB6D2153E1
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736415815; cv=none; b=FnR8vEKgvJTbZst5txya7ElY92nf5ArUUdQBlr9kv9U5Tv4jK4pFpmAHztOTFerA8sKRpv/rtLsJe97BDUw+oj1ENXWkMjvYH3ryV0ipQLyaXuwntV6f5ukL2QK/zXIve7WHXjNtEoOlgV377QyiJPDoX6u7N+JFvVwSXAbXKYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736415815; c=relaxed/simple;
	bh=SQFx5RO8oDpxCWSeNuBxDWyJoI5D+2S4X6Ecnnu7Z1g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gGXahF1XZd3fRN80/+MvXPUI0anUBH5BG9rL0zq7EjQH0qILjxAEZSS5VttonMqkAQOZNpHsghVLDpYLSgsSFqeq2uhs4WSJtd7cPejeSomrPLPLfGJyUhdtcoTy+vBAwTRfnnGUuvRuXGT5AAF5RDuJXAw7uMf4AdrR9NDTktg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=VhUL7sxF; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 6800F20872;
	Thu,  9 Jan 2025 10:43:31 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q4ZIagLLNvDV; Thu,  9 Jan 2025 10:43:30 +0100 (CET)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 8DF302087C;
	Thu,  9 Jan 2025 10:43:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 8DF302087C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1736415810;
	bh=xpqVED1b2AHIY5gnTbxMSNUl2WJ2S3ZRrbWUd5PhgJM=;
	h=From:To:CC:Subject:Date:From;
	b=VhUL7sxFarcTbqde09QuhDfQjNlE/FbypTkemwS5jrQnN/aYtSCZUHZWwECZ7Wq5C
	 GFe6J2In8ixKsTfL3b5VLifG/jb7IFCF3HLdm0tRGs68CRe1zrbUaaygyvvaQAs+uE
	 D58em9GWNWsc69tfHZtc9N5lRWHRGK9OEWDk09U4QBpJx4j5iasF/tBm1/AVykeka8
	 dEPskqC/VKPRHH5kNfwS90ReHx89EqdR9bOa2fmpFaIJd/3lRCrCVIz5TvooaMaE0s
	 6AttWw7TD/oX0PCc7lNBucBE5yXPRJEyBIwwfYk3NWbrUBGi3GTeirkJv3uc1GTu9H
	 nlAA2vJ5XdG6g==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 9 Jan 2025 10:43:30 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 9 Jan
 2025 10:43:29 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 7CBAF3182AFD; Thu,  9 Jan 2025 10:43:29 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/17] pull request (net-next): ipsec-next 2025-01-09
Date: Thu, 9 Jan 2025 10:43:04 +0100
Message-ID: <20250109094321.2268124-1-steffen.klassert@secunet.com>
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

1) Implement the AGGFRAG protocol and basic IP-TFS (RFC9347) functionality.
   From Christian Hopps.

2) Support ESN context update to hardware for TX.
   From Jianbo Liu.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit 152d00a913969514967ad3f962b3b1c8983eb2d7:

  r8169: simplify setting hwmon attribute visibility (2024-12-04 19:44:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git tags/ipsec-next-2025-01-09

for you to fetch changes up to 7082a6dc84ebba9dbdf65727b5bc4af92a2d31d3:

  net/mlx5e: Update TX ESN context for IPSec hardware offload (2025-01-07 13:12:11 +0100)

----------------------------------------------------------------
ipsec-next-2025-01-09

----------------------------------------------------------------
Christian Hopps (15):
      xfrm: config: add CONFIG_XFRM_IPTFS
      include: uapi: protocol number and packet structs for AGGFRAG in ESP
      xfrm: netlink: add config (netlink) options
      xfrm: add mode_cbs module functionality
      xfrm: add generic iptfs defines and functionality
      xfrm: iptfs: add new iptfs xfrm mode impl
      xfrm: iptfs: add user packet (tunnel ingress) handling
      xfrm: iptfs: share page fragments of inner packets
      xfrm: iptfs: add fragmenting of larger than MTU user packets
      xfrm: iptfs: add basic receive packet (tunnel egress) handling
      xfrm: iptfs: handle received fragmented inner packets
      xfrm: iptfs: add reusing received skb for the tunnel egress packet
      xfrm: iptfs: add skb-fragment sharing code
      xfrm: iptfs: handle reordering of received packets
      xfrm: iptfs: add tracepoint functionality

Jianbo Liu (2):
      xfrm: Support ESN context update to hardware for TX
      net/mlx5e: Update TX ESN context for IPSec hardware offload

Steffen Klassert (1):
      Merge branch 'Add IP-TFS mode to xfrm'

 Documentation/networking/xfrm_device.rst           |    3 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    |    3 +
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   |   37 +-
 include/net/xfrm.h                                 |   44 +
 include/uapi/linux/in.h                            |    2 +
 include/uapi/linux/ip.h                            |   16 +
 include/uapi/linux/ipsec.h                         |    3 +-
 include/uapi/linux/snmp.h                          |    2 +
 include/uapi/linux/xfrm.h                          |    9 +-
 net/ipv4/esp4.c                                    |    3 +-
 net/ipv6/esp6.c                                    |    3 +-
 net/netfilter/nft_xfrm.c                           |    3 +-
 net/xfrm/Kconfig                                   |   16 +
 net/xfrm/Makefile                                  |    1 +
 net/xfrm/trace_iptfs.h                             |  218 ++
 net/xfrm/xfrm_compat.c                             |   10 +-
 net/xfrm/xfrm_device.c                             |    4 +-
 net/xfrm/xfrm_input.c                              |   18 +-
 net/xfrm/xfrm_iptfs.c                              | 2764 ++++++++++++++++++++
 net/xfrm/xfrm_output.c                             |    6 +
 net/xfrm/xfrm_policy.c                             |   26 +-
 net/xfrm/xfrm_proc.c                               |    2 +
 net/xfrm/xfrm_replay.c                             |    1 +
 net/xfrm/xfrm_state.c                              |   84 +
 net/xfrm/xfrm_user.c                               |   77 +
 25 files changed, 3313 insertions(+), 42 deletions(-)
 create mode 100644 net/xfrm/trace_iptfs.h
 create mode 100644 net/xfrm/xfrm_iptfs.c

