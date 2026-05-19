Return-Path: <netdev+bounces-289390-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aK0TJ09KDGoMdAUAu9opvQ
	(envelope-from <netdev+bounces-289390-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:32:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCE657DAC8
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 929C8304E6EE
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0E13AA4EF;
	Tue, 19 May 2026 10:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FvqqLj/f"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D653A9D89
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 10:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186142; cv=none; b=tFVd7+3oiAe7PINZxe4O0sFRL1FHcnQL8/wAuZ+5LrjjZdFRKtjxUAeqlqfCByBav7epTpiMCaC3zyy12a7t7nmzkFODwXKWiZHtgfkHIyXzMkltvnE8jNGi3AqNEOTgb2FSpxVh8EKyP0SM8aOv3+e6u/CGzPiqIUPzHyxiyQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186142; c=relaxed/simple;
	bh=81z9I5hTk0GkEethM3pXIgRu18Sm5rwYvQwLj7nqAak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0f9/HxgBBEtRm0Dqpb61A1144so2DHYGBhvAPScgMnZo4bE2P0ZHAXV7gENTT7LXwhrCIpre8kZ6edW8vSBdwus6VQMOLVklPWalYhpQ19hWM2GzTnj+M2WYvvWLtdhoA+HvfE92Qhn83dAhKxiqUWtpGzuQd1kko0sHUhXWE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FvqqLj/f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779186137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n/vlkD/23OmrAj2LzzqI9Nh1utpeYvDExMI4wj2//ls=;
	b=FvqqLj/f+WaRoriQpRDLlENwU6seC172piIDYe+Xx/Xt+X2RrIYRx2rKasy9+Of06TINho
	//91496NrOwVGZobY468mCNYV2CXU6T8krCy5/uLw16JIXjsTuIC1T0f40VcQ6zLpXCyH2
	pYkdQwXnd85n5EjmE4W42J10pToc7Ak=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-hgdWFDm0PLeawxqS8hdJcw-1; Tue,
 19 May 2026 06:22:14 -0400
X-MC-Unique: hgdWFDm0PLeawxqS8hdJcw-1
X-Mimecast-MFC-AGG-ID: hgdWFDm0PLeawxqS8hdJcw_1779186132
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1E0619560AA;
	Tue, 19 May 2026 10:22:11 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.33])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 218261800352;
	Tue, 19 May 2026 10:22:05 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Stefan Metzmacher <metze@samba.org>,
	Mina Almasry <almasrymina@google.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [RFC PATCH 01/36] net: Perform special handling for a splice from a bvecq
Date: Tue, 19 May 2026 11:21:19 +0100
Message-ID: <20260519102158.592165-2-dhowells@redhat.com>
In-Reply-To: <20260519102158.592165-1-dhowells@redhat.com>
References: <20260519102158.592165-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [8.84 / 15.00];
	URIBL_BLACK(7.50)[talpey.com:email];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	GREYLIST(0.00)[pass,body];
	TAGGED_FROM(0.00)[bounces-289390-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[redhat.com:s=mimecast20190719];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,manguebit.org:email,linux.dev:email,talpey.com:email,samba.org:email]
X-Rspamd-Queue-Id: 3CCE657DAC8
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

In skb_splice_from_iter() used for MSG_SPLICE_PAGES, if it sees that it is
given a bvecq-based iterator, walk the bvecq directly rather than calling
iov_iter_extract_pages() to extract into a separate table.

Note that the bvecq chain carries information about whether a page can be
get_page'd or whether it has to be pinned (GUP), though the sk_buff can't
currently make use of this information.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Eric Dumazet <edumazet@google.com>
cc: Neal Cardwell <ncardwell@google.com>
cc: Kuniyuki Iwashima <kuniyu@google.com>
cc: Mina Almasry <almasrymina@google.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: netdev@vger.kernel.org
---
 net/core/skbuff.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 7dad68e3b518..127c300ab938 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7295,6 +7295,122 @@ nodefer:	kfree_skb_napi_cache(skb);
 		kick_defer_list_purge(cpu);
 }
 
+static __always_inline
+size_t iterate_one_bvec(struct bio_vec *p, size_t skip, size_t len,
+			void *priv, void *priv2, iov_step_f step)
+{
+#ifdef CONFIG_HIGHMEM
+	size_t progress = 0;
+
+	if (skip >= p->bv_len)
+		return 0;
+
+	len = umin(len, p->bv_len - skip);
+	while (len > 0) {
+		size_t remain, consumed;
+		size_t offset = p->bv_offset + skip, part;
+		void *kaddr = kmap_local_bvec(p, skip);
+
+		part = umin(len, PAGE_SIZE - offset % PAGE_SIZE);
+		remain = step(kaddr, progress, part, priv, priv2);
+		kunmap_local(kaddr);
+
+		consumed = part - remain;
+		len -= consumed;
+		progress += consumed;
+		skip += consumed;
+		if (remain)
+			break;
+	}
+
+	return progress;
+#else
+	return len - step(bvec_virt(p) + skip, 0, len, priv, priv2);
+#endif
+}
+
+static __always_inline
+size_t csum_one(void *iter_from, size_t progress,
+		size_t len, void *priv, void *priv2)
+{
+	__wsum *csum = priv;
+
+	*csum = csum_partial(iter_from, len, *csum);
+	return 0;
+}
+
+static void skb_splice_csum_bv(struct sk_buff *skb, struct bio_vec *bv,
+			       size_t skip, size_t len)
+{
+	__wsum csum = 0;
+
+	size_t did = iterate_one_bvec(bv, skip, len, &csum, NULL, csum_one);
+
+	WARN_ON_ONCE(did != len);
+	skb->csum = csum_block_add(skb->csum, csum, len);
+}
+
+/*
+ * Splice from a bvecq iterator to an skbuff.
+ */
+static size_t skb_splice_from_bvecq(struct sk_buff *skb, struct iov_iter *iter,
+				    size_t len)
+{
+	const struct bvecq *bq = iter->bvecq;
+	unsigned int slot = iter->bvecq_slot;
+	size_t frag_limit = READ_ONCE(net_hotdata.sysctl_max_skb_frags);
+	size_t spliced = 0, skip = iter->iov_offset;
+
+	len = umin(len, iter->count);
+	if (!len)
+		return 0;
+	if (slot == bq->nr_slots) {
+		/* The iterator may have been extended. */
+		bq = bq->next;
+		slot = 0;
+	}
+
+	do {
+		struct bio_vec *bvec = &bq->bv[slot];
+
+		if (skip < bvec->bv_len) {
+			size_t part = umin(bvec->bv_len - skip, len);
+			size_t off = bvec->bv_offset + skip;
+			int ret = -EIO;
+
+			if (WARN_ON_ONCE(!sendpage_ok(bvec->bv_page)))
+				break;
+
+			ret = skb_append_pagefrags(skb, bvec->bv_page, off, part,
+						   frag_limit);
+			if (ret < 0)
+				return ret;
+
+			if (skb->ip_summed == CHECKSUM_NONE)
+				skb_splice_csum_bv(skb, bvec, off, part);
+
+			len -= part;
+			spliced += part;
+			skip += part;
+		}
+		if (skip >= bvec->bv_len) {
+			skip = 0;
+			slot++;
+			if (slot >= bq->nr_slots && bq->next) {
+				bq = bq->next;
+				slot = 0;
+			}
+		}
+	} while (len);
+
+	iter->bvecq_slot = slot;
+	iter->bvecq = bq;
+	iter->iov_offset = skip;
+	iter->count -= spliced;
+	skb_len_add(skb, spliced);
+	return spliced;
+}
+
 static void skb_splice_csum_page(struct sk_buff *skb, struct page *page,
 				 size_t offset, size_t len)
 {
@@ -7329,6 +7445,9 @@ ssize_t skb_splice_from_iter(struct sk_buff *skb, struct iov_iter *iter,
 	ssize_t spliced = 0, ret = 0;
 	unsigned int i;
 
+	if (iov_iter_is_bvecq(iter))
+		return skb_splice_from_bvecq(skb, iter, maxsize);
+
 	while (iter->count > 0) {
 		ssize_t space, nr, len;
 		size_t off;


