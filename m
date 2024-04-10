Return-Path: <netdev+bounces-86681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5D789FE7B
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 19:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFFB01F24CAC
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 17:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1D517BB15;
	Wed, 10 Apr 2024 17:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="GTuDnIAE"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAF217BB03
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712770052; cv=none; b=oNBCd4xQuwnx5tuFUy2a86PMojeeWcjLSkNBpNLFTVmTUa7kzdVGNgNFtKAl3/JN0ygb3TvSN7OQd7ly+mBGb6g+q1T1+HBG+6wQLTK5rsUUPqQWy5w73Xw09fztri3QAprhIdGB08j8vgCyoVTQi4wEL78guRbg6OOcMMl8URY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712770052; c=relaxed/simple;
	bh=LQeLBP/ohImQzFc7hOuOG6d8q9mxIpKrU/Teh2L9wwM=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JOMrW67gNXqBj6YfW4oayRZkswnRL6vqJpBgfr9dU1LEneTm4SB+JU0VuWPb+VotboGmdC//Q2bP7eHcnLv612UcN5i0nP/m+lY5shR6JEdKf39FxQAUemE3N737P+yYkQBcHt8+1155C6eoAY07d+KC7AHKBZKCn0kx4EAzcgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=GTuDnIAE; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 6641B2085B;
	Wed, 10 Apr 2024 19:27:22 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9ZXVTniMsG26; Wed, 10 Apr 2024 19:27:18 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 9E750207D8;
	Wed, 10 Apr 2024 19:27:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 9E750207D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1712770038;
	bh=2YWdqZ0w7nu27e0x5lo11Z0ZgCAjwFTLE/UiffT4vkY=;
	h=Date:From:To:CC:Subject:Reply-To:From;
	b=GTuDnIAELPox6BzPwjPV6I7U3qcvAvTf3SgUOmQYznxXkE9RuqcUJ7FjKsimf6/IR
	 JSyxvSJw9HV8+DPHqExlQ57og5zR+NE101vWEjMiWXabKSc7bWScl4vyKAUdU7wpeu
	 BV6fT/G/zBqpmpqyovVJpkVHWinrkavyil79/lZHFhCZiQaWT79hcoQmlbbj6LXRCZ
	 BTPSurva9bRFRMzKOUaQLntiCLxlj5ZGjKwx9N5QlwtgFMnAsPc66RWViGMb3EyskK
	 BPqu48/EQSB3M1Ey/hVQvBLUc9fuPbMLuHvPtCSJZLFmXbmC/6bttEEp9Fhj9DUdZi
	 xdOF4Mg4/tbyg==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 8FD6E80004A;
	Wed, 10 Apr 2024 19:27:18 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 19:27:18 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 10 Apr
 2024 19:27:17 +0200
Date: Wed, 10 Apr 2024 19:27:12 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, <netdev@vger.kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Antony Antony <antony.antony@secunet.com>, Dan Carpenter
	<dan.carpenter@linaro.org>
Subject: [PATCH ipsec] xfrm: fix possible derferencing in error path
Message-ID: <2a5c46f3ae893a13a9da7176b3d67f3439d9ce1c.1712769898.git.antony.antony@secunet.com>
Reply-To: <antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)

Fix derferencing pointer when xfrm_policy_lookup_bytype returns an
 error.

Fixes: 63b21caba17e ("xfrm: introduce forwarding of ICMP Error messages")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/kernel-janitors/f6ef0d0d-96de-4e01-9dc3-c1b3a6338653@moroto.mountain/
Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 net/xfrm/xfrm_policy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 6affe5cd85d8..53d8fabfa685 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3593,6 +3593,8 @@ xfrm_policy *xfrm_in_fwd_icmp(struct sk_buff *skb,
 			return pol;

 		pol = xfrm_policy_lookup(net, &fl1, family, XFRM_POLICY_FWD, if_id);
+		if (IS_ERR(pol))
+			pol = NULL;
 	}

 	return pol;
--
2.30.2


