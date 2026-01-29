Return-Path: <netdev+bounces-254585-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oP2QEoL7emlaAQIAu9opvQ
	(envelope-from <netdev+bounces-254585-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 07:17:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0798AC2E4
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 07:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4BA4301F79C
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 06:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8D42DB7AD;
	Thu, 29 Jan 2026 06:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aPwZXG4o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com [209.85.128.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9F51ADFE4
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 06:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769667453; cv=none; b=KcpoB6/18tZPRiL3KURFS0PzFNh3HEWIgJe/32G5gNZT62CwZIlCNSCSXJXNFibzYMRgmVx/5AG2h9pYKozy9XLygDgZxzXxlR9o6xGxE8hSw6ObNd/I84ovsL2OThyEiNkPPEP0ANWAybBIkg3IukeFbtgwvGicPgIoU1K81ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769667453; c=relaxed/simple;
	bh=/f78JPPOX6javyZRThC7ZF2Z5atogSF9CGyesS3/qYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BokFStNk0JN4NtMSGaOY3kxqMQeamPHCyjDmQFpKHkDLoF0HQWvuuPgpxNSlple2mRKqT3JX0/+6TniPIl4bLsf+ylWIf6J6N1wgAtdBeBUVqduRav7oB3t7dNDWkq/uI4XN58U6iflmtiPf74sqxb0JakGLUap+7eqRaSnvD9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aPwZXG4o; arc=none smtp.client-ip=209.85.128.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f227.google.com with SMTP id 00721157ae682-78f89501423so17734557b3.1
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 22:17:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769667451; x=1770272251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pN45g4kRUVrmjUV0gV9PNhxI0auS5Q/eGFieZxaPaH8=;
        b=AzgoBhvM44dcvcBhklxxiWWDnTb8UDFIGTA1ZQdgcOm2SqZwe1SetTUwvYpxk5FLWT
         5SWWxmIasyBuyV0TD0bLNYba4j5hEtqUw30mjpIEtnrXyj6pw3Iq24fVpeh249YPCA2d
         Zau0D0zCZtCJaHwxhcng6EOtDpuS6SXPeoSEPQt5M0SM1mez42vYDrjoSv7ZrUVcoy29
         0ZKwpqv8mo5kh5PfGL6wBHlGZF11YXs7zul8huIeyVYw/s1enhBqjh53hR8Vk+WFcLx7
         kAbLMWgARx2bi+qFETe3eznuPoTwk8BU5WqNQFsGyQUZlzksXLmpE2eKOVC3cOaZebGI
         6tEQ==
X-Gm-Message-State: AOJu0YwBQzfBmlV1SUzMinSuVZvoTjSt0RNzuPdPVRfV1QU/ChqczXiI
	pUtiucl/Yb66zIr5amy2GLCEs07Zp0QLieVM/bvvXRYrN2djH4ZrX/S3vL3wqhnPAuIhMA9bnLt
	LShKH0bBYNqj8FprpIMYyJZ3J24JAv+nJlhEkZI7AOv98i6D5CzRJoSMu1erykRMzIlRBOIYfdL
	8NrI7q9i4bdoOa6HP+nDzqv/Mpur/D4BUTdrLuXo8QG0ztlPj5R0Ubkykn2IW3n30PKzQCmEw1a
	h6dw2BYO5c=
X-Gm-Gg: AZuq6aICzd6p9YIC9A3esp6SlwobbsqrUq+/txdIKLEgpfKCmxhYoeM6RV8inBB4I2W
	K51X9rfNByewUF1Vo0Aesv1/0x5H4Rug80QShoZBYpQBLt9kqoTUr9v3taN6oRlhRk1hegqUTBm
	wvqHpQ0tBHY8kXAG39A6jd8j8QQSQHzikd5NVtBwMy642xEvJr30ZLFjdNX91Sz3SZ5bBr+EqKw
	T4cPH/P5XrhZQIw43ceiqTNbdvtQbqTk763+csbFCbkXMZ98RiIUKX61g9uDNUg6vGVNZ0qT5H6
	nqadsM5bO/c4A47e1rW4RDvir75262ytBKu5NuGnPYZihcISYQehiXPpdquq91LSp3gGAibsND3
	67V70Q3LEU09VQXH6ICMDpalYhu84Rj2GNUJA6OFamu6tngQRCrC7oz9X+RAhnfsfh7MdQ3V59y
	pjMcu3mLIHsbsGiYssL3bafYx8pSnJu53VNxj/cxyGdaGQ
X-Received: by 2002:a05:690e:bca:b0:649:432f:2810 with SMTP id 956f58d0204a3-6499f0b784amr1508689d50.25.1769667450875;
        Wed, 28 Jan 2026 22:17:30 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-649960727f4sm390672d50.3.2026.01.28.22.17.30
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Jan 2026 22:17:30 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1232dd9a256so1189387c88.1
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 22:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769667450; x=1770272250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pN45g4kRUVrmjUV0gV9PNhxI0auS5Q/eGFieZxaPaH8=;
        b=aPwZXG4oni6sWVem91zu8BuaTjDao+2gQ/ItC/ybFwdzLqUjmNuFjlFC3ZE/e0dD5A
         Lni/DFzDQ/x273DwgNusgIOiAwmBHPvtgHPvuPh15TDg+RqFDtStPpS9qFnuX+f2Mp3T
         27uZqf0rh9zuAoJk6nOOGDCwlwI/f0473VWNQ=
X-Received: by 2002:a05:7022:6182:b0:123:36f3:2d2f with SMTP id a92af1059eb24-124b10bb9cbmr984422c88.26.1769667449524;
        Wed, 28 Jan 2026 22:17:29 -0800 (PST)
X-Received: by 2002:a05:7022:6182:b0:123:36f3:2d2f with SMTP id a92af1059eb24-124b10bb9cbmr984414c88.26.1769667448993;
        Wed, 28 Jan 2026 22:17:28 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9e0304bsm5318226c88.14.2026.01.28.22.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 22:17:28 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net 3/4] bnxt_en: Fix deleting of Ntuple filters
Date: Wed, 28 Jan 2026 22:16:45 -0800
Message-ID: <20260129061646.1417185-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260129061646.1417185-1-michael.chan@broadcom.com>
References: <20260129061646.1417185-1-michael.chan@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254585-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C0798AC2E4
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


