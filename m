Return-Path: <netdev+bounces-251971-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Ns0G1IMcWmPcQAAu9opvQ
	(envelope-from <netdev+bounces-251971-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 18:26:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BC55A81D
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 18:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DCDE7EE58A
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CCF40FD97;
	Wed, 21 Jan 2026 15:56:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B29492506
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769010993; cv=none; b=c3oL4mtG5GFCQ3O9yp1+IRR8x4SKsybMVHDtza0Uh3/ARBVNTdmBgx+ks1U81ksy9gHXV6D2/jkj32XQRFLmSUNmpd/tCAiUpfufqat4CNbCSZnpqWRHj/Vju6vWwUdQ66Pa4/BtOYqSuT8wXizqvfEyAUxkF8Sfa5w0g27wvy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769010993; c=relaxed/simple;
	bh=kqzS/7eXjKQG4xiemTDsmFZRs2ALv2BsjFw/ViIR5ug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C7sSGQzzM1VtKlt5HVr/FES5q8d+jllAIqBvqkOM9j/TleaFN4bdrYgadKE+pG9K2UFnDOWC7fejd5hQEoDef4i9Bcy8JUJVriiQen41B/KRmaJEQtvjSXp4t5uvnUOKEbZ6JaWEuVn4z38JduIawGmzNtQE4bRWjKzmxEYpMcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-45c83c49213so10726b6e.3
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 07:56:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769010989; x=1769615789;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BvlsW4lqNl+1+09mnU3bYFr4itCF0ttr+C2yEDPsR5w=;
        b=LJV3j9Jj6zcXehA/c09XQF008MZRpCXcOq3hYsiht1CR4xnZUhqavxqzPjWQycVSNV
         wx/dzWIQ+s4qgccTfe5DRQFSc3cEE9odSbv8v6oMx5eYxXnB4vz2vxno79wsZOQsSASC
         GD62oAXSKQHo1fHZuh+cNE2h+ozK9QrDS6prEjHfyPcYNA6piBSB+/NCJw3BHWs/fWdd
         NOGvRx5fNGHAwTBEgBbKP9XWOBCEDheQvYdqHRPniWsyh0dn451j3hS3d2khJPvnefvh
         zti3YJwqr0Wwm2Gh1bcAjLi42WhDuwVhIAYTQDDrXbuOTz75gUXrtDnjx+pwknsf/EdQ
         bf/Q==
X-Gm-Message-State: AOJu0YzPqMWBjBHRgkZZU6GlfORjTN5dcF8xKcf/njX2yZkwUXILrpa9
	ZxrmD85qU69x/ixxfu+hQ8jOpcOfqT3h3HDXNIda1POKBhV7TtVs5Imf
X-Gm-Gg: AZuq6aITYqB9SghnvXlhwWpfg5+6pxiQi7EVJcrwKIORMnDWZxiEghlGjR4UoAaeYA6
	wThcBx8SfVs4s7ih3ciYOtFFneJJZ2TAV/vX6NoqQvpZhraCAEEn97rL5IHcCzFLJrIInOmtusm
	xnKYFzmdOADfgDGozIl5OHNzYSVunjWqtYHxbImpv2TkFXsgUpIYIzmm/gzOzpPPQJEvNN679lb
	77T1L9Sv1nc8qRyW80t4IwxX49DzT8DCLSNc08t5ZN5KJJ9bNhaUac2NFr4+NKu8cHDTEc8VID9
	V4l2OAy6qTHs2Y9sxH2zt/4Sq5IdsrfJ3I/RBVD046DXL3bELWc/C3nRQqyoeRBKResbY17/tx1
	4i5dTaW0oqnKudTnGDWEhAqEPXTfhdtTsjfYYqLaAcwgP4FwXUAieHI/y5LGYeQ9FFFlmYybVKT
	Jg
X-Received: by 2002:a05:6808:1207:b0:450:f17d:860e with SMTP id 5614622812f47-45c9c146db5mr7453499b6e.47.1769010989362;
        Wed, 21 Jan 2026 07:56:29 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:9::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45c9dec6619sm8684288b6e.3.2026.01.21.07.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 07:56:28 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 21 Jan 2026 07:54:46 -0800
Subject: [PATCH net-next 9/9] net: sfc: falcon: convert to use
 .get_rx_ring_count
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-grxring_big_v4-v1-9-07655be56bcf@debian.org>
References: <20260121-grxring_big_v4-v1-0-07655be56bcf@debian.org>
In-Reply-To: <20260121-grxring_big_v4-v1-0-07655be56bcf@debian.org>
To: Ajit Khaparde <ajit.khaparde@broadcom.com>, 
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, 
 Somnath Kotur <somnath.kotur@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Igor Russkikh <irusskikh@marvell.com>, Simon Horman <horms@kernel.org>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
 Edward Cree <ecree.xilinx@gmail.com>, Brett Creeley <brett.creeley@amd.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 oss-drivers@corigine.com, linux-hyperv@vger.kernel.org, 
 linux-net-drivers@amd.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636; i=leitao@debian.org;
 h=from:subject:message-id; bh=kqzS/7eXjKQG4xiemTDsmFZRs2ALv2BsjFw/ViIR5ug=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpcPci73BBafszurpkpislh2ZdfEde9KM1z3BTH
 bEi/YHQ4KqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXD3IgAKCRA1o5Of/Hh3
 bW8xD/9h5DYoUj0BnDZx0DxqyEswo0Yz24BdyMadcONl2aU6A/5L0TN0u8VNDwSsWgG+fnZxzfR
 0kHcfXVG8VstKhv6WBMC4KO1magMR4Lx3JYC22oDObaXt2v5Y0T7QAFhVc5PKptaqbhRPvlEcZN
 1unciuhewFPcqJbCk6kpIvhbnNIY1YQA+YL3S5AVwJLGQFEl648DGshte1NMUainY1FRJzIOXZJ
 4GrJrJkkpb9DrbLw5/tOn/HudzHV5/eCLJJj4M7K+AqBwreaMY1wzbe3mO0amtQgxgkEFEKIgty
 0InW+tYXBOA/7shGFBMmhLckz6+yyDQz4tX5Z6F6EisOINVh+IghhbpQY9+5krZdeEmjm0ksSf8
 smqvc/Qh/olyNs/+9DSROujp3XnNIyKb1mU37/30xZ3U7at0PE0hyenclY51b2lnpKU+YSR+eZB
 bT8VP4nh7dJjCb8vSM21cU0LGpf1s8nkWKllnCNL34XZXQ0moTharhlQpikpXe+R6URX5SEgh2o
 8NpNLahAV7Az19qYncrEyF56TzKpBQNX3WfsPoM99oCxmkNP49P7Qs5qZI0dB8mwx1kmqtMWALQ
 fBl93SueB5K5ODRvXlBT/rrqhdsnXPaQ+1y6DKBTLMeK89Kb0y/0QFD7LrTz9A1HY4wHRz2RILz
 CB90w3nUtgxXUwQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Spamd-Result: default: False [0.24 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,marvell.com,microsoft.com,fb.com,meta.com,gmail.com,amd.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251971-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: D0BC55A81D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use the newly introduced .get_rx_ring_count ethtool ops callback instead
of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/sfc/falcon/ethtool.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/sfc/falcon/ethtool.c b/drivers/net/ethernet/sfc/falcon/ethtool.c
index 27d1cd6f24ca1..0493640315454 100644
--- a/drivers/net/ethernet/sfc/falcon/ethtool.c
+++ b/drivers/net/ethernet/sfc/falcon/ethtool.c
@@ -974,6 +974,13 @@ ef4_ethtool_get_rxfh_fields(struct net_device *net_dev,
 	return 0;
 }
 
+static u32 ef4_ethtool_get_rx_ring_count(struct net_device *net_dev)
+{
+	struct ef4_nic *efx = netdev_priv(net_dev);
+
+	return efx->n_rx_channels;
+}
+
 static int
 ef4_ethtool_get_rxnfc(struct net_device *net_dev,
 		      struct ethtool_rxnfc *info, u32 *rule_locs)
@@ -981,10 +988,6 @@ ef4_ethtool_get_rxnfc(struct net_device *net_dev,
 	struct ef4_nic *efx = netdev_priv(net_dev);
 
 	switch (info->cmd) {
-	case ETHTOOL_GRXRINGS:
-		info->data = efx->n_rx_channels;
-		return 0;
-
 	case ETHTOOL_GRXCLSRLCNT:
 		info->data = ef4_filter_get_rx_id_limit(efx);
 		if (info->data == 0)
@@ -1348,6 +1351,7 @@ const struct ethtool_ops ef4_ethtool_ops = {
 	.reset			= ef4_ethtool_reset,
 	.get_rxnfc		= ef4_ethtool_get_rxnfc,
 	.set_rxnfc		= ef4_ethtool_set_rxnfc,
+	.get_rx_ring_count	= ef4_ethtool_get_rx_ring_count,
 	.get_rxfh_indir_size	= ef4_ethtool_get_rxfh_indir_size,
 	.get_rxfh		= ef4_ethtool_get_rxfh,
 	.set_rxfh		= ef4_ethtool_set_rxfh,

-- 
2.47.3


