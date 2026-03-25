Return-Path: <netdev+bounces-271433-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FWVCn6Nw2lVrgQAu9opvQ
	(envelope-from <netdev+bounces-271433-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:23:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4C9320A5F
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 209FB305B243
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955CB368291;
	Wed, 25 Mar 2026 07:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Z5yC4AL4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0EC36492E;
	Wed, 25 Mar 2026 07:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774423363; cv=none; b=vF9UjZ2i801Yhkh8gz3jQAJmfscgvGzbMVKhG9xOSTRGX+M/hrfSRAwngxGsORa8p0HAti6UWt5GE4YIe8oqSaT+p0/K1paYgLUHdjEdRPronRJK0iS29bwEGAFIocmofNBxvo1eik3NpXZv0g0eD4/TxpkOW9HY+h+E99Mwp2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774423363; c=relaxed/simple;
	bh=bku4H/UZEGyHFNNbB/622394p04bXiZq69x3ssX7pBE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LmWSsO3X+LH0PGQsieROPmmuFGQC1WH1AX8/D5IHIXK98qEflnPKjXJ5W3fKwnkGs+7Grxeb/CNCnmQOYMaXts19AodYuS6+xYX6gckZQFPEpJRaVThZh0u2Hcb8vxwhH3ZYac6TQA5NQ8XoWHk+JKDc0Ig/xo3UJAjmmbzZyS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Z5yC4AL4; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P3GecW462175;
	Wed, 25 Mar 2026 00:22:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=z
	L9edTtQ+I8yjFW5xTW3OLUVfsJ015crBPbFIlBj9qU=; b=Z5yC4AL4rg7QlJL+n
	DUI3DR3OhsNIefXN7q1tPPMapXQyQ4BhOhn4Cow9T7fCqyjKaGI1W54OT2pYdFzU
	wOELNPgRQCoaP4Ixia7kaULRe4i3aMA+GCxYDRzuLW0KHH2AQd826gqhfBaTXsJW
	GIBw5R8yjCnbBUyOicJBH7Fz6yEH467UxdTsAcL2bBokSZM+pH0836yxKI1DRGSq
	uceFrlBsxKbz1N+4tUP+wMExW4DRkTdwjME81YnYRTCe5SCsjEG9n3xzlfdNqg6T
	zfj7GWAcmn636QBvu7YSMBKjsUbas8zU+nyZittA2N8H/xgt1DCiDfKnGDmmxhJL
	w8zFQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4d47na8e53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 00:22:24 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Mar 2026 00:22:23 -0700
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Mar 2026 00:22:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 25 Mar 2026 00:22:21 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 3458C3F7076;
	Wed, 25 Mar 2026 00:22:15 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <donald.hunter@gmail.com>, <jiri@resnulli.us>,
        <chuck.lever@oracle.com>, <matttbe@kernel.org>, <cjubran@nvidia.com>,
        <shshitrit@nvidia.com>, <dtatulea@nvidia.com>, <tariqt@nvidia.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH v8 net-next 2/6] net/mlx5e: heap-allocate devlink param values
Date: Wed, 25 Mar 2026 12:51:55 +0530
Message-ID: <20260325072159.1126964-3-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325072159.1126964-1-rkannoth@marvell.com>
References: <20260325072159.1126964-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA1MSBTYWx0ZWRfXza69Geo/qdWl
 pVoPyzq+nnoJPKFq92E6nyk+wbtrALA6jUck+8LjJjZvZ/FkGsCQMW1Iz/F+1I0UXHFIdx+CV71
 74fl00HOMvNVqvk78B7Wd6ON4kW0NE2A9Ew6TMr5y7S68vg0BTplxLt4p56quatdCM1PF53CGjf
 V8nu3adQwh105d4WmYZ+rq0UOUU50yJFjcdUmQmwu0hC9b+J7SEUh9VEYsnEqcNpE0L6BUaHKfC
 2UrKmwNb6LigHftufiK8ATrcKKjx5AxbOW9FUNOsEwkO1x9F3OHxDRsXbk7sLTYWNfkWJiL7884
 FkWW8EsLXSQcA4PrTPPNnhmXb2OPTPajaYRCUTW2n1apAGDBIXtYwoqM4+gscIC0PZNYIC0HcHA
 YhXdUoWxtQP3eqisBENRn30eWju+KAhh/xJH7rMz2BZ3gNiBZ9Wh/pCJvR1OW3IpxT7wzsYdC0V
 q4X6RKScHItZzpjeUvg==
X-Authority-Analysis: v=2.4 cv=LsifC3dc c=1 sm=1 tr=0 ts=69c38d30 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=aWKQy79EXxaKdZR1qOkA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: ejK-3yewcQDE9ushqwDSVMX7V3kT_cUO
X-Proofpoint-GUID: ejK-3yewcQDE9ushqwDSVMX7V3kT_cUO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_02,2026-03-24_01,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,resnulli.us,oracle.com,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271433-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,marvell.com:email,marvell.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: DE4C9320A5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

union devlink_param_value grows when U64 array params
are added to devlink. Keeping a four-element array of that
union on the stack in mlx5e_pcie_cong_get_thresh_config()
then trips -Wframe-larger-than=1280. Allocate the temporary
values with kcalloc() and free them on success and
error paths.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/mellanox/mlx5/core/en/pcie_cong_event.c  | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c b/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
index 2eb666a46f39..f02995552129 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
@@ -259,15 +259,21 @@ mlx5e_pcie_cong_get_thresh_config(struct mlx5_core_dev *dev,
 		MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_HIGH,
 	};
 	struct devlink *devlink = priv_to_devlink(dev);
-	union devlink_param_value val[4];
+	union devlink_param_value *val;
+
+	val = kcalloc(4, sizeof(*val), GFP_KERNEL);
+	if (!val)
+		return -ENOMEM;
 
 	for (int i = 0; i < 4; i++) {
 		u32 id = ids[i];
 		int err;
 
 		err = devl_param_driverinit_value_get(devlink, id, &val[i]);
-		if (err)
+		if (err) {
+			kfree(val);
 			return err;
+		}
 	}
 
 	config->inbound_low = val[0].vu16;
@@ -275,6 +281,7 @@ mlx5e_pcie_cong_get_thresh_config(struct mlx5_core_dev *dev,
 	config->outbound_low = val[2].vu16;
 	config->outbound_high = val[3].vu16;
 
+	kfree(val);
 	return 0;
 }
 
-- 
2.43.0


