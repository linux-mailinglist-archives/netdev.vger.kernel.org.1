Return-Path: <netdev+bounces-257471-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHozMKV8hWlQCQQAu9opvQ
	(envelope-from <netdev+bounces-257471-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 06:31:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD40FA5B2
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 06:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E3F2302F715
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 05:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1A1339B49;
	Fri,  6 Feb 2026 05:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KC1BbKAo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE2D339B39
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 05:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770355851; cv=none; b=pMRIeHjCHec1jvMj3PMuaqjU7QdYkrTu4sJiNk/ZIRgZCDLTfHriZcBC4fVaO/dVL5juV0tnPuj/fpCRK+3I15S7/NoE02MPh64E9CXrwnOT1mE3//1yYHvV5vjXUMdM/2yy3iLvtKY2CkSqsKlbG6L/kVce9MSCAig7IX7urLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770355851; c=relaxed/simple;
	bh=Mjy0C1WoO+iDqPqAogajWPA7OyrgFN2WbZflvc7qRbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eCrichhycpdvJHteQ1Ehk2PoFxcPXQslcSAQyRMn8thT5YvsUaEG/iwKQVXjTIIVUVMS41ad1Sj2IhNIXAxmMRkjZ77VsvKsJw2q38XpTCoACkokmNTJ4ot7wqLNgeEq1UbpZmpzs40bIjI2KHcRipPMSAPi+QHJ3KaWK04C4aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KC1BbKAo; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-88a288811a4so18758256d6.3
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 21:30:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770355850; x=1770960650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0qdchF33lVbdOqAAAAuxNjXh82Tr5cbf+7Qhe4vqxa0=;
        b=NStzyA+MXet2V4xz4m0ouiX+C/ADmvvH8dACi7nValIIzxnvA41e78qxkZKNfSTu6Z
         eFjB9bjOJnEjEflGh7+cgzGuaILTJ5cBqAHPuBtmW4/zofRVfEwFTViBvfxXXmvsxqLW
         tGU6rUYLpCZi7+JzFZwCnbyMR7QHK10azMdEuMe4JPeSN8J9o5e4RrpBoGvGAe8O0LBr
         2Bgxh6R+qpBLiqmvi4F9T4kQh9UaThuv2QWXFRWQttCAf2rVtMjIuGr+HG8npQAkcAtw
         faijnu6yWaIvqvQXprK6QpDlOBwV2VpV9ORXzHhUYoGLv55ja+arpc0wYRzUbsvoZcJW
         e6+w==
X-Gm-Message-State: AOJu0Yyjl01xRp5gvxZs9hkBPeAcBaAeXyL4APy4tQOHe+RDfqEIH3mQ
	DJvD3Is2zeikrPUBAeX7UDHhne227eYbC56Rdy/NmsTE3mM1AtyWxJWXyIMkUD1IG3XF0Q7MTdp
	diDxmsAHY1K8t0AMIVmnWWPtt37GLKp5lTy7kWzrwR+noyReZOhQQgWNl51FVGIZtT5952fSVQD
	ODIiemVjWMn7he9MC322JZavxrZnZmAVtpLmNt8r/lW6sd5t4/FB2J8E1fFnu6VBItxv9bpRBv1
	5k+AjvQOaY=
X-Gm-Gg: AZuq6aJTA/zxCFeeqiwI4bYszFm7Gfuh1HHn0GgaLEi11zta3aH9zexzoKM994yKe8P
	d9lfa4x0Y7eKuAdDWxA/6X/UuRrcV0ip7Alphxvrdb3I91QLxzkj4quQVDjEMwFqyO6O5v8MMva
	3qnstqew1YbvCLtOAa3v4fH6OwJduZ0uvw5QYJyfiA380AjPrJTIgE579jJKHnampZqVR2ulgCj
	F0zmUzyc4INURK/p888xMbXZhBGzB1atTHTi+UTr3DAp/f18nlUiWt47aglgnynREFRNlo9PkRh
	+UZYFJPI1m+GIqPpgDFtkvnXmrnGfRBJaZH9QhG98Tew40WsGbTi4SE4OV2FlmT6oAFim/YZhD0
	iAQt+B12GjNERvcU0I5PQatKkUx3tHGvqOLU/dIuJsAuX5o3/q0jXbKgXuHhT6lIbGkwZ0KbN4S
	/4KPrVp3fWDW7bSiJB3l4dlBMYjX0gmerVPki68yeyfFBMH4c=
X-Received: by 2002:a05:6214:c2d:b0:895:24bf:d157 with SMTP id 6a1803df08f44-8953ca7f73emr25679936d6.33.1770355850578;
        Thu, 05 Feb 2026 21:30:50 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8953bf15b33sm2331176d6.6.2026.02.05.21.30.50
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Feb 2026 21:30:50 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7d19e3a3770so5826664a34.0
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 21:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770355849; x=1770960649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qdchF33lVbdOqAAAAuxNjXh82Tr5cbf+7Qhe4vqxa0=;
        b=KC1BbKAo844wkVfDw1mxIf7+lu5kHC9/DMgn9SamTH7b2H0rJIHnOA+wMyORslmr0H
         B2GI+nxMetdwAZUEZ0NNzd3tAknrhfCB8IyvFT23yEwMVFXrFMbyqZvZys8C0ROFUyCi
         2xrSVgi5BDrxC6mjSBV6tG/5JlY9PG9xBmhvI=
X-Received: by 2002:a05:6830:2813:b0:7d1:4608:a2cc with SMTP id 46e09a7af769-7d46440d800mr872872a34.12.1770355849315;
        Thu, 05 Feb 2026 21:30:49 -0800 (PST)
X-Received: by 2002:a05:6830:2813:b0:7d1:4608:a2cc with SMTP id 46e09a7af769-7d46440d800mr872863a34.12.1770355848959;
        Thu, 05 Feb 2026 21:30:48 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4647aa6cbsm903529a34.26.2026.02.05.21.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 21:30:47 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net v2 2/4] bnxt_en: Don't overload fw_vnic_id for RSS context's filters
Date: Thu,  5 Feb 2026 21:29:28 -0800
Message-ID: <20260206052930.1882740-3-michael.chan@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257471-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3DD40FA5B2
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


