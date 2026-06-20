Return-Path: <netdev+bounces-300808-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DKFJNW6ENmo/AwcAu9opvQ
	(envelope-from <netdev+bounces-300808-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 14:15:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B27A6A8DF6
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 14:15:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=icloud.com header.s=1a1hai header.b=fQxxM3fR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300808-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300808-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=icloud.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54EF53024C82
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 12:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0A4390204;
	Sat, 20 Jun 2026 12:14:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from outbound.qs.icloud.com (qs-2003f-snip4-11.eps.apple.com [57.103.86.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3A92C21C5
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 12:14:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781957650; cv=none; b=hGRT/Qgd/ZHi6EDE1zXEkAHAV6vtTooI2MI5OQZECwxoG3r86EklVb8kvwBrS8It8NBvEbep6P4QXGfWxXVt1bLuhbXjIfRzRARjxVcPdoaZvFLCA5EtlZ/FwTq+blLkRQQCEYogRdfMfaQG9VtZq0PICGf3Wy/bXysULTiu0/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781957650; c=relaxed/simple;
	bh=F4nQG/vAy1yKxXgYOlZoathCWfcC0tiqHT340k4o7F0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJXEjIflalqS7eQXBB0DOaU23baCnhNDmJyG/tO0q+1hrqwxStlzYSUZ8sRc5qurinh1PV6RBWI69MmlnxxdvUB5vOUiE34hWTipR1nk7jREy15T5Z8KI0MTFpuytWgtrhPQpuNca11FjfYwBiERkECz5lEfhtTWNnLMNfpiVlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=fQxxM3fR; arc=none smtp.client-ip=57.103.86.63
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-10-percent-2 (Postfix) with ESMTPS id 6BA2E3000191;
	Sat, 20 Jun 2026 12:14:05 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQpOHV8CXhxBAFYLWxcOVk1KEVcJXwpABFEbWg9eK1sTVRdGCRkIXR0ZHldQXgheH0wcHQ5YBhICWkUKTV8OXh8EF0YZVQRHHl1WQh4ZAlEcVg1XQ1QEX1BJDEFQbFoARxdIHV0ZWW9QXRwOBFQHXQVdVlACWktfGV1FD18HWQRAD0oDXAVaAUIIVgdYBVkFXQpVQARTD1oRSwxbDl4JWzBQG18CQg8cE1YVDU1DEkIVBBFQAVgeVg==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1781957648; x=1784549648; bh=B2Pp0WGbRgzLs4Smn37csLZQa4PVookrDR16OraLNYs=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=fQxxM3fRRpdpKDkg9fQNT9MDJfVBRU2DBrRMA+lCbcumsv074awNbA3ORf1CwGDKUIHeIhUf6dkPt/WfPFVZ4fyhzbcQjcsljeic3Kf7VpnmYnx+k4DABggEjq128P0Qp5bguGsDNeXiaAIpLyaDMxPfS8R/oca4lEzMfSEg6FX4dLVQ08H7yEYFmAq6NA7kPuMyIcFAb4HHNUIqjJSGigQU4z9Rvpk4J1K7ALJ3m64x7rbxAvb4+qaO3uAr0Zp548d0kvvx4V5HEtPRn24saFm+8DZXDi9tMPEiwU1kgqrX66ounnexyazhmkLA5sOyT3uthVk1U22Y8w2onv1osw==
Received: from cibi (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-10-percent-2 (Postfix) with ESMTPSA id 11B5B3000184;
	Sat, 20 Jun 2026 12:14:00 +0000 (UTC)
From: Siddharth C <siddharthcibi@icloud.com>
To: ast@kernel.org,
	kuba@kernel.org,
	hawk@kernel.org,
	andrii@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Siddharth_Cibi <siddharthcibi@icloud.com>
Subject: [PATCH 2/2] selftests/bpf: validate rx_queue_index in xdp_metadata
Date: Sat, 20 Jun 2026 12:13:14 +0000
Message-ID: <20260620121321.45227-3-siddharthcibi@icloud.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260620121321.45227-1-siddharthcibi@icloud.com>
References: <20260620121321.45227-1-siddharthcibi@icloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: tFHWwJf4YN-D4whddqvv-hexfB_5gAlG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIwMDEyMSBTYWx0ZWRfX7plsFHKGUv1A
 WP5I9tWiRubvLDY0kEmOz1rGIrP9ys+APeD2YtGhXUH2+Y3lb69pEQNhftKS5YrTvVCh6Ymnddi
 n36ecaavCKERwR7qzxGfPs9cTmN0W9FmAFlrOMiHUPe1QBXWNBxuBnSywGTpzIK15VJiybYllzA
 LJL85veIVY677MBj3lHXFMuqUwU55lqVaxZmt8kbfWS6UYMwa2G0NCW9dzxZm8/+iADIyZtkPv6
 dxkje0LOiqBGtq3MLQBel6Nrmk7ElEgX/RCIQwMLP1Ww1/Inus8Tt/fdwG7Y7E6upWWQQ7hYLcu
 8G1lfI0OiB2yY2ikGQS
X-Proofpoint-GUID: tFHWwJf4YN-D4whddqvv-hexfB_5gAlG
X-Apple-Category-Label: MjA0NzgyOTUxNDY6JGNhdGVnb3J5JF9QZXJzb25hbCw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[icloud.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300808-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:kuba@kernel.org,m:hawk@kernel.org,m:andrii@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:siddharthcibi@icloud.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[siddharthcibi@icloud.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[icloud.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[icloud.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[siddharthcibi@icloud.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,icloud.com:dkim,icloud.com:email,icloud.com:mid,icloud.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B27A6A8DF6

From: Siddharth_Cibi <siddharthcibi@icloud.com>

Extend xdp_metadata selftest coverage to validate that
ctx->rx_queue_index is preserved and observable after XDP redirect
execution.

Capture rx_queue_index in metadata and assert that it matches the
expected queue during packet verification.

Signed-off-by: Siddharth_Cibi <siddharthcibi@icloud.com>
---
 tools/testing/selftests/bpf/prog_tests/xdp_metadata.c | 3 ++-
 tools/testing/selftests/bpf/progs/xdp_metadata.c      | 2 +-
 tools/testing/selftests/bpf/xdp_metadata.h            | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index 5c31054ad4a4..f8cabbbe7bb7 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -309,7 +309,8 @@ static int verify_xsk_metadata(struct xsk *xsk, bool sent_from_af_xdp)
 
 	if (!ASSERT_NEQ(meta->rx_hash, 0, "rx_hash"))
 		return -1;
-
+	if (!ASSERT_EQ(meta->rx_queue_index, QUEUE_ID, "rx_queue_index"))
+        	return -1;
 	if (!sent_from_af_xdp) {
 		if (!ASSERT_NEQ(meta->rx_hash_type & XDP_RSS_TYPE_L4, 0, "rx_hash_type"))
 			return -1;
diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata.c b/tools/testing/selftests/bpf/progs/xdp_metadata.c
index 09bb8a038d52..62ae83860d7f 100644
--- a/tools/testing/selftests/bpf/progs/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/progs/xdp_metadata.c
@@ -98,7 +98,7 @@ int rx(struct xdp_md *ctx)
 	bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash, &meta->rx_hash_type);
 	bpf_xdp_metadata_rx_vlan_tag(ctx, &meta->rx_vlan_proto,
 				     &meta->rx_vlan_tci);
-
+	meta->rx_queue_index = ctx->rx_queue_index;
 	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
 }
 
diff --git a/tools/testing/selftests/bpf/xdp_metadata.h b/tools/testing/selftests/bpf/xdp_metadata.h
index 87318ad1117a..1f0ae4c00091 100644
--- a/tools/testing/selftests/bpf/xdp_metadata.h
+++ b/tools/testing/selftests/bpf/xdp_metadata.h
@@ -49,4 +49,5 @@ struct xdp_meta {
 		__s32 rx_vlan_tag_err;
 	};
 	enum xdp_meta_field hint_valid;
+	__u32 rx_queue_index;
 };
-- 
2.53.0


