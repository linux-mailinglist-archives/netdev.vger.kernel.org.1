Return-Path: <netdev+bounces-145205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 311D19CDAA1
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 09:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC4011F24E40
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 08:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91C118FC70;
	Fri, 15 Nov 2024 08:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="fjHX67aq"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BCD18E368
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 08:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731659641; cv=none; b=PofL+YwPVxYeesdlp2zEN7OAjdNlKqkvUs4JMMtmCYtiSVb6vnbQy/f5NAttAxMaD9eYTu9WEpeoTeCvILz4ps2di1bbtDZjra/KnlzQMuhNzaznedf6U9ml/Al5+pRpQt6mUN49DFGMkhvj1KDdnEaV91/89ACg9AdwHcm80g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731659641; c=relaxed/simple;
	bh=cMO4s2CD7WS0RD7gezJQq/ygtOxgg1wHzjjMOODTFAg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VcFc9sSno+Yg08PT7qtvd82X/2X6xuLbKub/52yl6bnUL4QeNTgxqTEx4oj0CkcYYilrsPDPa+vHHNh6Iyo4JTzpy4RDUYBPl4GnoxG7984ZvaaBuUXaUocXbZ0G6RvCgsLAJ6g/EP6NB8HgNu63YP8/4T+e59sWaUz2lxSDdVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=fjHX67aq; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 99FA3201A1;
	Fri, 15 Nov 2024 09:33:56 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z6mszzmL-kTt; Fri, 15 Nov 2024 09:33:56 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id A13AC2084E;
	Fri, 15 Nov 2024 09:33:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com A13AC2084E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1731659634;
	bh=CWKApZvLSNozRi8LgYkjH7u/zRl46NNup8qzegF/MAc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=fjHX67aqteVCuG87mESe0wIMwDXJTN60sC+U/r+ifYC2CcVTtNo9H7pLyyGJ1eR/o
	 ObdAt9Xz93hAc0GQMJJ3axjuAL+Ll6UHifmhxLVP/bGnKNIxkkRzsErgBLjYSX1N1E
	 mdWJBZvTmlorVwMNAz6d3RSQvU/pEuMegXVaQORBklExj137nV4zbpT9Xgth5OMVAX
	 iGoI+TE/g35urJsWosnAyityEvSFXMOkU9Q3nEHSPbPnrZAb84ynP0BN1uxMOQ1Gy3
	 8enWiZenpMXiR4CzsBDNhDhQKscQUw3oVh/JDzEkBMmrVvH/R5m+dzbZoQUVP2dKI+
	 iuL6DLPVrBBSQ==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 15 Nov 2024 09:33:54 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 09:33:53 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id C756F3184487; Fri, 15 Nov 2024 09:33:52 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 08/11] xfrm: Convert struct xfrm_dst_lookup_params -> tos to dscp_t.
Date: Fri, 15 Nov 2024 09:33:40 +0100
Message-ID: <20241115083343.2340827-9-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115083343.2340827-1-steffen.klassert@secunet.com>
References: <20241115083343.2340827-1-steffen.klassert@secunet.com>
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

From: Guillaume Nault <gnault@redhat.com>

Add type annotation to the "tos" field of struct xfrm_dst_lookup_params,
to ensure that the ECN bits aren't mistakenly taken into account when
doing route lookups. Rename that field (tos -> dscp) to make that
change explicit.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 include/net/xfrm.h      | 3 ++-
 net/ipv4/xfrm4_policy.c | 3 ++-
 net/xfrm/xfrm_policy.c  | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 2b87999bd5aa..32c09e85a64c 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -19,6 +19,7 @@
 
 #include <net/sock.h>
 #include <net/dst.h>
+#include <net/inet_dscp.h>
 #include <net/ip.h>
 #include <net/route.h>
 #include <net/ipv6.h>
@@ -354,7 +355,7 @@ void xfrm_if_unregister_cb(void);
 
 struct xfrm_dst_lookup_params {
 	struct net *net;
-	int tos;
+	dscp_t dscp;
 	int oif;
 	xfrm_address_t *saddr;
 	xfrm_address_t *daddr;
diff --git a/net/ipv4/xfrm4_policy.c b/net/ipv4/xfrm4_policy.c
index 7e1c2faed1ff..7fb6205619e7 100644
--- a/net/ipv4/xfrm4_policy.c
+++ b/net/ipv4/xfrm4_policy.c
@@ -14,6 +14,7 @@
 #include <linux/inetdevice.h>
 #include <net/dst.h>
 #include <net/xfrm.h>
+#include <net/inet_dscp.h>
 #include <net/ip.h>
 #include <net/l3mdev.h>
 
@@ -24,7 +25,7 @@ static struct dst_entry *__xfrm4_dst_lookup(struct flowi4 *fl4,
 
 	memset(fl4, 0, sizeof(*fl4));
 	fl4->daddr = params->daddr->a4;
-	fl4->flowi4_tos = params->tos;
+	fl4->flowi4_tos = inet_dscp_to_dsfield(params->dscp);
 	fl4->flowi4_l3mdev = l3mdev_master_ifindex_by_index(params->net,
 							    params->oif);
 	fl4->flowi4_mark = params->mark;
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 7e3e10fb9ca0..4408c11c0835 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -312,7 +312,7 @@ static inline struct dst_entry *xfrm_dst_lookup(struct xfrm_state *x,
 	params.net = net;
 	params.saddr = saddr;
 	params.daddr = daddr;
-	params.tos = inet_dscp_to_dsfield(dscp);
+	params.dscp = dscp;
 	params.oif = oif;
 	params.mark = mark;
 	params.ipproto = x->id.proto;
-- 
2.34.1


