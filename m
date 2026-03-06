Return-Path: <netdev+bounces-264948-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iN/5OaVcq2mmcQEAu9opvQ
	(envelope-from <netdev+bounces-264948-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 00:00:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60528228766
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 00:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9907B3058BB4
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 22:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263C735F17D;
	Fri,  6 Mar 2026 22:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Pa1YnkIC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF2D35F606
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 22:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772837965; cv=none; b=upIdKXJDsggDDaVFKdyrPIkvuzSkt8J3sl/zdkESxLk3tPqXefsTYjnQdqD7rzRCLTK82vnT0rI4UA9lsguLqJnQstfdaXlxqhalxLc5Mf+MKHpkLH7dzlSO/+KB2xzKHw5pbdc44PS6is0Z2lJp1JlUTqOq9HwtBuiDO9i5oUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772837965; c=relaxed/simple;
	bh=1K8HM2/sMQI061gxGB5vioZL5ZaW7PlhDdZvvfgB/Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TZTI+SM7Cvw+nCihnLiA/IYszGWIDj7V7EYYBwmHYJaIIsmMs7gRFLrYoAUP9kSp/sqjrFPnGG/Y8zSuOzhlpKl1oqOgn5HCWKXC4ZsgCkrU0NO48L0fYMHo92kZ/jywXiF+THVLOthtkCLXmE0wxrT1JK3Em8jEstMnMzJOczM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Pa1YnkIC; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3598df39444so3850801a91.2
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 14:59:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772837963; x=1773442763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1aqXxRdnWIjd8YUNsLBt+pHFnxLJYEtfHlzMvKYG87w=;
        b=l2UQtL8vZJqjh2IuMW5PzsUGzFkAvHOYJMj0bFV9blkgZtIPWdH2Y5j3k1b55VlQmF
         TyAg4/bpE6Uqq8yYXuUarNjVWD+Z5CgHoWh5fww3oHSTL9k+P8xfc3TmOJTGfXQf5xth
         uEntKP1MmTlVP5HD07O+1i5jTSCmjuvC5YWt4PdrE2XSR5iFCOOX/Q/PZ0yE4AmktkXI
         hG/RAWbH8wrXYJv6LRDf3KJZiv08BB2ZrBKnEKQjluJqUvDc6GyIMbCaistfuOCl5S6O
         u4Ms9m7DfXemZmTQ2O2iFoxYyhywKpzmnhL4PVPGOmdf7/iQmC3E/FUf/TX5HxDdV94u
         2XqA==
X-Gm-Message-State: AOJu0YyT9FuxeIvPgKLtKiqpdwLz7a+rXeaXs19PiXpPZKxaC8b2Njhd
	4h2xZMfWGWEdzNtsVDjRe0Fr/OLrkwnqk60k0TzYRBS6yMuthlmutHFAgV9p4F3aaLwRs1/kNys
	Wqpk0vALDLAOwGsHQbDCiXB9NxgPGW6AHsbV3AgIOGQ4Ac6ng3zP5k44q6v7lsE5XOE9r4HBbP/
	xhT0BxWelPkyJD2/WlDQgD9hOaAXzeZGVqqHUaalYEtfT42PYxXDYwcLd3VFiHLo0RarYX6gJ4u
	BTuqtYLudU=
X-Gm-Gg: ATEYQzyh//8Q288f7tU3kimQvgtQ2iJMcxQV8e+Fa6NMgZvt+I5kR4eYPw6mjLEyjxD
	YXRmbVhTqxDEjv6q3Gi0bl8r1Kua1peP03lMe+NklkEfbgn2KtLrBHgOKkuvXkHT//3edkgB523
	JIBYc/NCPaS5Bf8ywuB31nBRv8ugx8rHQ4LXL9uRG00EAZTqqx+5XlBIZ+6ODfjWQYc3VHUrrQ3
	cND93K/6cLnNsdjTTWOCAR1ZGjQesVSmMS8ovnCp2wJ5yebJpMC+PEA52tef0TssNQruSuOYDo6
	GgA0vxNnJraSAarLaNoZPmQdoQ8EErQiJlSiTTip5l/X6GdBCh+f0vuPbPvryFkLi+ONBxjxnp0
	P8n09JYglxjv/I0gr7fxFHxx+rKWirECzhvvLBqRZMa87MAesunb79cVjvlQZ1WKdvkZdIH/r2F
	lkWdiKOSlGHR5JcCA4gN3UN4HBRU/UadNBowGVE1iHRS8ulx2zQ/c9oQfbs0Y=
X-Received: by 2002:a17:902:c943:b0:2ae:7f28:124b with SMTP id d9443c01a7336-2ae8239e4bcmr37429345ad.22.1772837962947;
        Fri, 06 Mar 2026 14:59:22 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ae83f5a7bfsm3801635ad.55.2026.03.06.14.59.22
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Mar 2026 14:59:22 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c71156fe09so5360164285a.0
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 14:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772837961; x=1773442761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1aqXxRdnWIjd8YUNsLBt+pHFnxLJYEtfHlzMvKYG87w=;
        b=Pa1YnkICTscuy/asRfYD3OGLv8apf9sQvM09c1bT+WC15r50+1kRUUfADmrl/I3po8
         R+WIRXujN9RGjNerDQHRXWJf32wLiMvbdPGxYiyFGOPHm7dgqtw6zT4h/+nYD11IgJcM
         ZS+V8LuetzoSZKJg7xLd4Ncuz8hsebhNn3RIs=
X-Received: by 2002:a05:620a:470b:b0:8c6:f411:5eec with SMTP id af79cd13be357-8cd6d4fb195mr501052785a.38.1772837961461;
        Fri, 06 Mar 2026 14:59:21 -0800 (PST)
X-Received: by 2002:a05:620a:470b:b0:8c6:f411:5eec with SMTP id af79cd13be357-8cd6d4fb195mr501050185a.38.1772837960862;
        Fri, 06 Mar 2026 14:59:20 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd6f4ab73dsm199448285a.20.2026.03.06.14.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 14:59:20 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	bjorn@kernel.org
Subject: [PATCH net] bnxt_en: Fix RSS table size check when changing ethtool channels
Date: Fri,  6 Mar 2026 14:58:54 -0800
Message-ID: <20260306225854.3575672-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 60528228766
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264948-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.977];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

When changing channels, the current check in bnxt_set_channels()
is not checking for non-default RSS contexts when the RSS table size
changes. The current check for IFF_RXFH_CONFIGURED is only sufficient
for the default RSS context. Expand the check to include the presence
of any non-default RSS contexts.

Allowing such change will result in incorrect configuration of the
context's RSS table when the table size changes.

Fixes: b3d0083caf9a ("bnxt_en: Support RSS contexts in ethtool .{get|set}_rxfh()")
Reported-by: Björn Töpel <bjorn@kernel.org>
Link: https://lore.kernel.org/netdev/20260303181535.2671734-1-bjorn@kernel.org/
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index ba47e8294fff..28d0ece2e7b1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -979,8 +979,8 @@ static int bnxt_set_channels(struct net_device *dev,
 
 	if (bnxt_get_nr_rss_ctxs(bp, req_rx_rings) !=
 	    bnxt_get_nr_rss_ctxs(bp, bp->rx_nr_rings) &&
-	    netif_is_rxfh_configured(dev)) {
-		netdev_warn(dev, "RSS table size change required, RSS table entries must be default to proceed\n");
+	    (netif_is_rxfh_configured(dev) || bp->num_rss_ctx)) {
+		netdev_warn(dev, "RSS table size change required, RSS table entries must be default (with no additional RSS contexts present) to proceed\n");
 		return -EINVAL;
 	}
 
-- 
2.51.0


