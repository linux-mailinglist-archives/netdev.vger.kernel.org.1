Return-Path: <netdev+bounces-297279-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0qlFEKp7KGpKFQMAu9opvQ
	(envelope-from <netdev+bounces-297279-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 22:46:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB13664210
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 22:46:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=dama-to.20251104.gappssmtp.com header.s=20251104 header.b=bY3Jl71K;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297279-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297279-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B23B305ECE8
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 20:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDA03C10A7;
	Tue,  9 Jun 2026 20:45:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E843749E3
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 20:45:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781037938; cv=none; b=uRrDS3dPxUFkqyd6/V+lGS46kH1ZZbxv6Nhru5+Uv9oK1L3fTTICRPfZIz9d3k2BJG96JhBHGmsy3l6+Y6g0kYls8tmpCwO99waU7C50d/otSwF4JlW+XiUnJnxMQ1hGwXoZ0jux3yzOtI/Hyse0L2H9X295W5ruiO0eDrDEjFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781037938; c=relaxed/simple;
	bh=S1x9x4Ghq2az/KolNp8/QcD1M4y0M34YTVMgXCocxJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dmx/Of9yysdS5pw5sH77BQpz273C+PwRdhMDwRN04cN5t1wxz9QHBPDq0wZxcm1XbKkmC6KW8Z6U4RGbAAduo8LlLE+zPwcHgL53xUqdGnm5vSlGoHJeE9ohapWA8lBHeAaF3+ichTMGEaAbyzvyxt3eeAjJU4d8n9emmutDJgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=bY3Jl71K; arc=none smtp.client-ip=209.85.214.174
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c0c35980fdso60913945ad.2
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 13:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1781037936; x=1781642736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3K1B8gwLWAzRfKm1h5Jy5RNbuV45+npcCR0eQNcT6pI=;
        b=bY3Jl71KzeiSX+qbk/Ej89CmWJtq3qZvVP6F2+KRJ+3HYsjg5uu7W1fYrduqF9650O
         IyJdME7uF2r+s0GBzutwhaMmMu0tDQGg30RzPfcuXofPdkVmSMY0izKdAMWBr3uTbkAV
         xB7/gMyuRBUDNRgNlU9kNkhFqYzLQND7LJ6XErTZxFQBWQIZwBlAioFd2x8MyETXDYPP
         XQkAcVIniyKqxg0ZKN0oiWWostJFUr/79Zn1OOBe9kcMbMYcQGgAwSVt5O9asPq6K3XU
         7pYJLh4a+ypTCaymBJ+JGc3vSUf/c6i9TFvFNEaVuGdrmjIT4as8auWZILvhCdv/IQtF
         LAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781037936; x=1781642736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3K1B8gwLWAzRfKm1h5Jy5RNbuV45+npcCR0eQNcT6pI=;
        b=VK2EMF0h/7vA9Xk8jAbIrscXtW/0aN4KooUtKHRQHOjt3w/o+pNShQwW9PehJ7x0kS
         CQIrPZKcUIJfJxbITNbgZmflxYxFODIVw7f3Hq301H9h58kmpdGMFqnLznx5/ppqFc/L
         FHqb/Y9XIa5OIrwKMI3l+GbkCAZ7tCztUGEF5pcGn7mOU+2tW32uHRPUAmhJoohb7weA
         NH+p60oedZUjMrLEKMoid5f0HXkUGVhpYQ4xanz+8CELiWu7mt/VfA2eP9lnfYDw1VPQ
         X7yr+IxE/uFxMncevHTa4g+g4PdDNa32502jTIdnZvbhNElReTCH7QKN9ULwWB2iRu03
         c/Uw==
X-Gm-Message-State: AOJu0YxriWodDS2u2100erNQf3f4jI+b5c2VON6PwJhqMY9Nadm1EYND
	TY8Ui2E+R+um7aJ9UYZHTuQnCwy6n31vqQideKq0WQFN6rIheXRA82qlTwGUaeeQeGZ+XUxofN7
	osxvEF/I=
X-Gm-Gg: Acq92OF2HF1lUGG4ynzzK/Ma2/rns9+lo4/R9FYf40Gj62BhHYXchVSO9ds6z4NXM0c
	diHLphHkkMJc3wHVVDSPkapWwmSnu31lqVksOUCBHSa0inupiE4IL3RPZ8mcH8xjXM/hULwGNM+
	mtwtrfhFWrsdbwLk8SgdYsvjezMNQ0dllLpSvpcppvtXUKWqIbkYoY6HUJ3jVFg7ftXtdJf9CCn
	7rdUblVU7pOYc3qIjq+Vjs3EPXEJQ1tarNJWlkmsXsF/535fTIfwVh31JW4vIND3Z4fC1Fyjaq0
	PFMJGH0VeOF9iEr3Q8O4Q0LDDcjmApsGgm7FvYP0C74fBMOgV+eUh2OiccBVXur+gytZhxDweLi
	1vrmTXKdqzz3kV/tYU3S4sMTZaSq/lOsTus2QHKxejYcB2oSXyzQb7IQxGRt0UTmbGOb7Q0Lt9y
	5ZuWO3VWkLhOGBPt4=
X-Received: by 2002:a17:903:22c4:b0:2c0:c262:b91f with SMTP id d9443c01a7336-2c1e80e431emr246254985ad.8.1781037935811;
        Tue, 09 Jun 2026 13:45:35 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4a::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d37esm292358325ad.9.2026.06.09.13.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 13:45:35 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Cc: horms@kernel.org,
	Joe Damato <joe@dama.to>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net v2] bnxt: fix head underflow on XDP head-grow
Date: Tue,  9 Jun 2026 13:44:58 -0700
Message-ID: <20260609204458.2237787-2-joe@dama.to>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-297279-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:michael.chan@broadcom.com,m:pavan.chebbi@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:andrew.gospodarek@broadcom.com,m:somnath.kotur@broadcom.com,m:horms@kernel.org,m:joe@dama.to,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,dama.to:email,dama.to:mid,dama.to:from_mime,dama-to.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,xdp.py:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8CB13664210

The xdp.py test test_xdp_native_adjst_head_grow_data crashes when run on
a bnxt machine (and also crashes in NIPA).

It seems that the bug is an underflow in bnxt_rx_multi_page_skb, which
builds the skb head:

  napi_build_skb(data_ptr - bp->rx_offset, rxr->rx_page_size);

The problem with this expression is that in page mode, rx_offset is:

  bp->rx_offset = NET_IP_ALIGN + XDP_PACKET_HEADROOM;

Which evaluates (at least on x86_64) to 258.

The test test_xdp_native_adjst_head_grow_data tests a case where the
head is adjusted by -256.

When this test runs, data_ptr is shifted to frag_start + 2 (where
frag_start = page_address(page) + offset).

Then, bnxt_rx_multi_page_skb is invoked and the napi_build_skb
expression subtracts 258, landing at an address before frag_start. This
could be either the previous fragment or the previous physical page when
the offset is < 256 (e.g. if the fragment started at offset 0).

When the skb is freed, the page pool fragment reference is dropped on
either the wrong page or the wrong frag of the right page. In either
case, the corrupted reference count can lead to the page being
prematurely recycled while still in use. Once (incorrectly) recycled, it
can be handed out again and on driver teardown this would result in a
double free.

The commit under fixes updated this code to handle the case where the
native page size is >= 64k, but it unintentionally broke the head grow
case.

To fix this, add an offset field to struct bnxt_sw_rx_bd, mirroring the
existing offset field in struct bnxt_sw_rx_agg_bd. Populate it on
allocation and preserve it on reuse.

In bnxt_rx_multi_page_skb, use the newly added offset field to compute
the fragment start and pass that to napi_build_skb. Adjust the layout
with skb_reserve.

There are two cases, the non-adjustment case and the adjustment case.

In both cases, the skb is built at page_address(page) + offset to
account for the case where the native page size >= 64K and skb_reserve
is called with data_ptr - (page_address(page) + offset). That
difference equals bp->rx_offset when data_ptr was not moved, or
bp->rx_offset + xdp_adjust when XDP adjusted the head.

Re-running the failing test with this commit applied causes the test to
run successfully to completion.

The other rx_skb_func implementations don't have this issue.

Fixes: f6974b4c2d8e ("bnxt_en: Fix page pool logic for page size >= 64K")
Signed-off-by: Joe Damato <joe@dama.to>
---
 v2:
   - Add offset to bnxt_sw_rx_bd, mirroring bnxt_sw_rx_agg_bd,
     as suggested by Michael Chan, eliminating math and simplifying code
     in bnxt_rx_multi_page_skb
   - Re-ran the xdp.py test to confirm the crash is resolved.

 v1: https://lore.kernel.org/netdev/20260608203129.920104-1-joe@dama.to/

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 10 ++++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 35e1f8f663c7..12e73ffff6c3 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1011,6 +1011,7 @@ int bnxt_alloc_rx_data(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 		mapping += bp->rx_dma_offset;
 		rx_buf->data = page;
 		rx_buf->data_ptr = page_address(page) + offset + bp->rx_offset;
+		rx_buf->offset = offset;
 	} else {
 		u8 *data = __bnxt_alloc_rx_frag(bp, &mapping, rxr, gfp);
 
@@ -1019,6 +1020,7 @@ int bnxt_alloc_rx_data(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 
 		rx_buf->data = data;
 		rx_buf->data_ptr = data + bp->rx_offset;
+		rx_buf->offset = 0;
 	}
 	rx_buf->mapping = mapping;
 
@@ -1040,6 +1042,7 @@ void bnxt_reuse_rx_data(struct bnxt_rx_ring_info *rxr, u16 cons, void *data)
 	prod_rx_buf->data_ptr = cons_rx_buf->data_ptr;
 
 	prod_rx_buf->mapping = cons_rx_buf->mapping;
+	prod_rx_buf->offset = cons_rx_buf->offset;
 
 	prod_bd = &rxr->rx_desc_ring[RX_RING(bp, prod)][RX_IDX(prod)];
 	cons_bd = &rxr->rx_desc_ring[RX_RING(bp, cons)][RX_IDX(cons)];
@@ -1175,8 +1178,11 @@ static struct sk_buff *bnxt_rx_multi_page_skb(struct bnxt *bp,
 	struct page *page = data;
 	u16 prod = rxr->rx_prod;
 	struct sk_buff *skb;
+	void *frag_start;
 	int err;
 
+	frag_start = page_address(page) + rxr->rx_buf_ring[cons].offset;
+
 	err = bnxt_alloc_rx_data(bp, rxr, prod, GFP_ATOMIC);
 	if (unlikely(err)) {
 		bnxt_reuse_rx_data(rxr, cons, data);
@@ -1185,13 +1191,13 @@ static struct sk_buff *bnxt_rx_multi_page_skb(struct bnxt *bp,
 	dma_addr -= bp->rx_dma_offset;
 	dma_sync_single_for_cpu(&bp->pdev->dev, dma_addr, rxr->rx_page_size,
 				bp->rx_dir);
-	skb = napi_build_skb(data_ptr - bp->rx_offset, rxr->rx_page_size);
+	skb = napi_build_skb(frag_start, rxr->rx_page_size);
 	if (!skb) {
 		page_pool_recycle_direct(rxr->page_pool, page);
 		return NULL;
 	}
 	skb_mark_for_recycle(skb);
-	skb_reserve(skb, bp->rx_offset);
+	skb_reserve(skb, data_ptr - (u8 *)frag_start);
 	__skb_put(skb, len);
 
 	return skb;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 61c847b36b9f..a2e75cfb65ab 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -911,6 +911,7 @@ struct bnxt_sw_rx_bd {
 	void			*data;
 	u8			*data_ptr;
 	dma_addr_t		mapping;
+	unsigned int		offset;
 };
 
 struct bnxt_sw_rx_agg_bd {

base-commit: 0aa05daef7848a5ac11158949dc73cd741995dc1
-- 
2.53.0-Meta


