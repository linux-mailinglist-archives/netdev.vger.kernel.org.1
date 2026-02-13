Return-Path: <netdev+bounces-258577-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMigCbXWjmmhFQEAu9opvQ
	(envelope-from <netdev+bounces-258577-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 08:45:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BB5133AE9
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 08:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E4E43082EEE
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 07:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EE93112BA;
	Fri, 13 Feb 2026 07:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hSNCmlhF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88663112AD
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 07:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770968739; cv=none; b=T/9swDdOnj+VRLRjoSl/YkRFbGnZOO3ZkdVRM4OZsr2BbzQnPDq5H/KAu3At/qLpburJ4ARbR60+Yp5PpyXS7y5UdMt3h6cSMLmBnnPHb4uPAFI0fXcOIbO6/4M8FJJUcNqm6pNLoVqfOB659crBGQvvGR6XODosDyAVi6jgA50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770968739; c=relaxed/simple;
	bh=VNwHz/eZZBwWdWWH88r0F5buz9m6Z1m9YhwxSDDH/0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HI7ycnZANLx2dXAChVKuyVBZfQAyABZU75MR0VJb8lgWHsp2u/nYMpwXHnR8yzHKASqeJvGZQqYKHeU41QAyALpK0lYSCCbjt+sVfnrSxND/68T14evizyMqXoEI3Hfn1xF/4IDeblQ39kLaHaTo5IfJyezxJgD+/1WiRQ62UIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hSNCmlhF; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so5816985ad.2
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 23:45:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770968737; x=1771573537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DTKH1SDd01uQyYlFWMAr/JLPwS9vRgiKjdxjSrM8tSI=;
        b=BLji7bGPz51IpwcHLT0zav3E6y8P0GIP75KCuxjLyB0FMvF3CDFrDkrY5upa0EE0fj
         xkU3G4Wt0jY6Vg47PTDOpQnqH8q4IgfefSZ79zxIttt7NZ1LBWF4rfQ/whApMvJyN+Zv
         7eNPU+UOztiR9pp41DFzwz3t0abDtw/48kXWhzL94XzVWMlIRzN9k1JWr0QuPmdg3mP1
         mkZaXhjUF95qaSyQzRry5L8JJZM15HjzwfwJ3grpiC2Qyrd0HUmWNMAVdl+tvOGwBxkj
         15GwPL9WJZHWHlU0DQNzJ8Uy/YTRoMQUB38PoZ03VfLL8+A+4DAzOp1A9CR+D4Q9YcGz
         v1KQ==
X-Gm-Message-State: AOJu0Ywi76w2U8jNM9AI/bKwXg0VPBsm4W+5WRjeM36ttdi0vtNJFdPW
	b/FxC1JnpGndAZsioSYDkEVQ/JIkJ1OSLxbLWD/jNTM5HVlT2lEsCpanLHm9drzGYKPyAj8VDZ3
	Z2icp/BnHcjqeIBIpmXlzgWaJqNWaYxxJxuMxuWoH6SjiIWPdGIQC6ABvPc1ytjXqinh/1eaMCs
	uwQtMq4PpqT6G9jPf9DXdRqI+fxBUmxLD29WEkJde/uSIAuMzzWFKbh4GrMYjWCfaKGlW3py0xz
	OtMpp8cq24=
X-Gm-Gg: AZuq6aJoJYLkRFbEH4eOm/kzRTrgSLQKp9Y0ob9F/8+Lu5QyH28XMt8hLd8URdRLjVE
	jUZbMOg5hZgFZ0cs60bJOx6djcmRN+1r6dNc3VSl9cXpYOPSoAZptutA40o4t6LnY2IYZItDlCd
	SXzLG73pXfwFuxoyQuBESIQijGpWIb6H0Pb5Mn26w+KBck2mZ+OtvkxJGDrR6HNq/kNjmb2BU6t
	Ncr6dFgStGNSG9r/2TPV8/zHIs+pYEG0lJYwNNEICP2CzrJMC+4vDGk2/a5TD8lA40eQK/fS4ey
	MMf0kSu8DjKrxkKNN/CWFQLEDz1bRS45ChdAg+DhjM9IJBvIY9EoVGoQD2eG9h07TBpNBgdT0iZ
	Dzu/4HiFgPLlk8lHu/+eUMO4CqXz1KepKpEaOmjZDVjl72rQWmC5LTpS6/2NprSIgJKqVighKyg
	lSKeaGJBpU49mJ2k5F/6j1Av99C27KcDdjFUUO9yIYIU9S5pM4Aq7DN/pm
X-Received: by 2002:a17:902:e852:b0:2aa:e7f3:faf3 with SMTP id d9443c01a7336-2ab505229e3mr11900275ad.23.1770968737159;
        Thu, 12 Feb 2026 23:45:37 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-94.dlp.protect.broadcom.com. [144.49.247.94])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ab29884be8sm8849265ad.21.2026.02.12.23.45.36
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Feb 2026 23:45:37 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-896fae4073fso9362926d6.2
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 23:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770968735; x=1771573535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTKH1SDd01uQyYlFWMAr/JLPwS9vRgiKjdxjSrM8tSI=;
        b=hSNCmlhFX04Qn03DEhVWzLDk2PeIpyx5NrE4g8TnWGPBWQqlUwosdFG/PwCaxGZC86
         kQYW+w3hMz2PaSIhnKlmtZWxarYaaJEHVbZZuVV9wSXhcpoMYmSNXzaZe9lbSyuXfasC
         bRbqtpHKKSKiCoT74C7VgKFOFi3N+5J7rlXrg=
X-Received: by 2002:ad4:5743:0:b0:895:1c9d:ba04 with SMTP id 6a1803df08f44-89736085d4emr13591946d6.6.1770968735614;
        Thu, 12 Feb 2026 23:45:35 -0800 (PST)
X-Received: by 2002:ad4:5743:0:b0:895:1c9d:ba04 with SMTP id 6a1803df08f44-89736085d4emr13591856d6.6.1770968735187;
        Thu, 12 Feb 2026 23:45:35 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50684b6b56bsm58882201cf.17.2026.02.12.23.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 23:45:34 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net v3 2/4] bnxt_en: Don't overload fw_vnic_id for RSS context's filters
Date: Thu, 12 Feb 2026 23:45:01 -0800
Message-ID: <20260213074503.2302046-3-michael.chan@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-258577-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:mid,broadcom.com:dkim,broadcom.com:email];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D9BB5133AE9
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
index 7768d9753e2d..8fc15a8353fc 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6287,7 +6287,7 @@ bnxt_cfg_rfs_ring_tbl_idx(struct bnxt *bp,
 		struct bnxt_vnic_info *vnic;
 
 		ctx = xa_load(&bp->dev->ethtool->rss_ctx,
-			      fltr->base.fw_vnic_id);
+			      fltr->base.rss_ctx_id);
 		if (ctx) {
 			rss_ctx = ethtool_rxfh_context_priv(ctx);
 			vnic = &rss_ctx->vnic;
@@ -10899,7 +10899,7 @@ void bnxt_del_one_rss_ctx(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
 
 	list_for_each_entry_safe(usr_fltr, tmp, &bp->usr_fltr_list, list) {
 		if ((usr_fltr->flags & BNXT_ACT_RSS_CTX) &&
-		    usr_fltr->fw_vnic_id == rss_ctx->index) {
+		    usr_fltr->rss_ctx_id == rss_ctx->index) {
 			ntp_fltr = container_of(usr_fltr,
 						struct bnxt_ntuple_filter,
 						base);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 9a41b9e0423c..6a18a1973fd5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1435,6 +1435,7 @@ struct bnxt_filter_base {
 	u16			sw_id;
 	u16			rxq;
 	u16			fw_vnic_id;
+	u16			rss_ctx_id;
 	u16			vf_idx;
 	unsigned long		state;
 #define BNXT_FLTR_VALID		0
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 53a83b6680c4..d0363f410ddb 100644
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
@@ -1469,11 +1469,10 @@ static int bnxt_add_ntuple_cls_rule(struct bnxt *bp,
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


