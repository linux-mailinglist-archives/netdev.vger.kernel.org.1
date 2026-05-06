Return-Path: <netdev+bounces-284937-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKh9CeJn+2llawMAu9opvQ
	(envelope-from <netdev+bounces-284937-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 18:10:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A7C4DDE42
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 18:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A1D130056D8
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 16:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4304963C3;
	Wed,  6 May 2026 16:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="aMeirNFJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15AF3F9F54
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 16:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778083751; cv=none; b=n5u6yBPytIfaDHjq4SAlnzo33QsJfL1UCzxbSBrTs+gUcvhNF8sTfvKqyX9ve/8P7jSNTJcxMj0JA5KXAa6R0luZc8srrzNwK/iIgjhFvuvC9AahZLED6f2kbnOGY3XIxJ5g5y8yOwWFq0/5TnG4fHnNfKepOipwefsRu/wuAu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778083751; c=relaxed/simple;
	bh=Qj3i0T7WbEbYsNt9YLxaFT/5dBJe0XNSH9MRZxq2rRg=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iYcqrayImNc6L6duD3oL6N7xM6sWM5FI5HVY9Ulb02CvY+V9r81YGXQP4bNbj4U3UPI/0Udo+Cl3xvVDrLzp0U7M/kjGa9tYun/ik41uewZGJhgranzs41f4zbYD6L5bAV1wFjZFijvbF/lqRF7vdpO+nIbnmsGV+vWLx2l6hWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=aMeirNFJ; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id AFF1920523;
	Wed,  6 May 2026 18:08:57 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mA0LYFOcnd-U; Wed,  6 May 2026 18:08:57 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 1392620764;
	Wed,  6 May 2026 18:08:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 1392620764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1778083737;
	bh=lVPz713VN2Pws4Zi8u05ryA7Kt5Ew6TrOcqoDFSP0b0=;
	h=Date:From:To:CC:Subject:From;
	b=aMeirNFJJIC2no6pfIZjWEQ3NLOGSSbFVxpjG3kR9rmTZfDAu4qJdMrO3cNfZU3MH
	 nhGqaEQN5eUvVsIp55/g6usBAjevfWuY7C7bi3uaLvxkLN6XNc5zizefYCTlDr1Ygc
	 6dEUjRhfS7glZwbXxOoJ2RodZ/Sau7VFcbRvMshel0rpmLAchmJRMW1rv/+oydAeMF
	 13wdAElxyQCGUZ2JbAnVRaVxjfJdEQg9cRqH4n4ZC7j3a6/7dRt8UucXUXdCs/V1xL
	 u9gnor3zghpvN/A2HMZM3+vL7MbUnR+02OIzVb2qzOUcUHBx8iNctTf7IDed8e9ZYo
	 Lvsu9VJ99vpXA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 6 May
 2026 18:08:56 +0200
Received: (nullmailer pid 549738 invoked by uid 1000);
	Wed, 06 May 2026 16:08:55 -0000
Date: Wed, 6 May 2026 18:08:55 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: <netdev@vger.kernel.org>
CC: <devel@linux-ipsec.org>
Subject: [PATCH ipsec-next] xfrm: Use regular error handling instead of
 BUG_ON() in the netlink API.
Message-ID: <aftnl6d59WUM_Dfm@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Queue-Id: 79A7C4DDE42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-284937-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,secunet.com:email,secunet.com:dkim,secunet.com:mid];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]

The xfrm netlink API uses BUG_ON() on failures since it exists.
However all these error are uncritical and can be handled
with regular error handling. This fixes machine crashes
in situations where an emergency break is not needed.

Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_user.c | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index d56450f61669..b24a0f9e91d5 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1734,7 +1734,10 @@ static int xfrm_get_spdinfo(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return -ENOMEM;
 
 	err = build_spdinfo(r_skb, net, sportid, seq, *flags);
-	BUG_ON(err < 0);
+	if (err < 0) {
+		kfree_skb(r_skb);
+		return err;
+	}
 
 	return nlmsg_unicast(xfrm_net_nlsk(net, skb), r_skb, sportid);
 }
@@ -1794,7 +1797,11 @@ static int xfrm_get_sadinfo(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return -ENOMEM;
 
 	err = build_sadinfo(r_skb, net, sportid, seq, *flags);
-	BUG_ON(err < 0);
+	if (err < 0) {
+		kfree_skb(r_skb);
+		return err;
+	}
+
 
 	return nlmsg_unicast(xfrm_net_nlsk(net, skb), r_skb, sportid);
 }
@@ -3285,7 +3292,10 @@ static int xfrm_send_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 
 	/* build migrate */
 	err = build_migrate(skb, m, num_migrate, k, sel, encap, dir, type);
-	BUG_ON(err < 0);
+	if (err < 0) {
+		kfree_skb(skb);
+		return err;
+	}
 
 	return xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_MIGRATE);
 }
@@ -3623,7 +3633,10 @@ static int xfrm_aevent_state_notify(struct xfrm_state *x, const struct km_event
 		return -ENOMEM;
 
 	err = build_aevent(skb, x, c);
-	BUG_ON(err < 0);
+	if (err < 0) {
+		kfree_skb(skb);
+		return err;
+	}
 
 	return xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_AEVENTS);
 }
@@ -3862,7 +3875,10 @@ static int xfrm_send_acquire(struct xfrm_state *x, struct xfrm_tmpl *xt,
 		return -ENOMEM;
 
 	err = build_acquire(skb, x, xt, xp);
-	BUG_ON(err < 0);
+	if (err < 0) {
+		kfree_skb(skb);
+		return err;
+	}
 
 	return xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_ACQUIRE);
 }
@@ -3984,7 +4000,10 @@ static int xfrm_exp_policy_notify(struct xfrm_policy *xp, int dir, const struct
 		return -ENOMEM;
 
 	err = build_polexpire(skb, xp, dir, c);
-	BUG_ON(err < 0);
+	if (err < 0) {
+		kfree_skb(skb);
+		return err;
+	}
 
 	return xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_EXPIRE);
 }
@@ -4151,7 +4170,8 @@ static int xfrm_send_report(struct net *net, u8 proto,
 		return -ENOMEM;
 
 	err = build_report(skb, proto, sel, addr);
-	BUG_ON(err < 0);
+	if (err < 0)
+		return err;
 
 	return xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_REPORT);
 }
@@ -4206,7 +4226,10 @@ static int xfrm_send_mapping(struct xfrm_state *x, xfrm_address_t *ipaddr,
 		return -ENOMEM;
 
 	err = build_mapping(skb, x, ipaddr, sport);
-	BUG_ON(err < 0);
+	if (err < 0) {
+		kfree_skb(skb);
+		return err;
+	}
 
 	return xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_MAPPING);
 }
-- 
2.43.0


