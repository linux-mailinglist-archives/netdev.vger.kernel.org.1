Return-Path: <netdev+bounces-300746-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LkcbFXCfNWqE1gYAu9opvQ
	(envelope-from <netdev+bounces-300746-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 21:58:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A27096A7976
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 21:58:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=icloud.com header.s=1a1hai header.b="bcL/HJsz";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300746-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300746-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=icloud.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D93B8304DEAF
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 19:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349BA3ABD99;
	Fri, 19 Jun 2026 19:58:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from outbound.pv.icloud.com (pv-2005l-snip4-11.eps.apple.com [57.103.66.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06321345CA3
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 19:58:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781899105; cv=none; b=TwQhlC2Y0922bVzvd4+doJD+UjHiQEUNfBwuwuqocU2wOUXawYGtDdHVgsivCk/Q+ccJrrN0yWs+Rz8wZQ6Pbl8PZbgCK915UDUtvmSP9EiCdBwib1+UU92z0x2fl23QI7OEZhFfz6Nu73x/DD28Gf7YV03xLHthzgCDVcTelfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781899105; c=relaxed/simple;
	bh=abkzKRJ2ahL2DDAvpCD/1XKjeQzMX896bZFcUDKWunc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bsGzFR/k73i3Ql0qGihLX19cH/XCfWkvs3XgefJy7U+vnelOocsH3EyNYuH8nesqg8IUgHlzAs7tNA/i35pg0WXnYZVOVsfrJH76071mcPwsWCeCRbhfjl6m5xUeSSmE5y4RrTJeZIgxbS0Wfj7Cj5BBpjbc0LARJNXM+va0ohg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=bcL/HJsz; arc=none smtp.client-ip=57.103.66.231
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPS id ED2A2180010E;
	Fri, 19 Jun 2026 19:58:20 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQpOHV8CXhxBAFYEWBcOVk1KEVcJXwpABFEbWg9eK1sTVRdGCRkIXR0ZHldQXgheH0wcHQ5YBhICWkUBXxcDVxxWRVwYQwldBVccHR1BRVsTVRdGCRkIXR0ZCEcfCjADQg5WA0MHRQAtGRxXUF4IXh9MHB0OWAYSHVAcDlEFWwBGCU4CVAZSB0cMQR1ZBlkHRBRKHh5eD1YYWApHBVQCUBl5EVABWB5WXloXXlMXH0sAXEVaDlsERxQ=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1781899103; x=1784491103; bh=/JHpw/Y6YXDfEJ2X+/4MEbtrZiHImZ8h4NMn92pbpcU=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=bcL/HJsz6U4Y/HzlReDv/oO4H8oOxWx9KtlYcHT+f7qMEE4cTVcSuGXrR/w2MuDHvr6TlC68jX4uL52oymoyBhdQviYEdQffsltbqX2fP4QYWP/ALbd8MyMk84PKSYMVqOzpN6wTpJkqPpg9wH0Hw0JYVx07r+ecGUXJTB/Qf3C+jFANhecDc4sUFX0Uojq54nAQpOroCUG2fN9c5W0M8W3Ie2NUogKQ0jNKqh1hIr1aQTtc5NOcos8S/wAnw0s7Sd+Q8HGRDDgciZINZSts5vOI81QBQptzoUJnIb4hX21rvllN1YroO/EGdCtyIHNZ1xrpd5hY48jafQjq26voZA==
Received: from cibi (unknown [17.56.9.36])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPSA id 8DE4E1800125;
	Fri, 19 Jun 2026 19:58:14 +0000 (UTC)
From: Siddharth_Cibi <siddharthcibi@icloud.com>
To: ast@kernel.org
Cc: Siddharth C <siddharthcibi@icloud.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	netdev@vger.kernel.org (open list:XDP (eXpress Data Path)),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] bpf: preserve rx_queue_index across XDP redirects
Date: Fri, 19 Jun 2026 19:57:57 +0000
Message-ID: <20260619195759.41254-2-siddharthcibi@icloud.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619195759.41254-1-siddharthcibi@icloud.com>
References: <20260619195759.41254-1-siddharthcibi@icloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDE5MSBTYWx0ZWRfXz50Z1pmVn3Ir
 WkpKZHpg5JAR5uEqjhUaQaIrLXKzlVnFy4PKF1VZyodlhMbUIaOQGIbHUcExINvOgxG7TPjk1P1
 FNvAh/X9REAhq0XgW3O7KN6s1zD6Ecct3lQ1uVirjjcayfsSSakcvLq5jHm5eoRnAWTkB1VE364
 9ciurTOqMGH0E/ydZYuBpcj1vr9JyH/55vNEe95vmhafNajCwIf7glpzDGURITcYfds2nEmFcUq
 S/KJsTJ+hTImnW1+fN0juDCGelm/1NDVKBTGhTnyDZmKwhvrVXIVUoECrRX2fdFTgxFxX+VuFPv
 M9j1QNGBj0ipD3up4Rn
X-Proofpoint-ORIG-GUID: gsH6DdmmtnWjrESumUuan1cOtAplPPdq
X-Proofpoint-GUID: gsH6DdmmtnWjrESumUuan1cOtAplPPdq
X-Apple-Category-Label: MjA0NzgyOTUxNDY6JGNhdGVnb3J5JF9QZXJzb25hbCw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300746-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[siddharthcibi@icloud.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[icloud.com,iogearbox.net,davemloft.net,kernel.org,gmail.com,fomichev.me,google.com,redhat.com,linux.dev,etsalapatis.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[icloud.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:siddharthcibi@icloud.com,m:daniel@iogearbox.net,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:netdev@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[siddharthcibi@icloud.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[icloud.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,icloud.com:dkim,icloud.com:email,icloud.com:mid,icloud.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A27096A7976

From: Siddharth C <siddharthcibi@icloud.com>

Store rx_queue_index in struct xdp_frame during xdp_buff to
xdp_frame conversion and restore it when rebuilding xdp_rxq_info
for cpumap and devmap execution paths.

This preserves ingress RX queue information for XDP programs
executed after redirect, allowing access to the original
rx_queue_index instead of losing queue context.

Also propagate rx_queue_index for zero-copy XDP frame conversion.

Signed-off-by: Siddharth_Cibi <siddharthcibi@icloud.com>
---
 include/net/xdp.h   | 2 ++
 kernel/bpf/cpumap.c | 2 +-
 kernel/bpf/devmap.c | 5 ++++-
 net/core/xdp.c      | 1 +
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index aa742f413c35..90318b2b76dc 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -301,6 +301,7 @@ struct xdp_frame {
 	 */
 	enum xdp_mem_type mem_type:32;
 	struct net_device *dev_rx; /* used by cpumap */
+	u32 rx_queue_index;
 	u32 frame_sz;
 	u32 flags; /* supported values defined in xdp_buff_flags */
 };
@@ -441,6 +442,7 @@ struct xdp_frame *xdp_convert_buff_to_frame(struct xdp_buff *xdp)
 
 	/* rxq only valid until napi_schedule ends, convert to xdp_mem_type */
 	xdp_frame->mem_type = xdp->rxq->mem.type;
+	xdp_frame->rx_queue_index = xdp->rxq->queue_index;
 
 	return xdp_frame;
 }
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 5e59ab896f05..8f2d7013620f 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -197,7 +197,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 
 		rxq.dev = xdpf->dev_rx;
 		rxq.mem.type = xdpf->mem_type;
-		/* TODO: report queue_index to xdp_rxq_info */
+		rxq.queue_index = xdpf->rx_queue_index;
 
 		xdp_convert_frame_to_buff(xdpf, &xdp);
 
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index dc7b859e8bbf..f419fa0e53e5 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -339,7 +339,7 @@ static int dev_map_bpf_prog_run(struct bpf_prog *xdp_prog,
 				struct net_device *rx_dev)
 {
 	struct xdp_txq_info txq = { .dev = tx_dev };
-	struct xdp_rxq_info rxq = { .dev = rx_dev };
+	struct xdp_rxq_info rxq = { };
 	struct xdp_buff xdp;
 	int i, nframes = 0;
 
@@ -349,6 +349,9 @@ static int dev_map_bpf_prog_run(struct bpf_prog *xdp_prog,
 		int err;
 
 		xdp_convert_frame_to_buff(xdpf, &xdp);
+		rxq.dev = rx_dev;
+		rxq.mem.type = xdpf->mem_type;
+		rxq.queue_index = xdpf->rx_queue_index;
 		xdp.txq = &txq;
 		xdp.rxq = &rxq;
 
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 9890a30584ba..9691d8dfadf3 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -606,6 +606,7 @@ struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp)
 	xdpf->metasize = metasize;
 	xdpf->frame_sz = PAGE_SIZE;
 	xdpf->mem_type = MEM_TYPE_PAGE_ORDER0;
+	xdpf->rx_queue_index = xdp->rxq->queue_index;
 
 	xsk_buff_free(xdp);
 	return xdpf;
-- 
2.53.0


