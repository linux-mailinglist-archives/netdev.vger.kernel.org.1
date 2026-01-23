Return-Path: <netdev+bounces-252883-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cM1vIOmgc2lqxgAAu9opvQ
	(envelope-from <netdev+bounces-252883-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 17:25:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 368477876F
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 17:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DB04302F7EA
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 16:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE40C2DA750;
	Fri, 23 Jan 2026 16:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zdr6483s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC092E2F14
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 16:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769185368; cv=none; b=WgnavyZK3So3WGBZSO5T1v9XXYGMF5bor5WXC0pKjJ6tU4IMvJ79jWVbDbE+mprvEH6zIUn4S3AbihIZam2LHOQ/LIdweXbNSMAyWe21HJashO4yCR36ykf+wSEgGb+yw3FWOZjiHWqTFyP35ggyOy/rBIyxdq+oWEh3qROFwjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769185368; c=relaxed/simple;
	bh=Z8hEHgPPNhf/7h6ZdU08r+TLRxflZ2AGPEEFQtRD3U0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rSqt8bso48XNEx8IEdkh0nNAx1zngSSXp8vvYLGO0K3gxkWbSy7ZJK1CmVdfCqVzrD9t7H8QtvRG6DgEVxdHrxB+3+GC1CwpTVJZelDUIjlBvTDJiz4nAe+K1L0f+jce7GWrLpCoECA2/ax5G9eFH2BtWpL4MeWFpe2J0s3eNfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zdr6483s; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-34ab8e0df53so2260153a91.3
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 08:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769185367; x=1769790167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOf3NxBk19JWjxojhs/EHSzPKHmhtF1Po6inLk8Bjqs=;
        b=Zdr6483sDgfen89EKPyPzUpHwcu9IQMyyZkzPa26ltEuCLXl4F0aBZ7exmVYiCu7t/
         6vTEPn9VEFZvkeg/3Gadbam2vilnTpttIhdPaaF0T6+HStTYt+tY3l6E9PXFNq7jwatE
         BHnvybwoxV99fIvW0c+IotByXGuUu36Tqk4PyMbQOKqLXIWeO2n3N3+9jQYmtWqGR2Uq
         ZHb+SVRvtFDXbpfL1M0Y8ww2PBwX5JQrWtV4E89khJq7qn6ZBOTUx8gLqHZM3qJcF9bb
         3hhD0rgv96Y2T6lHmb2dbmbx3WykpUB3XraktGpqUEqQx2PkwtacgESww4mlYDDcFV98
         6uyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769185367; x=1769790167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OOf3NxBk19JWjxojhs/EHSzPKHmhtF1Po6inLk8Bjqs=;
        b=aBUDtNjPttYOd+J/KT/FdR836uI7uWKAZXPEPXaiIEKMQh1b6JHbI5EvZPO3kubtsU
         jDEM0viuOrpPpxL0vzP188NkA93iET1Jq92CEy0sfbM6V42ReGVt9z7gcuvxhLp18lXz
         76sN+chI4d0PPeO34DCzKdt0L1YUMlg8zChXh4zNOOGmR51pYLc8MDGaQx5TAQOXyJE0
         NRCEcDinApYvjvPC1iY1H5bvrsFStCyKjCqRoOyI5UzJ2PZipmvNZrpaLtM8IV25Qa1T
         VqKYKj8YHZPLsmxYEp/JBCO9RY/m9eklsu/CHVfOjGN4A3gOXidkig3UFAt9sq0URqIW
         pDRw==
X-Gm-Message-State: AOJu0YyLDJHLXtajRtPvv+lhwGHugMxlU5b5YHkqJ3SWQt/dScY7aFoM
	MIFSujkFH9CADJ214CIpiHDBFPGrvna16Bgm9qx8lozJJkknOrqj7xo8rJIyoQ==
X-Gm-Gg: AZuq6aJSHo7X7uRTICMCVcFZtNrSkcCbjzLMEUG6C1kt0E7nVZEHzCx5Ydx7K8U1Ix/
	AfGI4K8oCBxZMWHyNHmuE3qaAsTrtCutH1BsmyvuCygZOF0F6/kpdjT4VtH+/KrTBguPM4buntB
	g2U+7WSwyDgqJYEg14tEPuCZMYWaFpO9a1GnJ36EpmyZwEefpBTh0vjq91wFGXZgkpuZRnYFm5b
	RKLGvuhSVKmDfQSY75m7tcIRW9BGO+A4xcBbOFxH8mmsLNkgDkG/8nzFZRhcjvI4eA+bIAPIp3M
	MHmfuQgoOeqbsHy9rXUH+fgp8MhNxbdza6an+EWxdSQwI82FZXi38R0K7Xwabl1VRw/tLkVp0wR
	VDihHy7ewsypFsYQLiD9HxnprJh3te76VMH7lAPk4eLptxGVf/aANVxHgnSVxC504I+7pAEz98W
	e1+5kaE0f+ELkC7niIjrqQaR2E/Q2h+T+94WlFwmQ1WFCm98JQGwgNiH/JTIQ9KhrQ
X-Received: by 2002:a17:90b:4b0d:b0:353:3934:1449 with SMTP id 98e67ed59e1d1-35367031e8cmr3216513a91.12.1769185366646;
        Fri, 23 Jan 2026 08:22:46 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3536dc50882sm2496967a91.16.2026.01.23.08.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 08:22:46 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Guillaume Nault <gnault@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 6/7] mpls: Fix load tearing with u64_stats
Date: Sat, 24 Jan 2026 00:21:38 +0800
Message-ID: <20260123162159.2877941-7-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123162159.2877941-1-mmyangfl@gmail.com>
References: <20260123162159.2877941-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,debian.org,fomichev.me,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-252883-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 368477876F
X-Rspamd-Action: no action

On 64bit arches, struct u64_stats_sync is empty and provides no help
against load/store tearing. struct copying should not be considered
tear-free. Use u64_stats_reads() instead.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 net/mpls/af_mpls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index 580aac112dd2..bd2e02b89d09 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -1097,7 +1097,7 @@ static void mpls_get_stats(struct mpls_dev *mdev,
 		p = per_cpu_ptr(mdev->stats, i);
 		do {
 			start = u64_stats_fetch_begin(&p->syncp);
-			local = p->stats;
+			u64_stats_reads(&local, &p->stats, sizeof(local));
 		} while (u64_stats_fetch_retry(&p->syncp, start));
 
 		stats->rx_packets	+= local.rx_packets;
-- 
2.51.0


