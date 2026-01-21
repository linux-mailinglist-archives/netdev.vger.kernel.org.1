Return-Path: <netdev+bounces-251967-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCMxGsAEcWmgbAAAu9opvQ
	(envelope-from <netdev+bounces-251967-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 17:54:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4B65A2E3
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 17:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3E85A7E020C
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150C348C8DB;
	Wed, 21 Jan 2026 15:56:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A22248AE0E
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769010988; cv=none; b=U5GaMbZFcggw1u+zlhGdTYSItWtwdXujQcyz/8FN7NN/s7uD19w7iWknJc21+MbLBJ17qFxWxcGXh7CLDz1YO02QR4/xFq+yt3si8Eb7tqA2gvXnc7sKHSCoYiJ3uk3d66rK0KePora3N2j0HiB2V5H3K+8dR2m9CedAnwfuhFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769010988; c=relaxed/simple;
	bh=IMKgxRU1sol0qv3q4ykIX98inRbeR6UTILUypHJQ1KU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gCVvJJcOqKdlG8B+MhcHwqi1DPAc8M0kNNMkdHf/2+jky9M2nqNGR14iKpA54NsfED0CN2jwUK3M8V0MjISaIsl3snirbCvjRS5EotfXYUKnNqbPy2A90Ky98FlVa+OFVXWgTAbpjsbkux0G0RzqzBKfb3O6LG6eoIT/4Xc7+YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-45c9f47e1e8so14569b6e.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 07:56:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769010985; x=1769615785;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6idYD0AKGESVEMq5nLW+uYD0VvpAsFD+VjX/8Dx4wWo=;
        b=TdVT5/S/lKxJi8Deh+/mExsf+/zWBS1Eb8gzstXUh/lR9HKtbEeUs2yebHvKR2HNDC
         1VgPhWApdMWlJTYpgM4anjr9BvtAy6a5hgj9/MbOnk5OPhVj93Jfxm/1ZvXuVn5oR2qq
         /l+kKJxwtWyIdpTFI5HuVqMvZLv+TMoW6llC3tSGYJfH72qSelYX8rS1HWzQyUXUOhhv
         JcBDm6ne0iAHTJejS6s4qVpoi2M4yIms9aWjQuvfQ8OWXxf+SPPm2iPzv/R8iNr4jm5h
         lN+rI052NRlZ6/I6+OqNNz0ilU6ISePQdulms8gYM/yUQE7P400uMrsSIyNCxKLQtHlc
         8zHg==
X-Gm-Message-State: AOJu0YwiGcmb6BPQruI+VwSlPs2gq91ZNjsjOaxkc5nSCROIfGD7b29T
	WX3T5G97v8NoYFuGXUGUxSw40tzVztdNymeEkPaaTXnkgIyELFSU5/9v
X-Gm-Gg: AZuq6aJaSmi39k5Z8xegiUPhazVMMKaQUfJALUsv7mEqK1q09dpZaiQGjGMkpbEYEg5
	TPBf81UFt5NrI680Ftm+zsfXR/OsK31p3BDTIs0An0MJ5/cUpXETQtXCcKN2KfGtHPY4KHt35Se
	60cIwg/H8DDYE9Qi6+3gWfugu4Jb08RP3bxz7H6513/SJShP76xt15tysVOr6CLoC4BydYBOJAY
	NYlXfJ0Dilo5/MMvLzSIGZq9fG9e1LGm6CVLMQJacnJi9+oPHraKwrJEnIZf7TuvQECnDtAaalA
	cdcXw9Zbt1XFRWKHCradyL3yE3fZyVTrjuzMc3nDYdi6eZKN+qnjsEjQj/6C8//SRY7YjDGuzOX
	nKUZhJCEC7en5rL56Cj9P1q1kBhZlp2bHQ5WHLxtWVJFF00FDsA7UjeVRRL7wJ/JziY/AoC9t6L
	N+fQ==
X-Received: by 2002:a05:6808:1801:b0:453:50af:c463 with SMTP id 5614622812f47-45c9c14fd86mr6820343b6e.41.1769010984991;
        Wed, 21 Jan 2026 07:56:24 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:44::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45c9e03faa4sm8763844b6e.18.2026.01.21.07.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 07:56:24 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 21 Jan 2026 07:54:42 -0800
Subject: [PATCH net-next 5/9] net: fbnic: convert to use .get_rx_ring_count
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-grxring_big_v4-v1-5-07655be56bcf@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1641; i=leitao@debian.org;
 h=from:subject:message-id; bh=IMKgxRU1sol0qv3q4ykIX98inRbeR6UTILUypHJQ1KU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpcPcimRzZNJSf4d1IZxSV2HQSnbvSRZ+5v/wtx
 2BlvP6rC5KJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXD3IgAKCRA1o5Of/Hh3
 bRjCEACgNH/DrBH3/TwdObeQBxDKQ7ri1VmY7UxH12naM375gcloF5oYaCC0Pk01M7Ncq72hwni
 gLDjbTsuQydWPhTRSh+jRQNZqUts5/jMyls9SMBdv7gqyKL5fg68fljW6jg9h/YpPbAF0CuSpvA
 SN7HeNH6i1WOl84JyeUA0QCGOknwIIkHSpBJ46s+d1h/RMLx1zlFhSk1FHeTyOjaBnthP1AWnn1
 hkzCGVgZ6hK4rbqjE0t7K0k+HS1X7oWJ3/KOG/f9vjeEwKO4kpSOszKoSBcDZl3YuggjxKJY6qz
 r6Dvx8Iuj3Svowtx2cmQvBUsEm2MMum8aOBkKo+InxoOs3YFrDrkqjkge0d35p8CF+D+ckWsmyR
 fae5k1dxkVjFpMGsltyMCv5KqSwBd3cOXtVf4EzCmhkADGnjfhVG5GE7XS/c2hN8GMMS2E4hyun
 uN0ZY9ze9aISu4y9s6LStKVnwxkwGOOoVvjIQo+iw9RpKPo2wFtl6DdSg3D/Frk4goh40hhBnS8
 viYUzFM/O6c8LzxKV/6uiM1d0+V7UOZxQj4oDT1/4KvisfOkF8lA4IhibwuRGscXVLr7oe0n811
 yETZIMGNqb/cRZLWJYwq3SNJNcFkD0xnzSG9RdO3eoluiG6lMzQsfYnr3jZQluo1wZHI3ECecXY
 3fRz+TAC8y16fZA==
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
	TAGGED_FROM(0.00)[bounces-251967-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 4D4B65A2E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use the newly introduced .get_rx_ring_count ethtool ops callback instead
of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 61b8005a0db5f..11745a2d8a443 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -825,6 +825,13 @@ static int fbnic_get_cls_rule(struct fbnic_net *fbn, struct ethtool_rxnfc *cmd)
 	return 0;
 }
 
+static u32 fbnic_get_rx_ring_count(struct net_device *netdev)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+
+	return fbn->num_rx_queues;
+}
+
 static int fbnic_get_rxnfc(struct net_device *netdev,
 			   struct ethtool_rxnfc *cmd, u32 *rule_locs)
 {
@@ -833,10 +840,6 @@ static int fbnic_get_rxnfc(struct net_device *netdev,
 	u32 special = 0;
 
 	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = fbn->num_rx_queues;
-		ret = 0;
-		break;
 	case ETHTOOL_GRXCLSRULE:
 		ret = fbnic_get_cls_rule(fbn, cmd);
 		break;
@@ -1895,6 +1898,7 @@ static const struct ethtool_ops fbnic_ethtool_ops = {
 	.get_sset_count			= fbnic_get_sset_count,
 	.get_rxnfc			= fbnic_get_rxnfc,
 	.set_rxnfc			= fbnic_set_rxnfc,
+	.get_rx_ring_count		= fbnic_get_rx_ring_count,
 	.get_rxfh_key_size		= fbnic_get_rxfh_key_size,
 	.get_rxfh_indir_size		= fbnic_get_rxfh_indir_size,
 	.get_rxfh			= fbnic_get_rxfh,

-- 
2.47.3


