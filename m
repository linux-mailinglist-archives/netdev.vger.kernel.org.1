Return-Path: <netdev+bounces-251010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E72E2D3A230
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 09:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70CC93091B04
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 08:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE15350A0B;
	Mon, 19 Jan 2026 08:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="PzT8KBGU"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B32C33A008;
	Mon, 19 Jan 2026 08:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768812853; cv=none; b=X7wVSJ317pO470oekV5cvZpDTk5E10HfsC8WnOAFRyssgiqNX0XpD8EBSlgR8n9JbvVk5ENc27pgwVAEf8cKEkZbdQkDLdEPKUQCfoS2apyGZNzvCWREpm1Wc4R2Kix/3CknWQlfo66pAoRsfaPjg/8zybaNS/Nrwcbr/y3hejI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768812853; c=relaxed/simple;
	bh=Ypfc+DHD6mY5KWIxZRHAe5zQWyskIOdjser71cyK0nM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V3Si1tARTqLkuG/nbT7GViNduYz6UnYjY7Ds7zlCh3n6gLACVO/8Xk6lYXYxnj+FNndbwHzatSBpUo18/AYgIC8woFigoJRI1hJ9yYX5VjHsCUJeu/NRuUjNhkzJacF+P1y1qp3lAKRcx8n8IzqeW0NgMbyNM45ZCUBOML9ySFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=PzT8KBGU; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id AEE8E20612;
	Mon, 19 Jan 2026 09:54:09 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id icjksfnTVSHn; Mon, 19 Jan 2026 09:54:09 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 23625201C7;
	Mon, 19 Jan 2026 09:54:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 23625201C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1768812849;
	bh=y5ubgHe+X9PkKIMHQhLFafwz2XGbBESwGP/oYfX9lzk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=PzT8KBGU5Te8V9bSFyBI1adtdXBTead/8GvcLaKpjhmJ907riM5ElKNmwGfDFmGSd
	 pel9MXQJWPUwp6nl4SSDz9jAGDr2j9GGiejOF+vrElIKYSpFMdTjllPTKJV0GCZk+H
	 z0yc8rORIu1oc1Hha+Y9ab7dxvukE8I3sikWIrYRsk/C/YwVto+wa2yRNmMAf7uk+q
	 Osy/K56jMNG1TbGcn8vnWYFrJO+9TYWxCOn+4XU/E5u79d8+zpaIvj/ZN5fnYUTRVK
	 Of/BW6R/LtxpUnkrXhZjd5/vsLvFc82BkD/5y8zWs2lcut2n1oIT8bFK2PogkJ186H
	 ZbzBfzveBee+A==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 19 Jan
 2026 09:54:08 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Chiachang Wang <chiachangwang@google.com>, Yan Yan
	<evitayan@google.com>, <devel@linux-ipsec.org>, Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH ipsec-next v4 1/5] xfrm: add missing __rcu annotation to nlsk
Date: Mon, 19 Jan 2026 09:53:46 +0100
Message-ID: <17f0f145b89c8447fd3b8a988f26bec41a503b7f.1768811736.git.antony.antony@secunet.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1768811736.git.antony.antony@secunet.com>
References: <cover.1768811736.git.antony.antony@secunet.com>
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

The nlsk field in struct netns_xfrm is RCU-protected, as seen by
the use of rcu_assign_pointer() and RCU_INIT_POINTER() when updating
it.
However, the field lacks the __rcu annotation, and most read-side
accesses don't use rcu_dereference().

Add the missing __rcu annotation and convert all read-side accesses to
use rcu_dereference() for correctness and to silence sparse warnings.

Sparse warning reported by NIPA allmodconfig test when modifying
net/xfrm/xfrm_user.c. The warning is a pre-existing issue in
xfrm_nlmsg_multicast(). This series added a new call to this function
and NIPA testing reported a new warning was added by this series.

To reproduce (requires sparse):
make C=2 net/xfrm/
net/xfrm/xfrm_user.c:1574:29: error: incompatible types in comparison
expression (different address spaces):
net/xfrm/xfrm_user.c:1574:29:    struct sock [noderef] __rcu *
net/xfrm/xfrm_user.c:1574:29:    struct sock *

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 include/net/netns/xfrm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/netns/xfrm.h b/include/net/netns/xfrm.h
index 23dd647fe024..ed8eee81bbb0 100644
--- a/include/net/netns/xfrm.h
+++ b/include/net/netns/xfrm.h
@@ -59,7 +59,7 @@ struct netns_xfrm {
 	struct list_head	inexact_bins;


-	struct sock		*nlsk;
+	struct sock __rcu	*nlsk;
 	struct sock		*nlsk_stash;

 	u32			sysctl_aevent_etime;
--
2.39.5


