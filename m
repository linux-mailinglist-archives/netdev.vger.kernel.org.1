Return-Path: <netdev+bounces-296714-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JfjgMjUnJ2rNsgIAu9opvQ
	(envelope-from <netdev+bounces-296714-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 22:33:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D1065A77B
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 22:33:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=dama-to.20251104.gappssmtp.com header.s=20251104 header.b=UPhOH13r;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296714-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296714-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB60130780F8
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 20:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACE639989C;
	Mon,  8 Jun 2026 20:31:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F32D33554F
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 20:31:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780950696; cv=none; b=TRrFcpgUj8naQy75K25MZNSQbbbUEjrtxucWnB47Rb1JxWn6YSt982UbkM4kQ/ZruVEqdJjtWdNeO1KNRhttu4ih+BYLAnGdm7Y1F3W5xHu4aleh+ZvjUrI9dPIYL7HNeZpmwC5khtSLqsRcIDdV75TYaOQXL/vScs5a9mLuIBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780950696; c=relaxed/simple;
	bh=g+hB/yLQ6vKKkVlN8bF6XCd8McWiw35mowG9ThCTB7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X60Wr1Udduwg2090u/BcBxuI5tPOOOVYMsam0mRAf4Eiec4swqJqEFcCGgaWnkI3/YDLHYeA+bTzhGUQLhU2t88auomQBsecFTNT5YUwOr+Cp+i1iHq9F+fV6idyL9UiSeDu+l/o3Fzj/4gKJd4ornmsrySoxf0XIv3LpquRGFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=UPhOH13r; arc=none smtp.client-ip=209.85.215.174
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c8585c51f1fso2355377a12.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 13:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1780950694; x=1781555494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gwfi1hNRVN18tx6MvutAXdjRReqdu40MZi3rUahoZ8o=;
        b=UPhOH13r6lLqSx6YrNSgIY1lhaFxRo7ZrVw9xzxUrna1VUg0TyYdTdzG55X1doURsM
         YrWs1reysVtG0FpYGb1MRokQauO/DRlVh2ut2R7EoO4HMaeNwmG7tHQxCgW2d3pA1O8F
         GVIw7ZCuPLMKhcA4g9pplMsXljeuv6Hrc6UecfpJFBkrCcFIBo1Vz6TFGSHGbVz9lLW5
         6t4oBbzIOkq2hWE7tNJk5R0O1i60EFD0hitC3b9ikj0BhXzqjLuOHsM7woR/4n2Zi9/d
         WZFLIV1oExHYuQVYY5zuDeN4/QjI9wIxLltnD+J6IyRaj7nZyjyd+CM3dQ01GkkST81v
         UMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780950694; x=1781555494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwfi1hNRVN18tx6MvutAXdjRReqdu40MZi3rUahoZ8o=;
        b=HihMWng+klzL4xCJGTXn+nyVN02vXbI7FuCtEgZlDMfEGKSIxSoShtnDd3VkaWUnCB
         +Okc7xCdcz0kY+j5ZmQm+vQhOMOVWkRqX+OqCLvC814JtjHRjvfs6xJn0AXSRitq2JGf
         VKqiJcKSo6zOkTOQBT+/I510B4RjilJtjXxnlSFVSqeTQYRYlcDmpbltUbWqW0U+3iEf
         MO/XBnA7GVJ80JIK/LbP+4UFktYEyA9BbGGzL0XPahhakiMq9vtmvE76cErEEOtkV2Qh
         DL/0F243wkKbMuNXraGDMkAn4/QH8XIBkK1kwc6TRNT+tcUBblLtTMjFOzjFdTTg47EL
         JJ5g==
X-Gm-Message-State: AOJu0YzZdaYeAdSf1mhlMxfFJI9WiKq0xNTSCYpO81UkluFZ7DgXB7VH
	T4kEfBAm+TPfL6Srw/ZmcVtMOWWySZ4XeECaEtVJCIuXMnJWgh7i8+htAaE/6eaiYw+BYXrYeA6
	pQIX2wgw=
X-Gm-Gg: Acq92OH5nA7lGdYf4DxIzSHNa7jLYO44eL2qkJsrtl5i/BuexfohQHZSepoxftKw81N
	25JhbJQHXwvlP4EPVodANALEFnGRnZ/hWh+bvafR/Y8MDieZXXZJZ/GB8Gy77eKGfFwIwMGpwMN
	6/iQUDc1bSdLQqOx1l6A9/74/uQ7BMju98VBW3D+F2YP5RLk2GI8Qh9A+guk6n5JQnGY9VcVZwL
	g6zX9muzlgydV6zRE68Z32sl2vSj8zvMFfUJH76OTtn9478Shaw925zKIAkX7hjNwO2oXlIvDX5
	PfwJzvmNbx9oGTcxAlGFu+0zQnPW3ZkcdzqZmoMzon4aFbC8R1+AqPCsNGjMPVd5CFb9v0n7h+6
	p5pZ2qpbR2dX971FiCveXl356ErNpTHnVpqUhDwoQ2sNUngoef0a6d9umJ0Z+q/yOpV9PBifyu2
	lFZSV85G7lXvQy0nKL9QZwQfbG
X-Received: by 2002:a17:902:e5ca:b0:2c0:fa52:1c47 with SMTP id d9443c01a7336-2c1ec906ca3mr146009545ad.25.1780950693780;
        Mon, 08 Jun 2026 13:31:33 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:e::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f8429fsm235533945ad.18.2026.06.08.13.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 13:31:33 -0700 (PDT)
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
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Cc: horms@kernel.org,
	Joe Damato <joe@dama.to>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net] bnxt: fix head underflow on XDP head-grow
Date: Mon,  8 Jun 2026 13:31:28 -0700
Message-ID: <20260608203129.920104-1-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-296714-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:michael.chan@broadcom.com,m:pavan.chebbi@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:somnath.kotur@broadcom.com,m:andrew.gospodarek@broadcom.com,m:horms@kernel.org,m:joe@dama.to,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,dama-to.20251104.gappssmtp.com:dkim,dama.to:email,dama.to:mid,dama.to:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 88D1065A77B

The xdp.py test test_xdp_native_adjst_head_grow_data crashes when run on
a bnxt machine (and also crashes in NIPA).

It seems that the bug is an underflow in bnxt_rx_multi_page_skb, which
builds the skb head:

  napi_build_skb(data_ptr - bp->rx_offset, rxr->rx_page_size);

The problem with this expression is that in page mode rx_offset is:

  bp->rx_offset = NET_IP_ALIGN + XDP_PACKET_HEADROOM;

Which evaluates (at least on x86_64) to 258.

The test test_xdp_native_adjst_head_grow_data tests a case where the
head is adjusted by -256.

When this test runs, data_ptr is shifted to frag_start + 2 (where
frag_start = page_address(page) + offset).

Then, bnxt_rx_multi_page_skb is invoked and the napi_build_skb
expression subtracts 258, landing at an address before frag_start. This
could be either the previous fragment or the previous physical page when
the frag_offset is < 256 (e.g. if the fragment started at offset 0).

When the skb is freed, the page pool fragment reference is dropped on
either the wrong page or the wrong frag of the right page. In either
case, the corrupted reference count can lead to the page being
prematurely recycled while still in use. Once (incorrectly) recycled, it
can be handed out again and on driver teardown this would result in a
double free.

The commit under fixes updated this code to handle the case where the
native page size is >= 64k, but it unintentionally broke the head grow
case.

To fix this, we need to do a bit of math to recover the offset if this
is a page fragment since it is not passed into rx_skb_func
(bnxt_rx_multi_page_skb, in this case).

Once the offset is recovered, build the skb at the start of the fragment
and then use skb_reserve to adjust the layout.

There are two cases, the non-adjustment case and the adjustment case.

In both cases, the skb is built at page_address(page) + frag_offset to
account for the case where the native page size >= 64K and skb_reserve
is called with data_ptr - (page_address(page) + frag_offset). That
difference equals bp->rx_offset when data_ptr was not moved, or
bp->rx_offset + xdp_adjust when XDP adjusted the head.

Re-running the failing test with this commit applied causes the test to
run successfully to completion.

The other rx_skb_func implementations don't have this issue.

Fixes: f6974b4c2d8e ("bnxt_en: Fix page pool logic for page size >= 64K")
Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 35e1f8f663c7..448609cc1617 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1174,7 +1174,9 @@ static struct sk_buff *bnxt_rx_multi_page_skb(struct bnxt *bp,
 	unsigned int len = offset_and_len & 0xffff;
 	struct page *page = data;
 	u16 prod = rxr->rx_prod;
+	unsigned int frag_off;
 	struct sk_buff *skb;
+	void *frag_start;
 	int err;
 
 	err = bnxt_alloc_rx_data(bp, rxr, prod, GFP_ATOMIC);
@@ -1185,13 +1187,15 @@ static struct sk_buff *bnxt_rx_multi_page_skb(struct bnxt *bp,
 	dma_addr -= bp->rx_dma_offset;
 	dma_sync_single_for_cpu(&bp->pdev->dev, dma_addr, rxr->rx_page_size,
 				bp->rx_dir);
-	skb = napi_build_skb(data_ptr - bp->rx_offset, rxr->rx_page_size);
+	frag_off = dma_addr - page_pool_get_dma_addr(page);
+	frag_start = page_address(page) + frag_off;
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

base-commit: 9772589b57e44aedc240211c5c3f7a684a034d3a
-- 
2.53.0-Meta


