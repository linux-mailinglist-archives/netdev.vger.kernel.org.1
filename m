Return-Path: <netdev+bounces-257472-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEaDCLV8hWlQCQQAu9opvQ
	(envelope-from <netdev+bounces-257472-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 06:31:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D54BFA5B9
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 06:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A93F30276B3
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 05:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC38327204;
	Fri,  6 Feb 2026 05:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eqiqHE2u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CFB288C08
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 05:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770355853; cv=none; b=q6Gu19Z+h7bMLruxqj9pYncyz2je0lNbICJ/AyHPPmo4nJHhIXFMttctmQFD7A6yz9CD0473wBvihlDmt7dBSaFaZ0HRHQIH0uoBV0vgmJC1A5NfBE+ioLqqEOhX7UJny5+KS/fN3WszpmbA8tpVz/NjJc9FqJNfpazApqx5whA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770355853; c=relaxed/simple;
	bh=/f78JPPOX6javyZRThC7ZF2Z5atogSF9CGyesS3/qYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=haPr7OqYjx4DIz5DCa9XoNKZugC0UqIkY32EqE5FNrbWCsiECD88L/apVHeft6uFrjyoQUbJ/f3Q0FUbIZmTCszaYl6eAhTXRFKiEOEMJp1L7lOix+969CfC57HTdSxnBzBcCwpcsq8X0149Sn0KfwdX7zHrsCgrvjOleLiBlPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eqiqHE2u; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-89461ccc46eso5389256d6.2
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 21:30:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770355853; x=1770960653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pN45g4kRUVrmjUV0gV9PNhxI0auS5Q/eGFieZxaPaH8=;
        b=fRPCh+zrE+5reVVP/kG4Bs1b97JPKgNXTR7JrubnrCilSzuLxweERnTEmFJ1Upl0ED
         +vc594k+5+wGO0hE8SlN6cCBCxYLHcnOt+Fyldf4iQOCCD9dK/gFmNRkAAIlMZXyyQAw
         LbwUZxjDny76szUp3rRo7HWH5ihMNgWMPNYVPXXUZbrOQnxLCWppFOWrUrlg7j9uJwwj
         6VcEx0ao0lQyf2jk567gEOWfqgY6tjkEZOskc7Nv8pmpkbaljX6URDgDE3YsrQbBMRIp
         ts/mvw9uMPzuM9yPX/LDOKtXAnL+1YlPno8mveYFBtND5j8r4CWyl0SoH95nAsRtOQBr
         wbog==
X-Gm-Message-State: AOJu0YwwvH9gvER00ecXjbfoiPjeOB0KNrcZe3ujOyw0pnaBmL5dEgJ6
	xk2ZbAHyeO3C5PzF90lP0Fr7o5uGSfty1aMjTWEsX4zZnwOEmVBe0zX49gL657JeGon+fQ8R0k3
	Cp76xBgvkCJ+mrR00VvnAIA2TFNJu7zBy3jSt2o5o2o15yBgOjutcExlSY4DhwJ36jvRGWeR/d+
	JQgNwUYzZ6t7VwDyEgJaMElTtQku/RgMitgdmFghB1n/dA7OnwI+qYsqFEXO75AJAgSNxGuZ4wf
	Bfsq62uw4c=
X-Gm-Gg: AZuq6aK3a0QqaT+Ky/Q2Ck5/cwbr6AMJFqGwo3Du7NneIhMO93UFOsbuR6i4CGoIYBy
	SlmsG0Y6ob6gFg32KxuHiAUiI/iOSk1ZaisWrXW0ZKZsI5FHi+sK1cKayo5cOLZevxfsFR+WmBr
	Bs0P1SCayeD22NIPbGA+DSYGh4W4IQ8WQwlglCe7UqZrs9joIwLNRkrCZWBONljlRqR275LfhBx
	QVG0NBUS8LG51zUxvpQNmpMdvO5R+GonmJxkPjsxuox0AZqxAyVp+YdGw+RelQ+GlGtac8zfuiR
	GXoBmAoUrYlZHvu2aHCzHHgIoIyHdSWoP+qEHhcxUlSGmfW3XriAYyPA37EjIWfNhLFWnog2dMX
	a0gKLGUd68e4pr5leiJc6l3aNun4WK3vT11dXNRH4Bozy3jn4cZgMrclRwkijJqTjASG65kdxIT
	2GZgcRjFdjz6V/mKY+YcrkpBmE6c2yUbkdBUG6ZtGcqhtBT1c=
X-Received: by 2002:a05:6214:2506:b0:894:72a9:68ee with SMTP id 6a1803df08f44-8953c7c2722mr25336886d6.11.1770355852645;
        Thu, 05 Feb 2026 21:30:52 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8953bf157acsm2364896d6.1.2026.02.05.21.30.52
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Feb 2026 21:30:52 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7cfd12d8245so531128a34.1
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 21:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770355852; x=1770960652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pN45g4kRUVrmjUV0gV9PNhxI0auS5Q/eGFieZxaPaH8=;
        b=eqiqHE2uqToMq4CZyDdEDx9kWVS0AN6T2fqr6FufG+pcTIGWgJzeSSHuMlciVx0unK
         Kul1Mv1dKg/hidjZ+rjNAhjo2qaYYueYhE6TQ3FJJkBY4EFpDMCu4xS5n3OLfZuZMDUW
         RHY/nuh8EWBT92f73umxB/ZMMQnMD2Y+w8sj0=
X-Received: by 2002:a05:6830:440d:b0:7cf:dbb4:320e with SMTP id 46e09a7af769-7d46447f6a1mr857803a34.18.1770355851687;
        Thu, 05 Feb 2026 21:30:51 -0800 (PST)
X-Received: by 2002:a05:6830:440d:b0:7cf:dbb4:320e with SMTP id 46e09a7af769-7d46447f6a1mr857793a34.18.1770355851337;
        Thu, 05 Feb 2026 21:30:51 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4647aa6cbsm903529a34.26.2026.02.05.21.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 21:30:50 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net v2 3/4] bnxt_en: Fix deleting of Ntuple filters
Date: Thu,  5 Feb 2026 21:29:29 -0800
Message-ID: <20260206052930.1882740-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260206052930.1882740-1-michael.chan@broadcom.com>
References: <20260206052930.1882740-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257472-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:dkim,broadcom.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7D54BFA5B9
X-Rspamd-Action: no action

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

Ntuple filters can be deleted when the interface
is down. The current code blindly sends the filter
delete command to FW. When the interface is down, all
the VNICs are deleted in the FW. When the VNIC is
freed in the FW, all the associated filters are also
freed. We need not send the free command explicitly.
Sending such command will generate FW error in the
dmesg.

In order to fix this, save a pointer to the corresponding
VNIC of an Ntuple filter in the ntuple filter's base
structure. Use this pointer to check if the VNIC is
already freed whenever we are freeing the Ntuple filters.
Now that we have access to the vnic itself, remove the
redundant reference to fw_vnic_id from all places.

Fixes: 8336a974f37d ("bnxt_en: Save user configured filters in a lookup list")
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 14 ++++++++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h         |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  7 +++----
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6fae0490bc1c..6ec173a25332 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6156,6 +6156,7 @@ int bnxt_hwrm_l2_filter_alloc(struct bnxt *bp, struct bnxt_l2_filter *fltr)
 {
 	struct hwrm_cfa_l2_filter_alloc_output *resp;
 	struct hwrm_cfa_l2_filter_alloc_input *req;
+	u16 dst_id = INVALID_HW_RING_ID;
 	u16 target_id = 0xffff;
 	int rc;
 
@@ -6177,7 +6178,10 @@ int bnxt_hwrm_l2_filter_alloc(struct bnxt *bp, struct bnxt_l2_filter *fltr)
 	if (!BNXT_CHIP_TYPE_NITRO_A0(bp))
 		req->flags |=
 			cpu_to_le32(CFA_L2_FILTER_ALLOC_REQ_FLAGS_OUTERMOST);
-	req->dst_id = cpu_to_le16(fltr->base.fw_vnic_id);
+
+	if (fltr->base.vnic)
+		dst_id = fltr->base.vnic->fw_vnic_id;
+	req->dst_id = cpu_to_le16(dst_id);
 	req->enables =
 		cpu_to_le32(CFA_L2_FILTER_ALLOC_REQ_ENABLES_L2_ADDR |
 			    CFA_L2_FILTER_ALLOC_REQ_ENABLES_DST_ID |
@@ -6212,6 +6216,9 @@ int bnxt_hwrm_cfa_ntuple_filter_free(struct bnxt *bp,
 	int rc;
 
 	set_bit(BNXT_FLTR_FW_DELETED, &fltr->base.state);
+	if (fltr->base.vnic->fw_vnic_id == INVALID_HW_RING_ID)
+		return 0;
+
 	rc = hwrm_req_init(bp, req, HWRM_CFA_NTUPLE_FILTER_FREE);
 	if (rc)
 		return rc;
@@ -6263,6 +6270,7 @@ bnxt_cfg_rfs_ring_tbl_idx(struct bnxt *bp,
 		if (ctx) {
 			rss_ctx = ethtool_rxfh_context_priv(ctx);
 			vnic = &rss_ctx->vnic;
+			fltr->base.vnic = vnic;
 
 			req->dst_id = cpu_to_le16(vnic->fw_vnic_id);
 		}
@@ -6273,6 +6281,7 @@ bnxt_cfg_rfs_ring_tbl_idx(struct bnxt *bp,
 		u32 enables;
 
 		vnic = &bp->vnic_info[BNXT_VNIC_NTUPLE];
+		fltr->base.vnic = vnic;
 		req->dst_id = cpu_to_le16(vnic->fw_vnic_id);
 		enables = CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_RFS_RING_TBL_IDX;
 		req->enables |= cpu_to_le32(enables);
@@ -6311,6 +6320,7 @@ int bnxt_hwrm_cfa_ntuple_filter_alloc(struct bnxt *bp,
 		bnxt_cfg_rfs_ring_tbl_idx(bp, req, fltr);
 	} else {
 		vnic = &bp->vnic_info[fltr->base.rxq + 1];
+		fltr->base.vnic = vnic;
 		req->dst_id = cpu_to_le16(vnic->fw_vnic_id);
 	}
 	req->enables |= cpu_to_le32(BNXT_NTP_FLTR_FLAGS);
@@ -6365,7 +6375,7 @@ static int bnxt_hwrm_set_vnic_filter(struct bnxt *bp, u16 vnic_id, u16 idx,
 	if (IS_ERR(fltr))
 		return PTR_ERR(fltr);
 
-	fltr->base.fw_vnic_id = bp->vnic_info[vnic_id].fw_vnic_id;
+	fltr->base.vnic = &bp->vnic_info[vnic_id];
 	rc = bnxt_hwrm_l2_filter_alloc(bp, fltr);
 	if (rc)
 		bnxt_del_l2_filter(bp, fltr);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index e2d52841fa86..fd7201283364 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1424,9 +1424,9 @@ struct bnxt_filter_base {
 #define BNXT_ACT_RSS_CTX	0x10
 	u16			sw_id;
 	u16			rxq;
-	u16			fw_vnic_id;
 	u16			rss_ctx_id;
 	u16			vf_idx;
+	struct bnxt_vnic_info	*vnic;
 	unsigned long		state;
 #define BNXT_FLTR_VALID		0
 #define BNXT_FLTR_INSERTED	1
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 8fd0e06ef2a7..f8aacd2822f9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1267,9 +1267,9 @@ static int bnxt_add_l2_cls_rule(struct bnxt *bp,
 	u8 vf = ethtool_get_flow_spec_ring_vf(fs->ring_cookie);
 	struct ethhdr *h_ether = &fs->h_u.ether_spec;
 	struct ethhdr *m_ether = &fs->m_u.ether_spec;
+	struct bnxt_vnic_info *vnic = NULL;
 	struct bnxt_l2_filter *fltr;
 	struct bnxt_l2_key key;
-	u16 vnic_id;
 	u8 flags;
 	int rc;
 
@@ -1291,17 +1291,16 @@ static int bnxt_add_l2_cls_rule(struct bnxt *bp,
 
 	if (vf) {
 		flags = BNXT_ACT_FUNC_DST;
-		vnic_id = 0xffff;
 		vf--;
 	} else {
 		flags = BNXT_ACT_RING_DST;
-		vnic_id = bp->vnic_info[ring + 1].fw_vnic_id;
+		vnic = &bp->vnic_info[ring + 1];
 	}
 	fltr = bnxt_alloc_new_l2_filter(bp, &key, flags);
 	if (IS_ERR(fltr))
 		return PTR_ERR(fltr);
 
-	fltr->base.fw_vnic_id = vnic_id;
+	fltr->base.vnic = vnic;
 	fltr->base.rxq = ring;
 	fltr->base.vf_idx = vf;
 	rc = bnxt_hwrm_l2_filter_alloc(bp, fltr);
-- 
2.51.0


