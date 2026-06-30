Return-Path: <netdev+bounces-303345-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Du62H8EWRGpToQoAu9opvQ
	(envelope-from <netdev+bounces-303345-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 21:19:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E566E783E
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 21:19:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=verdict.gg header.s=sig1 header.b=gjImPDZM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303345-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303345-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 119CC3061772
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 19:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1F43B71A8;
	Tue, 30 Jun 2026 19:18:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from outbound.ci.icloud.com (ci-2003a-snip4-5.eps.apple.com [57.103.91.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF663D9035
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 19:18:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782847096; cv=none; b=pS7WC1B1OrCXngKMGukZFpVVPwa4gAedvqisFmTJzPSMcc+CnL6UVyHjIcVamTJYckVsFdia8B89jfteeQGO+4FxRDnz69C+1X/kjplA9PnLk6rPc+sCbCVS8E2+Sq4KAdoXKbX50+Ui9+5bhZZ6G7CBmTg7OVCguSki2dQeosw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782847096; c=relaxed/simple;
	bh=bzxFy41sPH7fJd071OWXb6j48wdQSl7USCsOB++sLSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRsaYLmzcjLoRMYxpAMdNpUfFpXiJxqpds1Qxj/dRm2HlHGYdS2P2P7EklhWUeq4sYCCjR1BLGXvBns9eoi6hqN5sBSDWmEmFuI4Vyv5LQxSU1xRwTZwN2iO/WIfnMojts1dA6el9puShknad75onF8m+b6UjcAD1CuBuicoTPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg; spf=pass smtp.mailfrom=verdict.gg; dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b=gjImPDZM; arc=none smtp.client-ip=57.103.91.136
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPS id 4BF2E18015FF;
	Tue, 30 Jun 2026 19:18:09 +0000 (UTC)
X-ICL-RepId: 019f19f7-aa3d-708d-92a6-6423bd0acea5
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhICkMGWQJeCEABQwVdEhVdRVcIWwJAEVc4RQhFD1sTTVZUChcNVk1PHUEJXghGXl4fEx9UVgNBGRBWAVhWXQVNGlwYWQ8cE1BWWg5bBEcUFxtcABcbRgIEIwJfAEUCXglWATAXD1ZNTx1BCV4IRl5eHxMAXg8PTAtIAVsHXQFACEECWAZbHEgITANfGlMfFFwUWh9WBXIGXApXBFQfHBdeRhMZThtXTVoNQBlYBm0UVhVSBFk=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verdict.gg; s=sig1; t=1782847092; x=1785439092; bh=MlH8EI0NXkS41fcAP+/C6cjXncTfe7i2j/oK54dy168=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=gjImPDZMnR0eiFhM8rvRXjw4xYG7Jyf/9JRDWjhBDuxTtHkQq1DAiyyadBFi2kS9RZ+K4TIZzbM+R+RygTnQyx6nF+tPRdrTG5TxsyeDMzybQpibVh1X0e1lJaN+GBgX+3cZtSvqEIwxMbrUNSFr2dTNN1xWxqtma5k/LTMGQ2XGpTtvkdW4AE8YvKf2uEwM5s6jmhhSyUq7KmpjD/OmaR/ih8xwz4VL+p+WlMr4hgVTAMalAczoF0UzHz3rQh0zf5XNHQItEp9mQhwpZbyAisbU8djeieFL8ow6Eqqt1r0SM513TxgrUTkoNnLdTq4Ub/PjtULAmB8QArL/CpY7gw==
mail-alias-created-date: 1621344842221
Received: from DelNac.mail.msk (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPSA id 7E48218015DC;
	Tue, 30 Jun 2026 19:18:06 +0000 (UTC)
From: Vladimir Vdovin <deliran@verdict.gg>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	Vladimir Vdovin <deliran@verdict.gg>
Subject: [RFC PATCH bpf-next v1 7/7] selftests/bpf: cover bpf_xdp_metadata_rx_csum in xdp_metadata
Date: Tue, 30 Jun 2026 22:15:10 +0300
Message-ID: <20260630191510.81402-8-deliran@verdict.gg>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260630191510.81402-1-deliran@verdict.gg>
References: <20260630191510.81402-1-deliran@verdict.gg>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE4NiBTYWx0ZWRfX/EamM9QkAXmh
 c6vwdpZQ8tNevkl2WwFDaqN5FtZc32efUxVMpq8eaKmCFiUJL4Ic9dPnH0v++OeUSVJYzOkAvll
 l8jyEa1qKp09dXchU8Rw40zUwSrUGdc/szmBdl802AvtBY8chCGZ8i+fGcAbwnODUALAOQzOt3T
 XObQkzYq76XwnMZv2Q88/Ax7+1joCfsmQ5IPyQG0tZ2TPqevhiZJTyduiHo1hgLCtvMkDIllelb
 pdajCj5YfNMNXMc7fxbjN2ia0hx26lt/vSrTkjxoSM4Dp3yP1aetWi0uQUuziGas9JAyfxoQQLw
 HGMqBYEFTS4V4Y0Avzm
X-Proofpoint-GUID: Vro55lTvrxDexyUZhVxXDOSWRg7RsG4A
X-Proofpoint-ORIG-GUID: Vro55lTvrxDexyUZhVxXDOSWRg7RsG4A
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[verdict.gg:s=sig1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,fomichev.me,gmail.com,verdict.gg];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303345-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[deliran@verdict.gg,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:sdf@fomichev.me,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:deliran@verdict.gg,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[verdict.gg];
	DKIM_TRACE(0.00)[verdict.gg:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[deliran@verdict.gg,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,verdict.gg:dkim,verdict.gg:email,verdict.gg:mid,verdict.gg:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E2E566E783E

Call bpf_xdp_metadata_rx_csum() in the xdp_metadata program and export the
status to userspace.  veth surfaces skb->ip_summed: a frame injected via
AF_XDP carries no checksum context (XDP_CSUM_NONE), while one sent through
the stack is CHECKSUM_PARTIAL (XDP_CSUM_VERIFIED).  Assert each.

Signed-off-by: Vladimir Vdovin <deliran@verdict.gg>
---
 tools/testing/selftests/bpf/prog_tests/xdp_metadata.c | 10 ++++++++++
 tools/testing/selftests/bpf/progs/xdp_metadata.c      |  9 +++++++++
 tools/testing/selftests/bpf/xdp_metadata.h            |  8 ++++++++
 3 files changed, 27 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index 5c31054ad4a4..77f55696eb78 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -310,6 +310,16 @@ static int verify_xsk_metadata(struct xsk *xsk, bool sent_from_af_xdp)
 	if (!ASSERT_NEQ(meta->rx_hash, 0, "rx_hash"))
 		return -1;
 
+	/* veth surfaces the checksum verdict from skb->ip_summed.  A packet
+	 * injected via AF_XDP carries no checksum context and is CHECKSUM_NONE,
+	 * while one sent through the stack is CHECKSUM_PARTIAL and reads back as
+	 * verified.
+	 */
+	if (!ASSERT_EQ(meta->rx_csum_status,
+		       sent_from_af_xdp ? XDP_META_CSUM_NONE : XDP_META_CSUM_VERIFIED,
+		       "rx_csum_status"))
+		return -1;
+
 	if (!sent_from_af_xdp) {
 		if (!ASSERT_NEQ(meta->rx_hash_type & XDP_RSS_TYPE_L4, 0, "rx_hash_type"))
 			return -1;
diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata.c b/tools/testing/selftests/bpf/progs/xdp_metadata.c
index 09bb8a038d52..0089c6c5a2e4 100644
--- a/tools/testing/selftests/bpf/progs/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/progs/xdp_metadata.c
@@ -33,6 +33,8 @@ extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *hash,
 extern int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
 					__be16 *vlan_proto,
 					__u16 *vlan_tci) __ksym;
+extern int bpf_xdp_metadata_rx_csum(const struct xdp_md *ctx,
+				    enum xdp_csum_status *csum_status) __ksym;
 
 SEC("xdp")
 int rx(struct xdp_md *ctx)
@@ -43,6 +45,7 @@ int rx(struct xdp_md *ctx)
 	struct udphdr *udp = NULL;
 	struct iphdr *iph = NULL;
 	struct xdp_meta *meta;
+	enum xdp_csum_status csum_status;
 	u64 timestamp = -1;
 	int ret;
 
@@ -99,6 +102,12 @@ int rx(struct xdp_md *ctx)
 	bpf_xdp_metadata_rx_vlan_tag(ctx, &meta->rx_vlan_proto,
 				     &meta->rx_vlan_tci);
 
+	ret = bpf_xdp_metadata_rx_csum(ctx, &csum_status);
+	if (ret < 0)
+		meta->rx_csum_err = ret;
+	else
+		meta->rx_csum_status = csum_status;
+
 	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
 }
 
diff --git a/tools/testing/selftests/bpf/xdp_metadata.h b/tools/testing/selftests/bpf/xdp_metadata.h
index 87318ad1117a..ba1b2902b371 100644
--- a/tools/testing/selftests/bpf/xdp_metadata.h
+++ b/tools/testing/selftests/bpf/xdp_metadata.h
@@ -30,6 +30,10 @@ enum xdp_meta_field {
 	XDP_META_FIELD_VLAN_TAG	= BIT(2),
 };
 
+/* Mirror of enum xdp_csum_status (include/net/xdp.h) for userspace asserts. */
+#define XDP_META_CSUM_NONE	0
+#define XDP_META_CSUM_VERIFIED	1
+
 struct xdp_meta {
 	union {
 		__u64 rx_timestamp;
@@ -48,5 +52,9 @@ struct xdp_meta {
 		};
 		__s32 rx_vlan_tag_err;
 	};
+	union {
+		__u32 rx_csum_status;
+		__s32 rx_csum_err;
+	};
 	enum xdp_meta_field hint_valid;
 };
-- 
2.47.0


