Return-Path: <netdev+bounces-251964-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JPhI9MbcWmodQAAu9opvQ
	(envelope-from <netdev+bounces-251964-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 19:32:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E095B4F9
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 19:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 323787CDF02
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62DF48A2A6;
	Wed, 21 Jan 2026 15:56:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB62A399A41
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769010985; cv=none; b=YG96LUB35QlIOXX1s0FA3TYy7fkPScutViiFG5kuJq0kfU64sqfQb/ImcSu/Cx2u80DMJMdBZSFZEmWpWSxDGr/+axjt9LHFC/dzFy3RESPJQ0phOdPFgep+QnnOOrl32AMl89K4ph60bVHuNFM9UFOa3beo7ukK0RBEdlxrApM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769010985; c=relaxed/simple;
	bh=GFft51yuC4WzV3G/D8GfSip18W6gE1bf2WP0ZpHcZxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OToa1ip+FfNxjt2xgloF8zgZMGj46i7L6Jqx0LzCX998wwyG4B35KPRlb2We50JCBBicDXeP3EflearXjxu9OYxr9mfQu57EZxhTh0MFXiWNcjz40hcA8JdSmo5EIu7iIvtxxHTJ8ayS3Asbdw1ewTQjUhQjnt4Uyx3l4vNRhII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4041b3c1fa1so6196fac.3
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 07:56:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769010982; x=1769615782;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=78P/UAV1LWhbyJcJa9mSCIGPHxQe4k7cpmkiJ4BHBmg=;
        b=oQJyZnAyMVmpuvntoNtYsT9MhnXLDPSvLunSyycGEavZJu2HcknPDnKQ2ttWfFVR8d
         6WS12G+0vJlyoRYmpBxOpA9OyUodmzRjencDOqnUGc5h8W1TS5OzTx4r+6kCie5V1GLJ
         5R48cgDtmcm8T3yug15yLsT8NrdYhABn0EVZfqgCo00hxnPLhvZFsVH3fQ8fcsPBdlJw
         EP6OPGOCA9eSsaEzp988unS6Qdfab79fmTQnQ/7I9z3AXgkbABGM/LROkWyeMxu8QGXl
         VAvobPa3/qUHTgUjxiuUaXz+Bz5dJ4h6DuoMtoop3f6baZsszeo3K+6CtcYRyuRd60+z
         puqg==
X-Gm-Message-State: AOJu0YyQ61mHuEU3klrT0KQ5r5cl6Y09hadWSwg/JR4iHPE6LoqgX2lt
	80HMeKG+jk9UkgVEQOWRjtn+wgnC7lDTNwJnPxsVerc9nqr6drFj+Vem
X-Gm-Gg: AZuq6aIRv6NcYVahUkoGYG680EhdAJuyXtZcc7xPgayJPJqH4EkYMLrP8PH9yvG8tUS
	iCLg0UFw1vYqBh4CSEm0vYee6kcRl6ehnmU0bupKlneNwNmMMydDoDNDuYxB4nIhaobikf6lxVT
	FC0vb8VfewdjGeRIUQtz8aVJMKW54a88AeqxRfkxIHEeLP3mTLE+G0czgWPVTMfC7zQ4qiqHVZm
	dd6riu1fZOMY/jmMxqGx2DoaneaTHAq5mynS+l9Pz7W6eRq32mnTWxqRUdto9xVm2OaYTRffFrn
	GVCZmel4UO/Fxwz36wF16koAsiypj3/wfWZOfDmraWv38FOwfU8KPBZKLT6XuykVAMXxZRiFYIX
	qOt4Jdj51DnRYyopq9d1IW18cHEd6KNJfSgk/VBaFzR3SHX+e7dPqEUcm5vs8X+PvecHWrZy4G/
	nMZg==
X-Received: by 2002:a05:6870:45a1:b0:3e7:e70f:fd64 with SMTP id 586e51a60fabf-4044cdf9cfemr9891329fac.14.1769010981636;
        Wed, 21 Jan 2026 07:56:21 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:44::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4044bb528d5sm11496023fac.8.2026.01.21.07.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 07:56:21 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 21 Jan 2026 07:54:39 -0800
Subject: [PATCH net-next 2/9] net: atlantic: convert to use
 .get_rx_ring_count
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-grxring_big_v4-v1-2-07655be56bcf@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1756; i=leitao@debian.org;
 h=from:subject:message-id; bh=GFft51yuC4WzV3G/D8GfSip18W6gE1bf2WP0ZpHcZxI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpcPchwxi8H8OguEoWaW+kmoGlddgm3A5pgpqon
 /JUdTObJxmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXD3IQAKCRA1o5Of/Hh3
 bf7pD/41NmC5S3hL+B74vF2Opj+sDa22FIvCQbBe++dUZjtwVsisqSgWxLJ/B2rMO/CA8696S9K
 hx0+mQcLxTHhKYMrqk7KNVkSawjR6lSELsYYLraBScPWN5K+tN3sUYx897DHykjwYSLSI5BaEcS
 rDHG665uApAOYLxbJTcMjt3Ek4WqdiY5ULBKjYfc8tGTsPI4flTPH5Y9Z7PZTsZd9zHznCLptC9
 Q/QZqzBPox9DM4bpgRytV48W/k6MMJXsNE+XbjT7YX6fRn/7vcQK1sgvkKApwC+wzPdTsabII9q
 5t20R2VoaCRSgS3uJRLUqZ4Pu3qYVKxN38jDadJM72RyuL9jzK5HljpGRC7mYk28qeFXIz7KJ31
 YLhm23Dg+nC2ldGSviunTAEaor+YdHx3fgA7oHjmoBuI9Lq6NmPJvUYh3x1izX9vl/PwHQd4ty1
 VbHjE0SmHFoc4ZK8DhMLrKYy3QRUMpoSGc23y93sX2zLs1jEZZx8RfmU9DTZ6hYwSHYoFU6XGgD
 6fw0gqIWkRIQhRmX8zCXb0oDoF3Z+2tuoDdPfGCyypYAGH5GKy+kiV080XJttGzDp6DR+yhtma7
 9Vi8QZaS2b69SuOgveMIT3Z3babc6VSU09iQk/GHNky6QAqFUVKFbIJ8Zht8P+VDtSPhtn9uO2l
 7ESqVrCXTu3ldWA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Spamd-Result: default: False [0.24 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[debian.org];
	TAGGED_FROM(0.00)[bounces-251964-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,marvell.com,microsoft.com,fb.com,meta.com,gmail.com,amd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 37E095B4F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use the newly introduced .get_rx_ring_count ethtool ops callback instead
of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
index 6fef47ba0a59b..d8b5491c9cb2b 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
@@ -500,20 +500,22 @@ static int aq_ethtool_set_rss(struct net_device *netdev,
 	return err;
 }
 
+static u32 aq_ethtool_get_rx_ring_count(struct net_device *ndev)
+{
+	struct aq_nic_s *aq_nic = netdev_priv(ndev);
+	struct aq_nic_cfg_s *cfg = aq_nic_get_cfg(aq_nic);
+
+	return cfg->vecs;
+}
+
 static int aq_ethtool_get_rxnfc(struct net_device *ndev,
 				struct ethtool_rxnfc *cmd,
 				u32 *rule_locs)
 {
 	struct aq_nic_s *aq_nic = netdev_priv(ndev);
-	struct aq_nic_cfg_s *cfg;
 	int err = 0;
 
-	cfg = aq_nic_get_cfg(aq_nic);
-
 	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = cfg->vecs;
-		break;
 	case ETHTOOL_GRXCLSRLCNT:
 		cmd->rule_cnt = aq_get_rxnfc_count_all_rules(aq_nic);
 		break;
@@ -1072,6 +1074,7 @@ const struct ethtool_ops aq_ethtool_ops = {
 	.set_rxfh            = aq_ethtool_set_rss,
 	.get_rxnfc           = aq_ethtool_get_rxnfc,
 	.set_rxnfc           = aq_ethtool_set_rxnfc,
+	.get_rx_ring_count   = aq_ethtool_get_rx_ring_count,
 	.get_msglevel        = aq_get_msg_level,
 	.set_msglevel        = aq_set_msg_level,
 	.get_sset_count      = aq_ethtool_get_sset_count,

-- 
2.47.3


