Return-Path: <netdev+bounces-254586-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oO2wG4P7emlaAQIAu9opvQ
	(envelope-from <netdev+bounces-254586-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 07:17:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DC429AC2EB
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 07:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21CCB301FC94
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 06:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C029C3783B9;
	Thu, 29 Jan 2026 06:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="T79G5rFs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C91E2741DF
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 06:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769667453; cv=none; b=BfYCvDGheX6FWvlCm830fOPCcU6FsGvlw+5lZmmbH2YMHfZlM5zzbelz6UpnxQ3FeZb0gp3KVFWkbyl3cteKhifGzaDhx4Lv73pgNgN/cYXhjJnCl/U4LMwQ+FMpJV3TokBfmjVCP2Fx6WJ6XzS4C5dObX6CYbqiacRi3tUpdkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769667453; c=relaxed/simple;
	bh=Mjy0C1WoO+iDqPqAogajWPA7OyrgFN2WbZflvc7qRbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yyz8/MQsrl2pOLUiRuTO+kSw/g5q9QLabLbY6cIqaWlcSMFSm3FwQMwaiHUw2MmYtjxWkokq0pB63h55+D3sgyT9a3KlkYSIsJT1Aj4UQPW29Egb7Y85Vrpo1+jYWXQbYTiERPCo4M6Co73+7kXVyt2FexDQj63fORyC+ADl9X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=T79G5rFs; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-81e8a9d521dso313336b3a.2
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 22:17:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769667451; x=1770272251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0qdchF33lVbdOqAAAAuxNjXh82Tr5cbf+7Qhe4vqxa0=;
        b=uRuIJydMOZqdURB8RGuRXdYVLSFGIbV4apZ1o5FfQ4UE9B1eRENwIHkNK6h9CWNFo7
         G1FEWmvaZhe63zz0llZAaWOLC3p1dddKsqCZ37ax+pj31vdHG521qXzQ/MoCwvJKo7qD
         /1FuS8+GNLTHKj962fdzzTGgzKZTYpwGql1AX4HVURzgj/5C7h1G45LzTax1cwoKNYRv
         u0jqUyRw1X3nC4hL/TfQsx6IVH9U0izoBfi6/x2xVI+38WPaKHEgbbR/SdDZnaNjOw37
         5XquVrNsT/I0JwW6+xcYU8srtiSS+oc5caEoiIypBWIwDpyHkwjJi3kmksc8WMwv5phH
         S0ig==
X-Gm-Message-State: AOJu0YxqIT928cKnZcJWS4qOEV0s32EUX89u4tiOV9qc7ZaKsem18mji
	pXO6/hT0g2hPlnwMA7o4B3iC7OGFdIhLZApIC9JgqhcyjJ67+ETIq9sfaNjOzGVVMSxGsKdwomA
	K6mhYsKaP83pio5pOT3qi2DPGqAnGb/Zs9HhlSTZ3BEqIIcozFNbLxpRjSoSJdCI25YUhqpn5r1
	h57Q3fh3qYrp9o6BAPW04tzsw8s7V2FIFYjqwR5tr4b0eJn5sY4vIQF/5gqngBgxZqxUlsHp9DC
	dWseeREVAc=
X-Gm-Gg: AZuq6aKNW2+xNrcjQMGMSpU6g8Hm5l6WuYNpsCiOlUETusRCV3wUOT1qS3mMJsKJ6vP
	dBJoUi9dHauZLPa/ybp63a03KqANgWuWWu5E1oNixc5mKZNS005zlHwmfD5ChZrRE/waJgD7YwN
	/ORtiqGHDb6TrMiZOCIkcokrXQxK/M0LAFpaUPGSQjinrtIjcO0FsEPLNe5ek3uHaWFpPut7JOW
	2z7yAcQMKc4ycOgpwjb18nbzWUwxWtIAHHELljh5Ll0hTp0LMpRlXhYOSIhWZrmqddZauSfiLT+
	7Za8m2XcZonkinhkHbeZvwErAbKnPycPALNEr7SemSVMitFVNU+/g4YExmKaYXBaadO8laCCt3v
	GHeQofBH8X8uvIVSejJ25Jdv4LRtQzD0Jg1XzdxJr/ODPOJ1VyUJwFH+3VDBxM0fSGeKUs7gpuT
	CvClg6QDy9HKuRxuvsWnrvZqXw2FX2dJ70An0PULPt2w==
X-Received: by 2002:a05:6a00:bd91:b0:81f:44f9:7c1a with SMTP id d2e1a72fcca58-82369149540mr7499248b3a.3.1769667450390;
        Wed, 28 Jan 2026 22:17:30 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-82379b187a3sm539534b3a.1.2026.01.28.22.17.29
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Jan 2026 22:17:30 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2b795cff830so3583565eec.1
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 22:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769667448; x=1770272248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qdchF33lVbdOqAAAAuxNjXh82Tr5cbf+7Qhe4vqxa0=;
        b=T79G5rFsRav1+VtVb/i+tDbyVjsWhov/eo9czlyLIKCTa5XgPNxNYQY5+P7La58bTP
         9gwAB/QJOEITFinzcVMtpc/tTym6ur95mqNHRePBSHVA6r6P0SfH7RKMfe0jydRD6RZF
         3MG7G98oVFkOBRQOzcb12mJrCsvKIAEeESTN8=
X-Received: by 2002:a05:7022:628c:b0:11b:9386:a3c2 with SMTP id a92af1059eb24-124a012a4b8mr4394270c88.45.1769667448343;
        Wed, 28 Jan 2026 22:17:28 -0800 (PST)
X-Received: by 2002:a05:7022:628c:b0:11b:9386:a3c2 with SMTP id a92af1059eb24-124a012a4b8mr4394258c88.45.1769667447800;
        Wed, 28 Jan 2026 22:17:27 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9e0304bsm5318226c88.14.2026.01.28.22.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 22:17:26 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net 2/4] bnxt_en: Don't overload fw_vnic_id for RSS context's filters
Date: Wed, 28 Jan 2026 22:16:44 -0800
Message-ID: <20260129061646.1417185-3-michael.chan@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254586-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: DC429AC2EB
X-Rspamd-Action: no action

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

Currently the ntuple filters installed for an RSS context
use the ntuple filter's base member 'fw_vnic_id' to save the
RSS context id. This is making the fw_vnic_id overloaded when it
is being used with RSS context. This is very confusing.

Make explicit provision to save rss_ctx_id in the ntuple filter
so that we can avoid overloading fw_vnic_id.
Also remove unnecessary initialization of the id to 0.

This cleanup is necessary for the next patch that will remove
the fw_vnic_id field.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 4 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h         | 1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 5 ++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 64832289e18d..6fae0490bc1c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6259,7 +6259,7 @@ bnxt_cfg_rfs_ring_tbl_idx(struct bnxt *bp,
 		struct bnxt_vnic_info *vnic;
 
 		ctx = xa_load(&bp->dev->ethtool->rss_ctx,
-			      fltr->base.fw_vnic_id);
+			      fltr->base.rss_ctx_id);
 		if (ctx) {
 			rss_ctx = ethtool_rxfh_context_priv(ctx);
 			vnic = &rss_ctx->vnic;
@@ -10837,7 +10837,7 @@ void bnxt_del_one_rss_ctx(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
 
 	list_for_each_entry_safe(usr_fltr, tmp, &bp->usr_fltr_list, list) {
 		if ((usr_fltr->flags & BNXT_ACT_RSS_CTX) &&
-		    usr_fltr->fw_vnic_id == rss_ctx->index) {
+		    usr_fltr->rss_ctx_id == rss_ctx->index) {
 			ntp_fltr = container_of(usr_fltr,
 						struct bnxt_ntuple_filter,
 						base);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index f88e7769a838..e2d52841fa86 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1425,6 +1425,7 @@ struct bnxt_filter_base {
 	u16			sw_id;
 	u16			rxq;
 	u16			fw_vnic_id;
+	u16			rss_ctx_id;
 	u16			vf_idx;
 	unsigned long		state;
 #define BNXT_FLTR_VALID		0
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 068e191ede19..8fd0e06ef2a7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1219,7 +1219,7 @@ static int bnxt_grxclsrule(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 		fs->ring_cookie = RX_CLS_FLOW_DISC;
 	} else if (fltr->base.flags & BNXT_ACT_RSS_CTX) {
 		fs->flow_type |= FLOW_RSS;
-		cmd->rss_context = fltr->base.fw_vnic_id;
+		cmd->rss_context = fltr->base.rss_ctx_id;
 	} else {
 		fs->ring_cookie = fltr->base.rxq;
 	}
@@ -1468,11 +1468,10 @@ static int bnxt_add_ntuple_cls_rule(struct bnxt *bp,
 	if (fs->flow_type & FLOW_RSS) {
 		struct bnxt_rss_ctx *rss_ctx;
 
-		new_fltr->base.fw_vnic_id = 0;
 		new_fltr->base.flags |= BNXT_ACT_RSS_CTX;
 		rss_ctx = bnxt_get_rss_ctx_from_index(bp, cmd->rss_context);
 		if (rss_ctx) {
-			new_fltr->base.fw_vnic_id = rss_ctx->index;
+			new_fltr->base.rss_ctx_id = rss_ctx->index;
 		} else {
 			rc = -EINVAL;
 			goto ntuple_err;
-- 
2.51.0


