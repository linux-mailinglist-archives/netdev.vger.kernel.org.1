Return-Path: <netdev+bounces-276402-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMmxOjIj1mklBQgAu9opvQ
	(envelope-from <netdev+bounces-276402-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 11:43:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C673BA096
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 11:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 066DA3008337
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 09:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D190F3ACEF8;
	Wed,  8 Apr 2026 09:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="cY2pI/p6"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503603ACA64
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 09:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775641391; cv=none; b=gRlWMh+HSVTcVVzB1lK2ncmNU8iV6m1BRFRXV2NFH8+pqh8q5nYQkWDOsF3AJvl3KWYgL4F8mHqhrK04O0MuZSxJwF7uluiY2rD0j/Q5iSvyDbriiBvLuuQ1PsaLVIn5+hXivOziybeESml3zHY+bmEqIkiyeHsAjsGAFbzbtbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775641391; c=relaxed/simple;
	bh=m9Oo2arh0z6aXQFY+uLJpmLg1Pj1JP9yLKoNs1IT+UE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uksEfcEJvT8rNMv4BW2l/S43tHFjvcJ5pSdGMgkQWu8B50FTTvBg/yn+1NloRTu1AmQkkHRooDFgBsfC03cxTuw2vVm4WZ3X8JT+xNj+XXcivvx1ZnXjDuYF70lTfdRoMSloeLMx91NnT9lf6jCPpPWSWanFqGqg9f+/NPxoh5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=cY2pI/p6; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 066B4207B3;
	Wed,  8 Apr 2026 11:43:06 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5MlJ_nIEBAeJ; Wed,  8 Apr 2026 11:43:05 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 76EA2207C6;
	Wed,  8 Apr 2026 11:43:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 76EA2207C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1775641385;
	bh=7lHMzGTmvAk3JyW86PDPZggmH+wRhYSy+Nw4BJRjtg4=;
	h=From:To:CC:Subject:Date:From;
	b=cY2pI/p6SAtSWpjDALSgb3El9UQEnXW/nVaDyynO4DlnFiRiTh4FT0/zVXB9o8Wbw
	 PdZh8lR0dXV04yMm18lUBhYRLXIaG73OjhD5xg4MfsnvKLUkSI05nrMpMhPH9KSovG
	 utiBE+4cqIQ0bMTNi9rjmaBBe0NjDsLddZo9SlDijbN2Q/3DqTf2yaqj+z+kdozuGW
	 KGG7TtP/RFUpoTPrscKbx17Jawr8SUeaL8aYT695lxAHdF5rs2khkojejZUv4tcLkY
	 m+5gvzGnfAbudWccbls6ySdDYHbR0QWLeC86iy/y8khV5vBPkQAI1+K5aI5fXT/4ZN
	 A3so6F36kxhug==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Apr
 2026 11:43:04 +0200
Received: (nullmailer pid 150862 invoked by uid 1000);
	Wed, 08 Apr 2026 09:43:03 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/2] pull request (net-next): ipsec-next 2026-04-08
Date: Wed, 8 Apr 2026 11:42:39 +0200
Message-ID: <20260408094258.148555-1-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-276402-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:dkim,secunet.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 94C673BA096
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

1) Update outdated comment in xfrm_dst_check().
   From kexinsun.

2) Drop support for HMAC-RIPEMD-160 from IPsec.
   From Eric Biggers.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit d2adf01780b8957b31f4954d56646b02de956f65:

  net: freescale: ucc_geth: call of_node_put once (2026-02-24 18:26:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git tags/ipsec-next-2026-04-08

for you to fetch changes up to 05d42dc8ab92aa54aaeb1c033927c88fd2accba4:

  xfrm: Drop support for HMAC-RIPEMD-160 (2026-04-07 10:47:58 +0200)

----------------------------------------------------------------
ipsec-next-2026-04-08

----------------------------------------------------------------
Eric Biggers (1):
      xfrm: Drop support for HMAC-RIPEMD-160

kexinsun (1):
      xfrm: update outdated comment

 net/xfrm/xfrm_algo.c                | 20 --------------------
 net/xfrm/xfrm_policy.c              |  2 +-
 tools/testing/selftests/net/ipsec.c |  8 ++------
 3 files changed, 3 insertions(+), 27 deletions(-)

