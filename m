Return-Path: <netdev+bounces-250022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C15ED22FFC
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 09:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D36BB3003F75
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 08:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A8230DED0;
	Thu, 15 Jan 2026 08:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="CHCefN0S"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B412D9EDB;
	Thu, 15 Jan 2026 08:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768464292; cv=none; b=kTPuNn6zicgHRSZKntSAqjPrkmt9l4dGcdrGDdYvYSMbe/GffV5GCaFv4ZegxJxNoEQftjoYDhjn3TGpU32JPfecHkvr6gWOJuO2xzy4DToFL2gvavvpXbX6+mMMUXbVKGFS/Y3Mx8wdfqgXX1/qqf34qnHS5uOLZgaOb74e1ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768464292; c=relaxed/simple;
	bh=SMiUv0It0QKvT53o6z3GMkElo25Zs1H6KUQxGFCgl4k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X+0cdywIV93uSHVdf2GLYwl3Gh305VFGOM1C03jzTWti0bsAVd+oO/V3NnfW98rPowUyyOzT+63B/Ve5YlqPRKoyZ+xXB3hHFg+fV1dL/QZ0wjnYh16QCzzIp4l39I3JFIcCkqSQfAAioWD7518I1n4u1tHLESSzGo55FfMsHEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=CHCefN0S; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id C1B66208B5;
	Thu, 15 Jan 2026 09:04:48 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0lGmbBLk0qEH; Thu, 15 Jan 2026 09:04:48 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 3F8602085F;
	Thu, 15 Jan 2026 09:04:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 3F8602085F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1768464288;
	bh=ndgkFJELUO50Ovj6Z3LJw10ms/SoqU6gJ2cf1zrPzbs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=CHCefN0Shqx+tVpc32aLkVMoCUPMMo4kDzFwm8wtMaUQCuKR9J2dkT84u9a1kvAtV
	 Tk8CqTRTA5EG/6rjddN6F83pedb3wdALpl+Vs7U6jl+Iwr+PvXAqW8knMVPi9l5aEi
	 CQukg7YNnR0xToUTYUmCdKYaQExs+1OQ1AmuFa9Xka+awLbtXrK8+J9kJDXD2SttkG
	 rbP0zD5+zqdE96ytTGt8+OXqSB0pfbNFGNziVaxMTq02zwQRlGoy2Z7J95XPDnbMed
	 3d3SrujxBsHZ2pq5iA+vHUiadGwZFTOtiDCa/lKZ1x9F2HFjfzHl/aZy91lqE/QtWq
	 9Pr80Du7kShDw==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 15 Jan
 2026 09:04:47 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Chiachang Wang <chiachangwang@google.com>, Yan Yan
	<evitayan@google.com>, Shinta Sugimoto <shinta.sugimoto@ericsson.com>,
	<devel@linux-ipsec.org>, Simon Horman <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH ipsec-next v2 1/4] xfrm: remove redundant assignments
Date: Thu, 15 Jan 2026 09:04:23 +0100
Message-ID: <c975b4b6573d712af9e0bf4fe04d58e7b6520133.1768462955.git.antony.antony@secunet.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1768462955.git.antony.antony@secunet.com>
References: <cover.1768462955.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-02.secunet.de
 (10.32.0.172)

This assignments are overwritten within the same function further down

commit e8961c50ee9cc ("xfrm: Refactor migration setup
during the cloning process")
x->props.family = m->new_family;

Which actually moved it in the
commit e03c3bba351f9 ("xfrm: Fix xfrm migrate issues
when address family changes")

And the initial
commit 80c9abaabf428 ("[XFRM]: Extension for dynamic
update of endpoint address(es)")

added x->props.saddr = orig->props.saddr; and
memcpy(&xc->props.saddr, &m->new_saddr, sizeof(xc->props.saddr));

Signed-off-by: Antony Antony <antony.antony@secunet.com>

---
v1->v2: remove extra saddr copy, previous line
---
 net/xfrm/xfrm_state.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 9e14e453b55c..4fd73a970a7a 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1980,8 +1980,6 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
 	x->props.mode = orig->props.mode;
 	x->props.replay_window = orig->props.replay_window;
 	x->props.reqid = orig->props.reqid;
-	x->props.family = orig->props.family;
-	x->props.saddr = orig->props.saddr;

 	if (orig->aalg) {
 		x->aalg = xfrm_algo_auth_clone(orig->aalg);
--
2.39.5


