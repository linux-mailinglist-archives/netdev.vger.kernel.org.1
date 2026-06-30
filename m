Return-Path: <netdev+bounces-303339-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yRBIHxcXRGp5oQoAu9opvQ
	(envelope-from <netdev+bounces-303339-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 21:20:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6926E784F
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 21:20:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=verdict.gg header.s=sig1 header.b=IKeUJm5N;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303339-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303339-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2B5B3100FF5
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 19:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375BF3822AE;
	Tue, 30 Jun 2026 19:18:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from outbound.ci.icloud.com (ci-2005e-snip4-8.eps.apple.com [57.103.89.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BB63019BA
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 19:17:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782847081; cv=none; b=RwYxx/52M8BeGB/+Gp918Osufa9JmMSsOXZH0raAC6wq17ix6MwqKtXojOJwdEPsDaHdFPjsVEu07owbgLkshbtAfblv5XPJEPJX9HoaLGDgZpYnnhG/kLUJvmUX/rIFIoRCltPENvB0Sih02/dZz8dEBXL0tgKRxkJzB8EFyGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782847081; c=relaxed/simple;
	bh=gGdWrO/VICzqsi5b9oeW3D7Hc7Sxo044kL20l28ryyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rSZozYTiGynAYum2U/WFGt9k06fjheY7+UlNH6lONOwEWjzCIaKn6lyMIQRZb5v7ebGZYFZJJqC5Ot1A70tbem3iCcFIjSmTx7cIHQMQlk+HkxRiQEHwI/FyfyVBiaIZb07lxZZLBfZXMFVzB0yldjjgMvJ6JYQQPcaabZjo/r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg; spf=pass smtp.mailfrom=verdict.gg; dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b=IKeUJm5N; arc=none smtp.client-ip=57.103.89.179
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPS id 8E07D1800142;
	Tue, 30 Jun 2026 19:17:54 +0000 (UTC)
X-ICL-RepId: 019f19f7-70d0-728f-8fe8-479b5bf10a4e
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhICkMGWQJeCEABQwVdEhVdRVcIWwJAEVc4RQhFD1sTTVZUChcNVk1PHUEJXghGXl4fEx9UVgNBGRBWAVhWXQVNGlwYWQ8cE1BWWg5bBEcUFxtcABcbRgIEIwJfAEUCXglWATAXD1ZNTx1BCV4IRl5eHxMAXg8PTAtIAVsHXQFACEECWAZbHEgITANfGlkfFFwUWh9WBXIGXApXBFQfHBdeRhMZThtXTVoNQBlYBm0UVhVSBFk=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verdict.gg; s=sig1; t=1782847076; x=1785439076; bh=wvVWLPsYtZEctFl45EvUHYLNwiL5th6MjSAqxie468g=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=IKeUJm5N0WruePYttByLuUhtZOR/DauqKxkaE/GmZkAblJ7ZPsRJ7KueMRBMjBbwDGark58KsuyoEoYIPaj/Xug3eyZg5Zy3hh4AnKeUndGRIX2v0Yco8T/iLeiXfwPsJeJq5aVCIZevSIwndHCptf5tTsR6aREOh6A/CAd9GTaLzq8OziQ/4zeedZRwq/taN0+QklKrMv/xnWZOu0Vfn0mNGzdM/c4gxwE2RXxXt/5sfV/YU3dN78c524F0uVSWkJn/yjruougDnZoiDc3MtCcAgx4hkA/zd7VF/4n/ksce83uhVmBj1y4f23HIISMdoqFmVUy2xTWI8gtq93KdOQ==
mail-alias-created-date: 1621344842221
Received: from DelNac.mail.msk (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPSA id E26C91800171;
	Tue, 30 Jun 2026 19:17:51 +0000 (UTC)
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
Subject: [RFC PATCH bpf-next v1 1/7] xdp: let XDP programs assert the RX checksum over redirect
Date: Tue, 30 Jun 2026 22:15:04 +0300
Message-ID: <20260630191510.81402-2-deliran@verdict.gg>
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
X-Proofpoint-ORIG-GUID: 3ErTKaJopNcqfuA8tb7D_yTqV0MpCd0l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE4NiBTYWx0ZWRfX0v7et79NAryA
 iCdNHgmn6mfsKEFH0B2tNpX8fEZ3Mvr3EYY48zn2cHGcztPqSJw2GNMoTYdfsJ/EehfvtwIlrez
 VqAnW1ty2KMxNJQjEHitu3FOTfUT60SFlmps302nOfrVRGSPdj9L/UIX9kmelGgScUK9LOKIgRI
 9TnDCLglPeBxD4mh/3E4bG23eh/1ebQazcgeQwsOZVTfxE4fRhZxer0/Ws2HPPB6scHR9TNTu4R
 mZzvpcVNEnpJJIY+OHNAy9glcf/7iYqT56vgdBJbQQZiwZHIWPF+BsmXp88S31CdJc0OP/aaJif
 7pQ4qp+Oi3FcGmjHyms
X-Proofpoint-GUID: 3ErTKaJopNcqfuA8tb7D_yTqV0MpCd0l
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[verdict.gg:s=sig1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,fomichev.me,gmail.com,verdict.gg];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303339-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[deliran@verdict.gg,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:sdf@fomichev.me,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:deliran@verdict.gg,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[verdict.gg];
	DKIM_TRACE(0.00)[verdict.gg:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[verdict.gg:dkim,verdict.gg:email,verdict.gg:mid,verdict.gg:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA6926E784F

When an XDP program redirects a frame to a cpumap (or any other path
that rebuilds an skb from an xdp_frame via __xdp_build_skb_from_frame()),
the HW RX checksum status is lost and the stack revalidates the L4
checksum in software.

Add a non-dev-bound kfunc, bpf_xdp_assert_rx_csum(), that lets the program
assert the L4 checksum is correct.  It sets XDP_FLAGS_RX_CSUM_UNNECESSARY
on the buffer; the flag rides into the xdp_frame and
__xdp_build_skb_from_frame() turns it into skb->ip_summed =
CHECKSUM_UNNECESSARY.  The kernel cannot verify the assertion, the program
takes responsibility, the same way it is already trusted to rewrite
arbitrary packet contents.

Signed-off-by: Vladimir Vdovin <deliran@verdict.gg>
---
 include/net/xdp.h | 11 +++++++++++
 net/core/xdp.c    | 50 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index aa742f413c35..5a1e2cc9c312 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -81,6 +81,11 @@ enum xdp_buff_flags {
 	 * XDP program is not attached.
 	 */
 	XDP_FLAGS_FRAGS_UNREADABLE	= BIT(2),
+	/* XDP program asserts the L4 checksum is correct, so the skb built
+	 * out of this frame (e.g. on the cpumap redirect path) can be marked
+	 * CHECKSUM_UNNECESSARY instead of being validated in software.
+	 */
+	XDP_FLAGS_RX_CSUM_UNNECESSARY	= BIT(3),
 };
 
 struct xdp_buff {
@@ -316,6 +321,12 @@ xdp_frame_get_skb_flags(const struct xdp_frame *frame)
 	return frame->flags;
 }
 
+static __always_inline bool
+xdp_frame_rx_csum_unnecessary(const struct xdp_frame *frame)
+{
+	return !!(frame->flags & XDP_FLAGS_RX_CSUM_UNNECESSARY);
+}
+
 #define XDP_BULK_QUEUE_SIZE	16
 struct xdp_frame_bulk {
 	int count;
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 9890a30584ba..63ee36ec93de 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -830,8 +830,11 @@ struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 	/* Essential SKB info: protocol and skb->dev */
 	skb->protocol = eth_type_trans(skb, dev);
 
+	/* HW checksum info, if the XDP program asserted it */
+	if (xdp_frame_rx_csum_unnecessary(xdpf))
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+
 	/* Optional SKB info, currently missing:
-	 * - HW checksum info		(skb->ip_summed)
 	 * - HW RX hash			(skb_set_hash)
 	 * - RX ring dev queue index	(skb_record_rx_queue)
 	 */
@@ -961,6 +964,31 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
 	return -EOPNOTSUPP;
 }
 
+/**
+ * bpf_xdp_assert_rx_csum - Assert the packet's L4 checksum is correct.
+ * @ctx: XDP context pointer.
+ *
+ * Mark the frame so that an skb later built out of it (e.g. on the cpumap
+ * redirect path, see __xdp_build_skb_from_frame()) is set to
+ * CHECKSUM_UNNECESSARY instead of being validated in software when it enters
+ * the stack.
+ *
+ * This is an assertion made by the XDP program: the kernel cannot verify it.
+ * The program takes responsibility for the checksum being correct, the same
+ * way it is already trusted to rewrite arbitrary packet contents. If the
+ * program modifies L4 data after calling this kfunc the assertion may no
+ * longer hold.
+ *
+ * Return: 0.
+ */
+__bpf_kfunc int bpf_xdp_assert_rx_csum(struct xdp_md *ctx)
+{
+	struct xdp_buff *xdp = (struct xdp_buff *)ctx;
+
+	xdp->flags |= XDP_FLAGS_RX_CSUM_UNNECESSARY;
+	return 0;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(xdp_metadata_kfunc_ids)
@@ -974,6 +1002,18 @@ static const struct btf_kfunc_id_set xdp_metadata_kfunc_set = {
 	.set   = &xdp_metadata_kfunc_ids,
 };
 
+/* Generic XDP kfuncs that need no driver support and are therefore not
+ * dev-bound (unlike the rx-metadata kfuncs above).
+ */
+BTF_KFUNCS_START(xdp_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_xdp_assert_rx_csum)
+BTF_KFUNCS_END(xdp_kfunc_ids)
+
+static const struct btf_kfunc_id_set xdp_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &xdp_kfunc_ids,
+};
+
 BTF_ID_LIST(xdp_metadata_kfunc_ids_unsorted)
 #define XDP_METADATA_KFUNC(name, _, str, __) BTF_ID(func, str)
 XDP_METADATA_KFUNC_xxx
@@ -992,7 +1032,13 @@ bool bpf_dev_bound_kfunc_id(u32 btf_id)
 
 static int __init xdp_metadata_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &xdp_metadata_kfunc_set);
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &xdp_metadata_kfunc_set);
+	if (ret)
+		return ret;
+
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &xdp_kfunc_set);
 }
 late_initcall(xdp_metadata_init);
 
-- 
2.47.0


