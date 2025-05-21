Return-Path: <netdev+bounces-192156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30F7ABEB70
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 07:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1151C166BD3
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 05:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37269230BC0;
	Wed, 21 May 2025 05:43:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5C822FE06
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 05:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747806238; cv=none; b=T9faNIlVH9nnjpaJE6irhrxEDZtHpOUU1VGZpSVM9H0xfFmJbZ9AmjZjyLwLa4FGb1G1RfwCS7Pl21Hya1gNp2zcz++fjCI4d+bb0XyNIkLWVTqCYioXhNwEupFaZIj5uVQ+do0yTQQdKnpReunx0ujR2pjd5HC5JaQyyLFCA6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747806238; c=relaxed/simple;
	bh=ZR50hEIrAnsKkmKL1W80imyIhoEhz5GBYnZQledLfsc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RKfMk1RpPM+5U9HBH11aGV2SUTy/ESqowwuM/x3bMNvxaUTz0dS3ZQsh1wbwQLo6Qomp8X2sBv0n2WiQyLcpKft/G/yI7zYD63ad96aQ4gWmhfzSef6ERViHX7tCEuK2JbwVDAoQoW9b9inbHakM5VMgFFoR27mOim4wp3+9LMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 55C2E20826;
	Wed, 21 May 2025 07:43:53 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZXcCj5jS-EVx; Wed, 21 May 2025 07:43:52 +0200 (CEST)
Received: from EXCH-02.secunet.de (unknown [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 9B925207BE;
	Wed, 21 May 2025 07:43:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 9B925207BE
Received: from mbx-essen-02.secunet.de (10.53.40.198) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 21 May
 2025 07:43:52 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 07:43:51 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id C60423183065; Wed, 21 May 2025 07:43:50 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/5] pull request (net): ipsec 2025-05-21
Date: Wed, 21 May 2025 07:43:43 +0200
Message-ID: <20250521054348.4057269-1-steffen.klassert@secunet.com>
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

1) Fix some missing kfree_skb in the error paths of espintcp.
   From Sabrina Dubroca.

2) Fix a reference leak in espintcp.
   From Sabrina Dubroca.

3) Fix UDP GRO handling for ESPINUDP.
   From Tobias Brunner.

4) Fix ipcomp truesize computation on the receive path.
   From Sabrina Dubroca.

5) Sanitize marks before policy/state insertation.
   From Paul Chaignon.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit cfe82469a00f0c0983bf4652de3a2972637dfc56:

  ipv6: add exception routes to GC list in rt6_insert_exception (2025-04-10 20:09:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git tags/ipsec-2025-05-21

for you to fetch changes up to 0b91fda3a1f044141e1e615456ff62508c32b202:

  xfrm: Sanitize marks before insert (2025-05-14 07:18:58 +0200)

----------------------------------------------------------------
ipsec-2025-05-21

----------------------------------------------------------------
Paul Chaignon (1):
      xfrm: Sanitize marks before insert

Sabrina Dubroca (3):
      espintcp: fix skb leaks
      espintcp: remove encap socket caching to avoid reference leak
      xfrm: ipcomp: fix truesize computation on receive

Tobias Brunner (1):
      xfrm: Fix UDP GRO handling for some corner cases

 include/net/xfrm.h     |  1 -
 net/ipv4/esp4.c        | 53 +++++++-------------------------------------------
 net/ipv4/xfrm4_input.c | 18 +++++++++--------
 net/ipv6/esp6.c        | 53 +++++++-------------------------------------------
 net/ipv6/xfrm6_input.c | 18 +++++++++--------
 net/xfrm/espintcp.c    |  4 +++-
 net/xfrm/xfrm_ipcomp.c |  3 +--
 net/xfrm/xfrm_policy.c |  3 +++
 net/xfrm/xfrm_state.c  |  6 +++---
 9 files changed, 44 insertions(+), 115 deletions(-)

