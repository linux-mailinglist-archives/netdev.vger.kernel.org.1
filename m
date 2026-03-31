Return-Path: <netdev+bounces-273483-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONQ2CEBvy2k3HwYAu9opvQ
	(envelope-from <netdev+bounces-273483-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 08:52:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DB5364A4F
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 08:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A801F304D72F
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 06:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFFA3A8745;
	Tue, 31 Mar 2026 06:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WasN3rxf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f98.google.com (mail-ot1-f98.google.com [209.85.210.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93E43AEF33
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 06:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774939933; cv=none; b=VAvGNUmBH7iLKhXjAfgxeExp8W9bvoQDn52cks6czh+QzeaJxLXQV/nqX+B5yjpsLFd/JtNKxWpeguz/lpo5LwcJM4TU+wrcMUxOSg0pqC3fFMKMw/0Q2dr7b2iEeAWtnSBarCMzfhIBjJ+wOu/Feahi5eUXG3H+MKxZWMOb8Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774939933; c=relaxed/simple;
	bh=6h3RQl1N0ls7ne7sS0ca7b4u2DIIQxEwCtae+80I4Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L24CqgA8RksNEumZ1FwlW3OQbj1Mrs0eMnS8ECZWgNMqRHUYusN485e30E1IfMPNMP4h8S8zyX/wSqrBB/+XN1BkvN8fzA4sjWbL0C7q8vRcstl5OcnAp2EED41sv4WIsxsoHfk792+osDDzoGU6IvlWLCsRyz+Ynkr7niPMaFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WasN3rxf; arc=none smtp.client-ip=209.85.210.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f98.google.com with SMTP id 46e09a7af769-7d7c77fd31cso4945224a34.3
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 23:52:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774939931; x=1775544731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t+YCj2z6zp5L7edhP+bYVDCcOWvA/a85ZAtpIM2LMu4=;
        b=hUg1oVZMje85T3ftTdP3+/qB7IFRy/KIWIE3Xjup3B7GUV34qiAxTwYa3tMPXXbvUc
         utjLi+kyDhEj1sUWbsk5mwE+29WstSwtO59bgbshD3NPZXGskt7oDWR+0Y/FdPFXck//
         HYnSSUkt3F5HVFXwFOdcHhvIsc/lKSkaFX3+uuu1sOjCAVxzob2sdir7vul4+Ys6umF7
         PEXaI26C64lraNi9v2vhy8KxIVIMQFesJ4g5yppVGkRT+nIDYZ5wV+zNeNf7XovqIJEd
         SddeKAw0CI9JFPtctm2yiPuNtvobNlKxwXFzGJpY1nj36H7jIX/JI8c3SRdItZFgBzyO
         UfQQ==
X-Gm-Message-State: AOJu0YwxNW9bm+yaV/zmb14A53QSCsSyLnjSiGwBn5F/RMyTRiP20Uro
	KDEtz3ak7nAsPgq+voDxXgVfbQ8zccLqNjvxT9IQPeqghN45ik+/JYn1bZt7dyIQAToNSK+DckI
	Z4D0YB1OloGnxTj1idCjLch0XEJRdqHY8ShohAAnghRRo+JE2gMjMs8hr2Lb2yIEs7H6JMQYrQB
	DYeZ9ef20x2iOwy7O8drjT2ODB+1iryovxQ22I+DsHkwixhpNKRFB9HxZ7x7uShXmoIqnJbZvrD
	DyMx1W9vFo=
X-Gm-Gg: ATEYQzx52PKvH3J1eBClNV0aHKQn5+2vNg8jdLG6rFeVJpbSqGMq/jYWjLkeH7LThOr
	3rZ/QoST2i4zAxa+p2Mv3hXMjI3nhT++KXXlxmqvxmPKz1BSIOK4CmlJ/NVI8idT9+ywGAdJuDA
	0XjzEQrj/su6vUQm9BQT3e5Zr/85AaSUntyFYJz9Hib99WDeD2SbE+ASOGc+03xt5p7Zmmpr3LN
	zRWM+e8orxipmGdKMfdHA26G1FBd0trq0hk7irMK307Wu3BD5WjflufAwvpHR2h7TP9tRLWJsDR
	UujWuBobglUse+tFDNgPLe5sZR32MzkYrVJDGDwM+xE7OvVBUoMwUQLrQRGezdYuYkh922BpJr4
	fRVOET2NBGQbVXIbgZ0qO6w+Oqou74HSVaRLi1pXVGmOxLmB9XY27MnbiSCeNyJ/Mu6w0j52bNb
	uolAFLXoRtNZXIPLo8afX7SP7GFxHp6Wt2EStSKHwD3qoC/gpIybTQEFR4
X-Received: by 2002:a05:6830:7009:b0:7d7:e709:3a7f with SMTP id 46e09a7af769-7d9fae7aff2mr10140444a34.23.1774939930756;
        Mon, 30 Mar 2026 23:52:10 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7da0a76e612sm2137661a34.4.2026.03.30.23.52.10
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Mar 2026 23:52:10 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-89ce5eec0f0so89582126d6.3
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 23:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774939929; x=1775544729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+YCj2z6zp5L7edhP+bYVDCcOWvA/a85ZAtpIM2LMu4=;
        b=WasN3rxf/2Zxjt14/JMoPqq8/BHJ72I/vbuW7OBt2gM03HiDZd3d28bOsE/SpIY2iZ
         xJ/AfGLRtMFOdQ6f72exmw8U4LTnfLGos4YzMgsZoiPq/ydDs6Izv4+DvLGudbOhszV+
         y3sUW+cLDGQqKZbUPmXsXm1l8tMpahbe/Rdck=
X-Received: by 2002:a05:6214:4a02:b0:899:ecd8:d266 with SMTP id 6a1803df08f44-89ce8da18d9mr228781836d6.20.1774939929511;
        Mon, 30 Mar 2026 23:52:09 -0700 (PDT)
X-Received: by 2002:a05:6214:4a02:b0:899:ecd8:d266 with SMTP id 6a1803df08f44-89ce8da18d9mr228781606d6.20.1774939929023;
        Mon, 30 Mar 2026 23:52:09 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89ecbda4d50sm80543966d6.15.2026.03.30.23.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 23:52:08 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net v2 2/3] bnxt_en: Don't assume XDP is never enabled in bnxt_init_dflt_ring_mode()
Date: Mon, 30 Mar 2026 23:51:37 -0700
Message-ID: <20260331065138.948205-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260331065138.948205-1-michael.chan@broadcom.com>
References: <20260331065138.948205-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273483-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 93DB5364A4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The original code made the assumption that when we set up the initial
default ring mode, we must be just loading the driver and XDP cannot
be enabled yet.  This is not true when the FW goes through a resource
or capability change.  Resource reservations will be cancelled and
reinitialized with XDP already enabled.  devlink reload with XDP enabled
will also have the same issue.  This scenario will cause the ring
arithmetic to be all wrong in the bnxt_init_dflt_ring_mode() path
causing failure:

bnxt_en 0000:a1:00.0 ens2f0np0: bnxt_setup_int_mode err: ffffffea
bnxt_en 0000:a1:00.0 ens2f0np0: bnxt_request_irq err: ffffffea
bnxt_en 0000:a1:00.0 ens2f0np0: nic open fail (rc: ffffffea)

Fix it by properly accounting for XDP in the bnxt_init_dflt_ring_mode()
path by using the refactored helper functions in the previous patch.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Fixes: ec5d31e3c15d ("bnxt_en: Handle firmware reset status during IF_UP.")
Fixes: 228ea8c187d8 ("bnxt_en: implement devlink dev reload driver_reinit")
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v2: Fix commit ID of a Fixes tag

v1: https://lore.kernel.org/netdev/20260329232528.870637-3-michael.chan@broadcom.com/
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 173f962fc2ab..f11f3a704da5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -16547,6 +16547,10 @@ static void bnxt_adj_dflt_rings(struct bnxt *bp, bool sh)
 	else
 		bp->cp_nr_rings = bp->tx_nr_rings_per_tc + bp->rx_nr_rings;
 	bp->tx_nr_rings = bnxt_tx_nr_rings(bp);
+	if (sh && READ_ONCE(bp->xdp_prog)) {
+		bnxt_set_xdp_tx_rings(bp);
+		bnxt_set_cp_rings(bp, true);
+	}
 }
 
 static int bnxt_set_dflt_rings(struct bnxt *bp, bool sh)
@@ -16588,16 +16592,17 @@ static int bnxt_set_dflt_rings(struct bnxt *bp, bool sh)
 	rc = __bnxt_reserve_rings(bp);
 	if (rc && rc != -ENODEV)
 		netdev_warn(bp->dev, "Unable to reserve tx rings\n");
-	bp->tx_nr_rings_per_tc = bnxt_tx_nr_rings_per_tc(bp);
+
+	bnxt_adj_tx_rings(bp);
 	if (sh)
-		bnxt_trim_dflt_sh_rings(bp);
+		bnxt_adj_dflt_rings(bp, true);
 
 	/* Rings may have been trimmed, re-reserve the trimmed rings. */
 	if (bnxt_need_reserve_rings(bp)) {
 		rc = __bnxt_reserve_rings(bp);
 		if (rc && rc != -ENODEV)
 			netdev_warn(bp->dev, "2nd rings reservation failed.\n");
-		bp->tx_nr_rings_per_tc = bnxt_tx_nr_rings_per_tc(bp);
+		bnxt_adj_tx_rings(bp);
 	}
 	if (BNXT_CHIP_TYPE_NITRO_A0(bp)) {
 		bp->rx_nr_rings++;
@@ -16631,7 +16636,7 @@ static int bnxt_init_dflt_ring_mode(struct bnxt *bp)
 	if (rc)
 		goto init_dflt_ring_err;
 
-	bp->tx_nr_rings_per_tc = bnxt_tx_nr_rings_per_tc(bp);
+	bnxt_adj_tx_rings(bp);
 
 	bnxt_set_dflt_rfs(bp);
 
-- 
2.51.0


