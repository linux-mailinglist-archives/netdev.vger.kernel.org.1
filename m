Return-Path: <netdev+bounces-271110-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKtFL8ikwmm3fQQAu9opvQ
	(envelope-from <netdev+bounces-271110-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:50:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A46C430A77B
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 37A91302F115
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D273FFAC5;
	Tue, 24 Mar 2026 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o4kifuZb"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9293437DEB6
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774363622; cv=none; b=gCBGAPKGw/MNzHzlBL4afgUPbJdfbo12nrZf3zI1bWYoNsxdI44PR/zGSCWFwBYYcHLdhWFj/J8qGVdptscG4C4sk1jOU8k2UH3yPOLWs+FtJUwq1OD8cfuAbVPH+nnsLBWGQght7HOhlOYOWw9h7IKJ21zypndqgs4R+sHav+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774363622; c=relaxed/simple;
	bh=j+f3uClfjMHsdo332pJtQTIhUZDYivfEjSJPDjJCbgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YoBnvS3ZEdnUevSqB3Lv5DEzBQna0Q1b5UrySuaAc6T4O0K00KPLHKFWvY2LoqVFhnyjVyK/7TeNci1QcWadCQcoaK4mjkQKVZ5m1jCcD6MQWJCNMel/oeC3y2QDZL50f1JlmmHSDNjh9r2tllElnOLnB6fQ492xxPPeWfcrkhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o4kifuZb; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774363617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KzyxAYRyx/x/x8wyor+HCtuz83L/riqOOKLGxAKi7fs=;
	b=o4kifuZbDlbin/3tH5IwKgVXnJEuIfOoLaAscIuI6G6YKXt5+3Smcg1ScPu89ypQvAWNKv
	1wRzZ2G71/8iwrcLa/VtWWRDyb7gM9S5y8RW17mgPmrjRLw6560FSC1hawo81kWS/bzaJ0
	eUw3uUAnOE9FEgYBC/TmNctuX/c2xwY=
From: luka.gejak@linux.dev
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	fmaurer@redhat.com,
	liuhangbin@gmail.com,
	linux-kernel@vger.kernel.org,
	Luka Gejak <luka.gejak@linux.dev>
Subject: [PATCH net-next v1 4/7] net: hsr: use __func__ instead of hardcoded function name
Date: Tue, 24 Mar 2026 15:46:27 +0100
Message-ID: <20260324144630.189094-5-luka.gejak@linux.dev>
In-Reply-To: <20260324144630.189094-1-luka.gejak@linux.dev>
References: <20260324144630.189094-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.dev:?];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,gmail.com,vger.kernel.org,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271110-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DMARC_DNSFAIL(0.00)[linux.dev : SPF/DKIM temp error,none];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_TEMPFAIL(0.00)[linux.dev:s=key1];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: A46C430A77B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Luka Gejak <luka.gejak@linux.dev>

Replace the hardcoded string "hsr_get_untagged_frame" with the
standard __func__ macro in netdev_warn_once() call to make the code
more robust to refactoring.

Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
---
 net/hsr/hsr_forward.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index aefc9b6936ba..0aca859c88cb 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -184,7 +184,7 @@ struct sk_buff *hsr_get_untagged_frame(struct hsr_frame_info *frame,
 				create_stripped_skb_hsr(frame->skb_hsr, frame);
 		else
 			netdev_warn_once(port->dev,
-					 "Unexpected frame received in hsr_get_untagged_frame()\n");
+					 "Unexpected frame received in %s()\n", __func__);
 
 		if (!frame->skb_std)
 			return NULL;
-- 
2.53.0


