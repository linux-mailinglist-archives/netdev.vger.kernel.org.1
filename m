Return-Path: <netdev+bounces-283752-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePfEDC5b+GlStQIAu9opvQ
	(envelope-from <netdev+bounces-283752-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 10:39:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 840004BA564
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 10:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D4DB30056D9
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 08:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A05313E30;
	Mon,  4 May 2026 08:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MtpjUgNF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8932AEF5
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 08:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777883761; cv=none; b=l7AgehBRvgHjqY51lmxg8pygxAjcMAePxPzlwuLmWHG/vha44PzACfL3RPjyGAdLd2ElkFwy38oWfjE0y1rO4SqppRKHfr19qfG/XYFqgvNcVqFsBTylzW7kZeTU0JivkoD5u1ixjtZ6pmhpHIGF2c2h4SECkk4UhJBSn2RikJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777883761; c=relaxed/simple;
	bh=uLNU6B4FKGus2lCvcYMSJcn2SD+ma+cVsJ1Ycke12yE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dm56iG9SWSExaDFf3tBX8hrSJR6EbpR5vHhiq0/fgvCToJ3OOHW4K1LKrGGZizwdDsWcUcZEYRJVkDvDc7/FQJvXgd7xLVWgHoediKWKoJ60kyQkXjV4swegfdWfl1FrKF6ooIFykungUNctKwpTQqBDABQTUyCwlNHCOAML5y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MtpjUgNF; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-8b4000e51fdso37370336d6.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 01:36:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777883759; x=1778488559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3B+quBu0ESH9h4nwB9ieNaCldhlu2986sOTjzXl61mA=;
        b=FAu17rjxDWnCU0VKWghNrJxf8eFT8ZYl9cvLRDBEFLIeUGH+LOqC2PErarWb8ENbGw
         Ao1gXa8o4kxOxG4qklCVM+pfmW5xr2PvZvsIEtGTiBbkFjnSXaINJJHwmk5T0actdObT
         1HNAK40akjsuIsq58RcmfCxpEvMyf0ZRuY5jbT+Q9Q2NyDa7ZOJm//eCE0rFIM4/GdgQ
         SefZd05FWSSu+xhKu9Zh1Gz9KQRhol4gBHFjhxawVHB4LQIhH8XDHXq7vhZAVQNLpsNq
         iz/Czep8qNYFljJE77rUIGSaagnMEbN6x0c+ImwMfcy7mJIx7PpQdu0cwCbyaknxnPga
         9Gtg==
X-Forwarded-Encrypted: i=1; AFNElJ+1nlIgq9+WtAy8+iO1GDAzKnr3NOe15IQ6h1umgsbk3u6OpObIFBlh4cjJCEyttEKLx53j7Cs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtNhe3vdT1mvlT3XjJAYIwgGhSBj1SL9eHwwtVJBprrZSkGd5T
	b0wVtH869RJjr2C//TUZJ1K8GwL5aZ2ATqJsWjMrkrpVD59dyzA6jzJgHwKNN7jReaRINqdyzG/
	2BaBIK/AncJZBVpMTKf9Io8lxe5RN2Ubm3SQTeNTm3rAqZMAazntWUrH2KB4yU5QqJqYDmsniF6
	XhbbMbU0cwJacy2hcfPeHWDB21wWwtVh0wSRnE4HWIU421fe+cglrcQh16rFJQt3KOViPqWCt6D
	FM57iJF6o8=
X-Gm-Gg: AeBDievUWBcddxdtJyLRSuOoYGeLwkFazQxq4bpOa5ORYEva9OUzZcYj6CRoYLYm8u9
	IH/K7wzkrunNBxyl77BKy/3euBwX/mnPBzxBfPNkS+HfCXPMBjQzm7rGzz2cTfl1sDYAEt6FEHv
	HLlaL5Z4Q73X0v9ymIjlSJn3x9m57WmzZNWUcK58YhLXd+SpOzOV7mlhjK7zGXrGZLXgJqlf+NH
	mFEv6toId2+58dfayryPwjZEWoE0xtBy/6hJxa+FBGduhdE7Pqont+vs2PWXr05v744PEEKyw50
	t1Antlbda+uykX5IERB07uTgRcmEsxzK/A6IKthaLfteNGBPxOYkSPgtSBvkLIC0W1f5B4x9IoR
	YwuQ7bBw1mnjsqmJTbO41xLde+pht+k3de0uHy5IIxYkI6v1Yw7i61VTM5NvrQ7pvGuTH42zcw9
	43Hv163750jS1mx3Ln3BdK/wrvPZ1+q8TqgcHhRN/eHGuBhev029hsZKvjMoqy/he+hu8=
X-Received: by 2002:a05:6214:8011:b0:8a4:7977:e5fa with SMTP id 6a1803df08f44-8b668257977mr139362796d6.25.1777883759091;
        Mon, 04 May 2026 01:35:59 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8b53bdfb6a2sm9058516d6.25.2026.05.04.01.35.58
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2026 01:35:59 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b6097ca315bso5491904a12.3
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 01:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777883758; x=1778488558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3B+quBu0ESH9h4nwB9ieNaCldhlu2986sOTjzXl61mA=;
        b=MtpjUgNFiqgThq5qtDkDOCGXPxCpFWv3p87HJoxzLY2wDVSOn2zRHNHpCxfvKK0KHr
         OG+kGPp7ebH0wpvt5spsA4D+fJ9B2eORZyhwFMjRjNuVBDwUZgUOYQXe6RIZVzVFkoEd
         CKSs6r41AnYLkGzHy3vXfdoLKz3p9q62+v9N4=
X-Forwarded-Encrypted: i=1; AFNElJ90BA+eNLABpzbWalx5LfBMDvXb7KVMRZ2c0T1lsXYn2K6b1OysDg1ywt3lKpc0puwADlEM4zU=@vger.kernel.org
X-Received: by 2002:a05:6a00:139f:b0:838:1c02:276c with SMTP id d2e1a72fcca58-8381c022c71mr1660914b3a.40.1777883757666;
        Mon, 04 May 2026 01:35:57 -0700 (PDT)
X-Received: by 2002:a05:6a00:139f:b0:838:1c02:276c with SMTP id d2e1a72fcca58-8381c022c71mr1660900b3a.40.1777883757232;
        Mon, 04 May 2026 01:35:57 -0700 (PDT)
Received: from pc-hpe-top-git-sendmail-server.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515ad0183sm12539773b3a.31.2026.05.04.01.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 01:35:55 -0700 (PDT)
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew+netdev@lunn.ch,
	andrew.gospodarek@broadcom.com,
	edumazet@google.com,
	michael.chan@broadcom.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net 3/4] bnxt_en: Check return value of bnxt_hwrm_vnic_cfg
Date: Mon,  4 May 2026 14:06:10 +0530
Message-ID: <20260504083611.1383776-4-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260504083611.1383776-1-pavan.chebbi@broadcom.com>
References: <20260504083611.1383776-1-pavan.chebbi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 840004BA564
X-Rspamd-Action: no action
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
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283752-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

When the bnxt RDMA driver is loaded, it calls bnxt_register_dev().
As part of this, driver sends HWRM_VNIC_CFG firmware command
to configure the VNIC to operate in dual VNIC mode. Currently
the driver ignores the result of this firmware command. The RDMA
driver must know the result since it affects its functioning.

Check return value of call to bnxt_hwrm_vnic_cfg() in
bnxt_register_dev() and return failure on error.

Fixes: a588e4580a7e ("bnxt_en: Add interface to support RDMA driver.")
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index 052bf69cfa4c..5c751933da6a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -175,8 +175,14 @@ int bnxt_register_dev(struct bnxt_en_dev *edev,
 	ulp->handle = handle;
 	rcu_assign_pointer(ulp->ulp_ops, ulp_ops);
 
-	if (test_bit(BNXT_STATE_OPEN, &bp->state))
-		bnxt_hwrm_vnic_cfg(bp, &bp->vnic_info[BNXT_VNIC_DEFAULT]);
+	if (test_bit(BNXT_STATE_OPEN, &bp->state)) {
+		rc = bnxt_hwrm_vnic_cfg(bp, &bp->vnic_info[BNXT_VNIC_DEFAULT]);
+		if (rc) {
+			netdev_err(dev, "Failed to configure dual VNIC mode\n");
+			RCU_INIT_POINTER(ulp->ulp_ops, NULL);
+			goto exit;
+		}
+	}
 
 	edev->ulp_tbl->msix_requested = bnxt_get_ulp_msix_num(bp);
 
-- 
2.52.0


