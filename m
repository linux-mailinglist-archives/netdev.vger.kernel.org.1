Return-Path: <netdev+bounces-291050-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEADLsRHEWrIjQYAu9opvQ
	(envelope-from <netdev+bounces-291050-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 08:23:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1C95BD6AF
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 08:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB4E5300B8FA
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 06:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2F63191CE;
	Sat, 23 May 2026 06:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.in header.i=linuxuser509@zohomail.in header.b="BqDN+IG7"
X-Original-To: netdev@vger.kernel.org
Received: from sender-pp-o93.zoho.in (sender-pp-o93.zoho.in [103.117.158.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B0E3128CF;
	Sat, 23 May 2026 06:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779517373; cv=pass; b=AleD9IXbEYtZpaoNNsq+oYG17bpvHrfG4ZeeZntcquY6ofnpFvKw8RYAWkJHwYlIn5SVc5EaoP/Dd6F7qsNMJy6qp0da6hFn0iFxDGmrfyNIWDTjCqGu/9EFoCdmgq+DSsBjNTsZkOWjsoHzIx0LwBsJwE4G5wUBrtr8eodkEZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779517373; c=relaxed/simple;
	bh=DcGYQtSpJar3uKcn3JUGfnWWwccxu+srp6306Fr5jNk=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=XBYj4iBcAa2xxr8/DlwXY2C3d5N9P2u3ozTspP9/Q4SG32EwbbWuzVUcX3tcRbdD8heZt8i8/ukd3Cpm0kwwj3F/bO69ze/vU3RIMDH4cMH6tOyv8rvJ2gb+0v1qvNHdmPVmMIwlZ8kH7Q0sHeehmQZRKm8bVsvgiyKcw6uTmTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in; spf=pass smtp.mailfrom=zohomail.in; dkim=pass (1024-bit key) header.d=zohomail.in header.i=linuxuser509@zohomail.in header.b=BqDN+IG7; arc=pass smtp.client-ip=103.117.158.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.in
ARC-Seal: i=1; a=rsa-sha256; t=1779517336; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=cLmloSO7/9qaf/EIqs3nwo4r9PBVjT6cm0F9/5BNP4Wr0fQyIY58I8lhNFB7uld86kBe7l5NXGfQbgJfjXQKwigaXw5xJo6WfuEdKYRSL5PRSfFwSOXEEswTKj9XKpbIsGVCcSKjeTku8ykBK8kCqME7gtzjVjSEcj9j4cNnsPw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1779517336; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hZxyXWmAPqKETQ9Pxse7c7KTUmJuXZ6q1hA+scXEGkw=; 
	b=YaCN5S5VnxnsSytg1KXsfqKkocJz1HpdQOeePPuJyu97pqm7hCkTtriE0VhMkWt8MlhaHJrsrBjpEe5/p8VnoXtNTHX4qbPbLyRbbCbbfjuBZKHPLPJeKmqDEaj0/440zev+q37+KoW7Aiqg/DEFC3gpqL+au0yxwZXpow49mxc=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=linuxuser509@zohomail.in;
	dmarc=pass header.from=<linuxuser509@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779517336;
	s=zoho; d=zohomail.in; i=linuxuser509@zohomail.in;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=hZxyXWmAPqKETQ9Pxse7c7KTUmJuXZ6q1hA+scXEGkw=;
	b=BqDN+IG7zKiXQ4cUFfzhoIPlpKxh6QAhbw7W2nhzJUSekkPyfmNXGip/TyeLi7oA
	ZdqStJw38bcV9Ks7UwiaQ/VqY8ScL0NCpr8a2FW8AOY0BGqlZdmQZ10gHN2mEDpshW9
	xbyUH6iW84cEZRD/m4qs9nLc1LvGz15JNcQmISps=
Received: from mail.zoho.in by mx.zoho.in
	with SMTP id 1779517334906443.1321783571458; Sat, 23 May 2026 11:52:14 +0530 (IST)
Received: from  [106.219.3.73] by mail.zoho.in
	with HTTP;Sat, 23 May 2026 11:52:14 +0530 (IST)
Date: Sat, 23 May 2026 11:52:14 +0530
From: Ashwin Gundarapu <linuxuser509@zohomail.in>
To: "anthonylnguyen" <anthony.l.nguyen@intel.com>,
	"anthony.l.nguyen@intel.com" <przemyslaw.kitszel@intel.com>,
	"andrewnetdev" <andrew+netdev@lunn.ch>,
	"davem" <davem@davemloft.net>, "edumazet" <edumazet@google.com>,
	"kuba" <kuba@kernel.org>, "pabeni" <pabeni@redhat.com>
Cc: "intel-wired-lan" <intel-wired-lan@lists.osuosl.org>,
	"netdev" <netdev@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19e537fa55c.56218d6244367.1765806925055659075@zohomail.in>
Subject: [PATCH net-next] e1000e: fix memory leak of msix_entries on MSI-X
 failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[zohomail.in,reject];
	R_DKIM_ALLOW(-0.20)[zohomail.in:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-291050-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[zohomail.in:+];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linuxuser509@zohomail.in,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.992];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AD1C95BD6AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ashwin Gundarapu <linuxuser509@zohomail.in>
Date: Sat, 23 May 2026 11:49:40 +0530
Subject: [PATCH] e1000e: fix memory leak of msix_entries on MSI-X failure

When MSI-X initialization fails, the driver falls through to try
MSI or legacy interrupts. However, the msix_entries array allocated
earlier is not freed, causing a memory leak. Free it and set to
NULL before falling through to the MSI fallback path.

Found by code inspection.

Signed-off-by: Ashwin Gundarapu <linuxuser509@zohomail.in>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 7ce0cc8ab8f4..1526069d7fc1 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -2065,10 +2065,12 @@ void e1000e_set_interrupt_capability(struct e1000_adapter *adapter)
 							    a->num_vectors);
 				if (err > 0)
 					return;
-			}
-			/* MSI-X failed, so fall through and try MSI */
-			e_err("Failed to initialize MSI-X interrupts.  Falling back to MSI interrupts.\n");
-			e1000e_reset_interrupt_capability(adapter);
+                        }
+                        /* MSI-X failed, so fall through and try MSI */
+                        e_err("Failed to initialize MSI-X interrupts.  Falling back to MSI interrupts.\n");
+                        kfree(adapter->msix_entries);
+                        adapter->msix_entries = NULL;
+                        e1000e_reset_interrupt_capability(adapter);
 		}
 		adapter->int_mode = E1000E_INT_MODE_MSI;
 		fallthrough;
--
2.43.0



