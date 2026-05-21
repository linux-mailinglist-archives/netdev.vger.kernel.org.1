Return-Path: <netdev+bounces-290403-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBEuBBICD2pfEAYAu9opvQ
	(envelope-from <netdev+bounces-290403-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:01:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8934B5A54EF
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8128B309B767
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BAA3D9DCB;
	Thu, 21 May 2026 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaykBOUh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CE83D9DB3
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779367784; cv=none; b=ZJ0lFNiKWrCW8xNmKEj+oq4TtZDrCtXRLDKQEW6u93CDnHC7k+DoiU0qprzpakVMqmCguqikzW4SQPof8sGOzXyffQMFxu811TLUAPefQnZfiLS5Hv8KrxlUPms6993DS97lF+QBz7oB5nw8zXOcS3+ugSI3mCzKc/SVGnEvX3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779367784; c=relaxed/simple;
	bh=wigWFtjyEa+VCBZgvrGiZjEW95od0zj93AXCLLanc/A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z+rOw3vbRD3CAPLNtdbptZvV4aNmWlgWAbwr8xJHLdvcLRPyf5YflM4V6TtMwoMZ3bYfL2X8/d35vhQC6Wz0ze+tyZV/KYaR8K5fdlsTH4i2xDOPZzoLlkhxiwV5/nGD2rmBGWEceLG2L2syFQrOo7RVjJczudfqjubdTt4Xow8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaykBOUh; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48fde648a71so43859795e9.0
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 05:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779367780; x=1779972580; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3FOLDoUTVhvtMvpFRrgXFdt2ND7UZm3SuSUfzhbpzKo=;
        b=VaykBOUhtlW88xUww3Jn5n8ZoH/J009CQrx1v1vDaCNrv3+YyuH/fRW2keFMJzUlVX
         VdEGp0dnCqEdkx9wl+a8j7+8Q9/SERvqCcnXg9ZwfrjRvDe4w3DhYB6NEjbNDwXh61HL
         hfEX2fBsGwsUFq4yYoD6BddM+16lBOR/yXgto2fZGDJb0wZOAW8ffS0D60mRhTrvNMiq
         IXruIKVEmjHzAX4Tu0UmfNMrzBNcRGOOplb2hDcgIL/NPdS/2ECYJO4oO9fNAwCyEFPf
         +xHyv4zHnCaI93HCTE3MIyZKLtrDrclTvN+KszVa/Ojru1dZc7NIwFl6EikzLxvSgP9y
         q4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779367780; x=1779972580;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3FOLDoUTVhvtMvpFRrgXFdt2ND7UZm3SuSUfzhbpzKo=;
        b=jUSvAWqDVDZs5JmaTSDxyRhMUb0FoJFleWIToK/kTmOpS/67qFr0lech1bNc5N3fc4
         jRXiUi+xk9yJnDVBKU9+pcXp3VhFhPndKpD6n3UpwQVPo+z2OBID8rXHhi0OC5ndMLoh
         c6E9qwjj2x7R4nBZKSb5b5qnQTPI512CRagBl7eHBGpTI98l0G+fjhA2bfmX85J4to98
         hy/7PSsbg2noD0n7JphQJ/jJB5LYgv8Z9/SBb1kuRrwBXzrVbcZ535NothwxA0Vlg8cB
         4z85FAMJMhXO8jZStslqNemDW6H33Fy5kiNZzb/RTOe9ZNW4hVJ6/HlXx7bmskD4llc0
         ke/g==
X-Forwarded-Encrypted: i=1; AFNElJ899+nbLRwBgYMca/ERNRhmVbKTemCYazTD27KhVUq//tCE7PxHYNmdwQALn4LvUmJbQyd0r04=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEV63uRCgrZWqOlMb5jRRDWYDq8kMNd3Ap4XCY3ZBMX9IVq1Ln
	6PFaz+5nLooBMHfzYUcWqeYY6+bM9nB4FOaAFAdleETSv+qqAMGGRWWJ
X-Gm-Gg: Acq92OHqMXIcyydIKrg2z2HanOK1IR4Yz2WXElUIrFM4B2sTU1nn7XdOTPLqpnrA4kS
	fkHhbJjjLVp87EJIVS8Fj0fm/3gM4N3wGicEYPtv7Vv52PUc+b5q8OzNiMk4c3CAEIkMqqZUd9F
	2/IQ+o49Zf0nGKbvwslDmOl4D6hR8bGtzfCLKCQOCCqd1CFlxvt4XqaS30Mod/WLxntdtRt4v4P
	eyvBc8rMEEqW13XNCCO9C/zcOCTe4wUvI9IazHvyxwmZPqzfhMOUP37+g+O3QQomhEYz4NM1jLx
	3aNyuyGdCPUHUC9OfjBhLp+bg6VfR7/rxzZ/AbTk4dvEENicI7IA3VUNYF72i6r5dwGeBDNiGt0
	Vn7Ak3IXqZM9DR0DRiu/OaF9Y52m3ujIwGwu06oo0FKS8bvh5QVLQpFV28nZF8TuXvibkrYKB+L
	3vWU2vwrWT67UO8+QYoftrxbs=
X-Received: by 2002:a05:600c:8286:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-4903606a0bdmr35037485e9.6.1779367780083;
        Thu, 21 May 2026 05:49:40 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49035c219a0sm16144605e9.5.2026.05.21.05.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 05:49:39 -0700 (PDT)
Date: Thu, 21 May 2026 15:49:36 +0300
From: Dan Carpenter <error27@gmail.com>
To: David Carlier <devnexen@gmail.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] net: lan966x: cleanup error handling in
 lan966x_fdma_rx_alloc_page_pool()
Message-ID: <ag7_YBWRpRmY9MGT@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-290403-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,microchip.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,stanley.mountain:mid]
X-Rspamd-Queue-Id: 8934B5A54EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This code works, but there are a few things to tidy up:
1. No need to an unlikely() because IS_ERR() already has an unlikely()
   built in.
2. No need to use PTR_ERR_OR_ZERO() because it's not an error pointer.
3. Use the returned error code directly instead of using groveling in
   rx->page_pool to find it.

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index f8ce735a7fc0..2d1c38289bb4 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -91,7 +91,7 @@ static int lan966x_fdma_rx_alloc_page_pool(struct lan966x_rx *rx)
 		pp_params.dma_dir = DMA_BIDIRECTIONAL;
 
 	rx->page_pool = page_pool_create(&pp_params);
-	if (unlikely(IS_ERR(rx->page_pool)))
+	if (IS_ERR(rx->page_pool))
 		return PTR_ERR(rx->page_pool);
 
 	for (int i = 0; i < lan966x->num_phys_ports; ++i) {
@@ -106,7 +106,7 @@ static int lan966x_fdma_rx_alloc_page_pool(struct lan966x_rx *rx)
 					   rx->page_pool);
 	}
 
-	return PTR_ERR_OR_ZERO(rx->page_pool);
+	return 0;
 }
 
 static int lan966x_fdma_rx_alloc(struct lan966x_rx *rx)
@@ -115,8 +115,9 @@ static int lan966x_fdma_rx_alloc(struct lan966x_rx *rx)
 	struct fdma *fdma = &rx->fdma;
 	int err;
 
-	if (lan966x_fdma_rx_alloc_page_pool(rx))
-		return PTR_ERR(rx->page_pool);
+	err = lan966x_fdma_rx_alloc_page_pool(rx);
+	if (err)
+		return err;
 
 	err = fdma_alloc_coherent(lan966x->dev, fdma);
 	if (err) {
-- 
2.53.0


