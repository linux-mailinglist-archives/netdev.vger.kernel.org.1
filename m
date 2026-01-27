Return-Path: <netdev+bounces-253803-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MB9UJZqWeGnmrAEAu9opvQ
	(envelope-from <netdev+bounces-253803-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 11:42:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F2392FA7
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 11:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 311A830041E5
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 10:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4AC3431E3;
	Tue, 27 Jan 2026 10:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="0GRb/Cvq"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903B1344036;
	Tue, 27 Jan 2026 10:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769510551; cv=none; b=HtYuDZwNQlQY3FdOQKHVnQH7aPEWsC2CDribEtIDB+XEAePHruSvYKLY/RJWAh97QB/G481zscZ2iEV5fNvs3CajOCY3DP6TYd2iKtic/frmtDhiWDo0tkpq7hwREVzC9WlZKFmy+3+G+IRpIYIH2mCJ2lEZnMV+/s7QAatqYK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769510551; c=relaxed/simple;
	bh=Y3UUNaU3Fue3USygMdt+ESWBFocqEj0mJcLF+FJd+DE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iheoI9VumNFmY6VoqfeBV9KWWWcD6Ho8aOLWgNcBVXAqulfTnM5dQdoVrxjnOmfSj4kc7TzZD1aclWC7ynBPx3IcpaFrMlO7VtYdED3cn9NVkTJoutiR2WUKodC8hQA0RJW3IU0IGW7r6Re/t6H1g6Xip2pN0MTBL7tPkGg7vIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=0GRb/Cvq; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id AD0DE200AC;
	Tue, 27 Jan 2026 11:42:23 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eEMX2gdmEEeh; Tue, 27 Jan 2026 11:42:23 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id F20A62006C;
	Tue, 27 Jan 2026 11:42:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com F20A62006C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1769510543;
	bh=8f3zjACTFNAde3SBMeXL7CRmkIHL60J2ki/tBhZ4sh0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=0GRb/CvqjHS3ZFZV6ik3e8/XXeD+phT9x1l2eJ0r0YX0w2MTwBbexMwS7XlfmHuPg
	 3D4V2imlakqvHUqYMesOYQHteFcFIfj7zc0dTHOqr8x+LNf9j9HdXUFQtPodsV++k0
	 bk/5vD4XuJjG2RkXdKptBRthkNKDBQpxIof/XNbxmxJWDKe8NPVMJ6x49p8Ct0esz0
	 6+tBpxzxxbkRl6P4EwDhJeSb39DyciXufQ3nYzvpDv9z0t/H3HgvdYgxkgy9Yc1HT9
	 BQnsvhDEcCIR9apDFZ30js9hjRyR5IvTaxPXAgY56K0ReyeyU4H/Gh25N7W4Ck3gqB
	 5r/srr0u35PGQ==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 11:42:21 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Chiachang Wang <chiachangwang@google.com>, Yan Yan
	<evitayan@google.com>, <devel@linux-ipsec.org>, Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH ipsec-next v5 1/8] xfrm: add missing __rcu annotation to nlsk
Date: Tue, 27 Jan 2026 11:42:01 +0100
Message-ID: <9e8623132cb8001bce5bdf97e0c4591101b6dff9.1769509131.git.antony.antony@secunet.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1769509130.git.antony.antony@secunet.com>
References: <cover.1769509130.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-02.secunet.de
 (10.32.0.172)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-253803-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antony.antony@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 37F2392FA7
X-Rspamd-Action: no action

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
v3->v4: added this patch
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


