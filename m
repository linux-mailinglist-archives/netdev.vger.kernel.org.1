Return-Path: <netdev+bounces-258578-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDn+AcDWjmmhFQEAu9opvQ
	(envelope-from <netdev+bounces-258578-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 08:46:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DF6133AF0
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 08:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2650309DA05
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 07:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12923126DA;
	Fri, 13 Feb 2026 07:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Nr7WBvH+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f227.google.com (mail-qk1-f227.google.com [209.85.222.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30968311C37
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 07:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770968741; cv=none; b=jvQAT43tJz2ds4Xgvn5xcsnVV2ZtHqVdZtwBdoWeqiyCQs9S69EThqp8LX/3F1ZXz9ab9CpFSbLftzmQ9f5joiny3c7e/0tCCyXlCUYaqoATi8NoamDPvSm3pOCtcA0hOoa9I5/5MGxep/OaFKUzY5rPuttmNDydMYjmVklXFDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770968741; c=relaxed/simple;
	bh=nAb3HImLxOaZWm6557MYicr5XGXkB60zAU6w01uBHiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLWmnsKC3PlVTm7ChI9lBYp+rpSN/HzhK3eeZomMhhoYVNyJFtibAnEqOkk74Y8AUSp++sOCneTmYJCQEDB8MTQYR7a43E3SOVpM/bsOto+6vieh+TW2iV7xKRxxkNy0ekHU73T0l8YWVDzDu4IT3uU60F4ALrAgq3hvjtxg0/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Nr7WBvH+; arc=none smtp.client-ip=209.85.222.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f227.google.com with SMTP id af79cd13be357-8c710439535so53007785a.1
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 23:45:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770968739; x=1771573539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a6KP/h7jNtt/Dxp5G6lyyAKtSxwxntY2XWNzVR1k/58=;
        b=p6RU2cjZ8krZECOvEs8oWgFtbv4OvVWUJTPM4wW34dd/f3eGzthK/INnELMtxLkmQ2
         71YFNCwOUz304F104WLJW0M3LkhbCVbcKM7LW+SE0vlLMQgOerpewNBStne/jax2g2kn
         fokySFk4JoU5hzX7NrawTGXGTRMkkeL8Bd6ePkWXbQ7+jkK1OGdjWPNnF7k2SJOHAeqI
         OgwwXn8429ucAVTHh7r4nZRuTA6HOk/hAQB6uP0hOa7Hkc+oBQo8djZ7cF1jkgV/UQ98
         OABTQSMEbt8agVz4jUlKv9OWRZew4pSBHx8gIhiaj5XkIQQSU+GmSlqiERz3fhxW7ieK
         21lg==
X-Gm-Message-State: AOJu0Yw56oMvm/xQ8t6VC4eA2omcJ6u9FoFrZoLnfFnP7iMJbVnIMJWg
	aC1HYW0RyCCPgDyVH+Rsp874lk31JIDVU9r9CtDE+hALo4rJdpqSQ1fgHbRh3wuM+U/sRaNYyzu
	4JdhEn2TroA+OOB0hhLiCNUEu6mXNfSZTsfJdlQY8rnUpb2X7hB4eO2+hW72i8Jk5MlJ6/91mc6
	DpDUGbbf0iqK9ShXTZCo1bSMfekELohKZOSFcPEXdWgoFp7UXVjmqVbYLDcbn8z+2r8nKY77M+a
	3hLXtAqBtE=
X-Gm-Gg: AZuq6aKiHQYM2KZw3d4hdjc1uVMQM0v+ycZt7JDMswztrCEZBxUDfJUQnpwwBSR3mJR
	XEFLyIgf1hZfIrBCYvQD3KJhf5pAoLYZjUYifLt9DmCTTLdol5zSYux00qyPX++clC6LuEuveV1
	qwcdsqhnJ7qA2OvtdTUlvYw38c1k65rAGgx6CaGqKpuQH/ExizbIwYItiSUH/JUu2lCpCaICjDZ
	Ybbe8iDcKd38nJO1btFulaGHU4RIC3ULiEifFJDqd2inDM9j9PAslaiUeID3Z8VLIt32iqbVqpp
	nOCng0ZQgxZiw6gEm8Ey/MlLQoETx54+E3qlh29BkzZvUZQThjEC5H7T+6B49naXli1AS17z+wK
	so4YQcKSstk41JTFHSCqOX+soBe3Vlu1i4Q+V/aIkdDEEbYgGPD6yPDEJvk++aGTjLaqFQyhAL8
	Cui1/elFpqldi9m646dpbW8o+asK1r0oUMUQz9y/6Ygtz6qvVRXg6wbrzJ
X-Received: by 2002:ac8:5e49:0:b0:506:a43d:777e with SMTP id d75a77b69052e-506a825bd9dmr10900801cf.12.1770968738942;
        Thu, 12 Feb 2026 23:45:38 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-94.dlp.protect.broadcom.com. [144.49.247.94])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8971cd57eebsm9026806d6.22.2026.02.12.23.45.38
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Feb 2026 23:45:38 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-896fe47cab0so11495606d6.3
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 23:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770968737; x=1771573537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6KP/h7jNtt/Dxp5G6lyyAKtSxwxntY2XWNzVR1k/58=;
        b=Nr7WBvH+6nHezz8f2DnDLqPY8KNX9Z8Gi2uhcFqNvCiHKuI1PhM0yiWJsn93YVXCKP
         gQc+4U+4ApEWUFMJr0WBhXj5JcUGa8UzaggFaCrSSg8OJbTJ2YEt2heWi/LKI6Ct6TjI
         uqfJaPy4ZwnupBlVLzjc9SBjFqW7ZHWhZLjLw=
X-Received: by 2002:a05:6214:1c86:b0:895:c80:75af with SMTP id 6a1803df08f44-897361b7a7cmr10396226d6.34.1770968737490;
        Thu, 12 Feb 2026 23:45:37 -0800 (PST)
X-Received: by 2002:a05:6214:1c86:b0:895:c80:75af with SMTP id 6a1803df08f44-897361b7a7cmr10396026d6.34.1770968737021;
        Thu, 12 Feb 2026 23:45:37 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50684b6b56bsm58882201cf.17.2026.02.12.23.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 23:45:36 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net v3 3/4] bnxt_en: Fix deleting of Ntuple filters
Date: Thu, 12 Feb 2026 23:45:02 -0800
Message-ID: <20260213074503.2302046-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260213074503.2302046-1-michael.chan@broadcom.com>
References: <20260213074503.2302046-1-michael.chan@broadcom.com>
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
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-258578-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:mid,broadcom.com:dkim,broadcom.com:email];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 93DF6133AF0
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
index 8fc15a8353fc..1f05ecf367fe 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6184,6 +6184,7 @@ int bnxt_hwrm_l2_filter_alloc(struct bnxt *bp, struct bnxt_l2_filter *fltr)
 {
 	struct hwrm_cfa_l2_filter_alloc_output *resp;
 	struct hwrm_cfa_l2_filter_alloc_input *req;
+	u16 dst_id = INVALID_HW_RING_ID;
 	u16 target_id = 0xffff;
 	int rc;
 
@@ -6205,7 +6206,10 @@ int bnxt_hwrm_l2_filter_alloc(struct bnxt *bp, struct bnxt_l2_filter *fltr)
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
@@ -6240,6 +6244,9 @@ int bnxt_hwrm_cfa_ntuple_filter_free(struct bnxt *bp,
 	int rc;
 
 	set_bit(BNXT_FLTR_FW_DELETED, &fltr->base.state);
+	if (fltr->base.vnic->fw_vnic_id == INVALID_HW_RING_ID)
+		return 0;
+
 	rc = hwrm_req_init(bp, req, HWRM_CFA_NTUPLE_FILTER_FREE);
 	if (rc)
 		return rc;
@@ -6291,6 +6298,7 @@ bnxt_cfg_rfs_ring_tbl_idx(struct bnxt *bp,
 		if (ctx) {
 			rss_ctx = ethtool_rxfh_context_priv(ctx);
 			vnic = &rss_ctx->vnic;
+			fltr->base.vnic = vnic;
 
 			req->dst_id = cpu_to_le16(vnic->fw_vnic_id);
 		}
@@ -6301,6 +6309,7 @@ bnxt_cfg_rfs_ring_tbl_idx(struct bnxt *bp,
 		u32 enables;
 
 		vnic = &bp->vnic_info[BNXT_VNIC_NTUPLE];
+		fltr->base.vnic = vnic;
 		req->dst_id = cpu_to_le16(vnic->fw_vnic_id);
 		enables = CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_RFS_RING_TBL_IDX;
 		req->enables |= cpu_to_le32(enables);
@@ -6339,6 +6348,7 @@ int bnxt_hwrm_cfa_ntuple_filter_alloc(struct bnxt *bp,
 		bnxt_cfg_rfs_ring_tbl_idx(bp, req, fltr);
 	} else {
 		vnic = &bp->vnic_info[fltr->base.rxq + 1];
+		fltr->base.vnic = vnic;
 		req->dst_id = cpu_to_le16(vnic->fw_vnic_id);
 	}
 	req->enables |= cpu_to_le32(BNXT_NTP_FLTR_FLAGS);
@@ -6393,7 +6403,7 @@ static int bnxt_hwrm_set_vnic_filter(struct bnxt *bp, u16 vnic_id, u16 idx,
 	if (IS_ERR(fltr))
 		return PTR_ERR(fltr);
 
-	fltr->base.fw_vnic_id = bp->vnic_info[vnic_id].fw_vnic_id;
+	fltr->base.vnic = &bp->vnic_info[vnic_id];
 	rc = bnxt_hwrm_l2_filter_alloc(bp, fltr);
 	if (rc)
 		bnxt_del_l2_filter(bp, fltr);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 6a18a1973fd5..ae4d01445cea 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1434,9 +1434,9 @@ struct bnxt_filter_base {
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
index d0363f410ddb..861965ca2e1e 100644
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


