Return-Path: <netdev+bounces-300747-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r2YUOpqfNWqY1gYAu9opvQ
	(envelope-from <netdev+bounces-300747-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 21:59:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E9A6A7989
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 21:59:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=icloud.com header.s=1a1hai header.b=giUBqQ25;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300747-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300747-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=icloud.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 883A03064E2F
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 19:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0087F3B27E9;
	Fri, 19 Jun 2026 19:58:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from outbound.pv.icloud.com (pv-2005b-snip4-1.eps.apple.com [57.103.66.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03913749E3
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 19:58:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781899113; cv=none; b=hSejeLmo0DEDAe6679ZT6VuYHr2UtlY+YDmvqjEh7zCDZF40nl/LKH1sfNxwS+rj7U5PVa+fE6xiCFxcBYC2rwgT0kAVltNiifnfNpNSd/ZWQc0fswTxYtD0/gO5vkWNRWQ/oHi862cz7bd/dH5GncP6LditD1MDLUlJoLbcs5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781899113; c=relaxed/simple;
	bh=6uGn0GopFXIezIt1AfR5Ttqh7FWwt6oPkOUWciKbdCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B3oIEawhh6qMGKmg39ncepO5LMFo4JFKZlpcaKpKDspje67kKKVcSS7uyuYyG97NZKJqYEacLwIfMRvVg7XggKYGwJdIucQ0g/0UZVNzy7hX1089ZKkEtuJgrBAXV4It9GqVBhJX1X4oQIKOZ0QjQpsuMu5WI6SR/QwSVH9bcBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=giUBqQ25; arc=none smtp.client-ip=57.103.66.182
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPS id 109F8180010D;
	Fri, 19 Jun 2026 19:58:31 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQpOHV8CXhxBAFYEWBcOVk1KEVcJXwpABFEbWg9eK1sTVRdGCRkIXR0ZHldQXgheH0wcHQ5YBhICWkUBXBcDVxxWRVwYQwldBVccHR1BRVsTVRdGCRkIXR0ZCEcfCjADQg5WA0MHRQAtGRxXUF4IXh9MHB0OWAYSHVAcDlEFWwBGCU4CVAZSB0cMQR1ZBlkHRBRLHh5eD1YYWApHBVQCUBl5EVABWB5WXloXXlMXH0sAXEVaDlsERxQ=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1781899112; x=1784491112; bh=uCzNyh9ez4ys8w28jvcLcpYoV8d+8g3nF2DPpTvrxL8=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=giUBqQ25koolVJBR+nXkdbkQNhd9Ibm/w5aNVnWZo/k5duQFaKW2fvI7VJe2U+VCnG0+UPUHwxuZllenpXgH1zYJIXmC+W/3lme3m1yHqAFOhDBaS1xV8FfXJtqwxeS6I2kJfiSaDXRz7PofSz8UsWnAeRzLLkZTDjhRpr+AamB9P7ngcT9cQC+Hr8931vH3ZtwQJcpvkNEdrarQRxnfcmoUYY9lgqLWogw6YPweJlem/qXNSUQScisDElmQ9zz0x4bxCYjtFNKCSPirDySqScYnP1wQTp8DeOOkycZ4N0qXjlQdEsFOBlGsuk9Ip8HsuuS0nNYd997L5T6+afgkLw==
Received: from cibi (unknown [17.56.9.36])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPSA id 3253E18000A9;
	Fri, 19 Jun 2026 19:58:24 +0000 (UTC)
From: Siddharth_Cibi <siddharthcibi@icloud.com>
To: ast@kernel.org
Cc: Siddharth_Cibi <siddharthcibi@icloud.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org (open list:XDP (eXpress Data Path)),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path)),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] selftests/bpf: validate rx_queue_index in xdp_metadata
Date: Fri, 19 Jun 2026 19:57:58 +0000
Message-ID: <20260619195759.41254-3-siddharthcibi@icloud.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDE5MSBTYWx0ZWRfX9Svem6twCxxP
 80KPU026J0U9zQLpjIO6SbsWQw9GFqIaIsRBMRiW3x6/BPOLVjRNf0sBlaSDoMhjPml3B92vqPd
 APf+gf5zoCRfz2qpzsnBrB9nFLGjFHo0VsLoIvlKWMnKn/QzzK9Hg5A2PekoHdsJwF2yQ/KRMJs
 Jj5BOZcWPRJ9/mWvLIGn2PGDgZ+inQsc6XVymDqwWoM6gbBmarnXxkWqbSKpJteoAxnxDXyYKaa
 IZWvKF6W95YnzwpWh6W/VaHmm8OcT+fsECx+tSLMEfMwJ3WAXBpE7nwS4dfoqb/HDZqptV8rQtd
 HNJgV1TB2UWX4Klvmow
X-Proofpoint-ORIG-GUID: Db2CYb48ct3jrMupaRyZFvbMjivAXCot
X-Proofpoint-GUID: Db2CYb48ct3jrMupaRyZFvbMjivAXCot
X-Apple-Category-Label: MjA0NzgyOTUxNDY6JGNhdGVnb3J5JF9QZXJzb25hbCw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300747-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[siddharthcibi@icloud.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[icloud.com,iogearbox.net,davemloft.net,kernel.org,gmail.com,fomichev.me,linux.dev,etsalapatis.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[icloud.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:siddharthcibi@icloud.com,m:daniel@iogearbox.net,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[icloud.com:dkim,icloud.com:email,icloud.com:mid,icloud.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 83E9A6A7989

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


