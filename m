Return-Path: <netdev+bounces-259694-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id LD4II40smGmzCAMAu9opvQ
	(envelope-from <netdev+bounces-259694-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 10:42:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1281665BB
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 10:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93B00304E70E
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 09:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382033246F3;
	Fri, 20 Feb 2026 09:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="IrDRV1S7"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CD13242C0
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 09:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771580508; cv=none; b=XjB88c7y+BYtkSmKZtG7M+egWwqMz3J4yPMOtH0MtnMqIbr0oxAdjR9lq8NbKV8TyU+SRnf+Ca0Wt0mQJ7aPgg0wjwVbiE52DG8SXs1BwnDlEQYFLN0bxJn4+694YZ6vrjEpxmq3Uoan2mQypFG023rO4Fm2/jVOepmwLIEYxII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771580508; c=relaxed/simple;
	bh=iWQtI9jPCXG5nG08Ym8700WE7s5v763Zt8+sNLtGAXU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yz6zT7/bAAsMn0VfjfDRlcirq5jcAn9L0+mLYoR2LmAN5HCLsUfR5ZqxyxPckMhI84HQG9gXbjGbO5T2SkHzlx1onfjf0VR9PQdcgQObAvosrRprIFdmALw1UDk9VHBwsynooizvnl4RX2nlKhNvuL+hT48mm/kJOa8wtVMbnlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=IrDRV1S7; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 1B57E207F4;
	Fri, 20 Feb 2026 10:41:43 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L1SCDkrMt3iT; Fri, 20 Feb 2026 10:41:42 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 75DA1207BE;
	Fri, 20 Feb 2026 10:41:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 75DA1207BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1771580502;
	bh=oNTQcmbtRswPN3jPHL8YxuhDWC5jPUesAtVSqe2M8Lk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=IrDRV1S7SziBvAnkXqB4RoxUxe0XNXEzpS+hPruW5pUeo/yoqBKrbsIH4+b9K6ekI
	 /DHF9GVZ1itGwJtinT8q1H66wuyNK/7hng40mVO8S4QOo1g04ArhuSCkBztCxYc4HX
	 ULzoUSeI809fJ/iv8gyzB9dr8o+z1l131/h5dvqfBVY4z0riVTt9YkmIMgzxstwNyp
	 zF4PDml6kt3A0ieIXUc6ZFPmD0AC5VpNLzXmRx2pJ/QfridRdTRPmWGYU0l56Jg3wb
	 YQFLnUoNK31VDnhzcPWD8pNaklgZ01E3yD3FhYo5xFCU+fe9D/WSAUu4rcTBNvXFbZ
	 sxB2wlWnk1aiQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Feb
 2026 10:41:42 +0100
Received: (nullmailer pid 16448 invoked by uid 1000);
	Fri, 20 Feb 2026 09:41:41 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 2/3] xfrm: skip templates check for packet offload tunnel mode
Date: Fri, 20 Feb 2026 10:41:16 +0100
Message-ID: <20260220094133.14219-3-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260220094133.14219-1-steffen.klassert@secunet.com>
References: <20260220094133.14219-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-259694-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:mid,secunet.com:dkim,secunet.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CF1281665BB
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

In packet offload, hardware is responsible to check templates. The
result of its operation is forwarded through secpath by relevant
drivers. That secpath is actually removed in __xfrm_policy_check2().

In case packet is forwarded, this secpath is reset in RX, but pushed
again to TX where policy is rechecked again against dummy secpath
in xfrm_policy_ok().

Such situation causes to unexpected XfrmInTmplMismatch increase.

As a solution, simply skip template mismatch check.

Fixes: 600258d555f0 ("xfrm: delete intermediate secpath entry in packet offload mode")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_policy.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 62486f866975..5428185196a1 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3801,8 +3801,8 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
 		struct xfrm_tmpl *tp[XFRM_MAX_DEPTH];
 		struct xfrm_tmpl *stp[XFRM_MAX_DEPTH];
 		struct xfrm_tmpl **tpp = tp;
+		int i, k = 0;
 		int ti = 0;
-		int i, k;
 
 		sp = skb_sec_path(skb);
 		if (!sp)
@@ -3828,6 +3828,12 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
 			tpp = stp;
 		}
 
+		if (pol->xdo.type == XFRM_DEV_OFFLOAD_PACKET && sp == &dummy)
+			/* This policy template was already checked by HW
+			 * and secpath was removed in __xfrm_policy_check2.
+			 */
+			goto out;
+
 		/* For each tunnel xfrm, find the first matching tmpl.
 		 * For each tmpl before that, find corresponding xfrm.
 		 * Order is _important_. Later we will implement
@@ -3837,7 +3843,7 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
 		 * verified to allow them to be skipped in future policy
 		 * checks (e.g. nested tunnels).
 		 */
-		for (i = xfrm_nr-1, k = 0; i >= 0; i--) {
+		for (i = xfrm_nr - 1; i >= 0; i--) {
 			k = xfrm_policy_ok(tpp[i], sp, k, family, if_id);
 			if (k < 0) {
 				if (k < -1)
@@ -3853,6 +3859,7 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
 			goto reject;
 		}
 
+out:
 		xfrm_pols_put(pols, npols);
 		sp->verified_cnt = k;
 
-- 
2.43.0


