Return-Path: <netdev+bounces-290005-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOf/M2zhDWop4gUAu9opvQ
	(envelope-from <netdev+bounces-290005-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 18:29:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B46592010
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 18:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8E7632C81C4
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE943603F7;
	Wed, 20 May 2026 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r5P7wyPD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C907734AAF2
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779292841; cv=none; b=GBF48cqokk+ZWm+jDxNKwAq5I5DldKHZdZsqHoTpKRAdrQpjeBtF9t5jml3drVp3N7gJ+zYb7hDiq7ufeNtOnIGqUn1PMkALgdGkXR9YxkrLS+iAAO1zD/b6J7UNBXZwINov7GIIgV3JV5y+NOrvNq4s8jVRJg6bl1OZeDv3z/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779292841; c=relaxed/simple;
	bh=EYJENH/E9aIT1O7dcWbTzgwVXLLggCk/JlwRe3Mgr6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L+7eM2ZUxx1QzIgUnM7vNTXQFbCzAU2dpCgdLohspatPEou3FP/ouw+uXEvLNnKiIYtuj8QKVoi8KOFfpjuxwhM1dMaKTOcsD4jzwuUJhV0Wz1xM9iT15OPt6I9ffjD3tx7qcSgr3dQZ3LEhoIGHsR7lLR35T2i841Y2Q14BRQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r5P7wyPD; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3042a388168so74049eec.1
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 09:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779292838; x=1779897638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jZJSUSn4qvTX086pa/Fy4nlh1Sgz6dj9ak0JISPiC70=;
        b=r5P7wyPD6ZOmqH5FIN6WC+P/QqQS/6J+jyST9QbYyJHqMw22PfKiua8mAA+SPgTW0/
         oCXwfS2nPIId7QC4OungYlSzZRL350SHj1hTj77OVnolHHBE+EHEzC+c81M5faW+6KTm
         mfDczGPIZdabk2QxCdIxal5ucqTZjB6O88cXWif1P8H10gcxa1Bi/DxAsTQj/4RMMsi3
         w4TDEab5jFmPWBf8d4qb7PTyCXBEGQSB82fQhK9GVQoam0oTsGKmBqtbEI62KZl2DYkf
         J1djl/Pm7xwj0Ocjbkg4/HGKOH/MecdtivKRMQssQRlGrgmkGoH3BVpbUuGL9QxpUuSC
         JS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779292838; x=1779897638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZJSUSn4qvTX086pa/Fy4nlh1Sgz6dj9ak0JISPiC70=;
        b=JZDlFM1DvWBv61UBRshfQE9/8tmnWb6zLJ4oqr1aRpZ9WAdh9b0USmvT1knsQFusYD
         7SiDJzZAeaeyBpYHUkb8UhkvFit4do9WZ1Pyvllyr8Ua5G6S2f9eVNPrfButEtMNQ42e
         ZfxTqgZ+EYhc0I5/aKFezyqm8KvAHQlhBFSJNi9iOhoD22eeQQVkk5oAKXsAp3JvELtO
         uHemaWXAAejcUsL50/Q0FVdZtBy0lzoeGTIIX9qZsSmF98tz27koaj58seJ7kyLQARzC
         P/cj1dWGwUwBkqtUfnbDCWgbpSuMDWhgvuY/n6l4qhtmZriBsMXJzZpY7MA2phX7w8xK
         J6Ew==
X-Gm-Message-State: AOJu0YyBNoBXd3nL4VypiXx/fXM/mqowLNpshrTpr7iimtzNDP8UFf+B
	aQXgH8B1MpoqR9GIvbdYKx1B6ldZkM0pJ01mNMSLvqyJ8wnWUW8ZXdK59NvD8Nt5
X-Gm-Gg: Acq92OGlgaTrf3kg2j5AGeB31oyQFReYIYevOp8LkRssi/ch9abT622OeaaoFiAFPcV
	5aP5yk7z8YbL9p20y3jityGGo3RRPSRrOxM9pi6/F1OieRG+mdMZ0nPRGwdrikqQ4IW73LPJFyD
	vkHTCLQSPC3PjzRKlMxx+TcIKg87pKzUuxF8mL3dHfZOchMTynN7ccX3qKPOlHH070Jek+ZQzwx
	3v1tXByiL4Fn8uk/FLviM45ZxySl/VIZCZGuc6wKTNeo4GWCdquU3WA6hlQgCRJu6owQt8rnO/Y
	3kC5cDvM+Ja5fDx11lC8jrcLlb8qsVoRdOO6081dCymsLuRWLhBRgBM5Q7sk6MB/6qW59wOX2dD
	u6iUf6uHR5yaSqGNlrF1YopyWhTLD8kbuSdhZUCghksug71qIGlxGPsg40DiqTA3Fg9BLZ0B3mF
	1umUkuBD85e005cBOQWdRdv4mLVVSoCjE8ti86zovzF+aU22DKPOLBOqneMJTDkC2oLrF4bGG/c
	Yb/RMA=
X-Received: by 2002:a05:7300:430d:b0:2d9:db50:c6ce with SMTP id 5a478bee46e88-3042b30f58emr63273eec.3.1779292838345;
        Wed, 20 May 2026 09:00:38 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcb6e9sm23412317eec.16.2026.05.20.09.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 09:00:37 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	dongli.zhang@oracle.com,
	xmei5@asu.edu,
	linux-kernel@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net] tun: free page on short-frame rejection in tun_xdp_one()
Date: Wed, 20 May 2026 09:00:21 -0700
Message-ID: <20260520160020.375349-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,kernel.org,google.com,oracle.com,asu.edu,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290005-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 30B46592010
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tun_xdp_one() returns -EINVAL on a frame shorter than ETH_HLEN without
freeing the page that vhost_net_build_xdp() allocated for it.
tun_sendmsg() discards that -EINVAL and still returns total_len, so
vhost_tx_batch() takes the success path and never frees the page; each
short frame in a batch leaks one page-frag chunk.

A local process that can open /dev/net/tun and /dev/vhost-net can hit
this path: it attaches a tun/tap device as the vhost-net backend and
feeds TX descriptors whose length minus the virtio-net header is below
ETH_HLEN. Each kick leaks the page-frag chunks for that batch, and a
tight submission loop exhausts host memory and triggers an OOM panic.
Free the page before returning -EINVAL, matching the XDP-program error
path in the same function.

Fixes: 049584807f1d ("tun: add missing verification for short frame")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/net/tun.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index b183189f1853..f594360d66d6 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2394,8 +2394,10 @@ static int tun_xdp_one(struct tun_struct *tun,
 	bool skb_xdp = false;
 	struct page *page;
 
-	if (unlikely(datasize < ETH_HLEN))
+	if (unlikely(datasize < ETH_HLEN)) {
+		put_page(virt_to_head_page(xdp->data));
 		return -EINVAL;
+	}
 
 	xdp_prog = rcu_dereference(tun->xdp_prog);
 	if (xdp_prog) {
-- 
2.43.0


