Return-Path: <netdev+bounces-253933-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBJBOkbleGlvtwEAu9opvQ
	(envelope-from <netdev+bounces-253933-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 17:18:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54055979C9
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 17:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B32D300C9B0
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 16:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91F031619A;
	Tue, 27 Jan 2026 16:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WZnNkT0F";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OMwGReJQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WZnNkT0F";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OMwGReJQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C50B31328C
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 16:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769530586; cv=none; b=P9ALAj4nHy2rsTdfQ6lfrn+1qvBS5lVo20XBQRtuCT7NyC5rFkmqSHGyMRJ9INendiIKOH4UlQBXhyLScI/Ju/sR6ytupsBboFgG5fls+DpOelMCx7gshulkmyY3Vk6B7LFidYp3h1jw2lYoBp2F1Zeeh3hRJbfMZRMiYHL4IoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769530586; c=relaxed/simple;
	bh=+GktQ1kyEhAdFafRvrsn3ptLLIIul+XG9ykOzNal5tE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LU3QEkNLnYbycpEogh0GDBXeG0AWBVdPikX4bSIC1FW0i5yXoKMr8zrqByop4mAnY7kklWzCuJr7G6uJK1IodqLBghvMj/38PmZJKIzxKRhyCl9szuVNCI2QtCz4ITt9pM7CNzrz8/ugB8Eo0gzuqSjuHPbOPuTU+Lx+c7hFjCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WZnNkT0F; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OMwGReJQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WZnNkT0F; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OMwGReJQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4AE1C5BCE6;
	Tue, 27 Jan 2026 16:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769530581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NM3xZy/NVVYdo7OOJlkDOtIlQ2nqjY+Mi3ZBRUML5Xs=;
	b=WZnNkT0FlPmVQ3WXjLki1NeDkV2a1R4UuerK1dkKu9WamYDro4YaRn6w7IWLr3PNy4Iw6Y
	CKg+YXhhX2XkrMWKOzepw7Rc2URg2u+4pAMRtSpttHGMX4Fy8L9Vfy3FMfjGV+dV31ZoSS
	e1Zl0kWjhnNv7nVzqxSIwMwebXe6k6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769530581;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NM3xZy/NVVYdo7OOJlkDOtIlQ2nqjY+Mi3ZBRUML5Xs=;
	b=OMwGReJQTKdY/hIAlTFTij6F4MU3HFa+mJsYuJnptp1PvhQ+dVL4wdKyvD//7Mc5nKxLOk
	ET+3T0TtJfTAwoDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769530581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NM3xZy/NVVYdo7OOJlkDOtIlQ2nqjY+Mi3ZBRUML5Xs=;
	b=WZnNkT0FlPmVQ3WXjLki1NeDkV2a1R4UuerK1dkKu9WamYDro4YaRn6w7IWLr3PNy4Iw6Y
	CKg+YXhhX2XkrMWKOzepw7Rc2URg2u+4pAMRtSpttHGMX4Fy8L9Vfy3FMfjGV+dV31ZoSS
	e1Zl0kWjhnNv7nVzqxSIwMwebXe6k6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769530581;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NM3xZy/NVVYdo7OOJlkDOtIlQ2nqjY+Mi3ZBRUML5Xs=;
	b=OMwGReJQTKdY/hIAlTFTij6F4MU3HFa+mJsYuJnptp1PvhQ+dVL4wdKyvD//7Mc5nKxLOk
	ET+3T0TtJfTAwoDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1C293EA61;
	Tue, 27 Jan 2026 16:16:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OQ7SLdTkeGlULQAAD6G6ig
	(envelope-from <sjaeckel@suse.de>); Tue, 27 Jan 2026 16:16:20 +0000
From: Steffen Jaeckel <sjaeckel@suse.de>
To: Sidraya Jayagond <sidraya@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matttbe@kernel.org>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>,
	"D . Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] dibs: Re-apply lost patch
Date: Tue, 27 Jan 2026 17:16:11 +0100
Message-ID: <20260127161611.2228083-1-sjaeckel@suse.de>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253933-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_NEQ_ENVFROM(0.00)[sjaeckel@suse.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: 54055979C9
X-Rspamd-Action: no action

While merging the dibs layer, Matt [1] noticed that the changes which were
done in [2] conflicted and were missing. He subsequently fixed this in the
merge commit of his own tree, but the changes never made it upstream.

This commit re-introduces the changes.

[1] https://lore.kernel.org/netdev/74368a5c-48ac-4f8e-a198-40ec1ed3cf5f@kernel.org/
[2] a35c04de2565d ("net/smc: fix warning in smc_rx_splice() when calling get_page()")

Fixes: cc21191b584c ("dibs: Move data path to dibs layer")
Signed-off-by: Steffen Jaeckel <sjaeckel@suse.de>
---
 drivers/dibs/dibs_loopback.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/dibs/dibs_loopback.c b/drivers/dibs/dibs_loopback.c
index b3fd0f8100d4..aa029e29c6b2 100644
--- a/drivers/dibs/dibs_loopback.c
+++ b/drivers/dibs/dibs_loopback.c
@@ -12,6 +12,7 @@
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/dibs.h>
+#include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
@@ -49,6 +50,7 @@ static int dibs_lo_register_dmb(struct dibs_dev *dibs, struct dibs_dmb *dmb,
 {
 	struct dibs_lo_dmb_node *dmb_node, *tmp_node;
 	struct dibs_lo_dev *ldev;
+	struct folio *folio;
 	unsigned long flags;
 	int sba_idx, rc;
 
@@ -70,13 +72,16 @@ static int dibs_lo_register_dmb(struct dibs_dev *dibs, struct dibs_dmb *dmb,
 
 	dmb_node->sba_idx = sba_idx;
 	dmb_node->len = dmb->dmb_len;
-	dmb_node->cpu_addr = kzalloc(dmb_node->len, GFP_KERNEL |
-				     __GFP_NOWARN | __GFP_NORETRY |
-				     __GFP_NOMEMALLOC);
-	if (!dmb_node->cpu_addr) {
+
+	/* not critical; fail under memory pressure and fallback to TCP */
+	folio = folio_alloc(GFP_KERNEL | __GFP_NOWARN | __GFP_NOMEMALLOC |
+			    __GFP_NORETRY | __GFP_ZERO,
+			    get_order(dmb_node->len));
+	if (!folio) {
 		rc = -ENOMEM;
 		goto err_node;
 	}
+	dmb_node->cpu_addr = folio_address(folio);
 	dmb_node->dma_addr = DIBS_DMA_ADDR_INVALID;
 	refcount_set(&dmb_node->refcnt, 1);
 
@@ -122,7 +127,7 @@ static void __dibs_lo_unregister_dmb(struct dibs_lo_dev *ldev,
 	write_unlock_bh(&ldev->dmb_ht_lock);
 
 	clear_bit(dmb_node->sba_idx, ldev->sba_idx_mask);
-	kfree(dmb_node->cpu_addr);
+	folio_put(virt_to_folio(dmb_node->cpu_addr));
 	kfree(dmb_node);
 
 	if (atomic_dec_and_test(&ldev->dmb_cnt))
-- 
2.52.0


