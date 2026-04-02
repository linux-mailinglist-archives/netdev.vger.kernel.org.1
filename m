Return-Path: <netdev+bounces-274497-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEA9EnFZzmkxnAYAu9opvQ
	(envelope-from <netdev+bounces-274497-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:56:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D36E388A67
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33B88301BCD4
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 11:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FF0196C7C;
	Thu,  2 Apr 2026 11:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="KHAgDBas"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6003AD538
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 11:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775129527; cv=none; b=dmoGJxrrDTHVZMVBDWxKpNrUcfzI0QKhUZYsJ/pHBQDWsV8WcawLrOUMHFI6ylB6fle3goil/ZP6rGza6tmTmYrVXG5ZIoEBqxojU3DU9k/qDIU6KnKkT+nS6kG+BMwdSYrFDYUpJDs7Qgm3DWIj+zpede37WSsopS/GHKMs/xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775129527; c=relaxed/simple;
	bh=muLRHVKKCxa7THcGz+9Z64cjD57wbeN8h5gvpYkbALc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfdAs4s0+vcuTIcvBFRjwpXm8Meur0s7aktZlt22k9dhmkzvsugJRUtc+sH7+FZ8iHq02JFseJLJPinDgvbqPPSWD/z974FsWSa7P0H7oEuKZ6sEEw8+UXiJwbl1Pqc79baEYIwrrJfEjTwbk+NdMHXTokkPEIv/S8qNKRqr7Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=KHAgDBas; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id A61532088A;
	Thu,  2 Apr 2026 13:31:53 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pQWdtPZSa-DA; Thu,  2 Apr 2026 13:31:53 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 254D5205DD;
	Thu,  2 Apr 2026 13:31:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 254D5205DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1775129513;
	bh=RFAEwZW1ULGjo1FzYux4gg5LXrejoNZAV0wTbiHEnKQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=KHAgDBas/S8wG3b9YerVJeYGm5RlsjmWtEUeLnZu3/PoHelvbLzF69dHoisCSJECD
	 8KRYtLZ2H/0t2T3AwXgSnsE28a+pCGBNrF2AddcMnJ7I706jMmVLPeWauB1tbtTi3L
	 g8dFZ/hEQPkl2xbGEEypPYXFmLSMpc0fcKgPDXSThaT9vp51JVlRuK2J1lp9fucl5w
	 T4ynfJ7ZRRtO6ufwq23hzkFnx8QtzAGmOvyYymF2QEZEDaKtLK4jEfkt+2hZKYYODk
	 FGwr1XJBNCfHBNuk8R4ise9Dd0O9dHy6zK4r/xKibLYiHShzvR9/s/m7x7tFVDlnk2
	 8k4QB61EorWlg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 13:31:52 +0200
Received: (nullmailer pid 3788822 invoked by uid 1000);
	Thu, 02 Apr 2026 11:31:52 -0000
Date: Thu, 2 Apr 2026 13:31:52 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: <netdev@vger.kernel.org>
CC: Florian Westphal <fw@strlen.de>
Subject: [PATCH ipsec 2/2] xfrm: Wait for RCU readers during state netns exit
Message-ID: <ac5TqJaXXg66dqBy@secunet.com>
References: <ac5TePdKtegtWiRG@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ac5TePdKtegtWiRG@secunet.com>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_FROM(0.00)[bounces-274497-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[secunet.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9D36E388A67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

xfrm_state_fini() flushes the resize and GC work, destroys all states, and
then frees the state hash tables and the inbound percpu state cache.
Those objects can still be observed by concurrent RCU readers. We need
to wait for a RCU grace period before freeing the hash tables and the
percpu cache to avoid netns teardown racing with lockless lookups.

Fix this by adding synchronize_rcu() before freeing the state hash
tables and the inbound percpu state cache.

Fixes: c8406998b801 ("xfrm: state: use rcu_deref and assign_pointer helpers")
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_state.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 1748d374abca..84fbf1591138 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -3327,6 +3327,8 @@ void xfrm_state_fini(struct net *net)
 	xfrm_state_flush(net, 0, false);
 	flush_work(&xfrm_state_gc_work);
 
+	synchronize_rcu();
+
 	WARN_ON(!list_empty(&net->xfrm.state_all));
 
 	for (i = 0; i <= net->xfrm.state_hmask; i++) {
-- 
2.43.0


