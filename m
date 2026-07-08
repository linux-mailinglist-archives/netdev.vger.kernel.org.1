Return-Path: <netdev+bounces-305984-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kisJJie1TmobSwIAu9opvQ
	(envelope-from <netdev+bounces-305984-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 22:37:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D0872A438
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 22:37:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=verdict.gg header.s=sig1 header.b=qI7QkH7M;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305984-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305984-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D48C230B730C
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 20:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12C03E4C88;
	Wed,  8 Jul 2026 20:35:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from outbound.qs.icloud.com (qs-2005e-snip4-1.eps.apple.com [57.103.86.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7043E4C68
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 20:35:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783542916; cv=none; b=TN1HMHFRT7zHYrj9bvf8gsaxfLSg/6gpdgVmMxbgMluvDjzteK1RnVi7n5OjF/Xg9FFtdZXSK133MY0Ijz9WqNvRVsFK2q8WB3NDPv7sBcCdsJtktXiR2BFudgCq/bobQixj4AC9nqhVwxEyqup0R5NGLZNd0J0kmp/BMDyupCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783542916; c=relaxed/simple;
	bh=UkjUTZpO+eb0xjCalIOnZcTcPX6mUCbSOTdgTZMkbgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9pxp5Qt6cl8suVlAo9VLQY/9urbXonMA6lhpx9PDB05NFfKTPx0Dy41AVbQ9fbtxnF/frm3uuD31NzsfNdVI+y+2g/tx8LRNQANagJilqgc0YprKlOpRJ2ymZVJAXV4GIrZkzcDSW2V+DtTnKGAQcrRHLgEn/bmK7qkHMA7CdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg; spf=pass smtp.mailfrom=verdict.gg; dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b=qI7QkH7M; arc=none smtp.client-ip=57.103.86.172
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPS id 3FE41300111F;
	Wed, 08 Jul 2026 20:35:05 +0000 (UTC)
X-ICL-RepId: 019f4370-f930-7323-895b-d7470b570765
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhICkMGWQJeCEABQwVdEhVdRVcIWwJAEVc4RQhFD1sTTVZUChcNVk1PHUEJXghGXl4fEx9UVgFDGRBWAVhWXQVNGlwYWQ8cAUpWWg5bBEcUFxtcABcbRgIEIwJfAEUCXglWATAXD1ZNTx1BCV4IRl5eHxMAXg8PTAtIAVsHXAJIC0gAWQZbHEQMSQFcGl4fFFwUWh9WBXIGXApXBFQfHBdeRhMZThtXTVoNQBlYBm0UVhVSBFk=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verdict.gg; s=sig1; t=1783542911; x=1786134911; bh=+PFlT3RJWe6JoKnddGSkgUhZU+EBpA8u7FgwGEwUuz8=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=qI7QkH7MYvKsl0iKmaZHC9xUnOIK+tRzkAaK/ZoFxAZpkfrQ1w/sU7YJlBfuOmeYbDPdNh7MVSEvZJQnt/flaOfHLAcoRWohlGQCB6KbCSw6VDxuuZyM+mn46srfWVTjA6IPkztZKlo4JHzHhZUa78YXJEzUeGQfrwkPMDuzLHa4cvUp3nUct9hEorAfo6LRN8OP9RtFFoJWTyZvTMC+NwSUC8m031rppDgbCEU5UXbAuxXwDC/h/id5HcrIkP4y0svrW0AtU6kfbLDLew5Yiit6Q5S2qprJ/SuzU65Fa5jjcp6NdpdeDtT1mOKRFNuFW6AvZYcep4ruYM1dsCfYvA==
mail-alias-created-date: 1621344842221
Received: from DelNac.mail.msk (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPSA id 5D6D23001108;
	Wed, 08 Jul 2026 20:34:59 +0000 (UTC)
From: Vladimir Vdovin <deliran@verdict.gg>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kselftest@vger.kernel.org,
	Vladimir Vdovin <deliran@verdict.gg>
Subject: [PATCH bpf-next v4 4/6] selftests/bpf: Add selftest support for bpf_xdp_metadata_rx_checksum
Date: Wed,  8 Jul 2026 23:34:08 +0300
Message-ID: <20260708203410.45121-5-deliran@verdict.gg>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260708203410.45121-1-deliran@verdict.gg>
References: <20260708203410.45121-1-deliran@verdict.gg>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDIwMiBTYWx0ZWRfX3j05Hbc6i0Xa
 FwV19KsuyI/eGyRtezOY7i23/f+aPFAX43jgdVdGnjX1ZJxFdFdx9QDc1JMpZ1Ce3FFdyMeVT7S
 if2CcBavqoufVD7Fk2Go6um1X2wFv0zIKqxI/fVvrAG6IjYUuhILhDDTOoOQoAyP0nAggHBgjGS
 elsAuqMkNrP1x984GOysgM178O+2QhqGDOTOeZT6bXT5tpwOO7v7lA3xTqTyghpqH5OaDlHBnzm
 dgzSu5n46dFJSYL66vb9JV8+eFw5ZdzWRe/U9ySdWmQi2qqCQNTHYTh1T4jPuUlR2aCxAxnpHsV
 t+MW06cvm0W3MnKgn85
X-Proofpoint-GUID: _5GTcZh2MDb4kVaLz0CyKt1Ozjyuyi1l
X-Proofpoint-ORIG-GUID: _5GTcZh2MDb4kVaLz0CyKt1Ozjyuyi1l
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[verdict.gg:s=sig1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305984-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:andrew+netdev@lunn.ch,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:aleksander.lobakin@intel.com,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:kpsingh@kernel.org,m:haoluo@google.com,m:jolsa@kernel.org,m:shuah@kernel.org,m:maciej.fijalkowski@intel.com,m:jakub@cloudflare.com,m:aleksandr.loktionov@intel.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,m:linux-kselftest@vger.kernel.org,m:deliran@verdict.gg,m:donaldhunter@gmail.com,m:johnfastabend@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DMARC_NA(0.00)[verdict.gg];
	FORGED_SENDER(0.00)[deliran@verdict.gg,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,davemloft.net,google.com,redhat.com,iogearbox.net,fomichev.me,lunn.ch,intel.com,linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[deliran@verdict.gg,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[verdict.gg:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:email,verdict.gg:from_mime,verdict.gg:email,verdict.gg:mid,verdict.gg:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 33D0872A438

From: Lorenzo Bianconi <lorenzo@kernel.org>

Introduce dedicated selftest for bpf_xdp_metadata_rx_checksum kfunc to
bpf selftest framework.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Vladimir Vdovin <deliran@verdict.gg>
---
 tools/testing/selftests/bpf/prog_tests/xdp_metadata.c | 9 +++++++++
 tools/testing/selftests/bpf/progs/xdp_metadata.c      | 2 ++
 tools/testing/selftests/bpf/xdp_metadata.h            | 9 +++++++++
 3 files changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index 5c31054ad4a4..91de61c822f5 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -310,6 +310,15 @@ static int verify_xsk_metadata(struct xsk *xsk, bool sent_from_af_xdp)
 	if (!ASSERT_NEQ(meta->rx_hash, 0, "rx_hash"))
 		return -1;
 
+	if (!ASSERT_EQ(meta->ip_summed, XDP_CHECKSUM_NONE, "rx_ip_summed"))
+		return -1;
+
+	if (!ASSERT_EQ(meta->cksum, 0, "rx_cksum"))
+		return -1;
+
+	if (!ASSERT_EQ(meta->cksum_level, 0, "rx_cksum_level"))
+		return -1;
+
 	if (!sent_from_af_xdp) {
 		if (!ASSERT_NEQ(meta->rx_hash_type & XDP_RSS_TYPE_L4, 0, "rx_hash_type"))
 			return -1;
diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata.c b/tools/testing/selftests/bpf/progs/xdp_metadata.c
index 09bb8a038d52..af1e19d48d67 100644
--- a/tools/testing/selftests/bpf/progs/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/progs/xdp_metadata.c
@@ -98,6 +98,8 @@ int rx(struct xdp_md *ctx)
 	bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash, &meta->rx_hash_type);
 	bpf_xdp_metadata_rx_vlan_tag(ctx, &meta->rx_vlan_proto,
 				     &meta->rx_vlan_tci);
+	bpf_xdp_metadata_rx_checksum(ctx, &meta->ip_summed, &meta->cksum,
+				     &meta->cksum_level);
 
 	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
 }
diff --git a/tools/testing/selftests/bpf/xdp_metadata.h b/tools/testing/selftests/bpf/xdp_metadata.h
index 87318ad1117a..bca09b94af26 100644
--- a/tools/testing/selftests/bpf/xdp_metadata.h
+++ b/tools/testing/selftests/bpf/xdp_metadata.h
@@ -30,6 +30,10 @@ enum xdp_meta_field {
 	XDP_META_FIELD_VLAN_TAG	= BIT(2),
 };
 
+#define XDP_CHECKSUM_NONE		BIT(0)
+#define XDP_CHECKSUM_UNNECESSARY	BIT(1)
+#define XDP_CHECKSUM_COMPLETE		BIT(2)
+
 struct xdp_meta {
 	union {
 		__u64 rx_timestamp;
@@ -48,5 +52,10 @@ struct xdp_meta {
 		};
 		__s32 rx_vlan_tag_err;
 	};
+	struct {
+		__u32 ip_summed;
+		__u32 cksum;
+		__u8 cksum_level;
+	};
 	enum xdp_meta_field hint_valid;
 };
-- 
2.47.0


