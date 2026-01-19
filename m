Return-Path: <netdev+bounces-251011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E7FD3A225
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 09:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A64730086D0
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 08:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC8D3502AA;
	Mon, 19 Jan 2026 08:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="ynO91ZaH"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7203D2A1CF;
	Mon, 19 Jan 2026 08:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768812873; cv=none; b=MjEPzK3xPlcZJ6i4l7clocFNgNywvqKFLBEOp35P6XRcEeGuedcp2tl+nc9UDYV39uE4wSrElN0cPiztPlFKVL6JLM2hGvYBCtbnn//8ZR0GtSCnyhgLxVx6OyBwq2vF3JzMmkTRK+A+ohjBbxNunMvnLlqIMkBDvL2k8tQh9Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768812873; c=relaxed/simple;
	bh=McBfmnnEkA+VZYmqzhNi4kRUbW9eYfFWPDIlaRVdc2A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tTFPLdm5doTs4yaClW258tldZh3eJGshwoTh2vd5uSxlzynlzk/gMjj1uWZvZxPyqlA8s0pz3wu5hIJlqd2fYLtBIOQpdC5ds2hd3mQoCSXBc5p0rQRP8NQSHwIkbC0tCcJtmXbKF14PmPjHJTEzZtn69iDnGTS5FGf575wHvj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=ynO91ZaH; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id B21E02074B;
	Mon, 19 Jan 2026 09:54:29 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oXTVLUwhd0DD; Mon, 19 Jan 2026 09:54:29 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 96B7A207BE;
	Mon, 19 Jan 2026 09:54:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 96B7A207BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1768812868;
	bh=5BQ439mslfuweEeq26rQ7YLVOhzXbgR+eNZ0ziniS8Q=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=ynO91ZaHWpNkzwo+KtJetZdEubVG/KQbbk7xxcIxnW0Xp+beQyeDkDKouZY20Lajw
	 l/TjRFUIRkj88r8fTr5wcSwkXdl2lTc8cnK3Ag1JEEpFFpED/L932aqFU0LmQ5nhMm
	 eVLWjrI8otXebM4AcNITQdvN4FJEiB78hnEG4vJ5edJiHr5uugZEaMwipTJEC9UmHO
	 /t1YJFIDVbiD+Ix4bImIWxUPXFVnNsZf4YKbP7nufMLQpyb9Uh2cQnmireuKIIhGb8
	 inMzfKea7yD22PB6JksKOXqm7tUZly3VCB1tFojUNtopcN7fTz75jbOa98EfGCfcws
	 p4u1GBYDihScg==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 19 Jan
 2026 09:54:27 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Chiachang Wang <chiachangwang@google.com>, Yan Yan
	<evitayan@google.com>, <devel@linux-ipsec.org>, Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH ipsec-next v4 2/5] xfrm: remove redundant assignments
Date: Mon, 19 Jan 2026 09:54:08 +0100
Message-ID: <564f0e34f10b89448988cdf3ed933987707d268a.1768811736.git.antony.antony@secunet.com>
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
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-02.secunet.de
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


