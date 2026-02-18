Return-Path: <netdev+bounces-259206-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKVlB+FNlWnIOAIAu9opvQ
	(envelope-from <netdev+bounces-259206-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 06:28:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B30E91531DE
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 06:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EFD7A30175F9
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 05:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D212EA749;
	Wed, 18 Feb 2026 05:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AaJHCUyL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f227.google.com (mail-qt1-f227.google.com [209.85.160.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DF41F1513
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 05:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771392477; cv=none; b=hurQqYvAjBzqmgquIOIrzTq13ES1kbqRU2crHVSItA2y5JnQiVNMNa2X7YIpC9Yr6xqYGgp46DwbrtFxVLx81LmjFuCEBOKUXw2RDGiZKl9vqdNARczluVxr4dYYMag5wzyw0/p+xNjsJYS7PSU7R7ayXTSwnslbfWO/xVAWvbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771392477; c=relaxed/simple;
	bh=d5u5IAe7gfu6AXao34YA2COKVVZ98LvXS69WLYLlTaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qQ7Wc2QA/yCiLu2Q49Tgp9JRYrDLac0/tYipF8J47693O5RnzcD4rumptU1YP0HOeN+s4tDlHUKW/TFRdTHndPTu9lnQLKsQQuOQzkKeWDvU5iMeIGMVUkYdtX9PecxpneAY4hIJe+qFWkTwKFJ65DgkHaiPVPctdjZB1wwDyKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AaJHCUyL; arc=none smtp.client-ip=209.85.160.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f227.google.com with SMTP id d75a77b69052e-506a297c14bso48841771cf.2
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 21:27:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771392475; x=1771997275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2B9PV0MGzW5R2FMwBcx2SJsM/aIOtYftHSo0JobyAqM=;
        b=n8P+3c65NYtYE1UuN/HWkcOBJ3u0pjAN0RBC0kCvwOim+Dv0KaG0t+CNM49NbF06lA
         Mj8w2dPDD0e1lDGk5+QsJfXknMr0PgIxqwELg/cChetlFmrufDG2qeliWIMPEnWSodI+
         1i6GzrxL7dGUCRgSGx/VzQAvmRHBaH9X/kZuk/B0Jl+5iLQfhnC4B/CS9xxvy3G0BNgK
         e+W6V3DYP9Id5661rqNOPpGE9INEDc4vxOpTpgQq9WWbZvGR8FxnEqxZQm+PNE00QDfH
         86x/vDEGGGcyg6xP9Ipz2bvMoeYzSraotxCb37sBfzm6G01EDsYt2eanYYar6ib8mLNt
         HhPg==
X-Gm-Message-State: AOJu0YzYWIdumyXi4IhrcciUamt+PcWROiHpt1FOEFA/D20E4FSn/bsE
	9tSRlCB71EgyRVOqUKsvmdnMJnbkBBe6+aHvNb7LGKVXo0H2Pct/7hkO7QfzielvCV7YN0gCpo1
	1EANh0rieSsJsYF2tnONuqv4qVizwsDBeAxb3gjqZYkDDA1H0se8kBorc3GPJS2QWJ9gMy+1Dj3
	ITGkX4IZ+SIFf8fFsImJ+JODXrjrSNZRvixcJX3/kPn9G8qQUTjTDJB5FtqJS5vNklQpFOkd1xI
	aiaFGd4iw==
X-Gm-Gg: AZuq6aJC1DMPvcq54Uuav2pfPgM1+PS42dhpbqKveMVfJ/fcDtFz8syhrhY+H/MiroI
	n3i0XkpCCCnJ36tryYDOr53WJh+Rs7j7T4VZZBOefD3vjhzQ8Pd2QZnyktgDLzCh0MMCeZjcLyT
	YDIBdZ0LvptC0OPH1viLeYVS26grNE10lBYqHof77ZmLFybwBw1W87ADkF5oZ+Z6b2YzmLZiGHr
	nZZOKLJNcbE6/p8gISAJVvEq2gph1K4oojrqbS9GRW8l4eSKt3FqWvRjW2b35gnc+pLRdr4BEdC
	pe/Pbu7Wt5IheBi4ifaP7SXYquf3HsI/DhNvJIdSkJiSymWK8FwkC+gGGkVud/utYknfnj3fXka
	slP6ijQh7Hr/jHNgxC7cGP2b3sAJeG/UVm6hcPqk3Ei0+DMuyNpnsnyTufYGU6Drg64QsUDCAMX
	JFkHvbnLqSZD3O30fTc+8Q2U11VCJt+hvlvKl+T0opiN254qA8VrI2SgF8uA==
X-Received: by 2002:a05:622a:1917:b0:506:2116:4b86 with SMTP id d75a77b69052e-506e8f13202mr10395091cf.0.1771392474791;
        Tue, 17 Feb 2026 21:27:54 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-50684b6cc58sm20870141cf.7.2026.02.17.21.27.54
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Feb 2026 21:27:54 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c6de18907a0so3147025a12.1
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 21:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771392473; x=1771997273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2B9PV0MGzW5R2FMwBcx2SJsM/aIOtYftHSo0JobyAqM=;
        b=AaJHCUyLAYk+au+Riu0oVGjbaw83rdWn3EvxlgV57ff8UbKSgjn9/aGo3fzB67dflW
         inX6zpqVVN/RYtlz6xj+RrIBfZiNhmM+578WQX4JxkQ9A0DwmwdPKgCVD3nezTNl59dP
         lwi/ZpAR29s1wE3rJBHnCjjGtHUQUNDyFLWQY=
X-Received: by 2002:a05:6a00:3ccb:b0:823:1570:1e81 with SMTP id d2e1a72fcca58-825275e5ebcmr991226b3a.53.1771392473085;
        Tue, 17 Feb 2026 21:27:53 -0800 (PST)
X-Received: by 2002:a05:6a00:3ccb:b0:823:1570:1e81 with SMTP id d2e1a72fcca58-825275e5ebcmr991152b3a.53.1771392471280;
        Tue, 17 Feb 2026 21:27:51 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b69efdsm14894102b3a.40.2026.02.17.21.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 21:27:50 -0800 (PST)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rajashekar.hudumula@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Subject: [PATCH net v2] bnge: fix reserving resources from FW
Date: Wed, 18 Feb 2026 10:57:55 +0530
Message-ID: <20260218052755.4097468-1-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[vikas.gupta@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259206-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B30E91531DE
X-Rspamd-Action: no action

HWRM_FUNC_CFG is used to reserve resources, whereas HWRM_FUNC_QCFG is
intended for querying resource information from the firmware.
Since __bnge_hwrm_reserve_pf_rings() reserves resources for a specific
PF, the command type should be HWRM_FUNC_CFG.

Changes in v2:
  -Fix commit message.

Fixes: 627c67f038d2 ("bng_en: Add resource management support")
Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index 84c90a957719..91a4ef9e3150 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
@@ -442,7 +442,7 @@ __bnge_hwrm_reserve_pf_rings(struct bnge_dev *bd, struct bnge_hw_rings *hwr)
 	struct hwrm_func_cfg_input *req;
 	u32 enables = 0;
 
-	if (bnge_hwrm_req_init(bd, req, HWRM_FUNC_QCFG))
+	if (bnge_hwrm_req_init(bd, req, HWRM_FUNC_CFG))
 		return NULL;
 
 	req->fid = cpu_to_le16(0xffff);
-- 
2.47.1


