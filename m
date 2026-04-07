Return-Path: <netdev+bounces-276100-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJqwKhA51WlY3AcAu9opvQ
	(envelope-from <netdev+bounces-276100-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 19:04:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2CF3B22D6
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 19:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B32A0303CC2C
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 17:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDCA3D0915;
	Tue,  7 Apr 2026 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AboPylUy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ODZOh9RH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="umH7krKA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TKNjw97m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB81F3CBE63
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 17:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775581410; cv=none; b=LM8Q9jCc2rhQx51Z9dUCjhCp9w9neMr8VYcMofQl+xigRz511becD5Tp2lMXjtXnwomXehhPQ0XxrDRQB89hBMK2rNdOVIWCNBcjWErhMv/U5iIpD+IoGKkPqldftb+UL943Ak4DQhbLHOIAaNqErNTD3bI+CouhhlYiwfCNaq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775581410; c=relaxed/simple;
	bh=wd/YgB6h4/d30wnEtaUH1y3i3RgQjbQ0o8m+qBQkOoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CQrGgHQowFkS9P/ba+HVmrmy4tr3lfe1h4BjT48zuL0ExS5mneFvReDuO+NherKR1AJ8mbGjKoq27RwMEzJ2dGnrlQ6SWmLeDk9ygsZL5bdthWO8qVwwVwYcKxOz2cDPZ9PMPiJAmDf2PSvrIBKH/1VzySAIsUDDrPMHXmKbv8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AboPylUy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ODZOh9RH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=umH7krKA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TKNjw97m; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0B1485BCD7;
	Tue,  7 Apr 2026 17:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775581407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Egz3TmYcjwbsoBwoEm5GLfrPD8txLAnwPKyV55I3kpQ=;
	b=AboPylUy3IJM2Y/Uk+uXV5ceQoaRtAIlAJdU7pVxJWrYAfjV+zuZYBxKdk/qqr8HlMTl9A
	Dz5cI+Ln1V/LFo0UacN+uGS98N2TWVVFjays8W+yhEFCcQ6/c3XFUX1CdOCi5uFhLar1dW
	ikkVDzOwLxIYUW0d3ECewOPmvtvs7aI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775581407;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Egz3TmYcjwbsoBwoEm5GLfrPD8txLAnwPKyV55I3kpQ=;
	b=ODZOh9RHoWmFl5/tH1gYUxpQIh/gK91ZE0kEsvX+gO3KfL/N1piuH+ecuedhhOoQQsCPKR
	GzxrKRsLuy1lIhDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775581406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Egz3TmYcjwbsoBwoEm5GLfrPD8txLAnwPKyV55I3kpQ=;
	b=umH7krKA6zenZ1cJ4XD7dm3JAhkkCpjJe99RlWW+NshZJxKJoMmCTKYCQ/Z33rY2/BylIL
	C6XnoPTqwEHZNCPZVJZ3DyKUDC7K4ISmHkOYp3Loi5gOXyBDvbYqS1DuM1qe+NIIqioW26
	BFJJb/1oBOlaxidGXtTLB79zyTFrNQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775581406;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Egz3TmYcjwbsoBwoEm5GLfrPD8txLAnwPKyV55I3kpQ=;
	b=TKNjw97mp81uJcV9Cc2INmptCOcBYkj7GJkWBsJq/0JTnY+bCmBNCTqERRzblk48/wCWWR
	5YofxnhdptzHv5Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 821F04A0B0;
	Tue,  7 Apr 2026 17:03:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lq3PHN041WnlLAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 07 Apr 2026 17:03:25 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Damilola Bello <damilola@aterlo.com>
Subject: [PATCH net] net_sched: fix skb memory leak in deferred qdisc drops
Date: Tue,  7 Apr 2026 19:02:15 +0200
Message-ID: <20260407170214.4157-2-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276100-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,aterlo.com:email]
X-Rspamd-Queue-Id: 1A2CF3B22D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the network stack cleans up the deferred list via qdisc_run_end(),
it operates on the root qdisc. If the root qdisc do not implement the
TCQ_F_DEQUEUE_DROPS flag the packets queue to free are never freed and
gets stranded on the child's local to_free list.

Fix this by making qdisc_dequeue_drop() aware of the root qdisc. It
fetches the root qdisc and check for the TCQ_F_DEQUEUE_DROPS flag. If
the flag is present, the packet is appended directly to the root's
to_free list. Otherwise, drop it directly as it was done before the
optimization was implemented.

Fixes: a6efc273ab82 ("net_sched: use qdisc_dequeue_drop() in cake, codel, fq_codel")
Reported-by: Damilola Bello <damilola@aterlo.com>
Closes: https://lore.kernel.org/netdev/CAPgFtOLaedBMU0f_BxV2bXftTJSmJr018Q5uozOo5vVo6b9tjw@mail.gmail.com/
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 include/net/sch_generic.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index c3d657359a3d..61ba54e909f2 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -1170,12 +1170,18 @@ static inline void tcf_kfree_skb_list(struct sk_buff *skb)
 static inline void qdisc_dequeue_drop(struct Qdisc *q, struct sk_buff *skb,
 				      enum skb_drop_reason reason)
 {
+	struct Qdisc *root = qdisc_root_sleeping(q);
+
 	DEBUG_NET_WARN_ON_ONCE(!(q->flags & TCQ_F_DEQUEUE_DROPS));
 	DEBUG_NET_WARN_ON_ONCE(q->flags & TCQ_F_NOLOCK);
 
-	tcf_set_drop_reason(skb, reason);
-	skb->next = q->to_free;
-	q->to_free = skb;
+	if (root->flags & TCQ_F_DEQUEUE_DROPS) {
+		tcf_set_drop_reason(skb, reason);
+		skb->next = q->to_free;
+		q->to_free = skb;
+	} else {
+		kfree_skb_reason(skb, reason);
+	}
 }
 
 /* Instead of calling kfree_skb() while root qdisc lock is held,
-- 
2.53.0


