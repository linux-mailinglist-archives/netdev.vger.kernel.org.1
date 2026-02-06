Return-Path: <netdev+bounces-257536-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGljKVPYhWlZHQQAu9opvQ
	(envelope-from <netdev+bounces-257536-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 13:02:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 59613FD707
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 13:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 028F2300C31A
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 12:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F7833A70A;
	Fri,  6 Feb 2026 12:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hBKMgL8I"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44C133BBD0
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 12:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770379331; cv=none; b=qgnxZzHlLtj1WyI0QS5iAqMXW/cz4h1fE43skqUfig+18COGRmLyunS+2C7b/VpTBg8EqVjmbVpVsZJVha5JUvL95bG/HJ2jBqlyuTRJ3zJhk30CGxrRVGJNTJUlBF2OLHDoJxKALER84m6QgqOJzoySDBDam3PEXoDxWc3Hyno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770379331; c=relaxed/simple;
	bh=IYtJMDqUiKnsEBDJ8M5kMclbY0Y2FOYSESeqDQlbF1s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CbL8It2VkGmeoAdYwwMJTBBSDbT7L41sMqUSFM9DigYf4ZnCVGSZwYhiQ76QtagcUclGy2YlPHyVkMUxR5yU96ZAIf3SK9351CHvIj0a1ZluYYgck+hSn3SeP39Xo2TXN5h0LZ6xps/b48ixr7qyympZGdYI0sBaz1J7P1++/aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hBKMgL8I; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6167CIiX076786;
	Fri, 6 Feb 2026 04:02:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=jDdCrxCAhZuZ5+wCbc5NvTu
	QGplGyWzcfpGOrWR+FHY=; b=hBKMgL8IjXAua/kKRe4WrefwkxR4wHuevV/IohY
	IKxgbPV3KE+aaE8tuUIajTYDoDTFfthXBWdlVvqXar5pdHikKjaNC5eRb54Bnyt1
	XV3sEQGnX9MZmhJS6klpsP5JaDQtsUVdgmsCmOh5AHBQRpo3X13YAPZrIGRybBVe
	WuK7FDclEf46hYpkfrMh+QlFSXJdhK3v0+oLAmX3zZ7/dxNX9NSt0mYx1JgYoYRx
	O+a8oQGmuTIWS10r4Uj//JKu8Zh9UUJvT0yBNWJjVyb0wIUwGG6opeqYY0zBU+ys
	V4TolF6SG/2nYu9wOBefRHhJEXo2KS8UEV2PVmyHfA6bE8A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4c45e4xeef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 04:02:00 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 6 Feb 2026 04:02:15 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 6 Feb 2026 04:02:15 -0800
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id 557AF3F70BC;
	Fri,  6 Feb 2026 04:01:55 -0800 (PST)
From: Srujana Challa <schalla@marvell.com>
To: <netdev@vger.kernel.org>, <virtualization@lists.linux.dev>
CC: <pabeni@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
        <xuanzhuo@linux.alibaba.com>, <eperezma@redhat.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <ndabilpuram@marvell.com>, <kshankar@marvell.com>,
        <schalla@marvell.com>
Subject: [PATCH v2 net-next] virtio_net: Improve RSS key size validation and use NETDEV_RSS_KEY_LEN
Date: Fri, 6 Feb 2026 17:31:54 +0530
Message-ID: <20260206120154.2548079-1-schalla@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 6dFSgxZ3jv3CsnhwYrkBzr9owLp7o0iQ
X-Proofpoint-ORIG-GUID: 6dFSgxZ3jv3CsnhwYrkBzr9owLp7o0iQ
X-Authority-Analysis: v=2.4 cv=COonnBrD c=1 sm=1 tr=0 ts=6985d838 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=M5GUcnROAAAA:8 a=WvS6aQ_piSL3sVsHHQ4A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDA4NCBTYWx0ZWRfX4E5uYXF2x6rX
 TfueIhFXZDmweX4qLwDOab5l+WC+UpM4Z7oCtjEr6Qg4vUY6ZQ0y5/ivIvChptC3AWP2M5Un2q3
 EfsoYTXXyDjmKwkYivKCO5D0Q6zegm6Eem0mtX6B9+vatqdfTytCp3WFrLlN9wUxmyu4wcZTmX4
 T1LTFAtMZYFExPnx2tgcvp10fmRyJue+S53t35K9/bZllzAwHgx+j+k9SiL+ZQptM9wn2vtyAlQ
 cMStFipzn0xcwP/KKEHatNI9ael/heMaNZbMq9hjk+ItpgTt6j40sp53Ahf/r/B7Vs5hxntT5uN
 oiwG3mFhYAjXAJn47LwdChjRnwu+vyJ/X82gE0SUU3G2ogZloYuD3XfabYrUTRzHZHw5rbo2ik/
 /dR8EY0e0aKGejK7pqvaTpWI2IcE0u/LRM9gVnqWhkD36L/xws0Y4luHXMtPc+0x42Ms0VmYpWu
 tSqIg/z+WvaG1Kasvhw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_03,2026-02-05_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257536-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schalla@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:dkim,marvell.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[marvell.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 59613FD707
X-Rspamd-Action: no action

Replace hardcoded RSS max key size limit with NETDEV_RSS_KEY_LEN to
align with kernel's standard RSS key length. Add validation for RSS
key size against spec minimum (40 bytes) and driver maximum. When
validation fails, gracefully disable RSS features and continue
initialization rather than failing completely.

Signed-off-by: Srujana Challa <schalla@marvell.com>
---
 drivers/net/virtio_net.c | 62 +++++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index db88dcaefb20..1fa4197dffc3 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -381,7 +381,8 @@ struct receive_queue {
 	struct xdp_buff **xsk_buffs;
 };
 
-#define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
+#define VIRTIO_NET_RSS_MAX_KEY_SIZE     NETDEV_RSS_KEY_LEN
+#define VIRTIO_NET_RSS_MIN_KEY_SIZE     40
 
 /* Control VQ buffers: protected by the rtnl lock */
 struct control_buf {
@@ -6823,38 +6824,47 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT))
 		vi->has_rss_hash_report = true;
 
-	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS)) {
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS))
 		vi->has_rss = true;
 
-		vi->rss_indir_table_size =
-			virtio_cread16(vdev, offsetof(struct virtio_net_config,
-				rss_max_indirection_table_length));
-	}
-	vi->rss_hdr = devm_kzalloc(&vdev->dev, virtnet_rss_hdr_size(vi), GFP_KERNEL);
-	if (!vi->rss_hdr) {
-		err = -ENOMEM;
-		goto free;
-	}
-
 	if (vi->has_rss || vi->has_rss_hash_report) {
 		vi->rss_key_size =
 			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
-		if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
-			dev_err(&vdev->dev, "rss_max_key_size=%u exceeds the limit %u.\n",
-				vi->rss_key_size, VIRTIO_NET_RSS_MAX_KEY_SIZE);
-			err = -EINVAL;
-			goto free;
-		}
 
-		vi->rss_hash_types_supported =
-		    virtio_cread32(vdev, offsetof(struct virtio_net_config, supported_hash_types));
-		vi->rss_hash_types_supported &=
-				~(VIRTIO_NET_RSS_HASH_TYPE_IP_EX |
-				  VIRTIO_NET_RSS_HASH_TYPE_TCP_EX |
-				  VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
+		/* Spec requires at least 40 bytes */
+		if (vi->rss_key_size < VIRTIO_NET_RSS_MIN_KEY_SIZE) {
+			dev_warn(&vdev->dev,
+				 "rss_max_key_size=%u is less than spec minimum %u, disabling RSS\n",
+				 vi->rss_key_size, VIRTIO_NET_RSS_MIN_KEY_SIZE);
+			vi->has_rss = false;
+			vi->has_rss_hash_report = false;
+		} else if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
+			dev_warn(&vdev->dev,
+				 "rss_max_key_size=%u exceeds driver limit %u, disabling RSS\n",
+				 vi->rss_key_size, VIRTIO_NET_RSS_MAX_KEY_SIZE);
+			vi->has_rss = false;
+			vi->has_rss_hash_report = false;
+		} else {
+			vi->rss_indir_table_size =
+				virtio_cread16(vdev, offsetof(struct virtio_net_config,
+							      rss_max_indirection_table_length));
+			vi->rss_hash_types_supported =
+			    virtio_cread32(vdev, offsetof(struct virtio_net_config,
+							  supported_hash_types));
+			vi->rss_hash_types_supported &=
+					~(VIRTIO_NET_RSS_HASH_TYPE_IP_EX |
+					  VIRTIO_NET_RSS_HASH_TYPE_TCP_EX |
+					  VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
+
+			dev->hw_features |= NETIF_F_RXHASH;
+			dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
+		}
+	}
 
-		dev->hw_features |= NETIF_F_RXHASH;
-		dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
+	vi->rss_hdr = devm_kzalloc(&vdev->dev, virtnet_rss_hdr_size(vi), GFP_KERNEL);
+	if (!vi->rss_hdr) {
+		err = -ENOMEM;
+		goto free;
 	}
 
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) ||
-- 
2.25.1


