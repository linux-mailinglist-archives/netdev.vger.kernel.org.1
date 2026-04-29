Return-Path: <netdev+bounces-282290-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKoIAAfB8WkbkQEAu9opvQ
	(envelope-from <netdev+bounces-282290-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:27:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 680304912A2
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE3063025A4F
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 08:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193713B0AF1;
	Wed, 29 Apr 2026 08:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="bVEJDhQT"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6DE3AEF2D
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 08:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777451268; cv=none; b=gO0fbbMELrcSl9uPZ3rlBUwg8dnFhmIcJvItW4HsklA8EGyqPvKWixySKcltVTLt+Fwks50Um8l47d859EKUUmQCl/gmci7gVug9HxvMbEecHerAOU/pepa1kQPcte5gkorhnemiHrqsSFr/CLboREjlXp3R+yJcGvUq0zQ83EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777451268; c=relaxed/simple;
	bh=UeMbgQyKW4ov6RfuOD74SYC2gPv8C8XNhZJlOULT9L0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YC2m1V08UbtD+hlnJ7t40WJ0kFbHj5uBsdJO3YzXwlTKpU+kosFkSsrYxRNvVtXbcfg7jZYWynsyv2pH/nfWXqqOEFy9G4/G9IThKvnzRWOcPwODuo2ZDmGkjKN0xXtTwZdp+zKodrCrMHKnuTLbWl0Yg2yeh2SfftVaUdjlYko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=bVEJDhQT; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1777451264;
	bh=WgrZsvJRYeCZws+T6fsE9IMjwZvCyab/9cFomg6EY6I=;
	h=From:Date:Subject:To:Cc;
	b=bVEJDhQTonpj01syqHICznvyz1l4AYgDV0VYVsv04N87zK7lU6BsZXNbLNmzRKDEM
	 ew7m7cOdVDhRSLZpjGaqYqpO6T13InhyPrJrN2q3ssUvu96XSbjVTNp2nuQmliRPZL
	 s4/Ce8CdPOQIDS/8Ntj+guf2b0VcnSmCDCe23+e7j4f1X4LtJZO0VZHabuGYiSazqp
	 qar19dTnKUFhRb3cFY0921TWaogkzXSGbzJxPkuEaPBlRZrjb/C6KjPTO9NhcveXBY
	 JLlEuiSSEf2JWSoY98e9AYcgKbC2FH0IplAlCg126hVmCJWTfwQupFsfm1OEW0C3Ow
	 g7zOggCcGwLMg==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id A94C160263; Wed, 29 Apr 2026 16:27:44 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 29 Apr 2026 16:27:31 +0800
Subject: [PATCH net-next] net: mctp: test: remove skb dumps from test
 output
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-dev-mctp-test-skb-dump-v1-1-13fd5789ef71@codeconstruct.com.au>
X-B4-Tracking: v=1; b=H4sIAPLA8WkC/yWMwQ6CMBAFf4Xs2U2wAQP+ivFA24cWQ226CyEh/
 LtVj5PJzE6CHCB0rXbKWIOEdyxwPlXknkN8gIMvTKY2l7oxPXusPDtNrBBleVn2y5zYudb27dj
 BDJ5KnDLGsP3GN4pQjtiU7n8ji53g9Pul4/gA2As9mIQAAAA=
X-Change-ID: 20260429-dev-mctp-test-skb-dump-cc5b95f8e2ad
To: Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Rspamd-Queue-Id: 680304912A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282290-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,codeconstruct.com.au:email,codeconstruct.com.au:dkim,codeconstruct.com.au:mid]

We're currently dumping skb info in our fragment input test, which makes
interpreting the TAP test output a bit awkward.

Remove the skb dumps.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 net/mctp/test/route-test.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
index e1033643fab0..fbd6d4e08aef 100644
--- a/net/mctp/test/route-test.c
+++ b/net/mctp/test/route-test.c
@@ -859,12 +859,6 @@ static void mctp_test_route_input_cloned_frag(struct kunit *test)
 	skb[0]->data[4] = 0;
 	skb[3]->data[4] = 0;
 
-	skb_dump("pkt1 ", skb[0], false);
-	skb_dump("pkt2 ", skb[1], false);
-	skb_dump("pkt3 ", skb[2], false);
-	skb_dump("pkt4 ", skb[3], false);
-	skb_dump("pkt5 ", skb[4], false);
-
 	for (int i = 0; i < 5; i++) {
 		KUNIT_EXPECT_EQ(test, refcount_read(&skb[i]->users), 1);
 		/* Take a reference so we can check refcounts at the end */

---
base-commit: dca922e019dd758b4c1b4bec8f1d509efddeaab4
change-id: 20260429-dev-mctp-test-skb-dump-cc5b95f8e2ad

Best regards,
--  
Jeremy Kerr <jk@codeconstruct.com.au>


